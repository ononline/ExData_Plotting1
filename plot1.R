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
globalActPow <- as.numeric(values$Global_active_power)

# Creation of the plot file
png(filename = "plot1.png")

# Plotting
hist(globalActPow, col = "red", breaks = 12,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Closing the plot file
dev.off()