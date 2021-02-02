
# Load necessary packages
library(ncdf4)
library(chron)
library(lattice)
library(RColorBrewer)
require(svMisc)

# Clear the working environment
rm(list=ls())

files=list.files("data/NOAA_DHW_3.1/",full.names = TRUE)

#Testing: Need to check if this works
nc <- nc_open("../KI_temperature_insitu_NOAA/data/NOAA_DHW_3.1/ct5km_dhw_v3.1_19850327.nc")
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

dhw_northlagoon$date <- rownames(dhw_northlagoon)
dhw_northlagoon$date <- gsub(x = dhw_northlagoon$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_northlagoon$date <- gsub(x = dhw_northlagoon$date,pattern=".nc",replacement = "")
dhw_northlagoon$date <- as.POSIXct(dhw_northlagoon$date,format="%Y%m%d")

dhw_northlagoon_max <- max(dhw_northlagoon$dhw)
dhw_northlagoon[which(dhw_northlagoon$dhw==max(dhw_northlagoon$dhw)),]

######################################

LonIdx <- 450 # Lagoon Face -157.50
LatIdx <- 1760 # Lagoon Face 2.00

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
dhw_lagoonface <- data.frame(dhw)

dhw_lagoonface$date <- rownames(dhw_lagoonface)
dhw_lagoonface$date <- gsub(x = dhw_lagoonface$date,pattern="data/NOAA_DHW_3.1/ct5km_dhw_v3.1_",replacement = "")
dhw_lagoonface$date <- gsub(x = dhw_lagoonface$date,pattern=".nc",replacement = "")
dhw_lagoonface$date <- as.POSIXct(dhw_lagoonface$date,format="%Y%m%d")

dhw_lagoonface_max <- max(dhw_lagoonface$dhw)
dhw_lagoonface[which(dhw_lagoonface$dhw==max(dhw_lagoonface$dhw)),]

##############
dhw_region <- merge(dhw_northshore,dhw_vaskess, by="date",
                  suffixes = c("_northshore","_vaskess"))
dhw_region <- merge(dhw_region, dhw_southlagoon, by="date")
colnames(dhw_region)[4] <- "dhw_southlagoon"
dhw_region <- merge(dhw_region, dhw_northlagoon, by="date")
colnames(dhw_region)[5] <- "dhw_northlagoon"
dhw_region <- merge(dhw_region, dhw_BOW, by="date")
colnames(dhw_region)[6] <- "dhw_BOW"
dhw_region <- merge(dhw_region, dhw_lagoonface, by="date")
colnames(dhw_region)[6] <- "dhw_lagoonface"

# Remove unneccessary objects
rm(dhw,dhw_full,nc,dhwlist,nc,i,lat,lon,LatIdx,LonIdx,nlat,nlon)

# Take the mean of all 5 regions 
dhw_mean_KI <- data.frame("date"=dhw_region$date, "dhw"=rowMeans(dhw_region[,c(2:6)]))

#Save RData file for downstream use
save.image(file="data/NOAA_DHW_5km.RData")
