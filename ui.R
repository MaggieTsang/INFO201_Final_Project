# User-interface of our webpage

library(shiny)
library(plotly)
library(ggplot2)

source("./script/chart_year_sexualMinority.R")
source("./script/introduction.R")
source('./script/genderID.R')

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
                             tabPanel("Plot", plotOutput("circularPlot")), 
                             tabPanel("Table", tableOutput("table")),
                             tabPanel("Summary", verbatimTextOutput("summary"))
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
               selectInput("variable2", label = 'Y', choices=list('Identification', "Alive Characters"))
             ),
             # Show a plot of the generated distribution
             mainPanel(
               h2("Introduction:"),
               h4("This dataset is to show how gender affects the how a character identifies with their ID  and if they are living."),
               plotlyOutput('map'),
               h2("Conclusion:"),
               h4("In conclusion this dataset shows that the male and female characters are more prevalent than genderfluid characters. Even if comics are more welcoming to females they still aren't as open to the LBGT characters. In this graph you can see that genderfluid characters are underepresented compared to female or male genders")

             )
           )
  ),
  
  tabPanel("Test tab",
           fluidPage(
             titlePanel("Test text")
           ))
  
))