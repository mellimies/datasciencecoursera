library(dplyr)

cClasses = c(rep("character",2 ), rep("numeric", 7))
df <- read.csv('household_power_consumption.txt', sep=';', na.strings="?", colClasses=cClasses)
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

df$Date_and_time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# plot 4

png(file = "plot4.png")

par(mfrow=c(2,2))
with(df, plot(Date_and_time, Global_active_power, ylab = 'Global Active Power', type='o', pch='', xlab=''))
with(df, plot(Date_and_time, Voltage, ylab = 'Voltage', type='o', pch='', xlab='datetime'))

with(df, plot(Date_and_time, Sub_metering_1, type='o', pch='', xlab='', ylab='Energy sub metering'))
with(df, lines(Date_and_time, Sub_metering_2, col='red'))
with(df, lines(Date_and_time, Sub_metering_3, col='blue'))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

with(df, plot(Date_and_time, Global_reactive_power, type='o', pch='', xlab='datetime'))

dev.off()
