x <- c("good", "best", "better", "better", "best")
x_factor <- factor(x)
x
x_factor

x[1] > x[5]

x_factor <- factor(x, ordered = TRUE, levels = c("good", "better", "best"))
x_factor[1] > x_factor[5]

summary(x)
summary(x_factor)

df <- data.frame(x, x_factor)
x_list <- list(x, x_factor)
x_list

hist(mtcars$mpg)
barplot(table(x))
boxplot(mtcars$mpg)
summary(mtcars$mpg)
plot(mtcars$wt, mtcars$mpg)

library(ggplot2)
ggplot(data = mtcars, mapping = aes())

ggplot(
  data = mtcars,
  mapping = aes(x = wt, y = mpg),
  ylab("Miles/(US) gallon"),
  xlab("Weight (1000 lbs)")
)


library(dplyr)

iris
head(iris)

iris1 <- iris %>% arrange(desc(Petal.Length))
head(iris1)

iris2 <- iris %>%
  arrange(desc(Petal.Length)) %>%
  arrange(desc(Petal.Width))


ggplot(data = iris, mapping = aes(x = Sepal.Width, y = Species)) +
  geom_boxplot()

IRIS_graph <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point()
IRIS_graph + labs(
  title = "Figure 1. Scatterplot of Iris Petal Width vs Petal Length",
  x = "LENGTH",
  y = "WIDTH"
)

library(tidyverse)

ggplot(iris, aes(x = Petal.Length)) +
  geom_histogram()
dim(iris)
head(iris)

barplot(table(iris$Species))

barplot(iris$Petal.Length)

ggplot(iris, aes(x = Species)) +
  geom_bar()

head(iris$Petal.Length)

ggplot(iris, aes(x = Petal.Length)) +
  geom_histogram(color = "white") +
  facet_wrap(iris$Species)
boxplot(iris$Petal.Length)
ggplot(iris, aes(y = Petal.Length, x = factor(Species))) +
  geom_boxplot()

x <- c(20, 21, 22, 23, 24)
mean(x)
median(x)
# gives two values
range(x)
# real range
range(x)[2] - range(x)[1]
max(x) - min(x)
IQR(x)
quantile(x, .25)

# February 13th, 2024

qqnorm(mtcars$mpg)

IQR(mtcars$mpg)

quantile(mtcars$mpg, 0.75) + 1.5 * IQR(mtcars$mpg)

mtcars[mtcars$mpg > quantile(mtcars$mpg, 0.75) + 1.5 * IQR(mtcars$mpg), ]

# February 14th, 2024

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point()

ggplot(iris, aes(x = Sepal.Width, y = Petal.Length)) +
  geom_point()

ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point()

# correlation
cor(iris$Petal.Width, iris$Petal.Length)


# correlation
cor(iris$Petal.Width, iris$Petal.Length)


data(iris)

(max(iris$Sepal.Length) - mean(iris$Sepal.Length)) / sd(iris$Sepal.Length)

cor(iris[, c("Sepal.Width", "Petal.Length", "Petal.Width")], iris$Sepal.Length)

summary(lm(Sepal.Length ~ Petal.Length, data = iris))

model4 <- lm(mpg~wt - hp, data = mtcars)
model4

gg <- 2

if (gg > 3)
  gg else
  gg + 1


# Assuming you have a dataset named 'mtcars' containing the relevant variables (mpg, wt, am)
# Fit the interaction model
model <- lm(mpg ~ wt * am, data = mtcars)

# Summarize the model
summary(model)

# To extract coefficients and interpret them
coefficients(model)

# To predict the change in mpg for automatic transmission cars with a 1000 pound increase in weight
delta_mpg <- coefficients(model)["wt:am"] * 1000

# Print the expected change
print(delta_mpg)

print(summary(lm(mpg ~ wt * am, data = mtcars))$coefficients["wt:am", "Estimate"] * 1000)

lm(mpg ~ wt * am, data = mtcars)

summary(lm(mpg ~ wt * am, data = mtcars))

summary(lm(mpg ~ wt + am, data = mtcars))

# Fit Model 2: Linear regression model with interaction
model <- lm(mpg ~ wt * am, data = mtcars)

# Predict mpg for a 2000 pound car with automatic transmission
new_data <- data.frame(wt = 2000, am = 0)  # 0 indicates automatic transmission
predicted_mpg <- predict(model, newdata = new_data)

predicted_mpg

library(ggplot2)

ggplot(data = mtcars, aes(x = mpg, y = wt, color = factor(cyl))) +
  geom_point()

# 1 predictor would be mtcars$mpg
# write the ggplot command for creating a scatterplot with weight in the y
# axis and the best predictor #1 in the x axis. the ggplot commaand should include a code for
# producing different colors for number of cylinders a car has

# based on the plot would you say that the linear relationship
# between the weight of a car and the best predictor strongger for 6 cyl cars than 4 cyl cars?

# fit a simple linear regression that can be used to predict a cars weight in thousands of pounds
# interpret the value of r squared
summary(lm(mpg ~ wt, data = mtcars))

# what is the expected rate of change for a cars weight per 1 unit increase in mpg for cars with 120 hp
summary(lm(wt ~ mpg * hp, data = mtcars))

# write the ggplot command for creating side by side boxplots
# of cars weight by number of cylinders
# based on this 3 boxplots which car has the smallest IQR
ggplot(data = mtcars, aes(x = factor(cyl), y = wt)) +
  geom_boxplot()

# write the r command that will create a logical vector called is8cyl
# that will identify if a car has 8cyls or not
# then write another command that uses this new vector  to store the weights
# of just 8 cyl cars in a new vector called wt_8cyl.
# calculate and interpret the standard deviation of the weights of just the 8 cyl cars
is8cyl <- mtcars$cyl == 8
wt_8cyl <- mtcars$wt[is8cyl]
sd(wt_8cyl)

# write the dpylr command for displaying a table comparing the 
# mean weights and the standard deviation of the weights of carsby num of cyl.
# do the weights of 8 cyl cars have more variability than the weights of 
# 4 cyl cars? explain using the table.
library(dplyr)

mtcars %>%
  group_by(cyl) %>%
  summarise(mean_weight = mean(wt),
            sd_weight = sd(wt))

# write the dplyr command for creating a new data frame named MTCARS8cyl
# containing the variables wt and mpg only for cars with 8 cyls from the mtcars data frame
MTCARS8cyl <- mtcars %>%
  filter(cyl == 8) %>%
  select(wt, mpg)
MTCARS8cyl

# write the command that will modify the MTCARS8cyl so that two
# new columns are created called z_wt and z_mpg containing
# z scores of the wt and mpg data, respectively, for 8-cyl cars will be included.
MTCARS8cyl <- MTCARS8cyl %>%
  mutate(z_wt = scale(wt),
         z_mpg = scale(mpg))
MTCARS8cyl

# without using the filter or subset commands write the r commands for the 
# following subsets of mtcars
# all the data in the odd numbered columns
# all the mpg data for the 1st 16 rows

# a
mtcars[, seq(1,ncol(mtcars), by = 2), drop = FALSE]

# b
mtcars[1:16, "mpg", drop = FALSE]

# first 20 cars in a vector called MPG20 with MPG data
# first 20 cars in a vector called WT20 with weight data
# first 20 cars in a vector called AM20 with automatic transmission
# then create a new data frame with the new vectors weight in the first column then mpg then transmission
# show only the mpg data when printing the new data frame
MPG20 <- mtcars$mpg[1:20]
WT20 <- mtcars$wt[1:20]
AM20 <- mtcars$am[1:20]

# Creating a new data frame
data.frame(Weight = WT20, MPG = MPG20, Transmission = AM20)$MPG

# the box plot of the weight data for 8 cyl cars exhbit several outliers, including 
# the heaviest car amound them. explain how its an outlier by calculating upper fence
# using the 1.5 IQR rule

# fit a mlr model without interation that can be used to predict a cars weight
# based on mpg and the number of cyls with cyls treated as a categorial variable
# what are the estimates of beta coefficient of mpg and 6 cyl dummy variable?
# interpret these results
summary(lm(wt ~ mpg + as.factor(cyl), data = mtcars))


wt_pounds <- numeric(length(mtcars$wt))

# Loop through each element of mtcarsSwt and convert to pounds
for(i in 1:length(mtcars$wt)) {
  wt_pounds[i] <- mtcars$wt[i] * 1000  # Conversion from thousands of pounds to pounds
}

# Print the converted weights
print(wt_pounds)

is_outlier <- function(x) {
  
  Q1 <- quantile(x, 0.25)
  
  Q3 <- quantile(x, 0.75)
  
  IQR <- Q3 - Q1
    
    upper_limit <- Q3 + 1.5 * IQR
  
  
  
  max_val <- max(x)
  
  if (max_val > upper_limit) {
    
    print("Max is an outlier")
    
  } else {
    
    print("Max is not an outlier")
    
  }
  
}


is_outlier(mtcars$wt)

# Create a logical vector to identify 8-cylinder cars
is8cyl <- mtcars$cyl == 8

# Store weights of 8-cylinder cars in a new vector called wt_8cyl
wt_8cyl <- mtcars$wt[is8cyl]

# Calculate standard deviation of weights of 8-cylinder cars
sd_wt_8cyl <- sd(wt_8cyl)

# Interpret the standard deviation
cat("Standard Deviation of Weights of 8-cylinder cars:", sd_wt_8cyl)


# model <- lm(wt ~ mpg + as.factor(cyl), data = mtcars)
# 
# # Print the model summary
# summary(model)

qqnorm(mtcars$wt)
qqline(mtcars$wt)

# The social data (linkedin, facebook, views) has been created for you

# linkedin exceeds 10 but facebook below 10
linkedin > 10 & facebook < 10

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

# li_df is pre-loaded in your workspace

# Select the second column, named day2, from li_df: second
second <- li_df$day2

# Build a logical vector, TRUE if value in second is extreme: extremes
extremes <- second > 25 | second < 5

# Count the number of TRUEs in extremes
sum(extremes)

# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Examine the if statement for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
}

# Write the if statement for num_views
if (num_views > 15) {
  print("You are popular!")
}

# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else {
  print("Unknown medium")
}



# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else {
  print("Try to be more visible!")
}

# Variables related to your last day of recordings
li <- 15
fb <- 9

# Code the control-flow construct
if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
} else if (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- li + fb
}

# Print the resulting sms to the console
sms

# Initialize the speed variable
speed <- 64

# Code the while loop
while (speed > 30) {
  print("Slow down!")
  speed <- speed -7
}

# Print out the speed variable
speed

# Initialize the speed variable
speed <- 64

# Extend/adapt the while loop
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# Initialize the speed variable
speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))
  
  # Break the while loop when speed exceeds 80
  if (speed > 80) {
    break
  }
  
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for (li in linkedin) {
  print(li)
}

# Loop version 2
for (i in 1:length(linkedin)) {
  print(linkedin[i])
}

# temp has already been defined in the workspace

# Use lapply() to find each day's minimum temperature
lapply(temp, min)

# Use sapply() to find each day's minimum temperature
sapply(temp, min)

# Use lapply() to find each day's maximum temperature
lapply(temp, max)

# Use sapply() to find each day's maximum temperature
sapply(temp, max)

# The errors vector has already been defined for you
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)

# Sum of absolute rounded values of errors
sum(abs(round(errors)))

# Don't edit these two lines
vec1 <- c(1.5, 2.5, 8.4, 3.7, 6.3)
vec2 <- rev(vec1)

# Fix the error
mean(c(abs(vec1), abs(vec2)))

# The linkedin and facebook lists have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)

# Append fb_vec to li_vec: social_vec
social_vec <- append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing = TRUE)

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl("edu", emails)

# Use grep() to match for "edu", save result to hits
hits <- grep("edu", emails)

# Subset emails using hits
emails[hits]

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for .edu addresses more robustly
grepl("@.*\\.edu$", emails)

# Use grep() to match for .edu addresses more robustly, save result to hits
hits <- grep("@.*\\.edu$", emails)

# Subset emails using hits
emails[hits]

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "global@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use sub() to convert the email domains to datacamp.edu
sub("@.*\\.edu$", "@datacamp.edu", emails)

# Get the current date: today
today <- Sys.Date()

# See what today looks like under the hood
unclass(today)

# Get the current time: now
now <- Sys.time()

# See what now looks like under the hood
unclass(now)

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2)
date3 <- as.Date(str3, format = "%d/%B/%Y")

# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

# Generate 10 separate random flips with probability .3
rbinom(10, 1, 0.3)

# Generate 100 occurrences of flipping 10 coins, each with 30% probability
rbinom(100, 10, 0.3)

# Calculate the probability that 2 are heads using dbinom
dbinom(2, 10, .3)

# Confirm your answer with a simulation using rbinom
mean(rbinom(10000, 10, .3) == 2)

# Define parameters
p <- 0.45  # Probability of making a shot
n <- 30    # Number of shots attempted

# Calculate mean and standard deviation of the sample proportion
mean_proportion <- n * p
sd_proportion <- sqrt(n * p * (1 - p))

# a) Probability of making at least half of the shots
p_at_least_half <- 1 - pbinom(floor(n/2) - 1, n, p)
print(p_at_least_half)

# b) Probability of missing less than a quarter of the shots
p_less_than_quarter <- pbinom(ceiling(n/4) - 1, n, p)
print(p_less_than_quarter)

# c) Approximate distribution of the proportion of shots made
x_values <- seq(0, n, by = 1)
y_values <- dnorm(x_values, mean_proportion, sd_proportion)
plot(x_values, y_values, type = "l", main = "Approximate Distribution of Shots Made")


# Define parameters
a <- 0
b <- 36
mu <- (a + b) / 2

# Define PDF function for uniform distribution
pdf_uniform <- function(x, a, b) {
  ifelse(x >= a & x <= b, 1 / (b - a), 0)
}

# Calculate the definite integral from 0 to 15
integral_value <- integrate(pdf_uniform, lower = 0, upper = 15, a = a, b = b)$value
print(integral_value)

# Calculate the probability that at least five coins are heads
1 - pbinom(4, 10, .3)

# Confirm your answer with a simulation of 10,000 trials
mean(rbinom(10000, 10, .3) >= 5)

# Here is how you computed the answer in the last problem
mean(rbinom(10000, 10, .3) >= 5)

# Try now with 100, 1000, 10,000, and 100,000 trials
mean(rbinom(100, 10, .3) >= 5)
mean(rbinom(1000, 10, .3) >= 5)
mean(rbinom(10000, 10, .3) >= 5)
mean(rbinom(100000, 10, .3) >= 5)

# Calculate the expected value using the exact formula
25 * .3

# Confirm with a simulation using rbinom
mean(rbinom(10000, 25, .3))

# Calculate the variance using the exact formula
25 * .3 * (1 - .3)

# Confirm with a simulation using rbinom
var(rbinom(10000, 25, .3))

# Simulate 100,000 flips of a coin with a 40% chance of heads
A <- rbinom(100000, 1, .4)

# Simulate 100,000 flips of a coin with a 20% chance of heads
B <- rbinom(100000, 1, .2)

# Estimate the probability both A and B are heads
mean(A & B)

# You've already simulated 100,000 flips of coins A and B
A <- rbinom(100000, 1, .4)
B <- rbinom(100000, 1, .2)

# Simulate 100,000 flips of coin C (70% chance of heads)
C <- rbinom(100000, 1, 0.7)

# Estimate the probability A, B, and C are all heads
mean(A & B & C)

# Simulate 100,000 flips of a coin with a 60% chance of heads
A <- rbinom(100000, 1, 0.6)

# Simulate 100,000 flips of a coin with a 10% chance of heads
B <- rbinom(100000, 1, 0.10)

# Estimate the probability either A or B is heads
mean(A | B)

# Use rbinom to simulate 100,000 draws from each of X and Y
X <- rbinom(100000, 10, .6)
Y <- rbinom(100000, 10, .7)

# Estimate the probability either X or Y is <= to 4
mean(X <= 4 | Y <= 4)

# Use pbinom to calculate the probabilities separately
prob_X_less <- pbinom(4, 10, .6)
prob_Y_less <- pbinom(4, 10, .7)

# Combine these to calculate the exact probability either <= 4
prob_X_less + prob_Y_less - prob_X_less * prob_Y_less

# Simulate 100,000 draws of a binomial with size 20 and p = .1
X <- rbinom(100000, size = 20, prob = 0.1)

# Estimate the expected value of X
mean(X)

# Estimate the expected value of 5 * X
mean(5 * X)

# X is simulated from 100,000 draws of a binomial with size 20 and p = .1
X <- rbinom(100000, 20, .1)

# Estimate the variance of X
var(X)

# Estimate the variance of 5 * X
var(5 * X)

# Simulate 100,000 draws of X (size 20, p = .3) and Y (size 40, p = .1)
X <- rbinom(100000, size = 20, prob = 0.3)
Y <- rbinom(100000, size = 40, prob = 0.1)

# Estimate the expected value of X + Y
mean(X + Y)

# Simulation from last exercise of 100,000 draws from X and Y
X <- rbinom(100000, 20, .3) 
Y <- rbinom(100000, 40, .1)

# Find the variance of X + Y
var(X + Y)

# Find the variance of 3 * X + Y
var(3 * X + Y)

# Simulate 50000 cases of flipping 20 coins from fair and from biased
fair <- rbinom(50000, 20, .5)
biased <- rbinom(50000, 20, .75)

# How many fair cases, and how many biased, led to exactly 11 heads?
fair_11 <- sum(fair == 11)
biased_11 <- sum(biased == 11)

# Find the fraction of fair coins that are 11 out of all coins that were 11
fair_11 / (fair_11 + biased_11)

# Simulate 50000 cases of flipping 20 coins from fair and from biased
fair <- rbinom(50000, 20, .5)
biased <- rbinom(50000, 20, .75)

# How many fair cases, and how many biased, led to exactly 16 heads?
fair_16 <- sum(fair == 16)
biased_16 <- sum(biased == 16)

# Find the fraction of fair coins that are 16 out of all coins that were 16
fair_16 / (fair_16 + biased_16)

# Simulate 8000 cases of flipping a fair coin, and 2000 of a biased coin
fair_flips <- rbinom(8000, 20, .5)
biased_flips <- rbinom(2000, 20, .75)

# Find the number of cases from each coin that resulted in 14/20
fair_14 <- sum(fair_flips == 14)
biased_14 <- sum(biased_flips == 14)

# Use these to estimate the posterior probability
fair_14 / (fair_14 + biased_14)

# Simulate 80,000 draws from fair coin, 10,000 from each of high and low coins
flips_fair <- rbinom(80000, 20, .5)
flips_high <- rbinom(10000, 20, .75)
flips_low <- rbinom(10000, 20, .25)

# Compute the number of coins that resulted in 14 heads from each of these piles
fair_14 <- sum(flips_fair == 14)
high_14 <- sum(flips_high == 14)
low_14 <- sum(flips_low == 14)

# Compute the posterior probability that the coin was fair
fair_14 / (fair_14 + low_14 + high_14)

# Use dbinom to calculate the probability of 11/20 heads with fair or biased coin
probability_fair <- dbinom(11, 20, .5)
probability_biased <- dbinom(11, 20, .75)

# Calculate the posterior probability that the coin is fair
probability_fair / (probability_fair + probability_biased)

# Find the probability that a coin resulting in 14/20 is fair
dbinom(14, 20, .5) / (dbinom(14, 20, .5) + dbinom(14, 20, .75))

# Find the probability that a coin resulting in 18/20 is fair
dbinom(18, 20, .5) / (dbinom(18, 20, .5) + dbinom(18, 20, .75))

# Use dbinom to find the probability of 16/20 from a fair or biased coin
probability_16_fair <- dbinom(16, 20, .5)
probability_16_biased <- dbinom(16, 20, .75)

# Use Bayes' theorem to find the posterior probability that the coin is fair
(probability_16_fair * .99) / (probability_16_fair * .99 + probability_16_biased * .01)

# Simulations from the normal and binomial distributions
binom_sample <- rbinom(100000, 1000, .2)
normal_sample <- rnorm(100000, 200, sqrt(160))

# Use binom_sample to estimate the probability of <= 190 heads
mean(binom_sample <= 190)

# Use normal_sample to estimate the probability of <= 190 heads
mean(normal_sample <= 190)

# Calculate the probability of <= 190 heads with pbinom
pbinom(190, size = 1000, prob = 0.2)

# Calculate the probability of <= 190 heads with pnorm

pnorm(190, mean = 200, sd = sqrt(160))

# Draw a random sample of 100,000 from the Binomial(10, .2) distribution
binom_sample <- rbinom(100000, 10, .2)

# Draw a random sample of 100,000 from the normal approximation
normal_sample <- rnorm(100000, 2, sqrt(1.6))

# Compare the two distributions with the compare_histograms function
compare_histograms(binom_sample, normal_sample)

# Draw a random sample of 100,000 from the Binomial(1000, .002) distribution
binom_sample <- rbinom(100000, 1000, .002)

# Draw a random sample of 100,000 from the Poisson approximation
poisson_sample <- rpois(100000, 2)

# Compare the two distributions with the compare_histograms function
compare_histograms(binom_sample, poisson_sample)

# Simulate 100,000 draws from Poisson(2)
poisson_sample <- rpois(100000, 2)

# Find the percentage of simulated values that are 0
mean(poisson_sample == 0)

# Use dpois to find the exact probability that a draw is 0
dpois(0, 2)

# Simulate 100,000 draws from Poisson(1)
X <- rpois(100000, 1)

# Simulate 100,000 draws from Poisson(2)
Y <- rpois(100000, 2)

# Add X and Y together to create Z
Z <- X + Y

# Use compare_histograms to compare Z to the Poisson(3)
compare_histograms(Z, rpois(100000, 3))

# Simulate 100 instances of flipping a 20% coin
flips <- rbinom(100, size = 1, prob = 0.2)

# Use which to find the first case of 1 ("heads")
which(flips == 1)[1]

# Existing code for finding the first instance of heads
which(rbinom(100, 1, 0.2) == 1)[1]

# Replicate this 100,000 times using replicate()
replications <- replicate(100000, which(rbinom(100, 1, 0.2) == 1)[1])

# Histogram the replications with qplot
qplot(replications)

# Replications from the last exercise
replications <- replicate(100000, which(rbinom(100, 1, .2) == 1)[1])

# Generate 100,000 draws from the corresponding geometric distribution
geom_sample <- rgeom(100000, .2)

# Compare the two distributions with compare_histograms
compare_histograms(replications, geom_sample)

# Find the probability the machine breaks on 5th day or earlier
pgeom(4, .1)

# Find the probability the machine is still working on 20th day
1 - pgeom(19, .1)

# Calculate the probability of machine working on day 1-30
still_working <- 1 - pgeom(0:29, .1)

# Plot the probability for days 1 to 30
qplot(1:30, still_working)


