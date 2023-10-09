library(r4ss)

# run the retrospective analyses
retro(
  dir = "~/research/bsb-ss-2022/retro_run", # wherever the model files are
  oldsubdir = "", # subfolder within dir
  newsubdir = "retrospectives", # new place to store retro runs within dir
  years = 0:-7, # years relative to ending year of model
  exe = "ss_osx",
  extras = "-nohess -cbs 500000000"
)

retroModels <- SSgetoutput(dirvec = file.path(
  "~/research/bsb-ss-2022/retro_run", "retrospectives",
  paste("retro", 0:-7, sep = "")
))

saveRDS(retroModels, file = "~/research/bsb-ss-2022/retro_run/retroModels.rds")


# summarize the model results
retroSummary <- SSsummarize(retroModels)
# create a vector of the ending year of the retrospectives
endyrvec <- retroSummary[["endyrs"]] + 0:-7
# make plots comparing the 6 models
# showing 2 out of the 17 plots done by SSplotComparisons
SSplotComparisons(retroSummary,
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-7, "years"),
                  #subplot = 2, # only show one plot in vignette
                  pdf = TRUE, # send plots to PNG file
                  #plot = FALSE, # don't plot to default graphics device
                  plotdir = "~/research/bsb-ss-2022/retro_run/"
)


# calculate Mohn's rho, a diagnostic value
rho_output <- SSmohnsrho(
  summaryoutput = retroSummary,
  endyrvec = endyrvec,
  startyr = retroSummary[["endyrs"]] - 7,
  verbose = FALSE
)