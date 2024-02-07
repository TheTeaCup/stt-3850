x <- c("good", "best", "better", "better", "best")
x_factor <- factor(x)
x
x_factor

x[1] > x[5]

x_factor <- factor(x, ordered=TRUE, levels=c("good", "better", "best"))
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
ggplot(data=mtcars, mapping=aes())

ggplot(data=mtcars, 
       mapping = aes(x = wt, y = mpg), 
       ylab("Miles/(US) gallon"), 
       xlab("Weight (1000 lbs)"))


library(dplyr)

iris
head(iris)

iris1 <- iris %>% arrange(desc(Petal.Length))
head(iris1)

iris2 <- iris %>% arrange(desc(Petal.Length)) %>% arrange(desc(Petal.Width))


ggplot(data=iris, mapping= aes(x=Sepal.Width, y=Species)) + geom_boxplot()

IRIS_graph <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point() 
IRIS_graph + labs(
  title = "Figure 1. Scatterplot of Iris Petal Width vs Petal Length",
  x = "LENGTH",
  y = "WIDTH")

library(tidyverse)

ggplot(iris, aes(x=Petal.Length)) + geom_histogram()
dim(iris)
head(iris)

barplot(table(iris$Species))

barplot(iris$Petal.Length)

ggplot(iris, aes(x=Species)) + geom_bar()

head(iris$Petal.Length)

ggplot(iris, aes(x=Petal.Length)) + geom_histogram(color = "white") + facet_wrap(iris$Species)
boxplot(iris$Petal.Length)
ggplot(iris, aes(y=Petal.Length, x=factor(Species))) + geom_boxplot()

x <- c(20, 21, 22, 23, 24)
mean(x)
median(x)

