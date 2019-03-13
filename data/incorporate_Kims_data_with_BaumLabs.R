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

indivlogger <- paste(southlagoon,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
southlagoon_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(southlagoon_1hr)

indivlogger <- paste(lagoonface,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
lagoonface_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(lagoonface_1hr)

indivlogger <- paste(northshore,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
northshore_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(northshore_1hr)

indivlogger <- paste(bayofwrecks,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
bayofwrecks_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(bayofwrecks_1hr)

indivlogger <- paste(vaskesbay,"$temperature_1hr",collapse=",",sep = "")
evalstr <- paste("temperature_1hr <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1hr <- rowMeans(temperature_1hr,na.rm=TRUE)
vaskesbay_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1hr)
plot(vaskesbay_1hr)

# day.hour <- seq(1, length = length(xi2), by = 1/24)

# vaskessbay_wKim_alltime <- aggregate(zoo(vaskesbay_1hr[, 2], day.hour), floor, mean)
# vaskessbay_wKim_1d<-cbind.data.frame(xi3,vaskessbay_wKim_alltime)
# southlagoon_wKim_alltime <- aggregate(x=zoo(vaskesbay_1hr[, 2], day.hour), by=floor, FUN=mean,na.rm=TRUE,na.action=na.pass)
# southlagoon_wKim_1d<-cbind.data.frame(xi3,southlagoon_wKim_alltime)
# lagoonface_wKim_alltime <- aggregate(zoo(vaskesbay_1hr[, 2], day.hour), floor, mean)
# lagoonface_wKim_1d<-cbind.data.frame(xi3,lagoonface_wKim_alltime)
# northlagoon_wKim_alltime <- aggregate(zoo(vaskesbay_1hr[, 2], day.hour), floor, mean)
# northlagoon_wKim_1d<-cbind.data.frame(xi3,northlagoon_wKim_alltime)
# northshore_wKim_alltime <- aggregate(zoo(vaskesbay_1hr[, 2], day.hour), floor, mean)
# northshore_wKim_1d<-cbind.data.frame(xi3,northshore_wKim_alltime)
# bayofwrecks_wKim_alltime <- aggregate(zoo(vaskesbay_1hr[, 2], day.hour), floor, mean)
# bayofwrecks_wKim_1d<-cbind.data.frame(xi3,bayofwrecks_wKim_alltime)

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

save(vaskesbay_1d_wKim,southlagoon_1d_wKim,lagoonface_1d_wKim,northlagoon_1d_wKim,northshore_1d_wKim,bayofwrecks_1d_wKim,file = "data/KI_SB_temp_wKim_1d.RData")
