# Read in libraries
#library(stringr)
library(plotly)

graphData <- function(dataset, variable1, variable2, xvar, yvar) {
  x.data <- paste0(variable1)
  y.data <- paste0(variable2)
  name.of.title <- paste(xvar, " VS ", yvar)
  graph <- plot_ly(dataset, x = x.data, y = y.data, type = 'scatter', mode = "markers", 
                   marker = list(size = 8, color = 'rgba(0, 0, 255, .9)')) %>%
    layout(title = name.of.title)
  return(graph)
}