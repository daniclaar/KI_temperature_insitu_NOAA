# Clear working environment
rm(list=ls())

# Load necessary packages
library(ggplot2)
library(gridExtra)

# Load necessary data
load("data/NOAA_CoralTemp_2011_2018.RData")
load("data/KI_SB_temp_wKim_1d.RData")

# Prep Bay of Wrecks in situ/satellite data for merge
BOW_I <- bayofwrecks_1d_wKim
colnames(BOW_I) <- c("date","insitu_temp")
BOW_S <- sst_BOW[,c(2,1)]
colnames(BOW_S) <- c("date","sat_temp")
BOW_I[c(2193:2922),] <- NA # Make in situ data set longer to match satellite
BOW <- cbind(BOW_S,"insitu_temp"=BOW_I$insitu_temp)

# Prep North shore in situ/satellite data for merge
NS_I <- northshore_1d_wKim
colnames(NS_I) <- c("date","insitu_temp")
NS_S <- sst_northshore[,c(2,1)]
colnames(NS_S) <- c("date","sat_temp")
NS_I[c(2193:2922),] <- NA
NS <- cbind(NS_S,"insitu_temp"=NS_I$insitu_temp)

# Prep North lagoon in situ/satellite data for merge
NL_I <- northlagoon_1d_wKim
colnames(NL_I) <- c("date","insitu_temp")
NL_S <- sst_northlagoon[,c(2,1)]
colnames(NL_S) <- c("date","sat_temp")
NL_I[c(2193:2922),] <- NA
NL <- cbind(NL_S,"insitu_temp"=NL_I$insitu_temp)

# Prep South lagoon in situ/satellite data for merge
SL_I <- southlagoon_1d_wKim
colnames(SL_I) <- c("date","insitu_temp")
SL_S <- sst_southlagoon[,c(2,1)]
colnames(SL_S) <- c("date","sat_temp")
SL_I[c(2193:2922),] <- NA
SL <- cbind(SL_S,"insitu_temp"=SL_I$insitu_temp)

# Prep Vaskess Bay in situ/satellite data for merge
VB_I <- vaskesbay_1d_wKim
colnames(VB_I) <- c("date","insitu_temp")
VB_S <- sst_vaskess[,c(2,1)]
colnames(VB_S) <- c("date","sat_temp")
VB_I[c(2193:2922),] <- NA
VB <- cbind(VB_S,"insitu_temp"=VB_I$insitu_temp)

# Prep Lagoon face in situ/satellite data for merge
LF_I <- lagoonface_1d_wKim
colnames(LF_I) <- c("date","insitu_temp")
LF_S <- sst_lagoonface[,c(2,1)]
colnames(LF_S) <- c("date","sat_temp")
LF_I[c(2193:2922),] <- NA
LF <- cbind(LF_S,"insitu_temp"=LF_I$insitu_temp)

# head(LF)

BOW_scatter <- ggplot(data = BOW,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = "In situ Temperature (°C)")+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = NULL)+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="Bay of Wrecks")

NS_scatter <- ggplot(data = NS,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = "In situ Temperature (°C)")+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = "Satellite Temperature (°C)")+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="North Shore")

NL_scatter <- ggplot(data = NL,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = NULL)+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = NULL)+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="North Lagoon")

SL_scatter <- ggplot(data = SL,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = NULL)+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = NULL)+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="South Lagoon")

VB_scatter <- ggplot(data = VB,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = NULL)+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = "Satellite Temperature (°C)")+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="Vaskess Bay")

LF_scatter <- ggplot(data = LF,aes(x=insitu_temp,y=sat_temp,color=insitu_temp))+
  theme_classic()+
  geom_point()+
  geom_abline(intercept = 0,color="gray60")+
  scale_x_continuous(limits = c(24,31.75),expand=c(0,0),name = NULL)+
  scale_y_continuous(limits = c(24,31.75),expand=c(0,0), name = "Satellite Temperature (°C)")+
  scale_color_viridis_c(option="B",direction=-1,guide=FALSE) +
  annotate("text",x=26,y=30.75, label="Mid Lagoon")

           
jpeg(filename = "figures/scatter_plot/scatter_plots.jpg",width = 6, height=8, units="in",res=300)
grid.arrange(VB_scatter,SL_scatter,LF_scatter,NL_scatter,NS_scatter,BOW_scatter)
dev.off()

pdf(file = "figures/scatter_plot/scatter_plots.pdf",width = 6, height=8, useDingbats = FALSE)
grid.arrange(VB_scatter,SL_scatter,LF_scatter,NL_scatter,NS_scatter,BOW_scatter)
dev.off()