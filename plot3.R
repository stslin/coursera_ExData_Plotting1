plot3 <- function() 
{ 
  ##Plot the energy sub metering use between 2007-02-01 and 2007-02-02.
  
  ##Set program locale to English
  Sys.setlocale(category = "LC_ALL", locale = "English")
  
  ##configure start and end dates to extract data.
  startDate <- as.Date("2007-02-01", "%Y-%m-%d")
  endDate <- as.Date("2007-02-02", "%Y-%m-%d")
  
  ##Read data from data file.
  dataTable <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"")
  
  ##Keep only the data needed.
  dataTable$Date <- as.Date(dataTable$Date, "%d/%m/%Y")
  subTable <- dataTable[(dataTable$Date >= startDate) & (dataTable$Date <= endDate),]
  rm(dataTable)
  
  ##Create DateTime Data from Date and Time Columns.
  subTable["Date_Time"] <- NA
  subTable$Date_Time <- strptime(paste(subTable$Date, subTable$Time), "%Y-%m-%d %H:%M", tz = "GMT")
  
  ##Parse Submetering into numeric format.
  subTable$Sub_metering_1 <- as.numeric(as.character(subTable$Sub_metering_1))
  subTable$Sub_metering_2 <- as.numeric(as.character(subTable$Sub_metering_2))
  subTable$Sub_metering_3 <- as.numeric(as.character(subTable$Sub_metering_3))
  
  ##Set output device to PNG
  png("plot3.png")
  
  ##Plot submetering
  plot(subTable$Date_Time, subTable$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
  lines(subTable$Date_Time, subTable$Sub_metering_2,col="red")
  lines(subTable$Date_Time, subTable$Sub_metering_3,col="blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, lty=c(1, 1, 1) , col=c("black","red","blue"))
  
  ##Close PNG output device.
  dev.off()
}