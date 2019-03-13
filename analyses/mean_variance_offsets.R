# Clear working environment
rm(list=ls())

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

