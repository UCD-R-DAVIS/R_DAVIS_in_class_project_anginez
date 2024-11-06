### week 6 homework ----


library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

### 1. calculate mean life expectancy on each continent, and then create a plot that shows how life expectancy has changed over time in each continent.
head(gapminder)

life_expectancy <- gapminder %>% 
  group_by(continent) %>% 
  mutate(mean_longevity = mean(lifeExp)) %>% #calculating the mean life expectancy for each continent
  ggplot(life_expectancy,mapping=aes(x = year, y=lifeExp)) +
  geom_line(aes(color = continent)) +
  theme_classic() +
  theme(panel.grid = element_blank()) 
life_expectancy

### 2a. what does scale_x_log10() achieve?
# this layer puts all the values used for the x-axis on a log10 scale, useful for visualizing data that should be log-transformed.

### 2b. what does geom_smooth() achieve?
# geom_smooth is useful for fitting a regression line to the points. 

### challenge: modify the code to size the points in proportion to the population of the country
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size =pop), alpha = 0.5) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

### 3. create a boxplot that shows the life expectancy for brazil, china, el salvador, niger, and the united states with data points using geom_jitter
?labs()

five_countries <- gapminder %>% 
  filter(country == 'Brazil' | country == 'China' | country == 'El Salvador' | country == 'Niger' | country == 'United States')  %>% 
  ggplot(five_countries, mapping = aes(x=country,y=lifeExp)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5) +
  labs(title = "Life Expectancy of Five Countries") +
  xlab("Country") +
  ylab("Life Expectancy")

five_countries
