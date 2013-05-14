cscript 
version 11

/*
	grmate, m(4 2 3 4) x(0 2) y(0 2) n(8)
*/

program grmate
	syntax [, Matrix(string) X(string) Y(string) N(string) ///
		  COMPRESS noAXis noOrig noTrans Eigen]

	parse_matrix x11 x12 x21 x22 : `"`matrix'"'
	parse_range  xmin xmax       : `"`x'"'
	parse_range  ymin ymax       : `"`y'"'
	parse_n      n               : `"`n'"'

/*
	di "X = `x11' `x12' `x21' `x22'"
	di "x = `xmin' `xmax'
	di "y = `ymin' `ymax'
	di "n = `n'"
*/
	build_y_x `xmin' `xmax' `ymin' `ymax' `n'
	build_yt_xt `x11' `x12' `x21' `x22'

	if ("`eigen'"!="") {
		/* obtain eigenvectors and eigenvalues */
		tempname A X v
/*
		matrix `A' = (`x11' , `x12' \ `x21', `x22') 
		matrix symeigen `X' `v' = `A'
*/
		mata: A = (`x11' , `x12' \ `x21', `x22') 
		mata: eigensystem(A, X=., L=.)
		mata: st_matrix("`X'", Re(X))
		mata: st_matrix("`v'", Re(L))
		mata: X
		mata: L


		local lambda1 = `v'[1,1]
		local lambda2 = `v'[1,2]
		local slope1  = `X'[2,1]/`X'[1,1]
		local slope2  = `X'[2,2]/`X'[1,2]

		noi di 
		noi di "1st eigen vector is " `slope1' " = " ///
			`X'[1,1] " / " `X'[2,1] " reverse"
		noi di "2nd eigen vector is " `slope2' " = " ///
			`X'[1,2] " / " `X'[2,2] " reverse"
		noi di

		if ("`compress'"=="") {
			findmin x_minimum x_maximum : x xt
		}
		else {
			local x_minimum `xmin'
			local x_maximum `xmax'
		}
		qui gen x_eigen  = cond(_n==1, `x_minimum', `x_maximum') in 1/2
		qui gen y1_eigen = x_eigen*`slope1' in 1/2
		qui gen y2_eigen = x_eigen*`slope2' in 1/2
	}

	char y[min]  `ymin'
	char y[max]  `ymax'
	char x[min]  `xmin' 
	char x[max]  `xmax'

	char xt[xminymin] `=`x11'*`xmin' + `x12'*`ymin''
	char yt[xminymin] `=`x21'*`xmin' + `x22'*`ymin''
	char xt[xminymax] `=`x11'*`xmin' + `x12'*`ymax''
	char yt[xminymax] `=`x21'*`xmin' + `x22'*`ymax''
	char xt[xmaxymin] `=`x11'*`xmax' + `x12'*`ymin''
	char yt[xmaxymin] `=`x21'*`xmax' + `x22'*`ymin''
	char xt[xmaxymax] `=`x11'*`xmax' + `x12'*`ymax''
	char yt[xmaxymax] `=`x21'*`xmax' + `x22'*`ymax''

	char _dta[c11] `x11'
	char _dta[c12] `x12'
	char _dta[c12] `x21'
	char _dta[c22] `x22'

	local cmd `"gr twoway"'
	if ("`orig'"=="") {
		local cmd `"`cmd' (line y x, pstyle(p2))"'
	}
	if ("`trans'"=="") {
 		local cmd `"`cmd' (line yt xt, pstyle(p1))"'
	}

	if ("`orig'"=="") {
		local cmd ///
		`"`cmd' (scatteri `y[min]' `x[min]', color(black) ms(oh))"'
	}
	if ("`trans'"=="") {
		local cmd ///
		`"`cmd' (scatteri `yt[xminymin]' `xt[xminymin]', color(black) ms(oh))"'
	}

	if ("`orig'"=="") {
		local cmd `"`cmd' (scatteri `y[max]' `x[min]', color(black) ms(th))"'
	}
	if ("`trans'"=="") {
	local cmd `"`cmd' (scatteri `yt[xminymax]' `xt[xminymax]', color(black) ms(th))"'
	}

	if ("`eigen'"!="") {
		local cmd `"`cmd' (line y1_eigen x_eigen, color(black) lwidth(*1.5))"'
		local cmd `"`cmd' (line y2_eigen x_eigen, color(dkgreen))"'
	}


	// local cmd `"`cmd' (scatteri `y[min]' `x[max]', color(black) ms(Oh))"'
	// local cmd `"`cmd' (scatteri `yt[xmaxymin]' `xt[xmaxymin], color(255 255 255) ms(Oh)')"'

	local cmd `"`cmd', legend(off)"'
	local cmd `"`cmd' ylabel(, nogrid) xlabel(, nogrid)"'
	local cmd `"`cmd' ytitle("_1")"'
	local cmd `"`cmd' xtitle("_2")"'
	if ("`trans'"=="") {
		local ttl "A = (`x11', `x12' \ `x21', `x22')"
		if ("`eigen'"!="") {
			local val : di `lambda1'
			local ttl "`ttl'  (black) lambda1 = `val'"
			local val : di `lambda2'
			local ttl "`ttl'  (green) lambda2 = `val'"
		}
		local cmd `"`cmd' title("`ttl'", place(west) size(*.7))"'

	}
	local cmd `"`cmd' yscale(off) xscale(off)"'
	if ("`axis'"=="") {
		local cmd ///
			`"`cmd' yline(0, lcolor(gs10)) xline(0, lcolor(gs10))"'
	}
	display as txt `"- `cmd'"'
	`cmd'
end

program build_yt_xt
	args c11 c12 c21 c22

	gen xt = `c11'*x + `c12'*y
	gen yt = `c21'*x + `c22'*y
end


program build_y_x 
	args  xmin xmax  ymin ymax  n

	tempname x y

	quietly drop _all

	local nm1 = `n' - 1 
	gen y = . 
	gen x = . 

	local forward 1
	forvalues iy=0(1)`nm1' {
		scalar `y' = `ymin' + (`ymax'-`ymin')*(`iy'/`nm1')
		qui set obs `=_N+1'
		if (`forward') { 
			qui replace y = `y'    in l 
			qui replace x = `xmin' in l
			qui set obs `=_N+1'
			qui replace y = `y'    in l 
			qui replace x = `xmax' in l
		}
		else {
			qui replace y = `y'    in l 
			qui replace x = `xmax' in l
			qui set obs `=_N+1'
			qui replace y = `y' in l 
			qui replace x = `xmin' in l
		}
		local forward = !`forward'
	}

					// assume n is even
	local forward 0
	forvalues ix=0(1)`nm1' {
		scalar `x' = `xmin' + (`xmax'-`xmin')*(`ix'/`nm1')
		qui set obs `=_N+1'
		if (`forward') { 
			qui replace y = `ymin' in l 
			qui replace x = `x'    in l
			qui set obs `=_N+1'
			qui replace y = `ymax' in l 
			qui replace x = `x'    in l
		}
		else {
			qui replace y = `ymax' in l 
			qui replace x = `x'    in l
			qui set obs `=_N+1'
			qui replace y = `ymin' in l 
			qui replace x = `x'    in l
		}
		local forward = !`forward'
	}
end


program parse_matrix
	args	x11 x12 x21 x22 colon matrix nothing

	if ("`nothing'" != "") {
		error 198
	}
	if ("`colon'" != ":") {
		error 198
	}

	local myx11 : word 1 of `matrix'
	local myx12 : word 2 of `matrix'
	local myx21 : word 3 of `matrix'
	local myx22 : word 4 of `matrix'
	local void  : word 5 of `matrix'

	if ("`void'"!="") {
		di as err "option matrix() has extra element"
		exit 198
	}

	if ("`myx11'"=="") {
		di as error "option matrix() required"
		exit 198
	}
 
	confirm number `myx11'
	confirm number `myx12'
	confirm number `myx21'
	confirm number `myx22'

	c_local `x11' `myx11'
	c_local `x12' `myx12'
	c_local `x21' `myx21'
	c_local `x22' `myx22'
end

program parse_range
	args min max colon range nothing

	if ("`nothing'" != "") {
		error 198
	}
	if ("`colon'" != ":") {
		error 198
	}

	if ("`range'"=="") {
		c_local `min' 0
		c_local `max' 2
		exit
	}

	local mymin : word 1 of `range'
	local mymax : word 2 of `range'
	local void  : word 3 of `range'

	if ("`void'"!="") {
		di as err "option x() or y() has extra element"
		exit 198
	}

	if ("`mymin'"=="") {
		di as error "option x() or y() required"
		exit 198
	}
 
	confirm number `mymin'
	confirm number `mymax'

	c_local `min' `mymin'
	c_local `max' `mymax'
end


program parse_n
	args n colon value nothing

	if ("`nothing'" != "") {
		error 198
	}
	if ("`colon'" != ":") {
		error 198
	}

	if ("`value'"=="") {
		c_local `n' 8
		exit
	}

	local myval : word 1 of `value'
	local void  : word 2 of `value'

	if ("`void'"!="") {
		di as err "option n() has extra element"
		exit 198
	}

	confirm number `myval'

	c_local `n' `myval'
end


program findmin /* findmin x_minimum x_maximum : x xt */
	args min max colon var1 var2

	qui sum `var1'
	local mymin = r(min)
	local mymax = r(max)

	qui sum `var2' 
	if (`mymin' > r(min)) {
		local mymin = r(min)
	}
	if (`mymax' < r(max)) {
		local mymax = r(max)
	}

	c_local `min' `mymin'
	c_local `max' `mymax'
end




// grmat, m(4 2 3 4) x(-1 1) y(-2 2) n(8)
// grmat, m(4 2 3 4) x(0  3) y(0  3) n(8)

