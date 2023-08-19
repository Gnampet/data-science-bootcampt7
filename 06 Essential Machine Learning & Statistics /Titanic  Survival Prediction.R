
# In this session, I have predicted the survival rate of passengers in the "Titanic" data set with the "Linear Regression" model. 
# Caret is the important library in this part that enables you to train different types of algorithms.

#===========================================================================================================================

# Install packages
install.packages("titanic")
library("titanic") # for the Titanic data set
library("tidyverse")
library("caret")

titanic_train

#----------------------------------------------------------------------------------------------------------------------------
# Explore data set
head(titanic_train)
glimpse(titanic_train)

# Delete NA
df <- na.omit(titanic_train)

# Check the number of observation
nrow(df)

#----------------------------------------------------------------------------------------------------------------------------
# Split data
set.seed(42)
n<- nrow(df)
id<- sample(1:n, size = n*0.7)
train_df <- titanic_train[id, ]
test_df <- titanic_test[-id, ]

# Check train and test data
nrow(train_df)
nrow(test_df)

# Check errors in columns "Survived" and "Age" 
sum(is.na(train_df$Survived))
sum(is.na(train_df$Age))

# Replace NA by "Blank space"
train_df$Age[is.na(train_df$Age)] <- ""

#----------------------------------------------------------------------------------------------------------------------------
# Train Model
model_ttn <- glm(Survived ~ Age, data = train_df, family = "binomial" )
summary(model)

#----------------------------------------------------------------------------------------------------------------------------
# Create prediction
train_df$prob_survived <- predict(model_ttn, type = 'response')
train_df$pred_survived <- ifelse(train_df$prob_survived >=0.5,"1","0")

#----------------------------------------------------------------------------------------------------------------------------
# Evaluate prediction
mean(train_df$pred_survived == train_df$Survived) 

# Create a Confusion matrix
conM <- table(train_df$pred_survived, train_df$Survived, dnn = c("Survived","Dead"))

cat("Accuracy: ",(conM[1,1] + conM[2,2])/ sum(conM))
cat("Precision: ",conM[2,2] / (conM[2,1] + conM[2,2]))
cat("Recall: ", conM[2,2]/ (conM[1,2]+ conM[2,2]))
cat("F1: ", 2*((0.648*0.4196891)/(0.648+0.4196891)) )
