# Read in libraries
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

# Function for graph
GenderID <- function(dataset, user) {
  my.data <- group_by(dataset, SEX,ID) %>%
    summarize(count=n())
  
  my.data <- my.data[!(is.na(my.data$SEX) | my.data$SEX == "" | my.data$ID == ""), ]
  
  total <- group_by(my.data, SEX) %>%
    summarize(sum = sum(count)) 
  colnames(total) <- c("Sex","total")
  
  secret.data <- filter(my.data, ID == "Secret Identity") %>%
    select(SEX,count) 
  colnames(secret.data) <- c("Sex", "Secret")
  
  public.data <- filter(my.data, ID == "Public Identity") %>%
    select(SEX,count)
  colnames(public.data) <- c("Sex", "Public")
  
  none.data <- filter(my.data, ID == "No Dual Identity") %>%
    select(SEX,count)
  colnames(none.data) <- c("Sex", "None")
  
  known.data <- filter(my.data, ID == "Known to Authorities Identity") %>%
    select(SEX,count)
  colnames(known.data) <- c("Sex", "Known")
  
  # Dataframe necessary to plot graph
  table <- left_join(secret.data, public.data, by = "Sex") %>% 
    left_join(none.data, by ="Sex") %>%
    left_join(known.data, by ="Sex") %>%
    left_join(total, by ="Sex")
  
  pcnt <- data.frame(c("Female","Male"),
                     round(table$Secret / table$total * 100, digit = 0), 
                     round(table$Public / table$total * 100, digit = 0),
                     round(table$None / table$total * 100, digit = 0),
                     round(table$Known / table$total * 100, digit = 0))
  colnames(pcnt) <- c("Gender","Secret","Public","None", "Known")
  
  # Plotting graph
  circular <- ggplot(pcnt, aes(x = Gender, y = eval(parse(text = user)) ,fill = Gender)) + 
    geom_bar(width = 0.85, stat="identity") +    
    
    # To use a polar plot and not a basic b arplot
    coord_polar(theta = "y") +    
    
    #Remove useless labels of axis
    xlab("") + ylab("") +
    
    #Increase ylim to avoid having a complete circle
    ylim(c(0,75)) + 
    
    #Add group labels close to the bars :
    geom_text(data = pcnt, hjust = 1, size = 4, aes(x = Gender, y = 0, label = Gender)) +
    
    #Remove useless legend, y axis ticks and y axis text
    theme(legend.position = "none" , axis.text.y = element_blank() , axis.ticks = element_blank()) +
    
    ggtitle(paste("Proportion of each gender for", as.character(user), "ID")) +
    
    scale_fill_manual("legend", values = c("Male" = "blue", "Female" = "pink")) +
    
    theme(plot.title = element_text(size=22)) +
    theme(plot.title = element_text(hjust = 0.5))
  
  return(circular)
}

# This function displays the tab for the introduction that explaisn this graph
ID_Intro <- function() {
  return("This dataset is to show how gender affects how a character identifies as private identity, public, none identity, or unknown.")
}

# This function displays the tab that summarizes the conclusions for the data analyzed in the graph.
ID_Summary <- function () {
  return ("From this dataset one can see how underrepresented women are in this industry. Most female characters identify as a secret identity whereas males identitfy with a public identity.")
}
