# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)

# Load necessary data
load("data/KI_insitu_temperature.RData")
load("data/NOAA_CoralTemp_2011_2018.RData")

ggplot()+
  geom_line(aes(x=xi2,y=temperature_1hr),data=bayofwrecks_1hr_insitu)+
  NULL
