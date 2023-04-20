#C Black sea bass assessment for spatial and seasonal model, 2022 implementation of Fay/Cadrin/McNamee 2016 model in 3.24u
#C area 1 = inshore N, area 2 = inshore S
#C_SS-V3.30.20

0 #read weight at age file
2  #_N_Growth_Patterns, one for north, one for south
1 #_N_Platoons_Within_GrowthPattern 

3 #_recruitment distribution method
1 #_spawner-recruitment
2 #  N recruitment settlement assignments designs goes here if N_GP*nseas*area>1, so gives two recruitment patterns because 2 areas
0 #  placeholder for recruitment interaction request
#_growth pattern settlement
#GP Mth Area age@settlement
1 10 1 0  
2 10 2 0 

2 #_Cond 0 # N_movement_definitions goes here if N_areas > 1
1.0 #_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
1 1 2 1 21 25   
2 1 1 2 21 25   

2 #_Nblock_patterns
1 1 #_blocks_per_pattern
# begin and end years of blocks
#1989 1997 1998 2001  #for trawl
1989 1997
2009 2016
# 1995 2002 2003 2007

1 #_block deviation adjust method
0 0 0 0 0 #autogen of time-varying params (1= no autogen)
#1 1 1 1 1 #autogen of time-varying params (1= no autogen)

0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#2 #_N_breakpoints
# 4 4 # age(real) at M breakpoints

1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=not implemented; 4=not implemented
0.75 #_Growth_Age_for_L1  (need to check val)
999 #_Growth_Age_for_L2 (999 to use as Linf)
0.2 #_exponential decay for growth above max age
0 #_placeholder
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A)

1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity
#_placeholder for empirical age-maturity by growth pattern
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b

1 #_Hermaphroditism: 0=no, 1=fem to male
#_Cond additional params for hermaphroditism
-1 #Hermaphroditism season, -1=end of each season, <positive integer>=to select one season
1 #Inclue males in spawning biomass 0=no males in SSB, 1=simple add of males to females, xx - more options to come...


2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#1 #_env/block/dev_adjust_method (1=standard; 2=with logistic trans to keep within base parm bounds)


#_LO HI INIT PRIOR SD PR_type PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn         
#female, growth pattern 1                   
0.1 0.45 0.4 0.25 99 0 -6 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP:1_       
1 20 9.26 10 99 0 -1 0 0 0 0 0 0 0 # Lmin-Fem_GP_1_       
40 100 65 65 99 0 5 0 0 0 0 0 0 0 # Lmax-Fem_GP_1_       
0.02 0.65 0.18 0.18 99 0 4 0 0 0 0 0 0 0 # VBK-Fem_GP_1_       
0.01 0.5 0.25 0.3 99 0 4 0 0 0 0 0 0 0 # CV_yng-Fem_GP_1_       
0.01 0.5 0.01 0.04 99 0 -4 0 0 0 0 0 0 0 # CV_old       
-3 3 1.08E-05 0 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen1-Fem       
-3 4 3.062 3 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen2-Fem       
-10 100 20.79 1 0.8 0 -3 0 0 0 0 0 0 0 # Mat50-Fem       
-10 10 -0.576 -1 0.8 0 -3 0 0 0 0 0 0 0 # Matslp-Fem       
-3 3 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs1-Fem       
-3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # Eggs2-Fem       
#female, growth pattern 2                   
-3 3 0 0 0.8 6 -3 0 0 0 0 0.5 0 0 # natM_for_M_offset_mal=female*exp(male_param)
-3 3 -0.24 -0.24 99 6 -4 0 0 0 0 0.5 0 0 # Lmin_M      
-3 3 0 0 99 6 -4 0 0 0 0 0.5 0 0 # Lmax_M      
-3 3 0 0 99 6 4 0 0 0 0 0.5 0 0 # VBK_M      
-3 3 0 0 99 6 -4 0 0 0 0 0.5 0 0 # CV-yng_M      
-3 3 0 0 99 6 -5 0 0 0 0 0.5 0 0 # CV-old_M      
-3 3 1.08E-05 0 0.8 6 -3 0 0 0 0 0.5 0 0 # Wtlen1-Fem       
-3 4 3.062 3 0.8 6 -3 0 0 0 0 0.5 0 0 # Wtlen2-Fem     
-10 100 20.79 1 0.8 6 -3 0 0 0 0 0.5 0 0 # Mat50-Fem       
-10 10 -0.576 -1 0.8 6 -3 0 0 0 0 0.5 0 0 # Matslp-Fem     
-3 3 1 1 0.8 6 -3 0 0 0 0 0.5 0 0 # Eggs1-Fem       
-3 3 0 0 0.8 6 -3 0 0 0 0 0.5 0 0 # Eggs2-Fem     
#_male, growth pattern 1                   
-3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # natM_for_M_offset_mal=female*exp(male_param)
-3 3 0 0 99 0 -5 0 0 0 0 0 0 0 # Lmin_M      
-3 3 0 0 99 0 -5 0 0 0 0 0 0 0 # Lmax_M      
-3 3 0 0 99 0 5 0 0 0 0 0 0 0 # VBK_M     
-3 3 0 0 99 0 -5 0 0 0 0 0 0 0 # CV-yng_M      
-3 3 0 0 99 0 5 0 0 0 0 0 0 0 # CV-old_M      
-3 3 1.08E-05 0 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen1-Mal       
-3 4 3.062 3 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen2-Mal param
#_male, growth pattern 2                   
-3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # natM_for_M_offset_mal=female*exp(male_param)
-3 3 -0.24 -0.24 99 0 -5 0 0 0 0 0 0 0 # Lmin_M      
-3 3 0 0 99 0 -5 0 0 0 0 0 0 0 # Lmax_M      
-3 3 0 0 99 0 5 0 0 0 0 0 0 0 # VBK_M     
-3 3 0 0 99 0 -5 0 0 0 0 0 0 0 # CV-yng_M      
-3 3 0 0 99 0 5 0 0 0 0 0 0 0 # CV-old_M      
-3 3 1.08E-05 0 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen1-Mal       
-3 4 3.062 3 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen2-Mal       
#Hermaphroditism parameters                    
# inflection about 4                   
0 20 4 4 99 0 7 0 0 0 0 0 0 0 # Inflection_age_for_fem-male    
# std deviation in age                 
0.1 10 2 2 99 0 7 0 0 0 0 0 0 0 # std_dev_(in age)_for_distribution_of_fem-male
0.2 1 0.99 0.95 0.8 0 -3 0 0 0 0 0 0 0 # asymptotic_rate      

#C Recruitment distributions
#C RecrDist-settlement-1_
 -8 8 -1.1 0 99 0 2 0 2 1989 2014 5 0 0 # 
#C RecrDist-settlement-2_
 -4 4 -4 0 99 0 -1 0 0 0 0 0.5 0 0 # 
#Cohort growth dev
 0.1 3 1 1 99 0 -3 0 0 0 0 0.5 0 0#CohortGrowDev

#C Movement parameters
 -15 15 15 0 99 0 5 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_1from_2to_1
 -15 15 -15 0 99 0 -3 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_1from_2to_1
 -15 15 -0.5 0 99 0 2 0 0 0 0 0 0 0 # MoveParm_A_seas_2_GP_1from_1to_2
 -15 15 -15 0 99 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_2_GP_1from_1to_2 

#0.63 #_fracfemale  #0.37 are male (OJensen 2015/12/01)
1e-006 0.999999 0.63 0.63 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
1e-006 0.999999 0.63 0.63 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_2


# 0  #custom_MG-env_setup (0/1)
# -2 2 0 0 -1 99 -2 #_placeholder for no MG-environ parameters

#_seasonal_effects_on_biology_parms
#C possibly include this for w-l relationships
 1 1 0 0 0 0 1 1 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K

 -2 2 0 0 99 -1 -2 
 -2 2 0.38344 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 -0.034812 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 0.38344 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 -0.034812 0 99 -1 -2 #_placeholder for no seasonal MG parameters

# -2 2 0 0 -1 99 -2 #_placeholder for no MG dev parameters

#5 # placeholder for #_MGparm_Dev_Phase

#_Spawner-Recruitment
3 #_SR_function
1 #_equilibrium recruitment (0=none; 1=use steepness)
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             3            20            12            12            99             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1          0.95          0.75           0.2             6         -5          0          0          0          0          0          0          0 # SR_BH_steep
            -2             2           0.7           0.7            99             6         -3          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             6         -4          0          0          0          0          0          0          0 # SR_regime
             0           0.5             0             0            99             0         -3          0          0          0          0          0          0          0 # SR_autocorr

1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1987 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -3 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1965 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1988 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2012 #_last_yr_fullbias_adj_in_MPD
 2020 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 0.98 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -15 #min rec_dev
 15 #max rec_dev
 0 #_read_recdevs

# read specified recr devs
#_Yr Input_value

#Fishing Mortality info 
0.2 # F ballpark for tuning early phases
2009 # F ballpark year
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
3.99  # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# read overall start F value; overall phase; N detailed inputs to read for Fmethod 2
 7 # read N iterations for tuning for Fmethod 3 (recommend 3 to 7)
#Fleet Year Seas F_value se phase (for detailed setup of F_Method=2)


#_initial_F_parms
#_LO    HI  INIT    PRIOR   PR_type SD  PHASE
0 1 0.2 0 99 0 1 # InitF_1_
0 1 0.2 0 99 0 1 # InitF_2_
0 1 0.2 0 99 0 1 # InitF_3_
0 1 0.2 0 99 0 1 # InitF_4_
0 1 0.2 0 99 0 1 # InitF_5_
0 1 0.2 0 99 0 1 # InitF_6_
0 1 0.2 0 99 0 1 # InitF_7_
0 1 0.2 0 99 0 1 # InitF_8_
0 1 0.2 0 99 0 1 # InitF_9_
0 1 0.2 0 99 0 1 # InitF_10_
0 1 0.2 0 99 0 1 # InitF_11_
0 1 0.2 0 99 0 1 # InitF_12_


#_Q_setup
#_1:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm)
#_2:  extra input for link, i.e. mirror fleet
#_3:  0/1 to select extra sd parameter
#_4:  0/1 for biasadj or not
#_5:  0/1 to float
#fleet type info extrasd bias_adj float   
13 3 0 0 1 0 #MA_Spr  
14 3 0 0 1 0 #MA_Fll  
15 3 0 0 1 0 #MA_1  
16 3 0 0 1 0 #RI_Spr  
17 3 0 0 1 0 #RI_1  
18 3 0 0 1 0 #CT_Spr  
19 3 0 0 1 0 #CT_1  
20 3 0 0 1 0 #NY_1  
21 3 0 0 1 0 #NJ_Spr  
22 3 0 0 1 0 #NJ_1  
23 3 0 0 1 0 #DE_1  
24 3 0 0 1 0 #MD_1  
25 3 0 0 1 0 #VIMS_1  
26 3 0 0 1 0 #NEAMAP_N_Spr 
27 3 0 0 1 0 #NEAMAP_S_Spr 
28 3 0 0 1 0 #NEAMAP_Sth_Spr_1
29 3 0 0 1 0 #NEAMAP_N_Fall 
30 3 0 0 1 0 #NEAMAP_S_Fall 
31 3 0 0 1 0 #Alb_Nrth_Spr 
32 3 0 0 1 0 #Alb_Sth_Spr 
#33 1 0 0 1 1 #Dummy   
#34 1 0 0 1 1 #Dummy
35 3 0 0 1 0 #Bigelow_Spr_Nrth 
36 3 0 0 1 0 #Bigelow_Spr_Sth 
37 3 0 0 1 0 #NEFSC_Wint_Nrth 
38 3 0 0 1 0 #NEFSC_Wint_Sth 
39 3 0 0 1 0 #GS_Index  
40 3 0 0 1 0 #MRIP_CPUE_Nrth_Spr
41 3 0 0 1 0 #MRIP_CPUE_Sth_Spr
42 3 0 0 1 0 #MRIP_CPUE_Nrth_Fll
43 3 0 0 1 0 #MRIP_CPUE_Sth_Fll
-9999 0 0 0 0 0

#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index

#_Q_parms(if_any)  
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q MA	Spring 1+ (13)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, MA Spring 1+ (13)	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q MA Fall (14)			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, MA Fall (14)
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q MA 1 (15)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	MA 1 (15)	
-35	10	-7	0	99	0	1	0	0	0	0	0	0	0	#	ln_q RI trawl (16)			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, RI trawl (16)
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q RI	1 (17)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	RI 1 (17)	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q CT	Spring 1+ (18)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, CT Spring 1+ (18)	
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q CT	1 (19)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	CT 1 (19)	
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q NY	1 (20)			
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	NY 1 (20)
-35	10	-7	0	99	0	1	0	0	0	0	0	0	0	#	ln_q NJ trawl (21)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NJ trawl (21)			
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q NJ	1 (22)			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	NJ 1 (22)		
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q DE	1 (23)		
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	DE 1 (23)	
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q MD	1 (24)		
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	MD 1 (24)	
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q VIMS 1	(25)	
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param	VIMS 1 (25)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q NEAMAP	North Spr (26)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEAMAP North Spr (26)
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q NEAMAP	South Spr (27)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEAMAP South Spr (27)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q NEAMAP	South Spring Age 1s (28)
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEAMAP South Spring Age1s (28)
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q NEAMAP	North Fall (29)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEAMAP NOrth Fall (29)	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q NEAMAP	South Fall (30)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEAMAP South Fall (30)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q Albatross Spr North (31)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, Albatross Spr North (31)	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q Albatross Spr South (32)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, Albatross Spr South (32)	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q Bigelow North Spring (35)		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, Bigelow North SPring (35)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q Bigelow South Spring (36)	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, Bigelow South Spring (36)	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q NEFSC Winter BTS North	(37)
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEFSC Winter BTS North (37)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q NEFSC Winter BTS South	(38)
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, NEFSC Winter BTS South (38)
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q GSWI (39)
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, GSWI (39)			
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q North Rec CPUE Spr	(40)
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, North Rec CPUE Spr (40)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q South Rec CPUE Spr	(41)
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, South Rec CPUE Spr (41)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q North Rec CPUE Fall (42)
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, North Rec CPUE Fall (42)
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q South Rec CPUE Fall (43)
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power_param, South Rec CPUE Fall (43)

#_size_selex_types
#_Pattern Discard Male Special
 1 1 0 0 # North trawl 1
 1 1 0 0 # South trawl 1
 1 1 0 0 # North trawl 2
 1 1 0 0 # North trawl 2
 1 1 0 0 # North nontrawl 1
 1 1 0 0 # South nontrawl 1
 1 1 0 0 # North nontrawl 2
 1 1 0 0 # South nontrawl 2
 1 1 0 0 # North rec 1
 1 1 0 0 # South rec 1
 1 1 0 0 # North rec 2
 1 1 0 0 # South rec 2
 24 0 0 0 # MA trawl 1+ survey spring
 24 0 0 0 # MA trawl 1+ survey fall
 0 0 0 0 # MA 1
 24 0 0 0 # RI Trawl
 0 0 0 0 # RI 1
 24 0 0 0 # CT spring trawl Age 1+ 
 0 0 0 0 # CT 1
 0 0 0 0 # NY 1
 24 0 0 0 # NJ Trawl
 0 0 0 0 # NJ 1
 0 0 0 0 # DE 1
 0 0 0 0 # MD 1
 0 0 0 0 # VIMS 1
 24 0 0 0 # NEAMAP N Spring
 24 0 0 0 # NEAMAP S Spring
 0 0 0 0 # NEAMAP S Spring Age 1
 24 0 0 0 # NEAMAP N fall
 24 0 0 0 #  NEAMAP S fall
 24 0 0 0 # Alb SprN
 24 0 0 0 # Alb SprS
  0 0 0 0 # Dummy
  0 0 0 0 # Dummy
 24 0 0 0 # Bigelow North Spring
 24 0 0 0 # Bigelow South Spring
 24 0 0 0 # NEFSC Winter BTS North
 24 0 0 0 # NEFSC Winter BTS South
 0 0 0 0 # GSWI index on recruit devs
 5 0 0 5  # RecCPUE_North_Spring
 5 0 0 11 # RecCPUE_South_Spring 
 5 0 0 6  # RecCPUE_North_Fall
 5 0 0 12 # RecCPUE_South_Fall
 

#_age_selex_types
#_Pattern Discard Male Special
11 0 0 0 # North trawl 1
11 0 0 0 # South trawl 1
11 0 0 0 # North trawl 2
11 0 0 0 # South trawl 2
11 0 0 0 # North nontrawl 1
11 0 0 0 # South nontrawl 1
11 0 0 0 # North nontrawl 2
11 0 0 0 # South nontrawl 2
11 0 0 0 # North rec 1
11 0 0 0 # South rec 1
11 0 0 0 # North rec 2
11 0 0 0 # South rec 2
11 0 0 0 # MATRWL_SPR
11 0 0 0 # MATRWL_FLL
11 0 0 0 # MA1s
11 0 0 0 # RI_SPR
11 0 0 0 # RI1s
11 0 0 0 # CT_SPR
11 0 0 0 # CT1s
11 0 0 0 # NY1s
11 0 0 0 # NJ
11 0 0 0 # NJ1s
11 0 0 0 # DE 1s
11 0 0 0 # MD1s
11 0 0 0 # VIMS 1s
11 0 0 0 # NEAMAP_N_Spr
11 0 0 0 # NEAMAP_S_Spr
11 0 0 0 # NEAMAP_S_Spr_Age_1s
11 0 0 0 # NEAMAP_N_Fll
11 0 0 0 # NEAMAP_S_Fll
11 0 0 0 # NEFSC_N
11 0 0 0 # NEFSC_S
10 0 0 0 # dummy fleets for age data, Age 0 selex = 0
10 0 0 0 # dummy fleets for age data, Age 0 selex = 0
11 0 0 0 # Bigelow_N
11 0 0 0 # Bigelow_S
11 0 0 0 # NMFS_Wint_N
11 0 0 0 # NMFS_Wint_S
10 0 0 0 # GSWI
11 0 0 0 # RecCPUE_North_Spring
11 0 0 0 # RecCPUE_South_Spring
11 0 0 0 # RecCPUE_North_Fall
11 0 0 0 # RecCPUE_South_Fall


#
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
# 1   North_Trawl_1 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Trawl_1 (1)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2 #_Size_95%width_North_Trawl_1 (1)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Trawl_1(1)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)
# 2   South_Trawl_1 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_trawl_1(2)
0.01	20	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_trawl_1(2)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_trawl_1(2)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_trawl_1(2)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_trawl_1(2)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_trawl_1(2)
# 3   North_Trawl_2 LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Trawl_2(3)
0.01	20	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_North_Trawl_2(3)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Trawl_2(3)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Trawl_2(3)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Trawl_2(3)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_2(3)
# 4   South_Trawl_2 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_trawl_2(4)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_trawl_2(4)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_trawl_2(4)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_trawl_2(4)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_trawl_2(4)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_trawl_2(4)
# 5   North_Nontrawl_1 LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Nontrawl_1(5)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_North_Nontrawl_1(5)
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Nontrawl_1(5)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Nontrawl_1(5)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Nontrawl_1(5)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Nontrawl_1(5)
# 6   South_Nontrawl_2 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_Nontrawl_1(6)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_Nontrawl_1(6)
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_Nontrawl_1(6)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_Nontrawl_1(6)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_Nontrawl_1(6)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_Nontrawl_1(6)
# 7   North_Nontrawl_2 LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Nontrawl_2(7)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_North_Nontrawl_2(7)
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Nontrawl_2(7)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Nontrawl_2(7)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Nontrawl_2(7)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Nontrawl_2(7)
# 8   South_Nontrawl_2 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_Nontrawl_2(8)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_Nontrawl_2(8)
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_Nontrawl_2(8)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_Nontrawl_2(8)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_Nontrawl_2(8)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_Nontrawl_2(8)
# 9 North_Rec_1 LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Rec_1(9)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_North_Rec_1(9)												
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Rec_1(9)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Rec_1(9)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Rec_1(9)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Rec_1(9)
# 10   South_Rec_1 LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_Rec_1(10)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_Rec_1(10)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_Rec_1(10)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_Rec_1(10)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_Rec_1(10)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_Rec_1(10)
# 11   North_Rec_2 LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_North_Rec_2(11)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_North_Rec_2(11)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_North_Rec_2(11)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_North_Rec_2(11)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_North_Rec_2(11)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Rec_2(11)
# 12   South_Rec_2 LenSelex																										
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2	#_Size_inflection_South_Rec_2(12)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2	#_Size_95%width_South_Rec_2(12)													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_infl_South_Rec_2(12)
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2	#_Retain_L_width_South_Rec_2(12)
-10	10	10	4.59512	99	0	5	0	2	1989	2015	-1	0	0	#_Retain_L_asymptote_logit_South_Rec_2(12)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_South_Rec_2(12)
# 13   MA_Spring_Trawl LenSelex										
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_MA_Spring_Trawl(13)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_MA_Spring_Trawl(13)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_MA_Spring_Trawl(13)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_MA_Spring_Trawl(13)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_MA_Spring_Trawl(13)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_MA_Spring_Trawl(13)
# 14   MA_Fall_Trawl LenSelex													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_MA_Fall_Trawl(14)
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_MA_Fall_Trawl(14)
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_MA_Fall_Trawl(14)
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_MA_Fall_Trawl(14)
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_MA_Fall_Trawl(14)
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_MA_Fall_Trawl(14)																										
# 15   MA_Trawl_14cm_1 LenSelex
# 16   RI_Trawl LenSelex										
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_RI_Trawl(16)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_RI_Trawl(16)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_RI_Trawl(16)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_RI_Trawl(16)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_RI_Trawl(16)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_RI_Trawl(16)
# 17   RI_Trawl_Age1_1 LenSelex
# 18   CT_Trawl_oneplus LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_CT_Trawl_oneplus(18)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_CT_Trawl_oneplus(18)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_CT_Trawl_oneplus(18)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_CT_Trawl_oneplus(18)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_CT_Trawl_oneplus(18)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_CT_Trawl_oneplus(18)
# 19   CT_160mm_GeoMean_1 LenSelex
# 20   NY_Age1_StdIndex_1 LenSelex
# 21   NJ_Trawl LenSelex
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_NJ_Trawl(21)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_NJ_Trawl(21)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_NJ_Trawl(21)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_NJ_Trawl(21)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_NJ_Trawl(21)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_NJ_Trawl(21)
# 22   NJ_Age1_GeoMean_1 LenSelex 
# 23   DE_CPT_Age1_GeoMean_1 LenSelex
# 24   MD_Age1_LOGMEAN_1 LenSelex
# 25   VIMS_Age1_GeoMean_1 LenSelex
# 26   North_NEAMAP_1 LenSelex												
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_North_NEAMAP_1(26)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_North_NEAMAP_1(26)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_North_NEAMAP_1(26)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_North_NEAMAP_1(26)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_North_NEAMAP_1(26)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_North_NEAMAP_1(26)
# 27   South_NEAMAP_1 LenSelex													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_South_NEAMAP_1(27)
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_South_NEAMAP_1(27)
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_South_NEAMAP_1(27)
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_South_NEAMAP_1(27)
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_South_NEAMAP_1(27)
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_South_NEAMAP_1(27)
# 28   South_NEAMAP_Spring_Age1 LenSelex
# 29   North_NEAMAP_2 LenSelex
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_North_NEAMAP_2(29)
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_North_NEAMAP_2(29)
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_North_NEAMAP_2(29)
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_North_NEAMAP_2(29)
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_North_NEAMAP_2(29)
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_North_NEAMAP_2(29)
# 30   South_NEAMAP_2 LenSelex
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_peak_South_NEAMAP_2(30)
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_top_logit_South_NEAMAP_2(30)
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_ascend_se_South_NEAMAP_2(30)
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_descend_se_South_NEAMAP_2(30)
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0	#_Size_DblN_start_logit_South_NEAMAP_2(30)
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0	#_Size_DblN_end_logit_South_NEAMAP_2(30)
# 31   NEFSC_Spring_North LenSelex										
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_NEFSC_Spring_North(31)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_NEFSC_Spring_North(31)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_NEFSC_Spring_North(31)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_NEFSC_Spring_North(31)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_NEFSC_Spring_North(31)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_NEFSC_Spring_North(31)
# 32   NEFSC_Spring_South LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_NEFSC_Spring_South(32)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_NEFSC_Spring_South(32)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_NEFSC_Spring_South(32)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_NEFSC_Spring_South(32)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_NEFSC_Spring_South(32)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_NEFSC_Spring_South(32)
# 33   Dummy_Age_North_2 LenSelex
# 34   Dummy_Age_South_2 LenSelex
# 35   Bigelow_Nrth_Spr LenSelex												
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_Bigelow_Nrth_Spr(35)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_Bigelow_Nrth_Spr(35)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_Bigelow_Nrth_Spr(35)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_Bigelow_Nrth_Spr(35)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_Bigelow_Nrth_Spr(35)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_Bigelow_Nrth_Spr(35)
# 36   Bigelow_Sth_Spr LenSelex													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_Bigelow_Sth_Spr(36)
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_Bigelow_Sth_Spr(36)
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_Bigelow_Sth_Spr(36)
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_Bigelow_Sth_Spr(36)
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_Bigelow_Sth_Spr(36)
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_Bigelow_Sth_Spr(36)
# 37   North_Winter_BTS LenSelex											
5	59	22	65	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_North_Winter_BTS(37)
-10	4	-1.4	0	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_North_Winter_BTS(37)
0.01	9	0.22	5	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_North_Winter_BTS(37)
0.01	9	3	5	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_North_Winter_BTS(37)
-10	10	-0.05	-1.15	99	0	-2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_North_Winter_BTS(37)
-10	10	-1.93	-0.35	99	0	-3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_North_Winter_BTS(37)
# 38   South_Winter_BTS LenSelex													
5	59	22.9	65	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_peak_South_Winter_BTS(38)
-10	4	-4	0	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_top_logit_South_Winter_BTS(38)
0.01	9	2.46	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_ascend_se_South_Winter_BTS(38)
0.01	9	2.55	5	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_descend_se_South_Winter_BTS(38)
-10	10	-1.49	-1.15	99	0	2	0	0	0	0	0.5	0	2	#_Size_DblN_start_logit_South_Winter_BTS(38)
-10	10	0.112	-0.35	99	0	3	0	0	0	0	0.5	0	2	#_Size_DblN_end_logit_South_Winter_BTS(38)
# 39   GSWI LenSelex
# 40   Rec_CPUE_North_1 LenSelex												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P1_Rec_CPUE_North_1(40)
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P2_Rec_CPUE_North_1(40)
# 41   Rec_CPUE_South_1 LenSelex
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P1_Rec_CPUE_South_1(41)
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P2_Rec_CPUE_South_1(41)
# 42    Rec_CPUE_North_2 LenSelex													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P1_Rec_CPUE_North_2(42)
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P2_Rec_CPUE_North_2(42)													
# 43   Rec_CPUE_South_2 LenSelex 													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P1_Rec_CPUE_South_2(43)
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_SizeSel_P2_Rec_CPUE_South_2(43)
													
																																	
													
# 1   North_Trawl_1 AgeSelex																								
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Trawl_1(1)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Trawl_1(1)
# 2   South_Trawl_1 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_trawl_1(2)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_trawl_1(2)
# 3   North_Trawl_2 AgeSelex  													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Trawl_2(3)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Trawl_2(3)
# 4   South_Trawl_2 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_trawl_2(4)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_trawl_2(4)
# 5   North_Nontrawl_1 AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Nontrawl_1(5)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Nontrawl_1(5)
# 6   South_Nontrawl_1 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Nontrawl_1(6)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Nontrawl_1(6)
# 7   North_Nontrawl_2 AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Nontrawl_2(7)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Nontrawl_2(7)
# 8   South_Nontrawl_2 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Nontrawl_2(8)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Nontrawl_2(8)
# 9   North_Rec_1 AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Rec_1(9)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Rec_1(9)
# 10   South_Rec_1 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Rec_1(10)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Rec_1(10)
# 11   North_Rec_2 AgeSelex   													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Rec_2(11)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Rec_2(11)
# 12   South_Rec_2 AgeSelex  																								
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Rec_2(12)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Rec_2(12)
# 13   MA_Spring_Trawl AgeSelex    										
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Spring_Trawl(13)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Spring_Trawl(13)
# 14   MA_Fall_Trawl AgeSelex													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Fall_Trawl(14)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Fall_Trawl(14)
# 15   MA_Trawl_14cm_1 AgeSelex 											
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Trawl_14cm_1(15)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MA_Trawl_14cm_1(15)
# 16   RI_Trawl AgeSelex 											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_RI_Trawl(16)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_RI_Trawl(16)
# 17   RI_Trawl_Age1_1 AgeSelex 													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_RI_Trawl_Age1_1(17)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_RI_Trawl_Age1_1(17)
# 18   CT_Trawl_oneplus AgeSelex 											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_CT_Trawl_oneplus(18)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_CT_Trawl_oneplus(18)
# 19   CT_160mm_GeoMean_1 AgeSelex  												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_CT_160mm_GeoMean_1(19)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_CT_160mm_GeoMean_1(19)
# 20   NY_Age1_StdIndex_1 AgeSelex  												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NY_Age1_StdIndex_1(20)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NY_Age1_StdIndex_1(20)
# 21   NJ_Trawl AgeSelex 												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NJ_Trawl(21)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NJ_Trawl(21)
# 22   NJ_Age1_GeoMean_1 AgeSelex 												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NJ_Age1_GeoMean_1(22)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NJ_Age1_GeoMean_1(22)
# 23   DE_CPT_Age1_GeoMean_1 AgeSelex  											
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_DE_CPT_Age1_GeoMean_1(23)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_DE_CPT_Age1_GeoMean_1(23)
# 24   MD_Age1_LOGMEAN_1 AgeSelex 												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MD_Age1_LOGMEAN_1(24)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_MD_Age1_LOGMEAN_1(24)
# 25   VIMS_Age1_GeoMean_1 AgeSelex 												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_VIMS_Age1_GeoMean_1(25)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_VIMS_Age1_GeoMean_1(25)
# 26   North_NEAMAP_1 AgeSelex   											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_NEAMAP_1(26)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_NEAMAP_1(26)
# 27   South_NEAMAP_1 AgeSelex
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_1(27)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_1(27)
# 28   South_NEAMAP_Spring_Age1 AgeSelex							
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_Spring_Age1(28)
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_Spring_Age1(28)
# 29   North_NEAMAP_2 AgeSelex  													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_NEAMAP_2(29)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_NEAMAP_2(29)
# 30   South_NEAMAP_2 AgeSelex 
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_2(30)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_NEAMAP_2(30)
# 31   NEFSC_Spring_North AgeSelex										
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NEFSC_Spring_North(31)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NEFSC_Spring_North(31)
# 32   NEFSC_Spring_South AgeSelex  											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NEFSC_Spring_South(32)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_NEFSC_Spring_South(32)
# 33   Dummy_Age_North_2 AgeSelex
# 34   Dummy_Age_South_2 AgeSelex
# 35   Bigelow_Nrth_Spr AgeSelex 										
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Bigelow_Nrth_Spr(35)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Bigelow_Nrth_Spr(35)													
# 36   Bigelow_Sth_Spr AgeSelex  										
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Bigelow_Sth_Spr(36)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Bigelow_Sth_Spr(36)												
# 37   North_Winter_BTS AgeSelex 												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Winter_BTS(37)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_North_Winter_BTS(37)
# 38   South_Winter_BTS AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Winter_BTS(38)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_South_Winter_BTS(38)
# 39   GSWI AgeSelex
# 40   Rec_CPUE_North_1 AgeSelex  											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_North_1(40)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_North_1(40)
# 41   Rec_CPUE_South_1 AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_North_2(41)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_North_2(41)
# 42   Rec_CPUE_North_2 AgeSelex													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_South_1(42)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_South_1(42)
# 43   Rec_CPUE_South_2 AgeSelex 													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_South_2(43)
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Rec_CPUE_South_2(43)

0 #_2D AR selectivity


# Tag loss and Tag reporting parameters go next
# need no_tag_groups lines for TG_loss_init, TG_loss_chronic, TG_overdispersion
# and no_fleets lines for TG_report_fleet and TG_rpt_decayfleet
1 # TG_custom:  0=no read; 1=read
#_LO HI INIT PRIOR SD PR_type PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn  
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
-10 10 -9 -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1_
# set overdispersion to do 2, likelihood profile on this (use same val for all tag
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
1 1000 2 2 0.001 1 -7 0 0 0 0 0 0 0 # TG_overdispersion_1_
# 70.70% reporting rate (Moser & Shepherd 2009)        
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-10 20 0.881 0.88 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_
-4 4 0 0 2 0 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1_

#_Variance_adjustments_to_input_values
#_factor fleet value
1 1 0
1 2 0
1 3 0
1 4 0
1 5 0
1 6 0
1 7 0
1 8 0
1 9 0
1 10 0
1 11 0
1 12 0
1 13 0
1 14 0
1 15 0
1 16 0
1 17 0
1 18 0
1 19 0
1 20 0
1 21 0
1 22 0
1 23 0
1 24 0
1 25 0
1 26 0
1 27 0
1 28 0
1 29 0
1 30 0
1 31 0
1 32 0
1 33 0
1 34 0
1 35 0
1 36 0
1 37 0
1 38 0
1 39 0
1 40 0
1 41 0
1 42 0
1 43 0
2 1 0
2 2 0
2 3 0
2 4 0
2 5 0
2 6 0
2 7 0
2 8 0
2 9 0
2 10 0
2 11 0
2 12 0
2 13 0
2 14 0
2 15 0
2 16 0
2 17 0
2 18 0
2 19 0
2 20 0
2 21 0
2 22 0
2 23 0
2 24 0
2 25 0
2 26 0
2 27 0
2 28 0
2 29 0
2 30 0
2 31 0
2 32 0
2 33 0
2 34 0
2 35 0
2 36 0
2 37 0
2 38 0
2 39 0
2 40 0
2 41 0
2 42 0
2 43 0
3 1 0
3 2 0
3 3 0
3 4 0
3 5 0
3 6 0
3 7 0
3 8 0
3 9 0
3 10 0
3 11 0
3 12 0
3 13 0
3 14 0
3 15 0
3 16 0
3 17 0
3 18 0
3 19 0
3 20 0
3 21 0
3 22 0
3 23 0
3 24 0
3 25 0
3 26 0
3 27 0
3 28 0
3 29 0
3 30 0
3 31 0
3 32 0
3 33 0
3 34 0
3 35 0
3 36 0
3 37 0
3 38 0
3 39 0
3 40 0
3 41 0
3 42 0
3 43 0
4 1 0.75
4 2 0.5
4 3 1
4 4 1
4 5 0.5
4 6 0.25
4 7 0.5
4 8 1
4 9 0.5
4 10 1
4 11 1
4 12 1
4 13 1
4 14 1
4 15 1
4 16 0.5
4 17 1
4 18 0.1
4 19 1
4 20 1
4 21 0.15
4 22 1
4 23 1
4 24 1
4 25 1
4 26 0.5
4 27 0.5
4 28 1
4 29 0.5
4 30 0.5
4 31 0.2
4 32 1
4 33 1
4 34 1
4 35 1
4 36 1
4 37 1
4 38 1
4 39 0
4 40 1
4 41 1
4 42 1
4 43 1
5 1 1
5 2 1
5 3 1
5 4 1
5 5 1
5 6 1
5 7 1
5 8 1
5 9 1
5 10 1
5 11 1
5 12 1
5 13 1
5 14 1
5 15 1
5 16 1
5 17 1
5 18 1
5 19 1
5 20 1
5 21 1
5 22 1
5 23 1
5 24 1
5 25 1
5 26 1
5 27 1
5 28 1
5 29 1
5 30 1
5 31 1
5 32 1
5 33 1
5 34 1
5 35 1
5 36 1
5 37 1
5 38 1
5 39 1
5 40 1
5 41 1
5 42 1
5 43 1
6 1 1
6 2 1
6 3 1
6 4 1
6 5 1
6 6 1
6 7 1
6 8 1
6 9 1
6 10 1
6 11 1
6 12 1
6 13 1
6 14 1
6 15 1
6 16 1
6 17 1
6 18 1
6 19 1
6 20 1
6 21 1
6 22 1
6 23 1
6 24 1
6 25 1
6 26 1
6 27 1
6 28 1
6 29 1
6 30 1
6 31 1
6 32 1
6 33 1
6 34 1
6 35 1
6 36 1
6 37 1
6 38 1
6 39 1
6 40 1
6 41 1
6 42 1
6 43 1
7 1 1
7 2 1
7 3 1
7 4 1
7 5 1
7 6 1
7 7 1
7 8 1
7 9 1
7 10 1
7 11 1
7 12 1
7 13 1
7 14 1
7 15 1
7 16 1
7 17 1
7 18 1
7 19 1
7 20 1
7 21 1
7 22 1
7 23 1
7 24 1
7 25 1
7 26 1
7 27 1
7 28 1
7 29 1
7 30 1
7 31 1
7 32 1
7 33 1
7 34 1
7 35 1
7 36 1
7 37 1
7 38 1
7 39 1
7 40 1
7 41 1
7 42 1
7 43 1
-9999 0 0

10 #_maxlambdaphase
1 #_sd_offset

# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=WtFreq; 7=sizeage; 8=catch; 
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  wtfreq_method
5 1 1 0.4 1   # down weight age data via lambda instead of var adjustment to preserve sample size structure
5 2 1 0.4 1   # down weight age data via lambda instead of var adjustment to preserve sample size structure
1 14 1 0 1   # turn off MA Fll surv
4 14 1 0 1    # turn off MA Fll lengths
1 15 1 0 1   # turn off MA age 1s
1 17 1 0 1    #turn off RI age 1s because these data are in RI Spring trawl index, fleet 13
1 19 1 0 1   # turn off CT age 1s
1 22 1 0 1   # turn off NJ age 1s
1 25 1 0 1  #Turn off VIMS
1 27 1 0 1    # turn off NEAMAP Spring South index
4 27 1 0 1    # turn off NEAMAP Spring South lengths
1 29 1 0 1   # turn off Neamap Nrth Fall 
4 29 1 0 1    # turn off NEAMAP North Fall lengths
1 30 1 0 1   # turn off NEAMAP Sth Fall
4 30 1 0 1    # turn off NEAMAP Fall South lengths
5 33 1 0.4 1  #down weight age data via lambda instead of var adjustment to preserve sample size structure
5 34 1 0.4 1  #down weight age data via lambda instead of var adjustment to preserve sample size structure
1 37 1 0 1   #turn off North winter BTS
4 37 1 0 1   #turn off North winter BTS lengths
1 39 1 0 1    # turn off GSWI index on recruitment
-9999 1 1 1 1

0 # read specs for more stddev reporting

999  #end of file

