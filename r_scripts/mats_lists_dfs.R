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

y_var<- runif(10)
