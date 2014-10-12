plot2 <- function() 
{ 
  ##Plot the global active power use by time between 2007-02-01 and 2007-02-02.
  
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
  
  ##Set output device to PNG
  png("plot2.png")
  
  ##Plot Global Active Power Use
  plot(subTable$Date_Time, subTable$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  ##Close PNG output device.
  dev.off()
}