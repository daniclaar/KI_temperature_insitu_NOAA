# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/KI_SB_temp_1d.RData")
load("data/NOAA_CoralTemp_2011_2018.RData")

plot_temps <- function(insitu,satellite){
ggplot()+ theme_classic()+theme(legend.position = c(0.075, 0.87))+
  geom_line(aes(x=xi3,y=temperature_1d, color="In situ"),
            data=insitu)+
  geom_line(aes(x=date,y=sst, color="Satellite"),data=satellite)+
  scale_color_manual(name=NULL, values = c("gray50","turquoise"))+
  scale_x_datetime(name="Date", expand=c(0,0))+
  scale_y_continuous(name="Temperature (°C)")+
  NULL
}

plot_temps(bayofwrecks_1d,sst_BOW)
plot_temps(northlagoon_1d,sst_northlagoon)
plot_temps(northshore_1d,sst_northshore)
plot_temps(vaskesbay_1d,sst_vaskess)
plot_temps(southlagoon_1d,sst_southlagoon)

BOW <- plot_temps(bayofwrecks_1d,sst_BOW)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2018/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")
NL <- plot_temps(northlagoon_1d,sst_northlagoon)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2018/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")
NS <- plot_temps(northshore_1d,sst_northshore)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2018/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")
VB <- plot_temps(vaskesbay_1d,sst_vaskess)+
  annotate("text",x=as.POSIXct("2018/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskess Bay")
SL <- plot_temps(southlagoon_1d,sst_southlagoon)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2018/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")

pdf(file = "figures/KI_insitu_satellite_temps.pdf", width = 7.5, height = 10, useDingbats = FALSE)
grid.arrange(VB,SL,NL,NS,BOW, nrow=5)
dev.off()
