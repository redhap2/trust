capture clear
clear matrix
clear mata
capture log close
set memory 1000m
set maxvar 20000
set matsize 8000
set more off

global mypath "C:\Users\Redha CHABA\Documents\Working paper\trust\script"

global ind_controls age age_2 i.sex i.educ_sec i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1
global cty_controls log_gdppc vdem_polyarchy i.color_num corr_index area_log i.gov_num

use "${mypath}\data\data_dta\final_df6.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\final_df6.dta", replace

use "${mypath}\data\data_dta\df_10_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_10_w8_2.dta", replace

use "${mypath}\data\data_dta\df_15_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_15_w8_2.dta", replace

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_20_w8_2.dta", replace

use "${mypath}\data\data_dta\df_25_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_25_w8_2.dta", replace

use "${mypath}\data\data_dta\df_30_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_30_w8_2.dta", replace

use "${mypath}\data\data_dta\df_40_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_40_w8_2.dta", replace

use "${mypath}\data\data_dta\df_50_w8_2.dta", clear
destring, replace
egen color_num=group(color)
egen ea_num=group(EA_unique)
egen gov_num=group(gov_type)
egen iso_num=group(ISO)
egen cluster=group(cluster_frontiere ISO)
egen cluster_bdd=group(region_time murdock_names)
gen mean_pop_log_2=log(1+mean_pop_2)
save "${mypath}\data\data_dta\df_50_w8_2.dta", replace

***** main *****

**** weighted_inst_trust_2 ****

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo ols_cty: reghdfe weighted_inst_trust_2 distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo ols_fe: reghdfe weighted_inst_trust_2 distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_cty: reghdfe weighted_inst_trust_2 distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe weighted_inst_trust_2 distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t1.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


use "${mypath}\data\data_dta\final_df6.dta", clear

eststo all_vote_cty: reghdfe vote_oppo distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo all_vote_fe: reghdfe vote_oppo distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_vote_cty: reghdfe vote_oppo distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_vote_fe: reghdfe vote_oppo distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo all_perf_cty: reghdfe perf_country distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo all_perf_fe: reghdfe perf_country distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_perf_cty: reghdfe perf_country distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_perf_fe: reghdfe perf_country distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout all_vote_cty all_vote_fe bdd_vote_cty bdd_vote_fe all_perf_cty all_perf_fe bdd_perf_cty bdd_perf_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t1b.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend



use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo ols_x_fe: reghdfe weighted_inst_trust_2 c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)
eststo iv_fe: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo bdd_x_fe: reghdfe weighted_inst_trust_2 c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_iv_fe: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd) endog(pot_cvg pot_cvg_dist) ffirst

estout ols_x_fe iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

ivreghdfe pot_cvg mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time)

boottest  mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1 = r(p) 
boottest  mean_flash_tv mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2 = r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_all",replace bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2') slow(700)

qui ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist =mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe pot_cvg_dist mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) 

boottest mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_all", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2', SW mean_flash_tv, `SW1', SW mean_flash_tv_dist, `SW2') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  =mean_flash_tv_dist)  distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time) endog(pot_cvg)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
local aux3 =e(estatp)

outreg2 pot_cvg using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_all", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_all", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2') slow(700)



use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv


ivreghdfe pot_cvg mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd)

boottest  mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1 = r(p) 
boottest  mean_flash_tv mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2 = r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_bdd",replace bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2') slow(700)

qui ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist =mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe pot_cvg_dist mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) 

boottest mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
boottest mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2=r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2', SW mean_flash_tv, `SW1', SW mean_flash_tv_dist, `SW2') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  =mean_flash_tv_dist)  distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) endog(pot_cvg)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
local aux3=e(estatp)

outreg2 pot_cvg using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons nor2 adds(obs, e(N), boot pot_cvg, `aux1') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) endog(pot_cvg pot_cvg_dist)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
boottest pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t2_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2') slow(700)


use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv


eststo all_vote: ivreghdfe vote_oppo distance_cap_max_norm (pot_cvg pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo all_perf: ivreghdfe perf_country distance_cap_max_norm (pot_cvg pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst



estout all_vote all_perf using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t3.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Distance from the capital") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend






***** heterogeneity *****

**** vdem_med_free ****

*** weighted_inst_trust_2 ***

use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo iv_fe_free: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if vdem_med_free>=2.513, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo iv_fe_control: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if vdem_med_free<2.513, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout  iv_fe_free iv_fe_control using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t4.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Distance from the capital") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend




**** vdem_polyarchy ****

*** weighted_inst_trust_2 ***

use "${mypath}\data\data_dta\final_df6.dta", clear


gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo iv_fe_democ: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if vdem_polyarchy>0.513, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo iv_fe_autoc: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if vdem_polyarchy<=0.513, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout iv_fe_democ iv_fe_autoc  using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t4b.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Distance from the capital") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend



**** educ_sec ****

use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo educ_low: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm age age_2 i.sex i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if educ<3, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo educ_high: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm  age age_2 i.sex i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1  if educ>=3, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst



**** rural ****
eststo urban: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist) distance_sndncap_max_norm age age_2 i.sex i.educ_sec i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if rural==1, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo rural: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist) distance_sndncap_max_norm age age_2 i.sex i.educ_sec i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if rural==2, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst


**** age ****
gen age_group = .
replace age_group = 1 if age >= 18 & age <= 25
replace age_group = 2 if age >= 26 & age <= 35
replace age_group = 3 if age >= 36 & age <= 45
replace age_group = 4 if age >= 46

label define age_groups 1 "18-25" 2 "26-35" 3 "36-45" 4 "46+"
label values age_group age_groups

eststo one: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm i.sex i.educ_sec i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if age_group==1, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo two: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm i.sex i.educ_sec i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if age_group==2, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo three: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm i.sex i.educ_sec i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if age_group==3, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo four: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm i.sex i.educ_sec i.rural i.bin_conditions_eco i.bin_conditions_country i.emp mean_night_log mean_pop_log area_region_log tele_news journal_news radio_news disc_pol unfair_eth_bin pres_adm1 if age_group==4, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst


estout educ_low educ_high urban rural one two three four  using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t4c.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Distance from the capital") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend




**** trust gen - trad ****

use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo inst: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if round==5|round==8, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

eststo gen: ivreghdfe trust_gen distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls if round==5|round==8, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout inst gen using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t4e.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Distance from the capital") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

**** Heterogeneity national trust

*** weighted_inst_trust (pres+parl+elec)

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo ols_cty: reghdfe weighted_inst_trust distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo ols_fe: reghdfe weighted_inst_trust distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_cty: reghdfe weighted_inst_trust distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe weighted_inst_trust distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)


use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo ols_x_fe: reghdfe weighted_inst_trust c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)
eststo iv_fe: ivreghdfe weighted_inst_trust distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst


estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t5a.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*** trust_pres

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo ols_cty: reghdfe trust_pres distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo ols_fe: reghdfe trust_pres distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear


eststo bdd_cty: reghdfe trust_pres distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe trust_pres distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)


use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo ols_x_fe: reghdfe trust_pres c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)
eststo iv_fe: ivreghdfe trust_pres distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t5b.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend



*** trust_parl

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo ols_cty: reghdfe trust_parl distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo ols_fe: reghdfe trust_parl distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_cty: reghdfe trust_parl distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe trust_parl distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)


use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo ols_x_fe: reghdfe trust_parl c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)
eststo iv_fe: ivreghdfe trust_parl distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t5c.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*** trust_elec

use "${mypath}\data\data_dta\final_df6.dta", clear

eststo ols_cty: reghdfe trust_elec distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
eststo ols_fe: reghdfe trust_elec distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

eststo bdd_cty: reghdfe trust_elec distance_cap_max_norm distance_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe trust_elec distance_cap_max_norm distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

use "${mypath}\data\data_dta\final_df6.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv

eststo ols_x_fe: reghdfe trust_elec c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)
eststo iv_fe: ivreghdfe trust_elec distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(pot_cvg pot_cvg_dist) ffirst

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t5d.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend




*** IV BDD

use "${mypath}\data\data_dta\df_20_w8_2.dta", clear

gen pot_cvg_dist=distance_cap_max_norm*pot_cvg
gen mean_flash_tv=mean_flash*tv
gen mean_flash_tv_dist=distance_cap_max_norm*mean_flash_tv


eststo bdd_x_fe: reghdfe weighted_inst_trust_2 c.distance_cap_max_norm##c.pot_cvg distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_iv_fe: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd) endog(pot_cvg pot_cvg_dist) ffirst

estout bdd_x_fe bdd_iv_fe using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t6.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

ivreghdfe pot_cvg mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd)

boottest  mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1 = r(p) 
boottest  mean_flash_tv mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2 = r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t6_first_stage_bdd.tex",replace bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2') slow(700)

qui ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist =mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe pot_cvg_dist mean_flash_tv mean_flash_tv_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) 

boottest mean_flash_tv, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
boottest mean_flash_tv_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2=r(p) 

outreg2 mean_flash_tv mean_flash_tv_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t6_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot mean_flash_tv, `aux1', boot mean_flash_tv_dist, `aux2', SW mean_flash_tv, `SW1', SW mean_flash_tv_dist, `SW2') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  =mean_flash_tv_dist)  distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) endog(pot_cvg)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
local aux3=e(estatp)

outreg2 pot_cvg using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t6_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons nor2 adds(obs, e(N), boot pot_cvg, `aux1') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (pot_cvg  pot_cvg_dist = mean_flash_tv mean_flash_tv_dist)  distance_sndncap_max_norm $ind_controls i.country_round i.murdock_names, cluster(cluster_bdd) endog(pot_cvg pot_cvg_dist)

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux1=r(p) 
boottest pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(cluster_bdd)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t6_first_stage_bdd", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2') slow(700)



*** internet coverage - internet news


use "${mypath}\data\data_dta\final_df6.dta", clear

gen internet_dist=distance_cap_max_norm*internet_news
gen pot_cvg_dist=distance_cap_max_norm*pot_cvg

eststo ols_x_fe: reghdfe weighted_inst_trust_2 c.distance_cap_max_norm##c.internet_news distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

eststo internet_iv: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (internet_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(internet_news internet_dist) ffirst

estout ols_x_fe internet_iv using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t7.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

ivreghdfe internet_news pot_cvg pot_cvg_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time)

boottest  pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1 = r(p) 
boottest  pot_cvg pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2 = r(p) 

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t7_first_stage",replace bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2') slow(700)

qui ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (internet_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe internet_dist pot_cvg pot_cvg_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) 

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t7_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2', SW pot_cvg, `SW1', SW pot_cvg_dist, `SW2') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (internet_news  =pot_cvg_dist)  distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time) endog(internet_news)

boottest internet_news, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
local aux3 =e(estatp)

outreg2 internet_news using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t7_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot internet_news, `aux1') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (internet_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(internet_news internet_dist) ffirst

boottest internet_news, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest internet_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 internet_news internet_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t7_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot internet_news, `aux1', boot internet_dist, `aux2') slow(700)

*** internet coverage - social media news

use "${mypath}\data\data_dta\final_df6.dta", clear

gen internet_dist=distance_cap_max_norm*sm_news
gen pot_cvg_dist=distance_cap_max_norm*pot_cvg

eststo ols_x_fe: reghdfe weighted_inst_trust_2 c.distance_cap_max_norm##c.sm_news distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

eststo internet_iv: ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (sm_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(sm_news internet_dist) ffirst

estout ols_x_fe internet_iv using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t8.tex", replace style(tex) varlabels(_cons constant distance_cap_max_norm "Isolation from the capital city") cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


ivreghdfe sm_news pot_cvg pot_cvg_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time)

boottest  pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1 = r(p) 
boottest  pot_cvg pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2 = r(p) 

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t8_first_stage",replace bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2') slow(700)

qui ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (sm_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) ffirst 
cap matrix drop first
matrix first = e(first)   
matrix list first
cap drop SW*
cap drop AR*
local SW1= el(first,8,1)
local SW2= el(first,8,2)

ivreghdfe internet_dist pot_cvg pot_cvg_dist distance_cap_max_norm distance_sndncap_max_norm $ind_controls i.country_round , cluster(region_time) 

boottest pot_cvg, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest pot_cvg_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 

outreg2 pot_cvg pot_cvg_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t8_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot pot_cvg, `aux1', boot pot_cvg_dist, `aux2', SW pot_cvg, `SW1', SW pot_cvg_dist, `SW2') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (sm_news  =pot_cvg_dist)  distance_cap_max_norm distance_sndncap_max_norm $ind_controls , absorb(i.country_round) cluster(region_time) endog(sm_news)

boottest sm_news, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
local aux3 =e(estatp)

outreg2 sm_news using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t8_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot sm_news, `aux1') slow(700)

ivreghdfe weighted_inst_trust_2 distance_cap_max_norm (sm_news internet_dist = pot_cvg pot_cvg_dist)  distance_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(region_time) endog(sm_news internet_dist) ffirst

boottest sm_news, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux1=r(p) 
boottest internet_dist, noci   seed(121237)  boottype(wild) cluster(region_time)
local aux2=r(p) 
local aux3 =e(estatp)

outreg2 sm_news internet_dist using "C:\Users\Redha CHABA\Documents\Working paper\Trust\Script\tables\v_0\v_0\t8_first_stage", append bdec(3) pdec(2) excel tex nonotes nocons  nor2 adds(obs, e(N), boot sm_news, `aux1', boot internet_dist, `aux2') slow(700)
