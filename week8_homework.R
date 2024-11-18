# Loading in the dataset
library(tidyverse)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# timezone and how missing values are reported in the dataframe
# timezone: UTC
# rel_humid -> -99; temp_C_2m -> -999.9; windSpeed_m_s -> -999.9

# remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s
mloa <- mloa %>% 
  filter(!rel_humid== "-99" & !temp_C_2m=="-999.9" & !windSpeed_m_s=="-999.9")

# create a "datetime" column using the year, month, day, hour24, and min columns 
mloa$datetime <- paste(mloa$year, "-", mloa$month,
"-", mloa$day, ", ", mloa$hour24, ":",
mloa$min, sep = "")
head(mloa)

# create a column called "datetimeLocal" that converts the datetime column to Pacific/Honolulu time
mloa$datetimeLocal <- with_tz(mloa$datetime, tzone = "Pacific/Honolulu")

# calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns
mloa <- mloa %>% 
  mutate(mon = month(datetimeLocal),
         hr = hour(datetimeLocal)) %>% 
  group_by(mon, hr) %>% 
  summarise(avgTemp = mean(temp_C_2m))

# ggplot scatterplot of the mean monthly temperature, with points colored by the local hour
ggplot(data = mloa, aes(x = mon, y = avgTemp, color = hr)) +
  geom_point() +
  theme_bw() +
  theme(
    panel.grid.major = element_blank()
  ) +
  labs(x="Month", y = "Average temperature")
