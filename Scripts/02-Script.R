#Import Data, making a second dataset for comparison, traffic2 is used as control
traffic <-
  read.csv("C:/Users/bruce/Documents/bRuce/Data/select_traffic.csv"
           ,
           stringsAsFactors = FALSE)

#stringsAsFactors Makes to where the column names do not inhert the spaces of
#the original dataset

traffic2 <-
 read.csv("C: / Users / bruce / Documents / bRuce / Data / select_traffic.csv")

#Setting nonsense columns to NULL
traffic$X <- NULL
traffic2$X <- NULL

#Use sapply to see which classes embody both datasets, lapply can work as well
#but sapply just looks better to me
sapply(traffic, class)
sapply(traffic2, class)

#View variables to check for changes
View(traffic)
View(traffic2)

#Change column class to numeric
traffic$Vehicle.Year <- as.numeric(as.character(traffic$Vehicle.Year))
traffic2$Vehicle.Year <- as.numeric(as.character(traffic2$Vehicle.Year))

#Check for number of rows with 0 within traffic$`Vehicle Year`
sum(traffic$Vehicle.Year == '0', na.rm=TRUE)

#Check for NAs
sum(traffic$Vehicle.Year == 'na'
    
#Generate summary statistics for both datasets
summary(traffic)
summary(traffic2)

##How many rows are in the data ? How many columns ?
#50000 rows, 8 columns
dim(traffic)
dim(traffic2)

#What is the oldest car in the dataset?
# 0
summary(traffic)

#How many Fatal accidents in the dataset?
sum(traffic$Fatal == "Yes")
