#hw 5

################Function Start
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


#library call
library(ggplot2)
library(magrittr)
########################### Question 2 : FUNCTION
#FUNCTION NAME: plot_func
#PURPOSE: function returns a df with columns for pop size and time
#INPUTS: initial pop, growth rate, carrying capacity, end time of time vector,timestep for time vector
#OUTPUTS:

plot_func<-function(data=df){
    df%>%
        ggplot(aes(x=t,
                y=n +))+
                    geom_point(size=1) +
                  labs(
                  x= "Time (year)"+
                y="Population size")

}
                  


plot_func()




