# Stats Quizzes

# Quiz 1
# Let GPA be an R numeric vector of length 100 consisting of
# the gpa of 100 students and let CLASS be an R text vector
# consisting of their classes
# (i.e., whether they are freshman, sophomore, junior or senior)

# a) What is the R command needed to store the
# GPAs of the last 50 students into a new vector named GPA_Last50?
GPA_Last50 <- GPA[51:100]

# b) What is the R command for constructing a
# data frame named STUDENT containing the gpa
# and class data of the 100 students?
STUDENT <- data.frame(GPA, CLASS)

# c) What is the R command needed to display the
# gpa and class of the 1st and last student in
# the STUDENT data frame?
STUDENT[c(1, 100), ]

# Quiz 2
# Let STUDENT be an R data frame containing the
# character vector CLASS consisting of the classes
# (i.e., whether they are freshman, sophomore, junior or senior)
# of an unspecified number of students in the first column
# and the numeric vector GPA consisting of their gpa
# in the 2nd column.

# a) What is the R command needed to display just the
# number of rows and number of columns in the STUDENT data frame?
# What does the number of rows represent?
dim(STUDENT)

# b) What is the R command for storing the contents
# of the CLASS vector as an ordered factor with the
# order freshman < sophomore < junior < senior?
CLASS_factor <- factor(CLASS, ordered = TRUE, levels = c("freshman", "sophomore", "junior", "senior")) # nolint: line_length_linter.

# c) Create a logical vector that will identify which students
# are freshman and use it to display the gpa of all
# freshman in the STUDENT data frame.
is_freshman <- STUDENT$CLASS == "freshman"
STUDENT$GPA[is_freshman]

# Quiz 3
# a) Write the ggplot command for creating the
# side-by-side boxplots of sepal widths (Sepal.Width)
# by species (Species). Which specie has the lowest sepal width?
library(ggplot2)
ggplot(iris, aes(y = Sepal.Width, x = factor(Species))) +
    geom_boxplot()
# versicolor has the lowest sepal width, on average.

# b) Write the ggplot command for creating the scatterplot
# of the peatl width (Petal.Width) vs. petal length (Petal.Length)
# with petal length in the x-axis.
# Store the result of executing this command in an
# R object called IRIS_graph.
IRIS_graph <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
    geom_point()
IRIS_graph

# c) Modify IRIS_graph by adding the title:
# Figure 1. Scatterplot of Petal Width vs Petal Length
# and changing the x-axis label to LENGTH and
# the y-axis label to WIDTH.
IRIS_graph <- IRIS_graph + ggtitle("Figure 1. Scatterplot of Petal Width vs. Petal Length") + xlab("LENGTH") + ylab("WIDTH")
IRIS_graph

# Quiz 4
# a) Write the dplyr command for creating a new 100 by 3
# data frame called iris2 that will just contain the
# Petal.Length, Petal.Width and Species data for the
# setosa and versicolor species
# (i.e., iris2 must have 100 rows and 3 columns).
library(dplyr)
iris2 <- iris %>%
    filter(Species == "setosa" | Species == "versicolor") %>%
    select(Petal.Length, Petal.Width, Species)

# b) Write the dplyr command that will group the iris2
# data by Species and then will calculate the IQR of
# Petal.Length for the two species in this data frame.
# Based on the IQR, which of the two species has a
# smaller Petal.Length spread or variability?
iris2 %>%
    group_by(Species) %>%
    summarize(IQR = IQR(Petal.Length))
# setosa has a smaller petal length spread based on the smaller IQR.

# c) Write the ggplot command that will create a side by
# side histograms of the Petal.Length by species in the
# iris2 data frame. Which specie has a Petal.Length distribution
# that is more skewed and identify if its distribution is
# right-skewed or left-skewed?
ggplot(iris2, aes(x = Petal.Length)) +
    geom_histogram(color = "white") +
    facet_wrap(iris2$Species)
# versicolor is more skewed and it is left-skewed.

# Quiz 5
# a) Consider the mtcars data frame available in RStudio.
# Based on its qqnorm plot, are the mpg data
# normally distributed? Explain.
qqnorm(mtcars$mpg)
# Since there is a slight curving trend instead of a
# straight line pattern in the qqnorm plot of the mpg data,
# the data are not normally distributed.

# 2) Consider the mtcars data frame available in RStudio.
# Use the 1.5 IQR Rule to determine if the car with the
# maximum mpg is an outlier or not.
# State the mpg of this car and explain why this is or
# not an outlier based on the 1.5 IQR Rule.
upper_fence <- quantile(mtcars$mpg, 0.75) + 1.5 * IQR(mtcars$mpg)
max(mtcars$mpg)
upper_fence
max(mtcars$mpg) > upper_fence
# Since the maximum mpg of 33.9 is higher than the upper
# fence of 33.8625, this is an outlier based on the
# 1.5 IQR Rule.

# Suppose IQ scores in the general population are normally
# distributed with a mean of 100 and a standard deviation of 15.
# If a person with an IQ score is considered a genius,
# what percent of the general population are considered
# genius based on the Empirical Rule?

# 130 is 2 standard deviations above the mean.
# Since IQ scores are normally distributed,
# the Empirirical Rule predicts that about 95% of all IQ scores
# are expected to fall within 2 standard deviations of
# the mean, i.e., about 95% of IQ scores are within
# the interval (70,130). This means about 5% of all
# IQ scores are expected to be outside this interval
# and because of the symmetry of the Normal distribution,
# this means that about 2.5% of the general population are
# considered genius.

# Quiz 6
# a) Among the three other numeric variables in the iris
# data frame, identify the single best predictor of
# sepal length. Explain why this is the best predictor.
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris$Petal.Length, iris$Sepal.Length)
cor(iris$Petal.Width, iris$Sepal.Length)
plot(iris$Sepal.Width, iris$Sepal.Length)
plot(iris$Petal.Length, iris$Sepal.Length)
plot(iris$Petal.Width, iris$Sepal.Length)
#  Based on the correlation coefficients and the scatterplots
# of the Sepal Length vs the other variables (separately),
# it appears that Petal Length is the best predictor of
# Petal Length since it has the highest correlation and
# the scatterplot appears to have the strongest linear
# relationship.

# b) Fit a simple linear regression model (SLRM)
# that can be used to predict the sepal length based
# on the identified predictor in part a. Display and
# interpret the values of the estimate of the slope,
# the residual standard error and R-squared in context
# of the iris data.
model1 <- lm(Sepal.Length ~ Petal.Length, data = iris)
summary(model1)
# The estimate of the slope is 0.40892 which indicates
# that every 1 cm increase in petal length is expected
# to result in an increase of 0.40892 cm in sepal length.
# The residual standrd error is 0.4071 cm which
# is the expected average prediction error if the model
# is used to predict sepal length based on petal
# length of iris flowers.
# The R-squared is 0.76 which means 76% of the variation
# in sepal lengths of iris flowers is explained by their
# petal lengths.

# c) How many standard deviations away is the maximum
#  sepal length from the mean sepal length?
z_max <- (max(iris$Sepal.Length) - mean(iris$Sepal.Length)) / sd(iris$Sepal.Length)
max(iris$Sepal.Length)
z_max
# The maximum sepal length of from the mean sepal
# length of 7.9 cm is about 2.4837 standard deviations
# above the mean sepal length.

# Quiz 7
# a) Fit an interaction model that can be used to predict
# the cars’ mpg based on its weight and transmission type (am).
# What is the expected change in mpg per 1000 pound increase
# in a car’s weight for cars with automatic transmission?
model2 <- lm(mpg ~ wt * am, data = mtcars)
summary(model2)

# In the model y=β0+β1X1+β2X2+β3X1X2+ϵ where y= mpg,
# X1= weight in thousands of pounds,
# X2 = am (transmission type where manual = 1 and automatic = 0),
# the rate of change of y per unit increase in X1 for a
# given value of X2 is in general given by ∂y∂X1=β1+β3X2.
# So for a car with automatic transmission (X2=0 so the rate
# of change is just the estimate of β1), the rate of change
# of mpg per 1000 pound increase in car’s weight is -3.7859.
# That is, a 1000 pound increase in a car’s weight is expected
# to result in a decrease of 3.7859 mpg for cars with automatic
# transmission.

# b) Fit a no interaction model that can be used to predict
# the cars’ mpg based on its weight and transmission type (am).
# What is the expected difference in mpg for cars with manual
# transmission relative to cars with automatic transmission
# that have the same weight?
model3 <- lm(mpg ~ wt + factor(am), data = mtcars)
summary(model3)
# This is a model with a categorical predictor without interaction so the model is y=β0+β1X1+β2X2+ϵ where y= mpg, X1= weight in thousands of pounds and X2 = am (am = 1 for cars with manual transmission and 0 otherwise so here automatic transmission is the baseline category).

31.4161 + (-3.7859) * 2
# Based on the residual standard error and R-squared, the interaction model appears to be the better model. From this model the predicted mpg for a car with a given weight X1

# Quiz 8
# a) Write an R code with a for loop that will convert
# each of the elements of the mtcars$wt vector from thousands
# of pound to pounds within the loop and will store the
# converted weight data in a new vector called wt_pounds.
wt_pounds <- numeric()
n <- length(mtcars$wt)
for (i in 1:n) {
    wt_pounds[i] <- mtcars$wt[i] * 1000
}

# b) Write a function in R that will determine if the
# maximum value of a generic vector x is an outlier based on
# the 1.5 IQR rule. The function should have a generic
# vector x as input and should display “Max is an outlier”
# if the maximum value of x is an outlier. Otherwise,
# if the maximum value of x is not an outlier, the function
# should display “Max is not an outlier”. Test this function
# using the mtcars$wt vector.
ismax.outlier <- function(x) {
    if (max(x) > quantile(x, 0.75) + 1.5 * IQR(x)) print("Max is an outlier") else print("Max is not an outlier")
}

ismax.outlier(mtcars$wt)

# c) Construct the contingency table for the mtcars am and cyl
# variables. Based on this table, what is the
# probability of randomly selecting
table(mtcars$am, mtcars$cyl)

# c.a) an 8-cylinder car?
14 / 32

# c.b) an 8-cylinder car with a manual transmission?
2 / 32

# c.c) an 8-cylinder car given that the car has manual transmission?
2 / 13

# c.d) an 8-cylinder or a car with manual transmission?
14 / 32 + 13 / 32 - 2 / 32

# Quiz 9
# 1) A basketball player can make his shots 45% of the time.
# Assuming shots are independent, in a game where the
# player attempts 20 shots, what is the probability that

# a) he makes exactly half of his attempts?
# Let X = number of shots the player makes out of 20 attempts.
# If the shots are independent, it follows that X has a
# Binomial distribution with parameters n = 20 and
# p = P(making a shot for each attempt).
# P(X = 10) is given by
dbinom(10, 20, 0.45)

# b) he makes at least half of his shots?
# P(X ≥ 10) = 1 - P(X ≤ 9) which is calculated as
1 - pbinom(9, 20, 0.45)

# c) he misses less than 5 shots?
# P(he misses less than 5 shots) =
# P(he makes at least 16 shots) = P(X ≥ 16) = 1 - P(X ≤ 15)
# and is calculated as
1 - pbinom(15, 20, 0.45)

# d) How many shots is he expected to make in that
# game and what is the standard deviation?
20 * 0.45

# Its standard deviation,
# denoted by SD(X) is given by np(1−p)−−−−−−−−√ equal to
sqrt(20 * 0.45 * (1 - 0.45))

# 2) Length of stay in a hospital by a randomly
# selected patient is uniformly distributed over the
# interval 0 to 36 hours.

# a) Write the definite integral for the probability
# that a randomly selected patient from that hospital
# stays under 12 hours?
# Let X = length of hospital stay by a randomly selected
# patient. X has a uniform distribution over the
# interval (0,36) so its pdf is given by f(x)=1/36
# if x is in the interval (0,36) and is 0 otherwise.
12 / 36

# c) Draw a graph of the pdf of the random variable
# representing the length of stay of a randomly selected
# patient from that hospital and represent the probability
# in part a by shading an appropriate area.
x <- seq(0, 36, .01)
n <- length(x)
f <- rep(1 / 36, n)
df <- data.frame(x, f)
library(ggplot2)
ggplot(df, aes(x = x, y = f)) +
    geom_point() +
    geom_segment(x = 12, y = 0, xend = 12, yend = 1 / 36) +
    annotate("rect", xmin = 0, xmax = 12, ymin = 0, ymax = 1 / 36)

# d) What is the probability that a randomly
# selected patient from that hospital stays exactly 2 days?
# Since X is a continuous random variable, P(X = 2) = 0

# e) What is the expected length of the hospital stay
# of a randomly selected patient from that hospital and
# what is its standard deviation?
# E(X) is (a+b)/2 which is
(0 + 36) / 2

# SD(X) is
sqrt((36 - 0)^2 / 12)

# Quiz 10
# 1) A basketball player made can make his shots 45% of the
# time Assuming shots are independent, in a game where
# the player attempts 30 shots, use the CLT for Proportions
# to approximate the probability that

# a) he makes at least half of his shots.
sqrt(0.45 * 0.55 / 30)

# Hence, P(p^≥0.5) is equal to
1 - pnorm(0.5, 0.45, .09082951)

# b) he misses less than a quarter of his shots.
1 - pnorm(0.75, .45, .09082951)

# c) What is the approximate distribution of the
# proportion of shots the player makes?
# N(0.45, .09082951)

# 2) Length of stay in a hospital by a randomly selected
# patient is uniformly distributed over the
# interval 0 to 36 hours. If 100 patients from that hospital
# are randomly selected,

# a) write the definite integral for the probability
# that mean hospital stay of the sample is under 15 hours.
sqrt((36 - 0)^2 / 12) / sqrt(100)

# b) Calculate the numerical value of the integral in part a.
pnorm(15, 18, 1.03923)

# c) Calculate the probability that the mean hospital stay of the smaple is anywhere from 15 to 18 hours.
pnorm(18, 18, 1.03923) - pnorm(15, 18, 1.03923)

# What is the approximate distribution of the
# mean hospital stay of the sample?
# N(18, 1.03923)

# Quiz 11
# 1) A basketball player made 14 out of 30 shots in one game.
# Assuming these shots can be viewed as a random sample of
# the player’s shots,

# a) obtain and interpret a 90% confidence interval
# estimate of this player’s true field goal percentage
# (field goal percentage is the percent of the shots the
# player is expected to make).
prop.test(14, 30, conf.level = .9, correct = FALSE)
# We are 90% confident that the player’s true field goal percentage is anywhere from 32.59% to 61.29%.

# b) Calculate and interpret the margin of error of
# the estimate in part (a)?
# The margin of error is 14.98% calculated as follows:
CL <- .9
alpha <- 1 - CL
n <- 30
phat <- 14 / 30
abs(qnorm(alpha / 2) * sqrt(phat * (1 - phat) / n)) * 100

# c) Suppose someone thinks the margin of error in part
# (b) is too large. What sample size is needed to
# reduce this margin of error to 2% using the same
# confidence level? Use the sample proportion from the given
# data in calculating the sample size.
(qnorm(alpha / 2) / .02)^2 * phat * (1 - phat)
# Thus, the sample size needed is 1684.

# 2) Consider the 150 flowers in the iris dataset as a
# random sample of the population of all iris flowers.

# a) Obtain and interpret a 90% confidence interval
# estimate of the mean petal length of all iris flowers
# based on the iris dataset.
t.test(iris$Petal.Length, conf.level = .9)
# We are 90% confident that the mean petal length of all
# iris flowers is anywhere from 3.519 cm to 3.997 cm.

# b) What is the margin of error of the estimate in part (a)?
n <- length(iris$Petal.Length)
s <- sd(iris$Petal.Length)
abs(qt(alpha / 2, df = n - 1)) * s / sqrt(n)

# c) Suppose someone thinks the margin of error in part (b)
# is still too large. What sample size is needed to reduce
# this margin of error to 0.15 cm? Use the iris dataset to
# get an estimate of the standard deviation σ of the petal
# length of all iris flowers needed in calculating the sample
# size.
(qnorm(alpha / 2) * s / .15)^2
# Thus, a sample of 375 iris flowers is needed.

# d) If 150 iris flowers are randomly selected a
# thousand times and 90% confidence interval estimates
# of the mean petal length are obtained from each of these 1000
# random samples of 150 iris flowers, about how many of these
# interval estimates are expected to contain the true mean
# petal length of all iris flowers?
0.90 * 1000

# Quiz 12
# A basketball player made his first 2 shots and
# missed his last 3 shots. Assuming these shots can
# be viewed as a random sample of the player’s shots,
# we can store this data in an R vector called Orig.sample
# as follows: Orig.sample <- c(1,1,0,0,0) where a 1 means
# the player made the shot and a 0 meand the player missed
# the shot.

# a) Write the R code that will obtain a Bootstrap resample
# from this data and store the resample in a new vector call
# Boot.sample. Display the elements of this new vector
# Boot.sample and display the value of the sample proportion
# of shots made from this resample.
Orig.sample <- c(1, 1, 0, 0, 0)
n <- length(Orig.sample)
Boot.sample <- sample(Orig.sample, n, replace = TRUE)
Boot.sample
mean(Boot.sample)

# b) Suppose the values of the sample proportion from
# 10 Bootstrap resamples are stored in a new vector call
# phat.boot as follows:
# phat.boot <- c(0,.4, .2, .4, .2, .4, .6, .4, .4,.4).
# If phat.boot is treated as the Bootstrap distribution
# of the sample proportion p^, obtain and interpret an
# 80% confidence confidence interval estimate of the player’s
# true field goal percentage (field goal percentage is the
# percent of the shots the player is expected to make)
# using the Bootstrap percentile confidence interval method.
phat.boot <- c(0, .4, .2, .4, .2, .4, .6, .4, .4, .4)
CL <- .8
alpha <- 1 - CL
lower <- quantile(phat.boot, alpha / 2)
upper <- quantile(phat.boot, 1 - alpha / 2)
c(lower, upper)

# We are 80% confident that the player’s true
# field goal percentage is anywhere from 18% to 42%.

# c) Repeat part b but use the Bootstap standard
# error confidence interval method.
n <- length(Orig.sample)
boot.sd <- sd(phat.boot)
lower <- mean(Orig.sample) - abs(qt(alpha / 2, df = n - 1)) * boot.sd
upper <- mean(Orig.sample) + abs(qt(alpha / 2, df = n - 1)) * boot.sd
c(lower, upper)
# We are 80% confident that the player’s true
# field goal percentage is anywhere from 14.76% to 65.24%.

# Quiz 13
# 1) A basketball player made 14 out of 30 shots in one game.
# Assuming these shots can be viewed as a random sample of
# the player’s shots, test the claim that the player’s true
# field goal percentage p is less than 50% at the 5% level
# of significance. Make sure you write all the 5 steps of
# a hypothesis test in your solution.
# Explain why this test is reliable.
prop.test(14, 30, p = 0.5, alternative = "less", correct = FALSE)
sqrt(.1333)

# Solution:
# Step 1. Ho: p = 0.5 Ha: p < 0.5
# Step 2. z = -.3651
# Step 3. p-value = .3575
# Step.4 Since p-value > .05, we fail to reject Ho.
# Step 5. The data do not provide sufficient
# evidence that the player’s true field goal
# percentage is less than 50%.
# To verify the prop.test results:
phat <- 14 / 30
n <- 30
p0 <- 0.5
z <- (phat - p0) / sqrt(p0 * (1 - p0) / n)
pval <- pnorm(z)
z
pval
n * p0
n * (1 - p0)
# They’re both at least 10 so the test should be reliable.

# 2) Consider the 150 flowers in the iris dataset as
# a random sample of the population of all iris flowers.
# Use this data to test the claim at the 2% level of
# significance that the average petal length of the
# versicolor specie is less than the average petal
# length of the virginica specie. Make sure you write
# all the 5 steps of a hypothesis test in your solution.
# Explain why this test is reliable.
vers <- iris$Petal.Length[iris$Species == "versicolor"]
virg <- iris$Petal.Length[iris$Species == "virginica"]
n1 <- length(vers)
n2 <- length(virg)
n1
n2
vers
virg
t.test(vers, virg, alternative = "less")
# μ1 = mean petal length of all versicolor specie μ2
# = mean petal length of all virginica specie
# Step 1: H0: μ1=μ2
# Ha: μ1<μ2
# Step 2: t = -12.604
# Step 3. p-value < 2.2e-16
# Step 4. Since p-vale < .02, we reject H0.
# Step 5. The data provide sufficient evidence that
# the mean petal length for all versicolor specie is
# less than the mean petal length for the virginica specie.
# The test is reliable since the sample sizes are both
# at least 30 and the samples are assumed to be randomly
# selected.

# 3) Consider the mtcars data set as a random sample
# of all cars. Use this data to test the claim that
# transmission type (am) and number of cylinders (cyl)
# are not associated. Make sure you write all the 5 steps
# of a hypothesis test in your solution. Explain why the
# result says Chi-squared approximation may be incorrect
# (that is, why is the chi-squared test in this case is
# not reliable).
M <- table(mtcars$am, mtcars$cyl)
M
test.result <- chisq.test(M, correct = FALSE)
test.result
# Step 1. Ho: Transmission type and number of cylinders
# in cars are not associated/related
# (i.e., they are independent)
# Ha: Transmission type and number of cylinders in
# cars are associated/related (i.e., they are dependent)
# Step 2: χ2 = 8.7407
# Step.3. p-value = 0.01265
# Step 4. Since p-value < .05, we reject Ho.
# Step 5. The data provide sufficient evidence
# that the two variable are associated.
test.result$expected
# Since some of the expected cell counts when
# Ho is true are less than 5, the test is not
# reliable because the sample size is not large enough.
