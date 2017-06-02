#SuJin : Gender vs characteristics

library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

# Function create Circle graph and return it.
GenderCharacteristic <- function(dataset, char) {
  my.data <- group_by(dataset, SEX,ALIGN) %>%
    summarize(count=n())
  
  #filter out unknown columns or data which wont be include in my data
  my.data <- my.data[!(is.na(my.data$SEX) | my.data$SEX=="" | my.data$ALIGN==""), ]
  
  #add up number of each characters for each gender
  total <- group_by(my.data, SEX) %>%
    summarize(sum = sum(count)) 
  colnames(total) <- c("Sex","total")
  
  #create a dataframe that contain number of Bad characters in each gender
  b.data <- filter(my.data, ALIGN =="Bad Characters") %>%
    select(SEX,count) 
  colnames(b.data) <- c("Sex","bad")
  
  #create a dataframe that contain number of Good characters in each gender
  g.data <- filter(my.data, ALIGN == "Good Characters") %>%
    select(SEX,count)
  colnames(g.data) <- c("Sex","good")
  
  #create a dataframe that contain number of Neutral characters in each gender
  n.data <- filter(my.data, ALIGN == "Neutral Characters") %>%
    select(SEX,count)
  colnames(n.data) <- c("Sex","neutral")
  
  #create a table contain all characteristics for each gender
  table <- left_join(b.data,g.data, by= "Sex") %>% 
    left_join(n.data, by="Sex") %>%
    left_join(total, by="Sex")
  
  #change the numbers to percentage so we can see proportion of each characteristics for each gender
  pcnt <- data.frame(c("Agenda","Female","Male"),
                     round(table$bad/table$total *100, digit=0), 
                     round(table$good/table$total *100, digit=0),
                     round(table$neutral/table$total *100, digit=0))
  colnames(pcnt) <- c("Gender","Bad","Good","Neutral")
  
  #create circular graph that contain the characteristics proportion information for each gender
  circular <- ggplot(pcnt, aes(x = Gender, y = eval(parse(text = char)) ,fill = Gender)) + 
    geom_bar(width = 0.85, stat="identity") +    
    
    # To use a polar plot and not a basic b arplot
    coord_polar(theta = "y") +    
    
    #Remove useless labels of axis
    xlab("") + ylab("") +
    
    #Increase ylim to avoid having a complete circle
    ylim(c(0,75)) + 
    
    #Add group labels close to the bars :
    geom_text(data = pcnt, hjust = 1, size = 3, aes(x = Gender, y = 0, label = Gender)) +
    
    #Remove useless legend, y axis ticks and y axis text
    theme(legend.position = "none" , axis.text.y = element_blank() , axis.ticks = element_blank()) +
    
    #Create title of the graph
    ggtitle(paste("Proportion of each gender for ",as.character(char), "Characteristic")) +
    
    #change the color of the each column
    scale_fill_manual("legend", values = c("Male" = "#56B4E9", "Female" = "pink", "Agenda" = "palegreen1")) +
    
    #change the title size
    theme(plot.title = element_text(size=22)) +
    
    #Change the title location
    theme(plot.title = element_text(hjust = 0.5))
  
  return(circular)
}

#Create a table data which contain the characteristics proportion information for each gender
GC_table <- function(dataset){
  my.data <- group_by(dataset, SEX,ALIGN) %>%
    summarize(count=n())
  
  my.data <- my.data[!(is.na(my.data$SEX) | my.data$SEX=="" | my.data$ALIGN==""), ]
  
  total <- group_by(my.data, SEX) %>%
    summarize(sum = sum(count)) 
  colnames(total) <- c("Sex","total")
  
  b.data <- filter(my.data, ALIGN =="Bad Characters") %>%
    select(SEX,count) 
  colnames(b.data) <- c("Sex","bad")
  
  g.data <- filter(my.data, ALIGN == "Good Characters") %>%
    select(SEX,count)
  colnames(g.data) <- c("Sex","good")
  
  n.data <- filter(my.data, ALIGN == "Neutral Characters") %>%
    select(SEX,count)
  colnames(n.data) <- c("Sex","neutral")
  
  table <- left_join(b.data,g.data, by= "Sex") %>% 
    left_join(n.data, by="Sex") %>%
    left_join(total, by="Sex")
  
  pcnt <- data.frame(c("Agenda","Female","Male"),
                     round(table$bad/table$total *100, digit=0), 
                     round(table$good/table$total *100, digit=0),
                     round(table$neutral/table$total *100, digit=0))
  colnames(pcnt) <- c("Gender","Bad (%)","Good(%)","Neutral(%)")
  return(pcnt)
}

# Return introduction of my page
GC_Intro <- function(){
  return("Media is one of the most powerful tool that can influence to our view on the World. 
         We were interested in how media communicate images of the sexes with different characteristics.
         In our perspective, we used to see male characters are more strong and powerful than female characters.
         So we calculate each genders proportion on different characteristics.")
}

# Return the conclusion from my plot 
GC_Summary <- function() {
  return("As a general observation, Female has the higest proportion on Good Characteristic and male has the highest proportion on Bad characteristic. 
         Agenda characters also have the highest proportion on bad characteristics but compare to male characters they have little less proportion. 
         Also When we focus on neutral characteristics we can find the most characters are agenda. 
         Base on this result we can conclude that in the comics, males represent villains more often. We assume that it can be because of their strong and powerful images.
         and Women villains have weaker images to audience.
         So we hope to see more strong and real image of womens in Comics and other media.")
}
