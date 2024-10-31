### reading in the file ----
tyler_data <-  read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

### filter out any non-running activities
head(tyler_data)
library(dplyr)
tyler_data <- tyler_data %>% 
  filter(sport == "running")

### remove laps with times > 10 min. % < 5 min.
tyler_data <- tyler_data[tyler_data$minutes_per_mile > 5 & tyler_data$minutes_per_mile < 10,] %>% 
  filter(!tyler_data$total_elapsed_time_s < 60) # also filtering out any rows where elapsed time is less than a minute

### creating a "pace" categorical variable
tyler_data <- tyler_data %>% 
  mutate(pace = case_when(
    minutes_per_mile < 6 ~ "fast",
    minutes_per_mile > 8 ~ "slow",
    TRUE ~ "medium"
  ))
### creating "form" categorical variable
tyler_data <- tyler_data %>% 
  mutate(form = case_when(
    year == 2024 ~ "new",
    TRUE ~ "old"
  ))

### identify the average steps per minute for laps by form and pace
tyler_averages <- tyler_data %>% 
  group_by(form, pace) %>% 
  summarise(mean_steps = mean(steps_per_minute))

tyler_averages$mean_steps <- reorder(tyler_averages$mean_steps, -tyler_averages$mean_steps)

### generate a table showing these values w/ old and new as separate rows, and pace categories as columns
library(tidyverse)

tyler_averages %>% 
  pivot_wider(id_cols = 'form',
              names_from = 'pace',
              values_from = 'mean_steps') %>%
  
tyler_averages$pace <- factor(tyler_averages$pace, c("slow", 'medium', 'fast'))


### summarize the minimum, mean, median, and maximum steps per minute results for all laps run between january-june 2024 and july-october 2024
tyler_stats <- tyler_data %>% 
  filter(year == 2024 & month == 1:10)
tyler_stats <- tyler_stats %>%
  mutate(period = case_when(
    month >= 1 & month <= 6  ~ "Jan-Jun 2024",
    TRUE ~ "Jul-Oct 2024"
  )) %>%
  group_by(period) %>% 
  summarise(minimum = min(steps_per_minute),
            maximum = max(steps_per_minute),
            med = median(steps_per_minute),
            mean = mean(steps_per_minute))

