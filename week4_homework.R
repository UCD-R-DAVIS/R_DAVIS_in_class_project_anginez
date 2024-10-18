library(tidyverse)
library(dplyr)

### 1 ----
surveys <- read_csv("data/portal_data_joined.csv")

### 2 ----
# subset surveys, keep weights between 30 and 60
surveys_filtered <- filter(surveys, weight > 30 & weight < 60)
# print first 6 rows
head(surveys_filtered)

### 3 ----
?arrange
biggest_critters <- surveys %>%
  filter(!is.na(weight)) %>% # removing NA values for easier data manip
  group_by(species_id, sex) %>% # sets up to see biggest weight of each
  summarise(max_weight = max(weight)) %>% #create maximum weight
  arrange(max_weight) %>%
  arrange(desc(max_weight)) # rearrange in descending order

view(biggest_critters)

### 4 ----
?tally
NAs <- surveys %>% 
  filter(is.na(weight)) %>% # only na values
  group_by(species) %>% 
  tally() %>% # will give a count for NAs
  arrange(desc(n)) # in descending order
head(NAs)
# harrisi highest amnt of NAs

surveys %>% 
  filter(is.na(weight)) %>% # only na values
  group_by(plot_id) %>% 
  tally() %>% # will give a count for NAs
  arrange(desc(n))
# plot 13 has the highest amnt of NAs

surveys %>% 
  filter(is.na(weight)) %>% # only na values
  group_by(plot_type) %>% 
  tally() %>% # will give a count for NAs
  arrange(desc(n))
# control plots have the highest amnt

### 5 ----
surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% # adding a new average weight column
  select(species, sex, weight, avg_weight) %>%
  arrange(desc(avg_weight))

### 6 ----
surveys_avg_weight <- surveys_avg_weight %>%
  mutate(above_average = weight > avg_weight)

head(surveys_avg_weight)
