# User-interface of our webpage

library(shiny)
library(plotly)
library(ggplot2)

source("./script/chart_year_sexualMinority.R")
source("./script/introduction.R")
source('./script/genderID.R')
source("./script/gender_characteristics.R")

shinyUI(navbarPage(
  "Comic Book Character Diversity",
  
  # Introduction Tab
  tabPanel("Introduction",
           fluidPage(
             titlePanel("Introduction"),
             mainPanel(h3(Intro()))
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
                 tabsetPanel(type = "tabs", 
                             tabPanel("Intro",
                                      h2("Introduction:"),
                                      h4(GSMintro())
                                      ), 
                             tabPanel("Graph",
                                      plotlyOutput("year_gsm")),
                             tabPanel("Table",
                                      tableOutput("table_gsm")),
                             tabPanel("Summary",
                                      h2("Summary:"),
                                      h4(GSMoutro())
                                      )
                 )
                 
               )
             )
           )),
  # Gender Characteristics Tabs
  tabPanel("Gender Characteristics",
           fluidPage(
             
             # Application title
             titlePanel("Gender vs Characteristic"),
             
             sidebarLayout(
               sidebarPanel(
                 radioButtons("char", "Characteristic type:",
                              c("Good Character" = "Good",
                                "Bad Character" = "Bad",
                                "Neutral Character" = "Neutral")
                 )
               ),
               
               # Show a tabset that includes a plot, summary, and table view
               # of the generated distribution
               mainPanel(
                 tabsetPanel(type = "tabs", 
                             tabPanel("Intro", h2("Introduction:"),h4(GC_Intro())),
                             tabPanel("Plot", plotOutput("circularPlot")), 
                             tabPanel("Summary", h2("Summary Table"),tableOutput("table"),
                                      h2("Summary:"), h4(GC_Summary())
                              )
                 )
               )
             )
           )),
  
  # tatus tab
  tabPanel('ID and Living Status for Gender',
           # Application title
           titlePanel('Gender in relation to ID and living characters'),
           # Sidebar with a select input for both variables
           sidebarLayout(
             sidebarPanel(
               selectInput("variable1", label = 'X', choices=list('Gender Axis' = "Gender")),
               # Options for y axis
               selectInput("variable2", label = 'Y', choices=list('Identification'))
             ),
             # Show a plot of the generated distribution
             mainPanel(
               tabsetPanel(type = "tabs", 
                           tabPanel("Intro", h2("Introduction:"),h4(ID_Intro())),
                           tabPanel("Plot", plotlyOutput('map')), 
                           tabPanel("Summary",h2("Summary:"), h4(ID_Summary())
                           )
               )
               )
           )
  )
  ))