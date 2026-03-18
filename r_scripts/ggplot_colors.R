#looking at colors and color mapping in ggplot
#BW
#24 feb gang

###############

install.packages("ggmosaic")
install.packages("colorblindr")
install.packages("colorspace")
install.packages("wesanderson") #color palette 
install.packages("ggsci")
install.packages("devtools")
library(devtools)

#had to download devtools to install some crap 
##########333333###########
devtools::install_github("wilkelab/cowplot")
devtools::install_github("clauswilke/colorblindr")
install.packages("colorspace", repo = "http://R-Forge.R-project.org")

########### 3/5/2026 George Lecture

library(ggplot2)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)

d<- mpg

my_cols<- c("green", "thistle", "tomato", "cornsilk", "chocolate") #list of colors to be used later 

demoplot(my_cols, "map") #just to see what a figure would look like with a set of colors 
demoplot(my_cols, "bar")
demoplot(my_cols, "perspective")


#working with black and white color schemes

#choose grey (0=black, 100 = white) - can then use ths to grey on a scale
my_greys<- c("grey20", "grey50", "grey80" )
demoplot(my_greys, "bar")


my_greys2<- grey(seq(from=0.1, to=0.9, length.out = 10))

demoplot(my_greys2, "heatmap")


p1<- ggplot(data=d,aes(x=as.factor(cyl), y=cty, fill= as.factor(cyl)))+geom_boxplot()

plot(p1)

#default colors look identical in black/white 
p1_des<- colorblindr::edit_colors(p1,desaturate) #see what colorblind ppl would see
plot(p1_des)

#transparency of images using the alpha 

x1<- rnorm(n=100, mean=0)
x2<- rnorm(n=100, mean=2.7)

d_frame<- data.frame(v1=c(x1,x2))
lab<- rep(c("Control","Treatment"), each=100)
d_frame<- cbind(d_frame,lab)

h1<- ggplot(d_frame)+ aes(x=v1, fill = lab)

h1+geom_histogram(position= "identity", alpha = 0.5, color="black")


#discrete classifications
#scale_fill_manual for boxplots or barplots 
#scale_color manual for points, lines 

#boxplot with no color 

p_fil<- ggplot(d,aes(x=as.factor(cyl), y=cty))+geom_boxplot()
p_fil


#boxplot with default fill colors - add fill arg in aes

p_fil2<- ggplot(d,aes(x=as.factor(cyl), y=cty,fill=as.factor(cyl)))+geom_boxplot()
p_fil2

#create a custom color palette 

my_cols<-c("red", "brown", "blue", "orange")

p_fil2 +scale_fill_manual(values=my_cols)


#scatterplot with no color 

p_col<- ggplot(d)+aes(x=displ,y=cty)
p_col+geom_point(size=3)

#scatterplot with default ggplot colors - uses "col" argument

p_col<- ggplot(d)+ aes(x=displ,y=cyl, col=as.factor(cyl))+geom_point(size=3)
p_col


#missed something here check lec notes 

#continuous classification color scale 

p_grad<- ggplot(d)+aes(x=displ, y=cty, col=hwy) +geom_point(size=3) #didnt use as.factor so colored continuously 

p_grad


#custom gradient (specify the colors)

p_grad+scale_color_gradient(low="green", high="red")




#custom diverging gradient 3 cols 

mid<- median(d$cty)

p_grad+scale_color_gradient2(midpoint=mid,low="blue", mid="white", high="red")

#custom divergent (n-colors)

p_grad+scale_color_gradientn(colors=c("blue", "green", "yellow", "purple", "orange"))


#color palettes 

library(wesanderson)

print(wes_palettes) #view the names of the palettes 


demoplot(wes_palettes$BottleRocket1) #see how they look with diff palettes 

demoplot(wes_palettes[[2]][1:3], "bar") #can index out of the list
demoplot(wes_palettes[[2]][1:3], "pie") 

#colorbrewer palettes

library(RColorBrewer)

display.brewer.all()


demoplot(brewer.pal(4,"Accent"),"bar")
demoplot(brewer.pal(11,"Spectral"),"heatmap")

library(scales)
my_cols<- c("grey75", brewer.pal(3,"Blues"))
show_col(my_cols)


#viridis palette -- He ran a whole heatmap code to show the palette 

#p4+scale_fill_viridis_c() >>>>>>>>>>>>>>>> will scale fill automatically using the viridis palette 

#p4+scale_fill_viridis_c(option="inferno")
#p4+scale_fill_viridis_c(option="cividis")
#p4+scale_fill_viridis_c(option="plasma")














