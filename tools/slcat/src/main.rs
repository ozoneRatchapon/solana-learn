//! `slcat` — เครื่องมืออ่าน/ตรวจแคตตาล็อกของ solana-learn
//!
//! ตอนนี้มีคำสั่งเดียว: `audit` ซึ่งทำงานเดียวกับ `scripts/audit.sh` ชั้นที่ 1–2
//! (ข้อมูล + คุณภาพ) แต่ parse ไฟล์ครั้งเดียวแทนที่จะยิง `yq` 25 ครั้ง
//!
//! ตั้งใจให้ขึ้นทีละคำสั่ง ไม่ใช่เขียนใหม่ทั้งชุดรวดเดียว — bash ที่มีอยู่ทำงานได้
//! และมีวินัยครบแล้ว ตัวไหนย้ายมาต้องให้ผลตรงกับของเดิมก่อนถึงจะแทนที่ได้
//! ชั้น 3 (คำอ้างในเอกสาร) กับ 4 (CATALOG ตรงกับ YAML) ยังอยู่ที่ bash

mod model;

use clap::{Parser, Subcommand};
use model::{norm, Catalog, RejectedFile, SOURCES};
use std::collections::BTreeMap;
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "slcat", about = "เครื่องมือของ solana-learn")]
struct Cli {
    /// รากของ repo (ปกติเดาจากตำแหน่ง binary ไม่ได้ตอนรันผ่าน cargo)
    #[arg(long, default_value = ".")]
    root: PathBuf,
    #[command(subcommand)]
    cmd: Cmd,
}

#[derive(Subcommand)]
enum Cmd {
    /// ตรวจข้อมูล + คุณภาพ (ชั้น 1–2 ของ audit.sh)
    Audit {
        /// สัดส่วน note ขั้นต่ำที่ยอมรับได้ — ขยับขึ้นได้อย่างเดียว
        #[arg(long, default_value_t = 67)]
        note_floor: usize,
    },
}

fn main() -> std::process::ExitCode {
    let cli = Cli::parse();
    match cli.cmd {
        Cmd::Audit { note_floor } => match audit(&cli.root, note_floor) {
            Ok(fails) if fails == 0 => std::process::ExitCode::SUCCESS,
            Ok(_) => std::process::ExitCode::FAILURE,
            Err(e) => {
                eprintln!("  ✗ {e}");
                std::process::ExitCode::FAILURE
            }
        },
    }
}

struct Report {
    fails: usize,
    warns: usize,
}

impl Report {
    fn ok(&self, m: impl std::fmt::Display) {
        println!("  \x1b[32m✓\x1b[0m {m}");
    }
    fn bad(&mut self, m: impl std::fmt::Display) {
        println!("  \x1b[31m✗\x1b[0m {m}");
        self.fails += 1;
    }
    fn warn(&mut self, m: impl std::fmt::Display) {
        println!("  \x1b[33m!\x1b[0m {m}");
        self.warns += 1;
    }
}

fn audit(root: &std::path::Path, note_floor: usize) -> Result<usize, String> {
    let cat = Catalog::load(&root.join("data/resources.yml"))?;
    let rej_path = root.join("data/rejected.yml");
    let rej: RejectedFile = if rej_path.exists() {
        let t = std::fs::read_to_string(&rej_path).map_err(|e| e.to_string())?;
        serde_yaml::from_str(&t).map_err(|e| format!("parse rejected.yml ไม่ผ่าน: {e}"))?
    } else {
        RejectedFile { rejected: vec![] }
    };

    let total = cat.resources.len();
    let mut r = Report { fails: 0, warns: 0 };

    println!("\n\x1b[1m1. ข้อมูล ({total} รายการ)\x1b[0m");

    // ฟิลด์ที่ต้องมีถูกบังคับตั้งแต่ตอน parse แล้ว — ถ้าขาด load() จะ error ไปก่อนถึงตรงนี้
    r.ok("ทุก entry มี url / name / category / source (บังคับตอน parse)");

    let declared: Vec<&str> = cat.categories.keys().map(|s| s.as_str()).collect();
    let orphans: Vec<&str> = cat
        .categories_in_use()
        .into_iter()
        .filter(|c| !declared.contains(c))
        .collect();
    if orphans.is_empty() {
        r.ok("ทุก category มีประกาศใน categories:");
    } else {
        r.bad(format!("category ที่ไม่ได้ประกาศ: {}", orphans.join(", ")));
    }

    let mut seen: BTreeMap<String, &str> = BTreeMap::new();
    let mut dups = vec![];
    for res in &cat.resources {
        let n = norm(&res.url);
        if let Some(prev) = seen.insert(n.clone(), &res.name) {
            dups.push(format!("{n} ({prev} / {})", res.name));
        }
    }
    if dups.is_empty() {
        r.ok("ไม่มี URL ซ้ำหลัง normalize");
    } else {
        r.bad(format!("URL ซ้ำ: {}", dups.join(", ")));
    }

    let bad_src: Vec<&str> = cat
        .resources
        .iter()
        .filter(|x| !SOURCES.contains(&x.source.as_str()))
        .map(|x| x.name.as_str())
        .collect();
    if bad_src.is_empty() {
        r.ok("source อยู่ในชุดที่กำหนดทั้งหมด");
    } else {
        r.bad(format!("source นอกชุด: {}", bad_src.join(", ")));
    }

    // ── ทะเบียนที่ปฏิเสธ ───────────────────────────────────────────────
    println!("\n\x1b[1m1b. ทะเบียนที่ปฏิเสธ ({} รายการ)\x1b[0m", rej.rejected.len());
    if rej.rejected.is_empty() {
        r.ok("ยังไม่มีรายการที่ปฏิเสธ (ไฟล์พร้อมใช้)");
    } else {
        let thin = rej
            .rejected
            .iter()
            .filter(|x| x.reason.as_deref().map_or(true, |s| s.chars().count() < 20))
            .count();
        if thin == 0 {
            r.ok("ทุกเหตุผลยาวพอให้อ่านรู้เรื่อง");
        } else {
            r.bad(format!("{thin} รายการมีเหตุผลสั้นกว่า 20 ตัวอักษร"));
        }
        let kept: Vec<String> = cat.resources.iter().map(|x| norm(&x.url)).collect();
        let both: Vec<&str> = rej
            .rejected
            .iter()
            .filter(|x| kept.contains(&norm(&x.url)))
            .map(|x| x.url.as_str())
            .collect();
        if both.is_empty() {
            r.ok("ไม่มี URL ที่อยู่ทั้งในแคตตาล็อกและทะเบียนปฏิเสธ");
        } else {
            r.bad(format!("URL อยู่ทั้งสองฝั่ง: {}", both.join(", ")));
        }
    }

    // ── เลิกใช้แล้ว ────────────────────────────────────────────────────
    let dep: Vec<_> = cat.resources.iter().filter(|x| x.deprecated.is_some()).collect();
    println!("\n\x1b[1m1c. รายการที่เลิกใช้ ({} รายการ)\x1b[0m", dep.len());
    if dep.is_empty() {
        r.warn("ยังไม่มี entry ไหนถูกทำเครื่องหมายว่าเลิกใช้ — ในปีที่ Anchor ขึ้น 1.0 และ web3.js ย้ายไป Kit เป็นไปได้ยากที่จะไม่มีเลย");
    } else {
        let thin = dep
            .iter()
            .filter(|x| x.deprecated.as_deref().is_some_and(|s| s.chars().count() < 20))
            .count();
        if thin == 0 {
            r.ok("ทุกเหตุผลยาวพอให้อ่านรู้เรื่อง");
        } else {
            r.bad(format!("{thin} รายการมีเหตุผลเลิกใช้สั้นกว่า 20 ตัวอักษร"));
        }
        let nosup = dep.iter().filter(|x| x.superseded_by.is_none()).count();
        if nosup == 0 {
            r.ok("ทุกรายการบอกว่าใช้อะไรแทน");
        } else {
            r.warn(format!("{nosup} รายการเลิกใช้แต่ไม่ได้บอกตัวแทน"));
        }
        // ตัวแทนที่ตัวเองก็เลิกใช้ = ส่งคนไปเจอทางตันต่อ
        let dep_urls: Vec<String> = dep.iter().map(|x| norm(&x.url)).collect();
        let loops: Vec<&str> = dep
            .iter()
            .filter_map(|x| x.superseded_by.as_deref())
            .filter(|u| dep_urls.contains(&norm(u)))
            .collect();
        if loops.is_empty() {
            r.ok("ไม่มีตัวแทนที่ตัวเองก็เลิกใช้แล้ว");
        } else {
            r.bad(format!("superseded_by ชี้ไปหาของที่เลิกใช้: {}", loops.join(", ")));
        }
    }

    // ── คุณภาพ ─────────────────────────────────────────────────────────
    println!("\n\x1b[1m2. คุณภาพเนื้อหา\x1b[0m");
    let with = cat.with_note();
    let pct = with * 100 / total;
    if pct >= note_floor {
        r.ok(format!("มี note {with}/{total} ({pct}%) — เพดานล่าง {note_floor}%"));
    } else {
        r.bad(format!("มี note แค่ {pct}% (ต่ำกว่าเพดานล่าง {note_floor}%)"));
    }
    let nonote = total - with;
    if nonote > 0 {
        r.warn(format!("{nonote} entry ยังไม่มี note"));
        let mut by_cat: BTreeMap<&str, (usize, usize)> = BTreeMap::new();
        for res in &cat.resources {
            let e = by_cat.entry(res.category.as_str()).or_insert((0, 0));
            e.1 += 1;
            if res.note.is_none() {
                e.0 += 1;
            }
        }
        // เรียงตาม % มากไปน้อย เท่ากันแล้วเรียงชื่อหมวด — ต้อง deterministic
        // (ของเดิมฝั่ง bash ใช้ `sort -rn` เฉยๆ ซึ่งไม่ stable อันดับสลับได้ระหว่างรัน
        //  แก้ทั้งสองฝั่งให้ตรงกันแทนที่จะให้ฝั่งใหม่ไปเลียนแบบความไม่แน่นอน)
        let mut worst: Vec<(&str, usize, usize, usize)> = by_cat
            .into_iter()
            .filter(|(_, (n, _))| *n > 0)
            .map(|(c, (n, t))| (c, n * 100 / t, n, t))
            .collect();
        worst.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
        let s: Vec<String> = worst
            .iter()
            .take(3)
            .map(|(c, p, n, t)| format!("{c}({n}/{t} {p}%)"))
            .collect();
        r.warn(format!("หมวดที่ขาดหนักสุด: {}", s.join(" ")));
    }

    let dead = cat.resources.iter().filter(|x| x.status.as_deref() == Some("dead")).count();
    println!();
    if r.fails == 0 {
        print!(
            "\x1b[32mผ่าน\x1b[0m — {total} รายการ · {} หมวด · ลิงก์ตาย {dead} · note {pct}% · ปฏิเสธไว้ {} · เลิกใช้ {}",
            cat.categories_in_use().len(),
            rej.rejected.len(),
            dep.len()
        );
        if r.warns > 0 {
            print!("  (เตือน {})", r.warns);
        }
        println!();
    } else {
        println!("\x1b[31mไม่ผ่าน {} ข้อ\x1b[0m (เตือน {})", r.fails, r.warns);
    }
    Ok(r.fails)
}
