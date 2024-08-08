library(caret)   
library(ggplot2)

data(marketing, package = "datarium")
dim(marketing)
str(marketing) #show data type of each variable and first 5 observations
summary(marketing) #check if there are NA's in the dataset
ggplot(marketing, aes(sales)) +geom_histogram()#show distribution of outcome variable sales

#For a dataset with a small number of variables, pairs.panels is a better graphic to show relationships between variables and distribution of each variable simultaneously.
library(psych)
pairs.panels(marketing,method = "pearson", hist.col =  "steelblue",
             pch = 21, density = TRUE, ellipses = FALSE )
#You can see that variables youtube and facebook are highly related to sales but newspaper is not.
