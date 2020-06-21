## Import Data if it does not exist in global environment

if (!exists('data', envir = globalenv())) {
      #Import Data and convert date column to date class
      data <- read.table('household_power_consumption.txt',sep = ";",skip = 1)
      data$V1 <- as.Date(data$V1,'%d/%m/%Y')
      
      # Creating 2 dates to include for plotting
      date1 <- as.Date("2007/02/01",'%Y/%m/%d')
      date2 <- as.Date("2007/02/02",'%Y/%m/%d')
      
      #Subset data using 2 dates and bind 2 datasets to give us data with 2 dates
      data1 <- subset(data,V1 == date1)
      data2 <- subset(data,V1 == date2)
      data <- rbind(data1,data2)
}

# Extracting Power data, converting to numeric and getting rid of NA's
GlobalPower <-data$V3
GlobalPower <- as.numeric(GlobalPower)
GlobalPower <- GlobalPower[!is.na(GlobalPower)]

# Opening png graphics device and plotting
png(filename = 'plot1.png',width = 480,height = 480)
hist(GlobalPower,col = 'red',xlab = 'Global Active Power (kilowatts)',main = 'Global Active Power')
dev.off()