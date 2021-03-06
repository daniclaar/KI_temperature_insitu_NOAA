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

VB_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.position = c(0.75, 0.2),legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=VB_NOAAMMM),color="#5F4690",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=VB_NOAAminOffset),color="#AC93DD",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=VB_NOAAminOffsetnoEN),color="#DEC5FF",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_vaskess,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="DHW (ºC-week)",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="Vaskess Bay")

SL_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.position = c(0.75, 0.2),legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=SL_NOAAMMM),color="#1D6996",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=SL_NOAAminOffset),color="#6AB6E3",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=SL_NOAAminOffsetnoEN),color="#9CE8FF",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_southlagoon,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="DHW (ºC-week)",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="South Lagoon")

LF_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.position = c(0.75, 0.2),legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=LF_NOAAMMM),color="#0F8554",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=LF_NOAAminOffset),color="#5CD2A1",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=LF_NOAAminOffsetnoEN),color="#8EFFD3",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_lagoonface,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="DHW (ºC-week)",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="Mid Lagoon")

NL_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.position = c(0.75, 0.2),legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=NL_NOAAMMM),color="#EDAD08",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=NL_NOAAminOffset),color="#FFE03B",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=NL_NOAAminOffsetnoEN),color="#FFFF6E",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_northlagoon,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="North Lagoon")

NS_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.position = c(0.75, 0.2),legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=NS_NOAAMMM),color="#E17C05",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=NS_NOAAminOffset),color="#FFAF38",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=NS_NOAAminOffsetnoEN),color="#FFE26B",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_northshore,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="North Shore")

BOW_DHW <- ggplot()+ 
  theme_classic()+
  theme(legend.background=element_blank())+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_hline(yintercept = 32,linetype="dashed")+
  geom_line(aes(x=xi4,y=BOW_NOAAMMM),color="#CC503E",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=BOW_NOAAminOffset),color="#FF8371",data=DHW_all,size=1.5)+
  geom_line(aes(x=xi4,y=BOW_NOAAminOffsetnoEN),color="#FFB6A4",data=DHW_all,size=1.5)+
  geom_line(aes(x=date,y=dhw),color="gray50",data=dhw_BOW,size=1.5)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim1,xlim2))+
  scale_y_continuous(name="",limits=c(0,34),expand=c(0,0), 
                     breaks = c(4,8,12,16,20,24,28,32))+  
  annotate("text",x=as.POSIXct("2012/4/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=30.5, label="Bay of Wrecks")

NOAA_DHW <- ggplot()+ 
  theme_classic()+
  geom_hline(yintercept = 4,linetype="dashed")+
  geom_hline(yintercept = 8,linetype="dashed")+
  geom_hline(yintercept = 12,linetype="dashed")+
  geom_hline(yintercept = 16,linetype="dashed")+
  geom_hline(yintercept = 20,linetype="dashed")+
  geom_hline(yintercept = 24,linetype="dashed")+
  geom_hline(yintercept = 28,linetype="dashed")+
  geom_line(aes(x=date,y=dhw),color="#5F4690",data=dhw_vaskess)+
  geom_line(aes(x=date,y=dhw),color="#1D6996",data=dhw_southlagoon)+
  geom_line(aes(x=date,y=dhw),color="#0F8554",data=dhw_lagoonface)+
  geom_line(aes(x=date,y=dhw),color="#EDAD08",data=dhw_northlagoon)+
  geom_line(aes(x=date,y=dhw),color="#E17C05",data=dhw_northshore)+
  geom_line(aes(x=date,y=dhw),color="#CC503E",data=dhw_BOW)+
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim3,xlim4),
                   date_labels = "%b-%Y",date_breaks = "3 months")+
  scale_y_continuous(name="DHW (ºC-week)",limits=c(0,29),expand=c(0,0), 
                     breaks = c(0,4,8,12,16,20,24,28))+  
  annotate("text",x=as.POSIXct("2015/5/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=26, label="Satellite")

InSitu_DHW <- ggplot(data=DHW_all)+ 
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
  scale_x_datetime(name=NULL, expand=c(0,0), limits=c(xlim3,xlim4),
                   date_labels = "%b-%Y",date_breaks = "3 months")+
  scale_y_continuous(name="",limits=c(0,29),expand=c(0,0), 
                     breaks = c(0,4,8,12,16,20,24,28))+  
  annotate("text",x=as.POSIXct("2015/5/1 00:00:00",format="%Y/%m/%d %H:%M:%S",
                               tz="Pacific/Kiritimati"),y=26, label="In Situ")


pdf(file = "figures/DHW/KI_DHWs.pdf", width = 9.5, height = 10, useDingbats = FALSE)
grid.arrange(NOAA_DHW,InSitu_DHW,VB_DHW,NL_DHW,SL_DHW,
             NS_DHW,LF_DHW,BOW_DHW, layout_matrix = rbind(c(1, 2),
                                                          c(3, 4),
                                                          c(5, 6),
                                                          c(7, 8)))
dev.off()

jpeg(filename = "figures/DHW/KI_DHWs.jpg", width = 9.5, height = 10, units="in", res=300)
grid.arrange(NOAA_DHW,InSitu_DHW,VB_DHW,NL_DHW,SL_DHW,
             NS_DHW,LF_DHW,BOW_DHW, layout_matrix = rbind(c(1, 2),
                                                          c(3, 4),
                                                          c(5, 6),
                                                          c(7, 8)))
dev.off()

jpeg(filename = "figures/DHW/KI_DHWs2.jpg", width = 9.5, height = 7.5, units="in", res=300)
grid.arrange(VB_DHW,NL_DHW,SL_DHW,
             NS_DHW,LF_DHW,BOW_DHW, layout_matrix = rbind(c(1, 2),
                                                          c(3, 4),
                                                          c(5, 6)))
dev.off()

jpeg(filename = "figures/DHW/KI_DHWs_supplementary.jpg", width = 9.5, height = 2.5, units="in", res=300)
grid.arrange(NOAA_DHW,InSitu_DHW,ncol=2)
dev.off()

pdf(file = "figures/DHW/KI_DHWs_supplementary.pdf", width = 9.5, height = 2.5)
grid.arrange(NOAA_DHW,InSitu_DHW,ncol=2)
dev.off()


pdf(file = "figures/DHW/KI_DHWs2.pdf", width = 9.5, height = 7.5)
grid.arrange(VB_DHW,NL_DHW,SL_DHW,
             NS_DHW,LF_DHW,BOW_DHW, layout_matrix = rbind(c(1, 2),
                                                          c(3, 4),
                                                          c(5, 6)))
dev.off()