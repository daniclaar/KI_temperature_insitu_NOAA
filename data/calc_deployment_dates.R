rm(list=ls())

# Load necessary data
load("data/KI_SB_temp_1hr.RData")

sites <- ls(pattern="site*")

NonNAindex <- which(!is.na(site19_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site19_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site19_1hr[c(lastNonNA),]

NAindex <- which(is.na(site19_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site19_1hr[c(36969),]
site19_1hr[c(37993),]
### 

NonNAindex <- which(!is.na(site27_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site27_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site27_1hr[c(lastNonNA),]

plot(site27_1hr)

NAindex <- which(is.na(site27_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site27_1hr[c(22705),]
site27_1hr[c(32184),]
###


NonNAindex <- which(!is.na(site30_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site30_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site30_1hr[c(lastNonNA),]

plot(site30_1hr)

NAindex <- which(is.na(site30_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site30_1hr[c(37945),]
site30_1hr[c(39889),]

###
NonNAindex <- which(!is.na(site34_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site34_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site34_1hr[c(lastNonNA),]

plot(site34_1hr)

NAindex <- which(is.na(site34_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site34_1hr[c(22729),]
site34_1hr[c(38184),]

###
NonNAindex <- which(!is.na(site35_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site35_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site35_1hr[c(lastNonNA),]

plot(site35_1hr)

NAindex <- which(is.na(site35_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site35_1hr[c(22393),]
site35_1hr[c(32280),]
site35_1hr[c(38016),]
site35_1hr[c(39864),]

###
NonNAindex <- which(!is.na(site5_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site5_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site5_1hr[c(lastNonNA),]

plot(site5_1hr)

NAindex <- which(is.na(site5_1hr$temperature_1hr))
NAindex[c(firstNonNA:lastNonNA)]
site5_1hr[c(39673),]
site5_1hr[c(42552),]

###
NonNAindex <- which(!is.na(site9_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
site9_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
site9_1hr[c(lastNonNA),]

plot(site9_1hr)


###
NonNAindex <- which(!is.na(lagoonface_1hr$temperature_1hr))
firstNonNA <- min(NonNAindex)
firstNonNA
lagoonface_1hr[c(firstNonNA),]

lastNonNA <- max(NonNAindex)
lastNonNA
lagoonface_1hr[c(lastNonNA),]
