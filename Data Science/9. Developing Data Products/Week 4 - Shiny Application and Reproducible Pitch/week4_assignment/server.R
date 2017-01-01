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
shinyServer(function(input, output) {
  output$scatterPlot <- renderPlot({
    # 1.1 Generating and plotting Exponential Distribution
    dsExp = rexp (input$noSim, input$lambda)
    
    # 1.2 Exponential Distribution mean calculation
    vectMeans = NULL
    for (i in 1:input$noSim) vectMeans = c (vectMeans, mean (rexp(input$noExp, input$lambda)))
    
    plot (dsExp, pch=19, cex=0.6, main=paste("The exponential distribution \nwith ",
                     "lambda=",input$lambda,"and \n",input$noSim," observations",sep=" "), ylab="rexp (noSim, lambda)")
  })
  output$histPlot1 <- renderPlot({
    # 1.2 Exponential Distribution mean calculation
    vectMeans = NULL
    for (i in 1:input$noSim) vectMeans = c (vectMeans, mean (rexp(input$noExp, input$lambda)))
    hist (vectMeans, col="yellow", 
          main="Exponential Distribution's \nmean distribution", 
          breaks = 40, xlab="Means")
    rug (vectMeans)
  })
  output$histPlot2 <- renderPlot({
    # 1.2 Exponential Distribution mean calculation
    vectMeans = NULL
    for (i in 1:input$noSim) vectMeans = c (vectMeans, mean (rexp(input$noExp, input$lambda)))
    hist(vectMeans, col="red", 
         main="Theoretical Mean vs \nActual Mean for \nExponential Distribution",
         breaks=20, xlab="Means")
    abline(v=mean(vectMeans), lwd="4", col="green")
  })
  output$histPlot3 <- renderPlot({
    # 1.2 Exponential Distribution mean calculation
    vectMeans = NULL
    for (i in 1:input$noSim) vectMeans = c (vectMeans, mean (rexp(input$noExp, input$lambda)))
    hist(vectMeans, prob=TRUE, col="lightblue", main="Exponential and Normal Distribution", breaks=40)
    lines(density(vectMeans), lwd=3, col="red", xlab="Means")
  })
  
})
