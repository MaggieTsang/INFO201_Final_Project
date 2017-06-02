# Character Gender vs Mortality Rate 

library(plotly)
library(dplyr)

# Uses pie graph to show the mortality rate between genders 
GenderMortality <- function(dataset) {
  p <- dataset %>%
  group_by(ALIVE) %>%
  summarize(count = n()) %>%
  plot_ly(labels = ~ALIVE, values = ~count) %>%
  add_pie(hole = 0.6) %>%
  layout(title = "Gender & Mortality Rates",  showlegend = F,
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
}

GMConcl <- function() {
  return("Visualizing gender mortality rates was stemmed from the question 'Is there a different ratio of living and deceased characters per gender?' 
         In accordance to the graph, the differences aren't huge. There are roughly 1/4 male characters deceased whereas only about 1/5 female characters are.
         Agender and genderfluid characters are all alive. I suspected that there would be a higher percentage of male characters alive over any other
         gender type just because heroism and masculinity go hand in hand. On that same note, perhaps because there is more data since there are more
         male characters overall the data is more accurately displayed for these characters than any other gender type. Because female, agender, and genderfluid
         characters are under represented there is not much data to pull from for these visualizations.")
}

