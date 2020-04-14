## plot4.R
library(data.table)
library(dplyr)
library(lubridate)

# Get data
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataurl,"data.zip")
unzip("data.zip")

# Load data
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
dat <- tbl_df(dat)

# Transform date and time variables
dat <- mutate(dat, Datetime = dmy_hms(paste(Date,Time)))
dat <- mutate(dat, Date = dmy(Date))

# Select only relevant observations
dat <- filter(dat, Date >= "2007-02-01" & Date <= "2007-02-02")

# Change to english 
curlang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English_United States.1252")

# Open PNG device
png(filename = "plot4.png", width = 480, height = 480)

# Construct plot
par(mfrow = c(2,2))
plot(dat$Datetime, dat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(dat$Datetime, dat$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(dat$Datetime, dat$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(dat$Datetime, dat$Sub_metering_2, col = "red")
lines(dat$Datetime, dat$Sub_metering_3, col = "blue")
legend("topright", inset = 0.01,col = c("black", "red", "blue"), lty = c(1, 1, 1), box.lty = 0, cex = 0.9, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dat$Datetime, dat$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Close PNG device
dev.off()

# Change back to original language
Sys.setlocale("LC_TIME", curlang)

print("plot4.png created!")