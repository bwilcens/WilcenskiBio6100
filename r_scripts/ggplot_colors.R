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




