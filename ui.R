#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Shiny Application: K-means clustering project"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "dataset",
        label = "Choose dataset",
        choices = c("iris", "mtcars", "quakes")
      ),
      
      selectInput('xvar', 'X variable', names(iris)),
      
      selectInput('yvar',
                  'Y variable',
                  names(iris),
                  selected = names(iris)[[2]]),
      
      numericInput('clusters', 'Cluster count', 3, min = 1, max = 9),
      
      numericInput(
        'maxiter',
        'Maximum iterations',
        10,
        min = 1,
        max = 100
      ),
      
      uiOutput("ui")
    ),
    
    mainPanel(
      plotOutput('plot1'),
      htmlOutput("str_paragraph_title"),
      verbatimTextOutput("str_dataset")
    )
  )
))
