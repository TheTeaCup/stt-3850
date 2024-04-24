# Central Limit Theorem for Binomial Data

# When the data is not numerical, the Central Limit Theorem
# for the distribution of the sample mean X¯
# can not be applied since it does not make sense to
# calculate the mean of a non-numerical variable.
# For a special type of non-numerical data called Binomial or binary data we
# can use the Central Limit Theorem for Binomial Data.
# A variable is said to be a Binomial or binary variable if it takes on two possible values.
# These kinds of variables are often coded using 0s and 1s.
# If an individual has the trait of interest (say being an in-state student for example),
# that individual will be assigned a value of 1 and an individual who does not
# have the trait of interest will be assigned a value of 0.
# The CLT for Binomial Data says if samples of size n
# are repeatedly selected randomly from a population with a proportion
# p having the trait of interest, then the sampling distribution of
# the sample proportion p^ of individuals in the sample having the trait of
# interest will be approximately Normal with mean equal to the population proportion
# p and standard deviation equal to p(1−p)/n−−−−−−−−−√ if the sample size n
# is sufficiently large which in this situation means np≥10 and n(1−p)≥10.
# To illustrate this result, we will use the following function:
sampling.distrib <- function(x, n, m)
                             # This function obtains the approximate sampling distribution of the statistic tstat
# when m random samples of size n are repeatedly selected from the population x
{
    tstat <- vector() # initialize the vector
    for (i in 1:m) # loop for sampling from the population m times (m <=5000 is required for qqplot)
    {
        sample.data <- sample(x, n) # randomly sample n individuals form the population x
        tstat[i] <- length(which(sample.data == 1)) / length(sample.data) # calculate the value of the sample proportion of individuals who have the trait of interest from the sample
    }
    return(tstat) # returns the approximate sampling
    # distribution of tstat
}

# Let’s illustrate the CLT for Binomial Data with an example.
# Suppose we have a large university where it is known that 70% of all the students
# are in-state students. If we randomly sample 100 students,
# the sampling distribution of the sample proportion p^ of in-state students
# in the sample is represented by the histogram below which is approximated
# by a Normal density curve with a mean of p=0.7 and standard deviation of sd.phat
# calculated below:
p <- .7
pop <- rbinom(10000, 1, p)
# hist(pop)
n <- 100
m <- 10000
phat <- sampling.distrib(pop, n, m)
sd.phat <- sqrt(p * (1 - p) / n)
sd.phat

x <- seq(min(phat), max(phat), by = .01) # define the x-axis scale
y <- phat
hist(y, main = "Hist of Phat", xlab = "y", ylab = "density/frequency")
par(new = TRUE) # signifies that a new plot will be added to the current plot
plot(x, dnorm(x, p, sd.phat), axes = F, type = "l", col = "blue", xlab = "y", ylab = "density/frequency") # plot the N(mean,sd) density function

par(new = F) # new plot will be created in a new plotting area

# That is, the distribution of all the values of p^ obtained from repeatedly
# sampling 100 students from the university is represented by the above histogram
# which is adequately approximated by the N(0.7,.0458) density curve (the blue curve).
# As an application of the CLT for Binomial Data, we can approximate, for example,
# the probability of randomly sampling 100 students and getting at least 75% of
# them being in-state as follows:
1 - pnorm(0.75, p, sd.phat)

# Since np>=10 and n(1−p)>=10, the sample size n can be considered
# sufficiently large for this number to be considered a reasonable approximation to
length(which(phat >= .75)) / length(phat)

# In general, the larger the sample size n, the more accurate the Normal approximation
