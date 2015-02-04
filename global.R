rm(list = ls())
library(ggplot2)
library(dplyr)
library(class)
library(caret)
library(shiny)

# read in data and preprocess ####
ds <- read.csv("processed.cleveland.data",  header = F)
# add names to dataset
names(ds) <- c( "age", "sex", "cp",
                "trestbps", "chol",
                "fbs", "restecg",
                "thalach","exang",
                "oldpeak","slope",
                "ca","thal","num")
# change the class of all columns to numeric
ds <- as.data.frame(apply(ds, 2, as.numeric))
# remove na/missing values (original data shows as ?)
ds <- na.omit(ds)
# all values of num > 0 are cases of heart disease 
# as per the data descriptions at the uci repository
ds$num[ds$num > 0] <- 1

# standardize/normalize the data
standardized.X <- scale(ds[,-14])
set.seed(55)
features <- 1:3
training.index <- createDataPartition(ds$num, p = .5,list = F)
train.X <- standardized.X[training.index, features]
test.X  <- standardized.X[-training.index, features]
train.Y <- num[training.index]
test.Y <- num[-training.index]

table.settings <- list(searching = F, pageLength = 5, bLengthChange = F,
                       bPaginate = F, bInfo = F )