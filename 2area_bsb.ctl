#C Black sea bass assessment for spatial and seasonal model, 2022 implementation of Fay/Cadrin/McNamee 2016 model in 3.24u
#C area 1 = inshore N, area 2 = inshore S
#C_SS-V3.30.19

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


#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn									
#female,	growth	pattern	1																			
0.1	0.45	0.4	0.25	99	0	-6	0	0	0	0	0	0	0	#	NatM_p_1_Fem_GP:1_							
1	20	9.26	10	99	0	-1	0	0	0	0	0	0	0	#	Lmin-Fem_GP_1_							
40	100	65	65	99	0	5	0	0	0	0	0	0	0	#	Lmax-Fem_GP_1_							
0.02	0.65	0.18	0.18	99	0	4	0	0	0	0	0	0	0	#	VBK-Fem_GP_1_							
0.01	0.5	0.25	0.3	99	0	4	0	0	0	0	0	0	0	#	CV_yng-Fem_GP_1_							
0.01	0.5	0.01	0.04	99	0	-4	0	0	0	0	0	0	0	#	CV_old							
-3	3	1.08E-05	0	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen1-Fem							
-3	4	3.062	3	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen2-Fem							
-10	100	20.79	1	0.8	0	-3	0	0	0	0	0	0	0	#	Mat50-Fem							
-10	10	-0.576	-1	0.8	0	-3	0	0	0	0	0	0	0	#	Matslp-Fem							
-3	3	1	1	0.8	0	-3	0	0	0	0	0	0	0	#	Eggs1-Fem							
-3	3	0	0	0.8	0	-3	0	0	0	0	0	0	0	#	Eggs2-Fem							
#female,	growth	pattern	2																			
-3	3	0	0	0.8	0	-3	0	0	0	0	0	0	0	#	natM	for	M	offset	mal	=	female*exp(male	param)
-3	3	-0.24	-0.24	99	0	-4	0	0	0	0	0	0	0	#	Lmin	M						
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Lmax	M						
-3	3	0	0	99	0	4	0	0	0	0	0	0	0	#	VBK	M						
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	CV-yng	M						
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	CV-old	M						
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Wtlen1-Fem							
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Wtlen2-Fem							
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Mat50-Fem							
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Matslp-Fem							
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Eggs1-Fem							
-3	3	0	0	99	0	-4	0	0	0	0	0	0	0	#	Eggs2-Fem							
#_male,	growth	pattern	1																			
-3	3	0	0	0.8	0	-3	0	0	0	0	0	0	0	#	natM	for	M	offset	mal	=	female*exp(male	param)
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	Lmin	M						
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	Lmax	M						
-3	3	0	0	99	0	5	0	0	0	0	0	0	0	#	VBK	M						
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	CV-yng	M						
-3	3	0	0	99	0	5	0	0	0	0	0	0	0	#	CV-old	M						
-3	3	1.08E-05	0	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen1-Mal							
-3	4	3.062	3	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen2-Mal							param)
#_male,	growth	pattern	2																			
-3	3	0	0	0.8	0	-3	0	0	0	0	0	0	0	#	natM	for	M	offset	mal	=	female*exp(male	
-3	3	-0.24	-0.24	99	0	-5	0	0	0	0	0	0	0	#	Lmin	M						
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	Lmax	M						
-3	3	0	0	99	0	5	0	0	0	0	0	0	0	#	VBK	M						
-3	3	0	0	99	0	-5	0	0	0	0	0	0	0	#	CV-yng	M						
-3	3	0	0	99	0	5	0	0	0	0	0	0	0	#	CV-old	M						
-3	3	1.08E-05	0	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen1-Mal							
-3	4	3.062	3	0.8	0	-3	0	0	0	0	0	0	0	#	Wtlen2-Mal							
#Hermaphroditism		parameters																				
#	inflection	about	4																			
0	20	4	4	99	0	7	0	0	0	0	0	0	0	#	Inflection	age	for	fem-male				
#	std	deviation	in		age																	
0.1	10	2	2	99	0	7	0	0	0	0	0	0	0	#	std.	dev	(in	age)	for	distribution	of	fem-male
0.2	1	0.99	0.95	0.8	0	-3	0	0	0	0	0	0	0	#	asymptotic	rate						

#C Recruitment distributions
#C across settlement patterns
#C RecrDist-settlement-1_
-8     8   -1.1   0   99 -1  2  0 2 1989 2014 0.7 0 0 # 
#C RecrDist-settlement-2_
-4     4   0   0   99 -1  -3  0 0 0 0 0 0 0 # 
#Cohort growth dev
 0.1    3   1   1   99 -1  -3  0 0 0 0 0 0 0 #CohortGrowDev

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
0 #_future feature
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn		
3	20	12	12	99	0	1	0	0	0	0	0	0	0	#SR_R0
0.2	1	0.95	0.75	0.2	0	-5	0	0	0	0	0	0	0 #SR_steep
-2	2	0.7	0.7	99	0	-3	0	0	0	0	0	0	0	#SR_sigmaR
-5	5	0	0	1	0	-3	0	0	0	0	0	0	0	#SR_Regime
0	0.5	0.4	0	99	-1	-3	0	0	0	0	0	0	0	#SR_autocorr

1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1987 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 11 advanced options  (now 13)
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -3 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1) -ve to turn off
 1.0 #10000 #1000000 # 1#_lambda for prior_fore_recr occurring before endyr+1
1965   #_last_early_yr_nobias_adj_in_MPD 
1988   #_first_yr_fullbias_adj_in_MPD 
2012   #_last_yr_fullbias_adj_in_MPD 
2020   #_first_recent_yr_nobias_adj_in_MPD 
1   #_max_bias_adj_in_MPD (1.0 to mimic pre-2009 models)  
 0.0  # period for recruitment cycles
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options

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
0	1	0.2	0	99	0	1	#	InitF_1_
0	1	0.2	0	99	0	1	#	InitF_2_
0	1	0.2	0	99	0	1	#	InitF_3_
0	1	0.2	0	99	0	1	#	InitF_4_
0	1	0.2	0	99	0	1	#	InitF_5_
0	1	0.2	0	99	0	1	#	InitF_6_
0	1	0.2	0	99	0	1	#	InitF_7_
0	1	0.2	0	99	0	1	#	InitF_8_
0	1	0.2	0	99	0	1	#	InitF_9_
0	1	0.2	0	99	0	1	#	InitF_10_
0	1	0.2	0	99	0	1	#	InitF_11_
0	1	0.2	0	99	0	1	#	InitF_12_


#_Q_setup
#fleet	type	info	extrasd	bias_adj	float			
13	3	0	0	1	0	#RI	Spr		
14	3	0	0	1	0	#NJ	Spr		
15	3	0	0	1	0	#Alb	Nrth	Spr	
16	3	0	0	1	0	#Alb	Sth	Spr	
#17	1	0	0	1	1	#Dummy			
#18	1	0	0	1	1	#Dummy			
19	3	0	0	1	0	#MA	1		
20	3	0	0	1	0	#RI	1		
21	3	0	0	1	0	#CT	1		
22	3	0	0	1	0	#NY	1		
23	3	0	0	1	0	#NJ	1		
24	3	0	0	1	0	#DE	1		
25	3	0	0	1	0	#MD	1		
26	3	0	0	1	0	#VIMS	1		
27	3	0	0	1	0	#NEAMAP	N	Spr	
28	3	0	0	1	0	#NEAMAP	N	Fall	
29	3	0	0	1	0	#NEAMAP	S	Spr	
30	3	0	0	1	0	#NEAMAP	S	Fall	
31	3	0	0	1	0	#GS	Index		
32	3	0	0	1	0	#NEFSC	Wint	Nrth	
33	3	0	0	1	0	#NEFSC	Wint	Sth	
34	3	0	0	1	0	#MA	Spr		
35	3	0	0	1	0	#MA	Fll		
36	3	0	0	1	0	#CT	Spr		
37	3	0	0	1	0	#Bigelow	Spr	Nrth	
38	3	0	0	1	0	#Bigelow	Spr	Sth	
39	3	0	0	1	0	#NEAMAP	Sth	Spr	1
40	3	0	0	1	0	#MRIP	CPUE	Nrth	Spr
41	3	0	0	1	0	#MRIP	CPUE	Nrth	Fll
42	3	0	0	1	0	#MRIP	CPUE	Sth	Spr
43	3	0	0	1	0	#MRIP	CPUE	Sth	Fll
-9999 0 0 0 0 0

#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index

#_Q_parms(if_any)  
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
-35	10	-7	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	RI	trawl			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	RI	trawl		
-35	10	-7	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	NJ	trawl			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NJ	trawl		
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	Albatross	Spr	North		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	Albatross	Spr	North	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	Albatross	Spr	South		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	Albatross	Spr	South	
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	MA	1			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	MA	1		
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	RI	1			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	RI	1		
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	CT	1			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	CT	1		
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	NY	1			
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	NY	1		
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	NJ	1			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	NJ	1		
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	DE	1			
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	DE	1		
-35	10	-12	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	MD	1			
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	MD	1		
-35	10	-12	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	VIMS	1			
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param	VIMS	1		
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	NEAMAP	North	Spr		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEAMAP	North	Spr	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	NEAMAP	NOrth	Fall		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEAMAP	NOrth	Fall	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	NEAMAP	South	Spr		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEAMAP	South	Spr	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	NEAMAP	South	Fall		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEAMAP	South	Fall	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	GSWI				
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	GSWI			
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	NEFSC	Winter	BTS	North	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEFSC	Winter	BTS	North
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	NEFSC	Winter	BTS	South	
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEFSC	Winter	BTS	South
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	MA	Spring	1+		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	MA	Spring	1+	
-35	10	-8	0	99	0	-1	0	0	0	0	0	0	0	#	ln_q	MA	Fall			
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	MA	Fall		
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	CT	Spring	1+		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	CT	Spring	1+	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	Bigelow	North	SPring		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	Bigelow	North	SPring	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	Bigelow	South	Spring		
0	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	Bigelow	South	Spring	
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	NEAMAP	South	Spring	Age	1s
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	NEAMAP	South	Spring	Age1s
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	North	Rec	CPUE	Spr	
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	North	Rec	CPUE	Spr
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	North	Rec	CPUE	Fall	
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	North	Rec	CPUE	Fall
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	South	Rec	CPUE	Spr	
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	South	Rec	CPUE	Spr
-35	10	-8	0	99	0	1	0	0	0	0	0	0	0	#	ln_q	South	Rec	CPUE	Fall	
-10	10	0	0	99	0	-2	0	0	0	0	0	0	0	#	power	param,	South	Rec	CPUE	Fall


#_size_selex_types
#_Pattern Discard Male Special
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 #24 1 0 0 # 1
 #24 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 #24 1 0 0 # 1
 #24 1 0 0 # 1
 1 1 0 0 # 1
 1 1 0 0 # 1
 24 0 0 0 # RI Trawl
 24 0 0 0 # NJ Trawl
 24 0 0 0 # Alb SprN
 24 0 0 0 # Alb SprS
  0 0 0 0 #Dummy
  0 0 0 0 #Dummy
 0 0 0 0 #MA 1
 0 0 0 0 #RI 1
 0 0 0 0 #CT 1
 0 0 0 0 #NY 1
 0 0 0 0 #NJ 1
 0 0 0 0 #DE 1
 0 0 0 0 #MD 1
 0 0 0 0 #VIMS 1
 24 0 0 0 # NEAMAP N Spring
 24 0 0 0 # NEAMAP N fall
 24 0 0 0 # NEAMAP S Spring
 24 0 0 0 #  NEAMAP S fall
 31 0 0 0 # GSWI index on recruit devs
 24 0 0 0 # NEFSC Winter BTS North
 24 0 0 0 # NEFSC Winter BTS South
 24 0 0 0 # MA trawl 1+ survey spring
 24 0 0 0 # MA trawl 1+ survey fall
 24 0 0 0 # CT spring trawl Age 1+ 
 24 0 0 0 # Bigelow North Spring
 24 0 0 0 # Bigelow South Spring
 0 0 0 0 # NEAMAP S Spring Age 1
 5 0 0 5  # RecCPUE_North_Spring
 5 0 0 6  # RecCPUE_North_Fall
 5 0 0 11 # RecCPUE_South_Spring
 5 0 0 12 # RecCPUE_South_Fall
 


#_age_selex_types
#_Pattern Discard Male Special
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # 1
11 0 0 0 # 2
11 0 0 0 # RI_SPR
11 0 0 0 # NJ
11 0 0 0 # NEFSC_N
11 0 0 0 # NEFSC_S
10 0 0 0 # dummy fleets for age data, Age 0 selex = 0
10 0 0 0 # dummy fleets for age data, Age 0 selex = 0
11 0 0 0 # MA1s
11 0 0 0 # RI1s
11 0 0 0 # CT1s
11 0 0 0 # NY1s
11 0 0 0 # NJ1s
11 0 0 0 # DE 1s
11 0 0 0 # MD1s
11 0 0 0 # VIMS 1s
11 0 0 0 # NEAMAP_N_Spr
11 0 0 0 # NEAMAP_N_Fll
11 0 0 0 # NEAMAP_S_Spr
11 0 0 0 # NEAMAP_S_Fll
10 0 0 0 # GSWI
11 0 0 0 # NMFS_Wint_N
11 0 0 0 # NMFS_Wint_S
11 0 0 0 # MATRWL_SPR
11 0 0 0 # MATRWL_FLL
11 0 0 0 # CT_SPR
11 0 0 0 # Bigelow_N
11 0 0 0 # Bigelow_S
11 0 0 0 # NEAMAP_S_Spr_Age_1s
11 0 0 0 # RecCPUE_North_Spring
11 0 0 0 # RecCPUE_North_Fall
11 0 0 0 # RecCPUE_South_Spring
11 0 0 0 # RecCPUE_South_Fall



#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	20	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
#-10	4	-2	0	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-3	-0.35	99	0	3	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
#-10	4	-2	0	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	20	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
#-10	4	-2	0	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-3	-0.35	99	0	3	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
#-10	4	-2	0	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
#0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	1	2
#-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	1	2
													
5	59	15	65	99	0	2	0	0	0	0	0.5	1	2
0.01	9	7	5	99	0	2	0	0	0	0	0.5	1	2
0.01	1	1	0.99	99	0	5	0	2	1989	2015	0.4	0	0
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#SURVEYS													
													
#RI	SPring	Trawl											
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0
													
													
#NJ	trawl	(currently	mirroring	-	fleet)	if	length	data	available,	comment	out	first	two
#-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
#-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0
													
#NEFSC	Spring	Survey											
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
#NEAMAP													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0
													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	0
													
#NEFSC	Winter	BTS											
5	59	22	65	99	0	-2	0	0	0	0	0.5	0	2
-10	4	-1.4	0	99	0	-2	0	0	0	0	0.5	0	2
0.01	9	0.22	5	99	0	-2	0	0	0	0	0.5	0	2
0.01	9	3	5	99	0	-2	0	0	0	0	0.5	0	2
-10	10	-0.05	-1.15	99	0	-2	0	0	0	0	0.5	0	2
-10	10	-1.93	-0.35	99	0	-3	0	0	0	0	0.5	0	2
													
5	59	22.9	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-4	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	2.46	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	2.55	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-1.49	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	0.112	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
#MA	trawl	surveys											
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
5	59	25	65	99	0	-2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	-2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	-2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	-2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	-2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	-3	0	0	0	0	0.5	0	2
													
#CT	trawl	1+	(currently	RI	mirroring	trawl	survey)	-	if	length	data	available,	comment
#-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
#-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
5	59	25	65	99	0	2	0	0	0	0	0.5	0	0
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	0
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	0
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	0
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	0
													
#Bigelow													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
5	59	25	65	99	0	2	0	0	0	0	0.5	0	2
-10	4	-2	0	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0.5	0	2
0.01	9	5.9	5	99	0	2	0	0	0	0	0.5	0	2
-10	10	-2	-1.15	99	0	2	0	0	0	0	0.5	0	2
-10	10	-9	-0.35	99	0	3	0	0	0	0	0.5	0	2
													
#Rec	CPUE												
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	35	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
													
													
													
													
#AGE	selex												
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#RI	Trawl												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#NJ	Trawl												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Alb	Spr	N											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Alb	Spr	S											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#MA													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#RI													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#CT													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#NY													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#NJ													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#DE													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#MD													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#VIMS													
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#NEAMAP													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Winter	BTS												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#MA	trawl	surveys											
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#CT	1+												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Bigelow	N												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Bigelow	S												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#NEAMAP	S	Spring	Age		1								
-10	10	1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	1.5	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
#Rec	CPUE												
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0
													
-10	10	0.1	-0.35	99	0	-4	0	0	0	0	0.5	0	0
-10	10	20	-0.35	99	0	-4	0	0	0	0	0.5	0	0


0 #_2D AR selectivity


# Tag loss and Tag reporting parameters go next
# need no_tag_groups lines for TG_loss_init, TG_loss_chronic, TG_overdispersion
# and no_fleets lines for TG_report_fleet and TG_rpt_decayfleet
1 # TG_custom:  0=no read; 1=read
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn		
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_init_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
-10	10	-9	-9	0.001	1	-4	0	0	0	0	0	0	0	#	TG_loss_chronic_1_
#	set	overdispersion	to	do	2,	likelihood	profile	on	this	(use	same	val	for	all	tag
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
1	1000	2	2	0.001	1	-7	0	0	0	0	0	0	0	#	TG_overdispersion_1_
#	70.70%	reporting	rate	(Moser	&	Shepherd	2009)								
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-10	20	0.881	0.88	0.001	1	-4	0	0	0	0	0	0	0	#	TG_report_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_
-4	4	0	0	2	0	-4	0	0	0	0	0	0	0	#	TG_rpt_decay_fleet:_1_

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
4 2 1
4 3 0.5
4 4 0.5
4 5 0.5
4 6 1
4 7 0.5
4 8 1
4 9 0.25
4 10 1
4 11 1
4 12 1
4 13 0.5
4 14 0.15
4 15 0.2
4 16 1
4 17 1
4 18 1
4 19 1
4 20 1
4 21 1
4 22 1
4 23 1
4 24 1
4 25 1
4 26 1
4 27 0.5
4 28 0.5
4 29 0.5
4 30 0.5
4 31 0
4 32 1
4 33 1
4 34 1
4 35 1
4 36 0.1
4 37 1
4 38 1
4 39 1
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
5 1 1 0.4 1   #down weight age data via lambda instead of var adjustment to preserve sample size structure
5 7 1 0.4 1   #down weight age data via lambda instead of var adjustment to preserve sample size structure
5 17 1 0.4 1  #down weight age data via lambda instead of var adjustment to preserve sample size structure
5 18 1 0.4 1  #down weight age data via lambda instead of var adjustment to preserve sample size structure
1 19 1 0 1   # turn off MA age 1s
1 20 1 0 1    #turn off RI age 1s because these data are in RI Spring trawl index, fleet 13
1 21 1 0 1   # turn off CT age 1s
1 23 1 0 1   # turn off NJ age 1s
1 28 1 0 1   # turn off Neamap Nrth Fall 
4 28 1 0 1    # turn off NEAMAP North Fall lengths
1 29 1 0 1    # turn off NEAMAP Spring South index
4 29 1 0 1    # turn off NEAMAP Spring South lengths
1 30 1 0 1   # turn off NEAMAP Sth Fall
4 30 1 0 1    # turn off NEAMAP Fall South lengths
1 31 1 0 1    # turn off GSWI index on recruitment
1 35 1 0 1   # turn off MA Fll surv
4 35 1 0 1    # turn off MA Fll lengths
1 32 1 0 1   #turn off North winter BTS
4 32 1 0 1   #turn off North winter BTS lengths
1 26 1 0 1  #Turn off VIMS
-9999 1 1 1 1

0 # read specs for more stddev reporting

999  #end of file



