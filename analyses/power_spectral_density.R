data <- KI_allsites_1hr_insitu

as.xts(x, dateFormat="POSIXct")

library(TSstudio)
xts_to_ts()


library(bspec)

welchPSD(x, seglength, two.sided = FALSE, windowfun = tukeywindow, method = c("mean", "median"), windowingPsdCorrection = TRUE, ...)


# compute and plot the "plain" spectrum:
spec1 <- empiricalSpectrum(data)
plot(spec1$frequency, spec1$power, log="y", type="l")

# plot Welch spectrum using segments of length 10 years:
spec2 <- welchPSD(data, seglength=24)
plot(spec2$frequency, spec2$power, col="red")

library(phonTools)
pwelch()

spectrum(data)
