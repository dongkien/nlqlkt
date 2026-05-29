# Nguyên lý Quản lý Kinh tế — Học liệu mở

Bộ học liệu môn **Nguyên lý Quản lý Kinh tế** cho sinh viên cử nhân năm 3–4, dựng bằng **Quarto** dưới dạng Open Course site (15 tuần, hỗ trợ code Stata).

```
Quarto (single source)  →  HTML site / PDF / Slides
```

## 📁 Cấu trúc

```
nlqlkt/
├── _quarto.yml             Cấu hình site (navbar, sidebar, theme)
├── index.qmd               Trang chủ
├── syllabus.qmd            Đề cương chi tiết
├── schedule.qmd            Lịch học 15 tuần
├── lectures/
│   ├── index.qmd           Danh sách bài giảng
│   ├── week-01.qmd         Tuần 1 — FULLY POPULATED (mẫu)
│   └── week-02.qmd → 15.qmd  Skeleton để giảng viên đổ nội dung
├── problem-sets/
│   ├── index.qmd
│   └── ps-01.qmd           PS01 đầy đủ làm mẫu
├── exams/
│   └── index.qmd           Cấu trúc thi + đề mẫu
├── data/
│   └── vn_gdp_1986_2024.csv   Dataset cho Stata exercise tuần 1
├── styles/
│   └── custom.scss         Theme maroon + gold
└── _site/                  Output HTML (tự sinh, đừng commit)
```

## 🚀 Local development

```bash
# Render toàn site
quarto render

# Preview với live reload (sửa file → tự refresh trình duyệt)
quarto preview
# → mở http://localhost:4444/
```

> **Mẹo**: Quarto preview tự reload khi bạn lưu file `.qmd`. Mở 1 tab trình duyệt, 1 cửa sổ editor, làm việc song song.

## ✍️ Thêm / sửa nội dung

### Sửa một bài giảng

Mở `lectures/week-XX.qmd` → sửa Markdown → lưu → preview tự refresh.

### Thêm bài giảng mới (vd: bù học)

```bash
cp lectures/week-01.qmd lectures/week-04b.qmd
# Sửa frontmatter (title, subtitle), nội dung
# Thêm vào _quarto.yml > sidebar > contents
```

### Thêm Problem Set mới

```bash
cp problem-sets/ps-01.qmd problem-sets/ps-02.qmd
# Sửa nội dung và hạn nộp
```

### Thêm dataset cho bài tập

Đặt file `.csv` vào `data/`. Trong `.qmd`:

````markdown
```stata
import delimited "data/ten-file.csv", clear case(lower)
```
````

## 🎨 Tùy chỉnh giao diện

Đổi màu/font trong `styles/custom.scss`:

```scss
$primary:    #722f37;   // maroon đậm
$secondary:  #c19a4d;   // gold
$body-bg:    #fbfaf6;   // cream
$font-family-serif:  "Lora", Georgia, serif;
$font-family-sans-serif: "Be Vietnam Pro", sans-serif;
```

Lưu file → preview refresh ngay.

## 📤 Xuất sang định dạng khác

```bash
# HTML (mặc định)
quarto render

# PDF (cần TinyTeX — quarto install tinytex)
quarto render --to pdf

# Reveal.js slides
quarto render lectures/week-01.qmd --to revealjs

# Word
quarto render lectures/week-01.qmd --to docx
```

Cùng 1 file `.qmd` → ra HTML / PDF / Slide / Word.

## 🌐 Deploy free

### Cách 1 — GitHub Pages (khuyên dùng)

```bash
git init && git add . && git commit -m "Initial"
git branch -M main
git remote add origin https://github.com/<user>/nlqlkt.git
git push -u origin main
```

GitHub → Settings → Pages → Source: **GitHub Actions** → workflow Quarto sẵn có ([template tại quarto.org](https://quarto.org/docs/publishing/github-pages.html)).

```bash
# Hoặc dùng quarto-publish (push lên gh-pages branch):
quarto publish gh-pages
```

### Cách 2 — Netlify

Netlify → Add new site → từ GitHub repo.

- Build command: `quarto render`
- Publish directory: `_site`
- Add file `.nvmrc` ghi `22` để có Node phù hợp (nếu Quarto cần).

### Cách 3 — Netlify Drop

```bash
quarto render
# Kéo cả folder _site/ vào https://app.netlify.com/drop
```

## 🧑‍🏫 Stata trong tài liệu này

Code Stata được hiển thị có syntax highlight nhưng **không thực thi khi build** (Quarto cần Stata bản trả phí để execute). Sinh viên copy code → mở Stata trên máy mình → chạy.

Nếu giảng viên muốn embed kết quả thật (bảng, biểu đồ) vào tài liệu:

1. Chạy code trong Stata
2. Export biểu đồ thành `.png` → đặt vào `data/figures/`
3. Trong `.qmd`:
   ```markdown
   ![Tăng trưởng GDP Việt Nam](../data/figures/gdp.png){fig-alt="..."}
   ```

## 📋 Việc cần làm cho giảng viên

- [ ] Cập nhật tên giảng viên trong `_quarto.yml` (footer) và `syllabus.qmd`.
- [ ] Điền thông tin trường, mã môn, học kỳ vào `syllabus.qmd`.
- [ ] Cập nhật tên giáo trình chính xác cho phù hợp với chương trình của trường.
- [ ] Mở rộng nội dung Tuần 2–15 (hiện ở dạng skeleton).
- [ ] Bổ sung 2 dataset còn lại cho PS01: `vn_sector_share.csv`.
- [ ] Soạn PS02, PS03.
- [ ] Bổ sung đề thi mẫu giữa kỳ + cuối kỳ thật sự dưới dạng PDF.

## 🆘 Lỗi thường gặp

- **`quarto: command not found`** → `export PATH="$HOME/.local/bin:$PATH"` hoặc thêm vào `~/.bashrc`.
- **PDF render lỗi font tiếng Việt** → `quarto install tinytex` + dùng XeLaTeX engine.
- **Preview không live reload** → kiểm tra firewall, port 4444.
- **Stata code không có syntax highlight** → đảm bảo dùng ```` ```stata ```` (3 backticks + stata, không có curly braces).

## 📝 Giấy phép

Toàn bộ nội dung phát hành theo **Creative Commons BY-NC-SA 4.0** trừ khi ghi chú khác.
Có thể chia sẻ, sửa đổi, sử dụng cho mục đích giáo dục phi thương mại,
miễn dẫn nguồn và giữ giấy phép tương tự.
