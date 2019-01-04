library(tidyverse)

electric <- read.table("./household_power_consumption.txt",header = TRUE,sep = ';',na.strings = '?'
                       ,colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


#Choosing only the dates that fall into 2007-02-01 and 2007-02-02
electricFiltered <- electric %>% filter(Date == '2/2/2007')
electricFiltered2 <- electric %>% filter(Date == '1/2/2007')
electricFilt <- rbind(electricFiltered,electricFiltered2)

#Converting to a date
electricFilt$Date <- as.Date(electricFilt$Date, '%d/%m/%Y')
#And need to add in a datetime
dateTime <- paste(electricFilt$Date,electricFilt$Time) #Combines two columns into one
electricFilt <- electricFilt %>% mutate(datetime = lubridate::as_datetime(dateTime)) %>% arrange(datetime)
#Subplot 1 is same as plot 2
#Subplot 2 is voltage over time
#Subplot 3 is same as plot 3
#Subplot 4 is GRP over time


par(mfrow=c(2,2),mar=c(4,4,2,1)) #2 by 2 array of subplots

#Top left subplot
plot(electricFilt$Global_active_power ~ electricFilt$datetime,type = 'l',ylab = 'Global Active Power (kilowatts)',xlab = '') #Okay there's a weird extra line - why?

#Top right subplot
plot(electricFilt$datetime,electricFilt$Voltage,type = 'l',xlab = 'datetime',ylab='Voltage')

#Bottom left subplot
plot(electricFilt$datetime,electricFilt$Sub_metering_1,type = 'l', xlab = '', ylab = 'Energy sub metering', col = 'black')
lines(electricFilt$datetime,electricFilt$Sub_metering_2,col = 'red')
lines(electricFilt$datetime,electricFilt$Sub_metering_3,col='blue')
legend("topright",lwd = c(1,1,1),cex = .5,col = c('black','blue','red'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#Bottom right subplot
plot(electricFilt$datetime,electricFilt$Global_reactive_power,xlab = 'datetime',ylab = 'global_reactive_power',type = 'l')

#Saving it
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()