# Bryan Wilcenski
# 3/4/2024
# HW 07


## Question 1

# Using a for loop, write a function to calculate the number of zeroes in a numeric vector. 
# Before entering the loop, set up a counter variable counter <- 0. Inside the loop, 
# add 1 to counter each time you have a zero in the vector. Finally, use return(counter) for the output.
# generate vec binom, 



counter <- 0

zero_count<- function(n=1000){
  rb<- rbinom(n,1, 0.5) # create the vector
  for (i in 1:n){ #give function the number of time intervals to work through 
    if(rb[i] == 0){ #if indexed spot in the variable is equal to var, add one to counter
      counter <- counter+1
    }
  }
    return(counter)
}
zero_count()


## Question 2 


#Spoke with George, requested to use this method


library(dplyr)
library(sqldf)
library(tidyr)

ID <- c(1:100)
resp<-c(rbinom(100,1,0.5))
df<- data.frame(ID,resp)

sbst_0 <- nrow(filter(df,resp==0))
sbst_0

## Question 3


get_mat <- function(r=5,c=5){
  matrix<- matrix(NA, nrow = r, ncol = c)
  for (i in 1:r){
    for (j in 1:c){
      matrix[i,j]<- i*j
    }
  }
  return(matrix)
}
get_mat()


## Question 4

library(ggplot2)


# a)

set.seed(27)

trt_group <- c(rep("Jackson",4),rep("Hannah",5), rep("Bryan",6))
print(trt_group)

z <- c(runif(4) + 1, runif(5) + 10, runif(6) +27)
print(z)

# combine into data frame
df <- data.frame(trt=trt_group,res=z)
print(df)

# look at means in observed data
obs <- tapply(df$res,df$trt,mean)
print(obs)

# b)


# create a simulated data set

# set up a new data frame
df_sim <- df

# randomize assignment of response to treatment groups
df_sim$res <- sample(df_sim$res)
print(df_sim)


#look at means in simulated data
sim <- tapply(df_sim$res,df$trt,mean)
print(sim)


# function: shuffle_data
# randomize data for regression analysis
# input: 2-column data frame (x_var,y_var)
# output: 2-column data frame (x_var,y_var)
#------------------------------------------------- 
shuffle_data <- function() {
  df_sim

  df_sim$res <- sample(df_sim$res)

obs <- tapply(df$res,df$trt,mean)
sim <- tapply(df_sim$res,df$trt,mean)
print(sim)

return()

}

