# for_loops basic stuff 
#10 Feb. 2026 
#BEW

#create basic for loop
for (i in 1:5) {
  cat("stuck in a loop","\n")
  cat(3+2,"\n")
  cat(runif(1), "\n")
}

my_dogs<- c("chow", "akita", "malamute", "husky", "samoyed")

for (i in 1:length(my_dogs)){
  cat("i = ", i, "my_dogs[i]", my_dogs[i], "\n")
}


my_bad_dogs <- NULL

for(i in 1:length(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i]", my_bad_dogs[i], "\n")
}

for(i in seq_along(my_dogs)){
  cat("i =", i, "my_bad_dogs[i]", my_bad_dogs[i], "\n")
}


# Tip 1:
#don't do things in a loop that you dont need to: e.g.:

for(i in seq_along(my_dogs)){
  my_dogs[i]<- toupper(my_dogs[i]) #doesn't need to be in a loop 
}

tolower(my_dogs) #can just do the operation in the for loop above using a simple function <--



#Tip 2:
# don't change dimensions in the loop e.g.:

my_dat<-runif(1)

for(i in 2:10){
  temp<-runif(1)
  my_dat<-c(my_dat,10)
  #cat("loop number =", i, my_dat[1], "\n")
  print(my_dat)
}


#tip 3:
#don't write a loop if you can vectorize it

my_dat <- 1:10 
for (i in seq_along(my_dat)){
  my_dat[i]<- my_dat[i]+my_dat[1^2]
  cat("loop number =", i, my_dat[1], "\n")
}

#do this instead of the for loop above

z <- 1:10
z<- z + z^2
z

# TIP 4: 
# remember difference btwn i and z[i]m ("ith element of z")

z<- c(10,2,4)
for(i in seq_along(z)){
  cat("i=", i, "z[i]=", z[i], "\n")
}

#tip 5
#don't have to loop through everything

z<- 1:20 
for(i in seq_along(z)){
  if(i %% 2 ==0) next # if i is not divisible evenly by two, then skip that
  print(i)
  
}

###########################################

# look at the parameter space of the logistic growth model w a for loop 


################ Function Start ########################
#FUNCTION NAME: my_func
#PURPOSE: function returns a df with columns for pop size and time
#INPUTS: initial pop, growth rate, carrying capacity, end time of time vector,timestep for time vector
#OUTPUTS: #data frame with pop size and time

my_func<-function(No = 5, r = 0.5, K = 75, tf=100, ts= 1){ 
    e <- 2.718281828459 #define e constant
    t<- seq(from= 1,to=tf,by = ts) #define the number of steps, store as vector
    n<- K/(1+((K-No)/No)*e^(-r*t)) # formula to calculate the N(t) 
    out_df<- data.frame(t,n) # create df
    return(out_df)
    }

df<-my_func() #run function, assign to df
df


r_vec <- seq(0,1, by = 0.01) #vector of little rs 
r_vec

container_vec <- rep(NA,length(r_vec)) #storage for max(n)
c(length(container_vec), length(r_vec)) #both 21
container_vec



for (i in seq_along(r_vec)){
  temp_df<- my_func(r=r_vec[i]) #draws on hw 5 function (logistic growth)
  max_n<-max(temp_df$n)
  container_vec[i] <- max_n #storage is happening here
 
}

growth_df <- data.frame(r= r_vec,n = container_vec) 
plot(x= growth_df$r,y=growth_df$n) 

############
#2D parameter sweep for log growth func

r_values<- seq(0,1, length,out = 100)
K_values<- seq(10,1000, length,out = 100)

store_mat<- matrix (NA,nrow = length(r_values), ncol = length(K_values))

my_func(r=r_values[i],K = K_values)



growth_mat<- growth_sweep(r_vec = r_values,kvec=K_values)

growth_mat <- 


######## missed a ton of shit, None of the above will work^^^^^^
  
  
#2D parameter sweeep output Data Fram
for (i in seq_along(r_vec)){

  
}







#random walk func

###########
#Name; 
#purpose
#input : times = number of time steps 
#         n1    = inital pop size 
#          lamda = finite rate of increase
#        noise_sd= 10 
# output: 
#         vector n with pop size >0 until extinct 
#
library(ggplot2)

ran_walk <- function(times=100, n1= 50 ,lamda = 1, noise_sd=10){
  n <- rep(NA,times) #create our output vec ("storage container")
  n[1]<- n1 #initialize init pop size
  noise <- rnorm(n=100,mean =0, sd = noise_sd) #created noise/error 

  for(i in 1:(times-1)){ #do times-1 because we already defined n[1] as initial pop
    n[i+1] <- lamda*n[i] + noise_sd[i]
    if(n[i+1] <= 0){
      n[i+1] <- NA
      cat("Population Extinction at time", i+1, "\n")
      break 
    }
  }
  return(n)

}

x<- ran_walk()
print(x)

#plotting with default values
qplot(x = 1:100,y=ran_walk(), geom="line")


# no noise/not so random walk
qplot(x = 1:100,y=ran_walk(noise_sd=0), geom="line")


#no noise and adjust lamda

qplot(x = 1:100,y=ran_walk(lamda = 0.92, noise_sd=0), geom="line")


#add some stoch back, make lamda>1

qplot(x = 1:100,y=ran_walk(lamda = 1.11, noise_sd=10), geom="line")


