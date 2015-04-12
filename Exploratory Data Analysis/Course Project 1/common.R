# Override Finnish locale with en_US so that data formatting matches assignment.
# Data frame named 'df' is available after sourcing this script.

Sys.setlocale("LC_TIME", "en_US")

library(dplyr)

cClasses = c(rep("character",2 ), rep("numeric", 7))
df <- read.csv('household_power_consumption.txt', sep=';', na.strings="?", colClasses=cClasses)
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

df$Date_and_time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
