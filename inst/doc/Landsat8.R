## ----message=FALSE, fig.width = 7---------------------------------------------
library(water)
scene_folder <- system.file("extdata", "L8_C2", package = "water")
image.SR <- loadImageSR(path = scene_folder)
plot(image.SR)

## -----------------------------------------------------------------------------
image.SR <- cfmask(path = scene_folder, image = image.SR)

## -----------------------------------------------------------------------------
csvfile <- system.file("extdata", "INTA.csv", package = "water")
MTLfile <- list.files(scene_folder, pattern = "MTL.txt$", full.names = TRUE)
WeatherStation <- read.WSdata(WSdata = csvfile, datetime.format = "%Y/%m/%d %H:%M",
                              columns = c("date" = 1, "time" = 1, "radiation" = 5,
                                          "wind" = 6, "RH" = 3, "temp" = 2, "rain" = 4),
                              lat = -33.00513, long = -68.86469, elev = 927, height = 2,
                              tz = "America/Argentina/Mendoza", MTL = MTLfile)
print(WeatherStation)

## ----fig.width = 7------------------------------------------------------------
Energy.Balance <- METRIC.EB(image.SR = image.SR, surf.temp = image.SR$Band_10,
                            WeatherStation = WeatherStation, MTL = MTLfile,
                            Z.om.ws = 0.03)
plot(Energy.Balance)

## -----------------------------------------------------------------------------
summary(Energy.Balance)

## ----fig.width = 7------------------------------------------------------------
ET.24 <- ET24h(Energy.Balance)
plot(ET.24$ET24)

## ----fig.width = 7------------------------------------------------------------
image.DN <- loadImage(path = system.file("extdata", package = "water"), sat = "L8")
MTL.L1 <- system.file("extdata", "LC82320832016040LGN00_MTL.txt", package = "water")
Energy.Balance.DN <- METRIC.EB(image.DN = image.DN, image.SR = image.SR,
                               WeatherStation = WeatherStation, MTL = MTL.L1,
                               sat = "L8", LST.method = "METRIC",
                               Z.om.ws = 0.03)
plot(Energy.Balance.DN)

