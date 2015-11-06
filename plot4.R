# ATTENTION: the file plot1.png was generated in a Windows in portuguese(BR).
#            Please mind that Thu == qui; Fri == sex; Sat == sáb.


# Set dates and times for data extraction
firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime <- strptime("2007-02-01 00:01:00", "%Y-%m-%d %H:%M:%S")

# Calculate which lines to read in
begin <- beginDateTime - firstDateTime
beginLine <- as.numeric(begin) * 24 * 60 # first line to read in
numLines <- 48 * 60 # total number of minutes in 48 hours, total number of rows to read in

# Create the labels of the columns according to the assignment
names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
           "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
           "Sub_metering_3")
# File name in a variable for shorter function call
file <- "household_power_consumption.txt"

# File reading. colClasses called as character for later conversion
values <- read.csv2(file, na.strings = "?", skip = beginLine, nrows =  numLines, 
                    header = F, col.names = names, colClasses = "character")

# Data types treatment
values$Date <- as.Date(values$Date, format = "%d/%m/%Y")
globalActPow <- as.numeric(values$Global_active_power)
globalReactPow <- as.numeric(values$Global_reactive_power)
voltage <- as.numeric(values$Voltage)
sub1 <- as.numeric(values$Sub_metering_1)
sub2 <- as.numeric(values$Sub_metering_2)
sub3 <- as.numeric(values$Sub_metering_3)
dateTime <- as.POSIXct(paste(values$Date, values$Time), format="%Y-%m-%d %H:%M:%S")


# Creation of the plot file
png(filename = "plot4.png")

# Setting the graph to have 2x2 plots
par(mfrow=c(2,2))

# Plotting 1
plot(dateTime, globalActPow, type = "l",
     main = "", xlab = "", ylab = "Global Active Power")

# Plotting 2
plot(dateTime, voltage, type = "l",
     main = "", xlab = "", ylab = "Voltage")

# Plotting 3 
plot(dateTime, sub1, type = "l",
     main = "", xlab = "", ylab = "Energy sub metering")
lines(dateTime, sub2, col = "red")
lines(dateTime, sub3, col = "blue")

# Inserting the legend
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),cex=0.8, lty = 1)

# Plotting 4
plot(dateTime, globalReactPow, type = "l",
     main = "", xlab = "", ylab = "Global Reactive Power")

# Closing the plot file
dev.off()