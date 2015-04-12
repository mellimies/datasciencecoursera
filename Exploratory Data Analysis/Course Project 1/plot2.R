# plot 2

source('common.R')

par(mfrow=c(1,1))

png(file="plot2.png")
plot(df$Date_and_time, df$Global_active_power, ylab = 'Global Active Power (kilowatts)', type='o', pch='', xlab='')
dev.off()
