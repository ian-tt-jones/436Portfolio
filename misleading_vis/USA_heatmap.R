# installing packages
install.packages("ggplot2")
install.packages("maps")
install.packages("dplyr")
install.packages("tidycensus")
install.packages("sf")


# loading libraries
library(ggplot2)
library(maps)
library(ggplot2)
library(tidycensus)
library(sf)

# reading in unemployment data
unemployment_data_2020 <- read.csv("/Users/ianjones/Desktop/cs 436/436portfolio/misleading_vis/april2020unemployment.csv")
unemployment_data_2024 <- read.csv("/Users/ianjones/Desktop/cs 436/436portfolio/misleading_vis/april24unemployment.csv")

head(unemployment_data_2020)
head(unemployment_data_2024)

# merging data with state coordinates
library(dplyr)

# reading in shapefile
shapefile_data <- st_read("/Users/ianjones/Desktop/cs 436/436portfolio/misleading_vis/US 50 States Boundaries Shapefile_20240522/geo_export_7ce73286-b39c-4ce1-a845-79d033cbd2d6.shp")

# rename column in shapefile
colnames(shapefile_data)
shapefile_data <- shapefile_data %>% rename(State = state_name)

# Merge with unemployment data
merged_data_2020 <- merge(shapefile_data, unemployment_data_2020, by.x = "State", by.y = "State", all.x = TRUE)
merged_data_2024 <- merge(shapefile_data, unemployment_data_2024, by.x = "State", by.y = "State", all.x = TRUE)


# updating shapefile to only include the data we want, unemployment rate
updated_shapefile_2020 <- merged_data_2020[, c("Unemployment.Rate")]
updated_shapefile_2024 <- merged_data_2024[, c("Unemployment.Rate")]


# plotting

# setting the scale
breaks <- c(0, 2, 4, 10, 15, 30)

# Define breaks and colors for the finer scale
breaks <- c(0, 5, 10, 15, 20, 25, 30, Inf)  # Breaks for the unemployment rate scale
colors <- c("lightgreen", "yellow", "orange", "orangered", "red", "darkred")  # Colors corresponding to the breaks

# Set wider plot margins
summary(updated_shapefile_2020)
summary(updated_shapefile_2024)

par(mfrow = c(1, 2))

# Plotting 2020
plot(updated_shapefile_2020, col = colors, breaks = breaks, axes = FALSE, main = "Unemployment Rate in April 2020 (Trump)")
plot(updated_shapefile_2020, col = colors_, breaks = breaks_, main = "Unemployment Rate in April 2020 (Trump)", pal = colorNumeric(palette = colors_, domain = updated_shapefile_2024$Unemployment_Rate))

legend("bottomleft", legend = c("0-5%", "5-10%", "10-15%", "15-20%", "20-25%", "25%+"), fill = colors, title = "Unemployment Rate")


# Add x-axis label manually
mtext("Unemployment Rate (%)", side = 1, line = 3)

# plotting 2024
breaks_ <- c(0, 5, 10, 15, 20, 25, 30, Inf)  # Breaks for the unemployment rate scale
colors_ <- c("lightgreen", "yellow", "orange", "orangered", "red", "darkred")  # Colors corresponding to the breaks

plot(updated_shapefile_2024, col = colors_, breaks = breaks_, axes = FALSE, main = "Unemployment Rate in April 2024 (Biden)")
plot(updated_shapefile_2024, col = colors_, breaks = breaks_, main = "Unemployment Rate in April 2024 (Biden)", pal = colorNumeric(palette = colors_, domain = updated_shapefile_2024$Unemployment_Rate))

legend("bottomleft", legend = c("0-5%", "5-10%", "10-15%", "15-20%", "20-25%", "25%+"), fill = colors, title = "Unemployment Rate")

# Add x-axis label manually
mtext("Unemployment Rate (%)", side = 1, line = 3)

