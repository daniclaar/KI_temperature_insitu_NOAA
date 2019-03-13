# Load necessary libraries
library(iemisc)
library(ggplot2)
library(zoo)

# Load necessary data
load("data/KI_SB_temp_1hr.RData")


# Need to standardize in situ temperature to daily data
# Should do this for nighttime-only, and for all data together

# The first date that we want to interpolate from 
startDate <- as.POSIXct("2011/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# The last date that we want to interpolate to
endDate <- as.POSIXct("2016/12/31 23:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")

xi2 <- (seq(from=startDate, to= endDate, by=3600))
xi3 <- (seq(from=startDate, to= endDate, by=86400)) # by=86400 means interpolate by daily intervals

# Create a list regions for reference later
regions=c("southlagoon","northlagoon","lagoonface","northshore","bayofwrecks","vaskesbay")
# Create a list of sites for reference later
sitelist <- c("site3","site5","site8","site8.5","site9","site15","site19","site25","site27","site30","site32","site33","site34","site35","site40")

## Now do the actual interpolation
## Use DateTime to interpolate Temperature over xi. Don't remove NA values. The maximum gap (sequence of NAs) to interpolate over is 3 hours
# List all loggers for use in loop
logger <- grep("site",ls(),value=TRUE)
logger <- logger[!(logger %in% "sitelist")]

day.hour <- seq(1, length = length(xi2), by = 1/24)

site_8_alltime <- aggregate(zoo(site8_1hr[, 2], day.hour), floor, mean)
site_34_alltime <- aggregate(zoo(site34_1hr[, 2], day.hour), floor, mean)
site_35_alltime <- aggregate(zoo(site35_1hr[, 2], day.hour), floor, mean)
site_27_alltime <- aggregate(zoo(site27_1hr[, 2], day.hour), floor, mean)
site_30_alltime <- aggregate(zoo(site30_1hr[, 2], day.hour), floor, mean)
site_9_alltime <- aggregate(zoo(site9_1hr[, 2], day.hour), floor, mean)
site_32_alltime <- aggregate(zoo(site32_1hr[, 2], day.hour), floor, mean)
site_33_alltime <- aggregate(zoo(site33_1hr[, 2], day.hour), floor, mean)
site_40_alltime <- aggregate(zoo(site40_1hr[, 2], day.hour), floor, mean)
site_25_alltime <- aggregate(zoo(site25_1hr[, 2], day.hour), floor, mean)
site_3_alltime <- aggregate(zoo(site3_1hr[, 2], day.hour), floor, mean)
site_15_alltime <- aggregate(zoo(site15_1hr[, 2], day.hour), floor, mean)
site_19_alltime <- aggregate(zoo(site19_1hr[, 2], day.hour), floor, mean)
site_5_alltime <- aggregate(zoo(site5_1hr[, 2], day.hour), floor, mean)

## Now, create object for daily intervals
# Bind together the time vector (xi) and the temperature
site8_1d<-cbind.data.frame(xi3,site_8_alltime)
site34_1d<-cbind.data.frame(xi3,site_34_alltime)
site35_1d<-cbind.data.frame(xi3,site_35_alltime)
site27_1d<-cbind.data.frame(xi3,site_27_alltime)
site30_1d<-cbind.data.frame(xi3,site_30_alltime)
site9_1d<-cbind.data.frame(xi3,site_9_alltime)
site32_1d<-cbind.data.frame(xi3,site_32_alltime)
site33_1d<-cbind.data.frame(xi3,site_33_alltime)
site40_1d<-cbind.data.frame(xi3,site_40_alltime)
site25_1d<-cbind.data.frame(xi3,site_25_alltime)
site3_1d<-cbind.data.frame(xi3,site_3_alltime)
site15_1d<-cbind.data.frame(xi3,site_15_alltime)
site19_1d<-cbind.data.frame(xi3,site_19_alltime)
site5_1d<-cbind.data.frame(xi3,site_5_alltime)

# Create dataframe for each region that includes all interpolated objects for that site
southlagoon <- c(site8_1d,site34_1d,site35_1d)
northlagoon <- c(site27_1d,site30_1d)
lagoonface <- c(site9_1d,site32_1d,site33_1d,site40_1d)
northshore <- c(site25_1d,site3_1d)
bayofwrecks <- c(site15_1d,site19_1d)
vaskesbay <- c(site5_1d)
allsites <- c(site8_1d,site34_1d,site35_1d,site27_1d,
              site30_1d,site9_1d,site32_1d,site33_1d,
              site40_1d,site25_1d,site3_1d,site15_1d,
              site19_1d,site5_1d)

# Group sites by region
group_sites_by_region <- function(region, region_name){
  indivlogger <- paste(region,collapse=",")
  evalstr <- paste("temperature_1d <- cbind(",indivlogger,")")
  eval(parse(text=evalstr))
  temperature_1d <- temperature_1d[,seq(0,ncol(temperature_1d),2)]
  ifelse(ncol(temperature_1d)>1,temperature_1d <- rowMeans(temperature_1d,na.rm=TRUE),temperature_1d)
  evalstr2 <- paste(region_name,"_1d <<- cbind.data.frame(xi3,temperature_1d)",sep="")
  eval(parse(text=evalstr2))
}

group_sites_by_region(region=southlagoon,region_name="southlagoon")
group_sites_by_region(region=northlagoon,region_name="northlagoon")
group_sites_by_region(region=lagoonface,region_name="lagoonface")
group_sites_by_region(region=northshore,region_name="northshore")
group_sites_by_region(region=bayofwrecks,region_name="bayofwrecks")
group_sites_by_region(region=vaskesbay,region_name="vaskesbay")
group_sites_by_region(region=allsites,region_name="KI_allsites")


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

site_8_night <- aggregate(zoo(site8_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_34_night <- aggregate(zoo(site34_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_35_night <- aggregate(zoo(site35_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_27_night <- aggregate(zoo(site27_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_30_night <- aggregate(zoo(site30_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_9_night <- aggregate(zoo(site9_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_32_night <- aggregate(zoo(site32_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_33_night <- aggregate(zoo(site33_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_40_night <- aggregate(zoo(site40_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_25_night <- aggregate(zoo(site25_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_3_night <- aggregate(zoo(site3_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_15_night <- aggregate(zoo(site15_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_19_night <- aggregate(zoo(site19_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)
site_5_night <- aggregate(zoo(site5_1hr_night[, 2], day.hour), floor, mean, na.rm=TRUE)

## Now, create object for daily intervals
# Bind together the time vector (xi) and the temperature
site8_night_1d<-cbind.data.frame(xi3,site_8_night)
site34_night_1d<-cbind.data.frame(xi3,site_34_night)
site35_night_1d<-cbind.data.frame(xi3,site_35_night)
site27_night_1d<-cbind.data.frame(xi3,site_27_night)
site30_night_1d<-cbind.data.frame(xi3,site_30_night)
site9_night_1d<-cbind.data.frame(xi3,site_9_night)
site32_night_1d<-cbind.data.frame(xi3,site_32_night)
site33_night_1d<-cbind.data.frame(xi3,site_33_night)
site40_night_1d<-cbind.data.frame(xi3,site_40_night)
site25_night_1d<-cbind.data.frame(xi3,site_25_night)
site3_night_1d<-cbind.data.frame(xi3,site_3_night)
site15_night_1d<-cbind.data.frame(xi3,site_15_night)
site19_night_1d<-cbind.data.frame(xi3,site_19_night)
site5_night_1d<-cbind.data.frame(xi3,site_5_night)

# Create dataframe for each region that includes all interpolated objects for that site
southlagoon_night <- c(site8_night_1d,site34_night_1d,site35_night_1d)
northlagoon_night <- c(site27_night_1d,site30_night_1d)
lagoonface_night <- c(site9_night_1d,site32_night_1d,site33_night_1d,site40_night_1d)
northshore_night <- c(site25_night_1d,site3_night_1d)
bayofwrecks_night <- c(site15_night_1d,site19_night_1d)
vaskesbay_night <- c(site5_night_1d)
allsites_night <- c(site8_night_1d,site34_night_1d,site35_night_1d,site27_night_1d,
              site30_night_1d,site9_night_1d,site32_night_1d,site33_night_1d,
              site40_night_1d,site25_night_1d,site3_night_1d,site15_night_1d,
              site19_night_1d,site5_night_1d)

group_sites_by_region(region=southlagoon_night,region_name="southlagoon_night")
group_sites_by_region(region=northlagoon_night,region_name="northlagoon_night")
group_sites_by_region(region=lagoonface_night,region_name="lagoonface_night")
group_sites_by_region(region=northshore_night,region_name="northshore_night")
group_sites_by_region(region=bayofwrecks_night,region_name="bayofwrecks_night")
group_sites_by_region(region=vaskesbay_night,region_name="vaskesbay_night")
group_sites_by_region(region=allsites_night,region_name="KI_allsites_night")

# Save daily temperature data
save(site3_1d,site5_1d,site8_1d,site9_1d,site15_1d,site19_1d,site25_1d,site27_1d,site30_1d,site32_1d,site33_1d,site34_1d,site35_1d,site40_1d,southlagoon_1d,northlagoon_1d,lagoonface_1d,northshore_1d,bayofwrecks_1d,vaskesbay_1d,KI_allsites_1d,
     site3_night_1d,site5_night_1d,site8_night_1d,site9_night_1d,site15_night_1d,site19_night_1d,site25_night_1d,site27_night_1d,site30_night_1d,site32_night_1d,site33_night_1d,site34_night_1d,site35_night_1d,site40_night_1d,southlagoon_night_1d,northlagoon_night_1d,lagoonface_night_1d,northshore_night_1d,bayofwrecks_night_1d,vaskesbay_night_1d,KI_allsites_night_1d,
     file="data/KI_SB_temp_1d.RData")



# Sanity check: plotting
KI_allsites_1d_night_all <- cbind(KI_allsites_1d,KI_allsites_night_1d$temperature_1d)
colnames(KI_allsites_1d_night_all) <- c("xi3","all_times","night_only")

p <- ggplot(data=KI_allsites_1d_night_all,aes(x=xi3))+
  geom_line(aes(y=night_only),colour="black")+
  geom_line(aes(y=all_times),colour="orange",alpha=0.4)

xmin <- as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
xmax <- as.POSIXct("2015/7/7 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")

p2 <- p+xlim(xmin,xmax)
p2

vaskesbay_1d_all <- cbind(vaskesbay_1d,vaskesbay_night_1d$temperature_1d)
colnames(vaskesbay_1d_all) <- c("xi3","all_times","night_only")

p3 <- ggplot(data=vaskesbay_1d_all,aes(x=xi3))+
  geom_line(aes(y=night_only),colour="black")+
  geom_line(aes(y=all_times),colour="orange",alpha=0.4)
p3


# Sanity check: Night only example: 2016-09-15
# site 5 1hr - 50017:50022 (midnight-5am), 50037:50040 (8pm-11pm) mean = 25.2537
# site 5 1hr - 50017:50040 (all day) mean = 25.29772
# site 5 1d - 2085 value = 25.29772
# site 5 1d night - 2085 value = 25.2537 # Yay! It worked!

