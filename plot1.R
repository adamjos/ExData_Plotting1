## Plot1.R
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
dat <- mutate(dat, Date = dmy(Date))
dat <- mutate(dat, Time = hms(Time))

# Select only relevant observations
dat <- filter(dat, Date >= "2007-02-01" & Date <= "2007-02-02")

# Construct plot
hist(dat$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Copy plot to PNG
dev.copy(png, "plot1.png", width = 480, height = 480)

# Close PNG device
dev.off()

print("plot1.png created!")