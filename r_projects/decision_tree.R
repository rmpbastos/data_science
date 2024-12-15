# Load required libraries
library(datasets)    # For the iris dataset
library(caTools)     # For splitting the dataset into train and test sets
library(rpart)       # For training the Decision Tree model
library(rpart.plot)  # For visualizing the Decision Tree
library(caret)       # For model evaluation and feature importance
library(dplyr)       # For data manipulation

# Load the iris dataset
data(iris)

# Explore the dataset
head(iris)       # Display the first few rows of the dataset
summary(iris)    # Provide a statistical summary of each feature
str(iris)        # Display the structure and data types of the dataset

# Split the data into training and testing sets
set.seed(100)    # Ensure reproducibility of the random split
sample_split <- sample.split(Y = iris$Species, SplitRatio = 0.7)  # 70% training, 30% testing
train_set <- subset(x = iris, sample_split == TRUE)
test_set <- subset(x = iris, sample_split == FALSE)

# Train a Decision Tree model
dt_model <- rpart(Species ~ ., data = train_set, method = "class")
print(dt_model)

# Visualize the Decision Tree
rpart.plot(dt_model)

# Calculate feature importance
feature_importance <- varImp(dt_model)
feature_importance %>% arrange(desc(Overall))

# Make predictions on the testing set
predictions <- predict(dt_model, newdata = test_set, type = "class")
print(predictions)

# Evaluate the model using a confusion matrix
confusionMatrix(test_set$Species, predictions)  # Compare predictions with actual species



