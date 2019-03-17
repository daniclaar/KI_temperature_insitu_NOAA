rm(list=ls())

library(zoo)

load("data/KI_SB_temp_1hr.RData")
load("data/KI_SB_Kim_temp_1hr.RData")

# Create dataframe for each region that includes all interpolated objects for that site
southlagoon <- c("site8_1hr","site34_1hr","site35_1hr")
northlagoon <- c("site27_1hr","site30_1hr")
lagoonface <- c("site9_1hr","site32_1hr","site33_1hr","site40_1hr","K_33_1hr")
northshore <- c("site25_1hr","site3_1hr","K_22_1hr")
bayofwrecks <- c("site15_1hr","site19_1hr","BOW_K_1hr")
vaskesbay <- c("site5_1hr","site_5_1hr","CTD_K_1hr")
allsites <- c("site8_1hr","site34_1hr","site35_1hr","site27_1hr","site30_1hr","site9_1hr","site32_1hr","site33_1hr","site40_1hr","site25_1hr","site3_1hr","site15_1hr","site19_1hr","site5_1hr","K_33_1hr","K_22_1hr","BOW_K_1hr","site_5_1hr","CTD_K_1hr")

startDate <- as.POSIXct("2011/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# The last date that we want to interpolate to (ended 2016-12-31 for ease later on)
endDate <- as.POSIXct("2016/12/31 23:59:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# Create the POSIXct (time) object that we will be standardizing to - 1 minute interval
xi <- (seq(from=startDate, to= endDate, by=60)) # by=60 means interpolate by 1 minute intervals
xi2 <- (seq(from=startDate, to= endDate, by=3600)) # by=3600 means interpolate by 1 hour intervals
xi3 <- (seq(from=startDate, to= endDate, by=86400)) # by=86400 means interpolate by daily intervals

###
indivlogger <- paste(northlagoon,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
northlagoon_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(northlagoon_1hr)
northlagoon_1hr_wKim <- northlagoon_1hr

indivlogger <- paste(southlagoon,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
southlagoon_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(southlagoon_1hr)
southlagoon_1hr_wKim <- southlagoon_1hr

indivlogger <- paste(lagoonface,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
lagoonface_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(lagoonface_1hr)
lagoonface_1hr_wKim <- lagoonface_1hr

indivlogger <- paste(northshore,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
northshore_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(northshore_1hr)
northshore_1hr_wKim <- northshore_1hr

indivlogger <- paste(bayofwrecks,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
bayofwrecks_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(bayofwrecks_1hr)
bayofwrecks_1hr_wKim <- bayofwrecks_1hr


indivlogger <- paste(vaskesbay,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
vaskesbay_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(vaskesbay_1hr)
vaskesbay_1hr_wKim <- vaskesbay_1hr


#####
## Now calculate the mean for each hour
# Create a temporary vector 'tempmatrix'
tempmatrix <- bayofwrecks_1hr$temperature_1hr
# Reshape tempmatrix to be able to use colMeans to collapse each hour
dim(tempmatrix) = c(24,length(bayofwrecks_1hr$temperature_1hr)/24)
# Collapse by-minute data to hourly data, by taking the mean of all minutes in an hour
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
# Bind together the new time vector (xi2) and the hourly temperature
bayofwrecks_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- vaskesbay_1hr$temperature_1hr
dim(tempmatrix) = c(24,length(vaskesbay_1hr$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
vaskesbay_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- southlagoon_1hr$temperature_1hr
dim(tempmatrix) = c(24,length(southlagoon_1hr$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
southlagoon_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- lagoonface_1hr$temperature_1hr
dim(tempmatrix) = c(24,length(lagoonface_1hr$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
lagoonface_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- northlagoon_1hr$temperature_1hr
dim(tempmatrix) = c(24,length(northlagoon_1hr$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
northlagoon_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- northshore_1hr$temperature_1hr
dim(tempmatrix) = c(24,length(northshore_1hr$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
northshore_1d_wKim<-cbind.data.frame(xi3,temperature_1d)

######################
# Now use nightime only temperatures

sunRise <- format("05:00:00",format="%H:%M:%S")
sunSet <- format("20:00:00",format="%H:%M:%S")

site8_1hr_night <- site8_1hr
site8_1hr_night$time <- format(site8_1hr$xi2, format="%H:%M:%S")
site8_1hr_night$dayNight <- ifelse(site8_1hr_night$time > sunRise & site8_1hr_night$time < sunSet, 'day', 'night')
site8_1hr_night$temperature_1hr[site8_1hr_night$dayNight=="day"] <- NA
site8_1hr_night <- site8_1hr_night[c(1,2)]

site3_1hr_night <- site3_1hr
site3_1hr_night$time <- format(site3_1hr$xi2, format="%H:%M:%S")
site3_1hr_night$dayNight <- ifelse(site3_1hr_night$time > sunRise & site3_1hr_night$time < sunSet, 'day', 'night')
site3_1hr_night$temperature_1hr[site3_1hr_night$dayNight=="day"] <- NA
site3_1hr_night <- site3_1hr_night[c(1,2)]

site5_1hr_night <- site5_1hr
site5_1hr_night$time <- format(site5_1hr$xi2, format="%H:%M:%S")
site5_1hr_night$dayNight <- ifelse(site5_1hr_night$time > sunRise & site5_1hr_night$time < sunSet, 'day', 'night')
site5_1hr_night$temperature_1hr[site5_1hr_night$dayNight=="day"] <- NA
site5_1hr_night <- site5_1hr_night[c(1,2)]

site9_1hr_night <- site9_1hr
site9_1hr_night$time <- format(site9_1hr$xi2, format="%H:%M:%S")
site9_1hr_night$dayNight <- ifelse(site9_1hr_night$time > sunRise & site9_1hr_night$time < sunSet, 'day', 'night')
site9_1hr_night$temperature_1hr[site9_1hr_night$dayNight=="day"] <- NA
site9_1hr_night <- site9_1hr_night[c(1,2)]

site15_1hr_night <- site15_1hr
site15_1hr_night$time <- format(site15_1hr$xi2, format="%H:%M:%S")
site15_1hr_night$dayNight <- ifelse(site15_1hr_night$time > sunRise & site15_1hr_night$time < sunSet, 'day', 'night')
site15_1hr_night$temperature_1hr[site15_1hr_night$dayNight=="day"] <- NA
site15_1hr_night <- site15_1hr_night[c(1,2)]

site19_1hr_night <- site19_1hr
site19_1hr_night$time <- format(site19_1hr$xi2, format="%H:%M:%S")
site19_1hr_night$dayNight <- ifelse(site19_1hr_night$time > sunRise & site19_1hr_night$time < sunSet, 'day', 'night')
site19_1hr_night$temperature_1hr[site19_1hr_night$dayNight=="day"] <- NA
site19_1hr_night <- site19_1hr_night[c(1,2)]

site25_1hr_night <- site25_1hr
site25_1hr_night$time <- format(site25_1hr$xi2, format="%H:%M:%S")
site25_1hr_night$dayNight <- ifelse(site25_1hr_night$time > sunRise & site25_1hr_night$time < sunSet, 'day', 'night')
site25_1hr_night$temperature_1hr[site25_1hr_night$dayNight=="day"] <- NA
site25_1hr_night <- site25_1hr_night[c(1,2)]

site27_1hr_night <- site27_1hr
site27_1hr_night$time <- format(site27_1hr$xi2, format="%H:%M:%S")
site27_1hr_night$dayNight <- ifelse(site27_1hr_night$time > sunRise & site27_1hr_night$time < sunSet, 'day', 'night')
site27_1hr_night$temperature_1hr[site27_1hr_night$dayNight=="day"] <- NA
site27_1hr_night <- site27_1hr_night[c(1,2)]

site30_1hr_night <- site30_1hr
site30_1hr_night$time <- format(site30_1hr$xi2, format="%H:%M:%S")
site30_1hr_night$dayNight <- ifelse(site30_1hr_night$time > sunRise & site30_1hr_night$time < sunSet, 'day', 'night')
site30_1hr_night$temperature_1hr[site30_1hr_night$dayNight=="day"] <- NA
site30_1hr_night <- site30_1hr_night[c(1,2)]

site32_1hr_night <- site32_1hr
site32_1hr_night$time <- format(site32_1hr$xi2, format="%H:%M:%S")
site32_1hr_night$dayNight <- ifelse(site32_1hr_night$time > sunRise & site32_1hr_night$time < sunSet, 'day', 'night')
site32_1hr_night$temperature_1hr[site32_1hr_night$dayNight=="day"] <- NA
site32_1hr_night <- site32_1hr_night[c(1,2)]

site33_1hr_night <- site33_1hr
site33_1hr_night$time <- format(site33_1hr$xi2, format="%H:%M:%S")
site33_1hr_night$dayNight <- ifelse(site33_1hr_night$time > sunRise & site33_1hr_night$time < sunSet, 'day', 'night')
site33_1hr_night$temperature_1hr[site33_1hr_night$dayNight=="day"] <- NA
site33_1hr_night <- site33_1hr_night[c(1,2)]

site34_1hr_night <- site34_1hr
site34_1hr_night$time <- format(site34_1hr$xi2, format="%H:%M:%S")
site34_1hr_night$dayNight <- ifelse(site34_1hr_night$time > sunRise & site34_1hr_night$time < sunSet, 'day', 'night')
site34_1hr_night$temperature_1hr[site34_1hr_night$dayNight=="day"] <- NA
site34_1hr_night <- site34_1hr_night[c(1,2)]

site35_1hr_night <- site35_1hr
site35_1hr_night$time <- format(site35_1hr$xi2, format="%H:%M:%S")
site35_1hr_night$dayNight <- ifelse(site35_1hr_night$time > sunRise & site35_1hr_night$time < sunSet, 'day', 'night')
site35_1hr_night$temperature_1hr[site35_1hr_night$dayNight=="day"] <- NA
site35_1hr_night <- site35_1hr_night[c(1,2)]

site40_1hr_night <- site40_1hr
site40_1hr_night$time <- format(site40_1hr$xi2, format="%H:%M:%S")
site40_1hr_night$dayNight <- ifelse(site40_1hr_night$time > sunRise & site40_1hr_night$time < sunSet, 'day', 'night')
site40_1hr_night$temperature_1hr[site40_1hr_night$dayNight=="day"] <- NA
site40_1hr_night <- site40_1hr_night[c(1,2)]

K_33_1hr_night <- K_33_1hr
K_33_1hr_night$time <- format(K_33_1hr$xi2, format="%H:%M:%S")
K_33_1hr_night$dayNight <- ifelse(K_33_1hr_night$time > sunRise & K_33_1hr_night$time < sunSet, 'day', 'night')
K_33_1hr_night$temperature_1hr[K_33_1hr_night$dayNight=="day"] <- NA
K_33_1hr_night <- K_33_1hr_night[c(1,2)]

K_22_1hr_night <- K_22_1hr
K_22_1hr_night$time <- format(K_22_1hr$xi2, format="%H:%M:%S")
K_22_1hr_night$dayNight <- ifelse(K_22_1hr_night$time > sunRise & K_22_1hr_night$time < sunSet, 'day', 'night')
K_22_1hr_night$temperature_1hr[K_22_1hr_night$dayNight=="day"] <- NA
K_22_1hr_night <- K_22_1hr_night[c(1,2)]

BOW_K_1hr_night <- BOW_K_1hr
BOW_K_1hr_night$time <- format(BOW_K_1hr$xi2, format="%H:%M:%S")
BOW_K_1hr_night$dayNight <- ifelse(BOW_K_1hr_night$time > sunRise & BOW_K_1hr_night$time < sunSet, 'day', 'night')
BOW_K_1hr_night$temperature_1hr[BOW_K_1hr_night$dayNight=="day"] <- NA
BOW_K_1hr_night <- BOW_K_1hr_night[c(1,2)]

site_5_1hr_night <- site_5_1hr
site_5_1hr_night$time <- format(site_5_1hr$xi2, format="%H:%M:%S")
site_5_1hr_night$dayNight <- ifelse(site_5_1hr_night$time > sunRise & site_5_1hr_night$time < sunSet, 'day', 'night')
site_5_1hr_night$temperature_1hr[site_5_1hr_night$dayNight=="day"] <- NA
site_5_1hr_night <- site_5_1hr_night[c(1,2)]

CTD_K_1hr_night <- CTD_K_1hr
CTD_K_1hr_night$time <- format(CTD_K_1hr$xi2, format="%H:%M:%S")
CTD_K_1hr_night$dayNight <- ifelse(CTD_K_1hr_night$time > sunRise & CTD_K_1hr_night$time < sunSet, 'day', 'night')
CTD_K_1hr_night$temperature_1hr[CTD_K_1hr_night$dayNight=="day"] <- NA
CTD_K_1hr_night <- CTD_K_1hr_night[c(1,2)]

tempmatrix <- BOW_K_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(BOW_K_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
BOW_K_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- CTD_K_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(CTD_K_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
CTD_K_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- K_22_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(K_22_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
K_22_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- K_33_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(K_33_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
K_33_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site_5_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site_5_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site_5_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site15_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site15_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site15_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site19_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site19_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site19_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site25_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site25_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site25_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site27_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site27_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site27_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site3_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site3_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site3_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site30_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site30_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site30_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site32_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site32_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site32_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site33_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site33_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site33_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site34_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site34_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site34_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site35_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site35_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site35_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site40_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site40_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site40_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site5_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site5_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site5_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site8_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site8_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site8_night_1d<-cbind.data.frame(xi3,temperature_1d)

tempmatrix <- site9_1hr_night$temperature_1hr
dim(tempmatrix) = c(24,length(site9_1hr_night$temperature_1hr)/24)
temperature_1d <- colMeans(tempmatrix,na.rm=TRUE)
site9_night_1d<-cbind.data.frame(xi3,temperature_1d)


group_sites_by_region <- function(region, region_name){
  indivlogger <- paste(region,collapse=",")
  evalstr <- paste("temperature_1d <- cbind(",indivlogger,")")
  eval(parse(text=evalstr))
  temperature_1d <- temperature_1d[,seq(0,ncol(temperature_1d),2)]
  ifelse(ncol(temperature_1d)>1,temperature_1d <- rowMeans(temperature_1d,na.rm=TRUE),temperature_1d)
  evalstr2 <- paste(region_name,"_1d <<- cbind.data.frame(xi3,temperature_1d)",sep="")
  eval(parse(text=evalstr2))
}

# Create dataframe for each region that includes all interpolated objects for that site
southlagoon_night <- c("site8_night_1d","site34_night_1d","site35_night_1d")
northlagoon_night <- c("site27_night_1d","site30_night_1d")
lagoonface_night <- c("site9_night_1d","site32_night_1d","site33_night_1d","site40_night_1d","K_33_night_1d")
northshore_night <- c("site25_night_1d","site3_night_1d","K_22_night_1d")
bayofwrecks_night <- c("site15_night_1d","site19_night_1d","BOW_K_night_1d")
vaskesbay_night <- c("site5_night_1d","site_5_night_1d","CTD_K_night_1d")
allsites_night <- c("site8_night_1d","site34_night_1d","site35_night_1d","site27_night_1d","site30_night_1d","site9_night_1d","site32_night_1d","site33_night_1d","site40_night_1d","site25_night_1d","site3_night_1d","site15_night_1d","site19_night_1d","site5_night_1d","K_33_night_1d","K_22_night_1d","BOW_K_night_1d","site_5_night_1d","CTD_K_night_1d")

group_sites_by_region(region=southlagoon_night,region_name="southlagoon_night_wKim")
group_sites_by_region(region=northlagoon_night,region_name="northlagoon_night_wKim")
group_sites_by_region(region=lagoonface_night,region_name="lagoonface_night_wKim")
group_sites_by_region(region=northshore_night,region_name="northshore_night_wKim")
group_sites_by_region(region=bayofwrecks_night,region_name="bayofwrecks_night_wKim")
group_sites_by_region(region=vaskesbay_night,region_name="vaskesbay_night_wKim")
group_sites_by_region(region=allsites_night,region_name="KI_allsites_night_wKim")



save(vaskesbay_1d_wKim,vaskesbay_night_wKim_1d,
     southlagoon_1d_wKim,southlagoon_night_wKim_1d,
     lagoonface_1d_wKim,lagoonface_night_wKim_1d,
     northlagoon_1d_wKim,northlagoon_night_wKim_1d,
     northshore_1d_wKim,northshore_night_wKim_1d,
     bayofwrecks_1d_wKim,bayofwrecks_night_wKim_1d,
     file = "data/KI_SB_temp_wKim_1d.RData")

save(vaskesbay_1hr_wKim,
     southlagoon_1hr_wKim,
     lagoonface_1hr_wKim,
     northlagoon_1hr_wKim,
     northshore_1hr_wKim,
     bayofwrecks_1hr_wKim,
     file = "data/KI_SB_temp_wKim_1hr.RData")