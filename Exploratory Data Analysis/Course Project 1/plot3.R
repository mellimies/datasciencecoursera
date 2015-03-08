library(dplyr)

cClasses = c(rep("character",2 ), rep("numeric", 7))
df <- read.csv('household_power_consumption.txt', sep=';', na.strings="?", colClasses=cClasses)
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

df$Date_and_time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# plot 3

par(mfrow=c(1,1))

plot(df$Date_and_time, df$Sub_metering_1, type='o', pch='', xlab='', ylab='Energy sub metering')
lines(df$Date_and_time, df$Sub_metering_2, col='red')
lines(df$Date_and_time, df$Sub_metering_3, col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.copy(png, file="plot3.png")
dev.off()
