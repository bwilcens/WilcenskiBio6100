# This is a document describing vectors in R
#1.22.26
# Bryan Wilcenski

#--------------------------------------------------------
#START OF SCRIPT

x <- 5 
print(x)

#storing variables: use a uniform case for r 
#scripts and a universal case for files
plant_height <- 3 #snake case
plantHeight <- 4 # camel case
plant.height <- 2 # this is NOT preferred 

# reserved in R (F,T)
. #reserved for temporary variable

# Four basic data types

#           | c(i,t,3)   | (I,"Y", T)
#Dimensions | Homogenous | Heterogenous
#1D---------|vector------| list 
#2D---------|matrix------| data frame
#ND---------|array-------|

# 1D adtomic vec:
z <- c(3.2,5,5,6)
print(z)
typeof(z) #identify the data type (float, double in this case)

z <- c(c(3.2,3),(3,5))
print(z)
is.numeric(z) # will return F if not
is.character(z)

# character strings 
t<- "perch"
print(t)

t <- c("perch","bass","trout")
t[3]


t <- c("This is a 'character' string", "a second")
t

# print a specific character in the string
t[1]
t[2]

typeof(t)
is.numeric(t)

#Boolean/Logical - better to spell out these terms 
#T and F stored in binary 
z<- c(TRUE,FALSE,TRUE)
z

typeof(z)

c(T,F)
mean(z) #can calculate the percent of the boolean that are TRUE



# properties of a vector 

z<-c(1.1,2.2,3.3)

typeof(z) # gives type
is.numeric(z) # is.gives logical
t<-as.character(z) # as. coerces variable 

print(t)
typeof(t)
t<- c(1,2,"3",4)

length(t) # really useful 



# random number generator
z <-runif(5) #random uniform number distribution
names(z)
print(z)

names(z) <- c("A","B","D","E","F")

names(z)<-NULL
mean(z)
z

#special data types

z<- c(3,2,3,NA)
print(z)
typeof(z)
length(z)
typeof(z[4])
sum(z) #retunrs NA because of the NA in the string 

sum(z,na.rm=T) #na.rm = T removes the NA

z<- 0/0
print(z) #returns NaN

z <-1/0 # returns Inf
z

#vectorization 
# enables faster calculations than for loops 

z<- c(10,20,30,40)
z

y<-c(1,2,3)

z + y 

# recycling

x<-c(1,2)

z + x

