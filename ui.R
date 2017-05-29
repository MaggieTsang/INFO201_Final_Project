# User-interface of our webpage

library(shiny)
library(plotly)


shinyUI(
  
  # Gender and Sexual Minority Page
  fluidPage(
  titlePanel("Comic Characters in the LGBT Community"),
    sidebarLayout(
    sidebarPanel(
      # Drop-down widget to select gender
      selectInput(
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
      h5("As the LGBTQ+ community faces discrimination and continues to fight for their equal rights,
        this graph shows if comic book characters represent those of a sexual minority.
        The x-axis notes the year of a character's first appearance and the y-axis counts the
        total number of new characters that year. The blue line represents straight characters and
        the orange line represents those of any gender/sexual minority including
        bisexual, homosexual, pansexual, transgender, and gender fluid characters."
      ),
      plotlyOutput("year_gsm"),
      h3("Conclusion:"),
      h5("As a general observation, there are many more straight characters then GSM characters.
         Female GSM characters are more common than Male GSM characters, and there are no Agender
         GSM characters."
      ),
      h5("Interestingly, the years that have a higher frequency of GSM characters
         are aligned with real-life events. For example, GSM characters slightly rose in 1991, a year where
         laws were passed that banned discrimination based on sexual orientation. Another rise in 2001 may
         be due to the first event of legal same-sex marriage in Ontario, Canada. Later in 2001,
         same-sex couples were allowed adoption rights."
      ),
      h5("Although the large gap between Straight and GSM characters remain, GSM characters
         are having more appearances as time passes."
      )
      )
    
      )
    )
  #End of Gender Sexual Minority Page
  
  
  
  
  
  )