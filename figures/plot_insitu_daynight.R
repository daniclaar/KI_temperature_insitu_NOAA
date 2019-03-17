# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)
library(gridExtra)
library(scales)

# Load necessary data
load("data/KI_SB_temp_wKim_1d.RData")

region.cols<-c("VaskessBay" = "#5F4690","SouthLagoon"="#1D6996",
               "MidLagoon"="#0F8554","NorthLagoon"="#EDAD08",
               "NorthShore"="#E17C05","BayofWrecks"="#CC503E",
               "VaskessBay_night" = "#130044","SouthLagoon_night"="#000330",
               "MidLagoon_night"="#001F00","NorthLagoon_night"="#874700",
               "NorthShore_night"="#2F0000","BayofWrecks_night"="#330000")

NonNAindex <- which(!is.na(vaskesbay_1d_wKim$temperature_1d))
firstNonNA <- min(NonNAindex)
firstNonNA
lastNonNA <- max(NonNAindex)
lastNonNA

bayofwrecks_1d_wKim <- bayofwrecks_1d_wKim[c(233:nrow(bayofwrecks_1d_wKim)),]
bayofwrecks_night_wKim_1d <- bayofwrecks_night_wKim_1d[c(233:nrow(bayofwrecks_night_wKim_1d)),]
northlagoon_1d_wKim <- northlagoon_1d_wKim[c(233:nrow(northlagoon_1d_wKim)),]
northlagoon_night_wKim_1d <- northlagoon_night_wKim_1d[c(233:nrow(northlagoon_night_wKim_1d)),]
northshore_1d_wKim <- northshore_1d_wKim[c(233:nrow(northshore_1d_wKim)),]
northshore_night_wKim_1d <- northshore_night_wKim_1d[c(233:nrow(northshore_night_wKim_1d)),]
vaskesbay_1d_wKim <- vaskesbay_1d_wKim[c(233:nrow(vaskesbay_1d_wKim)),]
vaskesbay_night_wKim_1d <- vaskesbay_night_wKim_1d[c(233:nrow(vaskesbay_night_wKim_1d)),]
southlagoon_1d_wKim <- southlagoon_1d_wKim[c(233:nrow(southlagoon_1d_wKim)),]
southlagoon_night_wKim_1d <- southlagoon_night_wKim_1d[c(233:nrow(southlagoon_night_wKim_1d)),]
lagoonface_1d_wKim <- lagoonface_1d_wKim[c(233:nrow(lagoonface_1d_wKim)),]
lagoonface_night_wKim_1d <- lagoonface_night_wKim_1d[c(233:nrow(lagoonface_night_wKim_1d)),]


plot_temps_daynight <- function(day,night){
  ggplot()+ theme_classic()+theme(legend.position = c(0.88, 0.2))+
    geom_line(aes(x=xi3,y=temperature_1d, color="Day+Night"),
              data=day)+
    geom_line(aes(x=xi3,y=temperature_1d, color="Night-only"),data=night,alpha=0.5)+
    scale_color_manual(name=NULL, values = c("gray70","black"))+
    scale_x_datetime(name="Date", expand=c(0,0))+
    scale_y_continuous(name="Temperature (°C)",limits = c(24,31))+
    NULL
}

plot_temps_daynight(bayofwrecks_1d_wKim,bayofwrecks_night_wKim_1d)
plot_temps_daynight(northlagoon_1d_wKim,northlagoon_night_wKim_1d)
plot_temps_daynight(northshore_1d_wKim,northshore_night_wKim_1d)
plot_temps_daynight(vaskesbay_1d_wKim,vaskesbay_night_wKim_1d)
plot_temps_daynight(southlagoon_1d_wKim,southlagoon_night_wKim_1d)
plot_temps_daynight(lagoonface_1d_wKim,lagoonface_night_wKim_1d)

BOW <- plot_temps_daynight(bayofwrecks_1d_wKim,bayofwrecks_night_wKim_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")
NL <- plot_temps_daynight(northlagoon_1d_wKim,northlagoon_night_wKim_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")
NS <- plot_temps_daynight(northshore_1d_wKim,northshore_night_wKim_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")
VB <- plot_temps_daynight(vaskesbay_1d_wKim,vaskesbay_night_wKim_1d)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskess Bay")
SL <- plot_temps_daynight(southlagoon_1d_wKim,southlagoon_night_wKim_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")
LF <- plot_temps_daynight(lagoonface_1d_wKim,lagoonface_night_wKim_1d)+
  guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2016/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")


pdf(file = "figures/KI_insitu_daynight_temps.pdf", width = 7.5, height = 10, useDingbats = FALSE)
grid.arrange(VB,SL,LF,NL,NS,BOW, nrow=3, ncol=2)
dev.off()

####

bayofwrecks_1d_wKim_sub <- bayofwrecks_1d_wKim[c(1360:1420),]
bayofwrecks_night_wKim_1d_sub <- bayofwrecks_night_wKim_1d[c(1360:1420),]
northlagoon_1d_wKim_sub <- northlagoon_1d_wKim[c(1360:1420),]
northlagoon_night_wKim_1d_sub <- northlagoon_night_wKim_1d[c(1360:1420),]
northshore_1d_wKim_sub <- northshore_1d_wKim[c(1360:1420),]
northshore_night_wKim_1d_sub <- northshore_night_wKim_1d[c(1360:1420),]
vaskesbay_1d_wKim_sub <- vaskesbay_1d_wKim[c(1360:1420),]
vaskesbay_night_wKim_1d_sub <- vaskesbay_night_wKim_1d[c(1360:1420),]
southlagoon_1d_wKim_sub <- southlagoon_1d_wKim[c(1360:1420),]
southlagoon_night_wKim_1d_sub <- southlagoon_night_wKim_1d[c(1360:1420),]
lagoonface_1d_wKim_sub <- lagoonface_1d_wKim[c(1360:1420),]
lagoonface_night_wKim_1d_sub <- lagoonface_night_wKim_1d[c(1360:1420),]

BOW_sub <- plot_temps_daynight(bayofwrecks_1d_wKim_sub,bayofwrecks_night_wKim_1d_sub)+
  # guides(color=FALSE)+    
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
  annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="Bay of Wrecks")+
  scale_color_manual(name=NULL, values = c(region.cols[["BayofWrecks"]],region.cols[["BayofWrecks_night"]]))+    
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))

NL_sub <- plot_temps_daynight(northlagoon_1d_wKim_sub,northlagoon_night_wKim_1d_sub)+
  # guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
  annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="North Lagoon")+
  scale_color_manual(name=NULL, values = c(region.cols[["NorthLagoon"]],region.cols[["NorthLagoon_night"]]))+
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))


NS_sub <- plot_temps_daynight(northshore_1d_wKim_sub,northshore_night_wKim_1d_sub)+
  # guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
  annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="North Shore")+
  scale_color_manual(name=NULL, values = c(region.cols[["NorthShore"]],region.cols[["NorthShore_night"]]))+
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))


VB_sub <- plot_temps_daynight(vaskesbay_1d_wKim_sub,vaskesbay_night_wKim_1d_sub)+
  annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="Vaskess Bay")+
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
  scale_color_manual(name=NULL, values = c(region.cols[["VaskessBay"]],region.cols[["VaskessBay_night"]]))+
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))


  
SL_sub <- plot_temps_daynight(southlagoon_1d_wKim_sub,southlagoon_night_wKim_1d_sub)+
  # guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="South Lagoon")+
  scale_color_manual(name=NULL, values = c(region.cols[["SouthLagoon"]],region.cols[["SouthLagoon_night"]]))+
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))


LF_sub <- plot_temps_daynight(lagoonface_1d_wKim_sub,lagoonface_night_wKim_1d_sub)+
  # guides(color=FALSE)+
  scale_y_continuous(name="Temperature (°C)",limits = c(28.3,30),expand=c(0,0))+
  annotate("text",x=as.POSIXct("2015/5/19 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=29.75, label="Mid Lagoon")+
  scale_color_manual(name=NULL, values = c(region.cols[["MidLagoon"]],region.cols[["MidLagoon_night"]]))+
  scale_x_datetime(name="Date", expand=c(0,0),breaks=date_breaks("1 month"),
                   labels=date_format('%b %Y'))


pdf(file = "figures/KI_insitu_daynight_temps_subset.pdf", width = 12, height = 8, useDingbats = FALSE)
grid.arrange(VB_sub,SL_sub,LF_sub,NL_sub,NS_sub,BOW_sub, nrow=3, ncol=2)
dev.off()

jpeg(filename = "figures/KI_insitu_daynight_temps_subset.jpg", width = 12, height = 8, units="in",res = 300)
grid.arrange(VB_sub,SL_sub,LF_sub,NL_sub,NS_sub,BOW_sub, nrow=3, ncol=2)
dev.off()

