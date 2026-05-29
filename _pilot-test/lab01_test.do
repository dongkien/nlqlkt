* === Lab 1 Pilot Test — DTU301 ===
* Test toàn bộ code Lab 1 xem có chạy đúng không

clear all
set more off
cd "/home/kiendn/material-building/_pilot-test"
log using "lab01_test.log", replace text

* === Phần 1: Tạo dataset PPF ===
clear
set obs 11
generate x = _n - 1
generate y = sqrt(100 - x^2)

label variable x "Quân sự (đơn vị)"
label variable y "Y tế (số bệnh viện)"

display "=== Phần 1: Dataset PPF ==="
list

* === Phần 2: Vẽ PPF ===
twoway (line y x, lwidth(thick) lcolor("114 47 55")) ///
       (scatter y x, mcolor("114 47 55") msize(medium)), ///
       title("PPF: Đánh đổi giữa Y tế và Quốc phòng") ///
       xtitle("Quân sự (đơn vị)") ///
       ytitle("Y tế (số bệnh viện)") ///
       legend(off) ///
       graphregion(color(white))

graph export "ppf.png", replace width(1200)
display "=== Phần 2: PPF graph exported ==="

* === Phần 3: Chi phí cơ hội ===
sort x
generate y_lag = y[_n-1]
generate opportunity_cost = y_lag - y

label variable opportunity_cost "Chi phí cơ hội biên"

display "=== Phần 3: Chi phí cơ hội ==="
list x y opportunity_cost

* === Phần 4: Biểu đồ opportunity cost ===
twoway (bar opportunity_cost x, fcolor("193 154 77") lcolor("114 47 55")), ///
       title("Chi phí cơ hội biên tăng dần") ///
       xtitle("Số đơn vị quân sự") ///
       ytitle("Bệnh viện hy sinh để thêm 1 quân sự") ///
       graphregion(color(white))

graph export "opportunity_cost.png", replace width(1200)
display "=== Phần 4: Opportunity cost graph exported ==="

* === Phần 5: PPF dịch ra ===
generate y_new = sqrt(130 - x^2)
replace y_new = . if x^2 > 130

twoway (line y x,     lwidth(medium) lcolor("114 47 55")) ///
       (line y_new x, lwidth(medium) lcolor("46 125 80") lpattern(dash)), ///
       title("PPF dịch ra — đại diện cho tăng trưởng kinh tế") ///
       xtitle("Quân sự") ytitle("Y tế") ///
       legend(label(1 "PPF cũ") label(2 "PPF mới") position(2) ring(0) cols(1)) ///
       graphregion(color(white))

graph export "ppf_growth.png", replace width(1200)
display "=== Phần 5: PPF growth graph exported ==="

log close

display ""
display "=== PILOT TEST LAB 1 — COMPLETE ==="
display "Kiểm tra file: lab01_test.log, ppf.png, opportunity_cost.png, ppf_growth.png"
