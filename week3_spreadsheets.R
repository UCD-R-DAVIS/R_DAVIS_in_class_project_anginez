surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
class(surveys)
summary(surveys)
# gives a summary on every columns of the data frame. includes min & max, mean, median, etc. 
summary(surveys$weight)

surveys[1,5] #indexing, specifying the ROW, and COLUMN
surveys[1:5,] # gives first five rows, all columns
surveys[1:5, 1] # specifies the column
surveys [1,] #first row, all columns
surveys[c(1,5,24,3001),] # specific rows, all columns
surveys[,4] # gives every value of this column
surveys[,c(1,2,5)]
surveys[,1:5]

head(surveys['genus']) #presented as a dataframe, keeps the structure 
head(surveys[['genus']]) # presented as a vector

library(tidyverse)
t_surveys <- read_csv('data/portal_data_joined.csv')
class(t_surveys)
t_surveys
# basically like using head()