
# in class quiz
Orig.sample <- c(1,1,0,0,0)
bootstrap_sample <- sample(Orig.sample, replace = TRUE)

# Display the elements of the bootstrap sample
print(bootstrap_sample)

# Calculate the sample proportion of shots made in the bootstrap sample
sample_proportion <- mean(bootstrap_sample)
print(sample_proportion)

phat.boot <- c(0, 0.4, 0.2, 0.4, 0.2, 0.4, 0.6, 0.4, 0.4, 0.4)
# if phat.boot is treated as the bootstrap distribution 
# of the sample proportion p^, 
# obtain and interpret 80% confidence interval 
# estimate of the players true field goal percentage 
# using the bootstrap percentile confidence interval method
# Define the bootstrap distribution

# Sort the bootstrap distribution in ascending order
sorted_boot <- sort(phat.boot)

# Calculate the lower and upper percentiles for the confidence interval
lower_percentile <- quantile(sorted_boot, 0.1)
upper_percentile <- quantile(sorted_boot, 0.9)

# Display the confidence interval
confidence_interval <- c(lower_percentile, upper_percentile)
print(confidence_interval)

# Interpretation of the confidence interval
lower_bound <- confidence_interval[1]
upper_bound <- confidence_interval[2]
cat("The 80% confidence interval estimate for the player's true field goal percentage is [", lower_bound, ",", upper_bound, "].")

# This interval suggests that we can be 80% 
# confident that the player's true field goal 
# percentage falls between 18% and 42%.

# c

mean_boot <- mean(phat.boot)
se_boot <- sd(phat.boot) / sqrt(length(phat.boot))

# Calculate the margin of error for the desired confidence level (80%)
margin_error <- qt(0.9, df = length(phat.boot) - 1) * se_boot

# Calculate the confidence interval
lower_bound <- mean_boot - margin_error
upper_bound <- mean_boot + margin_error

# Display the confidence interval
confidence_interval <- c(lower_bound, upper_bound)
print(confidence_interval)

# Interpretation of the confidence interval
cat("The 80% confidence interval estimate for the player's true field goal percentage using bootstrap standard error is [", lower_bound, ",", upper_bound, "].")
# This interval indicates that we can be 80% 
# confident that the player's true field goal
# percentage lies between approximately 26.8% and 41.2%.