library(tidyverse)
### read in the file ----
tyler_activity_laps <-  read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")
head(tyler_activity_laps)

### filter out any non-running activities ----
tyler_activity_laps <- tyler_activity_laps %>% 
  filter(sport == 'running')

### remove laps with times > 10 min & < 5 min ----
tyler_activity_laps <- tyler_activity_laps[tyler_activity_laps$minutes_per_mile > 5 & 
                                             tyler_activity_laps$minutes_per_mile < 10,]
tyler_activity_laps <- tyler_activity_laps %>% 
  filter(!tyler_activity_laps$total_elapsed_time_s <= 60) # also filtering out any rows where elapsed time is less than or equal to a minute
head(tyler_activity_laps)

### group observations into three time periods corresponding to pre-2024 runningg, tyler's initial rehab efforts from january to june of this year, and activities from july to the present ----

tyler_activity_laps <- tyler_activity_laps %>% 
  mutate(period = case_when(
    year < 2024 ~ 'pre-2024',
    year == 2024 & month >=1 & month <= 6 ~ 'Jan-Jun 2024',
    TRUE ~ 'Jul-Oct 2024'
  ))
head(tyler_activity_laps)

### make a scatterplot that graphs SPM over speed by lap (minutes_per_mile), and make 5 aesthetic changes, and add linear trendlines to the plot to show the relationship between speed and SPM for each of the three time periods ----

ggplot(tyler_activity_laps, aes(x = minutes_per_mile, y = steps_per_minute, color = period)) +
  geom_point() +
  geom_smooth(aes(group = period), method = 'lm', color = '#101010', alpha = 0.2) +
  scale_color_manual(values = c("pre-2024" = "#b5e48c", "Jul-Oct 2024" = "#52b69a","Jan-Jun 2024" = "#1a759f")) + 
  theme_classic() +
  theme(panel.grid.major = element_blank()) +
  labs(x = "Speed by lap", y = "Steps per minute") 

### 8 ----
tyler_july <- tyler_activity_laps %>% filter(period == 'Jul-Oct 2024') #focusing post-intervention
tyler_july <- tyler_july %>% group_by(year, month,day) %>% 
  mutate(lap_num = rank(timestamp)) %>% 
  ungroup() %>% 
  filter(lap_num <= 3)
  
# make a plot showing SPM, speed, and lap number
ggplot(tyler_july, aes(x = minutes_per_mile, y = steps_per_minute, color = lap_num)) +
  geom_point() +
  geom_smooth(aes(group = lap_num), method = 'lm', alpha = 0.2, se = FALSE) +
  theme_classic() + 
  theme(panel.grid.major = element_blank()) + 
  labs(x = 'Min. per mile', y = 'Steps per mile', color = 'Lap number')
