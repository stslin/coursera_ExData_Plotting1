plot4 <- function() 
{ 
  ##Plot following for data between 2007-02-01 and 2007-02-02.
  ## -- (Top-Left) Global Active Power
  ## -- (Top-Right) Voltage
  ## -- (Bottom-Left) Energy Sub metering
  ## -- (Bottom-Right) Global Reactive Power
  
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
  
  ##Parse Global Active Power into numeric format.
  subTable$Global_active_power <- as.numeric(as.character(subTable$Global_active_power))
  
  ##Parse Global Voltage into numeric format.
  subTable$Voltage <- as.numeric(as.character(subTable$Voltage))
  
  ##Parse Submetering into numeric format.
  subTable$Sub_metering_1 <- as.numeric(as.character(subTable$Sub_metering_1))
  subTable$Sub_metering_2 <- as.numeric(as.character(subTable$Sub_metering_2))
  subTable$Sub_metering_3 <- as.numeric(as.character(subTable$Sub_metering_3))
  
  ##Parse Global reactive Power into numeric format.
  subTable$Global_reactive_power <- as.numeric(as.character(subTable$Global_reactive_power))
  
  ##Set output device to PNG
  png("plot4.png")
  
  ##Configure output to 2 by 2 panels.
  par(mfrow=c(2,2))
  
  ##Plot Global Active Power Use
  plot(subTable$Date_Time, subTable$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
  ##Plot Voltager Use
  plot(subTable$Date_Time, subTable$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  ##Plot submetering
  plot(subTable$Date_Time, subTable$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
  lines(subTable$Date_Time, subTable$Sub_metering_2,col="red")
  lines(subTable$Date_Time, subTable$Sub_metering_3,col="blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, lty=c(1, 1, 1) , col=c("black","red","blue"), bty = "n")
  
  ##Plot Global Reactive Power Use
  plot(subTable$Date_Time, subTable$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  
  ##Close PNG output device.
  dev.off()
}