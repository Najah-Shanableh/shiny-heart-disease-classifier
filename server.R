
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
 
library(shiny)

shinyServer(function(input, output) {
  
  set.seed(1)
  observe({
  knn.pred <- knn(train.X[,input$checkGroup], test.X[,input$checkGroup], train.Y, k = input$k)
 
  # percent error from predictor
  
  # percentage of test set which do NOT say "no" (very small percentage purchase)
  # therefore we are more interested in correct prediction of those which do 
  # purchase 
 
  
#   correct.detection <- 100*confusion.matrix[2,2]/sum(confusion.matrix[2,]) 
#   print(correct.detection)
#   
  output$LBITable <- renderDataTable({
    # modify this to show title - confusion matrix
    # /false positive/positive false negative/negative
    true.positive    <- sum(knn.pred == 1 & test.Y == 1)
    false.positive   <- sum(test.Y == 1) - true.positive
    true.negative    <- sum(knn.pred == 0 & test.Y == 0)
    false.negative   <- sum(test.Y == 0) - true.negative
    row.names <- c("Prediction - FALSE", "Prediction - TRUE" )
    col.names <- c("Reference - FALSE", "Reference - TRUE")
    cbind(Outcome = row.names, as.data.frame(matrix( 
      c(true.negative, false.negative, false.positive, true.negative) ,
            nrow = 2, ncol = 2, dimnames = list(row.names, col.names))))
#     cf.matrix <- as.data.frame(confusionMatrix(knn.pred, test.Y)[["table"]])
    }, options = table.settings
  )

  })
   output$value <- renderPrint({ (input$checkGroup) })
   
})
