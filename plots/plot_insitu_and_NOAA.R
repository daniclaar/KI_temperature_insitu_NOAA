# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)

# Load necessary data
load("data/KI_insitu_temperature.RData")
load("data/NOAA_CoralTemp_2011_2018.RData")

plot_temps <- function(insitu,satellite){
ggplot()+ theme_classic()+theme(legend.position = c(0.125, 0.85))+
  geom_line(aes(x=xi2,y=temperature_1hr, color="In situ"),
            data=insitu)+
  geom_line(aes(x=date,y=sst, color="Satellite"),data=satellite)+
  scale_color_manual(name="Data Source", values = c("darkgray","turquoise"))+
    xlab("Date")+
    scale_y_continuous(name="Temperature (°C)")+
  NULL
}

plot_temps(bayofwrecks_1hr_insitu,sst_BOW)
plot_temps(northlagoon_1hr_insitu,sst_northlagoon)
plot_temps(northshore_1hr_insitu,sst_northshore)
plot_temps(vaskesbay_1hr_insitu,sst_vaskess)
plot_temps(southlagoon_1hr_insitu,sst_southlagoon)
