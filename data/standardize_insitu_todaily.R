# Load necessary libraries
library(iemisc)

# Load necessary data
load("data/KI_SB_temp_1hr.RData")


# Need to standardize in situ temperature to daily data
# Should do this for nighttime-only, and for all data together

# The first date that we want to interpolate from 
startDate <- as.POSIXct("2011/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
# The last date that we want to interpolate to
endDate <- as.POSIXct("2016/12/31 23:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")

xi3 <- (seq(from=startDate, to= endDate, by=86400)) # by=24 means interpolate by daily intervals

# Create a list regions for reference later
regions=c("southlagoon","northlagoon","lagoonface","northshore","bayofwrecks","vaskesbay")
# Create a list of sites for reference later
sitelist <- c("site3","site5","site8","site8.5","site9","site15","site19","site25","site27","site30","site32","site33","site34","site35","site40")

## Now do the actual interpolation
## Use DateTime to interpolate Temperature over xi. Don't remove NA values. The maximum gap (sequence of NAs) to interpolate over is 3 hours
# List all loggers for use in loop
logger <- grep("site",ls(),value=TRUE)
logger <- logger[!(logger %in% "sitelist")]

site8_interp <- na.interp1(site8_1hr$xi2, site8_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site34_interp <- na.interp1(site34_1hr$xi2, site34_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site35_interp <- na.interp1(site35_1hr$xi2, site35_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site27_interp <- na.interp1(site27_1hr$xi2, site27_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site30_interp <- na.interp1(site30_1hr$xi2, site30_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site9_interp <- na.interp1(site9_1hr$xi2, site9_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site32_interp <- na.interp1(site32_1hr$xi2, site32_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site33_interp <- na.interp1(site33_1hr$xi2, site33_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site40_interp <- na.interp1(site40_1hr$xi2, site40_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site25_interp <- na.interp1(site25_1hr$xi2, site25_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site3_interp <- na.interp1(site3_1hr$xi2, site3_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site15_interp <- na.interp1(site15_1hr$xi2, site15_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site19_interp <- na.interp1(site19_1hr$xi2, site19_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site5_interp <- na.interp1(site5_1hr$xi2, site5_1hr$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)


## Now, create object for daily intervals
# Bind together the time vector (xi) and the temperature
site8_1d<-cbind.data.frame(xi3,site8_interp)
site34_1d<-cbind.data.frame(xi3,site34_interp)
site35_1d<-cbind.data.frame(xi3,site35_interp)
site27_1d<-cbind.data.frame(xi3,site27_interp)
site30_1d<-cbind.data.frame(xi3,site30_interp)
site9_1d<-cbind.data.frame(xi3,site9_interp)
site32_1d<-cbind.data.frame(xi3,site32_interp)
site33_1d<-cbind.data.frame(xi3,site33_interp)
site40_1d<-cbind.data.frame(xi3,site40_interp)
site25_1d<-cbind.data.frame(xi3,site25_interp)
site3_1d<-cbind.data.frame(xi3,site3_interp)
site15_1d<-cbind.data.frame(xi3,site15_interp)
site19_1d<-cbind.data.frame(xi3,site19_interp)
site5_1d<-cbind.data.frame(xi3,site5_interp)

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


# Save daily temperature data
save(site3_1d,site5_1d,site8_1d,site9_1d,site15_1d,site19_1d,site25_1d,site27_1d,site30_1d,site32_1d,site33_1d,site34_1d,site35_1d,site40_1d,southlagoon_1d,northlagoon_1d,lagoonface_1d,northshore_1d,bayofwrecks_1d,vaskesbay_1d,KI_allsites_1d,file="data/KI_SB_temp_1d.RData")

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
site5_1hr_night[c(50013:50045),]

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

site8_night_interp <- na.interp1(site8_1hr_night$xi2, site8_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site34_night_interp <- na.interp1(site34_1hr_night$xi2, site34_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site35_night_interp <- na.interp1(site35_1hr_night$xi2, site35_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site27_night_interp <- na.interp1(site27_1hr_night$xi2, site27_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site30_night_interp <- na.interp1(site30_1hr_night$xi2, site30_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site9_night_interp <- na.interp1(site9_1hr_night$xi2, site9_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site32_night_interp <- na.interp1(site32_1hr_night$xi2, site32_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site33_night_interp <- na.interp1(site33_1hr_night$xi2, site33_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site40_night_interp <- na.interp1(site40_1hr_night$xi2, site40_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site25_night_interp <- na.interp1(site25_1hr_night$xi2, site25_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site3_night_interp <- na.interp1(site3_1hr_night$xi2, site3_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site15_night_interp <- na.interp1(site15_1hr_night$xi2, site15_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site19_night_interp <- na.interp1(site19_1hr_night$xi2, site19_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)
site5_night_interp <- na.interp1(site5_1hr_night$xi2, site5_1hr_night$temperature_1hr, xi3, na.rm=FALSE, maxgap=3)


## Now, create object for daily intervals
# Bind together the time vector (xi) and the temperature
site8_night_1d<-cbind.data.frame(xi3,site8_night_interp)
site34_night_1d<-cbind.data.frame(xi3,site34_night_interp)
site35_night_1d<-cbind.data.frame(xi3,site35_night_interp)
site27_night_1d<-cbind.data.frame(xi3,site27_night_interp)
site30_night_1d<-cbind.data.frame(xi3,site30_night_interp)
site9_night_1d<-cbind.data.frame(xi3,site9_night_interp)
site32_night_1d<-cbind.data.frame(xi3,site32_night_interp)
site33_night_1d<-cbind.data.frame(xi3,site33_night_interp)
site40_night_1d<-cbind.data.frame(xi3,site40_night_interp)
site25_night_1d<-cbind.data.frame(xi3,site25_night_interp)
site3_night_1d<-cbind.data.frame(xi3,site3_night_interp)
site15_night_1d<-cbind.data.frame(xi3,site15_night_interp)
site19_night_1d<-cbind.data.frame(xi3,site19_night_interp)
site5_night_1d<-cbind.data.frame(xi3,site5_night_interp)

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


KI_allsites_1d_night_all <- cbind(KI_allsites_1d,KI_allsites_night_1d$temperature_1d)
colnames(KI_allsites_1d_night_all) <- c("xi3","all_times","night_only")

p <- ggplot(data=KI_allsites_1d_night_all,aes(x=xi3))+
  geom_line(aes(y=night_only),colour="black")+
  geom_line(aes(y=all_times),colour="orange",alpha=0.4)

xmin <- as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")
xmax <- as.POSIXct("2015/7/2 00:00:00",format="%Y/%m/%d %H:%M:%S",tz="Pacific/Kiritimati")

p2 <- p+xlim(xmin,xmax)

# Suspicious because all times and night time look exactly the same. Bug?

vaskesbay_1d_all <- cbind(vaskesbay_1d,vaskesbay_night_1d$temperature_1d)
colnames(vaskesbay_1d_all) <- c("xi3","all_times","night_only")

p <- ggplot(data=vaskesbay_1d_all,aes(x=xi3))+
  geom_line(aes(y=night_only),colour="black")+
  geom_line(aes(y=all_times),colour="orange",alpha=0.4)
p
p2

# Night only example: 2016-09-15
# site 5 1hr - 50017:50022 (midnight-5am), 50037:50040 (8pm-11pm) mean = 25.2537
# site 5 1hr - 50017:50040 (all day) mean = 25.29772
# site 5 1d - 2085 value = 25.21282

# Sooooooooo wtf