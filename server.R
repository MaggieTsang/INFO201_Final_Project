# Server-side of webpage

library(plotly)
library(dplyr)
library(png)

source("./script/chart_year_sexualMinority.R")
source("./script/gender_characteristics.R")

marvel.data <- read.csv("data/marvel-wikia-data.csv", stringsAsFactors = FALSE)
colnames(marvel.data)[13]  <- "YEAR"
dc.data <- read.csv("data/dc-wikia-data.csv", stringsAsFactors = FALSE)


shinyServer(function(input, output) {
  
  # GSM Tab
  output$year_gsm <- renderPlotly({
    # Show only selected gender. *** = all possible genders
    gender.selected <- input$gender
    if(gender.selected != "***") {
      marvel.data <- marvel.data %>% filter(SEX == gender.selected)
    }
    return(YearSexuality(marvel.data))
  })
  
  output$table_gsm <- renderTable({
    return(GSMtable(marvel.data))
  })
  
  
  # Gender vs Characteristics Tab
  output$circularPlot <- renderPlot({
    char_selected <- input$char
    return(GenderCharacteristic(marvel.data,char_selected))
  })
  output$table <- renderTable({
    return(GC_table(marvel.data))
  })
  output$summary <- renderText({
    return(GC_Summary())
  })
  
  # Another Tab functions here
  output$circularPlot <- renderPlot({
    selection <- input$variable
    graph <- CircleGraph(df, selection)
    return(graph)
  })
  
})