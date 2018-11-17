#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  datasetInput <- reactive({
    switch(
      input$dataset,
      "mtcars" = mtcars,
      "iris" = iris,
      "quakes" = quakes
    )
  })
  
  observe({
    selectedDataset <- datasetInput()
    
    updateSelectInput(session, "xvar", choices = names(selectedDataset))
    updateSelectInput(
      session,
      "yvar",
      choices = names(selectedDataset),
      selected = names(selectedDataset)[[2]]
    )
  })
  
  plotData <- reactive({
    d <- datasetInput()
    if (input$xvar %in% names(d) & input$yvar %in% names(d)) {
      return(d[, c(input$xvar, input$yvar)])
    }
  })
  
  clusters <- reactive({
    kmeans(plotData(), input$clusters, input$maxiter)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5, 4, 0, 1))
    p <- plotData()
    req(p)
    plot(p,
         col = clusters()$cluster,
         pch = 20,
         cex = 2)
    points(clusters()$centers,
           pch = 8,
           cex = 2,
           lwd = 2)
  })
  
  output$str_paragraph_title <- renderText({
    HTML(paste(
      "<h4>Structure of ",
      "<b><i>",
      input$dataset,
      "</b></i>",
      " dataset</h4>"
    ))
  })
  
  output$str_dataset <- renderPrint({
    str(datasetInput())
  })
  
})
