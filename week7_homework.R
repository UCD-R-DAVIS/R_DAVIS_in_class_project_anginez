gapminder <- read.csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

library(tidyverse)

# ideal df to work with -> countries in rows; two more columns for pop. in 2002 and 2007 to create the difference column. values would be the population size.

head(gapminder)

df <- gapminder %>% 
  select(country, year, pop, continent) %>%
  filter(year >= 2002 & year <= 2007) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% mutate(pop_diff = df$'2007' - df$'2002')

head(df)

# does NOT include oceanias in graph
df <- df %>% filter(!continent == "Oceania") %>% 
  group_by(continent)

# creating the plot

ggplot(df, aes(x = reorder(country,pop_diff), y = pop_diff)) +
  geom_col(width = 0.8, aes(fill = continent)) +
  facet_wrap(~ continent, ncol = 2, scales = "free") +
  labs(x = "Country", y = "Change in Populations Between 2002 and 2007") +
  theme_bw() +
  scale_fill_viridis_d() +
  theme(
    legend.position = 'none',
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
