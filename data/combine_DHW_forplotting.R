rm(list=ls())

load("data/KI_SB_temp_DHW_NOAAMMM.RData")
load("data/KI_SB_temp_DHW_NOAAMMMminOffset.RData")
load("data/KI_SB_temp_DHW_NOAAMMM_minOffsetnoEN.RData")

DHW_all <- cbind(southlagoon_DHW_NOAAMMM,northlagoon_DHW_NOAAMMM$DHW,lagoonface_DHW_NOAAMMM$DHW,northshore_DHW_NOAAMMM$DHW,bayofwrecks_DHW_NOAAMMM$DHW,vaskesbay_DHW_NOAAMMM$DHW)

DHW_all <- cbind(DHW_all,southlagoon_DHW_minOffset$DHW,northlagoon_DHW_minOffset$DHW,lagoonface_DHW_minOffset$DHW,northshore_DHW_minOffset$DHW,bayofwrecks_DHW_minOffset$DHW,vaskesbay_DHW_minOffset$DHW)
                 
DHW_all <- cbind(DHW_all,southlagoon_DHW_minOffsetnoEN$DHW,northlagoon_DHW_minOffsetnoEN$DHW,lagoonface_DHW_minOffsetnoEN$DHW,northshore_DHW_minOffsetnoEN$DHW,bayofwrecks_DHW_minOffsetnoEN$DHW,vaskesbay_DHW_minOffsetnoEN$DHW)
                 

colnames(DHW_all) <- c("xi4","SL_NOAAMMM","NL_NOAAMMM","LF_NOAAMMM","NS_NOAAMMM","BOW_NOAAMMM","VB_NOAAMMM","SL_NOAAminOffset","NL_NOAAminOffset","LF_NOAAminOffset","NS_NOAAminOffset","BOW_NOAAminOffset","VB_NOAAminOffset","SL_NOAAminOffsetnoEN","NL_NOAAminOffsetnoEN","LF_NOAAminOffsetnoEN","NS_NOAAminOffsetnoEN","BOW_NOAAminOffsetnoEN","VB_NOAAminOffsetnoEN")
