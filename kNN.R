library(caret)   
library(ggplot2)

data(marketing, package = "datarium")
dim(marketing)
str(marketing)

set.seed(100)
training.idx <- sample(1: nrow(marketing), size=nrow(marketing)*0.8)
train.data  <-marketing[training.idx, ]
test.data <- marketing[-training.idx, ]

set.seed(101)
model <- train(
sales~., data = train.data, method = "knn",
  trControl = trainControl("cv", number =4),
  preProcess = c("center","scale"),
  tuneLength = 10  #try 10 possible values of k to select the best one.
)
#In option trControl, you need to specify the number of folds used in cross validation (cv), which divides the train.data into several equal-size groups (i.e. folds),
#such that size(each fold) is sufficiently large, say at least 40. The number of folds also depends on the size of the training data set. If size(train.data) is big (more than several hundreds), then we alway use 10-fold cv. Otherwise use 4- or 5-fold cv for a relatively small training data set. 
#Now size(train.data)=160, 160/4=40, thus we set the number of folds=4. 

# Plot model error RMSE vs different values of k
plot(model)
# Best tuning parameter k 
model$bestTune
#k=5
#Compute the prediction error RMSE
predictions<-predict(model, test.data)
RMSE(predictions, test.data$sales)
#1.366957
#visualize the prediction results
plot(test.data$sales, predictions,main="Prediction performance of kNN regression")
abline(0,1, col="red")
## Very accurate prediction is obtained by Knn.

