##################################################
#  Data Formatting for BSB 2023 SS Assessment       #
#  J. McNamee  3/30/23                           #
#  updated by
# L Chong 2023-04-14
# G Fay 2023-04-16
##################################################

#load libraries
suppressPackageStartupMessages(library(tidyverse))
library(janitor)

##Load data
load(file.path(here::here(),"data","BSB.Index.Data.For.SS.RDATA"))
load(file.path(here::here(), "data","BSB.Index.Data.For.ESS.RDATA"))
load(file.path(here::here(),"data","BSB.Fishery.Data.For.SS.RDATA"))
load(file.path(here::here(),"data","BSB.Age.Data.With.Sex.For.SS.RDATA"))
load(file.path(here::here(), "data","BSB.Biological.Data.RDATA"))
fall_N_index <- read.csv(file.path(here::here(), "data","fall_northv2.csv"))
  fall_N_index <- as_tibble(fall_N_index)
fall_S_index <- read.csv(file.path(here::here(), "data","fall_southv2.csv"))
  fall_S_index <- as_tibble(fall_S_index)
spring_N_index <- read.csv(file.path(here::here(), "data","spring_north.csv"))
  spring_N_index <- as_tibble(spring_N_index)
spring_S_index <- read.csv(file.path(here::here(), "data","spring_south.csv"))
  spring_S_index <- as_tibble(spring_S_index)


# define length bins & a length lookup
Lbins <- c(seq(2,48,2),52,58,64,70)
nlenbins <- length(Lbins)
lenbins <- tibble(length = 1:100,
                  ibin = sapply(length,function(x) max(which(Lbins<x)))) |>
  mutate(ibin = ifelse(ibin==-Inf,1,ibin)) |>
  I()

##Start collecting re-organized data in a list
SS_BSB_dat1 = list(
  
  "###############################################",
  "##  Catch Data",
  "###############################################",
  "#_North_Trawl_1",
  N.Trawl.spr.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "NORTH", SEMESTER == 1, BSB.GEAR.CAT1 == "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 1, fleet = 1, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,  ##Note:Here season is 1 and 2, not 4 and 10 for months
  "#_South_Trawl_1",
  S.Trawl.spr.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "SOUTH", SEMESTER == 1, BSB.GEAR.CAT1 == "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 1, fleet = 2, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame ,
  "#_North_Trawl_2",
  N.Trawl.fall.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "NORTH", SEMESTER == 2, BSB.GEAR.CAT1 == "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 2, fleet = 3, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  "#_South_Trawl_2",
  S.Trawl.fall.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "SOUTH", SEMESTER == 2, BSB.GEAR.CAT1 == "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 2, fleet = 4, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  "#_North_NonTrawl_1",
  N.NonTrawl.spr.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "NORTH", SEMESTER == 1, BSB.GEAR.CAT1 != "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 1, fleet = 5, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  "#_South_NonTrawl_1",
  S.NonTrawl.spr.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "SOUTH", SEMESTER == 1, BSB.GEAR.CAT1 != "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 1, fleet = 6, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  "#_North_NonTrawl_2",
  N.NonTrawl.fall.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "NORTH", SEMESTER == 2, BSB.GEAR.CAT1 != "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 2, fleet = 7, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  "#_South_NonTrawl_2",
  S.NonTrawl.fall.Cat = comland.region.sem.mkt.gr %>% filter(STOCK == "SOUTH", SEMESTER == 2, BSB.GEAR.CAT1 != "TRAWL") %>% group_by(YEAR) %>% summarise(Catch=sum(land.mt)) %>%
    add_column(Seas = 2, fleet = 8, 
               .after = "YEAR") %>%
    add_column(CV = 0.01, 
               .after = "Catch") %>% data.frame,
  
  "#_North_Rec_1",
  N.Rec.spr.Cat = rec.agg.region.sem %>% filter(REGION == "North", SEMESTER == 1) %>% group_by(YEAR) %>% summarise(Catch=sum(AB1)/1000) %>%
    add_column(Seas = 1, fleet = 9, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Catch") %>% data.frame,  ###Just made up CV for now, need to discuss
  "#_South_Rec_1",
  S.Rec.spr.Cat = rec.agg.region.sem %>% filter(REGION == "South", SEMESTER == 1) %>% group_by(YEAR) %>% summarise(Catch=sum(AB1)/1000) %>%
    add_column(Seas = 1, fleet = 10, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Catch") %>% data.frame,
  "#_North_Rec_2",
  N.Rec.fall.Cat = rec.agg.region.sem %>% filter(REGION == "North", SEMESTER == 2) %>% group_by(YEAR) %>% summarise(Catch=sum(AB1)/1000) %>%
    add_column(Seas = 2, fleet = 11, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Catch") %>% data.frame,  ###Just made up CV for now, need to discuss
  "#_South_Rec_2",
  S.Rec.fall.Cat = rec.agg.region.sem %>% filter(REGION == "South", SEMESTER == 2) %>% group_by(YEAR) %>% summarise(Catch=sum(AB1)/1000) %>%
    add_column(Seas = 2, fleet = 12, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Catch") %>% data.frame,
  "###############################################",
  "##  Survey Index Data",
  "###############################################",
  "#_MA_Spring_Trawl",
  MA.spr.std = data.frame(year = MA.spr.agg[MA.spr.agg$Type == "Std", 1], seas = "4", index = "13",obs = MA.spr.agg[MA.spr.agg$Type == "Std", 2], CV = MA.spr.agg[MA.spr.agg$Type == "Std", 5]), 
  "#_MA_Fall_Trawl",
  MA.fall.std = data.frame(year = MA.fall.agg[MA.fall.agg$Type == "Std", 1], seas = "10", index = "14",obs = MA.fall.agg[MA.fall.agg$Type == "Std", 2], CV = MA.fall.agg[MA.fall.agg$Type == "Std", 5]),
  "#_RI_Spring_Trawl",
  RI.spr.std = data.frame(year = RI.spr.agg[RI.spr.agg$Type == "Std", 1], seas = "4", index = "15",obs = RI.spr.agg[RI.spr.agg$Type == "Std", 2], CV = RI.spr.agg[RI.spr.agg$Type == "Std", 5]),
  "#_RI_Fall_Trawl",
  RI.fall.std = data.frame(year = RI.fall.agg[RI.fall.agg$Type == "Std", 1], seas = "10", index = "16",obs = RI.fall.agg[RI.fall.agg$Type == "Std", 2], CV = RI.fall.agg[RI.fall.agg$Type == "Std", 5]),  #survey is new, how to number?
  "#_CT_Spring_Trawl",
  CT.spr.std = data.frame(year = CT.spr.agg[CT.spr.agg$Type == "Std", 1], seas = "4", index = "17",obs = CT.spr.agg[CT.spr.agg$Type == "Std", 2], CV = CT.spr.agg[CT.spr.agg$Type == "Std", 5]),
  "#_CT_Fall_Trawl",
  CT.fall.std = data.frame(year = CT.fall.agg[CT.fall.agg$Type == "Std", 1], seas = "10", index = "18",obs = CT.fall.agg[CT.fall.agg$Type == "Std", 2], CV = CT.fall.agg[CT.fall.agg$Type == "Std", 5]),
  "#_NY_Spring_Trawl_Age1",
  NY.mean = data.frame(year = NY.agg[, 1], seas = "4", index = "19",obs = NY.agg[, 2], CV = NY.agg[, 4]),
  "#_NJ_Trawl",
  NJ.mean = data.frame(year = NJ[, 1], seas = "4", index = "20",obs = NJ[, 2], CV = NJ[, 4]),
  "#_DE_Trawl",
  DE.mean = data.frame(year = DE.agg[-13, 1], seas = "4", index = "21",obs = DE.agg[-13, 2], CV = DE.agg[-13, 3]) |> filter(se!=0),  #Note: DE doesn't have a CV so CV is actually a SE, removed missing 1990 (the - row 13)
  "#_MD_Trawl",
  MD.mean = data.frame(year = MD.agg[, 1], seas = "4", index = "22",obs = exp(MD.agg[, 3]), CV = MD.agg[, 4]) |> filter(YEAR!=1996),  #Note: MD doesn't have a CV so CV is actually a SE, also index is a "LogMean"
  "#_VIMS_Trawl",
  VA.mean = data.frame(year = vims.agg[-32, 1], seas = "4", index = "23",obs = vims.agg[-32, 2], CV = 0.67),  #Note: No uncertainty estimate so just added 0.67 from previous dat file
  "#_NEAMAP_N_Spring_Trawl",
  NEAMAP.N.spr.mean = data.frame(year = neamap.spr.agg[neamap.spr.agg$BSB.Region == "NORTH", 2], seas = "4", index = "24",obs = neamap.spr.agg[neamap.spr.agg$BSB.Region == "NORTH", 3], CV = neamap.spr.agg[neamap.spr.agg$BSB.Region == "NORTH", 5]/neamap.spr.agg[neamap.spr.agg$BSB.Region == "NORTH", 3]), 
  "#_NEAMAP_S_Spring_Trawl",
  NEAMAP.S.spr.mean = data.frame(year = neamap.spr.agg[neamap.spr.agg$BSB.Region == "SOUTH", 2], seas = "4", index = "25",obs = neamap.spr.agg[neamap.spr.agg$BSB.Region == "SOUTH", 3], CV = neamap.spr.agg[neamap.spr.agg$BSB.Region == "SOUTH", 5]/neamap.spr.agg[neamap.spr.agg$BSB.Region == "SOUTH", 3]),
  "#_NEAMAP_N_Fall_Trawl",
  NEAMAP.N.fall.mean = data.frame(year = neamap.fall.agg[neamap.fall.agg$BSB.Region == "NORTH", 2], seas = "10", index = "26",obs = neamap.fall.agg[neamap.fall.agg$BSB.Region == "NORTH", 3], CV = neamap.fall.agg[neamap.fall.agg$BSB.Region == "NORTH", 5]/neamap.fall.agg[neamap.fall.agg$BSB.Region == "NORTH", 3]), 
  "#_NEAMAP_S_Fall_Trawl",
  NEAMAP.S.fall.mean = data.frame(year = neamap.fall.agg[neamap.fall.agg$BSB.Region == "SOUTH", 2], seas = "10", index = "27",obs = neamap.fall.agg[neamap.fall.agg$BSB.Region == "SOUTH", 3], CV = neamap.fall.agg[neamap.fall.agg$BSB.Region == "SOUTH", 5]/neamap.fall.agg[neamap.fall.agg$BSB.Region == "SOUTH", 3]),
  "#_NEFSC_N_Spring_Trawl",
  NEFSC.N.spr.mean = data.frame(year = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 3], seas = "4", index = "28",obs = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 9], CV = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 12]), 
  "#_NEFSC_S_Spring_Trawl",
  NEFSC.S.spr.mean = data.frame(year = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 3], seas = "4", index = "29",obs = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 9], CV = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "ALBATROSS", 12]),
  "#_Bigelow_N_Spring_Trawl",
  Big.N.spr.mean = data.frame(year = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 3], seas = "4", index = "30",obs = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 9], CV = nefsc.agg[nefsc.agg$STOCK_ABBREV == "NORTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 12]), 
  "#_Bigelow_S_Spring_Trawl",
  Big.S.spr.mean = data.frame(year = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 3], seas = "4", index = "31",obs = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 9], CV = nefsc.agg[nefsc.agg$STOCK_ABBREV == "SOUTH" & nefsc.agg$SEASON == "SPRING" & nefsc.agg$SERIES == "BIGELOW", 12]),
  ####NOTE: Winter survey not broken N-S, so couldn't update, but should be the same as before?
  "#_RecCPUE_N_spr",
  RecCPUE.N.mean = data.frame(year = RecCPA.agg[RecCPA.agg$Region == "North", 2], seas = "4", index = "9",obs = RecCPA.agg[RecCPA.agg$Region == "North", 3], CV = 0.38), #Note: Using previous average for RecCPUE CV until can get from Jeff
  "#_RecCPUE_S_spr",
  RecCPUE.S.mean = data.frame(year = RecCPA.agg[RecCPA.agg$Region == "South", 2], seas = "4", index = "11",obs = RecCPA.agg[RecCPA.agg$Region == "South", 3], CV = 0.25), #Note: Using previous average for RecCPUE CV until can get from Jeff
  "VAST_N_spr",
  VAST.N.spr = data.frame(year = spring_N_index$Year, seas = "4", index = "35", obs = spring_N_index$Index, CV = spring_N_index$Index_SD/spring_N_index$Index),
  "VAST_S_spr",
  VAST.S.spr = data.frame(year = spring_S_index$Year, seas = "4", index = "36", obs = spring_S_index$Index, CV = spring_S_index$Index_SD/spring_S_index$Index),
  "VAST_N_fall",
  VAST.N.fall = data.frame(year = fall_N_index$Year, seas = "10", index = "37", obs = fall_N_index$Index, CV = fall_N_index$IndexSD/fall_N_index$Index),
  "VAST_S_fall",
  VAST.S.fall = data.frame(year = fall_S_index$Year, seas = "10", index = "38", obs = fall_S_index$Index, CV = fall_S_index$Index_SD/fall_S_index$Index),
  
  "###############################################",
  "##  Discard Data",
  "###############################################",
  "#Disc_North_Trawl_1",
  N.Trawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "NORTH", SEMESTER == 1, FLEET == "TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 4, fleet = 1, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  ##Note: Dead discards for now, may want to switch to all discards, need to discuss; Also, here season is 4 and 10 for months and CV set to .3
  "#Disc_South_Trawl_1",
  S.Trawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "SOUTH", SEMESTER == 1, FLEET == "TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 4, fleet = 2, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,
  "#Disc_North_Trawl_2",
  N.Trawl.fall.Disc = comdisc.gr.sem %>% filter(REGION == "NORTH", SEMESTER == 2, FLEET == "TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 10, fleet = 3, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  
  "#Disc_South_Trawl_2",
  S.Trawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "SOUTH", SEMESTER == 2, FLEET == "TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 10, fleet = 4, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,
  "#Disc_North_NonTrawl_1",
  N.NonTrawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "NORTH", SEMESTER == 1, FLEET == "NON-TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 4, fleet = 5, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  
  "#Disc_South_NonTrawl_1",
  S.NonTrawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "SOUTH", SEMESTER == 1, FLEET == "NON-TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 4, fleet = 6, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,
  "#Disc_North_NonTrawl_2",
  N.NonTrawl.fall.Disc = comdisc.gr.sem %>% filter(REGION == "NORTH", SEMESTER == 2, FLEET == "NON-TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 10, fleet = 7, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  
  "#Disc_South_NonTrawl_2",
  S.NonTrawl.spr.Disc = comdisc.gr.sem %>% filter(REGION == "SOUTH", SEMESTER == 2, FLEET == "NON-TRAWL") %>% group_by(YEAR) %>% summarise(Discards=sum(Dead.Disc.mt)) %>%
    add_column(Seas = 10, fleet = 8, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,
  "#Disc_North_Rec_1",
  N.Rec.spr.Disc = rec.agg.region.sem %>% filter(REGION == "North", SEMESTER == 1) %>% group_by(YEAR) %>% summarise(Discards=sum(B2_dead)/1000) %>%
    add_column(Seas = 4, fleet = 9, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  ###Just made up CV for now, need to discuss and B2_dead or all B2s
  "#Disc_South_Rec_1",
  S.Rec.spr.Disc = rec.agg.region.sem %>% filter(REGION == "South", SEMESTER == 1) %>% group_by(YEAR) %>% summarise(Discards=sum(B2_dead)/1000) %>%
    add_column(Seas = 4, fleet = 10, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,
  "#Disc_North_Rec_2",
  N.Rec.fall.Disc = rec.agg.region.sem %>% filter(REGION == "North", SEMESTER == 2) %>% group_by(YEAR) %>% summarise(Discards=sum(B2_dead)/1000) %>%
    add_column(Seas = 10, fleet = 11, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame,  
  "#Disc_South_Rec_2",
  S.Rec.fall.Disc = rec.agg.region.sem %>% filter(REGION == "South", SEMESTER == 2) %>% group_by(YEAR) %>% summarise(Discards=sum(B2_dead)/1000) %>%
    add_column(Seas = 10, fleet = 12, 
               .after = "YEAR") %>%
    add_column(CV = 0.3, 
               .after = "Discards") %>% data.frame)

#create lookup table for commercial fleets
fishery_ids <- expand.grid(stock = c("NORTH","SOUTH"),
                           semester = 1:2,
                           gear = c("trawl", "non-trawl")) |>
  tibble() |>
  mutate_if(is.factor, as.character) |>
  mutate(index = 1:8) |>
  I()
fishery_ids


### length frequency of catch

# landings by mkt category, needed to weight the length comps
comland <- comland.region.sem.mkt.gr |>
  ungroup() |>
  clean_names() |>
  mutate(gear = ifelse(bsb_gear_cat1=="TRAWL","trawl","non-trawl")) |>
  select(-bsb_gear_cat1) |>
  left_join(fishery_ids) |>
  I()
comland


comlens <- comlen.region.sem.mkt.gr |>
  ungroup() |>
  clean_names() |>
  filter(stock %in% c("NORTH", "SOUTH")) |> #about 240 fish that don't have a region (UNK) assigned to them
  mutate(gear = ifelse(bsb_gear_cat1=="TRAWL","trawl","non-trawl")) |>
  select(-bsb_gear_cat1) |>
  left_join(comland) |>
  filter(!is.na(index)) |> # remove one(!) fish of length bin 32 in 2008, semester 2, trawl, unclassified market category, because no corresponding weight
  mutate(cal = numlen*land_mt,
         season = ifelse(semester==1,4,10)) |>
  select(-semester) |>
  left_join(lenbins) |>
  group_by(index, year, ibin, season, mktnm) |>
  summarize(cal = sum(cal, na.rm = TRUE), .groups = "drop") |>
  group_by(index, year, season) |>
  mutate(cal = round(cal/sum(cal, na.rm = TRUE), digits = 7)) |>
  ungroup() |>
  mutate(gender = 0,
         part = 2) |> 
  I()
#comlens

# comlens sample size
comlens_samp <- comlen.nsamp.region.sem.mkt.gr |>
  ungroup() |>
  clean_names() |>
  filter(stock %in% c("NORTH", "SOUTH")) |>
  mutate(gear = ifelse(bsb_gear_cat2=="TRAWL","trawl","non-trawl")) |>
  filter(stock != "UNK") |>
  select(-bsb_gear_cat2) |>
  left_join(fishery_ids) |>
  mutate(season = ifelse(semester==1,4,10), nsamp = nsamples) |>
  group_by(index, year, season, mktnm) |>
  summarise(nsamp = sum(nsamp, na.rm = TRUE), .groups = "drop") |>
  I()

# combine comlens and sample sizes
comlens <- comlens |>
  left_join(comlens_samp, by = c("index", "year", "season", "mktnm")) |>
  group_by(index, year, ibin, season, gender, part) |>
  summarise(cal =  sum(cal, na.rm = TRUE), nsamp = sum(nsamp, na.rm = TRUE), .groups = "drop") |>
  I()

fishery_lens <- comlens  

# recreational lengths

recfishery_ids <- expand.grid(region = c("North","South"),
                              semester = 1:2) |>
  tibble() |>
  mutate_if(is.factor,as.character) |>
  mutate(index = 9:12)
recfishery_ids  

reclens <- rec.exp.ab1b2.len |>
  clean_names() |>
  left_join(recfishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  rename(length = l_cm_bin) |>
  select(-semester, 
         -n_ab1b2,
         -region) |>
  pivot_longer(cols = c("n_ab1","n_b2"),
               names_to = "part",
               values_to = "cal") |>
  filter(cal>0) |>
  mutate(part = as.numeric(ifelse(part == "n_ab1",2,1))) |>
  left_join(lenbins) |>
  group_by(index, year, ibin, season, part) |>
  summarize(cal = sum(cal, na.rm = TRUE), .groups = "drop") |>
  group_by(index, year, season, part) |>
  mutate(cal = round(cal/sum(cal, na.rm = TRUE), digits = 7)) |>
  ungroup() |>
  mutate(gender = 0) |> 
  I()
reclens

# extract sample size for harvest
reclensharv <- rec.ab1.len |>
  clean_names() |>
  left_join(recfishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  rename(nsamp = sample_size) |>
  rename(length = l_cm_bin) |>
  select(-semester,
         -n_ab1,
         -region) |>	
  left_join(lenbins) |>
  group_by(index, year, ibin, season) |>
  summarise(nsamp = sum(nsamp, na.rm = TRUE), .groups = "drop") |>
  mutate(part = 2) |>
  I()
reclensharv

# extract sample size for discard
reclensdisc <- rec.b2.len |>
  clean_names() |>
  left_join(recfishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  rename(nsamp = sample_size) |>
  rename(length = l_cm_bin) |>
  filter(nsamp > 0) |>
  select(-disposition, 
         -data_source,
         -semester,
         -region,
         -sample_size_scaled) |>
  left_join(lenbins) |>
  group_by(index, year, ibin, season) |>
  summarise(nsamp = sum(nsamp, na.rm = TRUE), .groups = "drop") |>
  mutate(part = 1) |>
  I()
reclensdisc

# integrate discard sample size  
reclens <- reclens |>
  left_join(reclensharv) |>
  left_join(reclensdisc) |>
  na.omit() |> # missing sample sizes for discards in certain years
  I()

fishery_lens <- bind_rows(comlens, reclens)

# commercial discards
disc_lens <- comdisc.len |>
  clean_names() |>
  rename(gear = bsb_fleet) |>
  mutate(gear = tolower(gear)) |>
  select(-bsb_gear_cat) |>
  left_join(fishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  left_join(lenbins) |>
  select(-semester,-region,-length) |>
  group_by(index, year, season, source, ibin) |>
  summarize(cal = n(), .groups = "drop") |>
  group_by(index, year, season, source) |>
  mutate(cal = round(cal/sum(cal, na.rm = TRUE), digits = 7)) |>
  ungroup() |>
  mutate(gender = 0,
         part = 1,
         index = ifelse(source == "CFRF",-1*index,index)) |>
  select(-source) |>
  I()
disc_lens

# sample size for comdisc.len
comdisc_samp_trawl <- comdisc.nhaul.fleet |>
  clean_names() |>
  select(-non_trawl) |>
  mutate(gear = "trawl") |>
  left_join(fishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  group_by(index, year, season) |>
  summarize(nsamp = sum(trawl, na.rm = TRUE), .groups = "drop") |>
  I()
comdisc_samp_trawl

comdisc_samp_nontrawl<- comdisc.nhaul.fleet |>
  clean_names() |>
  select(-trawl) |>
  mutate(gear = "non-trawl") |>
  left_join(fishery_ids) |>
  mutate(season = ifelse(semester==1,4,10)) |>
  group_by(index, year, season) |>
  summarize(nsamp = sum(non_trawl, na.rm = TRUE), .groups = "drop") |>
  I()
comdisc_samp_nontrawl

disc_lens <- disc_lens |>
  left_join(comdisc_samp_trawl, by = c("index", "year", "season")) |> # joins only by index, year, season
  left_join(comdisc_samp_nontrawl, by = c("index", "year", "season")) |>
  mutate(nsamp_temp = ifelse(index < 0, 25, NA)) |># sample size for CFRF?
  rowwise() |> mutate(nsamp = sum(nsamp.x, nsamp.y, nsamp_temp, na.rm = TRUE)) |>
  select(-nsamp.x, -nsamp.y, -nsamp_temp) |> 
  I()
disc_lens

fishery_lens <- bind_rows(comlens, reclens, disc_lens)


fillbins <- unique(lenbins$ibin)[!unique(lenbins$ibin) %in% fishery_lens$ibin]
filllens <- fishery_lens |>
  slice(1:length(fillbins)) |>
  mutate(cal = 0,
         ibin = fillbins) |>
  I()

fishery_lens <- fishery_lens |>
  bind_rows(filllens) |>
  group_by(index, year, ibin, season, gender, part, nsamp) |>
  summarise(cal = sum(cal, na.rm = TRUE), .groups = "drop") |>
  ungroup() |>
  pivot_wider(names_from = ibin,
              names_prefix = "bin_",
              values_from = cal,
              names_sort = TRUE,
              values_fill = 0
  ) |>
  group_by(index, year, season, gender, part) |>
  summarize(across(c(nsamp, everything()), sum)) |>
  ungroup() |>
  #Yr Seas Flt/Svy Gender Part Nsamp datavector(female-male)
  select(year, season, index, gender, part, nsamp, everything()) |>
  I()
fishery_lens2 <- fishery_lens |>
  select(-(1:6)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))
fishery_lens_write <- bind_cols(fishery_lens, fishery_lens2)  


# "###############################################",
# "##  Length Frequency Data",
# "###############################################",
# "#LF_North_Trawl_1",
# 
# NTrawl.spr.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "NORTH" & comlen.region.sem.mkt.gr$SEMESTER == 1 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Flt = 1, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ), sum)[1,,1,2]),
#              .after = "YEAR") %>% data.frame,  ##There are UNKNOWNs in the stock area, not sure what to do with these, for now ignored, note: missing years90, 91, 94, 95, 98
# "#LF_South_Trawl_1",
# STrawl.spr.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "SOUTH" & comlen.region.sem.mkt.gr$SEMESTER == 1 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Flt = 2, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ), sum)[2,,1,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Trawl_2",
# NTrawl.fall.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "NORTH" & comlen.region.sem.mkt.gr$SEMESTER == 2 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 10, Flt = 3, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ), sum)[1,,2,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing years 89-94, 98, 2000, 2002
# "#LF_South_Trawl_2",
# STrawl.fall.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "SOUTH" & comlen.region.sem.mkt.gr$SEMESTER == 2 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 10, Flt = 4, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 == "TRAWL" ), sum)[2,,2,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing years 2001
# "#LF_North_NonTrawl_1",
# N.NonTrawl.spr.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "NORTH" & comlen.region.sem.mkt.gr$SEMESTER == 1 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Flt = 5, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ), sum)[1,,1,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing years89,90, 93, 94, 96-98, 2000, 2001, 2010, 2017-19, 2021
# "#LF_South_NonTrawl_1",
# S.NonTrawl.spr.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "SOUTH" & comlen.region.sem.mkt.gr$SEMESTER == 1 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Flt = 6, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ), sum)[2,,1,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing 89, 90, 92-94
# "#LF_North_NonTrawl_2",
# N.NonTrawl.fall.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "NORTH" & comlen.region.sem.mkt.gr$SEMESTER == 2 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 10, Flt = 7, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ), sum)[1,,2,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing years 89-97, 99, 2001, 2002, 2011, 2015, 2016, 2018, 2020, 2021
# "#LF_South_NonTrawl_2",
# S.NonTrawl.fall.LF = comlen.region.sem.mkt.gr[comlen.region.sem.mkt.gr$STOCK == "SOUTH" & comlen.region.sem.mkt.gr$SEMESTER == 2 & comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ,c(-1,-2,-3,-5)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 10, Flt = 8, Gender = 0,
#              Part = 2, NSamp = na.omit(tapply(comlen.region.sem.mkt.gr$NUMLEN, list(comlen.region.sem.mkt.gr$STOCK, comlen.region.sem.mkt.gr$YEAR, comlen.region.sem.mkt.gr$SEMESTER, comlen.region.sem.mkt.gr$BSB.GEAR.CAT1 != "TRAWL" ), sum)[2,,2,2]),
#              .after = "YEAR") %>% data.frame,  ##Note: missing years 2001
# "#LF_North_Rec_1",
# NRec.spr.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "North" & rec.exp.ab1b2.len$SEMESTER == 1 ,c(-2,-3,-6,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_AB1,
#     values_fn = sum,
#     values_fill = list(N_AB1 = 0)) %>%
#   add_column(Seas = 4, Flt = 9, Gender = 0,
#              Part = 2, NSamp = tapply(rec.exp.ab1b2.len$N_AB1, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[1,,1],
#              .after = "YEAR") %>% data.frame,  ##I used the data labeled expanded, think this is correct
# "#LF_South_Rec_1",
# SRec.spr.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "South" & rec.exp.ab1b2.len$SEMESTER == 1 ,c(-2,-3,-6,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_AB1,
#     values_fn = sum,
#     values_fill = list(N_AB1 = 0)) %>%
#   add_column(Seas = 4, Flt = 10, Gender = 0,
#              Part = 2, NSamp = tapply(rec.exp.ab1b2.len$N_AB1, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[2,,1],
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Rec_2",
# NRec.fall.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "North" & rec.exp.ab1b2.len$SEMESTER == 2 ,c(-2,-3,-6,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_AB1,
#     values_fn = sum,
#     values_fill = list(N_AB1 = 0)) %>%
#   add_column(Seas = 10, Flt = 11, Gender = 0,
#              Part = 2, NSamp = tapply(rec.exp.ab1b2.len$N_AB1, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[1,,2],
#              .after = "YEAR") %>% data.frame,
# "#LF_South_Rec_2",
# SRec.fall.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "South" & rec.exp.ab1b2.len$SEMESTER == 2 ,c(-2,-3,-6,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_AB1,
#     values_fn = sum,
#     values_fill = list(N_AB1 = 0)) %>%
#   add_column(Seas = 10, Flt = 12, Gender = 0,
#              Part = 2, NSamp = tapply(rec.exp.ab1b2.len$N_AB1, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[2,,2],
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Trawl_Disc_1",
# NTrawl.spr.Disc.LF = comdisc.len[comdisc.len$REGION == "North" & comdisc.len$SEMESTER == 1 & comdisc.len$BSB.FLEET == "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 4, Flt = 1, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET == "TRAWL" ), length)[1,,1,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_South_Trawl_Disc_1",
# STrawl.spr.Disc.LF = comdisc.len[comdisc.len$REGION == "South" & comdisc.len$SEMESTER == 1 & comdisc.len$BSB.FLEET == "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 4, Flt = 2, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET == "TRAWL" ), length)[2,,1,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Trawl_Disc_2",
# NTrawl.fall.Disc.LF = comdisc.len[comdisc.len$REGION == "North" & comdisc.len$SEMESTER == 2 & comdisc.len$BSB.FLEET == "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 10, Flt = 3, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET == "TRAWL" ), length)[1,,2,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_South_Trawl_Disc_2",
# STrawl.fall.Disc.LF = comdisc.len[comdisc.len$REGION == "South" & comdisc.len$SEMESTER == 2 & comdisc.len$BSB.FLEET == "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 10, Flt = 4, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET == "TRAWL" ), length)[2,,2,2]),
#              .after = "YEAR") %>% data.frame,
# 
# "#LF_North_NonTrawl_Disc_1",
# N.NonTrawl.spr.Disc.LF = comdisc.len[comdisc.len$REGION == "North" & comdisc.len$SEMESTER == 1 & comdisc.len$BSB.FLEET != "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 4, Flt = 5, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET != "TRAWL" ), length)[1,,1,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_South_NonTrawl_Disc_1",
# S.NonTrawl.spr.Disc.LF = comdisc.len[comdisc.len$REGION == "South" & comdisc.len$SEMESTER == 1 & comdisc.len$BSB.FLEET != "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 4, Flt = 6, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET != "TRAWL" ), length)[2,,1,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_North_NonTrawl_Disc_2",
# N.NonTrawl.fall.Disc.LF = comdisc.len[comdisc.len$REGION == "North" & comdisc.len$SEMESTER == 2 & comdisc.len$BSB.FLEET != "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 10, Flt = 7, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET != "TRAWL" ), length)[1,,2,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_South_NonTrawl_Disc_2",
# S.NonTrawl.fall.Disc.LF = comdisc.len[comdisc.len$REGION == "South" & comdisc.len$SEMESTER == 2 & comdisc.len$BSB.FLEET != "TRAWL" ,c(-2,-3,-4,-6, -7)] %>%
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = LENGTH,
#     values_fn = length,
#     values_fill = list(LENGTH = 0)) %>%
#   add_column(Seas = 10, Flt = 8, Gender = 0,
#              Part = 1, NSamp = na.omit(tapply(comdisc.len$LENGTH, list(comdisc.len$REGION, comdisc.len$YEAR, comdisc.len$SEMESTER, comdisc.len$BSB.FLEET != "TRAWL" ), length)[2,,2,2]),
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Rec_Disc_1",
# NRec.spr.Disc.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "North" & rec.exp.ab1b2.len$SEMESTER == 1 ,c(-2,-3,-5,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_B2,
#     values_fn = sum,
#     values_fill = list(N_B2 = 0)) %>%
#   add_column(Seas = 4, Flt = 9, Gender = 0,
#              Part = 1, NSamp = tapply(rec.exp.ab1b2.len$N_B2, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[1,,1],
#              .after = "YEAR") %>% data.frame,
# "#LF_South_Rec_Disc_1",
# SRec.spr.Disc.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "South" & rec.exp.ab1b2.len$SEMESTER == 1 ,c(-2,-3,-5,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_B2,
#     values_fn = sum,
#     values_fill = list(N_B2 = 0)) %>%
#   add_column(Seas = 4, Flt = 10, Gender = 0,
#              Part = 1, NSamp = tapply(rec.exp.ab1b2.len$N_B2, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[2,,1],
#              .after = "YEAR") %>% data.frame,
# "#LF_North_Rec_Disc_2",
# NRec.fall.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "North" & rec.exp.ab1b2.len$SEMESTER == 2 ,c(-2,-3,-5,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_B2,
#     values_fn = sum,
#     values_fill = list(N_B2 = 0)) %>%
#   add_column(Seas = 10, Flt = 11, Gender = 0,
#              Part = 1, NSamp = tapply(rec.exp.ab1b2.len$N_B2, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[1,,2],
#              .after = "YEAR") %>% data.frame,
# "#LF_South_Rec_2",
# SRec.fall.LF = rec.exp.ab1b2.len[rec.exp.ab1b2.len$REGION == "South" & rec.exp.ab1b2.len$SEMESTER == 2 ,c(-2,-3,-5,-7)] %>%
#   pivot_wider(
#     names_from = L_CM_BIN,
#     names_sort = T,
#     values_from = N_B2,
#     values_fn = sum,
#     values_fill = list(N_B2 = 0)) %>%
#   add_column(Seas = 10, Flt = 12, Gender = 0,
#              Part = 1, NSamp = tapply(rec.exp.ab1b2.len$N_B2, list(rec.exp.ab1b2.len$REGION, rec.exp.ab1b2.len$YEAR, rec.exp.ab1b2.len$SEMESTER), sum)[2,,2],
#              .after = "YEAR") %>% data.frame)

## index lengths code starts here.

objects <- c("MA.spr.CAL","MA.fall.CAL",
             "RI.spr.CAL","RI.fall.CAL",
             "CT.spr.CAL","CT.fall.CAL")
survey_index <- c(13, 14, 15, 16, 17, 18)
state_survey_lens <- map_dfr(objects, function(x) get(x)|>clean_names()|>
                               select(-season) |> mutate_if(is.character, as.numeric),
                             .id = "index") |>
  mutate(index = survey_index[as.integer(index)],
         season = ifelse(semester==1,4,10),
         #gender = 0,
         #part = 0,
  )
state_survey_lens

samp_objects <- c("MA.fall", "MA.spr",
                  "RI.fall", "RI.spr",
                  "LIS.fall", "LIS.spr")
state_samp <- map_dfr(samp_objects, function(x) get(x) |> clean_names(),
                      .id = "index") |>
  mutate(index = survey_index[as.integer(index)],
         season = ifelse(month > 6, 4, 10)) |>
  group_by(index, year, season) |>
  summarise(nsamp = sum(tot_n, na.rm = TRUE), .groups = "drop") |>
  mutate_if(is.factor, as.character) |>
  mutate_if(is.character, as.numeric) 

state_survey_lens <- state_survey_lens |>
  left_join(state_samp) |>
  na.omit()

nj <- NJ.CAL |>
  clean_names() |>
  mutate(season = 4,
         index = 20) |>
  mutate_if(is.character,as.numeric)

nj_samp <- NJ.June |>
  clean_names() |>
  group_by(year) |>
  summarise(nsamp = sum(tot_n), .groups = "drop")

nj <- nj |>
  left_join(nj_samp)

state_survey_lens <- bind_rows(state_survey_lens, nj) |>
  select(-semester)
## gender
## part

#lots of missing surveys (DE, MD, VIMS)

# MA trawl
#  "#LF_MA_Spring_Trawl",
#  MA.spr.LF <- MA.spr.lfreq[,c(-2,-3)] %>% 
# pivot_wider(
#   names_from = Length.cm,
#   names_sort = T,
#   values_from = Num.len,
#   values_fn = sum,
#   values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 4, Index = 13, Gender = 0, 
#              Part = 0, NSamp = tapply(MA.spr.lfreq$Num.len, MA.spr.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame, 
# "#LF_MA_Fall_Trawl",
# MA.fall.LF = MA.fall.lfreq[,c(-2,-3)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 10, Index = 14, Gender = 0, 
#              Part = 0, NSamp = tapply(MA.fall.lfreq$Num.len, MA.fall.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
# "#LF_RI_Spring_Trawl",
# RI.spr.LF = RI.spr.lfreq[,c(-2,-3, -4)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 4, Index = 16, Gender = 0, 
#              Part = 0, NSamp = tapply(RI.spr.lfreq$Num.len, RI.spr.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
# "#LF_RI_Fall_Trawl",
# RI.fall.LF = RI.fall.lfreq[,c(-2,-3,-4)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 10, Index = "17", Gender = 0, 
#              Part = 0, NSamp = tapply(RI.fall.lfreq$Num.len, RI.fall.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
# "#LF_CT_Spring_Trawl",
# CT.spr.LF = CT.spr.lfreq[,c(-2,-3)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 4, Index = 18, Gender = 0, 
#              Part = 0, NSamp = tapply(CT.spr.lfreq$Num.len, CT.spr.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
# "#LF_CT_Fall_Trawl",
# CT.fall.LF = CT.fall.lfreq[,c(-2,-3)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 10, Index = "19", Gender = 0, 
#              Part = 0, NSamp = tapply(CT.fall.lfreq$Num.len, CT.fall.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
# "#LF_NJ_Trawl",
# NJ.mean.LF = NJ.lfreq[,c(-2)] %>% 
#   pivot_wider(
#     names_from = Length.cm,
#     names_sort = T,
#     values_from = Num.len,
#     values_fn = sum,
#     values_fill = list(Num.len = 0)) %>%
#   add_column(Seas = 4, Index = 21, Gender = 0, 
#              Part = 0, NSamp = tapply(NJ.lfreq$Num.len, NJ.lfreq$Year, sum), 
#              .after = "Year") %>% data.frame,
objects <- c("neamap.spr.CAL",
             "neamap.fall.CAL"
)
neamap_lens <- map_dfr(objects, function(x) get(x)|>clean_names(),
                       .id = "index") |>
  mutate(season = ifelse(index==1,4,10),
         index = case_when(
           index == 1 & bsb_region == "NORTH" ~ 24,
           index == 1 & bsb_region == "SOUTH" ~ 25,
           index == 2 & bsb_region == "NORTH" ~ 26,
           index == 2 & bsb_region == "SOUTH" ~ 27),
         length = as.numeric(as.character(length_cm))) |>
  select(-bsb_region, -length_cm, -prop_length)
#neamap_lens

neamap_samp <- neamap.all |>
  clean_names() |>
  mutate(season = ifelse(season == "Fall",10,4),
         index = case_when(
           season == 4 & bsb_region == "NORTH" ~ 24,
           season == 4 & bsb_region == "SOUTH" ~ 25,
           season == 10 & bsb_region == "NORTH" ~ 26,
           season == 10 & bsb_region == "SOUTH" ~ 27)) |>
  group_by(index, year, season) |>
  summarise(nsamp = sum(tot_n, na.rm = TRUE), .groups = "drop")

neamap_lens <- neamap_lens |>
  left_join(neamap_samp)

# 
#   "#LF_NEAMAP_N_Spring_Trawl",
#   NEAMAP.N.spr.LF = neamap.spr.lfreq[neamap.spr.lfreq$BSB.Region == "NORTH",c(-1,-3,-4,-5,-8)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = Tot.numlen,
#       values_fn = sum,
#       values_fill = list(Tot.numlen = 0)) %>%
#     add_column(Seas = 4, Index = 26, Gender = 0, 
#                Part = 0, NSamp = tapply(neamap.spr.lfreq$Tot.numlen, list(neamap.spr.lfreq$BSB.Region, neamap.spr.lfreq$Year), sum)[1,], 
#                .after = "Year") %>% data.frame,
#   "#LF_NEAMAP_S_Spring_Trawl",
#   NEAMAP.S.spr.LF = neamap.spr.lfreq[neamap.spr.lfreq$BSB.Region == "SOUTH",c(-1,-3,-4,-5,-8)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = Tot.numlen,
#       values_fn = sum,
#       values_fill = list(Tot.numlen = 0)) %>%
#     add_column(Seas = 4, Index = 27, Gender = 0, 
#                Part = 0, NSamp = tapply(neamap.spr.lfreq$Tot.numlen, list(neamap.spr.lfreq$BSB.Region, neamap.spr.lfreq$Year), sum)[2,], 
#                .after = "Year") %>% data.frame,
#   "#LF_NEAMAP_N_Fall_Trawl",
#   NEAMAP.N.fall.LF = neamap.fall.lfreq[neamap.fall.lfreq$BSB.Region == "NORTH",c(-1,-3,-4,-5,-8)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = Tot.numlen,
#       values_fn = sum,
#       values_fill = list(Tot.numlen = 0)) %>%
#     add_column(Seas = 10, Index = 29, Gender = 0, 
#                Part = 0, NSamp = tapply(neamap.fall.lfreq$Tot.numlen, list(neamap.fall.lfreq$BSB.Region, neamap.fall.lfreq$Year), sum)[1,], 
#                .after = "Year") %>% data.frame,
#   "#LF_NEAMAP_S_Fall_Trawl",
#   NEAMAP.S.fall.LF = neamap.fall.lfreq[neamap.fall.lfreq$BSB.Region == "SOUTH",c(-1,-3,-4,-5,-8)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = Tot.numlen,
#       values_fn = sum,
#       values_fill = list(Tot.numlen = 0)) %>%
#     add_column(Seas = 10, Index = 30, Gender = 0, 
#                Part = 0, NSamp = tapply(neamap.fall.lfreq$Tot.numlen, list(neamap.fall.lfreq$BSB.Region, neamap.fall.lfreq$Year), sum)[2,], 
#                .after = "Year") %>% data.frame,

nefsc_lens <- nefsc.CAL |>
  clean_names() |>
  #filter(season!="SPRING") |>.  #getting rid of winter
  mutate(
    index = case_when(
      series == "ALBATROSS" & stock_abbrev == "NORTH" ~ 28,
      series == "ALBATROSS" & stock_abbrev == "SOUTH" ~ 29,
      series == "BIGELOW" & stock_abbrev == "NORTH" ~ 30,
      series == "BIGELOW" & stock_abbrev == "SOUTH" ~ 31),
    index = ifelse(season == "WINTER" & stock_abbrev == "SOUTH",33,index),
    season = 4, # only have spring & winter right now. ifelse(season=="SPRING",4,10),
    cal = no_at_length) |>
  select(year, season, index, length, cal)

nefsc_samp <- nefsc.pos.tows |>
  clean_names() |>
  mutate(index = case_when(
    year < 2009 & stock_abbrev == "NORTH" ~ 28,
    year < 2009 & stock_abbrev == "SOUTH" ~ 29,
    year >= 2009 & stock_abbrev == "NORTH" ~ 30,
    year >= 2009 & stock_abbrev == "SOUTH" ~ 31),
    index = ifelse(season == "WINTER" & stock_abbrev == "SOUTH", 33, index),
    season = 4) |>
  group_by(index, year, season) |>
  summarise(nsamp = sum(stations_pos_catch, na.rm = TRUE), .groups = "drop")

nefsc_lens <- nefsc_lens |>
  left_join(nefsc_samp) |>
  relocate(index, year, cal, season, length, nsamp)

#nefsc_lens

#winter survey not split N/S

# "#LF_NEFSC_N_Spring_Trawl",
# NEFSC.N.spr.LF = nefsc.lfreq[nefsc.lfreq$STOCK_ABBREV == "NORTH" & nefsc.lfreq$SEASON == "SPRING" & nefsc.lfreq$SERIES == "ALBATROSS" ,c(-1,-2,-4,-7)] %>% 
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Index = 31, Gender = 0, 
#              Part = 0, NSamp = tapply(nefsc.lfreq$NUMLEN, list(nefsc.lfreq$STOCK_ABBREV, nefsc.lfreq$YEAR, nefsc.lfreq$SERIES), sum)[1,1:20,1], 
#              .after = "YEAR") %>% data.frame,
# "#LF_NEFSC_S_Spring_Trawl",
# NEFSC.S.spr.LF = nefsc.lfreq[nefsc.lfreq$STOCK_ABBREV == "SOUTH" & nefsc.lfreq$SEASON == "SPRING" & nefsc.lfreq$SERIES == "ALBATROSS",c(-1,-2,-4,-7)] %>% 
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Index = 32, Gender = 0, 
#              Part = 0, NSamp = tapply(nefsc.lfreq$NUMLEN, list(nefsc.lfreq$STOCK_ABBREV, nefsc.lfreq$YEAR, nefsc.lfreq$SERIES), sum)[2,1:20,1], 
#              .after = "YEAR") %>% data.frame,
# "#_Bigelow_N_Spring_Trawl",
# Big.N.spr.LF = nefsc.lfreq[nefsc.lfreq$STOCK_ABBREV == "NORTH" & nefsc.lfreq$SEASON == "SPRING" & nefsc.lfreq$SERIES == "BIGELOW",c(-1,-2,-4,-7)] %>% 
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Index = 35, Gender = 0, 
#              Part = 0, NSamp = tapply(nefsc.lfreq$NUMLEN, list(nefsc.lfreq$STOCK_ABBREV, nefsc.lfreq$YEAR, nefsc.lfreq$SERIES), sum)[1,21:33,2], 
#              .after = "YEAR") %>% data.frame,
# "#_Bigelow_S_Spring_Trawl",
# Big.S.spr.LF = nefsc.lfreq[nefsc.lfreq$STOCK_ABBREV == "SOUTH" & nefsc.lfreq$SEASON == "SPRING" & nefsc.lfreq$SERIES == "BIGELOW",c(-1,-2,-4,-7)] %>% 
#   pivot_wider(
#     names_from = LENGTH,
#     names_sort = T,
#     values_from = NUMLEN,
#     values_fn = sum,
#     values_fill = list(NUMLEN = 0)) %>%
#   add_column(Seas = 4, Index = 36, Gender = 0, 
#              Part = 0, NSamp = tapply(nefsc.lfreq$NUMLEN, list(nefsc.lfreq$STOCK_ABBREV, nefsc.lfreq$YEAR, nefsc.lfreq$SERIES), sum)[2,21:33,2], 
#              .after = "YEAR") %>% data.frame,
####NOTE: Winter survey not broken N-S, so couldn't update, but should be the same as before?

# rec_cpue_lens <- rec.CAL |>
#   clean_names() |>
#   mutate(season = ifelse(semester==1,4,10),
#          index = case_when(
#            #GF - not sure why these have their own numbering, should be the same index as the catch
#            season == 4 & region == "North" ~ 9, #35,
#            season == 4 & region == "South" ~ 10, #36,
#            season == 10 & region == "North" ~ 11, #37,
#            season == 10 & region == "South" ~ 12)) |> #38)) |>
#   rename(length = length_cm,
#          cal = n_ab1b2) |>
#   select(year, season, index, length, cal)


# "#LF_RecCPUE_N_spr",
#   RecCPUE.N.spr.LF = rec.CAL[rec.CAL$REGION == "North" & rec.CAL$SEMESTER == "1",c(-2,-3)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = N_AB1B2,
#       values_fn = sum,
#       values_fill = list(N_AB1B2 = 0)) %>%
#     add_column(Seas = 4, Index = 40, Gender = 0, 
#                Part = 0, NSamp = tapply(rec.CAL$N_AB1B2, list(rec.CAL$REGION, rec.CAL$Year, rec.CAL$SEMESTER), sum)[1,,1], 
#                .after = "Year") %>% data.frame,
#   "#LF_RecCPUE_S_spr",
#   RecCPUE.S.spr.LF = rec.CAL[rec.CAL$REGION == "South" & rec.CAL$SEMESTER == "1",c(-2,-3)] %>% 
#     pivot_wider(
#       names_from = Length.cm,
#       names_sort = T,
#       values_from = N_AB1B2,
#       values_fn = sum,
#       values_fill = list(N_AB1B2 = 0)) %>%
#     add_column(Seas = 4, Index = 41, Gender = 0, 
#                Part = 0, NSamp = tapply(rec.CAL$N_AB1B2, list(rec.CAL$REGION, rec.CAL$Year, rec.CAL$SEMESTER), sum)[2,,1], 
#                .after = "Year") %>% data.frame,  ###Note, there is fall LF data for recCPUE, but no fall index, not sure what to do


# now put the lengths together, create proportions by length bin, and put in ss format
len_data <- bind_rows(state_survey_lens, 
                      neamap_lens, 
                      nefsc_lens) |>
  # , rec_cpue_lens) |>
  left_join(lenbins) |>
  select(-length)
# no observations in bin 27 & 28 so create dummy table to fill these columns
bigfish <- len_data |>
  slice(c(1,2)) |>
  mutate(ibin = 27,
         cal = 0) 
bigfish$ibin[2] <- 28

#bigfish
# now create proportions by bin and wrangle into ss shape
len_data <-  len_data |>
  bind_rows(bigfish) |>
  group_by(index, year, season, ibin, nsamp) |>
  summarize(cal = sum(cal, na.rm = TRUE), .groups = "drop") |>
  group_by(index, year, season) |>
  mutate(cal = round(cal/sum(cal, na.rm = TRUE), digits = 7)) |>
  ungroup() |>
  pivot_wider(names_from = ibin,
              names_prefix = "bin_",
              values_from = cal,
              names_sort = TRUE,
              values_fill = 0
  ) |>
  mutate(gender = 0,
         part = 0) |>
  #Yr Seas Flt/Svy Gender Part Nsamp datavector(female-male)
  select(year, season, index, gender, part, nsamp, everything()) |>
  filter(nsamp > 0) |>
  I()
#len_data
len_data2 <- len_data |>
  select(-(1:6)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))
len_data_write <- bind_cols(len_data, len_data2)  


### age compositions
fishery_ids_ac <- expand.grid(region = c("NORTH","SOUTH"),
                              semester = 1:2,
                              gear = c("trawl", "non-trawl")) |>
  tibble() |>
  mutate_if(is.factor, as.character) |>
  mutate(index = 1:8) |>
  I()

comm_ac <- fishery.alfreq.region.sem.gr |>
  ungroup() |>
  clean_names() |>
  mutate(gear = ifelse(gear == "TRAWL", "trawl", "non-trawl")) |>
  mutate(season = ifelse(semester == 1,4,10)) |>
  filter(region != "UNK") |>
  left_join(fishery_ids_ac) |>
  left_join(lenbins) |>
  group_by(index,year,age,ibin,season) |>
  summarize(num = sum(numage, na.rm = TRUE), .groups = "drop") |>
  mutate(lo = ibin, hi = ibin) |>
  select(-c(ibin)) |>
  pivot_wider(names_from = age,
              names_prefix = "bin_",
              names_sort = TRUE,
              values_from = num,
              values_fill = 0) |>
  arrange(index, year) %>%
  mutate(ageerr = 1,
         gender = 3,
         part = 0,
         nsamp = rowSums(.[grep("bin", names(.))], na.rm = T)) |>
  I()

nefsc_ac <- nefsc.CAA |>
  clean_names() |>
  mutate(season = ifelse(season == "SPRING",4,10),
         index = case_when(
           (stock_abbrev == "NORTH" & year < 2009) ~ -28,
           (stock_abbrev == "SOUTH" & year < 2009) ~ -29,
           (stock_abbrev == "NORTH" & year >= 2009) ~ -30,
           (stock_abbrev == "SOUTH" & year >= 2009) ~ -31,
         ), caa = no_at_age) |>
  filter(season == 4) |>
  group_by(year, season, index, age) |> 
  summarize(caa = sum(caa, na.rm = TRUE), .groups = "drop") |>
  complete(age = 0:15, fill = list(caa = 0)) |>
  pivot_wider(names_from = age,
              names_prefix = "bin_",
              names_sort = TRUE,
              values_from = caa,
              values_fill = 0) |>
  arrange(desc(index), year) |> 
  na.omit() |>
  mutate(gender = 0,
         ageerr = 1,
         part = 2,
         lo = 1,
         hi = 28,
         nsamp = 25) |>
  I()

fishery_ac <- bind_rows(comm_ac, nefsc_ac) |>
  select(year, season, index, gender, part, ageerr, lo, hi, nsamp, everything()) |>
  I()

fishery_ac2 <-  fishery_ac |>
  select(-(1:9)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))

fishery_ac_write <- bind_cols(fishery_ac, fishery_ac2)


## sex disaggregated age data
fishery_agelens <- fishery.age.data |>
  clean_names() |>
  left_join(lenbins) |>
  mutate(sex = case_when(
    sex %in% c("F", "FEMALE") ~ 1,
    sex %in% c("M", "MALE") ~ 2,
    TRUE ~ 0)) |>
  filter(region != "UNK") |> #some unknown region entries
  group_by(year, region, semester, sex, ibin, age) |>
  summarize(num = n()) |>
  # complete(age = 0:15, fill = list(num = 0)) |>
  # arrange(year, region, semester, sex, ibin, age) |>
  # pivot_wider(names_from = age,
  #             names_prefix = "bin_",
  #             names_sort = TRUE,
  #             values_from = num,
  #             values_fill = 0) |>
  I()
#fishery_agelens
unsexed_ageatlen <- fishery_agelens |>
  ungroup() |>
  filter(sex == 0) |>
  group_by(year, region, semester, sex, ibin) |>
  complete(age = 0:15, fill = list(num = 0)) |>
  mutate(nsamp = sum(num, na.rm=TRUE)) |>
  ungroup() |>
  pivot_wider(names_from = age,
              names_prefix = "age_",
              names_sort = TRUE,
              values_from = num,
              values_fill = 0) |>
  mutate(index = case_when(
    region == "NORTH" & semester == 1 ~ 1,
    region == "SOUTH" & semester == 1 ~ 2,
    region == "NORTH" & semester == 2 ~ 3,
    region == "SOUTH" & semester == 2 ~ 4,
  ),
  part = 2,
  ageerr= 1, 
  #nsamp = 25,
  lobin = ibin,
  month = ifelse(semester==1,4,10)) |>
  select(-region,-semester) |>
  select(year, month, index, sex, part, ageerr, lobin, ibin, nsamp, everything()) |>
  arrange(year, month, index, ibin) |>
  I()
#unsexed_ageatlen  
#add empty male columns
unsexed_ageatlen2 <-  unsexed_ageatlen |>
  select(-(1:9)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))
unsexed_ageatlen_write <- bind_cols(unsexed_ageatlen, unsexed_ageatlen2)
#unsexed_ageatlen_write 

## format the sexed parts
sexed_ageatlen <- fishery_agelens |>
  ungroup() |>
  filter(sex != 0) |>
  group_by(year, region, semester, sex, ibin) |>
  complete(age = 0:15, fill = list(num = 0)) |>
  #ungroup() |>
  #group_by(year, region, semester, sex, ibin) |>
  mutate(nsamp = sum(num, na.rm=TRUE)) |>
  ungroup() |>
  mutate(sex_age = paste(age, sex, sep = "_")) |>
  select(-age) |>
  pivot_wider(names_from = sex_age,
              names_prefix = "age_",
              names_sort = FALSE, #TRUE,
              values_from = num,
              values_fill = 0
  ) |>
  mutate(index = case_when(
    region == "NORTH" & semester == 1 ~ 1,
    region == "SOUTH" & semester == 1 ~ 2,
    region == "NORTH" & semester == 2 ~ 3,
    region == "SOUTH" & semester == 2 ~ 4,
  ),
  part = 2,
  ageerr= 1, 
  #nsamp = 25,
  lobin = ibin,
  month = ifelse(semester==1,4,10)) |>
  select(-region,-semester) |>
  select(year, month, index, sex, part, ageerr, lobin, ibin, nsamp, everything()) |>
  arrange(year, month, index, ibin) |>
  I()
sexed_ageatlen
t(sexed_ageatlen[1,])

colnames(unsexed_ageatlen_write) <- c(colnames(unsexed_ageatlen_write)[1:9],colnames(sexed_ageatlen)[-(1:9)])
fishery_ageatlen_write <- bind_rows(unsexed_ageatlen_write, sexed_ageatlen) |>
  arrange(year, month, index, sex, ibin)


### index age data
index_agelens <- index.age.data |>
  clean_names() |>
  left_join(lenbins) |>
  mutate(sex = case_when(
    sex %in% c("F", "FEMALE") ~ 1,
    sex %in% c("M", "MALE") ~ 2,
    TRUE ~ 0),
    age = ifelse(age>15,15,age)) |>
  group_by(year, region, semester, sex, ibin, age) |>
  summarize(num = n()) |>
  I()
# unsexed pieces
unsexed_ageatlen <- index_agelens |>
  ungroup() |>
  filter(sex == 0) |>
  group_by(year, region, semester, sex, ibin) |>
  complete(age = 0:15, fill = list(num = 0)) |>
  mutate(nsamp = sum(num, na.rm=TRUE)) |>
  ungroup() |>
  pivot_wider(names_from = age,
              names_prefix = "age_",
              names_sort = TRUE,
              values_from = num,
              values_fill = 0) |>
  mutate(index = case_when(
    region == "NORTH" & semester == 1 ~ 30,  #assigning to bigelow
    region == "SOUTH" & semester == 1 ~ 31,
    region == "NORTH" & semester == 2 ~ 26,  #assigning to neamap because need a fall survey
    region == "SOUTH" & semester == 2 ~ 27,
  ),
  part = 2,
  ageerr= 1, 
  #nsamp = 25,
  lobin = ibin,
  month = ifelse(semester==1,4,10)) |>
  select(-region,-semester) |>
  select(year, month, index, sex, part, ageerr, lobin, ibin, nsamp, everything()) |>
  arrange(year, month, index, ibin) |>
  I()
#unsexed_ageatlen  
#add empty male columns
unsexed_ageatlen2 <-  unsexed_ageatlen |>
  select(-(1:9)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))
unsexed_ageatlen_write <- bind_cols(unsexed_ageatlen, unsexed_ageatlen2)
#unsexed_ageatlen_write 

## format the sexed parts
sexed_ageatlen <- index_agelens |>
  ungroup() |>
  filter(sex != 0) |>
  group_by(year, region, semester, sex, ibin) |>
  complete(age = 0:15, fill = list(num = 0)) |>
  #ungroup() |>
  #group_by(year, region, semester, sex, ibin) |>
  mutate(nsamp = sum(num, na.rm=TRUE)) |>
  ungroup() |>
  mutate(sex_age = paste(age, sex, sep = "_")) |>
  select(-age) |>
  pivot_wider(names_from = sex_age,
              names_prefix = "age_",
              names_sort = FALSE, #TRUE,
              values_from = num,
              values_fill = 0
  ) |>
  mutate(index = case_when(
    region == "NORTH" & semester == 1 ~ 1,
    region == "SOUTH" & semester == 1 ~ 2,
    region == "NORTH" & semester == 2 ~ 3,
    region == "SOUTH" & semester == 2 ~ 4,
  ),
  part = 2,
  ageerr= 1, 
  #nsamp = 25,
  lobin = ibin,
  month = ifelse(semester==1,4,10)) |>
  select(-region,-semester) |>
  select(year, month, index, sex, part, ageerr, lobin, ibin, nsamp, everything()) |>
  arrange(year, month, index, ibin) |>
  I()
#sexed_ageatlen
#t(sexed_ageatlen[9:10,])

colnames(unsexed_ageatlen_write) <- c(colnames(unsexed_ageatlen_write)[1:9],colnames(sexed_ageatlen)[-(1:9)])
index_ageatlen_write <- bind_rows(unsexed_ageatlen_write, sexed_ageatlen) |>
  arrange(year, month, index, sex, ibin)


####### get the ghost age comps #######
## fishery data
lentemp <- fishery_lens %>% pivot_longer(cols = -(1:6), names_to = c("dummy","ibin"), names_sep = "_", values_to = "lprop") %>% select(-dummy)
lentemp2 <- lentemp %>% 
  #filter(year == 2014) %>% 
  mutate(age = 0,
         ibin = as.numeric(ibin)) %>% 
  group_by(year, season, index, gender, part, ibin) %>% 
  complete(age = 0:15) %>% 
  fill(nsamp, lprop)
## get the total ages (aggregated by sex)
nu_agelens <- fishery.age.data |>
  clean_names() |>
  mutate(gear = ifelse(gear == "TRAWL", "trawl", "non-trawl")) |>
  left_join(lenbins) |>
  filter(region != "UNK") |> #some unknown region entries
  group_by(year, region, semester, gear, ibin, age) |>
  summarize(num = n()) |>
  ungroup() |>
  group_by(year, region, semester, gear, ibin) |>
  complete(age = 0:15, fill = list(num = 0)) |>
  mutate(nsamp = sum(num, na.rm=TRUE),
         aprop = num/nsamp) |>
  ungroup() |>
  # pivot_wider(names_from = age,
  #             names_prefix = "age_",
  #             names_sort = TRUE,
  #             values_from = num,
  #             values_fill = 0) |>
  mutate(index = case_when(
    region == "NORTH" & semester == 1 & gear == "trawl" ~ 1,
    region == "SOUTH" & semester == 1 & gear == "trawl"  ~ 2,
    region == "NORTH" & semester == 2 & gear == "trawl"  ~ 3,
    region == "SOUTH" & semester == 2 & gear == "trawl"  ~ 4,
    region == "NORTH" & semester == 1 & gear == "non-trawl" ~ 5,
    region == "SOUTH" & semester == 1 & gear == "non-trawl"  ~ 6,
    region == "NORTH" & semester == 2 & gear == "non-trawl"  ~ 7,
    region == "SOUTH" & semester == 2 & gear == "non-trawl"  ~ 8,    
  ),
  #part = 2,
  #ageerr= 1, 
  #nsamp = 25,
  #lobin = ibin,
  season = ifelse(semester==1,4,10)) |>
  select(-region,-semester, -num, -nsamp) |>
  #select(year, month, index, sex, part, ageerr, lobin, ibin, nsamp, everything()) |>
  arrange(year, season, index, ibin) |>
  I()
#nu_agelens
nu_agecomp <- lentemp2 %>% left_join(nu_agelens) %>% 
  ungroup() %>% 
  mutate(aprop = ifelse(is.na(aprop),0,aprop),
         aprop2 = lprop*aprop) %>% 
  group_by(year, season, index, gender, part, age) %>% 
  summarize(caa = sum(aprop2)) |>
  ungroup() |>
  group_by(year, season, index, gender, part) %>% 
  mutate(caa = caa/sum(caa)) %>% 
  pivot_wider(names_from = age,
              names_prefix = "age_",
              names_sort = TRUE,
              values_from = caa,
              values_fill = 0) |>
  I()
ghost_fishery_agecomp_write <- nu_agecomp %>% 
  ungroup() %>% 
  drop_na() %>% 
  filter(index %in% 1:8) %>% 
  mutate(index = -1*index, 
         lo = 1,
         hi = 28,
         nsamp = 25,
         ageerr = 1) %>% 
  select(year, season, index, gender, part, ageerr, lo, hi, nsamp, everything()) |>
  I()
#ghost_fishery_agecomp_write
#add empty male columns
ghost2 <- ghost_fishery_agecomp_write |>
  select(-(1:9)) |>
  mutate_all(.funs = function(x) 0*x) |>
  rename_with(.fn = function(x) str_c("m_",x))
ghost_fishery_agecomp_write <- bind_cols(ghost_fishery_agecomp_write, ghost2)


##############################
# write to file
# GF NB that print does not work for tables - as it truncates the output
write("###", file = file.path("SS_BSB_dat.txt"))
xx <- map(SS_BSB_dat1, write.table,
          file = file.path("SS_BSB_dat.txt"),
          row.names = FALSE,
          quote = FALSE,
          col.names = FALSE,
          append = TRUE)
#capture.output(print(SS_BSB_dat1), file = file.path("SS_BSB_dat.txt"))


write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("##  Fishery Length Composition Data", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write.table(fishery_lens_write, 
            file = "SS_BSB_dat.txt", 
            append = TRUE, 
            row.names = FALSE,
            col.names = FALSE)


write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("##  Index Length Composition Data", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write.table(len_data_write, 
            file = "SS_BSB_dat.txt", 
            append = TRUE, 
            row.names = FALSE,
            col.names = FALSE)


write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("##  Age Composition Data", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write.table(fishery_ageatlen_write, #ac_write, 
            file = "SS_BSB_dat.txt", 
            append = TRUE, 
            row.names = FALSE,
            col.names = FALSE)
write.table(index_ageatlen_write, #ac_write, 
            file = "SS_BSB_dat.txt", 
            append = TRUE, 
            row.names = FALSE,
            col.names = FALSE)

write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("##  Ghost Age Composition Data", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write("###############################################", file = file.path("SS_BSB_dat.txt"), append = TRUE)
write.table(ghost_fishery_agecomp_write, #ac_write, 
            file = "SS_BSB_dat.txt", 
            append = TRUE, 
            row.names = FALSE,
            col.names = FALSE)
