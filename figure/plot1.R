library(data.table)
getwd()
Data<-fread("household_power_consumption.txt", header=T)
str(Data)
Data$Date <- as.Date(Data$Date , "%d/%m/%Y")
cData<-Data[order(Data$Date),]
str(cData)
SelectData<-cData[Date %between% c("2007-02-01", "2007-02-02")]
str(SelectData)
SelectData$Global_active_power<-as.numeric(SelectData$Global_active_power)
cSelectData<-SelectData[order(SelectData$Global_active_power),]
str(cSelectData)
png(file="plot1.png",width=480,height=480)
hist(SelectData$Global_active_power, main ="Global Active Power" , xlab ="Global Active Power (kilowatts)", ylab = "Frequency", col="red")
dev.off()
