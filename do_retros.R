library(r4ss)

# run the retrospective analyses
retro(
  dir = "~/research/bsb-ss-2022/", # wherever the model files are
  oldsubdir = "", # subfolder within dir
  newsubdir = "retrospectives", # new place to store retro runs within dir
  years = 0:-7, # years relative to ending year of model
  exe = "ss_linux",
  extras = "-nohess -cbs 500000000"
)

retroModels <- SSgetoutput(dirvec = file.path(
  "~/research/bsb-ss-2022/", "retrospectives",
  paste("retro", 0:-7, sep = "")
))

saveRDS(retroModels, file = "~/research/bsb-ss-2022/retroModels.rds")
