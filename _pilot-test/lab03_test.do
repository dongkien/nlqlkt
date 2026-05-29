* === Lab 3 Pilot Test ===
clear all
set more off
cd "/home/kiendn/material-building/_pilot-test"
log using "lab03_test.log", replace text

clear
input str20 nganh str20 doanh_nghiep thi_phan
"Viễn thông"      "Viettel"          54
"Viễn thông"      "VinaPhone"        18
"Viễn thông"      "MobiFone"         19
"Viễn thông"      "Vietnamobile"      4
"Viễn thông"      "Khác"              5
"Ngân hàng"       "Agribank"         11
"Ngân hàng"       "BIDV"             11
"Ngân hàng"       "VietinBank"       10
"Ngân hàng"       "Vietcombank"      10
"Ngân hàng"       "Techcombank"       5
"Ngân hàng"       "Khác"             53
"Bia"             "Heineken"         39
"Bia"             "Sabeco"           33
"Bia"             "Habeco"           11
"Bia"             "Carlsberg"        10
"Bia"             "Khác"              7
"Bán lẻ"          "BHX"              18
"Bán lẻ"          "WinMart"          16
"Bán lẻ"          "Coopmart"         10
"Bán lẻ"          "Aeon"              7
"Bán lẻ"          "Khác"             49
"Hàng không"      "Vietnam Airlines" 35
"Hàng không"      "Vietjet"          40
"Hàng không"      "Bamboo"           15
"Hàng không"      "Vietravel"         5
"Hàng không"      "Khác"              5
end

display "=== Dataset 5 ngành ==="
list, sepby(nganh)

* Tính HHI
generate thi_phan_sq = thi_phan ^ 2
egen HHI = total(thi_phan_sq), by(nganh)

display ""
display "=== HHI theo ngành ==="
preserve
    duplicates drop nganh, force
    keep nganh HHI
    gsort -HHI
    list, separator(0) noobs
restore

* Phân loại
generate muc_tap_trung = ""
replace muc_tap_trung = "Thấp"        if HHI < 1500
replace muc_tap_trung = "Trung bình"  if HHI >= 1500 & HHI <= 2500
replace muc_tap_trung = "Cao"         if HHI > 2500

display ""
display "=== Mức tập trung ==="
preserve
    duplicates drop nganh, force
    keep nganh HHI muc_tap_trung
    gsort -HHI
    list, separator(0) noobs
restore

* Tìm DN thống lĩnh (>30%)
generate thong_linh = (thi_phan > 30)
display ""
display "=== DN có vị trí thống lĩnh thị trường (>30%) ==="
list nganh doanh_nghiep thi_phan if thong_linh == 1, noobs

* Mô phỏng M&A Heineken + Sabeco
display ""
display "=== Mô phỏng M&A: Heineken + Sabeco ==="
preserve
    keep if nganh == "Bia"
    egen HHI_truoc = total(thi_phan_sq)
    display "HHI trước M&A: " HHI_truoc[1]

    replace thi_phan = 39 + 33 if doanh_nghiep == "Heineken"
    drop if doanh_nghiep == "Sabeco"

    generate thi_phan_sq_moi = thi_phan ^ 2
    egen HHI_sau = total(thi_phan_sq_moi)
    display "HHI sau M&A : " HHI_sau[1]
    display "ΔHHI         : " HHI_sau[1] - HHI_truoc[1]
restore

* Biểu đồ HHI
preserve
    duplicates drop nganh, force
    keep nganh HHI
    gsort -HHI

    graph bar HHI, over(nganh, sort(HHI) descending) ///
        bar(1, color("114 47 55")) ///
        title("Chỉ số HHI — 5 ngành Việt Nam") ///
        yline(1500, lcolor(orange) lpattern(dash)) ///
        yline(2500, lcolor(red) lpattern(dash)) ///
        ylabel(0(1000)5000) ///
        graphregion(color(white))

    graph export "hhi_5nganh.png", replace width(1400)
restore

log close
display ""
display "=== LAB 3 PILOT TEST COMPLETE ==="
