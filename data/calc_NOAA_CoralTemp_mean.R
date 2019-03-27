rm(list=ls())
load("data/NOAA_CoralTemp_2011_2018.RData")
head(sst_region)

sst_mean <- rowMeans(sst_region[2:7])

sst_mean <-cbind(sst_region[1],sst_mean)
plot(sst_mean)

save(sst_mean,file = "data/NOAA_CoralTemp_2011_2018_mean.RData")
