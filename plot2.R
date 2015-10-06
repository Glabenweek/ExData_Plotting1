# Script for plot 2

# for english weekdays names
Sys.setlocale("LC_TIME", "English")

# Create the folder to save the original data
if (!file.exists("data")) {
  dir.create("data")
}

# Download the original data in the data folder and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/original_data.zip")
unzip("./data/original_data.zip", exdir = "./data")

# Read the txt file
data <- read.table("./data/household_power_consumption.txt",sep=";",header=T,stringsAsFactors=F)
data$Date<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
sub_data<-subset(data,Date<"2007-02-03")
sub_data<-subset(sub_data,Date>="2007-02-01")
rm(data)


png("plot2.png")
plot(sub_data$Date, sub_data$Global_active_power, main="", xlab="",
     ylab="Global Active Power (kilowatts)", type = "l")
dev.off()
