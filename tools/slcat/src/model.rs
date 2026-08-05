//! โครงข้อมูลของแคตตาล็อก
//!
//! เหตุผลที่ย้ายมาเป็น Rust: `audit.sh` ยิง `yq` 25 ครั้ง แต่ละครั้ง spawn process
//! แล้ว parse ไฟล์ 1,600 บรรทัดใหม่ทั้งไฟล์ และ expression แต่ละอันเป็น string
//! ที่ไม่มีใครตรวจให้ — ตอนเขียน audit.sh ผมเขียน `select(has(\"note\") | not)`
//! ผิด escape ไปหนึ่งจุด มันคืน 0 เงียบๆ แทนที่จะเป็น 73 แล้วรายงานว่า "ทุก entry
//! มี note ครบ" ทั้งที่ 41% ไม่มี **ตัวตรวจที่ตอบผิดเงียบๆ แย่กว่าไม่มีตัวตรวจ**
//! เพราะมันทำให้เลิกสงสัย ที่นี่ field ผิดชื่อ = compile ไม่ผ่าน
//!
//! สิ่งที่ตั้งใจ **ไม่** ทำ: เขียนไฟล์กลับด้วย serde
//! `yq -i` เคยลบบรรทัดว่างระหว่าง entry ทิ้งหมด (1599 → 1427) และ serde_yaml
//! ก็จะทำแบบเดียวกัน — comment กับการจัดวางในไฟล์นี้เป็นของที่คนอ่าน การเขียนกลับ
//! ต้องทำแบบต่อท้าย/แก้ทีละบรรทัดเหมือนที่ script ทำอยู่ ดูกับดักใน CLAUDE.md

// ฟิลด์บางตัวยังไม่มีคำสั่งไหนอ่าน แต่ต้องอยู่ใน struct เพราะการ parse มันสำเร็จ
// คือส่วนหนึ่งของการตรวจ — ถ้า `added` ในไฟล์เป็นรูปแบบที่ deserialize ไม่ได้
// เราอยากให้ audit ล้มตรงนั้น ไม่ใช่ข้ามไปเงียบๆ
#![allow(dead_code)]

use serde::Deserialize;
use std::collections::BTreeMap;

/// `data/resources.yml`
#[derive(Debug, Deserialize)]
pub struct Catalog {
    /// key → ป้ายที่แสดงใน CATALOG.md
    pub categories: BTreeMap<String, String>,
    pub resources: Vec<Resource>,
}

#[derive(Debug, Deserialize)]
pub struct Resource {
    pub url: String,
    pub name: String,
    pub category: String,
    pub source: String,

    #[serde(default)]
    pub tags: Vec<String>,
    /// ทำไมถึงเก็บ / ใช้ตอนไหน — ไม่บังคับในโครงสร้าง แต่ `audit` มีเพดานล่างให้
    #[serde(default)]
    pub note: Option<String>,
    /// ลิงก์ยังเปิดได้ไหม — เครื่องเป็นเจ้าของ (`linkcheck.sh` เขียน)
    #[serde(default)]
    pub status: Option<String>,
    #[serde(default)]
    pub added: Option<String>,

    /// ยังควรใช้ไหม — คนเป็นเจ้าของ เครื่องห้ามเขียนทับ
    /// แยกจาก `status` เพราะสองเรื่องนี้ตั้งฉากกัน: tutorial Anchor 0.29 คือ
    /// `status: ok` (ได้ HTTP 200) และ deprecated พร้อมกัน
    #[serde(default)]
    pub deprecated: Option<String>,
    #[serde(default)]
    pub superseded_by: Option<String>,
}

/// `data/rejected.yml` — ทะเบียน "ดูแล้วไม่เอา"
#[derive(Debug, Deserialize)]
pub struct RejectedFile {
    #[serde(default)]
    pub rejected: Vec<Rejected>,
}

#[derive(Debug, Deserialize)]
pub struct Rejected {
    pub url: String,
    #[serde(default)]
    pub reason: Option<String>,
    #[serde(default)]
    pub checked: Option<String>,
    #[serde(default)]
    pub superseded_by: Option<String>,
}

pub const SOURCES: &[&str] = &["foundation", "anza", "community", "vendor", "thailand"];

/// ตัด scheme / www. / query / fragment / trailing slash แล้ว lowercase
///
/// ต้องให้ผลตรงกับ `norm()` ใน `scripts/lib.sh` เป๊ะ ไม่งั้นสองฝั่งจะเห็น
/// "ซ้ำ" คนละชุดกัน — มีเทสต์ผูกไว้ด้านล่าง
pub fn norm(url: &str) -> String {
    let s = url.split_once("://").map_or(url, |(_, rest)| rest);
    let s = s.strip_prefix("www.").unwrap_or(s);
    let s = s.split(['?', '#']).next().unwrap_or(s);
    s.trim_end_matches('/').to_lowercase()
}

impl Catalog {
    pub fn load(path: &std::path::Path) -> Result<Self, String> {
        let text = std::fs::read_to_string(path).map_err(|e| format!("อ่าน {path:?} ไม่ได้: {e}"))?;
        serde_yaml::from_str(&text).map_err(|e| format!("parse {path:?} ไม่ผ่าน: {e}"))
    }

    /// หมวดที่มี entry จริง (ไม่นับหมวดที่ประกาศไว้เฉยๆ)
    pub fn categories_in_use(&self) -> Vec<&str> {
        let mut v: Vec<&str> = self.resources.iter().map(|r| r.category.as_str()).collect();
        v.sort_unstable();
        v.dedup();
        v
    }

    pub fn with_note(&self) -> usize {
        self.resources.iter().filter(|r| r.note.is_some()).count()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn norm_matches_the_shell_version() {
        // เคสเดียวกับที่ scripts/lib.sh ต้องได้ — ถ้าสองฝั่งเห็นไม่ตรงกัน
        // check.sh จะบอกว่า [ใหม่] ทั้งที่ slcat บอกว่าซ้ำ
        assert_eq!(norm("https://learn.blueshift.gg/"), "learn.blueshift.gg");
        assert_eq!(norm("http://www.Example.com/A/"), "example.com/a");
        assert_eq!(norm("https://x.dev/p?q=1#frag"), "x.dev/p");
        assert_eq!(norm("https://x.dev///"), "x.dev");
        assert_eq!(norm("x.dev/PATH"), "x.dev/path");
    }

    #[test]
    fn tags_defaults_to_empty_not_error() {
        let y = "url: u\nname: n\ncategory: c\nsource: community\n";
        let r: Resource = serde_yaml::from_str(y).unwrap();
        assert!(r.tags.is_empty());
        assert!(r.note.is_none());
    }

    #[test]
    fn unknown_field_is_a_hard_error_nowhere_but_missing_required_is() {
        // ฟิลด์ที่ต้องมีขาด = parse ไม่ผ่าน ไม่ใช่คืนค่าว่างเงียบๆ แบบ yq
        let y = "url: u\nname: n\n";
        assert!(serde_yaml::from_str::<Resource>(y).is_err());
    }
}
