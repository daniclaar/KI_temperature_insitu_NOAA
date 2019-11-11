################################################################################
################# CALCULATE DHW FOR ALL SITES AND REGIONS ######################
################################################################################
# Clear R environment
rm(list=ls())

# Load necessary packages
library(zoo)

# Load necessary data
load("data/KI_SB_temp_wKim_1hr.RData")
load("data/NOAA_MMM_byregion.RData")
## Create startDate and endDate
# The first date that we want to interpolate from (started 2011-1-1 for ease later on)
startDate <- as.POSIXct("2011/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# The last date that we want to interpolate to (ended 2016-12-31 for ease later on)
endDate <- as.POSIXct("2016/12/31 23:59:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# Create a time vector (xi4) sampled to half week (for calculation of DHW)
xi4 <- (seq(from=startDate, to= endDate, by=302400))
# Subtract 1 day from xi4 to make half weekly calculations work
xi4 <- xi4[1:length(xi4)-1]

# Now collapse to half-weekly temperature
# Create temporary tempmatrix
tempmatrix <- southlagoon_1hr_wKim$temperature_1hr
# Truncate tempmatrix to allow for round half weekly calculations
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
# Reshape tempmatrix to be able to calculate half weekly temperature
dim(tempmatrix) = c(84,length(tempmatrix)/84)
# Calculate the mean of each half weekly temperature range
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
# Bind together the time vector (xi4) with the half-weekly temperature
southlagoon_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
# Remove temperature_halfwk to avoid confusion later on
rm(temperature_halfwk)

tempmatrix <- northlagoon_1hr_wKim$temperature_1hr
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
dim(tempmatrix) = c(84,length(tempmatrix)/84)
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
northlagoon_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
rm(temperature_halfwk)

tempmatrix <- lagoonface_1hr_wKim$temperature_1hr
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
dim(tempmatrix) = c(84,length(tempmatrix)/84)
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
lagoonface_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
rm(temperature_halfwk)

tempmatrix <- northshore_1hr_wKim$temperature_1hr
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
dim(tempmatrix) = c(84,length(tempmatrix)/84)
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
northshore_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
rm(temperature_halfwk)

tempmatrix <- bayofwrecks_1hr_wKim$temperature_1hr
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
dim(tempmatrix) = c(84,length(tempmatrix)/84)
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
bayofwrecks_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
rm(temperature_halfwk)

tempmatrix <- vaskesbay_1hr_wKim$temperature_1hr
tempmatrix <- tempmatrix[1:(floor(length(tempmatrix)/84)*84)]
dim(tempmatrix) = c(84,length(tempmatrix)/84)
temperature_halfwk <- colMeans(tempmatrix,na.rm=TRUE)
vaskesbay_halfwk<-cbind.data.frame(xi4,temperature_halfwk)
rm(temperature_halfwk)

################################################################################
## Now calculate the hotspot for all regions
# Set the MMM temperature (i.e. the mean monthly maximum, from NOAA)
MMM_NOAA_VB <- MMM_all[6]
MMM_NOAA_SL <- MMM_all[5]
MMM_NOAA_LF <- MMM_all[2]
MMM_NOAA_NL <- MMM_all[3]
MMM_NOAA_NS <- MMM_all[4]
MMM_NOAA_BOW <- MMM_all[1]

# Create a dataframe including time vector xi4
southlagoon_hotspot <- data.frame(xi4)
# Create "hotspot"
hotspot<-southlagoon_hotspot$hotspot
# Assign hotspot value, this is (halfweekly temperature) - (base temperature)
hotspot<-southlagoon_halfwk$temperature_halfwk-MMM_NOAA_SL
# Only keep hotspot temperature if the hotspot is >1 (for calculation of DHW)
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
# Bind together the time vector and the hotspot vector
southlagoon_hotspot <- cbind.data.frame(southlagoon_hotspot,hotspot)
# Remove hotspot to avoid confusion later on
rm(hotspot)

northlagoon_hotspot <- data.frame(xi4)
hotspot<-northlagoon_hotspot$hotspot
hotspot<-northlagoon_halfwk$temperature_halfwk-MMM_NOAA_NL
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
northlagoon_hotspot <- cbind.data.frame(northlagoon_hotspot,hotspot)
rm(hotspot)

lagoonface_hotspot <- data.frame(xi4)
hotspot<-lagoonface_hotspot$hotspot
hotspot<-lagoonface_halfwk$temperature_halfwk-MMM_NOAA_LF
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
lagoonface_hotspot <- cbind.data.frame(lagoonface_hotspot,hotspot)
rm(hotspot)

northshore_hotspot <- data.frame(xi4)
hotspot<-northshore_hotspot$hotspot
hotspot<-northshore_halfwk$temperature_halfwk-MMM_NOAA_NS
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
northshore_hotspot <- cbind.data.frame(northshore_hotspot,hotspot)
rm(hotspot)

bayofwrecks_hotspot <- data.frame(xi4)
hotspot<-bayofwrecks_hotspot$hotspot
hotspot<-bayofwrecks_halfwk$temperature_halfwk-MMM_NOAA_BOW
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
bayofwrecks_hotspot <- cbind.data.frame(bayofwrecks_hotspot,hotspot)
rm(hotspot)

vaskesbay_hotspot <- data.frame(xi4)
hotspot<-vaskesbay_hotspot$hotspot
hotspot<-vaskesbay_halfwk$temperature_halfwk-MMM_NOAA_VB
hotspot<-ifelse(hotspot<1,hotspot==0,hotspot)
vaskesbay_hotspot <- cbind.data.frame(vaskesbay_hotspot,hotspot)
rm(hotspot)

###################################################################################
## Now calculate the Degree Heating Week (DHW) ##
# Set the window for the rolling sum (this is 24 half weeks = summing over 12 weeks)
k=24

# Create a dataframe including the time vector xi4
southlagoon_DHW <- data.frame(xi4)
# Calculate the DHW using rollapply, summing across a 12 week window (k=24 half weeks). Multiply value by 0.5 to get DHW
southlagoon_DHW$DHW<-(rollapply(southlagoon_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

northlagoon_DHW <- data.frame(xi4)
northlagoon_DHW$DHW<-(rollapply(northlagoon_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

lagoonface_DHW <- data.frame(xi4)
lagoonface_DHW$DHW<-(rollapply(lagoonface_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

northshore_DHW <- data.frame(xi4)
northshore_DHW$DHW<-(rollapply(northshore_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

bayofwrecks_DHW <- data.frame(xi4)
bayofwrecks_DHW$DHW<-(rollapply(bayofwrecks_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

vaskesbay_DHW <- data.frame(xi4)
vaskesbay_DHW$DHW<-(rollapply(vaskesbay_hotspot$hotspot, width=k, by=1, sum, fill=c(NA,NA,NA), align="right",partial=FALSE)*0.5)

southlagoon_DHW_NOAAMMM <- southlagoon_DHW
northlagoon_DHW_NOAAMMM <- northlagoon_DHW
lagoonface_DHW_NOAAMMM <- lagoonface_DHW
northshore_DHW_NOAAMMM <- northshore_DHW
bayofwrecks_DHW_NOAAMMM <- bayofwrecks_DHW
vaskesbay_DHW_NOAAMMM <- vaskesbay_DHW

# Save all DHW data to an .RData file
save(southlagoon_DHW_NOAAMMM,northlagoon_DHW_NOAAMMM,lagoonface_DHW_NOAAMMM,northshore_DHW_NOAAMMM,bayofwrecks_DHW_NOAAMMM,vaskesbay_DHW_NOAAMMM,file="data/KI_SB_temp_DHW_NOAAMMM.RData")
