library(data.table)
library(base)
library(chron)
library(lattice)
library(ggplot2)
getwd()
Data<-fread("household_power_consumption.txt", header=T)
str(Data)
Data$Date <- as.Date(Data$Date , "%d/%m/%Y")
cData<-Data[order(Data$Date),]
str(cData)
SelectData<-cData[Date %between% c("2007-02-01", "2007-02-02")]
str(SelectData)

SelectData$Time <- chron(times=SelectData$Time)
cSelectData<-SelectData[order(SelectData$Time),]
str(cSelectData)
DTT<-within(cSelectData, DT<-paste(Date, Time, sep=' '))
str(DTT)

DTT$DT<- as.POSIXct(DTT$DT)
class(DateTime)

cDTT<-DTT[order(DTT$DT),]
str(cDTT)

cDTT$Global_active_power<-as.numeric(DTT$Global_active_power)
cDTT<-DTT[order(DTT$Global_active_power),]
str(cDTT)
head(cDTT)


png(file="plot2.png",width=480,height=480)
x<-cDTT$DT
y<-cDTT$Global_active_power
plot(x,y, type="h")
dev.off()
