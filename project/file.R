# packages
library(tidyverse)
library(ggplot2)
library(dplyr)

# vector header...
questions_vector <- c(
  "Island", "Village", "Sex", "Age", "Height", "Weight", "Birthday", "Birth_Year", 
  "Birth_Village", "Villages_Lived", "Married", "Children", "Attractiveness_Scale", 
  "Eye_Color", "Sleep", "Moderate_PA", "Health_VS_Before", "Smoke", "Anxious", 
  "Depression", "Music", "IQ_Guess", "BP_Top", "BP_Bottom", "Waist_Circumference", 
  "Glucose", "Cortisol", "Openness", "Conscientiousness", "Extraversion", 
  "Agreeableness", "Neuroticism"
)
  
# mean sex
mean(ifelse(responses$Sex == "Male", 1, ifelse(responses$Sex == "Female", 2, NA)))

# mean age
mean(responses$Age)

# mean height
mean(responses$Height.cm.)

# mean weight
mean(responses$Weight.kg.)

# mean children
mean(responses$Children)

# ggplot fun
ggplot(responses, aes(x=Height, y = Weight, color=Sex)) + 
  geom_point() + 
  scale_color_manual(values = c("Male" = "blue", "Female" = "pink"))

# Box Plot of Age by Villages Lived
ggplot(responses, aes(x = factor(Villages_Lived), y = Age)) +
  geom_boxplot() +
  labs(
    title = "Box Plot of Age by Villages Lived",
    x = "Villages Lived",
    y = "Age"
  ) +
  theme_minimal()

# Bar chart of gender distribution
ggplot(responses, aes(x = Sex, fill = Sex)) +
  geom_bar() +
  labs(
    title = "Gender Distribution",
    x = "Sex",
    y = "Count"
  ) +
  theme_minimal()

# Histogram of age
ggplot(responses, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(
    title = "Age Distribution",
    x = "Age",
    y = "Frequency"
  ) +
  theme_minimal()

# Scatter plot of height vs. weight
ggplot(responses, aes(x = Height, y = Weight)) +
  geom_point() +
  labs(
    title = "Scatter Plot of Height vs. Weight",
    x = "Height",
    y = "Weight"
  ) +
  theme_minimal()

# Box plot of waist circumference by gender
ggplot(responses, aes(x = Sex, y = Waist_Circumference, fill = Sex)) +
  geom_boxplot() +
  labs(
    title = "Box Plot of Waist Circumference by Gender",
    x = "Sex",
    y = "Waist Circumference"
  ) +
  theme_minimal()

# Line plot of cortisol levels over time
ggplot(responses, aes(x = Birth_Year, y = Cortisol, group = 1)) +
  geom_line(color = "blue") +
  labs(
    title = "Cortisol Levels Over Time",
    x = "Birth Year",
    y = "Cortisol Level"
  ) +
  theme_minimal()

# Bar chart of marital status
ggplot(responses, aes(x = Married, fill = Married)) +
  geom_bar() +
  labs(
    title = "Marital Status Distribution",
    x = "Marital Status",
    y = "Count"
  ) +
  theme_minimal()

ggplot(responses, aes(x = Anxious, y = Depression)) +
  geom_point() +
  labs(
    title = "Anxiety vs. Depression",
    x = "Anxiety",
    y = "Depression"
  ) +
  theme_minimal()

ggplot(responses, aes(y = Depression)) +
  geom_boxplot() +
  labs(
    title = "Box Plot of Depression",
    y = "Depression"
  ) +
  theme_minimal()

BMI <- responses$Weight / ((responses$Height / 100)^2) 
ggplot(responses, aes(x = BMI, y = Age, color = Sex)) +
  geom_point() +
  labs(
    title = "Scatter Plot of BMI by Age (Under 50)",
    x = "BMI",
    y = "Age"
  ) +
  theme_minimal()

filtered_data <- responses %>%
  filter(Age < 50) %>%
  mutate(BMI = Weight / ((Height / 100)^2))
ggplot(filtered_data, aes(x = Age, y = BMI, color = Sex)) +
  geom_point() +
  labs(
    title = "Scatter Plot of BMI by Age (Under 50)",
    x = "Age",
    y = "BMI"
  ) +
  theme_minimal()

