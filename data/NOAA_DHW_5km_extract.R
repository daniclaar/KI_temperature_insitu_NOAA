
# Load necessary packages
library(ncdf4)
library(chron)
library(lattice)
library(RColorBrewer)
require(svMisc)

# Clear the working environment
rm(list=ls())

latlon <- read.csv("data/region_latlons.csv")
files=list.files("data/NOAA_DHW_3.1/",full.names = TRUE)

#Testing: Need to check if this works
nc <- nc_open("data/NOAA_DHW_3.1/ct5km_dhw_v3.1_20110101.nc")
dhw_full <- ncvar_get( nc, "degree_heating_week")
# get longitude and latitude
lon <- ncvar_get(nc,"lon")
nlon <- dim(lon)
head(lon)
lat <- ncvar_get(nc,"lat")
nlat <- dim(lat)
head(lat)
nc_close(nc)

##########################################HIGH#################################

LonIdx <- 452 # Northshore -157.45
LatIdx <- 1760 # Northshore 2.025 


dhwlist <- list()
for (i in files) {
# Open the netcdf file
nc <- nc_open(i)
dhwlist[[i]] <- ncvar_get( nc, "degree_heating_week")[LonIdx, LatIdx]
# Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
nc_close(nc)
print(i)
Sys.sleep(0.01)
flush.console()
}

dhw <- do.call(rbind, dhwlist)
dhw_northshore <- data.frame(dhw)
colnames(dhw_northshore) <- c("id","dhw")

dhw_northshore$date <- rownames(dhw_northshore)
dhw_northshore$date <- gsub(x = dhw_northshore$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_northshore$date <- gsub(x = dhw_northshore$date,pattern=".nc",replacement = "")
dhw_northshore$date <- as.POSIXct(dhw_northshore$date,format="%Y%m%d")

dhw_northshore_max <- max(dhw_northshore$dhw)
dhw_northshore[which(dhw_northshore$dhw==max(dhw_northshore$dhw)),]

##################################LOW##################

LonIdx <- 451 # VaskessBay -157.5
LatIdx <- 1764 # VaskessBay 1.85

dhwlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  dhwlist[[i]] <- ncvar_get( nc, "degree_heating_week")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

dhw <- do.call(rbind, dhwlist)
dhw_vaskess <- data.frame(dhw)
colnames(dhw_vaskess) <- c("id","dhw")

dhw_vaskess$date <- rownames(dhw_vaskess)
dhw_vaskess$date <- gsub(x = dhw_vaskess$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_vaskess$date <- gsub(x = dhw_vaskess$date,pattern=".nc",replacement = "")
dhw_vaskess$date <- as.POSIXct(dhw_vaskess$date,format="%Y%m%d")

dhw_vaskess_max <- max(dhw_vaskess$dhw)
dhw_vaskess[which(dhw_vaskess$dhw==max(dhw_vaskess$dhw)),]

###############################3

LonIdx <- 449 # SouthLagoon -157.55
LatIdx <- 1762 # SouthLagoon 1.9

dhwlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  dhwlist[[i]] <- ncvar_get( nc, "degree_heating_week")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

dhw <- do.call(rbind, dhwlist)
dhw_southlagoon <- data.frame(dhw)
colnames(dhw_southlagoon) <- c("id","dhw")

dhw_southlagoon$date <- rownames(dhw_southlagoon)
dhw_southlagoon$date <- gsub(x = dhw_southlagoon$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_southlagoon$date <- gsub(x = dhw_southlagoon$date,pattern=".nc",replacement = "")
dhw_southlagoon$date <- as.POSIXct(dhw_southlagoon$date,format="%Y%m%d")

dhw_southlagoon_max <- max(dhw_southlagoon$dhw)
dhw_southlagoon[which(dhw_southlagoon$dhw==max(dhw_southlagoon$dhw)),]

######################################

LonIdx <- 454 # BayofWrecks -157.3
LatIdx <- 1764 # BayofWrecks 1.8

dhwlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  dhwlist[[i]] <- ncvar_get( nc, "degree_heating_week")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

dhw <- do.call(rbind, dhwlist)
dhw_BOW <- data.frame(dhw)
colnames(dhw_BOW) <- c("id","dhw")

dhw_BOW$date <- rownames(dhw_BOW)
dhw_BOW$date <- gsub(x = dhw_BOW$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_BOW$date <- gsub(x = dhw_BOW$date,pattern=".nc",replacement = "")
dhw_BOW$date <- as.POSIXct(dhw_BOW$date,format="%Y%m%d")

dhw_BOW_max <- max(dhw_BOW$dhw)
dhw_BOW[which(dhw_BOW$dhw==max(dhw_BOW$dhw)),]

######################################

LonIdx <- 451 # NorthLagoon -157.5
LatIdx <- 1760 # NorthLagoon 2.0

dhwlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  dhwlist[[i]] <- ncvar_get( nc, "degree_heating_week")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

dhw <- do.call(rbind, dhwlist)
dhw_northlagoon <- data.frame(dhw)
colnames(dhw_northlagoon) <- c("id","dhw")

dhw_northlagoon$date <- rownames(dhw_northlagoon)
dhw_northlagoon$date <- gsub(x = dhw_northlagoon$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_northlagoon$date <- gsub(x = dhw_northlagoon$date,pattern=".nc",replacement = "")
dhw_northlagoon$date <- as.POSIXct(dhw_northlagoon$date,format="%Y%m%d")

dhw_northlagoon_max <- max(dhw_northlagoon$dhw)
dhw_northlagoon[which(dhw_northlagoon$dhw==max(dhw_northlagoon$dhw)),]

dhw_dist <- merge(dhw_northshore,dhw_vaskess, by="date",
                  suffixes = c("_northshore","_vaskess"))
dhw_dist <- merge(dhw_dist, dhw_southlagoon, by="date")
colnames(dhw_dist)[4] <- "dhw_southlagoon"
dhw_dist <- merge(dhw_dist, dhw_northlagoon, by="date")
colnames(dhw_dist)[5] <- "dhw_northlagoon"
dhw_dist <- merge(dhw_dist, dhw_BOW, by="date")
colnames(dhw_dist)[6] <- "dhw_BOW"


save.image(file="data/NOAA_DHW_5km.RData")
