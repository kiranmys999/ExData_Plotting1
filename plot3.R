############################################################
# Note: 
# Make sure the parent directory of this file has the
# input data file - "household_power_consumption.txt"
# for the code to run without errors. Otherwise set the 
# working directory in the code below appropriately.
############################################################


# Read the current working directory path before changing directory.
currDir <- getwd()
# Set the parent directory as the working directory where the input data file is stored.
setwd("../")
# Read the input file name into a variable.
inputFile <- "household_power_consumption.txt"
# load the library sqldf for using the function 'read.csv.sql'.
library(sqldf)
# Use function read.csv.sql() to select only specific dates from the input file.
powerCon <- read.csv.sql(inputFile, "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'", sep=";")
# Reset the working directory to the directory containing this code file.
setwd(currDir)

# Convert the Date column to Date class.
powerCon[,1] <- as.Date(powerCon[,1], "%d/%m/%Y")
# Join Date and Time columns into a new variable called DateTime and add this new variable as a column to powerCon.
powerCon$DateTime <- with(powerCon, paste(Date, Time))
# Convert the column DateTime to datetime format.
powerCon$DateTime <- strptime(powerCon$DateTime, "%Y-%m-%d %H:%M:%S")

# Open a png graphic device for plotting and saving to a png file.
# First create an empty scatter plot, then add data points for each Sub metering variable, with different
# colors for each.
# Add labels for X-Y axes and a legend on the top right corner of the graph for the variables.

png(filename="plot3.png", width=480, height=480)
with(powerCon, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab=""))
with(powerCon, points(DateTime, Sub_metering_1, type="l"))
with(powerCon, points(DateTime, Sub_metering_2, type="l", col="red"))
with(powerCon, points(DateTime, Sub_metering_3, type="l", col="blue"))
title(ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

# Close the png graphic device.
dev.off()
