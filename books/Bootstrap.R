sim.means <- numeric(10000)
boot.means <- numeric(10000)
n <- 100 # sample size
mu <- 2.8 # population mean
sigma <- 0.3 # population standard deviation
set.seed(300) # remove the # symbol to get the same randomly generated data every time the code is executed
orig.sample <- rnorm(n, mu, sigma) # original sample
for (i in 1:10000)
{
    x <- rnorm(n, mu, sigma) # sample the population
    resamp <- sample(orig.sample, n, replace = TRUE)
    sim.means[i] <- mean(x)
    boot.means[i] <- mean(resamp)
}
par(mfrow = c(1, 2))
hist(sim.means, main = "Simulated", xlab = "means")
hist(boot.means, main = "Bootstrap", xlab = "means")

mean(orig.sample)
mean(orig.sample)
mean(boot.means)
sd(sim.means)
sd(boot.means)

sim.medians <- numeric(10000)
boot.medians <- numeric(10000)
# set.seed(300)
orig.sample <- rnorm(n, mu, sigma)
for (i in 1:10000)
{
    x <- rnorm(n, mu, sigma)
    resamp <- sample(orig.sample, n, replace = TRUE)
    sim.medians[i] <- median(x)
    boot.medians[i] <- median(resamp)
}
par(mfrow = c(1, 2))
hist(sim.medians, main = "Simulated", xlab = "medians")
hist(boot.medians, main = "Bootstrap", xlab = "medians")
mean(orig.sample)
mean(sim.medians)
mean(boot.medians)
sd(sim.medians)
sd(boot.medians)
