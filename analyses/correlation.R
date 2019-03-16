# Clear working environment
rm(list=ls())

# Load necessary packages
library(corrplot)

# Load necessary data
load("data/KI_SB_temp_wKim_1d.RData")
load("data/NOAA_CoralTemp_2011_2018.RData")

# Exploratory correlations
corr <- ccf(sst_region$sst_BOW,sst_region$sst_vaskess)
corr <- ccf(bayofwrecks_1d_wKim$temperature_1d,sst_BOW$sst,na.action=na.exclude,lag.max = 730)
corr <- ccf(northlagoon_1d_wKim$temperature_1d,sst_northlagoon$sst,na.action=na.exclude,lag.max = 730)
corr <- ccf(southlagoon_1d_wKim$temperature_1d,sst_southlagoon$sst,na.action=na.exclude,lag.max = 30)
corr <- ccf(vaskesbay_1d_wKim$temperature_1d,sst_vaskess$sst,na.action=na.exclude,lag.max = 30)
corr <- ccf(vaskesbay_1d_wKim$temperature_1d,northshore_1d$temperature_1d,na.action=na.exclude,lag.max = 30)
# corr <- ccf(vaskesbay_1d$temperature_1d[c(1774:2140)],sst_vaskess$sst[c(1774:2140)],na.action=na.pass,lag.max = 30)
corr$lag[which.max(corr$acf)]
plot(corr,ylim=c(0.7,1),main="Vaskess Bay")


#https://anomaly.io/detect-correlation-time-series/
correlationTable = function(graphs) {
  cross = matrix(nrow = length(graphs), ncol = length(graphs))
  for(graph1Id in 1:length(graphs)){
    graph1 = graphs[[graph1Id]]
    print(graph1Id)
    for(graph2Id in 1:length(graphs)) {
      graph2 = graphs[[graph2Id]]
      correlation = ccf(graph1, graph2, lag.max = 0,na.action = na.exclude)
      # correlation = ccf(graph1, graph2, lag.max = 0)
      cross[graph1Id, graph2Id] = correlation$acf[1]
      }
    }
  cross
}

sst_insitu_region <- cbind(sst_region[c(1:2192),],
                           "insitu_BOW" = bayofwrecks_1d_wKim$temperature_1d,
                           "insitu_northlagoon" = northlagoon_1d_wKim$temperature_1d,
                           "insitu_southlagoon" = southlagoon_1d_wKim$temperature_1d,
                           "insitu_vaskess" = vaskesbay_1d_wKim$temperature_1d,
                           "insitu_northshore" = northshore_1d_wKim$temperature_1d,
                           "insitu_lagoonface" = lagoonface_1d_wKim$temperature_1d)

sst_insitu_region <- sst_insitu_region[,c(1,5,4,7,3,6,2,11,10,13,9,12,8)]

# Choose what to compare (all in situ and all satellite SST)
graphs <- sst_insitu_region[,c(2:13)]
# Run correlationTable
corr = correlationTable(graphs)

colnames(corr) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                    "Mid Lagoon (S)","North Lagoon (S)",
                    "North Shore (S)","Bay of Wrecks (S)", 
                    "Vaskess Bay (I)", "South Lagoon (I)",
                    "Mid Lagoon (I)","North Lagoon (I)",
                    "North Shore (I)","Bay of Wrecks (I)")
rownames(corr) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                    "Mid Lagoon (S)","North Lagoon (S)",
                    "North Shore (S)","Bay of Wrecks (S)", 
                    "Vaskess Bay (I)", "South Lagoon (I)",
                    "Mid Lagoon (I)","North Lagoon (I)",
                    "North Shore (I)","Bay of Wrecks (I)")

# No longer need to remove with including Kim's data
# # Removed - insufficient overlap between these two sites - only 62 days
# vaskess_northshore_overlap <- sst_insitu_region[which(sst_insitu_region$insitu_northshore!="NaN" & sst_insitu_region$insitu_vaskess!="NaN"),]

plot(vaskess_northshore_overlap$date,vaskess_northshore_overlap$insitu_northshore)
nrow(vaskess_northshore_overlap)
# Use simulated p-value matrix: can be used to cross out certain values in the correlation matrix - no longer need this, as we have enough north Shore data now
p <- matrix(0.05,12,12)
# p[7,11] <- 1
# p[11,7] <- 1

# Create pdf of correlation plot
pdf(file = "figures/corr_plot.pdf",width=8,height=7,useDingbats = FALSE)
corrplot.mixed(corr, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               p.mat=p,sig.level=0.05,pch.col="darkgray",pch.cex=3)
dev.off()

jpeg(filename = "figures/corr_plot.jpg",width=8,height=7,units="in",res=300)
corrplot.mixed(corr, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               p.mat=p,sig.level=0.05,pch.col="darkgray",pch.cex=3)
dev.off()

#################################
# Use region of overlap August 27 2011 to July 30 2013
sst_insitu_region_s1 <- sst_insitu_region[c(239:942),]
# Choose what to compare 
graphs2 <- sst_insitu_region_s1[,c(2:7,9,11:13)]
# Run correlationTable
corr2 = correlationTable(graphs2)

colnames(corr2) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                    "Mid Lagoon (S)","North Lagoon (S)",
                    "North Shore (S)","Bay of Wrecks (S)", 
                    "South Lagoon (I)",
                    "North Lagoon (I)",
                    "North Shore (I)","Bay of Wrecks (I)")
rownames(corr2) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                    "Mid Lagoon (S)","North Lagoon (S)",
                    "North Shore (S)","Bay of Wrecks (S)", 
                    "South Lagoon (I)",
                    "North Lagoon (I)",
                    "North Shore (I)","Bay of Wrecks (I)")

pdf(file = "figures/corr_plot_2011to2013_noVaskessInoLagoonFaceI.pdf",width=8,height=7,useDingbats = FALSE)
corrplot.mixed(corr2, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               pch.col="darkgray",pch.cex=3)
dev.off()

jpeg(filename = "figures/corr_plot_2011to2013_noVaskessInoLagoonFaceI.jpg",width=8,height=7,units="in",res=300)
corrplot.mixed(corr2, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               pch.col="darkgray",pch.cex=3)
dev.off()


#################################
# Use region of overlap November 09 2015 to November 09 2016
sst_insitu_region_s2 <- sst_insitu_region[c(1774:2140),]
# Choose what to compare (all in situ and all satellite SST)
graphs3 <- sst_insitu_region_s2[,c(2:11,13)]
# Run correlationTable
corr3 = correlationTable(graphs3)

colnames(corr3) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                     "Mid Lagoon (S)","North Lagoon (S)",
                     "North Shore (S)","Bay of Wrecks (S)", 
                     "Vaskess Bay (I)","South Lagoon (I)",
                     "Mid Lagoon (I)","North Lagoon (I)",
                     "Bay of Wrecks (I)")
rownames(corr3) <- c("Vaskess Bay (S)", "South Lagoon (S)",
                     "Mid Lagoon (S)","North Lagoon (S)",
                     "North Shore (S)","Bay of Wrecks (S)", 
                     "Vaskess Bay (I)","South Lagoon (I)",
                     "Mid Lagoon (I)","North Lagoon (I)",
                     "Bay of Wrecks (I)")

pdf(file = "figures/corr_plot_2015to2016_noNorthShoreI.pdf",width=8,height=7,useDingbats = FALSE)
corrplot.mixed(corr3, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               pch.col="darkgray",pch.cex=3)
dev.off()

jpeg(filename = "figures/corr_plot_2015to2016_noNorthShoreI.jpg",width=8,height=7,units="in",res=300)
corrplot.mixed(corr3, upper = "circle",  
               lower.col = colorRampPalette(c("blue","yellow", "red"))(20),
               number.cex = 0.85,tl.pos = "lt",
               number.digits=3, cl.lim = c(0.75,1),is.corr = FALSE,
               upper.col = colorRampPalette(c("blue","yellow", "red"))(20),
               tl.col="black",tl.srt=45,outline="darkgray",
               pch.col="darkgray",pch.cex=3)
dev.off()
