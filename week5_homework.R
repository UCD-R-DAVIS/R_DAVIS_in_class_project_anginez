library(tidyverse)
### 1 ---- 
#read data
surveys <- read_csv('data/portal_data_joined.csv')
head(surveys)
#create surveys_wide
#need to make a mean hindfoot length column
surveys1 <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarize(mean_hflength = mean(hindfoot_length)) 
# usiing pivot_wider
surveys_wide <- surveys1 %>% 
  pivot_wider(id_cols = 'genus',
              names_from = 'plot_type',
              values_from = 'mean_hflength') %>%
  arrange(Control)
head(surveys_wide)

### 2 ----
?quantile
quantile(surveys$weight, prob = c(0.25, 0.5, 0.75), na.rm = TRUE)
# 1st quartile = 20, 3rd quartile = 48

surveys %>% 
  mutate(weight_cat = case_when(
    weight >= 48 ~ "large",
    is.na(weight) ~ NA_character_,
    weight <= 20 ~ "small",
    TRUE ~ "medium"
  )) %>% 
head()

surveys %>% 
  filter(!is.na(weight)) %>%
  mutate(weight_cat = case_when(
    weight >= 48 ~ 'large',
    weight <= 20 ~ 'small',
    TRUE ~ "medium"
  )) %>% 
  head()
