
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
`<-`(yy,5) #even the assignment operator can be called as a function
yy


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
