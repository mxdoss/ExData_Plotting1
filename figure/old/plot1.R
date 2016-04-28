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
Data<-fread("household_power_consumption.txt", header=T)
str(Data)
#convert characters into date format
Data$Date <- as.Date(Data$Date , "%d/%m/%Y")
cData<-Data[order(Data$Date),]
str(cData)

# refine and define dataset
SelectData<-cData[Date %between% c("2007-02-01", "2007-02-02")]
str(SelectData)

#convert charecter into numeric
SelectData$Global_active_power<-as.numeric(SelectData$Global_active_power)
cSelectData<-SelectData[order(SelectData$Global_active_power),]
str(cSelectData)

#store histogram in .png format
png(file="plot1.png",width=480,height=480)
hist(SelectData$Global_active_power, main ="Global Active Power" , xlab ="Global Active Power (kilowatts)", ylab = "Frequency", col="red")
dev.off()
