# Server-side of webpage

library(plotly)
library(dplyr)

marvel.data <- read.csv("data/marvel-wikia-data.csv", stringsAsFactors = FALSE)
colnames(marvel.data)[13]  <- "YEAR"
dc.data <- read.csv("data/dc-wikia-data.csv", stringsAsFactors = FALSE)
source("./script/chart_year_sexualMinority.R")


shinyServer(function(input, output) {
  output$year_gsm <- renderPlotly({
    # Show only selected gender. *** = all possible genders
    gender.selected <- input$gender
    if(gender.selected != "***") {
      marvel.data <- marvel.data %>% filter(SEX == gender.selected)
    }
    return(MarvelYearSexuality(marvel.data))
  })
  
})