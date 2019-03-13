# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/KI_SB_temp_wKim_1d.RData")
load("data/NOAA_CoralTemp_2011_2018.RData")

region.cols<-c("VaskessBay" = "#5F4690","SouthLagoon"="#1D6996",
               "MidLagoon"="#0F8554","NorthLagoon"="#EDAD08",
               "NorthShore"="#E17C05","BayofWrecks"="#CC503E")

plot_temps <- function(insitu,satellite){
  xlim1 <- as.POSIXct("2011/6/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                      tz="Pacific/Kiritimati")
  xlim2 <- as.POSIXct("2017/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                      tz="Pacific/Kiritimati")
  ggplot()+ theme_classic()+theme(legend.position = c(0.75, 0.2),
                                  legend.background=element_blank())+
    geom_line(aes(x=xi3,y=temperature_1d, color="In situ"),
              data=insitu)+
    geom_line(aes(x=date,y=sst, color="Satellite"),data=satellite)+
    scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
    scale_y_continuous(name="Temperature (ºC)")+
    NULL
}



plot_temps(bayofwrecks_1d_wKim,sst_BOW)
plot_temps(northlagoon_1d_wKim,sst_northlagoon)
plot_temps(northshore_1d_wKim,sst_northshore)
plot_temps(vaskesbay_1d_wKim,sst_vaskess)
plot_temps(southlagoon_1d_wKim,sst_southlagoon)
plot_temps(lagoonface_1d_wKim,sst_lagoonface)

BOW <- plot_temps(bayofwrecks_1d_wKim,sst_BOW)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))
NL <- plot_temps(northlagoon_1d_wKim,sst_northlagoon)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))
NS <- plot_temps(northshore_1d_wKim,sst_northshore)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))
VB <- plot_temps(vaskesbay_1d_wKim,sst_vaskess)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskes Bay")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))
SL <- plot_temps(southlagoon_1d_wKim,sst_southlagoon)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))
LF <- plot_temps(lagoonface_1d_wKim,sst_lagoonface)+guides(color=FALSE)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Lagoon Face")+
  scale_color_manual(name=NULL, values = c("turquoise","gray50"))



BOW2 <- plot_temps(bayofwrecks_1d_wKim,sst_BOW)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Bay of Wrecks")+
  scale_color_manual(name=NULL, values = c(region.cols[["BayofWrecks"]],"gray50"))
NL2 <- plot_temps(northlagoon_1d_wKim,sst_northlagoon)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Lagoon")+
  scale_color_manual(name=NULL, values = c(region.cols[["NorthLagoon"]],"gray50"))
NS2 <- plot_temps(northshore_1d_wKim,sst_northshore)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="North Shore")+
  scale_color_manual(name=NULL, values = c(region.cols[["NorthShore"]],"gray50"))
VB2 <- plot_temps(vaskesbay_1d_wKim,sst_vaskess)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Vaskes Bay")+
  scale_color_manual(name=NULL, values = c(region.cols[["VaskessBay"]],"gray50"))
SL2 <- plot_temps(southlagoon_1d_wKim,sst_southlagoon)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="South Lagoon")+
  scale_color_manual(name=NULL, values = c(region.cols[["SouthLagoon"]],"gray50"))
LF2 <- plot_temps(lagoonface_1d_wKim,sst_lagoonface)+
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=30.5, label="Lagoon Face")+
  scale_color_manual(name=NULL, values = c(region.cols[["MidLagoon"]],"gray50"))


pdf(file = "figures/KI_insitu_satellite_temps_wKim.pdf", width = 9.5, height = 9, useDingbats = FALSE)
grid.arrange(VB,SL,LF,NL,NS,BOW, layout_matrix = rbind(c(NA, 3),
                                                       c(NA, 4),
                                                       c(1, 5),
                                                       c(2, 6)))
dev.off()

pdf(file = "figures/KI_insitu_satellite_temps_v2_wKim.pdf", width = 9.5, height = 9, useDingbats = FALSE)
grid.arrange(VB2,SL2,LF2,NL2,NS2,BOW2, layout_matrix = rbind(c(NA, 3),
                                                             c(NA, 4),
                                                             c(1, 5),
                                                             c(2, 6)))
dev.off()
