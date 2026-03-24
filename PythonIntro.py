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
# remove - detes something
# pop - data stacks - allows you to remove an item (row), 
# clear

mixed.remove("start")

last = mixed.pop()
mixed



# list comprehension
print(mixed)

[x for x in mixed]

[x for x in mixed if isinstance(x,str)] #basically a for loop in one line
 # this stuff is not crucial given that numpy can do many of the same things


###########################################
# dictionaries: 
###########################################

#manually coding a dictionary
md = {
    "first":"John",
    "last" : "Smith",
    "year" : 2017,
    "status": "active"
}

#creating dictionary with constructor func
md2 = dict(first = "John", Last = "Smith", )

type(md) #what type this is 
type(md2)
len(md) # gives length of pairs

# data types within a dictionary 
dataTypes = {
    "string": "thing",
    "integer":3,
    "float" : 3.14342,
    "list" : [1,2,3,"a"],
    "boolean": False
}


#square brackets with name of the key will return the value under that name 
dataTypes["string"] 

#built in method
dataTypes.get("boolean")

# return all keys and values using methods in dictionary 
dataTypes.keys()
dataTypes.values()

#return as a list of touples (key and value)
dataTypes.items()

#add element
dataTypes["age"] = 36

#can also edit individual items in dictionary
dataTypes["age"] =35
dataTypes

####################################################################
# NUMPY
####################################################################
# import numpy as np (make sure this has been done after you install numpy with terminal )



arr1 = np.array([0,1,2,3,4,5,6,7,8,9])

#can index from
arr1[3]
arr1[-1]
arr1[:3]
arr1[1:5]
arr1[1:8:2] #gets every other (:2) between 1 and 8

# 2d array
arr2= np.array([[1,2,3],[4,5,6],[7,8,9]])
arr2

arr2[2,2]

arr2[:,2] # colon is placeholder for everything
arr2[2,:]
arr2[0:2,0:2] #why doesnt this return the fiull array??????????????????????????????

#3d array 
arr3= np.array([[[1,2],[3,4]],[[5,6],[7,8]]])
arr3

# 3D indexing
arr3[1,0,1]

# number of dimensions 
arr1.ndim
arr2.ndim
arr3.ndim

# shape of n array 
arr1.shape
arr2.shape
arr3.shape

arr2.dtype # will tell you what is contained in the array
arr2.astype(str)

# reshape an array
 
arr1
arr1.shape
arr1.reshape(2,5)

#3d array reshape 

arr3
arr3.shape
arr3.reshape(4,2)

# combining arrays 

first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

longArray = np.concatenate((first,second))
longArray

#select axis for higher dims
newStack = np.concatenate((arr2,arr2), axis = 1)

newStack
newStack.shape

#stacking arrays 

newStack= np.stack((arr2, arr2))
newStack.shape

# splitting arrays 

np.array_split(arr1, 2) #split the array into two equal parts
np.array_split (arr1,2,axis = 0)

# import random module (random numvber generating)

from numpy import random

random.seed(seed=100)
random.randint(50) #value from 0 to 50 
random.rand(50) # 50 vals 0 to 1
random.rand(50, 5, 10) # five by ten array 
random.choice(arr1) #random number from array 1 
random.choice(arr1, size = (3,3))
random.choice([0,1], p = [.3,.7],size=100) #pull from 0,1 array 100 times, 0 pulled at prop 30%, 1 pulled at prob 70%

x = random.normal(loc=5, scale=3, size=200)

plt.hist(x)
plt.show()

x=random.binomial(n=10, p=0.5,size=300)

plt.hist(x)
plt.show()

x= random.uniform(low=1,high=10, size=50)
plt.hist(x)

#math

#math between arrays 
# same as r 

#need to use numpy to multiply through (vectorized operations) matrix ops, etc.
x*100
arr2
arr2*arr2

np.mean(arr2) #find mean of whole array 
np.max(arr2)

#####################################################################################
#logic structures 
#####################################################################################

#if stat.print 

a=3

if a>=5:
    print("a is greater than or equal to 5") #will print nothing if the condition is not met, text if it is 

# if with an else statement 
if a >=5:
    print("a is greater than or equal to 5")
else:
    print("a is less than 5")

a=3
b=3
operation = "exp"

if operation == "mult":
    y=a*b
elif operation== "div":
    y=a/b
elif operation=="add":
    y=a+b
elif operation=="sub":
    y=a-b
else:
    "I don't know this operation"

print(y)

###################################
#Loops 
###################################

l= [10, 20]
for i in range(2):
    print(l[i])

#loop on an object directly
 
x=["blue", "green", "red"]
for i in x:
    print(i) #in this case, i is actually the object (don't need to index into the counter -- python stuff)

rnd = random.uniform(low = 1, high = 5, size = 10)

outList = [] #create truly empty list 

arr1 #length 10 
rnd # random list of length 10

for i in range(len(arr1)):
    outList.append(rnd[i]+arr1[i])  #creates list of ten floats, containing floats that add ith value of two diff arrays 
outList 

#nested loop with ifelse 

rnd2D = random.uniform(low = 0, high = 1, size= (3,3)) # 3 by 3 array contianing random uniform vals 

matOut = np.empty(shape=(3,3)) # should create empty array in same dimensions, but copied down 3,3 array from above 
#unclear why it would do this - "slick"

shp = rnd2D.shape # keep in mind the dimensions of this shp object

# nested loop
for i in range(shp[0]):
    for j in range(shp[1]):
        if rnd2D[i,j]>=0.5:
            matOut[i,j] = rnd2D[i,j] * 1000
        else:
            matOut[i,j]= rnd2D[i,j] / 1000

matOut

#######################################################
# pandas -- equivalent of data frames in python 
#######################################################

dates = pd.date_range("20130101", periods = 6) #date uses yyyymmdd
dates


df=pd.DataFrame(np.random.randn(6,4), index = dates, columns = ["a", "b", "c", "d"])

df.head(4)
df.tail(4)
df.index # pulls the row index names 
df.columns  # pulls the column index names

df.describe

df.to_numpy() # numpy conversion 
#indexing into pandas
df["a"]

df.loc[:, ["a","b"]]
df

## tuff above was a cluster f, need to redo 

ds = pd.read_csv("iris.data.csv")
ds


ds["sepal_length"] #pulling out column


ds["sepal_area"] = ds.sepal_length * ds.sepal_width #create a new column in dataset 

ds.head() #view 

#fully numeric filter (if something is not meeting a criteria, make it NaN)
df[df>0.5]
