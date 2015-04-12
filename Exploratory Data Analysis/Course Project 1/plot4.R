# plot 4

source('common.R')

png(file = "plot4.png")

par(mfrow=c(2,2))
with(df, {
  
  # plot 1,1
  plot(Date_and_time, Global_active_power, ylab = 'Global Active Power', type='o', pch='', xlab='')

  # plot 1,2
  plot(Date_and_time, Voltage, ylab = 'Voltage', type='o', pch='', xlab='datetime')
  
  # plot 2,1
  plot(Date_and_time, Sub_metering_1, type='o', pch='', xlab='', ylab='Energy sub metering')
  lines(Date_and_time, Sub_metering_2, col='red')
  lines(Date_and_time, Sub_metering_3, col='blue')
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1, col=c("black", "red", "blue"), bty="n")

  # plot 2,2
  plot(Date_and_time, Global_reactive_power, type='o', pch='', xlab='datetime')
})

dev.off()
