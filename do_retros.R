library(r4ss)

# run the retrospective analyses
retro(
  #dir = "~/research/bsb-ss-2022/results/run_257/retros", # wherever the model files are
  dir = "~/research/bsb-ss-2022/results/run_276/retros", # wherever the model files are
  oldsubdir = "", # subfolder within dir
  newsubdir = "retrospectives", # new place to store retro runs within dir
  years = 0:-7, # years relative to ending year of model
  exe = "ss_osx",
  extras = "-nohess -cbs 500000000"
)

retroModels <- SSgetoutput(dirvec = file.path(
  "~/research/bsb-ss-2022/retros",
  paste("retro", 0:-5, sep = "")
))

saveRDS(retroModels, file = "~/research/bsb-ss-2022/retros/retroModels.rds")


# summarize the model results
retroSummary <- SSsummarize(retroModels)
# create a vector of the ending year of the retrospectives
endyrvec <- retroSummary[["endyrs"]] + 0:-5
# make plots comparing the 6 models
# showing 2 out of the 17 plots done by SSplotComparisons
SSplotComparisons(retroSummary,
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  subplot = c(1,3,5,7,13:17), # only show one plot in vignette
                  pdf = TRUE, # send plots to PNG file
                  indexfleets = purrr::map(1:6,~c(9, 10, 13, 14)),
                  #plot = FALSE, # don't plot to default graphics device
                  plotdir = "~/research/bsb-ss-2022/results/run_257/retros/"
)
SSplotComparisons(retroSummary,
                  endyrvec = endyrvec-2,
                  initpoint = 2014,
                  legendlabels = paste("Data", 0:-5, "years"),
                  subplot = c(9,11), # only show one plot in vignette
                  pdf = TRUE, # send plots to PNG file
                  indexfleets = purrr::map(1:6,~c(9, 10, 13, 14)),
                  #plot = FALSE, # don't plot to default graphics device
                  plotdir = "~/research/bsb-ss-2022/results/run_257/retros/"
)


# calculate Mohn's rho, a diagnostic value
rho_output <- SSmohnsrho(
  summaryoutput = retroSummary,
  endyrvec = endyrvec,
  startyr = retroSummary[["endyrs"]] - 5,
  verbose = FALSE
)
#redo for recruitment to look at last estimated value
rho_output2 <- SSmohnsrho(
  summaryoutput = retroSummary,
  endyrvec = endyrvec-2,
  startyr = retroSummary[["endyrs"]] - 5,
  verbose = FALSE
)
rho_output$WoodHole_SSB.all
rho_output2$WoodHole_Rec.all
rho_output$WoodHole_F.all

rho_output$AFSC_Hurtado_SSB
rho_output2$AFSC_Hurtado_Rec
rho_output$AFSC_Hurtado_F
