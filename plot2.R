# Exploratory Analysis
#Project 1 Plot2

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
png(file = "plot2.png", width = 480, height =480, units ="px")
# open png device and create  file in working directory

# create a plot and send to a file (no window appears on screen)
with(Data, plot(Global_active_power ~ TimeStamp,type = "line", 
                ylab= "Global Active Power (kilowatts)",
                xlab = ""))
##annotations

dev.off() #close the png device
# now you can view the file on your computer