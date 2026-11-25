## ----message=FALSE------------------------------------------------------------
library(water)


## -----------------------------------------------------------------------------
csvfile <- system.file("extdata", "apples.csv", package="water")
MTLfile <- system.file("extdata", "L7.MTL.txt", package="water")
# the wind speed in apples.csv is in km/h: cf converts it to m/s
WeatherStation <- read.WSdata(WSdata = csvfile, date.format = "%d/%m/%Y",
                              lat=-35.42222, long= -71.38639, elev=201, height= 2.2,
                              columns=c("date" = 1, "time" = 2, "radiation" = 3,
                              "wind" = 4, "RH" = 6, "temp" = 7, "rain" = 8),
                              cf = c(1, 0.2777778, 1), MTL = MTLfile,
                              tz = "America/Santiago")

## ----fig.width = 5------------------------------------------------------------
print(WeatherStation)

plot(WeatherStation, hourly=TRUE)

## ----fig.width = 5------------------------------------------------------------
image.DN <- rast(L7_Talca)
plot(image.DN)

## ----fig.width = 5, warning=FALSE---------------------------------------------
Energy.Balance <- METRIC.EB(image.DN = image.DN, plain=TRUE, 
                            WeatherStation = WeatherStation, 
                            MTL=MTLfile,
                            sat="L7", thermalband=image.DN$Thermal1)
summary(Energy.Balance)

## ----fig.width = 5------------------------------------------------------------
plot(Energy.Balance$EB)

## ----fig.width = 5, warning=FALSE---------------------------------------------
ET.24 <- ET24h(Energy.Balance)
plot(ET.24$ET24)

