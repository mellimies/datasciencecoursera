# plot 1

source('common.R')

par(mfrow=c(1,1))

png(file="plot1.png")
hist(df$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()
