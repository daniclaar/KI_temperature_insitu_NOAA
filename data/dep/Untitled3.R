rm(list=ls())

library(ggplot2)
library(gridExtra)

load("data/DHW_all.RData")
load("data/NOAA_DHW_5km.RData")

region.cols<-c("VaskessBay" = "#5F4690","SouthLagoon"="#1D6996",
               "MidLagoon"="#0F8554","NorthLagoon"="#EDAD08",
               "NorthShore"="#E17C05","BayofWrecks"="#CC503E")

xlim1 <- as.POSIXct("2011/6/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")
xlim2 <- as.POSIXct("2017/1/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")
xlim3 <- as.POSIXct("2015/2/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")
xlim4 <- as.POSIXct("2016/9/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                    tz="Pacific/Kiritimati")

IS_and_Sat <- ggplot(data=DHW_all)+ 
  theme_classic()+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_line(aes(x=xi4,y=VB_NOAAMMM),color="#5F4690")+
  geom_line(aes(x=xi4,y=SL_NOAAMMM),color="#1D6996")+
  geom_line(aes(x=xi4,y=LF_NOAAMMM),color="#0F8554")+
  geom_line(aes(x=xi4,y=NL_NOAAMMM),color="#EDAD08")+
  geom_line(aes(x=xi4,y=NS_NOAAMMM),color="#E17C05")+
  geom_line(aes(x=xi4,y=BOW_NOAAMMM),color="#CC503E")+
  geom_line(aes(x=date,y=dhw),color="black",data=dhw_mean_KI,size=1.5)+
    scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim3,xlim4),
                   date_labels = "%b-%Y",date_breaks = "3 months")+
  scale_y_continuous(name="",limits=c(0,29),expand=c(0,0), 
                     breaks = c(0,4,8,12,16,20,24,28))+  


jpeg(filename = "figures/IS_and_Sat_forKIBleaching.jpg", width = 9.5, height = 10, 
     units="in", res=300)
IS_and_Sat
dev.off()

