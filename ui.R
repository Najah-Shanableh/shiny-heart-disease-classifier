
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Classification of Heart Disease w/KNN"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("k",
                  "number of neighbors",
                  min = 1,
                  max = 20,
                  value = 5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput('LBITable')
    )
  ),
  checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                     choices = feature.list,
                     selected = 2),
  
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
))
