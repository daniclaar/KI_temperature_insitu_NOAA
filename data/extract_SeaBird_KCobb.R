# Manually clean and trim Kim Cobb's SeaBird data

file1 <- "data/Kim_SeaBird/SBE05601861_2016-11-10_DrillSite_uc.csv"

sb.dataset <-read.csv(file1, header=TRUE, sep=",", comment.char = "%")

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]

# plot(sb.dataset$Temperature)

# plot(sb.dataset$Temperature[c(614400:617500)])

sb.dataset[c(614400:614440),]
sb.dataset[c(617480:617500),]

sb.dataset$Temperature[sb.dataset$Date == "2015-11-05"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-11-06"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-11-07"] <- NA

# plot(sb.dataset$Temperature[c(825000:830000)])

sb.dataset[c(825000:825020),]
sb.dataset[c(829980:830000),]

sb.dataset$Temperature[sb.dataset$Date == "2016-03-30"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2016-03-31"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2016-04-01"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2016-04-02"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2016-04-03"] <- NA

sb.dataset$Temperature[sb.dataset$Date == "2016-11-10"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2016-11-09"] <- NA

x13Drill_01861_2014toNov2016 <- sb.dataset

###

file2 <- "data/Kim_SeaBird/SBE05606613_2018-03-08_DrillSite_uc.csv"

sb.dataset <-read.csv(file2, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)

sb.dataset <- sb.dataset[sb.dataset$Date != "2016-11-10",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2018-03-08",]

x13Drill_06613_Nov2016toMar2018 <- sb.dataset

tail(x13Drill_01861_2014toNov2016) # ends at 2016-11-10 04:04:02
head(x13Drill_06613_Nov2016toMar2018) # starts with 2016-11-11 00:31:42

###

file3 <- "data/Kim_SeaBird/SBE05601857_2015-11-05_33_uc.csv"

sb.dataset <-read.csv(file3, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]

sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-04",]

# plot(sb.dataset$Temperature[c(280500:285500)])
head(sb.dataset[c(280500:285500),])

sb.dataset$Temperature[sb.dataset$Date == "2015-03-18"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-03-19"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-03-20"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-03-21"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-03-22"] <- NA

# plot(sb.dataset$Temperature[c(350000:450000)])
head(sb.dataset[c(350000:450000),])
tail(sb.dataset[c(350000:450000),])

sb.dataset$Temperature[sb.dataset$Date == "2015-05-06"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-07"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-08"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-09"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-10"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-11"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-12"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-13"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-14"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-15"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-16"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-17"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-18"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-19"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-20"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-21"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-22"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-23"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-24"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-25"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-26"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-27"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-28"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-29"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-30"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-05-31"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-01"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-02"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-03"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-04"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-05"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-06"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-07"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-08"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-09"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-10"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-11"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-12"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-13"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-14"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-15"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-16"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-17"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-18"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-19"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-20"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-21"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-22"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-23"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-24"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-25"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-26"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-27"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-28"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-29"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-06-30"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-01"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-02"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-03"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-04"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-05"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-06"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-07"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-08"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-09"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-10"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-11"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-12"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-13"] <- NA
sb.dataset$Temperature[sb.dataset$Date == "2015-07-14"] <- NA

site33_01857_2014toNov2015 <- sb.dataset


###

file4 <- "data/Kim_SeaBird/SBE05601861_2018-03-08_Site33_uc.csv"

sb.dataset <-read.csv(file4, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)

sb.dataset[c(1150900:1150920),]
# plot(sb.dataset$Temperature[c(1150900:1173981)])

sb.dataset <- sb.dataset[c(1150900:1173981),]

site33_01861_Nov2016toMar2018 <- sb.dataset


###

file5 <- "data/Kim_SeaBird/SBE05601850_2016-11-11_CTDSite_uc.csv"

sb.dataset <-read.csv(file5, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)

head(sb.dataset)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-07",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-08",]

sb.dataset$Temperature[c(620624:833676)] <- NA
sb.dataset$Temperature[c(609104:620624)] <- NA


# plot(sb.dataset$Temperature[833676:943985])

# plot(sb.dataset$Temperature[1:609104])
head(sb.dataset[1:609104,])
tail(sb.dataset[1:609104,])

sb.dataset1 <- sb.dataset[1:609104,]
sb.dataset2 <- sb.dataset[833676:943985,]

# plot(sb.dataset$Temperature[c(1:609104,833676:943985)])
# plot(sb.dataset$Temperature[c(500000:609104,833676:943985)])


CTDsite_01850_2014toNov2015 <- sb.dataset1
# Data from 01850 (sb.dataset$Temperature[833676:943985]) from ostensibly same site looks very weird- a lot of (daily?) variability, makes me wonder if it was at a different depth or was out of calibration? Have not included for now, but could include if this is cleared up.
CTDsite_01850_Mar2016toNov2016 <- sb.dataset2

rm(sb.dataset1,sb.dataset2)

###

file6 <- "data/Kim_SeaBird/SBE05601849_2015-11-06_BofW_uc.csv"

sb.dataset <-read.csv(file6, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-07",]

sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-05",]

BOW_01849_2014toNov2015 <- sb.dataset

###

file7 <- "data/Kim_SeaBird/SBE05601845_2015-11-06_22_uc.csv"

sb.dataset <-read.csv(file7, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-07",]

sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-05",]

site22_01845_2014toNov2015 <- sb.dataset

###

file8 <- "data/Kim_SeaBird/SBE05600653_2015-11-07_5_uc.csv"

sb.dataset <-read.csv(file8, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-07",]

sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-05",]

tail(sb.dataset[c(28000:28500),])
# plot(sb.dataset$Temperature[c(34000:119626)])
head(sb.dataset[c(34000:119626),])

# plot(sb.dataset$Temperature[c(34720:118906)])
head(sb.dataset[c(34720:118906),])
tail(sb.dataset[c(34720:118906),])

site5_00653_Jul2015toNov2015 <- sb.dataset[c(34720:118906),]

###
file9 <- "data/Kim_SeaBird/SBE05606985_2018-03-09_CTDsite_uc.csv"

sb.dataset <-read.csv(file9, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

sb.dataset <- sb.dataset[sb.dataset$Date != "2016-11-11",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2018-03-09",]

CTDsite_06985_Nov2016toMar2018 <- sb.dataset

###
file10 <- "data/Kim_SeaBird/SBE05601845_2016-03-31_CTDsite_uc.csv"

sb.dataset <-read.csv(file10, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

# plot(sb.dataset$Temperature[619000:827050])
head(sb.dataset[619000:827050,])

sb.dataset <- sb.dataset[619000:827050,]

sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-06",]
# plot(sb.dataset$Temperature)

CTDsite_01845_Nov2015toMar2016 <- sb.dataset

###
file11 <- "data/Kim_SeaBird/SBE05601970_2015-11-05_27_uc.csv"

sb.dataset <-read.csv(file11, header=TRUE, sep=",", comment.char = "%")

# plot(sb.dataset$Temperature)
head(sb.dataset)
tail(sb.dataset)

# plot(sb.dataset$Temperature)

sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-03",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-05",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-06",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-07",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2014-09-08",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-04",]
sb.dataset <- sb.dataset[sb.dataset$Date != "2015-11-05",]

site27_01970_Sep2014toNov2015 <- sb.dataset


# Cannot use Lagoon Site (Kim Lagoon 1) or Kim 2 Lagoon Site (Inner Lagoon), as they are both inside the lagoon, and not comparable to the rest of the data/analyses. These sites are not included here.
# Cannot use DrillSite as it is at 22 ft, and thus out of our depth range for this study.

save(list=c("site33_01857_2014toNov2015", "site33_01861_Nov2016toMar2018", 
            "BOW_01849_2014toNov2015", 
            "site27_01970_Sep2014toNov2015",
            "site22_01845_2014toNov2015", 
            "site5_00653_Jul2015toNov2015", 
            "CTDsite_01850_2014toNov2015","CTDsite_01845_Nov2015toMar2016","CTDsite_01850_Mar2016toNov2016", "CTDsite_06985_Nov2016toMar2018"),
     file = "data/SeaBird_KCobb_trimmed.RData")
