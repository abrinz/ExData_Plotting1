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

#Plot 3 - All three sub-metering datapoints over time
#Now how in tarnation do I do this?
plot(electricFilt$datetime,electricFilt$Sub_metering_1,type = 'l', xlab = '', ylab = 'Energy sub metering', col = 'black')
lines(electricFilt$datetime,electricFilt$Sub_metering_2,col = 'red')
lines(electricFilt$datetime,electricFilt$Sub_metering_3,col='blue')
legend("topright",lwd = c(1,1,1),col = c('black','blue','red'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#Saving the file
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()