# Central Limit Theorem (Distribution of the sample mean) Problems 1.
# IQ scores are known to be normally distributed with a mean of 100 and
# a standard deviation of 15. If 36 individuals are randomly selected,
# what is the probability that their average IQ score is at least 105?
# mu = 100 sigma = 15 n = 36 >= 30 implies the
# sampling distribution of the sample mean X¯
# is approximately Normal with mean 100 and a standard deviation of

15 / sqrt(36)

# P(X¯>=105) =
1 - pnorm(105, 100, 2.5)

# 2) Test scores in one large Stats class have a mean of 75 and a
# standard deviation of 8. If 50 students from that class are randomly selected,
# what is the probability that their average test score is below 70?
# μ=75 σ=8 n=50 >= 30 implies from the CLT that the sampling distribution of
# the sample mean test score X¯ is approximately Normal with mean 75 and
# standard deviation
8 / sqrt(50)

# P(X¯<70) =
pnorm(70, 75, 1.131371)

# Central Limit Theorem for Binomial Data (Distribution of the sample proportion) Problems

# 1) 60% of students in one large university are females. If 200 students are randomly
# selected, what is the probability that at least 50% are females?
# p=0.6 n=200 np = 200 x 0.6 = 120 >= 10 and n(1-p) = 200 x 0.4 = 80 >= 10
# Since np and n(1-p) are both at least 10, then from the CLT for Binomial Data,
# the sampling distribution of the sample proportion of female students p^
# is approximately Normal with mean 0.6 and standard deviation
sqrt(0.6 * 0.4 / 200)

# $P( >= 0.5) = $
1 - pnorm(0.5, 0.6, .03464102)

# 2) A fair coin is flipped 100 times.
# What is the probability that at least 60 of the flips are heads?
# p = 0.5 n = 100 np = 100 * .5 = 50 >= 10 and n(1-p) = 100 * 0.5 = 50 >= 10
# Since np and n(1-p) are both at least 10, the CLT for Binomial data implies
# the sampling distribution of the sample proportion of heads p^
# is approximately Normal with mean 0.5 and a standard deviation of
sqrt(0.5 * 0.5 / 100)

# $P( >= 0.6) = $
1 - pnorm(0.6, 0.5, .05)
