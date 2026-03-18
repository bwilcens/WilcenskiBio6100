#Homework 09 Scratch

library(ggplot2)

## Question 1

iris <- iris



petal.plot <- ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width)) + 
  geom_point(size=1) +
  geom_smooth(method="lm")+
  labs(
    x = "Petal Length (in.)",
    y= "Petal Width (in.)"
  )


petal.plot


## Question 2

petal.box <- ggplot(data = iris, aes(x = Species, y = Petal.Length)) + 
  geom_boxplot(size=1, fill = "orange")+
  geom_jitter(size=1) + 

  labs(
    x = "Species",
    y= "Petal Width"
  )
petal.box

## Question 3

library(tidyverse)

newdf <- iris%>%
  mutate(binary_setosa=case_when(Species=="setosa"~1, TRUE ~0)) %>%
  select(Species, binary_setosa, everything())
newdf


class(newdf$binary_setosa)


binary.jit <- ggplot(data = newdf, aes(x = Petal.Length, y = binary_setosa)) + 
  geom_point(size=1)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

binary.jit

## Question 4

bumble <- read.csv("beeData.csv")




mosaic1<- mosaicplot(~  sampling_event+ bee_caste, data=bumble, main = "Sample Event and Caste", color=TRUE, cex.axis= 2)


