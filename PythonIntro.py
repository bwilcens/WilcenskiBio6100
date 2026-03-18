# Intro to Python 
# 3/17/2026



#installing libraries:

import numpy as np 
import pandas as pd
import matplotlib.pyplot as plt

# need to specify which package you are drawing a function from (e.g. mean below specified as part of np)
# np.mean()


#################################
# Objects, Methods, and Functions:
#################################

#need to use print() unlike r -- must be explicit 

print("I love Python")

greeting = "Hello"

print(greeting)

scaler = 6    #integer value 

out = scaler * 3 #doing math with an obj

print(out)

myList = [34, 7, 98] #create a list

myList.append(33) #this uses a method to change the actual object -- do no need to call it 

len(myList) #performing a function on the list (len()=length)


### Data Structures
# ##################

#make list of cols 

a_list = ["blue", "green", "red"]
print(a_list)

# indexing into a list 

first_el = a_list[0]

print(first_el)


# looking at data types

nums = [1,2,5,8]
chars = ["a","b", "c"]
boolean = [True, True, False]


# mixed lists 

mixed = [1,2,True,"blue", 5]


#checking data types
type(nums[0])

#type returns highest level object type -- eg- result from above 

# negative indexing [-1]

print(mixed[-1]) #will return last element
print(mixed[-3]) # will return third element from right


#ranged indexing
print(mixed[1:4]) #not inclusive at end of the list ------ inclusive at the beginning, not at the end
print(mixed[:4]) #start at beginning 
print(mixed[2:]) #start at 2

#is item in the list

1 in mixed # will return a boolean to say whether something is in the mix




# changing elements
mixed[4] = "green" # index into a list
print(mixed)

mixed.insert(0,"start") # inserts something into the list without changing the rest of the characters

mixed

# other methods to change elements 
# extend
# remove
# pop
# clear








