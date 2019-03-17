# Clear working environment
rm(list=ls())

#
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/NOAA_CoralTemp_2011_2018.RData")
load("data/KI_SB_temp_wKim_1d.RData")

# Prep Bay of Wrecks in situ/satellite data for merge
BOW_I <- bayofwrecks_1d_wKim
colnames(BOW_I) <- c("date","insitu_temp")
BOW_S <- sst_BOW[,c(2,1)]
colnames(BOW_S) <- c("date","sat_temp")
BOW_I[c(2193:2922),] <- NA # Make in situ data set longer to match satellite
BOW <- cbind(BOW_S,"insitu_temp"=BOW_I$insitu_temp)
# Calculate difference between satellite and in situ temperature
BOW$diff <- BOW$sat_temp - BOW$insitu_temp
# Calculate mean difference for Bay of Wrecks
BOW_meandiff <- mean(BOW$diff,na.rm = TRUE)

# Prep North shore in situ/satellite data for merge
NS_I <- northshore_1d_wKim
colnames(NS_I) <- c("date","insitu_temp")
NS_S <- sst_northshore[,c(2,1)]
colnames(NS_S) <- c("date","sat_temp")
NS_I[c(2193:2922),] <- NA
NS <- cbind(NS_S,"insitu_temp"=NS_I$insitu_temp)
NS$diff <- NS$sat_temp - NS$insitu_temp
NS_meandiff <- mean(NS$diff,na.rm = TRUE)

# Prep North lagoon in situ/satellite data for merge
NL_I <- northlagoon_1d_wKim
colnames(NL_I) <- c("date","insitu_temp")
NL_S <- sst_northlagoon[,c(2,1)]
colnames(NL_S) <- c("date","sat_temp")
NL_I[c(2193:2922),] <- NA
NL <- cbind(NL_S,"insitu_temp"=NL_I$insitu_temp)
NL$diff <- NL$sat_temp - NL$insitu_temp
NL_meandiff <- mean(NL$diff,na.rm = TRUE)

# Prep South lagoon in situ/satellite data for merge
SL_I <- southlagoon_1d_wKim
colnames(SL_I) <- c("date","insitu_temp")
SL_S <- sst_southlagoon[,c(2,1)]
colnames(SL_S) <- c("date","sat_temp")
SL_I[c(2193:2922),] <- NA
SL <- cbind(SL_S,"insitu_temp"=SL_I$insitu_temp)
SL$diff <- SL$sat_temp - SL$insitu_temp
SL_meandiff <- mean(SL$diff,na.rm = TRUE)

# Prep Vaskess Bay in situ/satellite data for merge
VB_I <- vaskesbay_1d_wKim
colnames(VB_I) <- c("date","insitu_temp")
VB_S <- sst_vaskess[,c(2,1)]
colnames(VB_S) <- c("date","sat_temp")
VB_I[c(2193:2922),] <- NA
VB <- cbind(VB_S,"insitu_temp"=VB_I$insitu_temp)
VB$diff <- VB$sat_temp - VB$insitu_temp
VB_meandiff <- mean(VB$diff,na.rm = TRUE)

# Prep Lagoon face in situ/satellite data for merge
LF_I <- lagoonface_1d_wKim
colnames(LF_I) <- c("date","insitu_temp")
LF_S <- sst_lagoonface[,c(2,1)]
colnames(LF_S) <- c("date","sat_temp")
LF_I[c(2193:2922),] <- NA
LF <- cbind(LF_S,"insitu_temp"=LF_I$insitu_temp)
LF$diff <- LF$sat_temp - LF$insitu_temp
LF_meandiff <- mean(LF$diff,na.rm = TRUE)

# Make data frame with mean differences
region_meandiff <- data.frame("Vaskess Bay" = VB_meandiff, 
                              "South Lagoon" = SL_meandiff,
                              "Lagoon Face" = LF_meandiff,
                              "North Lagoon" = NL_meandiff,
                              "North Shore" = NS_meandiff,
                              "Bay of Wrecks" = BOW_meandiff)

# Calculate variances for each region
VB_var_satellite <- var(sst_vaskess$sst,na.rm = TRUE)
VB_var_insitu <- var(vaskesbay_1d_wKim$temperature_1d,na.rm=TRUE)
SL_var_satellite <- var(sst_southlagoon$sst,na.rm = TRUE)
SL_var_insitu <- var(southlagoon_1d_wKim$temperature_1d,na.rm = TRUE)
LF_var_satellite <- var(sst_lagoonface$sst,na.rm = TRUE)
LF_var_insitu <- var(lagoonface_1d_wKim$temperature_1d,na.rm=TRUE)
NL_var_satellite <- var(sst_northlagoon$sst,na.rm = TRUE)
NL_var_insitu <- var(northlagoon_1d_wKim$temperature_1d,na.rm=TRUE)
NS_var_satellite <- var(sst_northshore$sst,na.rm = TRUE)
NS_var_insitu <- var(northlagoon_1d_wKim$temperature_1d,na.rm=TRUE)
BOW_var_satellite <- var(sst_BOW$sst,na.rm = TRUE)
BOW_var_insitu <- var(bayofwrecks_1d_wKim$temperature_1d,na.rm=TRUE)

# Make data frames with variances
region_var_I <- data.frame("Vaskess Bay" = VB_var_insitu, 
                         "South Lagoon" = SL_var_insitu,
                         "Lagoon Face" = LF_var_insitu,
                         "North Lagoon" = NL_var_insitu,
                         "North Shore" = NS_var_insitu,
                         "Bay of Wrecks" = BOW_var_insitu)
region_var_S <- data.frame("Vaskess Bay" = VB_var_satellite, 
                         "South Lagoon" = SL_var_satellite,
                         "Lagoon Face" = LF_var_satellite,
                         "North Lagoon" = NL_var_satellite,
                         "North Shore" = NS_var_satellite,
                         "Bay of Wrecks" = BOW_var_satellite)

region_var_comb <- rbind("insitu"=region_var_I,"satellite"=region_var_S)
region_var <- t(region_var_comb)

# Subset to dates with the most available in situ data (but no north shore)
# November 09 2015 to November 09 2016

# Subset temperature data
VB_insitu_sub <- vaskesbay_1d_wKim[c(1774:2140),]
SL_insitu_sub <- southlagoon_1d_wKim[c(1774:2140),]
LF_insitu_sub <- lagoonface_1d_wKim[c(1774:2140),]
NL_insitu_sub <- northlagoon_1d_wKim[c(1774:2140),]
BOW_insitu_sub <- bayofwrecks_1d_wKim[c(1774:2140),]
VB_satellite_sub <- sst_vaskess[c(1774:2140),]
SL_satellite_sub <- sst_southlagoon[c(1774:2140),]
LF_satellite_sub <- sst_lagoonface[c(1774:2140),]
NL_satellite_sub <- sst_northlagoon[c(1774:2140),]
BOW_satellite_sub <- sst_BOW[c(1774:2140),]

# Calculate variance
VB_var_sub_satellite <- var(VB_satellite_sub$sst,na.rm = TRUE)
VB_var_sub_insitu <- var(VB_insitu_sub$temperature_1d,na.rm=TRUE)
SL_var_sub_satellite <- var(SL_satellite_sub$sst,na.rm = TRUE)
SL_var_sub_insitu <- var(SL_insitu_sub$temperature_1d,na.rm = TRUE)
LF_var_sub_satellite <- var(LF_satellite_sub$sst,na.rm = TRUE)
LF_var_sub_insitu <- var(LF_insitu_sub$temperature_1d,na.rm=TRUE)
NL_var_sub_satellite <- var(NL_satellite_sub$sst,na.rm = TRUE)
NL_var_sub_insitu <- var(NL_insitu_sub$temperature_1d,na.rm=TRUE)
BOW_var_sub_satellite <- var(BOW_satellite_sub$sst,na.rm = TRUE)
BOW_var_sub_insitu <- var(BOW_insitu_sub$temperature_1d,na.rm=TRUE)

# Make data frames with variances of subset data
region_var_sub_I <- data.frame("Vaskess Bay" = VB_var_sub_insitu, 
                           "South Lagoon" = SL_var_sub_insitu,
                           "Lagoon Face" = LF_var_sub_insitu,
                           "North Lagoon" = NL_var_sub_insitu,
                           "Bay of Wrecks" = BOW_var_sub_insitu)
region_var_sub_S <- data.frame("Vaskess Bay" = VB_var_sub_satellite, 
                           "South Lagoon" = SL_var_sub_satellite,
                           "Lagoon Face" = LF_var_sub_satellite,
                           "North Lagoon" = NL_var_sub_satellite,
                           "Bay of Wrecks" = BOW_var_sub_satellite)

region_var_sub_comb <- rbind("insitu"=region_var_sub_I,"satellite"=region_var_sub_S)
region_var_sub <- t(region_var_sub_comb)

# Calculate mean offset for subset data
VB_sub_meandiff <- mean(VB_satellite_sub$sst-VB_insitu_sub$temperature_1d,na.rm = TRUE)
SL_sub_meandiff <- mean(SL_satellite_sub$sst-SL_insitu_sub$temperature_1d,na.rm = TRUE)
LF_sub_meandiff <- mean(LF_satellite_sub$sst-LF_insitu_sub$temperature_1d,na.rm = TRUE)
NL_sub_meandiff <- mean(NL_satellite_sub$sst-NL_insitu_sub$temperature_1d,na.rm = TRUE)
BOW_sub_meandiff <- mean(BOW_satellite_sub$sst-BOW_insitu_sub$temperature_1d,na.rm = TRUE)

# Make data frames with mean offsets of subset data
region_sub_meandiff <- data.frame("Vaskess Bay" = VB_sub_meandiff, 
                              "South Lagoon" = SL_sub_meandiff,
                              "Lagoon Face" = LF_sub_meandiff,
                              "North Lagoon" = NL_sub_meandiff,
                              "Bay of Wrecks" = BOW_sub_meandiff)


BOW_noEN <- BOW[c(1:which(BOW$date=="2015-04-30"),
                  which(BOW$date=="2016-07-01"):nrow(BOW)),]
BOW_noEN_meandiff <- mean(BOW_noEN$diff,na.rm = TRUE)

LF_noEN <- LF[c(1:which(LF$date=="2015-04-30"),
                  which(LF$date=="2016-07-01"):nrow(LF)),]
LF_noEN_meandiff <- mean(LF_noEN$diff,na.rm = TRUE)

NL_noEN <- NL[c(1:which(NL$date=="2015-04-30"),
                  which(NL$date=="2016-07-01"):nrow(NL)),]
NL_noEN_meandiff <- mean(NL_noEN$diff,na.rm = TRUE)

NS_noEN <- NS[c(1:which(NS$date=="2015-04-30"),
                  which(NS$date=="2016-07-01"):nrow(NS)),]
NS_noEN_meandiff <- mean(NS_noEN$diff,na.rm = TRUE)

SL_noEN <- SL[c(1:which(SL$date=="2015-04-30"),
                  which(SL$date=="2016-07-01"):nrow(SL)),]
SL_noEN_meandiff <- mean(SL_noEN$diff,na.rm = TRUE)

VB_noEN <- VB[c(1:which(VB$date=="2015-04-30"),
                  which(VB$date=="2016-07-01"):nrow(VB)),]
VB_noEN_meandiff <- mean(VB_noEN$diff,na.rm = TRUE)

# Make data frames with mean offsets of subset data
region_noEN_meandiff <- data.frame("Vaskess Bay" = VB_noEN_meandiff, 
                                  "South Lagoon" = SL_noEN_meandiff,
                                  "Lagoon Face" = LF_noEN_meandiff,
                                  "North Lagoon" = NL_noEN_meandiff,
                                  "North Shore" = NS_noEN_meandiff,
                                  "Bay of Wrecks" = BOW_noEN_meandiff)

BOW_noEN_2 <- BOW_noEN[!is.na(BOW_noEN$diff),]
BOW_noEN_2_s <- split(BOW_noEN_2, sample(1:round(nrow(BOW_noEN_2)/30), nrow(BOW_noEN_2), replace=T))
BOW_noEN_2_s$`1`$diff
BOW_noEN_2_s_meandiff <- data.frame(seq(1,50))
BOW_noEN_2_s_meandiff[1,] <- mean(BOW_noEN_2_s$`1`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[2,] <- mean(BOW_noEN_2_s$`2`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[3,] <- mean(BOW_noEN_2_s$`3`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[4,] <- mean(BOW_noEN_2_s$`4`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[5,] <- mean(BOW_noEN_2_s$`5`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[6,] <- mean(BOW_noEN_2_s$`6`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[7,] <- mean(BOW_noEN_2_s$`7`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[8,] <- mean(BOW_noEN_2_s$`8`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[9,] <- mean(BOW_noEN_2_s$`9`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[10,] <- mean(BOW_noEN_2_s$`10`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[11,] <- mean(BOW_noEN_2_s$`11`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[12,] <- mean(BOW_noEN_2_s$`12`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[13,] <- mean(BOW_noEN_2_s$`13`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[14,] <- mean(BOW_noEN_2_s$`14`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[15,] <- mean(BOW_noEN_2_s$`15`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[16,] <- mean(BOW_noEN_2_s$`16`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[17,] <- mean(BOW_noEN_2_s$`17`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[18,] <- mean(BOW_noEN_2_s$`18`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[19,] <- mean(BOW_noEN_2_s$`19`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[20,] <- mean(BOW_noEN_2_s$`20`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[21,] <- mean(BOW_noEN_2_s$`21`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[22,] <- mean(BOW_noEN_2_s$`22`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[23,] <- mean(BOW_noEN_2_s$`23`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[24,] <- mean(BOW_noEN_2_s$`24`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[25,] <- mean(BOW_noEN_2_s$`25`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[26,] <- mean(BOW_noEN_2_s$`26`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[27,] <- mean(BOW_noEN_2_s$`27`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[28,] <- mean(BOW_noEN_2_s$`28`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[29,] <- mean(BOW_noEN_2_s$`29`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[30,] <- mean(BOW_noEN_2_s$`30`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[31,] <- mean(BOW_noEN_2_s$`31`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[32,] <- mean(BOW_noEN_2_s$`32`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[33,] <- mean(BOW_noEN_2_s$`33`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[34,] <- mean(BOW_noEN_2_s$`34`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[35,] <- mean(BOW_noEN_2_s$`35`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[36,] <- mean(BOW_noEN_2_s$`36`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[37,] <- mean(BOW_noEN_2_s$`37`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[38,] <- mean(BOW_noEN_2_s$`38`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[39,] <- mean(BOW_noEN_2_s$`39`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[40,] <- mean(BOW_noEN_2_s$`40`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[41,] <- mean(BOW_noEN_2_s$`41`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[42,] <- mean(BOW_noEN_2_s$`42`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[43,] <- mean(BOW_noEN_2_s$`43`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[44,] <- mean(BOW_noEN_2_s$`44`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[45,] <- mean(BOW_noEN_2_s$`45`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[46,] <- mean(BOW_noEN_2_s$`46`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[47,] <- mean(BOW_noEN_2_s$`47`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[48,] <- mean(BOW_noEN_2_s$`48`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[49,] <- mean(BOW_noEN_2_s$`49`$diff,na.rm = TRUE)
BOW_noEN_2_s_meandiff[50,] <- mean(BOW_noEN_2_s$`50`$diff,na.rm = TRUE)

LF_noEN_2 <- LF_noEN[!is.na(LF_noEN$diff),]
LF_noEN_2_s <- split(LF_noEN_2, sample(1:round(nrow(LF_noEN_2)/30), nrow(LF_noEN_2), replace=T))
LF_noEN_2_s$`1`$diff
LF_noEN_2_s_meandiff <- data.frame(seq(1,50))
LF_noEN_2_s_meandiff[1,] <- mean(LF_noEN_2_s$`1`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[2,] <- mean(LF_noEN_2_s$`2`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[3,] <- mean(LF_noEN_2_s$`3`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[4,] <- mean(LF_noEN_2_s$`4`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[5,] <- mean(LF_noEN_2_s$`5`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[6,] <- mean(LF_noEN_2_s$`6`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[7,] <- mean(LF_noEN_2_s$`7`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[8,] <- mean(LF_noEN_2_s$`8`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[9,] <- mean(LF_noEN_2_s$`9`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[10,] <- mean(LF_noEN_2_s$`10`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[11,] <- mean(LF_noEN_2_s$`11`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[12,] <- mean(LF_noEN_2_s$`12`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[13,] <- mean(LF_noEN_2_s$`13`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[14,] <- mean(LF_noEN_2_s$`14`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[15,] <- mean(LF_noEN_2_s$`15`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[16,] <- mean(LF_noEN_2_s$`16`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[17,] <- mean(LF_noEN_2_s$`17`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[18,] <- mean(LF_noEN_2_s$`18`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[19,] <- mean(LF_noEN_2_s$`19`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[20,] <- mean(LF_noEN_2_s$`20`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[21,] <- mean(LF_noEN_2_s$`21`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[22,] <- mean(LF_noEN_2_s$`22`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[23,] <- mean(LF_noEN_2_s$`23`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[24,] <- mean(LF_noEN_2_s$`24`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[25,] <- mean(LF_noEN_2_s$`25`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[26,] <- mean(LF_noEN_2_s$`26`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[27,] <- mean(LF_noEN_2_s$`27`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[28,] <- mean(LF_noEN_2_s$`28`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[29,] <- mean(LF_noEN_2_s$`29`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[30,] <- mean(LF_noEN_2_s$`30`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[31,] <- mean(LF_noEN_2_s$`31`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[32,] <- mean(LF_noEN_2_s$`32`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[33,] <- mean(LF_noEN_2_s$`33`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[34,] <- mean(LF_noEN_2_s$`34`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[35,] <- mean(LF_noEN_2_s$`35`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[36,] <- mean(LF_noEN_2_s$`36`$diff,na.rm = TRUE)
LF_noEN_2_s_meandiff[c(37:50),] <- NA

NL_noEN_2 <- NL_noEN[!is.na(NL_noEN$diff),]
NL_noEN_2_s <- split(NL_noEN_2, sample(1:round(nrow(NL_noEN_2)/30), nrow(NL_noEN_2), replace=T))
NL_noEN_2_s$`1`$diff
NL_noEN_2_s_meandiff <- data.frame(seq(1,36))
NL_noEN_2_s_meandiff[1,] <- mean(NL_noEN_2_s$`1`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[2,] <- mean(NL_noEN_2_s$`2`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[3,] <- mean(NL_noEN_2_s$`3`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[4,] <- mean(NL_noEN_2_s$`4`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[5,] <- mean(NL_noEN_2_s$`5`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[6,] <- mean(NL_noEN_2_s$`6`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[7,] <- mean(NL_noEN_2_s$`7`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[8,] <- mean(NL_noEN_2_s$`8`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[9,] <- mean(NL_noEN_2_s$`9`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[10,] <- mean(NL_noEN_2_s$`10`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[11,] <- mean(NL_noEN_2_s$`11`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[12,] <- mean(NL_noEN_2_s$`12`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[13,] <- mean(NL_noEN_2_s$`13`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[14,] <- mean(NL_noEN_2_s$`14`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[15,] <- mean(NL_noEN_2_s$`15`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[16,] <- mean(NL_noEN_2_s$`16`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[17,] <- mean(NL_noEN_2_s$`17`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[18,] <- mean(NL_noEN_2_s$`18`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[19,] <- mean(NL_noEN_2_s$`19`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[20,] <- mean(NL_noEN_2_s$`20`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[21,] <- mean(NL_noEN_2_s$`21`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[22,] <- mean(NL_noEN_2_s$`22`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[23,] <- mean(NL_noEN_2_s$`23`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[24,] <- mean(NL_noEN_2_s$`24`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[25,] <- mean(NL_noEN_2_s$`25`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[26,] <- mean(NL_noEN_2_s$`26`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[27,] <- mean(NL_noEN_2_s$`27`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[28,] <- mean(NL_noEN_2_s$`28`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[29,] <- mean(NL_noEN_2_s$`29`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[30,] <- mean(NL_noEN_2_s$`30`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[31,] <- mean(NL_noEN_2_s$`31`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[32,] <- mean(NL_noEN_2_s$`32`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[33,] <- mean(NL_noEN_2_s$`33`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[34,] <- mean(NL_noEN_2_s$`34`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[35,] <- mean(NL_noEN_2_s$`35`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[36,] <- mean(NL_noEN_2_s$`36`$diff,na.rm = TRUE)
NL_noEN_2_s_meandiff[c(37:50),] <- NA

NS_noEN_2 <- NS_noEN[!is.na(NS_noEN$diff),]
NS_noEN_2_s <- split(NS_noEN_2, sample(1:round(nrow(NS_noEN_2)/30), nrow(NS_noEN_2), replace=T))
NS_noEN_2_s$`1`$diff
NS_noEN_2_s_meandiff <- data.frame(seq(1,32))
NS_noEN_2_s_meandiff[1,] <- mean(NS_noEN_2_s$`1`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[2,] <- mean(NS_noEN_2_s$`2`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[3,] <- mean(NS_noEN_2_s$`3`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[4,] <- mean(NS_noEN_2_s$`4`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[5,] <- mean(NS_noEN_2_s$`5`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[6,] <- mean(NS_noEN_2_s$`6`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[7,] <- mean(NS_noEN_2_s$`7`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[8,] <- mean(NS_noEN_2_s$`8`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[9,] <- mean(NS_noEN_2_s$`9`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[10,] <- mean(NS_noEN_2_s$`10`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[11,] <- mean(NS_noEN_2_s$`11`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[12,] <- mean(NS_noEN_2_s$`12`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[13,] <- mean(NS_noEN_2_s$`13`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[14,] <- mean(NS_noEN_2_s$`14`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[15,] <- mean(NS_noEN_2_s$`15`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[16,] <- mean(NS_noEN_2_s$`16`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[17,] <- mean(NS_noEN_2_s$`17`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[18,] <- mean(NS_noEN_2_s$`18`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[19,] <- mean(NS_noEN_2_s$`19`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[20,] <- mean(NS_noEN_2_s$`20`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[21,] <- mean(NS_noEN_2_s$`21`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[22,] <- mean(NS_noEN_2_s$`22`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[23,] <- mean(NS_noEN_2_s$`23`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[24,] <- mean(NS_noEN_2_s$`24`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[25,] <- mean(NS_noEN_2_s$`25`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[26,] <- mean(NS_noEN_2_s$`26`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[27,] <- mean(NS_noEN_2_s$`27`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[28,] <- mean(NS_noEN_2_s$`28`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[29,] <- mean(NS_noEN_2_s$`29`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[30,] <- mean(NS_noEN_2_s$`30`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[31,] <- mean(NS_noEN_2_s$`31`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[32,] <- mean(NS_noEN_2_s$`32`$diff,na.rm = TRUE)
NS_noEN_2_s_meandiff[c(33:50),] <- NA

SL_noEN_2 <- SL_noEN[!is.na(SL_noEN$diff),]
SL_noEN_2_s <- split(SL_noEN_2, sample(1:round(nrow(SL_noEN_2)/30), nrow(SL_noEN_2), replace=T))
SL_noEN_2_s$`1`$diff
SL_noEN_2_s_meandiff <- data.frame(seq(1,36))
SL_noEN_2_s_meandiff[1,] <- mean(SL_noEN_2_s$`1`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[2,] <- mean(SL_noEN_2_s$`2`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[3,] <- mean(SL_noEN_2_s$`3`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[4,] <- mean(SL_noEN_2_s$`4`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[5,] <- mean(SL_noEN_2_s$`5`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[6,] <- mean(SL_noEN_2_s$`6`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[7,] <- mean(SL_noEN_2_s$`7`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[8,] <- mean(SL_noEN_2_s$`8`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[9,] <- mean(SL_noEN_2_s$`9`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[10,] <- mean(SL_noEN_2_s$`10`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[11,] <- mean(SL_noEN_2_s$`11`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[12,] <- mean(SL_noEN_2_s$`12`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[13,] <- mean(SL_noEN_2_s$`13`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[14,] <- mean(SL_noEN_2_s$`14`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[15,] <- mean(SL_noEN_2_s$`15`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[16,] <- mean(SL_noEN_2_s$`16`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[17,] <- mean(SL_noEN_2_s$`17`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[18,] <- mean(SL_noEN_2_s$`18`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[19,] <- mean(SL_noEN_2_s$`19`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[20,] <- mean(SL_noEN_2_s$`20`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[21,] <- mean(SL_noEN_2_s$`21`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[22,] <- mean(SL_noEN_2_s$`22`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[23,] <- mean(SL_noEN_2_s$`23`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[24,] <- mean(SL_noEN_2_s$`24`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[25,] <- mean(SL_noEN_2_s$`25`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[26,] <- mean(SL_noEN_2_s$`26`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[27,] <- mean(SL_noEN_2_s$`27`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[28,] <- mean(SL_noEN_2_s$`28`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[29,] <- mean(SL_noEN_2_s$`29`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[30,] <- mean(SL_noEN_2_s$`30`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[31,] <- mean(SL_noEN_2_s$`31`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[32,] <- mean(SL_noEN_2_s$`32`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[33,] <- mean(SL_noEN_2_s$`33`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[34,] <- mean(SL_noEN_2_s$`34`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[35,] <- mean(SL_noEN_2_s$`35`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[36,] <- mean(SL_noEN_2_s$`36`$diff,na.rm = TRUE)
SL_noEN_2_s_meandiff[c(38:50),] <- NA

VB_noEN_2 <- VB_noEN[!is.na(VB_noEN$diff),]
VB_noEN_2_s <- split(VB_noEN_2, sample(1:round(nrow(VB_noEN_2)/30), nrow(VB_noEN_2), replace=T))
VB_noEN_2_s$`1`$diff
VB_noEN_2_s_meandiff <- data.frame(seq(1,14))
VB_noEN_2_s_meandiff[1,] <- mean(VB_noEN_2_s$`1`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[2,] <- mean(VB_noEN_2_s$`2`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[3,] <- mean(VB_noEN_2_s$`3`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[4,] <- mean(VB_noEN_2_s$`4`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[5,] <- mean(VB_noEN_2_s$`5`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[6,] <- mean(VB_noEN_2_s$`6`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[7,] <- mean(VB_noEN_2_s$`7`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[8,] <- mean(VB_noEN_2_s$`8`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[9,] <- mean(VB_noEN_2_s$`9`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[10,] <- mean(VB_noEN_2_s$`10`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[11,] <- mean(VB_noEN_2_s$`11`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[12,] <- mean(VB_noEN_2_s$`12`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[13,] <- mean(VB_noEN_2_s$`13`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[14,] <- mean(VB_noEN_2_s$`14`$diff,na.rm = TRUE)
VB_noEN_2_s_meandiff[c(15:50),] <- NA

mean(VB_noEN_2$diff[1:30])
mean(VB_noEN_2$diff[31:60])
mean(VB_noEN_2$diff[61:90])
mean(VB_noEN_2$diff[91:120])
mean(VB_noEN_2$diff[121:150])
mean(VB_noEN_2$diff[151:180])
mean(VB_noEN_2$diff[181:210])
mean(VB_noEN_2$diff[211:240])
mean(VB_noEN_2$diff[241:270])
mean(VB_noEN_2$diff[271:300])
mean(VB_noEN_2$diff[301:330])
mean(VB_noEN_2$diff[331:360])
mean(VB_noEN_2$diff[361:390])
# mean(VB_noEN_2$diff[391:416])

mean(VB_noEN_2$diff[1:60])
mean(VB_noEN_2$diff[61:120])
mean(VB_noEN_2$diff[121:180])
mean(VB_noEN_2$diff[181:240])
mean(VB_noEN_2$diff[241:300])
mean(VB_noEN_2$diff[301:360])
# mean(VB_noEN_2$diff[361:416])

mean(VB_noEN_2$diff[1:180])
mean(VB_noEN_2$diff[181:360])

#########
  
noEN_meandiff <- cbind(BOW_noEN_2_s_meandiff,LF_noEN_2_s_meandiff,NL_noEN_2_s_meandiff,NS_noEN_2_s_meandiff,SL_noEN_2_s_meandiff,VB_noEN_2_s_meandiff)
colnames(noEN_meandiff) <- c("BOW","LF","NL","NS","SL","VB")

p <- ggplot(noEN_meandiff)
p + 
  geom_boxplot(aes(x="BOW",y=BOW))+
  geom_boxplot(aes(x="LF",y=LF))+
  geom_boxplot(aes(x="NL",y=NL))+
  geom_boxplot(aes(x="NS",y=NS))+
  geom_boxplot(aes(x="SL",y=SL))+
  geom_boxplot(aes(x="VB",y=VB))


region.cols<-c("VaskessBay" = "#5F4690","SouthLagoon"="#1D6996",
               "MidLagoon"="#0F8554","NorthLagoon"="#EDAD08",
               "NorthShore"="#E17C05","BayofWrecks"="#CC503E")

# noEN_meandiff <- data.frame(t(noEN_meandiff))
# noEN_meandiff$region <- rownames(noEN_meandiff)

p <- ggplot(noEN_meandiff)
p <- p + scale_x_discrete(name="") + 
  scale_y_continuous(name="Mean Difference",lim=c(-0.3,1)) +
  geom_hline(yintercept = 0,linetype="dashed")+
  theme_classic()+guides(fill=FALSE)+
  geom_violin(aes(x="1_VB",y=VB,fill=region.cols[["VaskessBay"]]))+
  geom_violin(aes(x="2_SL",y=SL,fill=region.cols[["SouthLagoon"]]))+
  geom_violin(aes(x="3_LF",y=LF,fill=region.cols[["MidLagoon"]]))+
  geom_violin(aes(x="4_NL",y=NL,fill=region.cols[["NorthLagoon"]]))+
  geom_violin(aes(x="5_NS",y=NS,fill=region.cols[["NorthShore"]]))+
  geom_violin(aes(x="6_BOW",y=BOW,fill=region.cols[["BayofWrecks"]]))+
  scale_fill_manual(values = c("#0F8554","#1D6996","#5F4690","#CC503E","#E17C05","#EDAD08"))
p

BOW_noEN_3 <- BOW_noEN[!is.na(BOW_noEN$diff),]
BOW_noEN_3_s <- split(BOW_noEN_3, sample(1:round(nrow(BOW_noEN_3)/60), nrow(BOW_noEN_3), replace=T))
BOW_noEN_3_s$`1`$diff
BOW_noEN_3_s_meandiff <- data.frame(seq(1,25))
BOW_noEN_3_s_meandiff[1,] <- mean(BOW_noEN_3_s$`1`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[2,] <- mean(BOW_noEN_3_s$`2`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[3,] <- mean(BOW_noEN_3_s$`3`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[4,] <- mean(BOW_noEN_3_s$`4`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[5,] <- mean(BOW_noEN_3_s$`5`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[6,] <- mean(BOW_noEN_3_s$`6`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[7,] <- mean(BOW_noEN_3_s$`7`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[8,] <- mean(BOW_noEN_3_s$`8`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[9,] <- mean(BOW_noEN_3_s$`9`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[10,] <- mean(BOW_noEN_3_s$`10`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[11,] <- mean(BOW_noEN_3_s$`11`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[12,] <- mean(BOW_noEN_3_s$`12`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[13,] <- mean(BOW_noEN_3_s$`13`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[14,] <- mean(BOW_noEN_3_s$`14`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[15,] <- mean(BOW_noEN_3_s$`15`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[16,] <- mean(BOW_noEN_3_s$`16`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[17,] <- mean(BOW_noEN_3_s$`17`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[18,] <- mean(BOW_noEN_3_s$`18`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[19,] <- mean(BOW_noEN_3_s$`19`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[20,] <- mean(BOW_noEN_3_s$`20`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[21,] <- mean(BOW_noEN_3_s$`21`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[22,] <- mean(BOW_noEN_3_s$`22`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[23,] <- mean(BOW_noEN_3_s$`23`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[24,] <- mean(BOW_noEN_3_s$`24`$diff,na.rm = TRUE)
BOW_noEN_3_s_meandiff[25,] <- mean(BOW_noEN_3_s$`25`$diff,na.rm = TRUE)                    
LF_noEN_3 <- LF_noEN[!is.na(LF_noEN$diff),]
LF_noEN_3_s <- split(LF_noEN_3, sample(1:round(nrow(LF_noEN_3)/60), nrow(LF_noEN_3), replace=T))
LF_noEN_3_s$`1`$diff
LF_noEN_3_s_meandiff <- data.frame(seq(1,25))
LF_noEN_3_s_meandiff[1,] <- mean(LF_noEN_3_s$`1`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[2,] <- mean(LF_noEN_3_s$`2`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[3,] <- mean(LF_noEN_3_s$`3`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[4,] <- mean(LF_noEN_3_s$`4`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[5,] <- mean(LF_noEN_3_s$`5`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[6,] <- mean(LF_noEN_3_s$`6`$diff,na.rm = TRUE)
LF_noEN_3_s_meandiff[7,] <- mean(LF_noEN_3_s$`7`$diff,na.rm = TRUE)

NL_noEN_3 <- NL_noEN[!is.na(NL_noEN$diff),]
NL_noEN_3_s <- split(NL_noEN_3, sample(1:round(nrow(NL_noEN_3)/60), nrow(NL_noEN_3), replace=T))
NL_noEN_3_s$`1`$diff
NL_noEN_3_s_meandiff <- data.frame(seq(1,25))
NL_noEN_3_s_meandiff[1,] <- mean(NL_noEN_3_s$`1`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[2,] <- mean(NL_noEN_3_s$`2`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[3,] <- mean(NL_noEN_3_s$`3`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[4,] <- mean(NL_noEN_3_s$`4`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[5,] <- mean(NL_noEN_3_s$`5`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[6,] <- mean(NL_noEN_3_s$`6`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[7,] <- mean(NL_noEN_3_s$`7`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[8,] <- mean(NL_noEN_3_s$`8`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[9,] <- mean(NL_noEN_3_s$`9`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[10,] <- mean(NL_noEN_3_s$`10`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[11,] <- mean(NL_noEN_3_s$`11`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[12,] <- mean(NL_noEN_3_s$`12`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[13,] <- mean(NL_noEN_3_s$`13`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[14,] <- mean(NL_noEN_3_s$`14`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[15,] <- mean(NL_noEN_3_s$`15`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[16,] <- mean(NL_noEN_3_s$`16`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[17,] <- mean(NL_noEN_3_s$`17`$diff,na.rm = TRUE)
NL_noEN_3_s_meandiff[18,] <- mean(NL_noEN_3_s$`18`$diff,na.rm = TRUE)

NS_noEN_3 <- NS_noEN[!is.na(NS_noEN$diff),]
NS_noEN_3_s <- split(NS_noEN_3, sample(1:round(nrow(NS_noEN_3)/60), nrow(NS_noEN_3), replace=T))
NS_noEN_3_s$`1`$diff
NS_noEN_3_s_meandiff <- data.frame(seq(1,25))
NS_noEN_3_s_meandiff[1,] <- mean(NS_noEN_3_s$`1`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[2,] <- mean(NS_noEN_3_s$`2`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[3,] <- mean(NS_noEN_3_s$`3`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[4,] <- mean(NS_noEN_3_s$`4`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[5,] <- mean(NS_noEN_3_s$`5`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[6,] <- mean(NS_noEN_3_s$`6`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[7,] <- mean(NS_noEN_3_s$`7`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[8,] <- mean(NS_noEN_3_s$`8`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[9,] <- mean(NS_noEN_3_s$`9`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[10,] <- mean(NS_noEN_3_s$`10`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[11,] <- mean(NS_noEN_3_s$`11`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[12,] <- mean(NS_noEN_3_s$`12`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[13,] <- mean(NS_noEN_3_s$`13`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[14,] <- mean(NS_noEN_3_s$`14`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[15,] <- mean(NS_noEN_3_s$`15`$diff,na.rm = TRUE)
NS_noEN_3_s_meandiff[16,] <- mean(NS_noEN_3_s$`16`$diff,na.rm = TRUE)


SL_noEN_3 <- SL_noEN[!is.na(SL_noEN$diff),]
SL_noEN_3_s <- split(SL_noEN_3, sample(1:round(nrow(SL_noEN_3)/60), nrow(SL_noEN_3), replace=T))
SL_noEN_3_s$`1`$diff
SL_noEN_3_s_meandiff <- data.frame(seq(1,25))
SL_noEN_3_s_meandiff[1,] <- mean(SL_noEN_3_s$`1`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[2,] <- mean(SL_noEN_3_s$`2`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[3,] <- mean(SL_noEN_3_s$`3`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[4,] <- mean(SL_noEN_3_s$`4`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[5,] <- mean(SL_noEN_3_s$`5`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[6,] <- mean(SL_noEN_3_s$`6`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[7,] <- mean(SL_noEN_3_s$`7`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[8,] <- mean(SL_noEN_3_s$`8`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[9,] <- mean(SL_noEN_3_s$`9`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[10,] <- mean(SL_noEN_3_s$`10`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[11,] <- mean(SL_noEN_3_s$`11`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[12,] <- mean(SL_noEN_3_s$`12`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[13,] <- mean(SL_noEN_3_s$`13`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[14,] <- mean(SL_noEN_3_s$`14`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[15,] <- mean(SL_noEN_3_s$`15`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[16,] <- mean(SL_noEN_3_s$`16`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[17,] <- mean(SL_noEN_3_s$`17`$diff,na.rm = TRUE)
SL_noEN_3_s_meandiff[18,] <- mean(SL_noEN_3_s$`18`$diff,na.rm = TRUE)

VB_noEN_3 <- VB_noEN[!is.na(VB_noEN$diff),]
VB_noEN_3_s <- split(VB_noEN_3, sample(1:round(nrow(VB_noEN_3)/60), nrow(VB_noEN_3), replace=T))
VB_noEN_3_s$`1`$diff
VB_noEN_3_s_meandiff <- data.frame(seq(1,25))
VB_noEN_3_s_meandiff[1,] <- mean(VB_noEN_3_s$`1`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[2,] <- mean(VB_noEN_3_s$`2`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[3,] <- mean(VB_noEN_3_s$`3`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[4,] <- mean(VB_noEN_3_s$`4`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[5,] <- mean(VB_noEN_3_s$`5`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[6,] <- mean(VB_noEN_3_s$`6`$diff,na.rm = TRUE)
VB_noEN_3_s_meandiff[7,] <- mean(VB_noEN_3_s$`7`$diff,na.rm = TRUE)


noEN_3_meandiff <- cbind(BOW_noEN_3_s_meandiff,LF_noEN_3_s_meandiff,NL_noEN_3_s_meandiff,NS_noEN_3_s_meandiff,SL_noEN_3_s_meandiff,VB_noEN_3_s_meandiff)
colnames(noEN_3_meandiff) <- c("BOW","LF","NL","NS","SL","VB")

p3 <- ggplot(noEN_3_meandiff)
p3 <- p3 + scale_x_discrete(name="") +
  scale_y_continuous(name="Mean Difference",lim=c(-0.3,1)) +
  geom_hline(yintercept = 0,linetype="dashed")+
  theme_classic()+guides(fill=FALSE)+
  geom_violin(aes(x="1_VB",y=VB,fill=region.cols[["VaskessBay"]]))+
  geom_violin(aes(x="2_SL",y=SL,fill=region.cols[["SouthLagoon"]]))+
  geom_violin(aes(x="3_LF",y=LF,fill=region.cols[["MidLagoon"]]))+
  geom_violin(aes(x="4_NL",y=NL,fill=region.cols[["NorthLagoon"]]))+
  geom_violin(aes(x="5_NS",y=NS,fill=region.cols[["NorthShore"]]))+
  geom_violin(aes(x="6_BOW",y=BOW,fill=region.cols[["BayofWrecks"]]))+
  scale_fill_manual(values = c("#0F8554","#1D6996","#5F4690","#CC503E","#E17C05","#EDAD08"))
p3

grid.arrange(p,p3,ncol=2)
