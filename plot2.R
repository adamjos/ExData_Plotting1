## plot2.R
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
Sys.setlocale("LC_TIME","English_United States.1252")

# Construct plot
plot(dat$Datetime, dat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Copy plot to PNG
dev.copy(png, "plot2.png", width = 480, height = 480)

# Close PNG device
dev.off()

# Change back to original language
Sys.setlocale("LC_TIME",curlang)

print("plot2.png created!")