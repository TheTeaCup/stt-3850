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