## 2/19/2026
#Bryan Wilcenski
#ggplot2

# making up for the lack of ggplot2 experience
##need to lock in this class--bombed out on the lecture prior to this one (for loops 2)


##GGPLOT1 
#load in ggplot package in positron or library("ggplot2", lib.loc = "C:/Users/bwilcens/AppData/Local/R/win-library/4.5")

# aes (which kayers go where)
# geom_FUNCTION (format of the type of plot ) e.g. bar plot, box plot, etc.
  #can have a scatter, and a best fit line, or other combinations etc
  #stat=
  #position= place things on the plot using x and y coords 

#store the plot to an object (e.g. p1<- ggplot(~~~~~))

#required packages for this script 
library(ggplot2)
#install.packages("patchwork")
#install.packages("ggthemes")

library(patchwork)
library(ggthemes)

#load our dataset (included: mpg)
d<- mpg

# first call to ggplot : hist 

ggplot(data= d) +
  aes(x=hwy) +      #don't need dollar sign once data set is loaded into ggplot
  geom_histogram() 

#copied down now adding stuff: change colors

ggplot(data= d) +
  aes(x=hwy) +      #don't need dollar sign once data set is loaded into ggplot
  geom_histogram(fill="slateblue", color = "black") # "fill" is inside hist, "color" is border

## density plot (looks like hist but does smooth line)

ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill="mintcream")

# scatter plot 

ggplot(data=d) +
  aes(x=displ, y = hwy)+
  geom_point() + #draw dots (scatter plot)
  geom_smooth() + #default lowess curve
  geom_smooth(method="lm", col="red")


# box plot

ggplot(data=d) +
  aes(x=fl, y= cty) +
  geom_boxplot(fill = "thistle", color="blue")

#basic bar plot

ggplot(data=d) +
  aes(x=fl) +
  geom_bar()


# barplot with y response 

x_treatment<- c("control", "low", "high")
y_response<- c(12,2.5,22)
summary_data<- data.frame(x_treatment,y_response)

ggplot(data= summary_data) +
  aes(x = x_treatment, y = y_response) +
  geom_col(fill = c("grey50","goldenrod","goldenrod", color = "blue"))


#plotting curves 

my_vec<- seq(1,100,by= 0.1)

#plot simple func
d_frame<- data.frame(x=my_vec, y = sin(my_vec))


#plot lines

ggplot(data = d_frame)+
  aes(x=x, y=y) + #x that is passing in comes from line 87
  geom_line()


d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape = 5, scale = 3))
d_frame

ggplot(data = d_frame)+
  aes(x=x, y=y) + #x that is passing in comes from line 87
  geom_line()

#### themes and fonts

p1<- ggplot(data = mpg, mapping = aes(x=displ, y=cty)) + #can put mapping in the initial ggplot func
  geom_point() + 
  theme_classic() #classic theme 

#some diff themes can be added after

p1 + theme_minimal()
p1 + theme_linedraw() #gas
p1 + theme_dark()
p1 + theme_base()
p1 + theme_void() #removes all and then you add after
p1 + theme_par() # pulls current plotting paramters from r itself -- if you change them then this will use changed ones


#  font sizes ( BIG KEY )

p1 + theme_classic(base_size = 30 , base_family="serif") #font size and font type

#code for adding additional fonts 

library(extrafont)


#using other fonts

p1 + theme_classic(base_size=30,
                  base_family ="chalkduster")
print(p1)

#coordinate flopping in ggplot



p2<- ggplot(data=d,mapping=aes(x=fl,fill=fl))+ #fill function within aes can colorize cats using the stuff
  geom_bar() +
  labs(fill="Fuel Type",x = "Fuel Type", y = "Count") +
  theme(legend.position = c(.2,.8)) #place legend on the 
print(p2)


p2+coord_flip() + 
  theme_grey(base_size=20, base_family = "sans") #coordinate flip happens here


#setting x and y limits

#useful if you want mult figures to have the same y axis (so they can be alongside eachother)

p2 <- ggplot(data=d,mapping=aes(x=displ,y=cty)) + #fill function within aes can colorize cats using the stuff
  geom_point() +
  theme_bw(base_size=20) +
  xlim(0,8)+
  ylim(8,30) 

 print(p2)


# #########################################
# multipanel plots 
 
install.packages("patchwork")
install.packages("ggthemes")

library(patchwork)
library(ggthemes)

g1 <-ggplot(data=d)+
  aes(x= displ, y= cty) +
  geom_point() +
  geom_smooth()
g1

g2 <- ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill = "tomato", color = "black")
g2


g3<- ggplot(data = d) +
  aes(x=displ) +
  geom_histogram(fill= "royalblue", color="black")
g3

g4 <- ggplot(data=d) + 
  aes(x=fl,y=cty, fill =fl) +
  geom_boxplot()+
  theme(legend.position = "none")
g4

 #patchwork to combine 
g1+g2

g1 + g2 + g3 +plot_layout(ncol=1) #layout organization like matrix 


#changing area of each plot

g1+g2 +plot_layout(ncol=1, heights =c(2,1)) #heights takes vector of weights (top is twice as tall in this case)

g1+g2 +plot_layout(ncol=2, widths =c(1,2)) #change widths 



#add a spacer 

g1+ plot_spacer() + g2 


#nested layouts

g1+ {
  g2 +{
    g3 +
      g4 +
      plot_layout(ncol=1)  #layout for g3 and g4
  }
} +
  plot_layout(ncol=1) #laout for g1 and then the other three groupes

# - operator for subtrack placement

g1 + g2 - g3 + plot_layout(ncol=1) # - symbor returns full size plot 

# using | amd \ 
(g1 | g2 | g3 )/g4 #same method as subtrack

# add global titles
(g1 | g2 | g3 )/g4 + plot_annotation("Title Here",
caption = "made this in patchwork")



# adding tags

g1/ (g2|g3)+
  plot_annotation(tag_levels = "1")


###############################
# multi panel plots with facet

m1 <- ggplot(data = d) +
  aes(x=displ, y =cty) +
  geom_point() + 
  geom_smooth(method=lm)

#using facet grid
m1 + facet_grid(class ~ fl, scales = "free_y") #enables y axis scales to adapt to data 


# facet for only one variable
m1 +facet_grid(class~.)

# facet wrap  (one variable, three columns )

m1 +facet_wrap(~class)

m1 +facet_wrap(~class +fl) #will remove nonexistant combinations (can use drop = F to return them to chart)




