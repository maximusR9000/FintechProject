#Installing required packages
install.packages(c("tidyverse", "caret", "rpart", "randomForest", "rpart.plot"))

#Setting current working directory for easy accessing the .csv files
setwd("/Users/maximus/Downloads/Notes/Fintech /Project/archive")


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

treeModel = rpart(Loan_Status ~ ., data = trainData, method = "class")

rpart.plot(treeModel)
