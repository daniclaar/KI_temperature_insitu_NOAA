# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/KI_SB_temp_1d.RData")

NonNAindex <- which(!is.na(vaskesbay_1d$temperature_1d))
firstNonNA <- min(NonNAindex)
firstNonNA
lastNonNA <- max(NonNAindex)
lastNonNA

bayofwrecks_1d <- bayofwrecks_1d[c(233:nrow(bayofwrecks_1d)),]
bayofwrecks_night_1d <- bayofwrecks_night_1d[c(233:nrow(bayofwrecks_night_1d)),]
northlagoon_1d <- northlagoon_1d[c(233:nrow(northlagoon_1d)),]
northlagoon_night_1d <- northlagoon_night_1d[c(233:nrow(northlagoon_night_1d)),]
northshore_1d <- northshore_1d[c(233:nrow(northshore_1d)),]
northshore_night_1d <- northshore_night_1d[c(233:nrow(northshore_night_1d)),]
vaskesbay_1d <- vaskesbay_1d[c(233:nrow(vaskesbay_1d)),]
vaskesbay_night_1d <- vaskesbay_night_1d[c(233:nrow(vaskesbay_night_1d)),]
southlagoon_1d <- southlagoon_1d[c(233:nrow(southlagoon_1d)),]
southlagoon_night_1d <- southlagoon_night_1d[c(233:nrow(southlagoon_night_1d)),]


plot_temps_daynight <- function(day,night){
  ggplot()+ theme_classic()+theme(legend.position = c(0.08, 0.87))+
    geom_line(aes(x=xi3,y=temperature_1d, color="Day+Night"),
              data=day)+
    geom_line(aes(x=xi3,y=temperature_1d, color="Night-only"),data=night,alpha=0.5)+
    scale_color_manual(name=NULL, values = c("goldenrod","gray20"))+
    scale_x_datetime(name="Date", expand=c(0,0))+
    scale_y_continuous(name="Temperature (°C)",limits = c(24,31))+
    NULL
}

plot_temps_daynight(bayofwrecks_1d,bayofwrecks_night_1d)
plot_temps_daynight(northlagoon_1d,northlagoon_night_1d)
plot_temps_daynight(northshore_1d,northshore_night_1d)
plot_temps_daynight(vaskesbay_1d,vaskesbay_night_1d)
plot_temps_daynight(southlagoon_1d,southlagoon_night_1d)

BOW <- plot_temps_daynight(bayofwrecks_1d,bayofwrecks_night_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")
NL <- plot_temps_daynight(northlagoon_1d,northlagoon_night_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")
NS <- plot_temps_daynight(northshore_1d,northshore_night_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")
VB <- plot_temps_daynight(vaskesbay_1d,vaskesbay_night_1d)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskess Bay")
SL <- plot_temps_daynight(southlagoon_1d,southlagoon_night_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")

pdf(file = "figures/KI_insitu_daynight_temps.pdf", width = 7.5, height = 10, useDingbats = FALSE)
grid.arrange(VB,SL,NL,NS,BOW, nrow=5)
dev.off()

####

bayofwrecks_1d_sub <- bayofwrecks_1d[c(1360:1420),]
bayofwrecks_night_1d_sub <- bayofwrecks_night_1d[c(1360:1420),]
northlagoon_1d_sub <- northlagoon_1d[c(1360:1420),]
northlagoon_night_1d_sub <- northlagoon_night_1d[c(1360:1420),]
northshore_1d_sub <- northshore_1d[c(1360:1420),]
northshore_night_1d_sub <- northshore_night_1d[c(1360:1420),]
vaskesbay_1d_sub <- vaskesbay_1d[c(1360:1420),]
vaskesbay_night_1d_sub <- vaskesbay_night_1d[c(1360:1420),]
southlagoon_1d_sub <- southlagoon_1d[c(1360:1420),]
southlagoon_night_1d_sub <- southlagoon_night_1d[c(1360:1420),]

BOW_sub <- plot_temps_daynight(bayofwrecks_1d_sub,bayofwrecks_night_1d_sub)+
  guides(color=FALSE)+    
  scale_y_continuous(name="Temperature (°C)",limits = c(28,30))+
  annotate("text",x=as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")
NL_sub <- plot_temps_daynight(northlagoon_1d_sub,northlagoon_night_1d_sub)+
  guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28,30))+
  annotate("text",x=as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")
NS_sub <- plot_temps_daynight(northshore_1d_sub,northshore_night_1d_sub)+
  guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28,30))+
  annotate("text",x=as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")
VB_sub <- plot_temps_daynight(vaskesbay_1d_sub,vaskesbay_night_1d_sub)+
  annotate("text",x=as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskess Bay")+
  scale_y_continuous(name="Temperature (°C)",limits = c(28,30))
  
SL_sub <- plot_temps_daynight(southlagoon_1d_sub,southlagoon_night_1d_sub)+
  guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28,30))+
annotate("text",x=as.POSIXct("2015/7/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")

pdf(file = "figures/KI_insitu_daynight_temps_subset.pdf", width = 7.5, height = 10, useDingbats = FALSE)
grid.arrange(VB_sub,SL_sub,NL_sub,NS_sub,BOW_sub, nrow=5)
dev.off()

