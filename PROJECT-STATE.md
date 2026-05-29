# Project State — Nguyên lý Quản lý Kinh tế

**File này là điểm chốt trạng thái dự án — đọc đầu mỗi session để hiểu nhanh.**

## 📍 Quick context (đọc 30 giây)

- **Project**: Website học liệu môn **Nguyên lý Quản lý Kinh tế** (FTU, Viện KT&KDQT)
- **Path**: `/home/kiendn/nlqlkt/`
- **Live URL**: https://dongkien.github.io/nlqlkt/
- **GitHub repo**: https://github.com/dongkien/nlqlkt
- **Tech stack**: Quarto + Stata MP + R + nbstata + Netlify-like (GitHub Pages)
- **Người chính**: TS. Đỗ Ngọc Kiên (Trưởng Bộ môn) + đội 11 giảng viên FTU

## ✅ Đã hoàn thành (cumulative)

### Nội dung (100% song slide thật)
- **15/15 bài giảng** từ slide thực tế của TS. Đỗ Ngọc Kiên
- **16/16 Stata Lab** (Lab 0 cài đặt + 15 lab theo buổi)
- **16/16 R Lab** (song song với Stata Lab — phiên bản free, ggplot2)
- Trang chủ, đề cương, lịch học 15 buổi, problem sets, đánh giá, **người hướng dẫn**

### Cấu trúc đã chốt
- 5 chương + Seminar tổng hợp trải 15 buổi (đúng đề cương FTU)
- Đánh giá: 10% quá trình + 30% giữa kỳ + 60% cuối kỳ
- Cuối kỳ: tự luận đóng, **20 trắc nghiệm + 2 tự luận** (2 mức Bloom)
- Stata/R Lab: **bonus 5%**, làm cả 2 → tối đa **+7%**

### Tech setup
- **Quarto 1.9.38** ở `~/.local/quarto/`
- **Stata MP 19** ở `/usr/local/stata19/` (2-core perpetual MP license)
- **nbstata** trong venv `.venv/` cho Stata MP qua Quarto
- **R**: chưa cài (R Lab chỉ hiển thị code, không execute)
- **GitHub credentials**: PAT trong `~/.git-credentials` (xem section dưới)

### Quyết định lớn đã chốt
- **Brand**: chỉ "Nguyên lý Quản lý Kinh tế", **không có mã DTU301**
- **Theme**: maroon `#722f37` + gold `#c19a4d` + cream `#fbfaf6`
- **Font**: Lora (serif) + Be Vietnam Pro (sans)
- **Code blocks**: cream bg + dark text (sửa từ dark theme trước)
- **R Lab callouts**: cross-link với Stata Lab trong mỗi bài giảng

## 🚧 Đang dở / Chờ user

| Việc | Trạng thái | Cần |
|---|---|---|
| Pilot test với 5-8 SV | Sẵn sàng (gói ở `_pilot-test/student-package/`) | User triển khai pilot |
| R Lab 2-15 chi tiết hoá | Skeleton có sẵn | Khi nào sinh viên cần → fill in |
| Datasets thật thay mô phỏng | Mô phỏng OK cho học | Khi có data thật, replace từng lab |
| GitHub PAT có thể hết hạn | Active 90 days | Tạo mới nếu sắp hết hạn |

## 🔑 Lệnh thường dùng

```bash
# === LÀM VIỆC LOCAL ===
cd /home/kiendn/nlqlkt
source .venv/bin/activate
export PATH="$HOME/.local/bin:$PATH"

# Preview
quarto preview --no-browser --port 4445
# → http://localhost:4445/

# Render full
quarto render

# === ĐẨY LÊN PRODUCTION ===
# 1. Commit source (main branch)
git add . && git commit -m "..."
git push origin main

# 2. Render + publish (gh-pages branch — Pages serve từ đây)
quarto publish gh-pages --no-prompt --no-browser

# === CHẠY STATA MP TRỰC TIẾP ===
stata-mp -b do myfile.do
# Hoặc qua Quarto khi có {stata} block (Tuần 1 hiện đang execute thật)
```

## 📁 Cấu trúc thư mục

```
nlqlkt/
├── _quarto.yml              ← config navbar, sidebar, theme
├── index.qmd                ← trang chủ
├── syllabus.qmd             ← đề cương
├── schedule.qmd             ← lịch học 15 buổi
├── nguoi-huong-dan.qmd      ← danh sách giảng viên (NEW)
├── lectures/
│   ├── index.qmd
│   └── buoi-{01..15}.qmd    ← 15 bài giảng đầy đủ
├── stata-lab/
│   ├── index.qmd
│   ├── lab-00.qmd
│   └── lab-{01..15}.qmd     ← 16 Stata Lab
├── r-lab/                    ← (NEW)
│   ├── index.qmd
│   ├── lab-00.qmd            ← full
│   ├── lab-01.qmd            ← full
│   └── lab-{02..15}.qmd      ← skeleton, link sang Stata Lab tương ứng
├── problem-sets/index.qmd
├── exams/index.qmd
├── data/vn_gdp_1986_2024.csv
├── styles/custom.scss
├── _source-materials/        ← slides gốc (Quarto ignored)
│   └── slides/
├── _pilot-test/              ← Pilot test cho 5-8 SV
│   ├── CHECKLIST-PILOT.md
│   └── student-package/
├── .venv/                    ← Python venv với nbstata
├── PROJECT-STATE.md          ← FILE NÀY
└── README.md
```

## 🔐 GitHub credentials

```
username: dongkien
email: dongockien@gmail.com
name: Do Ngoc Kien
```

PAT lưu ở `~/.git-credentials` (file local, KHÔNG commit). Tạo PAT mới khi cần tại https://github.com/settings/tokens với quyền `repo`.

## 🚀 Quay lại làm tiếp — checklist

Khi mở Claude Code sáng mai:

```bash
# 1. Vào thư mục
cd /home/kiendn

# 2. Tiếp đúng hội thoại (nếu chưa quá 7 ngày)
claude -c

# Hoặc session mới + đọc state
claude
# Rồi nói: "tiếp Material Building, đọc PROJECT-STATE.md"
```

Memory file `~/.claude/projects/-home-kiendn/memory/nlqlkt.md` sẽ auto-load với context.

## 📞 Liên hệ + nhận diện

Nếu file này không khớp với những gì bạn nghĩ Claude nhớ:
- Memory: `cat ~/.claude/projects/-home-kiendn/memory/nlqlkt.md`
- Git log: `cd /home/kiendn/nlqlkt && git log --oneline | head -20`
- File tree: `find /home/kiendn/nlqlkt -type f -name "*.qmd" | head -20`

## 🎯 Kế hoạch dài hạn (nếu user muốn mở rộng)

- [ ] Bilingual VN/EN cho international students
- [ ] Tích hợp với LMS FTU (Moodle?)
- [ ] Mở rộng cho các môn khác trong Bộ môn
- [ ] Video lecture archive
- [ ] Newsletter sinh viên định kỳ
- [ ] PDF export đẹp cho in ấn

---

*Last updated: 29/05/2026 — sau khi thêm R Lab + xoá DTU301 + thêm trang Người hướng dẫn*
