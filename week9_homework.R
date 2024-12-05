# week 9 homework 
library(tidyverse)

surveys <- read.csv('data/portal_data_joined.csv')

# load mauna loa dataset
mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# using a for loop, print to the console the longest specis name of each taxon
for(i in unique(surveys$taxa)){
  mytaxon <- surveys[surveys$taxa == i,]
  longestnames <- mytaxon[nchar(mytaxon$species) == max(nchar(mytaxon$species)),] %>% select(species)
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}

# use the map function from purrr to print the max of each of the following columns:
# “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”

mycols <- mloa %>% 
  select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")

mycols %>% map(max, na.rm = T)
# $windDir [1] 360; $windSpeed_m_s [1] 20.5; $baro_hPa [1] -999.9; $temp_C_2m [1] 18.9; $temp_C_10m [1] 16.9; $temp_C_towertop [1] 16.2; $rel_humid [1] 138; $precip_intens_mm_hr [1] 60

# make a function called C_to_F that converts Celsius to Fahrenheit 
C_to_F <- function(x){
  x * 1.8 + 32
}

# make three new columns called "temp_F_2m", "temp_F_10m", and "temp_F_towertop" by applying this function to columns "temp_C_2m", "temp_C_10m", and "temp_C_towertop"

mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

