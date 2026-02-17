# for loops 2 from website

# create a simple random growth population model function

##################################################
# FUNCTION: ran_walk
# stochastic random walk 
# input: times = number of time steps
#        n1 = initial population size (= n[1])
#        lambda = finite rate of increase
#        noise_sd = sd of a normal distribution with mean 0
# output: vector n with population sizes > 0 
#         until extinction, then NA 
#------------------------------------------------- 
library(ggplot2)
ran_walk <- function(times=100,n1=50,lambda=1.00,noise_sd=10) {
                n <- rep(NA,times)  # create output vector
                n[1] <- n1 # initialize with starting population size
                noise <- rnorm(n=times,mean=0,sd=noise_sd) # create noise vector
                for(i in 1:(times-1)) {
                  n[i + 1] <- lambda*n[i] + noise[i]
                  if(n[i + 1] <=0) {
                    n[i + 1] <- NA
                    cat("Population extinction at time",i+1,"\n")
                    break}
                }

return(n)
}

# explore paramaters in plot function
qplot(x=1:100,y=ran_walk(),geom="line")


qplot(x=1:100,y=ran_walk(noise_sd=0),geom="line")

qplot(x=1:100,y=ran_walk(lambda=0.92,noise_sd=0),geom="line")
m <- matrix(round(runif(20),digits=2),nrow=5)

# loop over rows
for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + i
} 
print(m)
