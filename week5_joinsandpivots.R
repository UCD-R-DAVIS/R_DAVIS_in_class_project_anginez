# good to use dim() while trying to join dfs 
library(tidyverse)

tail <- read_csv('data/tail_length.csv')
surveys <- read_csv('data/portal_data_joined.csv')

dim(tail)
dim(surveys)
head(tail)

surveys_inner <- inner_join(x = surveys, y = tail)
dim(surveys_inner)
head(surveys_inner)

all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)

# pivots change shapes, say you want to show columns as rows
# less manipulation, more visualization 

surveys_mz <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarise(mean_weight = mean(weight))

surveys_mz %>% 
  pivot_wider(id_cols = 'genus',
              names_from = 'plot_id',
              values_from = 'mean_weight')
