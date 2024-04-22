x <- c("good","best","better","better","best")
x_factor <- factor(x)
x
x_factor
x[1] > x[5]
x_factor <- factor(x,ordered=TRUE,levels=c("good","better","best"))
x_factor[1] > x_factor[5]
summary(x)
summary(x_factor)
df <- data.frame(x, x_factor)
x_list <- list(x, x_factor, df)
x_list

hist(mtcars$mpg)
barplot(table(x))
boxplot(mtcars$mpg)
summary(mtcars$mpg)
plot(mtcars$wt,mtcars$mpg)
library(ggplot2)
mpg_hist <- ggplot(data=mtcars,mapping=aes(x=mpg))+geom_histogram(color="white",binwidth=3)
mpg_hist + xlab("MPG") + ylab("COUNT") +ggtitle("Figure 1. Histogram of Cars' mpg")
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar()
g <- ggplot(data=mtcars,mapping=aes(y=mpg, x=wt,color=factor(am),size=cyl))+geom_point()
CLASS <- c("freshman","sophomore","junior","senior","junior")
GPA <- c(2.5,2.6,3,3.5,2.75)
STUDENT <- data.frame(CLASS, GPA)
dim(mtcars)
CLASS_factor <- factor(CLASS)
CLASS_factor
g + geom_abline(slope=-10,intercept=40,color="blue",linetype=6)
a <- 2
2 -> b
c = 2
x <- c(0,1,2)
y <- c(1,2,3)
(x | y) & (!x)

library(dplyr)
iris
head(iris)
iris1 <- iris %>% arrange(Sepal.Length)
iris1 <- iris %>% arrange(desc(Sepal.Length))
iris1 <- iris %>% arrange(Sepal.Length) %>% arrange(Petal.Length)
iris1 <- iris %>% select(Sepal.Length,Petal.Length)
head(iris1)

iris2 <- iris %>% filter(Species=="setosa" | Species =="virginica")
iris2

#Write the dplyr commands that will store the Sepal.Length 
#and Petal.Length data only for the versicolor specie and store in
# a new data frame named iris4 whose dimension is 50 by 2

iris3 <- iris %>% select(Sepal.Length,Petal.Length,Species) 
iris5 <- iris3 %>% filter(Species=="versicolor")


iris4 <- iris %>% filter(Species=="versicolor") %>% select(Sepal.Length, Petal.Length)


iris6 <- iris %>% mutate(Petal.Length.Inch = Petal.Length * 0.393701,Petal.Width.Inch = Petal.Width * .393701)

PL.setosa <- iris$Petal.Length[iris$Species=="setosa"]
PL.versicolor <- iris$Petal.Length[iris$Species=="versicolor"]
PL.virginica <- iris$Petal.Length[iris$Species=="virginica"]
mean(PL.setosa)
mean(PL.versicolor)
mean(PL.virginica)

iris %>% group_by(Species) %>% summarize(Mean = mean(Petal.Length),Median = median(Petal.Length))
iris %>% summarize(Mean = mean(Petal.Length),Median = median(Petal.Length))
iris %>% top_n(5,Petal.Length)

library(tidyverse)
ggplot(iris,aes(x=Petal.Length))+geom_histogram()
dim(iris)
head(iris)
barplot(table(iris$Species))
ggplot(iris,aes(x=Species))+geom_bar()
hist(iris$Petal.Length)
ggplot(iris,aes(x=Petal.Length))+geom_histogram(color="white",bins=5)+facet_wrap(iris$Species)
boxplot(iris$Petal.Length)
ggplot(iris,aes(y=Petal.Length,x=factor(Species)))+geom_boxplot()

x <- c(20,21,22,23,24)
mean(x)
median(x)
range(x)
range(x)[2]-range(x)[1]
max(x)-min(x)
IQR(x)
quantile(x,.25)
quantile(x,0.75)
ggplot(iris,aes(y=Petal.Length,x=factor(Species)))+geom_boxplot()
iris %>% group_by(Species) %>% summarize(IQR = IQR(Petal.Length))
sd(x)
sd(x)^2
var(x)
lower <- quantile(x,0.25)-1.5*IQR(x)
upper <- quantile(x,0.75)+1.5*IQR(x)
c(lower,upper)
x <- rnorm(10000,3.0,0.25)
hist(x)
mu<- mean(x)
sigma<- sd(x)
lower1 <- mu - sigma
upper1 <- mu + sigma
within1 <- x[x >= lower1 & x <=upper1]
length(within1)/length(x)*100

lower2 <- mu - 2*sigma
upper2 <- mu + 2*sigma
within2 <- x[x >= lower2 & x <=upper2]
length(within2)/length(x)*100

qqnorm(x)
qqnorm(iris$Petal.Length)

n1 <- 100
n2 <- 100
x1 <- 72
x2 <- 61
p1hat <- x1/n1
p2hat <- x2/n2
phat <- (x1+x2)/(n1+n2)
z <- (p1hat - p2hat)/sqrt(phat*(1-phat)*(1/n1+1/n2))
pvalue <- 1- pnorm(z)
z
pvalue
sample.data <- matrix(c(72,61,28,39),nrow=2)
prop.test(sample.data,alternative="greater",correct=FALSE)
xbar <- 3.0
s <- 0.4
n <- 50
mu_0 <- 2.8
t <- (xbar - mu_0)/(s/sqrt(n))
pval <- 1 - pt(t,df = n-1)
t.test(mtcars$mpg,mu=20,alternative="greater")

manual <- mtcars$mpg[mtcars$am==1]
auto <- mtcars$mpg[mtcars$am==0]
xbar1 <- mean(manual)
xbar2 <- mean(auto)
s1 <- sd(manual)
s2 <- sd(auto)
n1 <- length(manual)
n2 <- length(auto)
t <- (xbar1-xbar2)/sqrt(s1^2/n1 + s2^2/n2)
df <- (s1^2/n1 + s2^2/n2)^2/(1/(n1-1)*(s1^2/n1)^2+1/(n2-1)*(s2^2/n2)^2)
pval <- 1-pt(t,df=df)
t
pval
df
t.test(manual,auto, alternative="greater")