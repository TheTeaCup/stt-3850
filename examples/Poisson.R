# If there are twelve cars crossing a bridge per minute on average,
# find the probability of having seventeen or more cars crossing the bridge 
# in a particular minute. 

# The probability of having sixteen or less cars crossing the bridge in a
#  particular minute is given by the function ppois. 
ppois(16, lambda=12)   # lower tail

# Hence the probability of having seventeen or more cars crossing 
# the bridge in a minute is in the upper tail of the probability density function. 
ppois(16, lambda=12, lower=FALSE)   # upper tail 