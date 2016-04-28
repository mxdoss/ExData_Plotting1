#remove any existing variables/objects
rm(list = ls(all = TRUE))
#Install package if not installed previously and load it
if(!require(data.table)){
    install.packages("data.table")
    library(data.table)
}

#Create a folder in the desktop for this assignment
setwd("~/Desktop")
if (!dir.exists("Assignment")){
        dir.create("Assignment")
      }
setwd("~/Desktop/Assignment")

#Download and unzip the data to the local desktop folder called "Data.zip"
  if (!file.exists("Data.zip")){
        DataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(DataURL, destfile = "Data.zip", method="curl")
        unzip("Data.zip")
      }


# read the data into table
Data<-fread("household_power_consumption.txt", header=T, na.strings="?")
str(Data)
#convert characters into date format
Data$Date <- as.Date(Data$Date , "%d/%m/%Y")
cData<-Data[order(Data$Date),]
str(cData)

# refine and define dataset
SelectData<-cData[Date %between% c("2007-02-01", "2007-02-02")]
str(SelectData)
rm("Data")
rm("cData")

DateTime <- paste(as.Date(SelectData$Date, "%d/%m/%Y"), SelectData$Time)
SelectData$DateTime<- as.POSIXct(DateTime)
str(SelectData)

class(SelectData$DateTime)

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#plot1

x<-SelectData$DateTime
y<-SelectData$Global_active_power
with(SelectData, plot(Global_active_power~DateTime, type="l", xlab="", ylab="Global Active Power"))

#plot2
with(SelectData, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = 'l'))

#plot3

with(SelectData, plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(SelectData,lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(SelectData,lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = c(1, 1, 1), bty = "n")


#plot4
with(SelectData, plot(DateTime,Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = 'l'))

#plot4
dev.off()
