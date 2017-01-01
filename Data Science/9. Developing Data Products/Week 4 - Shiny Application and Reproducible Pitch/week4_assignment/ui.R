#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The Effect of Lambda, No. of Obs and Exponentials in Exponential Distribution and Central Limit Theorem Simulation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("lambda",
                   "Lambda or Theorotical Mean:",
                   min = 0.1,
                   max = 1,
                   value = 0.2,
                   step = 0.1),
       sliderInput("noSim",
                   "No. of Observations / Simulations:",
                   min = 1000,
                   max = 100000,
                   value = 1000,
                   step = 1000),
       sliderInput("noExp",
                   "No. of Exponentials:",
                   min = 10,
                   max = 100,
                   value = 40,
                   step = 10),
       h5("Use the slider controls on the left pane to adjust / select:"),
       h5("    1. Lambda / Theorotical Mean"),
       h5("    2. No. of Observations / Simulations"),
       h5("    3. No. of Exponentials"),
       h5("The charts will be adjusted automatically to reflect the impact of selected inputs on the distribution")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column (5, plotOutput("scatterPlot")),
        column (5, plotOutput("histPlot1"))
      ),
      fluidRow(
        column (5, plotOutput("histPlot2")),
        column (5, plotOutput("histPlot3"))
      )
    )
  )
))
