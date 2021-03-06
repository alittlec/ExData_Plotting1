# Week 1 'exploratory data analysis', plot1

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

png("plot1.png",width=480,height=480)
hist(inputData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()