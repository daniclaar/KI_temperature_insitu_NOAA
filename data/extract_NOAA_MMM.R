# Load necessary packages
library(ncdf4)
library(lattice)

sites<-read.csv('figures/ki_map_files/ki_sites_temperature.csv')

### Extract NOAA MMM by lat/lon
nc <- nc_open("data/NOAA_CoralTemp/ct5km_climatology_v3.1.nc") # Open netcdf file
lon <- ncvar_get(nc,"lon") # get longitude for reference
lat <- ncvar_get(nc,"lat") # get latitude for reference
names(nc$var) # Check the names to pick what to extract
sst_NOAA_clim_full <- ncvar_get( nc, "sst_clim_mmm") # Extract whole globe, can subset by lat/lon later
nc_close(nc) # Close the netcdf file --!!IMPORTANT!! otherwise you might corrupt your netcfd file

# I manually found the LonIdx and LatIdx based on lat and lon above - this is clunky and annoying and I'm sure there's a way to automate this.
LonIdx_NS <- 452 # Set longitude index for your site: northshore -157.425.
LatIdx_NS <- 1760 # Set latitude index for your site: northshore 2.025
LonIdx_VB <- 451 # VaskessBay -157.5
LatIdx_VB <- 1764 # VaskessBay 1.85
LonIdx_SL <- 449 # southlagoon -157.55
LatIdx_SL <- 1762 # southlagoon 1.9
LonIdx_BOW <- 454 # BayofWrecks -157.3
LatIdx_BOW <- 1764 # BayofWrecks 1.8
LonIdx_NL <- 451 # northlagoon -157.475
LatIdx_NL <- 1760 # northlagoon 2.0
LonIdx_LF <- 450 # lagoonface -157.50
LatIdx_LF <- 1760 # lagoonface 2.00

# Extract MMM for each region
MMM_BOW <- sst_NOAA_clim_full[LonIdx_BOW,LatIdx_BOW]
MMM_LF <- sst_NOAA_clim_full[LonIdx_LF,LatIdx_LF]
MMM_NL <- sst_NOAA_clim_full[LonIdx_NL,LatIdx_NL]
MMM_NS <- sst_NOAA_clim_full[LonIdx_NS,LatIdx_NS]
MMM_SL <- sst_NOAA_clim_full[LonIdx_SL,LatIdx_SL]
MMM_VB <- sst_NOAA_clim_full[LonIdx_VB,LatIdx_VB]

MMM_all <- t(data.frame("Bay of Wrecks" = MMM_BOW, "Mid Lagoon" = MMM_LF,"North Lagoon" = MMM_NL, "North Shore" = MMM_NS,"South Lagoon" = MMM_SL, "Vaskess Bay" = MMM_VB))
colnames(MMM_all) <- "MMM"

save(MMM_all,file="NOAA_MMM_byregion.RData")
