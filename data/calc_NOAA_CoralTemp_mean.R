# Calculate the mean in situ SST across regions

# Clear working environment
rm(list=ls())

# Load necessary data
load("figures/Figure_1/KI_SB_temp_wKim_1d.RData")

# View data
insitu_regions <- cbind(bayofwrecks_1d_wKim,lagoonface_1d_wKim[2],
                       northlagoon_1d_wKim[2],northshore_1d_wKim[2],
                       southlagoon_1d_wKim[2],vaskesbay_1d_wKim[2])
insitu_mean <- rowMeans(insitu_regions[2:7],na.rm = TRUE)

insitu_mean <-cbind(insitu_regions[1],insitu_mean)
plot(insitu_mean)

save(insitu_mean,file = "figures/Figure_1/KI_SB_temp_wKim_1d_mean.RData")
