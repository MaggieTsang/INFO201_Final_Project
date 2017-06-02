# Server-side for Comic Book Character Diversity

library(shiny)
library(plotly)
library(dplyr)

source("./script/chart_year_sexualMinority.R")
source("./script/gender_characteristics.R")
source('./script/GenderID.R')
source('./script/gender_vs_mortality.R')

marvel.data <- read.csv("data/marvel-wikia-data.csv", stringsAsFactors = FALSE)
colnames(marvel.data)[13]  <- "YEAR"


shinyServer(function(input, output) {
  
  # GSM Tab
  output$year_gsm <- renderPlotly({
    # Show only selected gender. *** = all possible genders
    gender.selected <- input$gender
    if (gender.selected != "***") {
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
    return(GenderCharacteristic(marvel.data, char_selected))
  })
  output$table <- renderTable({
    return(GC_table(marvel.data))
  })
  
  # Identification status based on gender
  output$circlePlot <- renderPlot({
    user.selected <- input$user
    return(GenderID(marvel.data, user.selected))
  })
  
  # Gender Mortality
  output$genderMortality <- renderPlotly({
    gender.select <- input$gendermort
    if (gender.select != "***") {
      marvel.data <- marvel.data %>%
        filter(SEX == gender.select)
    }
    return(GenderMortality(marvel.data))
  })
  
})