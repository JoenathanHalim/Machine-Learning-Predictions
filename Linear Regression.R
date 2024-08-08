library(caret)   
library(ggplot2)

data(marketing, package = "datarium")
dim(marketing)
str(marketing)

set.seed(100)
training.idx <- sample(1: nrow(marketing), size=nrow(marketing)*0.8)
train.data  <-marketing[training.idx, ]
test.data <- marketing[-training.idx, ]

lmodel<- lm(sales~., data = train.data)
summary(lmodel)
#r-sq=0.8925, The linear regression model with 3 predictors explains 89% variation in the sales data
predictions <-predict(lmodel, test.data)
RMSE(predictions, test.data$sales)
#  1.95369 which is a bit bigger than that of kNN 
plot(test.data$sales, predictions, main="Prediction performance of linear regression")
abline(0,1, col="red")
##Accurate prediction is achived, but prediction of the kNN is slightly better.
#check residual plots
par(mfrow=c(2,2))
plot(lmodel)
par(mfrow=c(1,1))
#The residual plot shows an outlying point #131 and a quadratic pattern indicating that 2nd order predictors may be needed. 

##4.To improve linear regression by adding second order terms in regression
#From pairs.panel plot, two predictors youtube and facebook are highly related to sales.
#Then we add square terms of both predictors in the regression. 
lmodel.2<- lm(sales~youtube+facebook+newspaper+I(youtube^2)+I(facebook^2), data = train.data)
summary(lmodel.2)
#r-sq= 0.918
predictions <-predict(lmodel.2, test.data)
RMSE(predictions, test.data$sales)
#RMSE=1.954943, does not reduced, which shows that the model does not improve its prediction.

#We can consider to add another 2nd order term: the interaction between both predictors youtube and facebook. 
lmodel.2<- lm(sales~youtube+facebook+newspaper+I(youtube^2)+I(youtube*facebook)+I(facebook^2), data = train.data)
summary(lmodel.2)
#r-sq increases to 0.98. this improved regression model can explain almost all variation in data. 
#predictors youtube, youtube^2 and interaction youtube*facebook are strongly significant in the model.

predictions <-predict(lmodel.2, test.data)
RMSE(predictions, test.data$sales)
#RMSE=0.5134645 which decreases a lot from the Knn and previous regression models.
##so adding all second order terms of youtube and facebook improves the prediction considerably in this example.
plot(test.data$sales, predictions, main="Prediction performance of linear regression")
abline(0,1, col="red")
#all predicted values are very close to the true values of sales in the test set.

#check residual plots of the improved regression model 
par(mfrow=c(2,2))
plot(lmodel.2)
par(mfrow=c(1,1))
##Residual plot shows a horizontal line at 0, no clear quadratic pattern.
##The model fitting now is good enough though observation 131 is still outlying. 
##We can choose this quadratic regression model as a final model for prediction due to its very small RMSE.
##It can be seen from the trained linear model that advertising on both youtube and facebook has significant/important impacts on the sales.
