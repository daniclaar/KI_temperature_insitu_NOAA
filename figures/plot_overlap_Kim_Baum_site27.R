rm(list=ls())

library(zoo)
library(ggplot2)

load("data/KI_SB_temp_1hr.RData")
load("data/KI_SB_Kim_temp_1hr.RData")

xlim1 <- as.POSIXct("2014/9/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")
xlim2 <- as.POSIXct("2016/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")
p1 <- ggplot()+ theme_classic()+theme(legend.position = c(0.75, 0.2),
                                legend.background=element_blank())+
  geom_line(aes(x=xi2,y=temperature_1hr, color="Kim_27", alpha=0.85),
            data=K_27_1hr)+guides(alpha=FALSE)+
  geom_line(aes(x=xi2,y=temperature_1hr, color="Baum_27", alpha=0.85),data=site27_1hr)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="Temperature (ºC)",limits=c(26.5,31))+
  NULL

pdf(file = "figures/Kim_Baum_comparison_site27.pdf",width=9, height=7)
p1
dev.off()