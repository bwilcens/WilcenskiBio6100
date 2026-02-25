##HW 8


library(dplyr)
library(sqldf)
library(tidyr)

## Question 1

str(iris)


## Question 2

anyNA(iris)


unique(iris$Species)


iris1<- iris %>%
  filter(Species =="versicolor" | Species == "virginica") %>%
  filter(Sepal.Length > 6 & Sepal.Width > 2.5)

str(iris1)


## Question 3

iris2<-select(iris1,Species, Sepal.Length, Sepal.Width)
str(iris2)
iris2

##Question 4 

iris3<- arrange(iris2,by=desc(Sepal.Length))
head(iris3)


## Question 5

iris4<- mutate(iris3, Sepal.Area = Sepal.Length*Sepal.Width)
str(iris4)
head(iris4)

#Question 6

iris5<- summarize(iris4, meanSplLen=mean(Sepal.Length), meanSplWid=mean(Sepal.Width), TotalNumber=n())
iris5

##Question 7

iris6<- iris4 %>%
  group_by(Species)%>%
  summarize(meanSplLen=mean(Sepal.Length), meanSplWid=mean(Sepal.Width), TotalNumber=n())
iris6

##Question 8 
irisFinal <- iris%>%
  filter(Species =="versicolor" | Species == "virginica") %>%
  filter(Sepal.Length > 6 & Sepal.Width > 2.5) %>%
      select(Species, Sepal.Length, Sepal.Width) %>%
        arrange(by=desc(Sepal.Length)) %>%
         mutate(Sepal.Area = Sepal.Length*Sepal.Width) %>%
          #summarize(meanSplLen=mean(Sepal.Length), meanSplWid=mean(Sepal.Width), TotalNumber=n())%>%
            group_by(Species)%>%
              summarize(meanSplLen=mean(Sepal.Length), meanSplWid=mean(Sepal.Width), TotalNumber=n())
irisFinal

#Question 9


irisLong<- iris%>%

  pivot_longer(cols=Sepal.Length:Petal.Width, names_to="Measure", values_to= "values")
head(irisLong)
