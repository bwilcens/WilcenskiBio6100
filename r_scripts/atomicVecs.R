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
 #reserved for temporary variable

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

####################################
#atomic vecs part II

z <- vector( mode ="numeric", length = 0)
print(z)

#dynamic creation (don't in R, do in python)
z<- c(z,5)
print(z)

#predefined length

z <- rep(0,100)
print(z)
length(z)

## can create the empty list to speed up processing in for loops

z<- rep(NA, 100)
z

typeof(z)

z[1] <- "vermont"
head(z)
typeof(z)


my_vector <- runif(100)
my_names <- paste("species", seq(1:length(my_vector)),sep="")
print(my_names)

names(my_vector) <- my_names
head(my_vector)
str(my_vector)


#using the rep function

rep(0.5,6)
rep(x=0.5, times =6) # should write out the arguments in functions I am using

my_vec <- c(1,2,3)

#repeat a vector
rep(x=my_vec, times = 2, each =2)

#sequencing vectors 
seq(from = 2, to = 4)
2:4

x<- seq(from = 2, to = 4, length=7) #evenly space w a given start/end/length

my_vec <- 1:length(x) # common in other languages, slow in R 
my_vec

#better in R to use: 
seq_along(my_vec)

# generate random vectors

runif(5) #gives us 5 values from 0:1 
#the params
runif(n=3, min=100,max=101)

set.seed(123) #takes any number 

#gives you the same progression of random numbers
runif(n=3, min=0,max=1)

#normal distribution
out<-rnorm(n=500, mean= 100, sd=30)
hist(out)

# random sampling 

long_vec <- seq_len(10)
long_vec

#can set seed if you want as well 

sample(x=long_vec, size = 10, replace=T)

#weighted sampling from a vec
weights <- c(rep(90,5), rep(10,5))
weights

sample(x=long_vec,replace=TRUE, prob=weights)


#subsetting vectors
z <- c(3.1, 9.2, 1.3, 0.4,7.5)
print(z)

z[-c(2,3)] #using vecs slice

#using logicals 
z[!z<3] # = z[z>3]

#relational operators
#<
#>
#<=
#>=
#    == (need to use two of them for 'equals')

#logical operators
# 1 == not 
# & == and (vector)
# | == or (vector)
# xor == (x,y)     {exclusive or; will return true if a condition is only true for one of two items in vector}


x<-1:5
y<- c(1:3,7,7)

x==2 #equals 
x!=2 #not equal

x== 1 & y ==7 #using and: never happens in defined sequences ^^^

x == 1 | y == 7 # using or

x==3 & y==3 # using or

xor(x==3,y==5) # exclusive or (xor)


# missing values

set.seed(90)
z<- runif(10)
z
z<0.5
z[z<0.5]
z[which(z<0.5)]

zd <- c(z,NA, NA)
zd

zd[zd<0.5]

#dropping NAs with which to index

zd[which(zd<0.5)]

