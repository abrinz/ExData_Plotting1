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

#Plot 1 - GAP vs frequency histogram
hist(electricFilt$Global_active_power,main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()