BOW_I <- bayofwrecks_1d
colnames(BOW_I) <- c("date","insitu_temp")
BOW_S <- sst_BOW[,c(2,1)]
colnames(BOW_S)
colnames(BOW_S) <- c("date","sat_temp")
nrow(BOW_S)
nrow(BOW_I)

BOW_I[c(2193:2922),] <- NA

BOW <- cbind(BOW_S,"insitu_temp"=BOW_I$insitu_temp)
tail(BOW)
plot(BOW$sat_temp)
plot(BOW$insitu_temp)

BOW$diff <- BOW$sat_temp - BOW$insitu_temp
BOW_meandiff <- mean(BOW$diff,na.rm = TRUE)
BOW_var <- var(BOW$diff,na.rm = TRUE)

###

NS_I <- northshore_1d
colnames(NS_I) <- c("date","insitu_temp")
NS_S <- sst_northshore[,c(2,1)]
colnames(NS_S)
colnames(NS_S) <- c("date","sat_temp")
nrow(NS_S)
nrow(NS_I)

NS_I[c(2193:2922),] <- NA

NS <- cbind(NS_S,"insitu_temp"=NS_I$insitu_temp)
tail(NS)
plot(NS$sat_temp)
plot(NS$insitu_temp)

NS$diff <- NS$sat_temp - NS$insitu_temp
NS_meandiff <- mean(NS$diff,na.rm = TRUE)
NS_var <- var(NS$diff,na.rm = TRUE)

###

NL_I <- northlagoon_1d
colnames(NL_I) <- c("date","insitu_temp")
NL_S <- sst_northlagoon[,c(2,1)]
colnames(NL_S)
colnames(NL_S) <- c("date","sat_temp")
nrow(NL_S)
nrow(NL_I)

NL_I[c(2193:2922),] <- NA

NL <- cbind(NL_S,"insitu_temp"=NL_I$insitu_temp)
tail(NL)
plot(NL$sat_temp)
plot(NL$insitu_temp)

NL$diff <- NL$sat_temp - NL$insitu_temp
NL_meandiff <- mean(NL$diff,na.rm = TRUE)
NL_var <- var(NL$diff,na.rm = TRUE)

###

SL_I <- southlagoon_1d
colnames(SL_I) <- c("date","insitu_temp")
SL_S <- sst_southlagoon[,c(2,1)]
colnames(SL_S)
colnames(SL_S) <- c("date","sat_temp")
nrow(SL_S)
nrow(SL_I)

SL_I[c(2193:2922),] <- NA

SL <- cbind(SL_S,"insitu_temp"=SL_I$insitu_temp)
tail(SL)
plot(SL$sat_temp)
plot(SL$insitu_temp)

SL$diff <- SL$sat_temp - SL$insitu_temp
SL_meandiff <- mean(SL$diff,na.rm = TRUE)
SL_var <- var(SL$diff,na.rm = TRUE)

###

VB_I <- vaskesbay_1d
colnames(VB_I) <- c("date","insitu_temp")
VB_S <- sst_vaskess[,c(2,1)]
colnames(VB_S)
colnames(VB_S) <- c("date","sat_temp")
nrow(VB_S)
nrow(VB_I)

VB_I[c(2193:2922),] <- NA

VB <- cbind(VB_S,"insitu_temp"=VB_I$insitu_temp)
tail(VB)
plot(VB$sat_temp)
plot(VB$insitu_temp)

VB$diff <- VB$sat_temp - VB$insitu_temp
VB_meandiff <- mean(VB$diff,na.rm = TRUE)
VB_var <- var(VB$diff,na.rm = TRUE)

###

LF_I <- lagoonface_1d
colnames(LF_I) <- c("date","insitu_temp")
LF_S <- sst_lagoonface[,c(2,1)]
colnames(LF_S)
colnames(LF_S) <- c("date","sat_temp")
nrow(LF_S)
nrow(LF_I)

LF_I[c(2193:2922),] <- NA

LF <- cbind(LF_S,"insitu_temp"=LF_I$insitu_temp)
tail(LF)
plot(LF$sat_temp)
plot(LF$insitu_temp)

LF$diff <- LF$sat_temp - LF$insitu_temp
LF_meandiff <- mean(LF$diff,na.rm = TRUE)
LF_var <- var(LF$diff,na.rm = TRUE)

region_meandiff <- data.frame("Vaskess Bay" = VB_meandiff, 
                              "South Lagoon" = SL_meandiff,
                              "Lagoon Face" = LF_meandiff,
                              "North Lagoon" = NL_meandiff,
                              "North Shore" = NS_meandiff,
                              "Bay of Wrecks" = BOW_meandiff)

region_var <- data.frame("Vaskess Bay" = VB_var, 
                              "South Lagoon" = SL_var,
                              "Lagoon Face" = LF_var,
                              "North Lagoon" = NL_var,
                              "North Shore" = NS_var,
                              "Bay of Wrecks" = BOW_var)
