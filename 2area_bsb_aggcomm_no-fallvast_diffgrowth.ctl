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
1 7 1 0  
2 7 2 0 
#1 10 1 0  
#2 10 2 0 

2 #_Cond 0 # N_movement_definitions goes here if N_areas > 1
0 #1.0 #_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
1 1 2 1 21 25   
2 1 1 2 21 25   

6 #_Nblock_patterns
1 1 2 2 1 1 #_blocks_per_pattern
# begin and end years of blocks
#1989 1997 1998 2001  #for trawl
1998 2022 #1989 1997
2009 2016
# 1995 2002 2003 2007
#1985 1999 2000 2010 #2011 2021
2000 2010 2011 2022
2001 2008 2009 2022 #1989 2000 2001 2008
2014 2019
2012 2022 #1985 2000

1 #_block deviation adjust method
#0 0 0 0 0 #autogen of time-varying params (1= no autogen)
1 1 1 1 1 #autogen of time-varying params (1= no autogen)

0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#2 #_N_breakpoints
# 4 4 # age(real) at M breakpoints

1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=not implemented; 4=not implemented
0.75 #_Growth_Age_for_L1  
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


3 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#1 #_env/block/dev_adjust_method (1=standard; 2=with logistic trans to keep within base parm bounds)

#LO HI  INIT    PRIOR   SD  PR_Type PHASE   env-var use_dev dev_minyr   dev_maxyr   dev_stdev   Block   Block_Fxn       
#female,    growth  pattern 1,  decade  1                                       
0.1 0.45    0.4 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_Fem_GP:1_
1   20  12.88   10  99  0   3   0   0   0   0   0   0   0   #   Lmin-Fem_GP_1_
30  100 77.47   65  99  0   3   0   0   0   0   0   6   2   #   Lmax-Fem_GP_1_
0.02    0.65    0.134   0.18    99  0   3   0   0   0   0   0   6   2   #   VBK-Fem_GP_1_
0.01    0.5 0.15    0.3 99  0   3   0   0   0   0   0   0   0   #   CV_yng-Fem_GP_1_
-5  5   0   0.04    99  0   4  0   0   0   0   0   0   0   #   CV_old
#0.01  5   0.15   0.15    99  0   4  0   0   0   0   0   0   0   #   CV_old
1.00E-07    3   3.34E-05  0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-Fem
-3  4   2.753379   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-Fem
-10 100 20.31   1   0.8 0   -3  0   0   0   0   0   3   2   #   Mat50-Fem
-10 10  -0.55   -1  0.8 0   -3  0   0   0   0   0   3   2   #   Matslp-Fem
-3  3   1   1   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs1-Fem
-3  3   0   0   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs2-Fem

#female,    growth  pattern 2,  decade  1
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -3  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   3  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -4  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_

#0.1 0.45    0.4 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_Fem_GP:2_
#1   20  11.58   10  99  0   3  0   0   0   0   0   0   0   #   Lmin-Fem_GP_2_
#30  100 69.4    65  99  0   3   0   0   0   0   0   0   0   #   Lmax-Fem_GP_2_
#0.02    0.65    0.133   0.18    99  0   3   0   0   0   0   0   0   0   #   VBK-Fem_GP_2_
#0.01    0.5 0.15    0.3 99  0   -3   0   0   0   0   0   0   0   #   CV_yng-Fem_GP_2_
#0.01    0.5 0.15    0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
-3  3   1.55E-05    0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-Fem
-3  4   2.963   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-Fem
-10 100 20.91   1   0.8 0   -3  0   0   0   0   0   3   2   #   Mat50-Fem
-10 10  -0.29   -1  0.8 0   -3  0   0   0   0   0   3   2   #   Matslp-Fem
-3  3   1   1   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs1-Fem
-3  3   0   0   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs2-Fem
                                                            
##female,    growth  pattern 2,  decade  1                                       
#-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_Fem_GP:2_
#-10 10  -1.06E-01   10  99  0   3   0   0   0   0   0   0   0   #   Lmin-Fem_GP_2_
#-10 10  -1.10E-01   65  99  0   3   0   0   0   0   0   0   0   #   Lmax-Fem_GP_2_
#-10 10  -0.007490672    0.18    99  0   3   0   0   0   0   0   0   0   #   VBK-Fem_GP_2_
#-10 10  0   0.3 99  0   -4   0   0   0   0   0   0   0   #   CV_yng-Fem_GP_2_
#-10 10  0   0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
#-3  3   0.0000171   0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-Fem
#-3  4   2.928   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-Fem
#-10 100 20.91   1   0.8 0   -3  0   0   0   0   0   3   2   #   Mat50-Fem
#-10 10  -0.29   -1  0.8 0   -3  0   0   0   0   0   3   2   #   Matslp-Fem
#-3  3   1   1   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs1-Fem
#-3  3   0   0   0.8 0   -3  0   0   0   0   0   0   0   #   Eggs2-Fem

#_male, growth  pattern 1,  decade  1                                       
0.1 0.45    0 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -3  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   3  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -4  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_

#0.1 0.45    0.4 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
#1   20  0    10  99  0   -3  0   0   0   0   0   0   0   #   Lmin-M_GP_1_
#30  100 0   65  99  0   -3   0   0   0   0   0   0   0   #   Lmax-M_GP_1_
#30  100 69   65  99  0   3   0   0   0   0   0   0   0   #   Lmax-M_GP_1_
#0.02    0.65    0.347   0.18    99  0   3   0   0   0   0   0   0   0   #   VBK-M_GP_1_
#0.02    0.65    0   0.18    99  0   -3   0   0   0   0   0   0   0   #   VBK-M_GP_1_
#0.01    0.5 0    0.3 99  0   -4  0   0   0   0   0   0   0   #   CV_yng-M_GP_1_
#0.01    0.5 0    0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
-3  3   3.82E-05    0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
-3  4   2.706   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M

##_male, growth  pattern 1,  decade  1                                       
#-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
#-10 10  0   10  99  0   3  0   0   0   0   0   0   0   #   Lmin-M_GP_1_
#-10 10  0   65  99  0   3  0   0   0   0   0   0   0   #   Lmax-M_GP_1_
#-10 10  0   0.18    99  0   3  0   0   0   0   0   0   0   #   VBK-M_GP_1_
#-10 10  0   0.3 99  0   -4  0   0   0   0   0   0   0   #   CV_yng-M_GP_1_
#-10 10  0   0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
#-3  3   0.0000104   0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
#-3  4   3.094   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M
                                                            
#_male, growth  pattern 2,  decade  1                                       
0.1 0.45    0 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:2_
-10 10  0   0.25    99  0   -3  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -4  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -4  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
#0.1 0.45    0.4 0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:2_
#1   20  0    10  99  0   -3  0   0   0   0   0   0   0   #   Lmin-M_GP_2_
#30  100 60.01   65  99  0   3   0   0   0   0   0   0   0   #   Lmax-M_GP_2_
#30  100 0   65  99  0   -3   0   0   0   0   0   0   0   #   Lmax-M_GP_2_
#0.02    0.65    0 0.18    99  0   -3   0   0   0   0   0   0   0   #   VBK-M_GP_2_
#0.01    0.5 0    0.3 99  0   -4  0   0   0   0   0   0   0   #   CV_yng-M_GP_2_
#0.01    0.5 0    0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
-3  3   1.21E-05    0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
-3  4   3.033   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M

##_male, growth  pattern 2,  decade  1                                       
#-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:2_
#-10 10  0   10  99  0   3  0   0   0   0   0   0   0   #   Lmin-M_GP_2_
#-10 10  0   65  99  0   3  0   0   0   0   0   0   0   #   Lmax-M_GP_2_
#-10 10  0   0.18    99  3   3  0   0   0   0   0   0   0   #   VBK-M_GP_2_
#-10 10  0   0.3 99  0   -4  0   0   0   0   0   0   0   #   CV_yng-M_GP_2_
#-10 10  0   0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
#-3  3   0.0000158   0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
#-3  4   2.951   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M

#Hermaphroditism parameters                    
# inflection about 4                   
0 20 4 4 99 0 -7 0 0 0 0 0 0 0 # Inflection_age_for_fem-male    
# std deviation in age                 
0.1 10 2 2 99 0 -7 0 0 0 0 0 0 0 # std_dev_(in age)_for_distribution_of_fem-male
#0.01 1 0.99 0.95 0.8 0 -3 0 0 0 0 0 0 0 # asymptotic_rate      
0.01 1 0.1 0.95 0.8 0 -3 0 0 0 0 0 0 0 # asymptotic_rate      

#C Recruitment distributions
#C RecrDist-settlement-1_
 -8 8 -1 0 99 0 1 0 23 1990 2021 3 0 0 # 
#-8 8 -1.1 0 99 0.5 1 0 2 1990 2019 1 0 0 #  
#C RecrDist-settlement-2_
 -4 4 -1 0 99 0 -1 0 0 0 0 0 0 0 # 
#Cohort growth dev
 0.1 3 1 1 99 0 -3 0 0 0 0 0 0 0#CohortGrowDev

#C Movement parameters
 -15 15 15 0 99 0 1 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_1from_2to_1
 -15 15 -9998 0 99 0 -3 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_1from_2to_1
 -15 15 -2 0 99 0 1 0 0 0 0 0 0 0 # MoveParm_A_seas_2_GP_1from_1to_2
 -15 15 -9998 0 99 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_2_GP_1from_1to_2 

#0.63 #_fracfemale  #0.37 are male (OJensen 2015/12/01)
1e-006 0.999999 0.63 0.63 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
1e-006 0.999999 0.63 0.63 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_2


# 0  #custom_MG-env_setup (0/1)
# -2 2 0 0 -1 99 -2 #_placeholder for no MG-environ parameters

#_  LO  HI  INIT    PRIOR   PR_SD   PR_type PHASE       
#1   20  12.88   10  99  0   3   #   Lmin-Fem_GP_1_
#1   20  12.88   10  99  0   3   #   Lmin-Fem_GP_1_
#30  100 77.47   65  99  0   3   #   Lmax-Fem_GP_1_
30  100 77.47   65  99  0   3   #   Lmax-Fem_GP_1_
#0.02    0.65    0.134   0.18    99  0   3   #   VBK-Fem_GP_1_
0.02    0.65    0.134   0.18    99  0   3   #   VBK-Fem_GP_1_
-3  3   1.76E-05    0   0.8 0   -3  #   Wtlen_1_Fem_GP_1_BLK3repl_2000
-3  3   1.52E-05    0   0.8 0   -3  #   Wtlen_1_Fem_GP_1_BLK3repl_2011
-3  4   2.916   3   0.8 0   -3  #   Wtlen_2_Fem_GP_1_BLK3repl_2000
-3  4   2.964   3   0.8 0   -3  #   Wtlen_2_Fem_GP_1_BLK3repl_2011
-10 100 22.85   1   0.8 0   -3  #   Mat50%_Fem_GP_1_BLK3repl_2000
-10 100 22.69   1   0.8 0   -3  #   Mat50%_Fem_GP_1_BLK3repl_2011
-10 10  -0.42   -1  0.8 0   -3  #   Mat_slope_Fem_GP_1_BLK3repl_2000
-10 10  -0.63   -1  0.8 0   -3  #   Mat_slope_Fem_GP_1_BLK3repl_2011
-3  3   1.38E-05   0   0.8 0   -3  #   Wtlen_1_Fem_GP_2_BLK3repl_2000
-3  3   1.92E-05   0   0.8 0   -3  #   Wtlen_1_Fem_GP_2_BLK3repl_2011
-3  4   2.991   3   0.8 0   -3  #   Wtlen_2_Fem_GP_2_BLK3repl_2000
-3  4   2.889   3   0.8 0   -3  #   Wtlen_2_Fem_GP_2_BLK3repl_2011
-10 100 21.11   1   0.8 0   -3  #   Mat50%_Fem_GP_2_BLK3repl_2000
-10 100 22.73   1   0.8 0   -3  #   Mat50%_Fem_GP_2_BLK3repl_2011
-10 10  -0.4    -1  0.8 0   -3  #   Mat_slope_Fem_GP_2_BLK3repl_2000
-10 10  -0.43   -1  0.8 0   -3  #   Mat_slope_Fem_GP_2_BLK3repl_2011
-3  3   9.7E-06   0   0.8 0   -3  #   Wtlen_1_Mal_GP_1_BLK3repl_2000
-3  3   2.78E-05   0   0.8 0   -3  #   Wtlen_1_Mal_GP_1_BLK3repl_2011
-3  4   3.091    3   0.8 0   -3  #   Wtlen_2_Mal_GP_1_BLK3repl_2000
-3  4   2.774   3   0.8 0   -3  #   Wtlen_2_Mal_GP_1_BLK3repl_2011
-3  3   1.10E-05   0   0.8 0   -3  #   Wtlen_1_Mal_GP_2_BLK3repl_2000
-3  3   2.48E-05   0   0.8 0   -3  #   Wtlen_1_Mal_GP_2_BLK3repl_2011
-3  4   3.044   3   0.8 0   -3  #   Wtlen_2_Mal_GP_2_BLK3repl_2000
-3  4   2.800   3   0.8 0   -3  #   Wtlen_2_Mal_GP_2_BLK3repl_2011
0.0001  2   0.7 0 0 0   -5  #   RecrDist_GP_1_area_1_month_10_dev_se
-0.99   0.99    0   0   0 0   -6  #   RecrDist_GP_1_area_1_month_10_dev_autocorr

#_seasonal_effects_on_biology_parms
#C possibly include this for w-l relationships
 1 1 0 0 0 0 1 1 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K

 -2 2 0 0 99 -1 -2 
 -2 2 0.115 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 -0.00838 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 0.3348 0 99 -1 -2 #_placeholder for no seasonal MG parameters
 -2 2 0 0 99 -1 -2 
 -2 2 -0.03504 0 99 -1 -2 #_placeholder for no seasonal MG parameters


# -2 2 0 0 -1 99 -2 #_placeholder for no MG dev parameters

#5 # placeholder for #_MGparm_Dev_Phase

#_Spawner-Recruitment
3 #_SR_function
1 #_equilibrium recruitment (0=none; 1=use steepness)
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             3            20            13            12            99             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1          0.95          0.75           0.2             6         -5          0          0          0          0          0          0          0 # SR_BH_steep
            -2             2           0.7           0.7            99             6         -3          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             6         -4          0          0          0          0          0          0          0 # SR_regime
             0           0.5             0             0            99             0         -3          0          0          0          0          0          0          0 # SR_autocorr

1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1987 #1992 #1987 # first year of main recr_devs; early devs can preceed this era
2019 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 10000000 #_lambda for Fcast_recr_like occurring before endyr+1
 1965 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1988 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2017 #_last_yr_fullbias_adj_in_MPD
 2023 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
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
0 3.99 1.9 0 99 0 1 # InitF_1_
#0 3.99 1.2 0 99 0 1 # InitF_2_
#0 1.8 0.25 0 99 0 1 # InitF_3_
#0 1.8 0.25 0 99 0 1 # InitF_4_


#_Q_setup
#_1:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm)
#_2:  extra input for link, i.e. mirror fleet
#_3:  0/1 to select extra sd parameter
#_4:  0/1 for biasadj or not
#_5:  0/1 to float
#fleet type info extrasd bias_adj float   
9 3 0 0 1 0 #VAST_N_Spr
10 3 0 0 1 0 #VAST_S_Spr
11 3 0 0 1 0 #VAST_N_Fall 
12 3 0 0 1 0 #VAST_S_Fall  
13 3 0 0 1 0
14 3 0 0 1 0
15 3 0 0 1 0
-9999 0 0 0 0 0

#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index

#_Q_parms(if_any)  
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn
-35 10  -8  0   99  0   1   0   0   0   0   0   0   0   #   ln_q VAST North Spring (35)  
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, VAST North Spring(35)  
-35 10  -8  0   99  0   1   0   0   0   0   0   0   0   #   ln_q VAST South Spring (36)  
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, VAST South Spring (36)  
-35 10  -8  0   99  0   -1   0   0   0   0   0   0   0   #   ln_q VAST North Fall (37)  
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, VAST North Fall (37)  
-35 10  -8  0   99  0   -1   0   0   0   0   0   0   0   #   ln_q VAST South Fall (38)  
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, VAST South Fall (38)  			
-35 10  -8  0   99  0   1   0   0   0   0   0   0   0   #   ln_q fleet 9
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, fleet 9
-35 10  -8  0   99  0   1   0   0   0   0   0   0   0   #   ln_q fleet 10   
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, fleet 10
-35 10  -1.23  0   99  0   -1   0   0   0   0   0   0   0   #   ln_q fleet 41   
0   10  0   0   99  0   -2  0   0   0   0   0   0   0   #   power_param, fleet 41

#_size_selex_types
#_Pattern Discard Male Special
1	2	0	0
1	2	0	0
1	2	0	0
1	2	0	0
1	2	0	0
1	2	0	0
1	2	0	0
1	2	0	0
1 0 0 0 #24  0   0   0   #35 VAST_North_Spr
1 0 0 0 #24  0   0   0   #36 VAST_South_Spr
1 0 0 0 #24  0   0   0   #37 VAST_North_Fall
1 0 0 0 #24  0   0   0   #38 VAST_South_Fall
5 0 0 7  #39 RecCPUE_North_Fall
5 0 0 8 #40 RecCPUE_South_Fall
0 0 0 0

#_age_selex_types
#_Pattern Discard Male Special
0   0   0   0       
0   0   0   0       
10   0   0   0       
10   0   0   0       
0   0   0   0       
0   0   0   0       
10   0   0   0       
10   0   0   0       
10   0   0   0   #35 VAST_North_Spr
10   0   0   0   #36 VAST_South_Spr
10   0   0   0   #37 VAST_North_Fall
10   0   0   0   #38 VAST_South_Fall
0   0   0   0   #39 RecCPA_North_Spring
0   0   0   0   #40 RecCPA_South_Spring
0 0 0 0

#selectivity parameters
#
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_minyr	dev_maxyr	dev_stddev	Block	Block_Fxn

##
#Fleet 1 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	1	2
																						
5		59	15	65	99	0	2	0	0	0	0	0	1	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	1	2	#_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0  5   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 2 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	1	2
																						
5		59	15	65	99	0	2	0	0	0	0	0	1	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	1	2	#_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-5 5  4.99  4.59512 99  0   2   0   2   1990    2020    4   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 3 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0	0	0
																						
5		59	15	65	99	0	2	0	0	0	0	0	0	0	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	0	0	#_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0  5   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 4 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	1	2
																						
5		59	15	65	99	0	2	0	0	0	0	0	1	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	1	2	#_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-5 5  4.99  4.59512 99  0   2   0   2   1990    2020    4   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 9 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0	0	0
																					
5		59	15	65	99	0	2	0	0	0	0	0	4	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	4	2	#_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0  4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

1		59	1	65	99	0	-2	0	0	0	0	0	0	0
0.001	9	0.001	5	99	0	-2	0	0	0	0	0	0	0
0		1	0.15	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 10 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%

5		59	25	65	99	0	2	0	0	0	0	0	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0	0	0
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

1		59	1	65	99	0	-2	0	0	0	0	0	0	0
0.001	9	0.001	5	99	0	-2	0	0	0	0	0	0	0
0		1	0.15	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 11 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0	0	0
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

1		59	1	65	99	0	-2	0	0	0	0	0	0	0
0.001	9	0.001	5	99	0	-2	0	0	0	0	0	0	0
0		1	0.15	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 12 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%

5		59	25	65	99	0	2	0	0	0	0	0	0	0
0.01	9	5.1	5	99	0	2	0	0	0	0	0	0	0
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
-10 10  10  4.59512 99  0   -2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

1		59	1	65	99	0	-2	0	0	0	0	0	0	0
0.001	9	0.001	5	99	0	-2	0	0	0	0	0	0	0
0		1	0.15	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#35 VAST_North_Spr
    5   59  25  65  99  0   2   0   0   0   0   0   0   0
#-10     4   -2  0   99  0   2   0   0   0   0   0   0   0
0.01    9   5.1 5   99  0   2   0   0   0   0   0   0   0
#0.01    9   5.9 5   99  0   2   0   0   0   0   0   0   0
#-10 10  -2  -1.15   99  0   2   0   0   0   0   0   0   0
#-10 10  -9  -0.35   99  0   3   0   0   0   0   0   0   0

#36 VAST_South_Spr
    5   59  25  65  99  0   2   0   0   0   0   0   0   0
#-10     4   -2  0   99  0   2   0   0   0   0   0   0   0
0.01    9   5.1 5   99  0   2   0   0   0   0   0   0   0
#0.01    9   5.9 5   99  0   2   0   0   0   0   0   0   0
#-10 10  -2  -1.15   99  0   2   0   0   0   0   0   0   0
#-10 10  -9  -0.35   99  0   3   0   0   0   0   0   0   0

#37 VAST_North_Fall
    5   59  25  65  99  0   -2   0   0   0   0   0   0   0
#-10     4   -2  0   99  0   2   0   0   0   0   0   0   0
0.01    9   5.1 5   99  0   -2   0   0   0   0   0   0   0
#0.01    9   5.9 5   99  0   2   0   0   0   0   0   0   0
#-10 10  -2  -1.15   99  0   2   0   0   0   0   0   0   0
#-10 10  -9  -0.35   99  0   3   0   0   0   0   0   0   0

#38 VAST_South_Fall
    5   59  25  65  99  0   -2   0   0   0   0   0   0   0
#-10     4   -2  0   99  0   2   0   0   0   0   0   0   0
0.01    9   5.1 5   99  0   -2   0   0   0   0   0   0   0
#0.01    9   5.9 5   99  0   2   0   0   0   0   0   0   0
#-10 10  -2  -1.15   99  0   2   0   0   0   0   0   0   0
#-10 10  -9  -0.35   99  0   3   0   0   0   0   0   0   0

#Rec CPUE
-10     10     1    -0.35    99 0    -4      0  0  0  0  0  0  0   
-10     10    35    -0.35    99 0    -4      0  0  0  0  0  0  0   

-10     10     1    -0.35    99 0    -4      0  0  0  0  0  0  0   
-10     10    35    -0.35    99 0    -4      0  0  0  0  0  0  0  


#age-based selectivity



# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
# commercial selecgtivity
             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989
-10 10  10  4.59512 99  0   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)

             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989
#0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #

#             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
#            5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989
-10 10  10  4.59512 99  0   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)

             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989
#0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #

 #            5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
 #         0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
 #            5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
 #         0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989

 #            5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
 #         0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
 #            5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
 #         0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989


#             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989

#             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989


#recreational selectivity
 #            5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
 #            5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989             
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
 #         0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989             
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
 #         0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989             
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
 #         0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
#             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989             
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
#          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
          -10 10  10  4.59512 99  0   -2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
 #         0.0001  2   0.4 0 0 0   -5  #   
#-0.99   0.99    0   0   0 0   -6  #



0 #_2D AR selectivity


# Tag loss and Tag reporting parameters go next
# need no_tag_groups lines for TG_loss_init, TG_loss_chronic, TG_overdispersion
# and no_fleets lines for TG_report_fleet and TG_rpt_decayfleet
1 # TG_custom:  0=no read; 1=read
#_LO HI INIT PRIOR SD PR_type PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn  
#-10 10 -9  -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1
# 10% initial tag loss (Moser and Shepherd 2009)
-10 10 -2.197225  -9 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_init_1
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_2
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_3
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_4
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_5
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_6
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_7
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_8
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_9
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_10
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_11
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_12
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_13
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_14
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_15
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_16
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_17
 -10 10 -7  -7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_loss_init_18
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_1
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_2
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_3
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_4
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_5
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_6
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_7
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_8
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_9
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_10
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_11
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_12
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_13
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_14
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_15
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_16
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_17
 -10 10 -7  -7 0.001 1 -4 0 0 0 0 0 0 0 # TG_loss_chronic_18
 1 10 2  2 0.001 1 -4 0 0 0 0 0 0 0 # TG_overdispersion_1
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_2
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_3
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_4
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_5
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_6
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_7
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_8
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_9
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_10
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_11
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_12
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_13
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_14
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_15
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_16
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_17
 1 10 2  2 0.001 1 -1000 0 0 0 0 0 0 0 # TG_overdispersion_18
 # 70.70% reporting rate (Moser & Shepherd 2009)        
 -10 10 0.881  0.881 0.001 1 -4 0 0 0 0 0 0 0 # TG_report_fleet:_1
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_2
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_3
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_4
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_5
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_6
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_7
 -10 10 7  7 0.001 1 -1000 0 0 0 0 0 0 0 # TG_report_fleet:_8
 -4 0 0  0 2 6 -4 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_1
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_2
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_3
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_4
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_5
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_6
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_7
 -4 0 0  0 2 6 -1000 0 0 0 0 0 0 0 # TG_rpt_decay_fleet:_8

#_Variance_adjustments_to_input_values
#_factor fleet value
#1 14 0.15
#1 15 0.15
1 13 0.15
1 14 0.15
4	1	0.2
4	2	0.2
4	3	0.2
4	4	0.2
4	5	0.2
4	6	0.2
4	7	0.2
4	8	0.2
#4 9 0.2
#4 10 0.2
#4 11 0.2
#4 12 0.2
#4 13 0.05
#4 14 0.05
#4 15 0.05
#4 16 0.05
#4 17 0.05
#4 18 0.05
#4 20 0.05
-9999 0 0

10 #_maxlambdaphase
1 #_sd_offset

# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=WtFreq; 7=sizeage; 8=catch; 
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  wtfreq_method
5 1 1 0.1 1
5 2 1 0.1 1
5 3 1 0.1 1
5 4 1 0.1 1
5 5 1 0 1
5 6 1 0 1
#5 7 1 0.1 1
#5 8 1 0.1 1
5 7 1 0.25 1
5 8 1 0.25 1
# turn off data from objective function for surveys other than VAST & RecCPA
1   15 1 0 1
#5 9 1 4 1
#5 10 1 4 1
5 9 1 0.75 1
5 10 1 0.5 1
#5 11 1 0.5 1
#5 12 1 0.5 1
1 11 1 0 1
1 12 1 0 1
5 11 1 0 1
5 12 1 0 1
-9999 1 1 1 1

0 # read specs for more stddev reporting

999  #end of file







#variance adjustment
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
#1 41 0
#1 42 0
#1 43 0
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
#2 41 0
#2 42 0
#2 43 0
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
#3 41 0
#3 42 0
#3 43 0
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
#4 41 1
#4 42 1
#4 43 1
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
#5 41 1
#5 42 1
#5 43 1
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
#6 41 1
#6 42 1
#6 43 1
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
#7 41 1
#7 42 1
#7 43 1


#_male, growth  pattern 1,  decade  1                                       
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:1_
-10 10  -0.265163209    10  99  0   3   0   0   0   0   0   0   0   #   Lmin-M_GP_1_
-10 10  -0.496556756    65  99  0   3   0   0   0   0   0   0   0   #   Lmax-M_GP_1_
-10 10  0.95148498  0.18    99  0   3   0   0   0   0   0   0   0   #   VBK-M_GP_1_
-10 10  0   0.3 99  0   4   0   0   0   0   0   0   0   #   CV_yng-M_GP_1_
-10 10  0   0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
-3  3   0.0000104   0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
-3  4   3.094   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M
                                                            
#_male, growth  pattern 2,  decade  1                                       
-10 10  0   0.25    99  0   -6  0   0   0   0   0   0   0   #   NatM_p_1_M_GP:2_
-10 10  -0.25509263 10  99  0   3   0   0   0   0   0   0   0   #   Lmin-M_GP_2_
-10 10  -0.25537955 65  99  0   3   0   0   0   0   0   0   0   #   Lmax-M_GP_2_
-10 10  0.400477567 0.18    99  3   4   0   0   0   0   0   0   0   #   VBK-M_GP_2_
-10 10  0   0.3 99  0   4   0   0   0   0   0   0   0   #   CV_yng-M_GP_2_
-10 10  0   0.04    99  0   -4  0   0   0   0   0   0   0   #   CV_old
-3  3   0.0000158   0   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen1-M
-3  4   2.951   3   0.8 0   -3  0   0   0   0   0   3   2   #   Wtlen2-M



# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_1(1)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_1(1)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_1(1)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_1(1)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Trawl_1(2)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Trawl_1(2)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Trawl_1(2)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Trawl_1(2)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_North_Trawl_2(3)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Trawl_2(3)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Trawl_2(3)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Trawl_2(3)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Trawl_2(4)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Trawl_2(4)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Trawl_2(4)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Trawl_2(4)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_North_Nontrawl_1(5)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Nontrawl_1(5)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Nontrawl_1(5)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Nontrawl_1(5)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Nontrawl_1(6)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Nontrawl_1(6)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Nontrawl_1(6)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Nontrawl_1(6)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_North_Nontrawl_2(7)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Nontrawl_2(7)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Nontrawl_2(7)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Nontrawl_2(7)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Nontrawl_2(8)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Nontrawl_2(8)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Nontrawl_2(8)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Nontrawl_2(8)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_North_Rec_1(9)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Rec_1(9)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_1(9)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_1(9)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Rec_1(10)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Rec_1(10)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Rec_1(10)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Rec_1(10)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_North_Rec_2(11)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_North_Rec_2(11)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_North_Rec_2(11)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_North_Rec_2(11)_BLK1repl_1989
             5            59            25            65            99             0      2  # Size_inflection_South_Rec_2(12)_BLK1repl_1989
          0.01             9           5.1             5            99             0      2  # Size_95%width_South_Rec_2(12)_BLK1repl_1989
             5            59            15            65            99             0      2  # Retain_L_infl_South_Rec_2(12)_BLK1repl_1989
          0.01             9             7             5            99             0      2  # Retain_L_width_South_Rec_2(12)_BLK1repl_1989



## NOW



0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #
0.0001  2   0.4 0 0 0   -5  #   
-0.99   0.99    0   0   0 0   -6  #


          

##
#Fleet 1 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	1	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	1	2
																						
5		59	15	65	99	0	2	0	0	0	0	0	1	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	1	2	#_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 2 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 3 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 4 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 5 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 6 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 7 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0.5	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 8 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5       59  25  65  99  0   2   0   0   0   0   0   1   2
0.01    9   5.1 5   99  0   2   0   0   0   0   0   1   2
                                                                                        
5       59  15  65  99  0   2   0   0   0   0   0   1   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   1   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   -5   0   0   0   0   0  0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   0   0   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 9 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	4	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	4	2
																					
5		59	15	65	99	0	2	0	0	0	0	0	4	2	#_Retain_L_infl_North_Trawl_1(1)
0.01	9	7	5	99	0	2	0	0	0	0	0	4	2	#_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10	10	0	-0.35	99	0	-4	0	0	0	0	0	0	0	#_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 10 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%

5		59	25	65	99	0	2	0	0	0	0	0	4	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	4	2
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 11 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%
5		59	25	65	99	0	2	0	0	0	0	0	4	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	4	2
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

#Fleet 12 - logistic selectivity, with time block 1, retention (block 1) [tv asymptote turned off], discard mortality 100%

5		59	25	65	99	0	2	0	0	0	0	0	4	2
0.01	9	5.1	5	99	0	2	0	0	0	0	0	4	2
																						
5       59  15  65  99  0   2   0   0   0   0   0   4   2   #_Retain_L_infl_North_Trawl_1(1)
0.01    9   7   5   99  0   2   0   0   0   0   0   4   2   #_Retain_L_width_North_Trawl_1(1)
#-10 10  10  4.59512 99  0   2   0   0   0   0   0   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  10  4.59512 99  0   2   0   2   1990    2020    5   4   2   #_Retain_L_asymptote_logit_North_Trawl_1(1)
-10 10  0   -0.35   99  0   -4  0   0   0   0   0   0   0   #_Retain_L_maleoffset_North_Trawl_1(1)

5		59	25	65	99	0	-2	0	0	0	0	0	0	0
0.01	9	2	5	99	0	-2	0	0	0	0	0	0	0
0		1	1	1	99	0	-2	0	0	0	0	0	0	0
0		25	0	0	99	0	-2	0	0	0	0	0	0	0

