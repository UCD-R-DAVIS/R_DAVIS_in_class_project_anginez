### using surveys data ----
head(surveys)


surveys_base <- surveys[c('species_id', 'weight', 'plot_type')] # new dataframe with species_id, weight, and plot_type columns
surveys_base <- surveys_base[1:5000,] # selecting only the first 5000 rows
as.factor(surveys_base$species_id) # species_id as factors 
as.factor(surveys_base$plot_type) # plot_type as factors 
summary(surveys_base)
?complete.cases
surveys_base <- surveys_base[complete.cases(surveys_base$weight),] # removing rows with NA values in weight column

# factors are different from characters as they are levels or categories of objects, instead of objects themselves
# in the dataframe. factors may be useful if you are tying to see the levels present in the dataframe without having to 
# look through the entire df, such as if you are looking at the different plot types of the surveys data without wanting to
# scroll through 17k rows. 

### challenge ----
challenge_base <- surveys_base[surveys_base$weight > 150,]
# creating a dataframe from surveys_base only with individuals that had weight greater than 150g 