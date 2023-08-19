
# Predict house prices in India with "Linear Regression" and "K-Nearest Neighbor(knn)" in R programming.

#===========================================================================================================================

# Install package
library(tidyverse)
library(caret)
library(readxl)

# read excel
House_Price_India <- read_excel("C:/Users/User/Desktop/Nampet/Data_camp/Data_rockie/Live09_Essentrial_ML/House Price India.xlsx")

# view data
glimpse(House_Price_India)
view(House_Price_India)

#----------------------------------------------------------------------------------------------------------------------------
#1. Split data
train_test_split <- function(data, trainRatio=0.8) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size=trainRatio*n) # sampling observation from 1-n, size(no. of sampling) = % * n
  train_data <- data[id, ]
  test_data <- data[-id, ]
  
  list(train=train_data, test=test_data) 
}

split_data <- train_test_split(House_Price_India,0.8)
train_data <- split_data$train
test_data <- split_data$test

#----------------------------------------------------------------------------------------------------------------------------
#2. Train model
lm_model <- train(log(Price) ~ `number of bedrooms` + `number of bathrooms` + `number of floors` + `number of views` + `Number of schools nearby` + `Distance from the airport`,
            data = train_data,
            method = "lm")


knn_model <- train(log(Price) ~ `number of bedrooms` + `number of bathrooms` + `number of floors` + `number of views` + `Number of schools nearby` + `Distance from the airport`,
            data = train_data,
            method = "knn")
#----------------------------------------------------------------------------------------------------------------------------
#3. Test model
pred <- predict(lm_model, newdata = test_data)

#----------------------------------------------------------------------------------------------------------------------------
#4. Evaluate
#RMSE
rmse_metric <- function(actual, prediction){
  sqrt(mean((actual - prediction)**2))
}

#MAE
mae_metric <- function(actual, prediction){
  mean(abs(actual - prediction))
}

#MSE
mse_metric <- function(actual, prediction){
  mean((actual - prediction)**2)
}

rmse_metric(log(test_data$Price),pred)
mae_metric(log(test_data$Price),pred)
mse_metric(log(test_data$Price),pred)

