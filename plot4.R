#Exploratory Analysis
#Project 1 Plot4

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "houshold_power_consumption.zip", method = "curl")

unzip("houshould_power_consumption.zip", overwrite = TRUE)

Data <- read.table(text = grep("^[1,2]/2/2007", 
                               readLines("household_power_consumption.txt"), 
                               value = TRUE), 
                   col.names = c("Date", "Time", "Global_active_power", 
                                 "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   header = TRUE, sep = ";", 
                   na.strings = "?")

#convert Date and time data to nice format
Data$TimeStamp <- as.POSIXct(strptime(paste(Data$Date, Data$Time), "%d/%m/%Y %H:%M:%S"))

#We will only be using data from the dates 2007-02-01 and 2007-02-02.

#using a png device
png(file = "plot4.png", width = 480, height =480, units ="px")
# open png device and create  file in working directory


#set up to be a 2x2 grid of plots
par(mfcol = c(2,2)) # go down columns first

# create a plot and send to a file (no window appears on screen)
with(Data, {
      #the upper left
      plot(Global_active_power ~ TimeStamp,type = "line", 
           ylab= "Global Active Power (kilowatts)",
           xlab = "")
      
      #the lower left
      plot( Sub_metering_1 ~ TimeStamp,type = "line", 
            ylab= "Energy sub metering",
            xlab = "")
      lines(Sub_metering_2 ~TimeStamp, col = "Red")
      lines(Sub_metering_3 ~TimeStamp, col = "Blue")
      legend("topright",lwd =c(1,1,1), col = c("black", "blue","red"), 
            legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
      
      #the upper right
      plot(Voltage~TimeStamp, type = "line",
           xlab = "datetime")
      
      #lower right
      plot(Global_reactive_power~TimeStamp, type="line",
           xlab = "datetime")
      
      })

dev.off() #close the png device
# now you can view the file on your computer