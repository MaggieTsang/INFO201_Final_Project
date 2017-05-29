# Maggie chart
# Views trends between year and the appearance frequency of sexual minorities

library(dplyr)
library(plotly)

# Uses a line graph to view trendlines
YearSexuality <- function(dataset) {
  # Straight character information
  straight.characters <- dataset %>% filter(GSM == "", is.na(YEAR) == FALSE) %>% group_by(YEAR) %>% summarise(freq = n())
  colnames(straight.characters) <- c("YEAR", "str_freq")
  
  # Non-straight character information
  gsm.characters <- dataset %>% filter(GSM != "", is.na(YEAR) == FALSE) %>% group_by(YEAR) %>% summarise(freq = n())
  colnames(gsm.characters) <- c("YEAR", "gsm_freq")
  
  # Summarizes sexuality data, change N/A frequencies to zero
  plot.summary <- left_join(straight.characters, gsm.characters, by = "YEAR")
  plot.summary[is.na(plot.summary)] <- 0
  
  # Create and return graph with two trendlines
  line.graph <- plot_ly(plot.summary, x = ~YEAR, y = ~str_freq, name = "Straight Characters", type = "scatter", mode = "lines") %>% 
    add_trace(y = ~gsm_freq, name = "GSM Characters", type = "scatter", mode = "lines") %>%
    layout(xaxis = list(title = "Year of First Appearance"), yaxis = list(title = "Character Frequency"), title = "Comparing Trends of Comic Character Sexual Minorities") %>%
    return()
}