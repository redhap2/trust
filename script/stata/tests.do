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


noisily{
reghdfe growth_country 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_crime     	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_corr      	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_educ   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_elect  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_health 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_ineq   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_job    	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_local  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_parl   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_pres   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_price  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_road   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_water  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_trad   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_poor   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_mean   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
}                                                                              


noisily{
reghdfe corr_parl_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe corr_pres_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe pol_corr 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe corr_local_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe corr_trad_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe corr_level 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
}


noisily{
reghdfe pol_trust c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
}

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv


noisily{
	cls
ivreghdfe growth_country	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_eco 			dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_crime  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_corr   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_educ   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_elect  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_health 		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_ineq   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_job    		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_local  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_parl   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_pres   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_price  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_road   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_water  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_trad   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_poor   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_mean   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}


noisily{
	cls
ivreghdfe growth_country	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_eco 			dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_crime  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_corr   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_educ   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_elect  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_health 		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_ineq   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_job    		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_local  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_parl   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_pres   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_price  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_road   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_water  		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_trad   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_poor   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe perf_mean   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}


noisily{
	cls
ivreghdfe corr_parl_a    		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe corr_pres_a    		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe pol_corr 	   			dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe corr_local_a   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe corr_trad_a    		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe corr_level 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}

noisily{
	cls
ivreghdfe bin_check_citiz 	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe bin_check_parl 	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe assoc_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe commu_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe prob_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe elec_fair_a 	   	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe pref_demo_a 	   	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe protest_a 	   	dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe bin_vote 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}










**cty
noisily{
	cls
reghdfe growth_country	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_eco 			dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_crime  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_corr   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_educ   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_elect  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_health 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_ineq   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_job    		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_local  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_parl   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_pres   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_price  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_road   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_water  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_trad   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_poor   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
reghdfe perf_mean   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round, cluster(i.region_time)
}

**fe
noisily{
	cls
reghdfe growth_country	dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_eco 			dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_crime  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_corr   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_educ   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_elect  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_health 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_ineq   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_job    		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_local  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_parl   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_pres   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_price  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_road   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_water  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_trad   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_poor   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe perf_mean   		dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
}

*perf
**cty
noisily{
	cls
reghdfe growth_country  dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_eco  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_crime  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_corr   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_educ   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_elect  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_health 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_ineq   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_job    	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_local  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_parl   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_pres   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_price  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_road   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_water  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_trad   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_poor  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_mean  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
}

**fe
noisily{
	cls
reghdfe growth_country  dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_eco  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_crime  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_corr   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_educ   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_elect  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_health 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_ineq   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_job    	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_local  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_parl   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_pres   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_price  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_road   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_water  	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_trad   	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_poor  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf_mean  		dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
}


noisily{
reghdfe corr_parl_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe corr_pres_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe pol_corr 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe corr_local_a	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe corr_trad_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe corr_level 		dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls, absorb(i.round i.murdock_names) cluster(cluster_bdd)
}



reghdfe perf_road dist_cap_max_norm dist_sndncap_max_norm $ind_controls, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

reghdfe feelnat dist_cap_max_norm dist_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe perf dist_cap_max_norm dist_sndncap_max_norm $ind_controls, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)




ivreghdfe perf_road dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)



**********
* table perf

use "${mypath}\data\data_dta\data_final.dta", clear

eststo all_elect: reghdfe perf_elect dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
eststo all_road: reghdfe perf_road dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
eststo all_local: reghdfe perf_local dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
eststo all_trad: reghdfe perf_trad dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_elect: reghdfe perf_elect dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_road: reghdfe perf_road dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_local: reghdfe perf_local dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_trad: reghdfe perf_trad dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

****
use "${mypath}\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

noisily{
	cls
reghdfe satis_demo_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe extent_a     	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe elec_fair_a      	dist_cap_max_norm dist_sndncap_max_norm $ind_controls  if spl==1, absorb(i.country_round) cluster(i.region_time)
}   
                                                                           
use "${mypath}\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

noisily{
	cls
ivreghdfe satis_demo_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)
ivreghdfe extent_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe elec_fair_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}

use "${mypath}\data\data_dta\df_40_2.dta", clear

noisily{
	cls
reghdfe satis_demo_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe extent_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe elec_fair_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth  if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
}





use "${mypath}\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

noisily{
	cls
reghdfe satis_demo_a 	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls  if spl==1, absorb(i.round) cluster(i.region_time)
reghdfe extent_a     	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls  if spl==1, absorb(i.round) cluster(i.region_time)
reghdfe elec_fair_a      	dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls  if spl==1, absorb(i.round) cluster(i.region_time)
}   
                                                                           
use "${mypath}\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

noisily{
	cls
ivreghdfe satis_demo_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist)
ivreghdfe extent_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
ivreghdfe elec_fair_a 	   		dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $cty_controls if spl==1, absorb(i.round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}

use "${mypath}\data\data_dta\df_40_2.dta", clear

noisily{
	cls
reghdfe satis_demo_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth $cty_controls  if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe extent_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth $cty_controls  if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
reghdfe elec_fair_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls i.bin_unfair_eth $cty_controls  if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
}






use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

noisily{
	cls
reghdfe bin_trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
reghdfe bin_trust_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_pol_trust_2 dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_corr_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
reghdfe bin_corr_parl_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_pol_corr_2 dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
}

noisily{
	cls
reghdfe bin_trust_parl_a c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_trust_pres_a c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_pol_trust_2 c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_corr_parl_a c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_corr_pres_a c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe bin_pol_corr_2 c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
}

noisily{
	cls
ivreghdfe bin_trust_parl_a dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst
ivreghdfe bin_trust_pres_a dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst
ivreghdfe bin_pol_trust_2 dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe bin_corr_parl_a dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst
ivreghdfe bin_corr_pres_a dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst
ivreghdfe bin_pol_corr_2 dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist) dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

}



*t1: pol_trust dist_cap_log

use "${mypath}\data\data_dta\data_final_r.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_log*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_log*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_log##c.cvg_region_pot dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap_log (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend








*t1: pol_trust dist_cap

use "${mypath}\data\data_dta\data_final_r.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap dist_sndncap $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap dist_sndncap $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap dist_sndncap $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap##c.cvg_region_pot dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend








*t1: neig_eth_a dist_cap_max_norm

use "${mypath}\data\data_dta\data_final_r.dta", clear

global ind_controls age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_conditions_country i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1
*bin_unfair_eth: removes observations
global cty_controls gdppc_log area_log vdem_polyarchy cor_index i.color_num i.gov_num

noisily{
	cls
eststo ols_cty: reghdfe neig_eth_a cvg_region_pot $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe neig_eth_a cvg_region_pot $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
}

*internet

gen lis_region_tv=lis_region*tv

*iv
noisily{
	cls

eststo iv_fe: ivreghdfe neig_eth_a (cvg_region_pot = lis_region_tv) $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot) ffirst
}













use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*internet_news
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

ivreghdfe pol_trust dist_cap_max_norm (internet_news cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(internet_news cvg_region_pot_dist) 






*2
*pol_trust dist_cap_log

use "${mypath}\data\data_dta\data_final_r.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_log dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_log*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_log*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_log##c.cvg_region_pot dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap_log (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_log $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend


*pol_trust dist_cap

use "${mypath}\data\data_dta\data_final_r.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap dist_sndncap $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap dist_sndncap $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap dist_sndncap $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap##c.cvg_region_pot dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend



*pol_trust dist_cap_mean_norm

use "${mypath}\data\data_dta\data_final_r.dta", clear

eststo ols_cty: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls $cty_controls i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_cty: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls $cty_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_mean_norm dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_mean_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_mean_norm*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_mean_norm##c.cvg_region_pot dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap_mean_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend



*internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_mean_norm*cvg_region_pot
gen internet_news_dist=dist_cap_mean_norm*internet_news_adm2
gen internet_use_dist=dist_cap_mean_norm*internet_use_adm2
gen sm_news_dist=dist_cap_mean_norm*sm_news_adm2
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_mean_norm*lis_region_tv

*ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_mean_norm##c.internet_news dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

*iv

eststo iv_fe: ivreghdfe pol_trust dist_cap_mean_norm (internet_use_adm2 internet_use_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_mean_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(internet_use_adm2 internet_use_dist) 

estout ols_cty ols_fe bdd_cty bdd_fe ols_x_fe iv_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend








use "${mypath}\data\data_dta\data_final_r.dta", clear

cls
eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1 & p_polity>5, absorb(i.country_round) cluster(i.region_time)

eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1 & p_polity<=5, absorb(i.country_round) cluster(i.region_time)


use "${mypath}\data\data_dta\df_40_2.dta", clear

eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1 & p_polity>5, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1 & p_polity<=5, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

estout ols_cty ols_fe bdd_cty bdd_fe using "${mypath}\tables\v_1\t1.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend

*t2 - internet

use "${mypath}\data\data_dta\data_final_r.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

** ols interaction

eststo ols_x_fe: reghdfe pol_trust c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1 & p_polity<=6, absorb(i.country_round) cluster(i.region_time)



***Detachment from national politics

use "${mypath}\data\data_dta\data_final_r.dta", clear

noisily{
	cls
reghdfe vote_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe feelnat dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe assoc_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe commu_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
reghdfe prob_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)
}


use "${mypath}\data\data_dta\df_40_2.dta", clear

noisily{
cls	
reghdfe vote_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe assoc_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe commu_a dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
reghdfe prob_a  dist_cap_max_norm dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)
}







global mypath "C:\Users\Redha CHABA\Documents\working_paper\trust"

use "${mypath}\data\data_dta\data_27_02_25.dta", clear



global ind_controls age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_conditions_country i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road
*bin_unfair_eth: removes observations
global cty_controls gdppc_log area_log vdem_polyarchy cor_index i.color_num i.gov_num


gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

** ols interaction

noisily{
	cls

reghdfe pol_trust c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(i.region_time)

reghdfe pol_trust c.dist_cap_max_norm##c.cvg_region_pot dist_sndncap_max_norm $ind_controls desert_region elevation_region mountain_region precipitation_region temp_max_region temp_min_region temp_mean_region if spl==1, absorb(i.country_round) cluster(i.region_time)
}
** first stage
gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

gen desert_region_tv=desert_region*tv
gen mountain_region_tv=mountain_region*tv


gen precipitation_region_tv=precipitation_region*tv
gen temp_max_region_tv=temp_max_region*tv
gen temp_min_region_tv=temp_min_region*tv
gen temp_mean_region_tv=temp_mean_region*tv
gen elevation_region_tv=elevation_region*tv
gen mountain_region_tv=mountain_region*tv

noisily{
	cls
ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst
}


ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls desert_region_tv elevation_region_tv mountain_region_tv precipitation_region_tv temp_mean_region_tv temp_max_region_tv temp_min_region_tv if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls desert_region elevation_region mountain_region if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls desert_region_tv elevation_region_tv mountain_region_tv if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst

ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls desert_region_tv mountain_region_tv if spl==1, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) ffirst









use "${mypath}\working_paper\trust\data\data_dta\data_27_02_25.dta", clear

gen desert_region_tv=desert_region*tv
gen mountain_region_tv=mountain_region*tv

global ind_controls age age_2 i.sex i.educ_sec i.bin_rural i.bin_conditions_eco i.bin_emp night_region_log pop_region_log area_region_log tele_news paper_news radio_news disc_pol_a pres_adm1 distance_to_road
*bin_unfair_eth: removes observations
global cty_controls gdppc_log area_log vdem_polyarchy cor_index i.color_num i.gov_num
global geo_controls desert_region_tv mountain_region_tv
global bdd_controls distance_border_km distance_border_km2 distance_border_km3 bin_unfair_eth

*t1: pol_trust dist_cap_max_norm

use "${mypath}\working_paper\trust\data\data_dta\data_27_02_25.dta", clear
gen desert_region_tv=desert_region*tv
gen mountain_region_tv=mountain_region*tv

eststo ols_cty: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls $geo_controls bin_unfair_eth i.round if spl==1, cluster(i.region_time)
eststo ols_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $geo_controls bin_unfair_eth if spl==1, absorb(i.country_round) cluster(i.region_time)

use "${mypath}\working_paper\trust\data\data_dta\df_40.dta", clear
gen desert_region_tv=desert_region*tv
gen mountain_region_tv=mountain_region*tv

eststo bdd_cty: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $cty_controls $bdd_controls $geo_controls if spl==1, absorb(i.round i.murdock_names) cluster(cluster_bdd)
eststo bdd_fe: reghdfe pol_trust dist_cap_max_norm dist_sndncap_max_norm $ind_controls $bdd_controls $geo_controls if spl==1, absorb(i.country_round i.murdock_names) cluster(cluster_bdd)

noisily{
estout ols_cty ols_fe bdd_cty bdd_fe, replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend
}














*t4 - media and institutitons freedom

use "${mypath}\working_paper\trust\data\data_dta\data_final.dta", clear

gen cvg_region_pot_dist=dist_cap_max_norm*cvg_region_pot
gen lis_region_tv=lis_region*tv
gen lis_region_tv_dist=dist_cap_max_norm*lis_region_tv

eststo iv_fe_free: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & med_corr_mean>  2.57 , absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_control: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & med_corr_mean<=  2.545 , absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 




eststo iv_fe_democ: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & e_polity2_mean2>6, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

eststo iv_fe_autoc: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & e_polity2_mean2<=6, absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

estout iv_fe_free iv_fe_control iv_fe_democ iv_fe_autoc using "${mypath}\wp_git\rbci\tables\v_2\t4.tex", replace style(tex) cells(b(star fmt(3)) se(par fmt(2))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2_a, fmt(0 3)) margin legend





sum v2xedvd_inpt_mean2 v2x_polyarchy_mean2 v2xedvd_me_cent_mean2 v2medstateprint_mean2 v2medstatebroad_mean2 v2medpolstate_mean2 v2medpolnonstate_mean2 e_v2x_freexp_altinf_3C_mean2 e_v2x_freexp_altinf_4C_mean2 e_v2x_freexp_altinf_5C_mean2 v2x_freexp_mean2 v2xme_altinf_mean2 if spl==1, d


noisily{
cls
eststo iv_fe_control: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & v2x_freexp_mean2>=.7370329  , absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 
}


eststo iv_fe_control: ivreghdfe pol_trust dist_cap_max_norm (cvg_region_pot cvg_region_pot_dist = lis_region_tv lis_region_tv_dist)  dist_sndncap_max_norm $ind_controls $geo_controls if spl==1 & v2medpolstate_mean2>0.566  , absorb(i.country_round) cluster(region_time) endog(cvg_region_pot cvg_region_pot_dist) 

gen  altinf_ctrl=-v2xme_altinf_mean2


