capture clear
clear matrix
clear mata
capture log close
set memory 1000m
set maxvar 20000
set matsize 8000
set more off

global mypath "C:\Users\Redha CHABA\Documents"

use "${mypath}\working_paper\rbci\data\data_dta\data_final.dta", clear

global ind_controls age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road
*bin_unfair_eth: removes observations
global cty_controls gdppc_log area_log vdem_polyarchy cor_index i.color_num i.gov_num
global geo_controls desert_region_tv mountain_region_tv

use "${mypath}\working_paper\rbci\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

reghdfe pol_trust cvg_region_pot dist_cap_max_norm c.dist_cap_max_norm#c.cvg_region_pot dist_sndncap_max_norm $ind_controls $geo_controls if cvg_region_pot>.0272222 & spl==1, absorb(i.country_round) cluster(i.region_time)

generate baseline2=1 if e(sample)
matrix b=e(b)
matrix V=e(V)

matrix b1=e(b2)

matrix b3=e(b3)

scalar b1=b[1,2]
scalar b3=b[1,3]

scalar varb1=V[2,2]
scalar varb3=V[3,3]

scalar covb1b3=V[2,3]

scalar list b1 b3 varb1 varb3 covb1b3

generate MVL= cvg_region_pot

gen conbl=b1+b3*MVL

gen consl=sqrt(varb1+varb3*(MVL^2)+2*covb1b3*MVL) 

gen al=1.96*consl

gen upperl=conbl+al

gen lowerl=conbl-al

*drop lowerl upperl al MVL conbl consl

*********************;
* Generate Rug Plot *;
*********************;

gen where=0.5
gen pipe = "|"

egen tag_distance= tag(cvg_region_pot)
gen yline=0

graph twoway hist MVL if baseline2==1, percent color(gs12%30) yaxis(2) || line conbl MVL, lpattern (solid) clwidth(medium)  clcolor(black) ||   line upperl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort ||   line lowerl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort|| , yscale(noline) xscale(noline) yline(0, lcolor(black))  xtitle("Mobile internet coverage", size(3))xsca(titlegap(2)) ysca(titlegap(2)) ytitle("Marginal effect of distance from the capital", size(3)) scheme(s2mono) graphregion(fcolor(white)) legend(off)

graph export "${mypath}\wp_git\rbci\plots\marginal_effect\pol_trust.jpg", width(4000) replace

**** vote_oppo_2

use "${mypath}\working_paper\rbci\data\data_dta\data_final.dta", clear

*willingness to vote for the ruling party
gen vote_oppo_2=-vote_oppo 

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

reghdfe vote_oppo_2 cvg_region_pot dist_cap_max_norm c.dist_cap_max_norm#c.cvg_region_pot dist_sndncap_max_norm $ind_controls $geo_controls if cvg_region_pot>.0272222 & spl==1, absorb(i.country_round) cluster(i.region_time)

generate baseline2=1 if e(sample)
matrix b=e(b)
matrix V=e(V)

matrix b1=e(b2)

matrix b3=e(b3)

scalar b1=b[1,2]
scalar b3=b[1,3]

scalar varb1=V[2,2]
scalar varb3=V[3,3]

scalar covb1b3=V[2,3]

scalar list b1 b3 varb1 varb3 covb1b3

generate MVL= cvg_region_pot

gen conbl=b1+b3*MVL

gen consl=sqrt(varb1+varb3*(MVL^2)+2*covb1b3*MVL) 

gen al=1.96*consl

gen upperl=conbl+al

gen lowerl=conbl-al

*drop lowerl upperl al MVL conbl consl

*********************;
* Generate Rug Plot *;
*********************;

gen where=0.5
gen pipe = "|"

egen tag_distance= tag(cvg_region_pot)
gen yline=0

graph twoway hist MVL if baseline2==1, percent color(gs12%30) yaxis(2) || line conbl MVL, lpattern (solid) clwidth(medium)  clcolor(black) ||   line upperl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort ||   line lowerl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort|| , yscale(noline) xscale(noline) yline(0, lcolor(black))  xtitle("Mobile internet coverage", size(3))xsca(titlegap(2)) ysca(titlegap(2)) ytitle("Marginal effect of distance from the capital", size(3)) scheme(s2mono) graphregion(fcolor(white)) legend(off)

graph export "${mypath}\wp_git\rbci\plots\marginal_effect\vote_oppo.jpg", width(4000)

**** growth_country

use "${mypath}\working_paper\rbci\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

reghdfe growth_country cvg_region_pot dist_cap_max_norm c.dist_cap_max_norm#c.cvg_region_pot dist_sndncap_max_norm $ind_controls $geo_controls if cvg_region_pot>.0272222 & spl==1, absorb(i.country_round) cluster(i.region_time)

generate baseline2=1 if e(sample)
matrix b=e(b)
matrix V=e(V)

matrix b1=e(b2)

matrix b3=e(b3)

scalar b1=b[1,2]
scalar b3=b[1,3]

scalar varb1=V[2,2]
scalar varb3=V[3,3]

scalar covb1b3=V[2,3]

scalar list b1 b3 varb1 varb3 covb1b3

generate MVL= cvg_region_pot

gen conbl=b1+b3*MVL

gen consl=sqrt(varb1+varb3*(MVL^2)+2*covb1b3*MVL) 

gen al=1.96*consl

gen upperl=conbl+al

gen lowerl=conbl-al

*drop lowerl upperl al MVL conbl consl

*********************;
* Generate Rug Plot *;
*********************;

gen where=0.5
gen pipe = "|"

egen tag_distance= tag(cvg_region_pot)
gen yline=0

graph twoway hist MVL if baseline2==1, percent color(gs12%30) yaxis(2) || line conbl MVL, lpattern (solid) clwidth(medium)  clcolor(black) ||   line upperl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort ||   line lowerl MVL, clpattern(longdash) clwidth(thin) clcolor(gs8) sort|| , yscale(noline) xscale(noline) yline(0, lcolor(black))  xtitle("Mobile internet coverage", size(3))xsca(titlegap(2)) ysca(titlegap(2)) ytitle("Marginal effect of distance from the capital", size(3)) scheme(s2mono) graphregion(fcolor(white)) legend(off)

graph export "${mypath}\wp_git\rbci\plots\marginal_effect\growth_country.jpg", width(4000)