install.packages(c("tidyverse","caret","readxl"))
library(tidyverse)
library(caret)
library(readxl)

House_Price_India <- read_excel("C:/Users/User/Desktop/Nampet/Data_camp/Data_rockie/ML/House Price India.xlsx")
glimpse(House_Price_India)
view(House_Price_India)


# train test split
# 1. split data
ggplot(data = House_Price_India, aes(x=Price)) + geom_histogram()
price_log <- log(House_Price_India$Price)


ggplot(data = House_Price_India, aes(x=price_log)) + geom_histogram()

set.seed(42)
tr_ts_data <- function(data, trainRatio = 0.7) {
  n <- nrow(data)
  id <- sample(1:n, size = trainRatio*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(
    list(train = train_data, test = test_data)
  )
}

set.seed(42)
split_data <- tr_ts_data(House_Price_India, 0.8)
train_data <- split_data$train
test_data <- split_data$test

# 2. train
set.seed(42)
ctrl <- trainControl(
  method = "cv", # k-fold golden standard
  number = 5, # k=5
  verboseIter = TRUE
)

lm_method <- train(Price ~ `number of bedrooms` + `number of bathrooms` + `living area` + `lot area` + `grade of the house` , 
                   data = train_data,
                   methods = "lm",
                   trControl = ctrl)

rf_method <- train(Price ~ `number of bedrooms` + `number of bathrooms` + `living area` + `lot area` + `grade of the house` , 
                   data = train_data,
                   methods = "rf",
                   trControl = ctrl)

knn_method <- train(Price ~ `number of bedrooms` + `number of bathrooms` + `living area` + `lot area` + `grade of the house` , 
                   data = train_data,
                   methods = "knn",
                   trControl = ctrl) 



# 3. score
p_lm <- predict(lm_method, newdata = test_data)
p_rf <- predict(rf_method, newdata = test_data)
p_knn <- predict(knn_method, newdata = test_data)

# 4. evaluate
mae_metric <- function(actual, prediction) {
  # mean absolute error
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction) {
  # mean squared error
  sq_error <- (actual - prediction)**2
  mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
  # root mean squared error
  sq_error <- (actual - prediction)**2
  sqrt(mean(sq_error)) 
}

mae_metric(log(test_data$Price), p_lm)

