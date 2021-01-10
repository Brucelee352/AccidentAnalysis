#Read Data
traffic <- read.csv("Data/select_traffic.csv", 
                    stringsAsFactors = FALSE)

#Remove NA rows from dataset
traffic_no_na <- na.exclude(object = traffic)

#Subset traffic_no_na data to a new dataset called ‘accidents’ 
#where a row is only kept if there was an accident.

accidents <- subset(traffic_no_na, traffic_no_na$Accident == "Yes")
accidents$X <- NULL

#Make Vehicle Year numeric, if needed 
accidents$Vehicle.Year <- as.numeric(accidents$Vehicle.Year)

#Make preliminary histogram to plot values and check for outliers
hist(accidents$Vehicle.Year, freq = TRUE, breaks = 100)

#Recode Vehicle.Year to change entries with impossible values
accidents$Vehicle.Year[accidents$Vehicle.Year < 1932] <- "1932"
accidents$Vehicle.Year[accidents$Vehicle.Year > 2021] <- "2021" 

#Remake histogram with re-coded values, if giving error, run line 15
hist(x = accidents$Vehicle.Year, freq = TRUE, breaks = 40, 
     xlab = "Vehicle.Year recoded for impossible values")

#Make new column using lubridate to pull months from $Date.of.stop
library(lubridate)

#Plot histogram charting frequency 
hist(x = accidents$`Month of Stop`, freq = TRUE, breaks = 40, 
     xlab = "Frequency of Month of Stop in each Accident")

#How many rows are in traffic_no_na & accidents respectively?
nrow(traffic_no_na)
nrow(accidents)

#How many accidents occurred in 1999?
sum(accidents$Vehicle.Year == "1999")

#Which month has the most accidents? December
tail(names(sort(table(accidents$`Month of Stop`))), 1)

#Write accidents to new dataset
write.csv(accidents, "Data/accidents.csv")
