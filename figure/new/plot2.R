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


DateTime <- paste(as.Date(SelectData$Date, "%d/%m/%Y"), SelectData$Time)
SelectData$DateTime<- as.POSIXct(DateTime)
str(SelectData)

class(SelectData$DateTime)


png(file="plot2.png",width=480,height=480)
x<-SelectData$DateTime
y<-SelectData$Global_active_power
with(SelectData, plot(Global_active_power~DateTime, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
