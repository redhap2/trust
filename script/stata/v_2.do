capture clear
clear matrix
clear mata
capture log close
set memory 1000m
set maxvar 20000
set matsize 8000
set more off

global mypath "C:\Users\Redha CHABA\Documents"

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

global ind_controls age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road
*bin_unfair_eth: removes observations
global cty_controls gdppc_log area_log vdem_polyarchy cor_index i.color_num i.gov_num
global geo_controls desert_region_tv mountain_region_tv

*t1: pol_trust dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls $geo_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls  $geo_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls $geo_controls bin_unfair_eth if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $geo_controls bin_unfair_eth if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\t1.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*t2 - internet

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

** ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls $geo_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

** first stage

ivreghdfe cvg_region_pot lis_region_tv lis_region_tv_dist dist_cap_max_norm dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 , absorb(i.country_round) cluster(region_time)

boottest  lis_region_tv, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1 = r(p) 
boottest  lis_region_tv lis_region_tv_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2 = r(p) 

outreg2 lis_region_tv lis_region_tv_dist using "${mypath}\wp_git\rbci\tables\v_2\t2_fs.tex",replace bdec(3) pdec(2)  tex nonotes nocons  nor2 adds(obs, e(N), boot lis_region_tv, `aux1', boot lis_region_tv_dist, `aux2') slow(700)

qui ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot  cvg_region_pot_dist =lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls i.country_round  if spl==1, cluster(region_time) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe cvg_region_pot_dist lis_region_tv lis_region_tv_dist dist_cap_max_norm dist_sndncap_max_norm $ind_controls $geo_controls i.country_round  if spl==1, cluster(region_time) 

boottest lis_region_tv, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest lis_region_tv_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 

outreg2 lis_region_tv lis_region_tv_dist using "${mypath}\wp_git\rbci\tables\v_2\t2_fs.tex", append bdec(3) pdec(2)  tex nonotes nocons  nor2 adds(obs, e(N), boot lis_region_tv, `aux1', boot lis_region_tv_dist, `aux2', SW lis_region_tv, `SW1', SW lis_region_tv_dist, `SW2') slow(700)

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot  =lis_region_tv_dist)  dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot)

boottest cvg_region_pot, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
local aux3 =e(estatp)

outreg2 cvg_region_pot using "${mypath}\wp_git\rbci\tables\v_2\t2_fs.tex", append bdec(3) pdec(2)  tex nonotes nocons  nor2 adds(obs, e(N), boot cvg_region_pot, `aux1') slow(700)

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot  cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)

boottest cvg_region_pot, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest cvg_region_pot_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 cvg_region_pot cvg_region_pot_dist using "${mypath}\wp_git\rbci\tables\v_2\t2_fs.tex", append bdec(3) pdec(2)  tex nonotes nocons  nor2 adds(obs, e(N), boot cvg_region_pot, `aux1', boot cvg_region_pot_dist, `aux2') slow(700)

** second stage

eststo iv_fe: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_x_fe iv_fe using "${mypath}\wp_git\rbci\tables\v_2\t2.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*t3 - vote_oppo country_growth

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

*willingness to vote for the ruling party
gen vote_oppo_2=-vote_oppo 

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

eststo iv_fe_vote: ivreghdfe vote_oppo_2 dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_growth: ivreghdfe growth_country dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)

estout iv_fe_vote iv_fe_growth using "${mypath}\wp_git\rbci\tables\v_2\t3.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*t4 - media and institutitons freedom

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

eststo iv_fe_free: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & vdem_med_corrupt>3, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_control: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & vdem_med_corrupt<=3, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_democ: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & e_polity2_mean2>6, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_autoc: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & e_polity2_mean2<=6, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout iv_fe_free iv_fe_control iv_fe_democ iv_fe_autoc using "${mypath}\wp_git\rbci\tables\v_2\t4.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*t5 - educ and urban 

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

eststo educ_low: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm age age_2 i.sex i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road if spl==1 & educ_sec==0, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)

eststo educ_high: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm age age_2 i.sex i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road if spl==1 & educ_sec==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo urban: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm age age_2 i.sex i.educ_sec i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road if spl==1 & bin_rural==0, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)

eststo rural: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm age age_2 i.sex i.educ_sec i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road if spl==1 & bin_rural==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)

estout educ_low educ_high urban rural using "${mypath}\wp_git\rbci\tables\v_2\t5.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend





**APPENDIX

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_int_news_cty: reghdfe internet_news cvg_region_pot dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_int_news_fe: reghdfe internet_news cvg_region_pot dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

eststo ols_int_use_cty: reghdfe internet_use cvg_region_pot dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_int_use_fe: reghdfe internet_use cvg_region_pot dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)


estout ols_int_news_cty ols_int_news_fe ols_int_use_cty ols_int_use_fe using "${mypath}\wp_git\rbci\tables\v_2\A1.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*trust_pres_a dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe trust_pres_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe trust_pres_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe trust_pres_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe trust_pres_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)


estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A2.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*trust_parl_a dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A3.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust dist_cap_log

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A4.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust dist_cap_10

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear


eststo ols_cty: reghdfe pol_trust dist_cap_10 dist_sndncap_10 $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_10 dist_sndncap_10 $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust dist_cap_10 dist_sndncap_10 $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_10 dist_sndncap_10 $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A5.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust dist_cap_mean_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A6.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust i.dist_cap_quint

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust i.dist_cap_quint i.dist_sndncap_quint $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust i.dist_cap_quint i.dist_sndncap_quint $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust i.dist_cap_quint i.dist_sndncap_quint $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust i.dist_cap_quint i.dist_sndncap_quint $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A7.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

use "${mypath}\data\data_dta\df_30_2.dta", clear

eststo bdd_cty_30: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe_30: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

use "${mypath}\data\data_dta\df_50_2.dta", clear

eststo bdd_cty_50: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe_50: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout bdd_cty_30 bdd_fe_30 bdd_cty_50 bdd_fe_50 using "${mypath}\wp_git\rbci\tables\v_2\A8.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust dist_cap_max_norm dist_cap_max_norm_2

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A9.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_cap_max_norm_3

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_cap_max_norm_3 dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_cap_max_norm_3 dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_cap_max_norm_3 dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_cap_max_norm_2 dist_cap_max_norm_3 dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A10.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*tele_news dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe tele_news dist_cap_max_norm dist_sndncap_max_norm age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news radio_news disc_pol_a pres_adm1 distance_to_road $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe tele_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news radio_news disc_pol_a pres_adm1 distance_to_road if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe tele_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news radio_news disc_pol_a pres_adm1 distance_to_road  $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe tele_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news radio_news disc_pol_a pres_adm1 distance_to_road  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A11.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*radio_news dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe radio_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news tele_news disc_pol_a pres_adm1 distance_to_road  $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe radio_news dist_cap_max_norm dist_sndncap_max_norm   age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news tele_news disc_pol_a pres_adm1 distance_to_road  if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe radio_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news tele_news disc_pol_a pres_adm1 distance_to_road  $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe radio_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log paper_news tele_news disc_pol_a pres_adm1 distance_to_road  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A12.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*paper_news dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe paper_news dist_cap_max_norm dist_sndncap_max_norm  age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log radio_news tele_news disc_pol_a pres_adm1 distance_to_road  $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe paper_news dist_cap_max_norm dist_sndncap_max_norm   age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log radio_news tele_news disc_pol_a pres_adm1 distance_to_road if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe paper_news dist_cap_max_norm dist_sndncap_max_norm   age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log radio_news tele_news disc_pol_a pres_adm1 distance_to_road $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe paper_news dist_cap_max_norm dist_sndncap_max_norm   age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log radio_news tele_news disc_pol_a pres_adm1 distance_to_road if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A13.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*internet_news dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe internet_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe internet_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe internet_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe internet_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A14.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*sm_news dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

eststo ols_cty: reghdfe sm_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe sm_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40_2.dta", clear
eststo bdd_cty: reghdfe sm_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe sm_news dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\wp_git\rbci\tables\v_2\A15.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend