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
