# Suppose a university official claims that 25% of all students are freshmen,
# 30% are sophomores, 30$ are juniors and 15% are seniors.
# We want to test this claim using the following randomly
# selected data: 275 freshmen, 303 sophomores, 286 juniors and 250 seniors.
# To do this formally, we perform a test of Ho:
# the distribution of students are as what the official claims vs.
# Ha: the distribution is different as claimed by the official.
# In R, we can use the chisq.test() function to perform this test as follows:

Obs <- c(275, 303, 286, 250) # This is the vector of observed counts
prob <- c(.25, .3, .3, .15) # This is the probability distribution in the null hypothesis
distrib.test <- chisq.test(Obs, p = prob, correct = FALSE) # set the continuity correction to FALSE, if the optional argument p= is omitted, the null hypothesis is that the data follows a uniform distribution
distrib.test

# Output
##
##  Chi-squared test for given probabilities
##
## data:  Obs
## X-squared = 51.036, df = 3, p-value = 4.807e-11

# Thus, since the p-value is small (< .05 or any reasonable significance level α),
# we should reject the null hypothesis and conclude that the
# data provide statistically significant evidence against the official’s claim.
# To verify the p-value, we use the pchisq() function as follows:

k <- 4 # number of categories
df <- k - 1 # degree of freedom for the chi-squared distribution
pval <- pchisq(51.036, df, lower.tail = FALSE)
pval

# Output
## [1] 4.806448e-11

#  display the table of expected counts

distrib.test$expected

# Output
## [1] 278.5 334.2 334.2 167.1

# Test of Association

smoke <- c(rep("yes", 30), rep("no", 70))
cancer <- c(rep("yes", 20), rep("no", 60), rep("yes", 20))
smoke

# summarize the data in a contingency or two-way table stored as a matrix as follows

M <- table(smoke, cancer) # the data must be stored in a matrix containing the observed counts
M

# we test Ho:
# Smoking and cancer have no association vs. Ha:
# Smoking and cancer have an association.
# To do this, we use the chisq.test() function in R as follows:

sc.test <- chisq.test(M, correct = FALSE) # set correct to FALSE for no continuity correction
sc.test

# To verify the p-value calculation, we use the pchisq() function.

r<-2  #number of rows or number of categories for the smoke variable
c<-2  #number of columns or number of categoriesfor the cancer variable
df<-(r-1)*(c-1)
pval<-pchisq(12.698,df,lower.tail = FALSE)
round(pval,6)  #round to 6 decimals

# To verify this, we display the table of expected counts when Ho is true:
sc.test$expected

# 2-Sample z-test for Difference in 2 Population Proportions
p1hat<-20/70
p2hat<-20/30
n1<-70
n2<-30
phat<-40/100
z<-(p1hat-p2hat)/sqrt(phat*(1-phat)*(1/n1+1/n2))
pvalue.left.tailed<-pnorm(z,0,1)
pvalue.right.tailed<-pnorm(z,0,1,lower.tail=FALSE)
pvalue.two.tailed<-2*min(pvalue.left.tailed,pvalue.right.tailed)
pvalue.two.tailed

