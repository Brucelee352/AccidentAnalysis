options(scipen = 99)
library(tidyverse)
library(lubridate)
library(ggplot2)

accidents <- read.csv("Data/accidents.csv")

accidents$Month.Year <- format(as.Date(accidents$Date.Of.Stop), "%m-01-%Y")

#Code variables 

##Number of Accidents 
accidents$Accident = ifelse(accidents$Accident == "Yes", 1 ,0)

##Number of Fatalities 
accidents$Fatal = ifelse(accidents$Fatal == "Yes", 1 ,0)

##Number of Alcohol related accidents
accidents$Alcohol = ifelse(accidents$Alcohol == "Yes", 1 ,0)

##-----------------

#Summarize 

Num_Accidents <- accidents %>%
  group_by(Month.Year) %>%
  summarise(sum_Accidents = sum(Accident))

Num_Fatal <- accidents %>%
  group_by(Month.Year) %>%
  summarise(sum_Fatal = sum(Fatal))

Num_Alcohol <- accidents %>%
  group_by(Month.Year) %>%
  summarise(sum_Alcohol = sum(Alcohol))

#Join variables using merge(), aka, R counterpart to SQL's join 

agg_accidents <- merge(Num_Accidents, Num_Alcohol, by = "Month.Year")
agg_accidents <- merge(agg_accidents, Num_Fatal, by = "Month.Year")

##-----------------

#Code dates using base R, can be done with lubridate as well

agg_accidents$Month.Year <- as.Date(agg_accidents$Month.Year, 
                                    format = "%m-%d-%Y")
  
agg_accidents$DayofWeek <- strftime(agg_accidents$Month.Year,'%A')

agg_accidents$DayofWeek <- factor(agg_accidents$DayofWeek, levels= c("Sunday", 
                                  "Monday", "Tuesday", "Wednesday", "Thursday", 
                                         "Friday", "Saturday"))

agg_accidents[order(agg_accidents$DayofWeek), ]

# If needed, check structure of inconsistencies with classes 
str(agg_accidents)

##-----------------
##Recode variables 

agg_accidents$sum_Alcohol = ifelse(agg_accidents$sum_Alcohol == 
                                     "0", "No", "Yes")

agg_accidents$sum_Fatal = ifelse(agg_accidents$sum_Fatal == 
                                   "0", "No", "Yes")

agg_accidents$Accidents <-  agg_accidents$sum_Accidents
agg_accidents$Fatal <- agg_accidents$sum_Fatal
agg_accidents$Alcohol <-agg_accidents$sum_Alcohol

agg_accidents$sum_Accidents <- NULL
agg_accidents$sum_Fatal <- NULL
agg_accidents$sum_Alcohol <- NULL

##-----------------
##Plots

accidentplot <- ggplot(data = agg_accidents, aes(x = Month.Year, 
                           y = Accidents)) + 
  geom_point(position = "jitter", aes(color = Alcohol, 
                                      size = Fatal)) + 
  geom_smooth(method = "lm", se = FALSE) + 
  scale_fill_discrete() +
  labs(title = "Accidents by Year and Type", x = "Year", 
       y = "Number of Accidents") +
  theme_bw()

accidentplot2 <- ggplot(agg_accidents, aes(x = Month.Year, y = Accidents)) + 
  geom_point(position = "jitter") + 
  geom_smooth(method = "lm", se = FALSE) + 
  labs(title = "Accidents by Year", x = "Year", y = "Accidents" )+
  theme_bw()+
  facet_wrap(.~DayofWeek)
 

accidentplot <- accidentplot + ylim(c(0, 30)) 
accidentplot
accidentplot2


#linear model of sum_accidents over time 
mod1 <- lm(agg_accidents$Accidents ~ agg_accidents$Month.Year)
mod2 <- lm(agg_accidents$Accidents ~ I(1:91))
summary(mod1)
summary(mod2)



