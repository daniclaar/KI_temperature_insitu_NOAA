# Clear working environment
rm(list=ls())

#
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/NOAA_CoralTemp_2011_2018.RData")
load("data/KI_SB_temp_wKim_1d.RData")

# Prep Bay of Wrecks in situ/satellite data for merge
BOW_N <- bayofwrecks_night_wKim_1d
colnames(BOW_N) <- c("date","nightonly_temp")
BOW_D <- bayofwrecks_1d_wKim
colnames(BOW_D) <- c("date","daynight_temp")
BOW <- cbind(BOW_N,"daynight_temp"=BOW_D$daynight_temp)
# Calculate difference between satellite and in situ temperature
BOW$time_diff <- BOW$daynight_temp - BOW$nightonly_temp
# Calculate mean difference for Bay of Wrecks
BOW_time_meandiff <- mean(BOW$time_diff,na.rm = TRUE)
BOW_time_maxdiff <- max(BOW$time_diff,na.rm=TRUE)
BOW_time_mindiff <- min(BOW$time_diff,na.rm=TRUE)

# Prep North Shore in situ/satellite data for merge
NS_N <- northshore_night_wKim_1d
colnames(NS_N) <- c("date","nightonly_temp")
NS_D <- northshore_1d_wKim
colnames(NS_D) <- c("date","daynight_temp")
NS <- cbind(NS_N,"daynight_temp"=NS_D$daynight_temp)
NS$time_diff <- NS$daynight_temp - NS$nightonly_temp
NS_time_meandiff <- mean(NS$time_diff,na.rm = TRUE)
NS_time_maxdiff <- max(NS$time_diff,na.rm=TRUE)
NS_time_mindiff <- min(NS$time_diff,na.rm=TRUE)

# Prep North Lagoon in situ/satellite data for merge
NL_N <- northlagoon_night_wKim_1d
colnames(NL_N) <- c("date","nightonly_temp")
NL_D <- northlagoon_1d_wKim
colnames(NL_D) <- c("date","daynight_temp")
NL <- cbind(NL_N,"daynight_temp"=NL_D$daynight_temp)
NL$time_diff <- NL$daynight_temp - NL$nightonly_temp
NL_time_meandiff <- mean(NL$time_diff,na.rm = TRUE)
NL_time_maxdiff <- max(NL$time_diff,na.rm=TRUE)
NL_time_mindiff <- min(NL$time_diff,na.rm=TRUE)

# Prep South Lagoon in situ/satellite data for merge
SL_N <- southlagoon_night_wKim_1d
colnames(SL_N) <- c("date","nightonly_temp")
SL_D <- southlagoon_1d_wKim
colnames(SL_D) <- c("date","daynight_temp")
SL <- cbind(SL_N,"daynight_temp"=SL_D$daynight_temp)
SL$time_diff <- SL$daynight_temp - SL$nightonly_temp
SL_time_meandiff <- mean(SL$time_diff,na.rm = TRUE)
SL_time_maxdiff <- max(SL$time_diff,na.rm=TRUE)
SL_time_mindiff <- min(SL$time_diff,na.rm=TRUE)

# Prep Vaskess Bay in situ/satellite data for merge
VB_N <- vaskesbay_night_wKim_1d
colnames(VB_N) <- c("date","nightonly_temp")
VB_D <- vaskesbay_1d_wKim
colnames(VB_D) <- c("date","daynight_temp")
VB <- cbind(VB_N,"daynight_temp"=VB_D$daynight_temp)
VB$time_diff <- VB$daynight_temp - VB$nightonly_temp
VB_time_meandiff <- mean(VB$time_diff,na.rm = TRUE)
VB_time_maxdiff <- max(VB$time_diff,na.rm=TRUE)
VB_time_mindiff <- min(VB$time_diff,na.rm=TRUE)

# Prep Lagoon Face in situ/satellite data for merge
LF_N <- lagoonface_night_wKim_1d
colnames(LF_N) <- c("date","nightonly_temp")
LF_D <- lagoonface_1d_wKim
colnames(LF_D) <- c("date","daynight_temp")
LF <- cbind(LF_N,"daynight_temp"=LF_D$daynight_temp)
LF$time_diff <- LF$daynight_temp - LF$nightonly_temp
LF_time_meandiff <- mean(LF$time_diff,na.rm = TRUE)
LF_time_maxdiff <- max(LF$time_diff,na.rm=TRUE)
LF_time_mindiff <- min(LF$time_diff,na.rm=TRUE)

# Make data frame with mean differences
region_time_diff <- data.frame("Vaskess Bay" = VB_time_meandiff, 
                              "South Lagoon" = SL_time_meandiff,
                              "Lagoon Face" = LF_time_meandiff,
                              "North Lagoon" = NL_time_meandiff,
                              "North Shore" = NS_time_meandiff,
                              "Bay of Wrecks" = BOW_time_meandiff)

region_time_diff[2,] <- c(VB_time_maxdiff,SL_time_maxdiff,LF_time_maxdiff,NL_time_maxdiff,NS_time_maxdiff,BOW_time_maxdiff)

region_time_diff[3,] <- c(VB_time_mindiff,SL_time_mindiff,LF_time_mindiff,NL_time_mindiff,NS_time_mindiff,BOW_time_mindiff)
rownames(region_time_diff) <- c("meandiff","maxdiff","mindiff")

region_time_diff$all.regions <- NA
region_time_diff$all.regions[1] <- rowMeans(region_time_diff[1,c(1:6)])
region_time_diff$all.regions[2] <- max(region_time_diff[2,c(1:6)])
region_time_diff$all.regions[3] <- min(region_time_diff[3,c(1:6)])

write.csv(region_time_diff,file="analyses/daynight_diff.csv")
