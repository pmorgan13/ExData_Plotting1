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

# Extracting Power data, converting to numeric and getting rid of NA's for Y-Axis
data2 <- data
data2$V3 <- as.numeric(data2$V3)
data2 <- data2[!is.na(data2$V3),]

## Creating Datetime for x-axis
datetime <- as.POSIXct(paste(data2$V1, data2$V2), format="%Y-%m-%d %H:%M:%S")

# Opening png graphics device and plotting
png(filename = 'plot2.png',width = 480,height = 480)
plot(datetime,data2$V3,xlab = '',ylab = 'Global Active Power (kilowatts)',type = 'l')
dev.off()