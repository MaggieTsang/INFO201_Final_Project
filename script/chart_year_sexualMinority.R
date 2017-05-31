# Views trends between year and the appearance frequency of sexual minorities

library(dplyr)
library(plotly)

# Uses a line graph to view trendlines
YearSexuality <- function(dataset) {
  # Get graphing summary
  plot.summary <- GSMtable(dataset)
  colnames(plot.summary) <- c("YEAR", "str_freq", "gsm_freq")
  
  # Create and return graph with two trendlines
  line.graph <- plot_ly(plot.summary, x = ~YEAR, y = ~str_freq, name = "Straight Characters", type = "scatter", mode = "lines") %>% 
    add_trace(y = ~gsm_freq, name = "GSM Characters", type = "scatter", mode = "lines") %>%
    layout(xaxis = list(title = "Year of First Appearance"), yaxis = list(title = "Character Frequency"), title = "Comparing Trends of Comic Character Sexual Minorities") %>%
    return()
}

GSMtable <- function(dataset) {
  # Straight character information
  straight.characters <- dataset %>% filter(GSM == "", is.na(YEAR) == FALSE) %>% group_by(YEAR) %>% summarise(freq = n())
  colnames(straight.characters) <- c("YEAR", "str_freq")
  
  # Non-straight character information
  gsm.characters <- dataset %>% filter(GSM != "", is.na(YEAR) == FALSE) %>% group_by(YEAR) %>% summarise(freq = n())
  colnames(gsm.characters) <- c("YEAR", "gsm_freq")
  
  # Summarizes sexuality data, change N/A frequencies to zero
  plot.summary <- left_join(straight.characters, gsm.characters, by = "YEAR")
  plot.summary[is.na(plot.summary)] <- 0
  colnames(plot.summary) <- c("Year", "Total Straight Characters", "Total GSM Characters")
  return(plot.summary)
}

GSMintro <- function() {
  return("As the LGBTQ+ community faces discrimination and continues to fight for their equal rights,
    this graph shows if comic book characters represent those of a sexual minority.
    The x-axis notes the year of a character's first appearance and the y-axis counts the
    total number of new characters that year. The blue line represents straight characters and
    the orange line represents those of any gender/sexual minority including
    bisexual, homosexual, pansexual, transgender, and gender fluid characters."
  )
}

GSMoutro <- function() {
  return("As a general observation, there are many more straight characters then GSM characters.
    Female GSM characters are more common than Male GSM characters, and there are no Agender
    GSM characters. Interestingly, the years that have a higher frequency of GSM characters
    are aligned with real-life events. For example, GSM characters slightly rose in 1991, a year where
    laws were passed that banned discrimination based on sexual orientation. Another rise in 2001 may
    be due to the first event of legal same-sex marriage in Ontario, Canada. Later in 2001,
    same-sex couples were allowed adoption rights. Although the large gap between Straight and GSM
    characters remain, GSM characters are having more appearances as time passes."
  )
}