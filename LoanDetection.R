#Installing required packages
install.packages(c("tidyverse", "caret", "rpart", "randomForest", "rpart.plot"))

#Setting current working directory for easy accessing the .csv files
setwd("/Users/maximus/Downloads/Notes/Fintech /Project/FintechProject/archive")


#Loading libraries
library(tidyverse)
library(caret)
library(rpart)
library(randomForest)
library(rpart.plot)

loanData = read_csv("train_u6lujuX_CVtuZ9i.csv")
loanData = na.omit(loanData)

loanData = subset(loanData, select = -Loan_ID)

View(loanData)

set.seed(123)
trainIndex = createDataPartition(loanData$Loan_Status, p = 0.8, list = FALSE)
trainData = loanData[trainIndex, ]
testData = loanData[-trainIndex, ]


#Decision Tree Model
treeModel = rpart(Loan_Status ~ ., data = trainData, method = "class")

rpart.plot(treeModel)

treePrediction = predict(treeModel, testData, type = "class")
confusionMatrix(treePrediction, as.factor(testData$Loan_Status))

#Random Forest Model
set.seed(123)
rfModel = randomForest(as.factor(Loan_Status) ~ ., data = trainData, ntree = 100)
rfPrediction = predict(rfModel, testData)
confusionMatrix(rfPrediction, as.factor(testData$Loan_Status))
