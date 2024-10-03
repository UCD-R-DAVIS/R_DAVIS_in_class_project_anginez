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