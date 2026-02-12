
## 2/5/2026
#functions notes (what is programming )

#Functional Programming vs OOP (obj oriented programming)


#OOP notes 
#object has attributes that are analysis in and of itself, can then call stuff from within the oop
#WE WONT BE USING THIS AS MICH IN THIS CLASS
#
##Functional notes  FOCUS OF THIS DAY'S CLASS
#--
#function-> output -> function
#
#There is a function called function()
#
# myfunc<- function(x=1,y=2) {
#out<-x+y
#out<-y/2
########outside of the function is the global env, inside is local
########locally defined variables don't call in the local env
#z<-list(out, out)
#return(z)}

###need to call function later
# z <- myfunc(x=2,y=3)
##########can then call it with different variables or a range of variables
#

#CLASS NOTES 

#a demo of user defined functions in R 
#Bryan Wilcenski 
#2/5/2026
#####################################################################

#looking at existing functions 

sum(3,2) # function
3+2 #operator, but a function in r 

`+`(3,2) #plus sign is a function

y<-3
`<-`(y,5) #even the assignment operator can be called as a function
y


print(read.table) #see inside the function

# create a function

#start function called functionName
###################################### Hashtag delineater to show into a funciton##
adder_subtractor <- function(x=1,y=2,z=TRUE){
# Name: adder_subtractor
#Operation: it does some random math depending on value of z: 
#Inputs: (3 inputs):
  #x (numeric scalar value, default=1) one of the numbers to be operated on
  #y (numeric scalar value, default=2) one of the numbers to be operated on)
  #z (logical,default=T): a switch to decide on subtracting or adding
#Outputs: (numeric value resulting from addition or subtraction)
  if(z==TRUE){
  out<- x+y
  }else{
    out<-x-y
  }
    
    return(out)
}
  
########################################################
#end of function

adder_subtractor(x=7,y=4,z=FALSE)


# Hardy Weinberg Function 

#######################################################################
#START FUNCTION
hardy_weinberg<-function(p = runif(1)){
#######################################################################
  #FUNCTION: hardy_winberg 
  # operation: does a hardy weinberg equilibrium problem
  #Input = p: (allele frequency of dominant allele)
  # #output = q(recessive): frequencies of three genotypes (fAA,fAB,fBB)

  q <- 1-p #defined q 
  fAA<- p^2
  fAB<- 2*p*q
  fBB<-q^2
  
  # store data for output
  out_vec<-signif(c(q=q,p=p,AA=fAA,BB=fBB,AB=fAB),digits = 3) 
  
  #return the values
  return(out_vec)

}
#######################################################################
#END FUNCTION

hardy_weinberg()
hardy_weinberg(p=0.3)
hardy_weinberg(p=9) #FUNCTION WILL WORK, BUT THE RESULT DOESNT MAKE SENSE (BIO STUFF)

#global vs local parameters

my_func<- function(a=3,b=4){
  z<-sum(a,b)
  return(z)
}

my_func()

#my bad func doesn't define b - cannot declare it outside of the function (make sure it is declared in the local env)
my_bad_func<- function(a=3){
  #b<-8 #ADDED THIS AFTER THE FACT--WAY TO FIX the issue of undeclared b
  z<-a+b
  return(z)
}
my_bad_func()


#passing global variables properly 

a<-32
b<-4

my_func_2<- function(first,second){
  z<- first+second
  return(z)

}

my_func_2(first=a,second=b) #passing occurs here! (this is a safe way to create things outside the func)


#2/10/26

#HARDY WEINBERG PART/DAY TWO
# added IF clause to guide user

#######################################################################
#START FUNCTION
hardy_weinberg<-function(p = runif(1)){
#######################################################################
  #FUNCTION: hardy_winberg 
  # operation: does a hardy weinberg equilibrium problem
  # Input = p: (allele frequency of dominant allele)
  # #output = q(recessive): frequencies of three genotypes (fAA,fAB,fBB)

  if(p > 1 | p < 0){
    return( "Function failure: p must be greater than 0 but less than 1.")
  }
    

  q <- 1-p #defined q 

  fAA<- p^2
  fAB<- 2*p*q
  fBB<-q^2
  
  # store data for output
  out_vec<-signif(c(q=q,p=p,AA=fAA,BB=fBB,AB=fAB),digits = 3) 
  
  #return the values
  return(out_vec)

}
#######################################################################
#END FUNCTION

hardy_weinberg( p = 3)






#######################################################################
#START FUNCTION
hardy_weinberg<-function(p = runif(1)){
#######################################################################
  #FUNCTION: hardy_winberg 
  # operation: does a hardy weinberg equilibrium problem
  # Input = p: (allele frequency of dominant allele)
  # #output = q(recessive): frequencies of three genotypes (fAA,fAB,fBB)

  if(p > 1 | p < 0){
    stop( "Function failure: p must be greater than 0 but less than 1.")
  }
    

  q <- 1-p #defined q 

  fAA<- p^2
  fAB<- 2*p*q
  fBB<-q^2
  
  # store data for output
  out_vec<-signif(c(q=q,p=p,AA=fAA,BB=fBB,AB=fAB),digits = 3) 
  
  #return the values
  return(out_vec)

}
#######################################################################
#END FUNCTION
hardy_weinberg()
hardy_weinberg(p=3)


#regression function  - BASIC

# START OF FUNCTION
######################################################################
fit_linear<- function(x= runif(20), y = runif(20 )){
  ######################################################################
  #FUNCTION: fit_linear
  # PURPOSE: fits a s imple linear reg
  # INPUTS: numeric vector of predictors x and response y 
  # OUT: slope and p value

  my_mod<- lm(y~x) #model 

  #get values out

  my_out<-c(slope=summary(my_mod)$coefficients[2,1],
  p_value=summary(my_mod)$coefficients[2,4])

  #plot output 

  plot(x=x,y=y)
  return(my_out)
}
######################################################################
# END OF FUNCTION

var1<- 1:20
var2<- 21:40

fit_linear(x=var1, y=var2)



# START OF FUNCTION
######################################################################
fit_linear<- function(p = NULL){
  ######################################################################
  #FUNCTION: fit_linear
  # PURPOSE: fits a s imple linear reg
  # INPUTS: numeric vector of predictors x and response y 
  # OUT: slope and p value
  if(is.null(p)){
    p<- list(x=runif(20), y=runif(20))
  }

  my_mod<- lm(p$x~p$y) #fit the model

  # get the outputs
   my_out<-c(slope=summary(my_mod)$coefficients[2,1],
        p_value=summary(my_mod)$coefficients[2,4])

  #plot to check outputs 
  plot(x= p$x, y=p$y)
  return(my_out)
}
######################################################################
# END OF FUNCTION

fit_linear()

my_parms <- list(x= 1:10, y=sort(runif(10))) #create parameters in global
my_parms

fit_linear( p = my_parms) # pass in parameters

#for loop notes 

#z<- c(NA, NA, ... NA(10))

#for(i in 1:10 ){ # i is just a counter variable 
  # print(i) #output would return 1,2,3,4, etc> up to 10
  # print(z[i]) 

  # t <-x+y
  # z[i]<- t # would return vector of 10 stored as z 
#}






