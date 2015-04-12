# plot 3

source('common.R')

par(mfrow=c(1,1))
png(file="plot3.png")
with(df, {
  plot(Date_and_time, df$Sub_metering_1, type='o', pch='', xlab='', ylab='Energy sub metering')
  lines(Date_and_time, df$Sub_metering_2, col='red')
  lines(Date_and_time, df$Sub_metering_3, col='blue')
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))  
})
dev.off()
