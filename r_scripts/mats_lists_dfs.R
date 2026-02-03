# Lists, Matrices, and Data Frames
# Bryan Wilcenski
# 1/29/2026

##########################################################################

#create a matrix from a vector

my_vec<- 1:12

#filling with columns, row argument (nrow=4)
m<- matrix(data = my_vec, nrow =4)

#by filling through other direction (byrow=T)
m<- matrix(data = my_vec, ncol =3, byrow =T)
m

#lists: (atomic vectors that can hold variables of diff types)
my_list <- list(1:10, matrix(1:8,nrow = 4, byrow=T), letters[1:3], pi)
print(my_list)

#indexing a list
str(my_list[1])

#my_list[1] + 1 (wont run- non-numeric argument to binary operator)

my_list[[1]]
x<- my_list[[1]]
str(x)

#index into a matrix

my_list[[2]]
my_list[2] #diff return as line above

my_list[[2]][1,2] #returns row 1, col 2, of 2nd thing in list (matrix)

#naming lists

my_list2<- list(tester=FALSE,little_m=matrix(1:9, nrow=3)) 
#will not print with double brackets around the number of list item -- uses names
print(my_list2)

#named objects in lists:

print(my_list2$little_m) #dollar sign after list name specifies list item
my_list2$little_m[2,3] #don't need double brackets if using name to index

#looking at emplty place indexing

my_list2$little_m[1,] #gives full first row
my_list2$little_m[4] #if you don't include column (as a ',') r will treat the matrix as a vector

#unlist
unrolled<- unlist(my_list2)
unrolled #flattens all list components into a named list, true is boolean and reduced to 0
unrolled[1]

#unpacking complex lists

#make sure that ggplot2 is installed, then invoke in script 
library(ggplot2)

#create random vars
y_var<- runif(10)
x_var<- runif(10)

#regress 
my_model<- lm(y_var~x_var)

#plot my model
qplot(x=x_var, y=y_var) 

#explore structure
print(my_model)

str(summary(my_model))

#extracting pvals -- after getting the summary of my_model, you can index out certain things (pval)
summary(my_model)$coefficients["x_var", "Pr(>|t|"]

u<- unlist(summary(my_model))

print(u)

pval<-u$coefficients2
pval

#data frames

 #define variables
var_a<- 1:12
var_b<-rep(c("A","B", "C"),4)
var_c<- runif(12)

#creating a data frame from vecs 9variables
df<- data.frame(var_a,var_b,var_c)
df

#view  structure summary of df
str(df)

#access things in df

df$var_b
#can also treat like matrix - may not be the best way
df[1,1]

#best way:
df$var_a[1] #first elmt in var_a

#expanding the data frame

#contains the things we add to df in the next step
new_data<-list(var_a = 13, var_b="D", var_c=0.77)
new_data

#appending data
df2<-rbind(df,new_data)
df2


head(df2,10)
tail(df2)

View(df2) #view data frames in the viewer

#add a new column to a dataframe
print(df2)

#using cbind (adding the column after definign what is in it)
new_var<- rnorm(13)
df3<- cbind(df2,new_var) 
print(df3)
str(df3)

#using assignment operator
char_var<- rep("T",13)
df3$charV<- char_var
head(df3)


## reading and writing data frames
#know where the data is stored - create a data folder in repository

#writing data frames
write.csv(df3,"6100data/my_dataframe.csv") 
#include the subfolder before the file name to place in subfolder
##

data<-read.csv("6100data/my_dataframe.csv", header = T, sep=",")
data$var_a


##Distinctions between DFs and Mat Dims 

z_mat<-matrix(data=1:30,ncol=3, byrow=T)
print(z_mat)

z_dframe<- as.data.frame(z_mat) #turn into df
print(z_dframe)

str(z_mat)
str(z_dframe)

head(z_dframe)
head(z_mat)

z_mat[2,1] #element indexing
z_dframe$V2[2] #correct for dframe

#column ref

z_dframe[,3] #(calls third column) 
z_dframe$V3#same but the pone above is better
z_mat[,3]


#one dimension referencing (indexing in one dimension with matrix will turn it into a vector)
z_mat[2]
z_dframe[2]

#missing data in dfs and mats

zd<- runif(10)
zd

zd[c(5,7)]<- NA
zd

#complete cases 
complete.cases(zd) #when a value is there > true, when not> false

#filter for only True
zd[complete.cases(zd)]


#which positions are missing?
which(complete.cases(zd)) #returns indexes for which we have complete cases
which(!complete.cases(zd)) #returns indexes for which we DO NOT have complete cases

# missing data in matrix

m<-matrix(1:20,nrow=5) #will default to column-wise filling

#add missing data 
m[1,1]<- NA
m[5,4]<- NA
m

#other way of writing step above 
#m[c(1),1]<- NA # missed the formula for doing this

m[complete.cases(m),] #returns only the rows where all values are complete

#complete cases for onlu certain columns
      

m[complete.cases(m[,c(1,2)]),] #drops first row
m[complete.cases(m[,c(1,2)]),] #no drops 
m[complete.cases(m[,c(3,4)]),] # drops row 4 
m[complete.cases(m[,c(1,4)]),] # drops rows 1 and 4 

#subsetting mats and data frames
m<- matrix(data=1:12, nrow=3)
dimnames(m)<- list(paste("Species",LETTERS[1:nrow(m)],sep=""),paste("Site",1:ncol(m),sep=""))
print(m)

#element wise subsetting ---# better to do the second one if possible
m[1:2, 3:4]
m[c("SpeciesA","SpeciesB"),c("Site3", "Site4")]

m[1:2,]
m[,3:4]


#using logical for subsetting (in this case greater than operator)

colSums(m) #generates vector w the sum of the columns 
colSums(m)>15 # generates logical 

sums<-colSums(m)
sums[sums >15]

rowSums(m)
m[rowSums(m)==22,] #add the comma to keep the format 

m[,"Site1"] #gives us first row with site 1 

m[,"Site1"]<3 #turns to logical 


#data curation

###---Start of Metadata
#put some basic metadata in the csv  that the data comes from
#title, date, author
#author email address website 
#ownership collaborators funding src repo citatipns
#sampling locations samp times vari desc missing data (true zeros vs missing data)
#data track changes log (date: ~~~~~, changes:)
###---------END OF METADATA-----
#///////////

##
#----start of data-------

read.table(file="ExcelDataTemplate.csv",
header=TRUE,sep=",",comment.char="#")



#read in and write out are most often used in r 

#other option: saving r objects as rds file 
# (output of the model can be preserved so you don't have to rerun every time)

saveRDS(z_dframe,file= "6100data/sData.RDS")
z_dframe


# using RDS function 
unfrozen_Z<- readRDS("6100data/sData.RDS")
unfrozen_Z
















