rm(list=ls())

load("data/NOAA_CoralTemp_2011_2018.RData")

sst_mean <- rowMeans(sst_region[2:7])

sst_KI <- data.frame(date = sst_region$date, KI_mean_temp = sst_mean)
head(sst_KI)

save(sst_KI,file="data/NOAA_CoralTemp_2011_2018_KI_mean.RData")