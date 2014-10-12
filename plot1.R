plot1 <- function() 
{
  ##Plot the histogram of the global active power use between 2007-02-01 and 2007-02-02.
  
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
  
  ##Parse Global Active Power into numeric format.
  subTable$Global_active_power <- as.numeric(as.character(subTable$Global_active_power))
  
  ##Set output device to PNG.
  png("plot1.png")
  
  ##Draw histogram of Global Active Power
  hist(subTable$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  
  ##Close PNG output device.
  dev.off()
}