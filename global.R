rm(list = ls())
library(ggplot2)
library(dplyr)
library(class)
library(caret)
library(shiny)


ds.classes <- rep("numeric", 14)
ds <- read.table("C:/Users/Chris/Dropbox/OpenData/heartDiseaseData/processed.cleveland.data", sep = ",", header = F)


names(ds) <- c( "age", "sex", "cp",
                "trestbps", "chol",
                "fbs", "restecg",
                "thalach","exang",
                "oldpeak","slope",
                "ca","thal","num")

ds <- as.data.frame(apply(ds, 2, as.numeric))
ds <- na.omit(ds)
ds$num[ds$num > 0] <- 1
attach(ds)

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