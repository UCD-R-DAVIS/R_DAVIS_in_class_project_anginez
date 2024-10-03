# rm() <- removes variables from the environment tab!! Helpful!!

# comparison functions
testnum <- 6
testnum2 <- 9

testnum2 == 5
# checks if this is equal to 5 or not, FALSE in this case 

testnum2 != 5
# checks if this is NOT 5, so it'll read as TRUE in this case

# handy name conventions
numSamples <- 50
num_samples <- 50
rm(num_samples)

#challenge
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg * 2.2

elephant2_lb > elephant1_lb

myelephants <- c(elephant1_lb, elephant2_lb)

which(myelephants == max(myelephants))
# 2, asking which is the biggest (max())      

getwd()

# "./data example" the period denots "from this data/filepath" when pulling data in 
# actually . maybe means from the current directory ?

d <- read.csv("./data/tail_length.csv")

dir.create("./homework")

# how r thinks about data 
# vectors
weight_g <- c(50,57,64,68,78)

### inspection -----
length(weight_g)
# 5 
str(weight_g)

### changing a vector ----
weight_g <- c(weight_g, 90)
weight_g
# need to include c() when adding values to a pre-existing vector 

# challenge 
num_char <- c(1, 2, 3, "a") # changes them all to characters 
num_logical <- c(1, 2, 3, TRUE, FALSE) # true fale become binary 1 and 0 
char_logical <- c("a", "b", "c", TRUE) # turns them all into characters 
tricky <- c(1, 2, 3, "4") # character vectors

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

# character < numerical < logical (hierarchy of vector types?)

### subsetting ----
  animals <- c("fish", "bird", "reptile", "mammal")
animals[2]
animals[c(2,3)]

### conditional subsetting ---- 
weight_g > 50
# FALSE TRUE TRUE TRUE TRUE TRUE, giving us a logical indication if the statement is true 
weight_g[weight_g > 50]
# then it reads out the values that make that statement TRUE 

### symbols ----
# %in%
animals %in% c("fish", "insect", "bird", "amphibian", "mammal")
# shows which are present in this larger dataset 
# using == instead is PAIRWISE MATCHING, whereas %in% doesn't care about location/order 
# bucket-to-bucket vs. pair-to-pair