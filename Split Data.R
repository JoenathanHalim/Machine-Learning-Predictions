library(caret)   
library(ggplot2)

data(marketing, package = "datarium")
dim(marketing)
str(marketing)

set.seed(100)
training.idx <- sample(1: nrow(marketing), size=nrow(marketing)*0.8)
train.data  <-marketing[training.idx, ]
test.data <- marketing[-training.idx, ]
