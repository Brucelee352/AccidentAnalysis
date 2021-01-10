#Import via Files/Import Dataset

#Change variable name and remove dupe
traffic <- traffic_50ksample_excel
rm(traffic_50ksample_excel)

##Set variable name with spaces using backticks, this is something I just found 
traffic$`Vehicle Year` <- traffic$Year
traffic$Year <- NULL

##Change "Date of Stop" to the format R actually understands...
traffic$`Date Of Stop` <- as.Date.numeric(x = traffic$`Date Of Stop`, origin = "1899-12-30")
View(traffic$`Date Of Stop`)  

##Write the traffic data to a .csv file

##Simple
write.csv(traffic, 'select_traffic.csv')

##Path Specified 
write.csv(traffic, "C://Users/bruce/Documents/bRuce/Data/select_traffic.csv")

     
