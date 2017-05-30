# User-interface of our webpage

library(shiny)
library(plotly)

source("./script/chart_year_sexualMinority.R")
source("./script/introduction.R")


shinyUI(navbarPage(
  "Comic Book Character Diversity",
  
  # Introduction Tab
  tabPanel("Introduction",
           fluidPage(
             titlePanel("Introduction"),
             mainPanel(h5(Intro()))
             
           )),

  # GSM and LGBT Tab
  tabPanel("LGBT Community",
           fluidPage(
             titlePanel("Comic Characters in the LGBT Community"),
             
             # Sidebar with drop-down box widget, select gender
             sidebarLayout(
               sidebarPanel(selectInput(
                 "gender",
                 "Gender:",
                 choices = list(
                   "All" = "***",
                   "Female" = "Female Characters",
                   "Male" = "Male Characters",
                   "Agender" = "Agender Characters"
                 )
               )),
               
               mainPanel(
                 h3("Introduction:"),
                 h5(GSMintro()),
                 plotlyOutput("year_gsm"),
                 h3("Conclusion:"),
                 h5(GSMoutro())
               )
             )
           )),
  
  # Other Tabs
  tabPanel("Test tab",
           fluidPage(
             titlePanel("Test text")
           ))
  
))