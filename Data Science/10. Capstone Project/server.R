# server.R

load("ngrams_and_badwords.RData", envir=.GlobalEnv)
source("nextword.R")

nextw <- function(phrase, safemode=TRUE) {
  return(StupidBackoff(phrase, removeProfanity=safemode))
}

shinyServer(function(input, output) {
  
  phraseGo <- eventReactive(input$goButton, {
    input$phrase <- "en-US"
  })
  output$stats <- renderText({
    numword <- length(strsplit(input$phrase," ")[[1]])
    numchar <- nchar(input$phrase)
    paste("You've written ", numword, " words and ", numchar, "characters")
  })
  output$nextword <- renderText({
    result <- nextw(phraseGo(), input$lang, safemode=TRUE)
    paste0(result)
  })
  output$stats2 <- renderText({
    numword <- length(strsplit(input$phrase2," ")[[1]])
    numchar <- nchar(input$phrase2)
    paste("You've written ", numword, " words and ", numchar, "characters")
  })
  output$nextword2 <- renderText({
    result <- nextw(input$phrase2, safemode=TRUE)
    paste0(result)
  })
  
})