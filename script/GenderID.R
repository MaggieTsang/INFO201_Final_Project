# Read in libraries
library(stringr)
library(plotly)

graphData <- function(dataset, variable1, variable2, xvar, yvar) {
  x.data <- paste0(variable1)
  y.data <- paste0(variable2)
  name.of.title <- paste(xvar, " VS ", yvar)
  graph <- plot_ly(dataset, x = x.data, y = y.data, type = 'scatter', 
                   marker = list(size = 8, color = 'rgba(0, 0, 255, .9)')) %>%
    layout(title = name.of.title)
  return(graph)
}

ID_Intro <- function() {
  return("This dataset is to show how gender affects the how a character identifies with their ID  and if they are living.")
}

ID_Summary <- function () {
  return ("In conclusion this dataset shows that the male and female characters are more prevalent than genderfluid characters. Even if comics are more welcoming to females they still aren't as open to the LBGT characters. In this graph you can see that genderfluid characters are underepresented compared to female or male genders")
}