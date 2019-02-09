
# Load necessary packages
library(ncdf4)
# library(chron)
library(lattice)
library(RColorBrewer)
# require(svMisc)

# Clear the working environment
rm(list=ls())

latlon <- read.csv("data/region_latlons.csv")
files=list.files("data/NOAA_CoralTemp/",full.names = TRUE)

#The NOAA Coral Reef Watch (CRW) daily global 5km Sea Surface Temperature (SST) product shows the nighttime ocean temperature (at the surface) measured by CRW's CoralTemp Sea Surface Temperature Version 1.0 product. The SST scale ranges from -2 to 35 °C. This product is updated each afternoon at about 13:30 U.S. Eastern Time.
#https://coralreefwatch.noaa.gov/satellite/coraltemp.php

# Test on one file to make sure it works:
# nc <- nc_open("data/NOAA_CoralTemp/coraltemp_v1.0_20110101.nc")
# sst_full <- ncvar_get( nc, "analysed_sst")
# # get longitude and latitude
# lon <- ncvar_get(nc,"lon")
# nlon <- dim(lon)
# head(lon)
# lat <- ncvar_get(nc,"lat")
# nlat <- dim(lat)
# head(lat)
# nc_close(nc)

# Extract data for Northshore (-157.425, 2.025)
LonIdx <- 452 # northshore -157.425
LatIdx <- 1760 # northshore 2.025 

sstlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  sstlist[[i]] <- ncvar_get( nc, "analysed_sst")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

sst <- do.call(rbind, sstlist)
sst_northshore <- data.frame(sst)
# colnames(sst_northshore) <- c("id","sst")

sst_northshore$date <- rownames(sst_northshore)
sst_northshore$date <- gsub(x = sst_northshore$date,pattern="data/NOAA_CoralTemp/coraltemp_v1.0_",replacement = "")
sst_northshore$date <- gsub(x = sst_northshore$date,pattern=".nc",replacement = "")
sst_northshore$date <- as.POSIXct(sst_northshore$date,format="%Y%m%d")

# Extract data for Vaskess Bay (-157.5, 1.85)
LonIdx <- 451 # VaskessBay -157.5
LatIdx <- 1764 # VaskessBay 1.85

sstlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  sstlist[[i]] <- ncvar_get( nc, "analysed_sst")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

sst <- do.call(rbind, sstlist)
sst_vaskess <- data.frame(sst)
# colnames(sst_vaskess) <- c("id","sst")

sst_vaskess$date <- rownames(sst_vaskess)
sst_vaskess$date <- gsub(x = sst_vaskess$date,pattern="data/NOAA_CoralTemp/coraltemp_v1.0_",replacement = "")
sst_vaskess$date <- gsub(x = sst_vaskess$date,pattern=".nc",replacement = "")
sst_vaskess$date <- as.POSIXct(sst_vaskess$date,format="%Y%m%d")

# Extract data for Southlagoon (-157.55, 1.9)
LonIdx <- 449 # southlagoon -157.55
LatIdx <- 1762 # southlagoon 1.9

sstlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  sstlist[[i]] <- ncvar_get( nc, "analysed_sst")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

sst <- do.call(rbind, sstlist)
sst_southlagoon <- data.frame(sst)
# colnames(sst_southlagoon) <- c("id","sst")

sst_southlagoon$date <- rownames(sst_southlagoon)
sst_southlagoon$date <- gsub(x = sst_southlagoon$date,pattern="data/NOAA_CoralTemp/coraltemp_v1.0_",replacement = "")
sst_southlagoon$date <- gsub(x = sst_southlagoon$date,pattern=".nc",replacement = "")
sst_southlagoon$date <- as.POSIXct(sst_southlagoon$date,format="%Y%m%d")

# Extract data for BayofWrecks (-157.3, 1.8)
LonIdx <- 454 # BayofWrecks -157.3
LatIdx <- 1764 # BayofWrecks 1.8

sstlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  sstlist[[i]] <- ncvar_get( nc, "analysed_sst")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

sst <- do.call(rbind, sstlist)
sst_BOW <- data.frame(sst)
# colnames(sst_BOW) <- c("id","sst")

sst_BOW$date <- rownames(sst_BOW)
sst_BOW$date <- gsub(x = sst_BOW$date,pattern="data/NOAA_CoralTemp/coraltemp_v1.0_",replacement = "")
sst_BOW$date <- gsub(x = sst_BOW$date,pattern=".nc",replacement = "")
sst_BOW$date <- as.POSIXct(sst_BOW$date,format="%Y%m%d")

# Extract data for Northlagoon (-157.5, 2.0)
LonIdx <- 451 # northlagoon -157.5
LatIdx <- 1760 # northlagoon 2.0

sstlist <- list()
for (i in files) {
  # Open the netcdf file
  nc <- nc_open(i)
  sstlist[[i]] <- ncvar_get( nc, "analysed_sst")[LonIdx, LatIdx]
  # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file
  nc_close(nc)
  print(i)
  Sys.sleep(0.01)
  flush.console()
}

sst <- do.call(rbind, sstlist)
sst_northlagoon <- data.frame(sst)
# colnames(sst_northlagoon) <- c("id","sst")

sst_northlagoon$date <- rownames(sst_northlagoon)
sst_northlagoon$date <- gsub(x = sst_northlagoon$date,pattern="data/NOAA_CoralTemp/coraltemp_v1.0_",replacement = "")
sst_northlagoon$date <- gsub(x = sst_northlagoon$date,pattern=".nc",replacement = "")
sst_northlagoon$date <- as.POSIXct(sst_northlagoon$date,format="%Y%m%d")

#########################
# Merge regions together into one object
sst_region <- merge(sst_BOW,sst_northlagoon, by="date",suffixes = c("_BOW","_northlagoon"))
sst_region <- merge(sst_region, sst_southlagoon, by="date")
colnames(sst_region)[4] <- "sst_southlagoon"
sst_region <- merge(sst_region, sst_vaskess, by="date")
colnames(sst_region)[5] <- "sst_vaskess"
sst_region <- merge(sst_region, sst_northshore, by="date")
colnames(sst_region)[6] <- "sst_northshore"


save(list = c("sst_region","sst_northlagoon","sst_BOW","sst_southlagoon",
              "sst_vaskess","sst_northshore"), 
     file="data/NOAA_CoralTemp_2011_2018.RData")
