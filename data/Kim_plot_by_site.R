rm(list=ls())

library(ggplot2)
library(gridExtra)

load("data/KI_SB_Kim_temp_1hr.RData")

plot_temp <- function(site){
  xlim1 <- as.POSIXct("2014/8/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                      tz="Pacific/Kiritimati")
  xlim2 <- as.POSIXct("2017/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                      tz="Pacific/Kiritimati")
  ggplot()+ theme_classic()+theme(legend.position = c(0.75, 0.2))+
    geom_line(aes(x=xi2,y=temperature_1hr),
              data=site)+
    scale_x_datetime(name="Date", expand=c(0,0), limits=c(xlim1,xlim2))+
    scale_y_continuous(name="Temperature (?C)",limits=c(24,32))+
    NULL
}

BOW <- plot_temp(BOW_K_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="Bay of Wrecks")
CTD <- plot_temp(CTD_K_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="CTD Site")
DS <- plot_temp(DS_K_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="Drill Site")
K22 <- plot_temp(K_22_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="Site 22 (Kim)")
K33 <- plot_temp(K_33_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="Site 33 (Kim)")
K5 <- plot_temp(site_5_1hr)+
  annotate("text",x=as.POSIXct("2015/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),
           y=31, label="Site 5 (BaumLab)")

jpeg(filename = "figures/Kim_plot_by_site.jpg", width=8, height=8, units="in",res=300)
grid.arrange(BOW,CTD,DS,K22,K33,K5)
dev.off()

