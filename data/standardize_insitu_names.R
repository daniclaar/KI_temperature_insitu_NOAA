rm(list=ls())

load(file="data/KI_SB_temp_1hr.RData")
bayofwrecks_1hr_insitu <- bayofwrecks_1hr
KI_allsites_1hr_insitu <- KI_allsites_1hr
lagoonface_1hr_insitu <- lagoonface_1hr
northlagoon_1hr_insitu <- northlagoon_1hr
northshore_1hr_insitu <- northshore_1hr
southlagoon_1hr_insitu <- southlagoon_1hr
vaskesbay_1hr_insitu <- vaskesbay_1hr

rm(bayofwrecks_1hr,KI_allsites_1hr,lagoonface_1hr,northlagoon_1hr,
   northshore_1hr,southlagoon_1hr,vaskesbay_1hr)

save("bayofwrecks_1hr_insitu","KI_allsites_1hr_insitu", "lagoonface_1hr_insitu","northlagoon_1hr_insitu","northshore_1hr_insitu","southlagoon_1hr_insitu","vaskesbay_1hr_insitu",file="data/KI_insitu_temperature.RData")
