cscript 
version 11

// theoretically,  grmate.do could be used instead of grmat.do, 
// but why tempt fate?
run grmat

local a11 2
local a12 1
local a21 1.5
local a22 2

local x1 = .75
local x2 = .25

local y1 = `a11'*`x1' + `a12'*`x2'
local y2 = `a21'*`x1' + `a22'*`x2'
di `y1' " " `y2'



graph twoway ///
(scatteri `x1' `x2') ///
(scatteri `y1' `y2' )  ///
(pcarrowi `x1' `x2'  `y1' `y2', msize(*2)) ///
, ///
xscale(range(0 3) off) ///
yscale(range(0 3) off) aspectratio(1) ///
legend(off) ///
ylabel(, nogrid) xlabel(, nogrid)

graph save fig1, replace

local xx1 = .2
local xx2 = .1
local yy1 = `a11'*`xx1' + `a12'*`xx2'
local yy2 = `a21'*`xx1' + `a22'*`xx2'

local xxx1 = .4
local xxx2  = 1.5
local yyy1 = `a11'*`xxx1' + `a12'*`xxx2'
local yyy2 = `a21'*`xxx1' + `a22'*`xxx2'


#delimit ; 

graph twoway 
(scatteri `x1' `x2') 
(scatteri `y1' `y2' )  
(pcarrowi `x1' `x2'  `y1' `y2', msize(*2)) 

(scatteri `xx1' `xx2') 
(scatteri `yy1' `yy2' )  
(pcarrowi `xx1' `xx2'  `yy1' `yy2', msize(*2)) 

(scatteri `xxx1' `xxx2') 
(scatteri `yyy1' `yyy2' )  
(pcarrowi `xxx1' `xxx2'  `yyy1' `yyy2', msize(*2)) 


, 
xscale(range(0 3) off) 
yscale(range(0 3) off) aspectratio(1) 
legend(off) 
ylabel(, nogrid) xlabel(, nogrid)
;
#delimit cr
graph save fig2, replace


grmat, m(2 1 1.5 2) x(0 3) y(0 3) notrans
graph save fig3, replace

grmat, m(2 1 1.5 2) x(0 3) y(0 3) noorig
graph save fig4, replace

grmat, m(2 1 1.5 2) x(0 3) y(0 3) 
graph save fig5, replace

grmat, m(2 1 1.5 2) x(-3 3) y(-4 4) 
graph save fig5_1, replace

grmat, m(2 0 0 2) x(0 3) y(0 3) 
graph save fig6, replace

grmat, m(.125 0 0 .125) x(0 3) y(0 3) 
graph save fig7, replace

grmat, m(1 2 3 1) x(0 3) y(0 3)
graph save fig8, replace

grmat, m(1 -2 3 1) x(0 3) y(0 3)
graph save fig8_1, replace


grmat, m(2 3 2 3) x(0 3) y(0 3)
graph save fig9, replace

* talk 2

grmat, m(2 1 1.5 .85) y(-1.175 1.175) x(-1.5 1.5)
graph save fig10, replace


graph twoway ///
(pci       0 0  3 3, lcolor(gs12)) ///
(scatteri  1 1  2 2) ///
(pcarrowi  1 1  2 2 "x", msize(*2)) ///
, ///
xscale(range(0 3) ) ///
yscale(range(0 3) ) aspectratio(1) ///
legend(off) ///
ylabel("", nogrid) xlabel("", nogrid) ///
xtitle("") ytitle("")
graph save fig11, replace

qui run grmate
grmate, m(2 1 1 2) x(-3 3) y(-3 3) ei noax
graph save fig12, replace

grmate, m(1.1 2 3 1) x(-3 3) y(-3 3) ei noax
graph save fig13, replace

grmate, m(2 1 1.5 .85) x(-3 3) y(-3 3) ei noax compress
graph save fig14, replace
