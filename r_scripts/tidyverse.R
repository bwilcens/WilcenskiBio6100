install.packages("dplyr")
install.packages("sqldf")
install.packages("tidyr")

  library(dplyr)
library(sqldf)
library(tidyr)

#core verbs to wrangle data
#filter(), arrange(), sumarize(), group_by(), and mutate()


#start with built in dataset

#to specify package youre using for repeat syntax:
dplyr::filter()
stats::filter()

data(starwars)
class(starwars)
# tbl_df (similar to data frame), "tbl" (similar to df),
head(starwars)
glimpse(starwars)


# clean up dataset

#Base r has complete.cases() function - removes any rows with NA in them

starwarsClean <- starwars[complete.cases(starwars[,1:10]),] #runs complete cases for just first ten rows in the dataset
# pulls full set for any of the rows with no NAs in first ten columns 
#filtered dataset from 87 to 29

#check for NA's 

is.na(starwarsClean[,1])
anyNA(starwarsClean[,1:10])

#filter function - this will subset observatiuons by their values
#uses <,>,=<, == etc
#logical operators like & and |

#filter automaticallly excluses NA, have to ask for them explicitly 

filter(starwarsClean,gender=="masculine"& height<180)

filter(starwarsClean,gender=="masculine"& height<180, height>100)

filter(starwars, eye_color %in% c("blue", "brown"))
#filters for multiple conditions 

#arrange() reorder rows

arrange(starwarsClean, by = height)
arrange(starwarsClean, by = desc(height)) # Orders by descending height

arrange(starwarsClean, height, desc(mass)) #additional columns (e.g. mass) will break ties

#select() choose variables based on their names/columns

starwarsClean[1:10,] #does the same thing as the tidyverse prompt below 
select(starwarsClean,1:10) 
select(starwarsClean, name:homeworld) #take all columns between name and homeworld
select(starwarsClean,-(films:starships)) #subsetting everything except films to starships

#rearrange columns
select(starwarsClean,homeworld, name, gender, species, everything()) #order first columsn in given order, print the rest after that 

select(starwarsClean, contains("color")) #looks at every column name, extract any (col name) that contains "color"

#rename colomns 
select(starwars, haircolor=hair_color) #actual name of column comes after stating the new name you want


#mutate() function create new variables with functions of existing variables 

#create new columns that is height / mass 
y<- mutate(starwarsClean, ratio=height/mass) #row wise operation , will add to end
#can reorder with select

starwars_lbs<- mutate(starwarsClean, mass_lbs=mass*2.2)

#use transmute() function to just have the new variable that you want

z<- transmute(starwarsClean, mass_lbs=mass*2.2)
 

#summarize and group by fucntions collapse things to single var 

summarize(starwarsClean,meanHeight=mean(height)) #needs to be clean

summarize(starwars, meanHeight=mean(height)) #wont work 

summarize(starwars, meanHeight=mean(height, na.rm=TRUE), TotalNumber=n()) #returns the mean height with no na, 
#and number of records total (including nas)

#use group_by() for additional calculations
starwarsGender <- group_by(starwars, gender)
summarize(starwarsGender, meanHeight = mean(height,na.rm=TRUE), number=n()) #returns mean height 
# within each group_by category, and returns the number in each group


# pipe statements : %>%, or |> (these two both work)

#these are sequences of actions that will change dataset 
#going to pass intermediate results onto next functions in sequence
#you sould avoid this when you need to manipulate more than one object or if there are meaningful intermediary objects 

#formatting: should have space before it and follow with automatic indent

starwarsClean%>% #initializes data frame
  group_by(gender) %>% #groups by gender
  summarize(meanHeight = mean(height,na.rm=TRUE), number=n()) #calcs summary 

# case_when() when we want to include mult conditional ifelse
unique(starwarsClean$species)

#create new column, check if species is human, if so, label as human, if not, label as nonhuman, place in second col
newdf <- starwarsClean%>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~"Non-human")) %>%
  select(name, sp, everything())


#pivot from long to wide format using pivot_wider, pivot_longer 

wideSW<- starwarsClean%>%
  select(name, sex, height) %>%
  pivot_wider(names_from= sex, values_from = height, values_fill=NA)
wideSW


pivotSW<- starwars%>%
  select(name,homeworld) %>%
  group_by(homeworld)%>%
  mutate(rn=row_number()) %>%
  ungroup()%>%
  pivot_wider(names_from=homeworld, values_from=name)


x<-wideSW %>%
  pivot_longer(cols=male:female, names_to="sex", values_to="height",
  values_drop_na=TRUE)

