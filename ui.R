# User-interface of our webpage - Diversity of Comic Characters

library(shiny)
library(plotly)
library(ggplot2)

source("./script/chart_year_sexualMinority.R")
source("./script/introduction.R")
source('./script/GenderID.R')
source("./script/gender_characteristics.R")
source('./script/gender_vs_mortality.R')

shinyUI(
  navbarPage(
    "Marvel Comic Character Diversity",
    
    # Introduction Tab
    tabPanel("Introduction",
             fluidPage(
               titlePanel("Introduction"),
               mainPanel(h3(Intro()),
                         h3(AudienceQuestions()))
             )),
    
    # GSM and LGBT Tab
    tabPanel("LGBT Community",
             fluidPage(
               titlePanel("LGBT Community Representation"),
               
               # Sidebar with drop-down box widget, select gender
               sidebarLayout(sidebarPanel(
                 selectInput(
                   "gender",
                   "Gender:",
                   choices = list(
                     "All" = "***",
                     "Female" = "Female Characters",
                     "Male" = "Male Characters",
                     "Agender" = "Agender Characters"
                   )
                 )
               ),
               
               mainPanel(
                 tabsetPanel(
                   type = "tabs",
                   tabPanel("Intro",
                            h2("Introduction:"),
                            h4(GSMintro())),
                   tabPanel("Graph",
                            plotlyOutput("year_gsm")),
                   tabPanel("Table",
                            tableOutput("table_gsm")),
                   tabPanel("Summary",
                            h2("Summary:"),
                            h4(GSMoutro()))
                 )
               ))
             )),
    
    # Gender Characteristics Tabs
    tabPanel(
      "Gender Characteristics",
      fluidPage(
        # Application title
        titlePanel("Gender vs Characteristic"),
        
        sidebarLayout(sidebarPanel(
          radioButtons(
            "char",
            "Characteristic type:",
            c(
              "Good Character" = "Good",
              "Bad Character" = "Bad",
              "Neutral Character" = "Neutral"
            )
          )
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
          tabsetPanel(
            type = "tabs",
            tabPanel("Intro", h2("Introduction:"), h4(GC_Intro())),
            tabPanel("Plot", plotOutput("circularPlot")),
            tabPanel(
              "Summary",
              h2("Summary Table"),
              tableOutput("table"),
              h2("Summary:"),
              h4(GC_Summary())
            )
          )
        ))
      )
    ),
    
    # Identification and Gender
    tabPanel(
      "Gender and Identification",
      fluidPage(
        # Application title
        titlePanel("Gender vs Identification"),
        
        sidebarLayout(sidebarPanel(
          radioButtons(
            "user",
            "Identification type:",
            list(
              "Secret Identity" = "Secret",
              "Public Identity" = "Public",
              "No Dual Identity" = "None",
              "Known to Authorities Identity" = "Known"
            )
          )
          
        ),
        mainPanel(
          tabsetPanel(
            type = "tabs",
            tabPanel("Intro", h2("Introduction:"), h4(ID_Intro())),
            tabPanel("Plot", plotOutput('circlePlot')),
            tabPanel("Summary", h2("Summary:"), h4(ID_Summary()))
          )
        ))
      )
    ),
    
    # Gender vs Morality
    tabPanel("Gender Mortality",
             fluidPage(
               titlePanel("Gender Comparisons of Mortality Rates"),
               
               sidebarLayout(sidebarPanel(
                 selectInput(
                   inputId = "gendermort",
                   label = "Gender:",
                   choices = list(
                     "Male" = "Male Characters",
                     "Female" =  "Female Characters",
                     "Agender" =
                       "Agender Characters",
                     "Genderfluid" = "Genderfluid Characters",
                     "All" = "***"
                   ),
                   selected = "All"
                 )
               ),
               
               mainPanel(
                 tabsetPanel(
                   type = "tabs",
                   tabPanel(
                     "Dataset",
                     h2("Introduction"),
                     h4(
                       "Visualizing the percentages of living and deceased characters between genders."
                     ),
                     plotlyOutput("genderMortality")
                   ),
                   tabPanel("Conclusion",
                            h2("Conclusions Drawn:"),
                            GMConcl())
                 )
               ))
             ))
  )
)