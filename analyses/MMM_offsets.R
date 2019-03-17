rm(list=ls())
load("NOAA_MMM_byregion.RData")

MMM_all

Offset <- t(data.frame(-0.04,0.49,0.59,0.36,0.54,0.32))
Offset_NoEN <- t(data.frame(-0.07,0.58,0.66,0.44,0.61,0.37))

MMM_all <- cbind(MMM_all,Offset,Offset_NoEN)
colnames(MMM_all) <- c("MMM","Offset","Offset_noEN")

MMM_all <- as.data.frame(MMM_all)

MMM_all$MMMminOffset <- MMM_all$MMM - MMM_all$Offset
MMM_all$MMMminOffset_noEN <- MMM_all$MMM - MMM_all$Offset_noEN
