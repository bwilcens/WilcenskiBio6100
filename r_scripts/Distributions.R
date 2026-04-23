# ProbDist
# 4/21/2026


############################
# Function: my_histo
# Purpose: creates a ggplot histogram
# Requires: ggplot
# Input: x = a numeric vector
#        data_type= "cont" or "disc"
# Output: a ggplot histogram
############################
library(ggplot2)
my_histo <- function(x=NULL,data_type="cont") { #null var for x (wont run unless we include an x val)
  if(is.null(x)) x=runif(1000)
  df <- data.frame(x=x) 

# if data are continuous bounded (0,1), adjust bins for histogram  
  if (data_type=="cont" & min(df$x) > 0 & max(df$x) < 1) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(boundary=0,
                   binwidth=1/30,
                   color="black",
                   fill="goldenrod") +
    scale_x_continuous(limits=c(0,1))}  

  
# if data are continuous, but not bounded (0,1), use
# ggplot default bins
  if (data_type=="cont" & (min(df$x) < 0 | max(df$x) > 1)) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(color="black",
                   fill="goldenrod")}

     
  

# if data are discrete integers, 
#  use geom_bar to create a histogram
if (data_type=="disc") {
  p1 <- ggplot(data=df) + 
    aes(x=x) +
    geom_bar(color="black",fill="goldenrod") }
  
print(p1)
} 
my_histo()

# poisson dist 
my_histo(data_type="disc",x=rpois(1000,lambda=3)) #as you increase lambda, you get closer to the normal dist, more negative, closer to exponential

my_histo(data_type="cont",x=runif(1000))
my_histo(data_type="cont",x=rnorm(n=10000,mean=0,sd=1)) #can mess around with all kindds of stuff 




############################
# Function: my_pdf 
# Purpose: creates a ggplot probability density function ############
# Requires: ggplot
# Input: x = a numeric vector of x values
#        y = pdf values calculated for each value of x
#        data_type= "cont" or "disc"
# Output: a ggplot pdf
############################
# y axis is density -- probability of that value 
#shape one is alpha, shape 2 is beta


my_pdf <- function(x=NULL,y=NULL,data_type="cont") {
  if(is.null(x) | is.null(y)) {
    x=seq(from=-3,to=3,length.out=100)
    y=dnorm(x) }
  
    df <- data.frame(x=x,y=y) 
    
    # for continuous distributions, 
    # plot the line for the pdf
    if(data_type=="cont") {
      p1 <- ggplot(data=df) +
        aes(x=x,y=y) +
      geom_line() +
        geom_area(fill = "cornflower blue") } 
    
    # for discrete distributions,
    # plot a bar for the probability at each value
    if (data_type=="disc") {
      p1 <- ggplot(data=df) + 
        aes(x=x,y=y) +
        geom_col(color="black",fill="cornflower blue") }
    print(p1)
}
my_pdf()

my_x=seq(from=0,to=1,length.out=100)

my_pdf(x=my_x,y=dbeta(x=my_x,shape1=120,shape2=120)) # beta dist, calculate probabilty density 

my_pdf(x=0:10,y=dpois(x=0:10,lambda=4.5),data_type="disc") # density poisson function


#also need ggplot
library(MASS)
#-------------------------------------------------
# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# (observations per time or per unit area)
# Parameter lambda > 0

# "d" function generates probability density
hits <- 0:10
my_vec <- dpois(x=hits,lambda=1)
my_vec

my_pdf(x=hits,y=my_vec,data_type="disc")

my_vec <- dpois(x=hits,lambda=2)
my_pdf(x=hits,y=my_vec,data_type="disc")

sum(my_vec)  # sum of density function = 1.0 (total area under curve)

#mnore on website



library(MASS)
#-------------------
# we want to find the dist that best represents the dataset
data <- c(100,100,104,99)
z<- fitdistr(data,"normal")
z

hist(rnorm(n= 1000, mean=100.75, sd = 1.9))

#frog data 

frog_data<- c(30.15,26.3,27.5,22.9,27.8,26.2)
frog_data

#try to fit normal to frog data 
z<- fitdistr(frog_data,"normal")
print(z)
x<-1:100

frog_density <- dnorm(x=x,mean=26.8,sd =2.18) #(from z)
qplot(x, frog_density,geom="line") # generate a density qplot with the parameters 



z<- fitdistr(frog_data, "gamma") #try out gamma dist (shape and rate are generated)
                                 #
z

#gamma density 
frog_gamma<- dgamma(x, shape =147.2,rate =5.5)
frog_gamma 
qplot(x, frog_gamma,geom="line") # generate a density qplot with the parameters 

#fuck up the dataset and see what happens 

newFrogData <- c(frog_data, 0.05) 
z<- fitdistr(newFrogData, "gamma")
z #see shape rate and (standard error in parenth)


NewFrogGamma<- dgamma(x, shape =0.8,rate =.035)
qplot(x, NewFrogGamma,geom="line") 

