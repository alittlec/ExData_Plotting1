# Week 1 'exploratory data analysis', plot 3

require(sqldf)
localFile <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"

if (!file.exists(localFile)){
  download.file(url,destfile)
  unzip(destfile)
  unlink(destfile)
}

#read only the required dates (2007-02-01 and 2007-02-02)
library(sqldf)
inputData <- read.csv2.sql(localFile,
                           header=TRUE,
                           sep=";",
                           na.strings="?",
                           sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

inputData$DateTime <- paste(inputData$Date,inputData$Time)
inputData$DateTime <- strptime(inputData$DateTime,format="%d/%m/%Y %H:%M:%S") #1/1/2007 00:01:00
inputData$Date <- as.Date(inputData$Date,format="%d/%m/%Y")

png("plot3.png",width=480,height=480)
with(inputData, plot(DateTime,Sub_metering_1,type="l",col="black",ylab="Energy sub metering"))
with(inputData, lines(DateTime,Sub_metering_2,col="red"))
with(inputData, lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1)
dev.off()