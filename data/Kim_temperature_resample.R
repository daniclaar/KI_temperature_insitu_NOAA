# Prepare KCobb data 

#Clear working directory
rm(list=ls())

# Load necessary data
load("data/SeaBird_KCobb_trimmed.RData")

#Load necessary packages
library(iemisc)

loggers <- ls()

BOW_01849_2014toNov2015$DateTime <- as.POSIXct(paste(BOW_01849_2014toNov2015$Date,
                                                     BOW_01849_2014toNov2015$Time),
                                               format="%Y-%m-%d %H:%M:%S",
                                               tz="Pacific/Kiritimati")

CTDsite_01845_Nov2015toMar2016$DateTime <- as.POSIXct(paste(CTDsite_01845_Nov2015toMar2016$Date,CTDsite_01845_Nov2015toMar2016$Time),format="%Y-%m-%d %H:%M:%S",
                                               tz="Pacific/Kiritimati")

CTDsite_01850_2014toNov2015$DateTime <- as.POSIXct(paste(CTDsite_01850_2014toNov2015$Date, CTDsite_01850_2014toNov2015$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

CTDsite_01850_Mar2016toNov2016$DateTime <- as.POSIXct(paste(CTDsite_01850_Mar2016toNov2016$Date, CTDsite_01850_Mar2016toNov2016$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

CTDsite_06985_Nov2016toMar2018$DateTime <- as.POSIXct(paste(CTDsite_06985_Nov2016toMar2018$Date, CTDsite_06985_Nov2016toMar2018$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

site22_01845_2014toNov2015$DateTime <- as.POSIXct(paste(site22_01845_2014toNov2015$Date, site22_01845_2014toNov2015$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

site33_01857_2014toNov2015$DateTime <- as.POSIXct(paste(site33_01857_2014toNov2015$Date, site33_01857_2014toNov2015$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

site33_01861_Nov2016toMar2018$DateTime <- as.POSIXct(paste(site33_01861_Nov2016toMar2018$Date, site33_01861_Nov2016toMar2018$Time), format="%Y-%m-%d %H:%M:%S",tz="Pacific/Kiritimati")

site5_00653_Jul2015toNov2015$DateTime <- as.POSIXct(paste(site5_00653_Jul2015toNov2015$Date, site5_00653_Jul2015toNov2015$Time), format="%m/%d/%Y %H:%M:%S", tz="Pacific/Kiritimati")

site27_01970_Sep2014toNov2015$DateTime <- as.POSIXct(paste(site27_01970_Sep2014toNov2015$Date, site27_01970_Sep2014toNov2015$Time), format="%Y-%m-%d %H:%M:%S", tz="Pacific/Kiritimati")

###
# The first date that we want to interpolate from (started 2011-1-1 for ease later on)
startDate <- as.POSIXct("2011/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# The last date that we want to interpolate to (ended 2016-12-31 for ease later on)
endDate <- as.POSIXct("2016/12/31 23:59:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# Create the POSIXct (time) object that we will be standardizing to - 1 minute interval
xi <- (seq(from=startDate, to= endDate, by=60)) # by=60 means interpolate by 1 minute intervals
xi2 <- (seq(from=startDate, to= endDate, by=3600)) # by=3600 means interpolate by 1 hour intervals
# Create a list regions for reference later
regions=c("southlagoon","northlagoon","lagoonface","northshore","bayofwrecks","vaskesbay")
# Create a list of sites for reference later
sitelist <- c("K_22","K_27","K_33","BOW_K","CTD_K")

## Now do the actual interpolation
## Use DateTime to interpolate Temperature over xi. Don't remove NA values. The maximum gap (sequence of NAs) to interpolate over is 10800 seconds or 3 hours
# List all loggers for use in loop
logger <- loggers
# For every logger, create and evaluate a string of form: 
# loggername_interp <- na.interp(loggername$DateTime, loggername$Temperature, xi, na.rm=FALSE, maxgap=10800)
for (i in 1:length(logger)) {
  evalstr<-paste((logger[i]),"_interp <- ","na.interp1(", logger[i], "$DateTime,",logger[i],"$Temperature, xi, na.rm=FALSE, maxgap=10800)",sep="")
  eval(parse(text=evalstr))
}

BOW_K <- c("BOW_01849_2014toNov2015_interp")
CTD_K <- c("CTDsite_01845_Nov2015toMar2016_interp", "CTDsite_01850_2014toNov2015_interp", "CTDsite_01850_Mar2016toNov2016_interp", "CTDsite_06985_Nov2016toMar2018_interp")
K_22 <- c("site22_01845_2014toNov2015_interp")
K_33 <- c("site33_01857_2014toNov2015_interp", "site33_01861_Nov2016toMar2018_interp")
site_5 <- c("site5_00653_Jul2015toNov2015_interp")  
K_27 <- c("site27_01970_Sep2014toNov2015_interp")

# Create dataframe for each region that includes all interpolated objects for that site
lagoonface <- c(K_33)
northshore <- c(K_22)
bayofwrecks <- c(BOW_K)
vaskesbay <- c(site_5,CTD_K)
northlagoon <- c(K_27)
allsites <- c(K_33,K_22,BOW_K,site_5,CTD_K)

## Now, we merge all data from a single site into an object sampled at 1 minute intervals
# Create 'indivlogger' to inclue all loggers at site
indivlogger <- paste(K_27,collapse=",")
# Create a string (for later evaluation) that binds together all individual loggers
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
# Evaluate that string
eval(parse(text=evalstr))
# Collapse all of the columns in temperature_1m into one column by using rowMeans
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
# Bind together the time vector (xi) and the temperature
K_27_1m<-cbind.data.frame(xi,temperature_1m)
## Now calculate the mean for each hour
# Create a temporary vector 'tempmatrix'
tempmatrix <- temperature_1m
# Reshape tempmatrix to be able to use colMeans to collapse each hour
dim(tempmatrix) = c(60,length(temperature_1m)/60)
# Collapse by-minute data to hourly data, by taking the mean of all minutes in an hour
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
# Bind together the new time vector (xi2) and the hourly temperature
K_27_1hr<-cbind.data.frame(xi2,temperature_1hr)
# Remove temporary variables to avoid confusion later on
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(site_5,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
site_5_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
site_5_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(site_5,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
site_5_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
site_5_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(K_33,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
K_33_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
K_33_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(K_22,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
K_22_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
K_22_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(CTD_K,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
CTD_K_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
CTD_K_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

indivlogger <- paste(BOW_K,collapse=",")
evalstr <- paste("temperature_1m <- cbind(",indivlogger,")")
eval(parse(text=evalstr))
temperature_1m <- rowMeans(temperature_1m,na.rm=TRUE)
BOW_K_1m<-cbind.data.frame(xi,temperature_1m)
tempmatrix <- temperature_1m
dim(tempmatrix) = c(60,length(temperature_1m)/60)
temperature_1hr <- colMeans(tempmatrix,na.rm=TRUE)
BOW_K_1hr<-cbind.data.frame(xi2,temperature_1hr)
rm(temperature_1m,temperature_1hr)

save(BOW_K_1m,site_5_1m,K_33_1m,K_22_1m,CTD_K_1m,K_27_1m,file = "data/KI_SB_Kim_temp_1m.RData")
save(BOW_K_1hr,site_5_1hr,K_33_1hr,K_22_1hr,K_27_1hr,CTD_K_1hr,file = "data/KI_SB_Kim_temp_1hr.RData")
