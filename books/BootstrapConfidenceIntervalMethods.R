xbar.star <- numeric(10000)
xbars <- numeric(10000)
CL <- .95
alpha <- 1 - CL
n <- 10 # sample size
mu <- 2.8 # population mean
sigma <- 0.3 # population standard deviation
set.seed(300) # remove this line to get different randomly generated data every time the code is executed
orig.sample <- rnorm(n, mu, sigma) # original sample
xbar <- mean(orig.sample)
s <- sd(orig.sample)
for (i in 1:10000)
{
    resamp <- sample(orig.sample, n, replace = TRUE)
    samp <- rnorm(n, mu, sigma)
    xbars[i] <- mean(samp)
    xbar.star[i] <- mean(resamp)
}

lower.1t <- xbar - abs(qt(alpha / 2, n - 1)) * s / sqrt(n)
upper.1t <- xbar + abs(qt(alpha / 2, n - 1)) * s / sqrt(n)
c(lower.1t, upper.1t)

boot.sd <- sd(xbar.star)
lower.se <- xbar - abs(qt(alpha / 2, n - 1)) * boot.sd # lower limit for Bootstrap SE Method
upper.se <- xbar + abs(qt(alpha / 2, n - 1)) * boot.sd # upper limit for Bootstrap SE Method  Interval Method 1
c(lower.se, upper.se)

lower.percentile <- quantile(xbar.star, alpha / 2) # lower limit for Bootstrap Percentile Method
upper.percentile <- quantile(xbar.star, 1 - alpha / 2) # upper limit for Bootstrap Percentile Method
c(lower.percentile, upper.percentile)

hist(xbars)

hist(xbar.star)

phat.star <- numeric(10000)
phats <- numeric(10000)
CL <- .95
alpha <- 1 - CL
n <- 100 # sample size
p <- 0.7 # population proportion

set.seed(300) # remove this line to get different randomly generated data every time the code is executed
orig.sample <- rbinom(n, 1, p) # original sample
phat <- mean(orig.sample) # sample proportion
for (i in 1:10000)
{
    resamp <- sample(orig.sample, n, replace = TRUE)
    samp <- rbinom(n, 1, p)
    phats[i] <- mean(samp)
    phat.star[i] <- mean(resamp)
}

lower.1z <- phat - abs(qnorm(alpha / 2)) * sqrt(phat * (1 - phat) / n)
upper.1z <- phat + abs(qnorm(alpha / 2)) * sqrt(phat * (1 - phat) / n)
c(lower.1z, upper.1z)

boot.sd <- sd(phat.star)
lower.se <- phat - abs(qnorm(alpha / 2)) * boot.sd # lower limit for Bootstrap SE Method
upper.se <- phat + abs(qnorm(alpha / 2)) * boot.sd # upper limit for Bootstrap SE Method
c(lower.se, upper.se)

lower.percentile <- quantile(phat.star, alpha / 2) # lower limit for Bootstrap Percentile Method
upper.percentile <- quantile(phat.star, 1 - alpha / 2) # upper limit for Bootstrap Percentile Method
c(lower.percentile, upper.percentile)

hist(phats)

hist(phat.star)

median.star <- numeric(10000)
CL <- .95
alpha <- 1 - CL
n <- 10 # sample size
mu <- 2.8 # population mean
sigma <- 0.3 # population standard deviation
set.seed(300) # remove this line to get different randomly generated data every time the code is executed
orig.sample <- rnorm(n, mu, sigma) # original sample
for (i in 1:10000)
{
    resamp <- sample(orig.sample, n, replace = TRUE)
    median.star[i] <- median(resamp)
}

lower.percentile <- quantile(median.star, alpha / 2) # lower limit for Bootstrap Percentile Method
upper.percentile <- quantile(median.star, 1 - alpha / 2) # upper limit for Bootstrap Percentile Method
c(lower.percentile, upper.percentile)
hist(median.star)
