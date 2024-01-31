hist(mtcars$mpg)
barplot(table(x))
boxplot(mtcars$mpg)
summary(mtcars$mpg)
plot(mtcars$wt, mtcars$mpg);

library(ggplot2)

ggplot(data=mtcars, mapping=aes())
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg))
ggplot(data=mtcars, 
    mapping = aes(x = wt, y = mpg), 
    ylab("Miles/(US) gallon"), 
    xlab("Weight (1000 lbs)"))