####### Basics of SQL
# 2/26/26
library(tidyverse)
library(sqldf)

#read in csvs

#note this is my file directory layout

species_clean<- read.csv('WilcenskiBio6100/Data/site_by_species.csv') 
var_clean<- read.csv('WilcenskiBio6100/Data/site_by_variables.csv')


#start with operations/functions -- one file to start 

#subsetting rows
#dplyr: use filter()

species<- filter(species_clean, Site<30) #dplyr
species


var<- filter(var_clean, Site<30) #dplyr
var


#dataquest sql commands list website has good help stuff 

#SQL method - first specify query you'll use 
# then run sqldf()


#select specific columns from dataset, WHERE filters out for condition
query<- "SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'" 

sqldf(query) #spits out into console based on sql code above

#dplyr for subsetting 

edit_species <- species%>%
  select(Site, Sp1, Sp2, Sp3)

# OR 

edit_species2<-species%>%
  select(1,2,3,4)


#Query entire table

query<- "SELECT * FROM species" # * = entire data set 


a<- sqldf(query)

#rename columns 
#in dplyr yopu would use rename() functions

species<- rename(species,Long=Longitude.x., Lat = Latitude.y.)
head(species)

# in SQL 

query<- "SELECT Long AS Longitude FROM species" #returns just selected Long column
#could show all by adding a WITH * (or something equivalent)
sqldf(query)


#pull out all numeric columns 

#first adding letter column ***
num_species<- species%>%
  mutate(letters=rep(letters, length.out = length(species$Site)))

num_species<- select(num_species, Site, Long, Lat, Sp1, letters)

num_species

#now removing non-numeric

num_species_edit<- select(num_species, where(is.numeric))
head(num_species_edit)

#Pivot longer to lengthen data , decreasing col number, inc row number
# you may also see gather()/spread(), but this is outdated and has been replaced by 
#pivot.longer()

species_long <- pivot_longer(edit_species, cols = c(Sp1, Sp2, Sp3), names_to="ID")


species_wide <- pivot_wider(species_long, names_from=ID)


#aggregation of data , getting calcs from data 

#SQL

query<- "SELECT SUM(Sp1+ Sp2+ Sp3) FROM species_wide GROUP BY SITE"
sqldf(query)


# added "AS Occurence" 
query<- "SELECT SUM(Sp1+ Sp2+ Sp3) AS Occurence FROM species_wide GROUP BY SITE"
sqldf(query)

#2 file operations joining datasets together

#Joining things can often be left/right/ or union joins 

#start w clean versions of vars 


#always create objects from it so as not to edit the og dataset
edit_species<- species_clean%>%
  filter(Site<30)%>%
  select(Site,Sp1, Sp2, Sp3,Sp4, Longitude.x., Latitude.y.)

edit_var<- var_clean %>%
  filter(Site<30)  %>%
  select(Site,BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

#left join from file b to file a -- needs matching marker column 

left<- left_join(edit_species, edit_var, by= "Site")

right<- right_join(edit_species, edit_var, by= "Site")

inner<- inner_join(edit_species, edit_var, by = "Site")
#retain rows that match between files, but loses a lot of 
#non matching info 

#full join retain all values but you have NAs for non-matching vals 

full<- full_join(edit_species,edit_var, by= "Site")

#SQL 

query<- "Select * FROM edit_var RIGHT JOIN edit_species ON edit_var.Site =edit_species.Site;"
x<-sqldf(query)
