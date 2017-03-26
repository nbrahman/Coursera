# ui.R
library(shiny)

shinyUI(fluidPage(
  theme = "bootstrap.css",
  titlePanel(h1("Next Word Prediction", align="center"),
             windowTitle = "a coursera data science capstone project"),
  h4("~ a coursera data science capstone project ~", align="center"),
  hr(),
  fluidRow(
    column(12, offset=3,
           tabsetPanel(type = "tabs",
                       tabPanel("Prediction",
                                "Write any ENGLISH into this text box:",
                                textInput("phrase2", label = "", value = ""),
                                tags$head(tags$style(type="text/css", "#phrase2 {width: 450px;}")),
                                
                                fluidRow(
                                  column(6,
                                         "The next word (in your mind) is:",
                                         h2(textOutput("nextword2")),
                                         column(12,
                                                h5(textOutput("stats2"), align="left"))
                                  ))
                       ),        
                       tabPanel("About",
                                fluidRow(
                                  column(6,
                                         includeMarkdown("./about.rmd"))
                                )
                       )
                       
           )
    )
  ),
  hr(),
  p("Created by ", a("R", href="http://www.r-project.org/", target="_blank"),
    "and", a("Shiny", href="http://shiny.rstudio.com", target="_blank"), align="center"),
  
  p(img(src="headers.png"), align="center")
  
))