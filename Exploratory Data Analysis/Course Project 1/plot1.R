library(dplyr)

cClasses = c(rep("character",2 ), rep("numeric", 7))
df <- read.csv('household_power_consumption.txt', sep=';', na.strings="?", colClasses=cClasses)
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

# plot 1
hist(df$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')


# plot 2

df$Date_and_time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
plot(df$Date_and_time, df$Global_active_power, ylab = 'Global Active Power (kilowatts)', type='o', pch='', xlab='')

# plot 3

plot(df$Date_and_time, df$Sub_metering_1, type='o', pch='', xlab='', ylab='Energy sub metering')
lines(df$Date_and_time, df$Sub_metering_2, col='red')
lines(df$Date_and_time, df$Sub_metering_3, col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
#