### 06/10/2015
### Script for plot 3



### Remark: The part up to line 44 is common to the 4 R code files 



# Create the folder to save the original data
if (!file.exists("data")) {
    dir.create("data")
}

# Download the original data in the data folder and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="./data/original_data.zip")

unzip("./data/original_data.zip",
      exdir = "./data")

# Read the txt file
data <- read.table("./data/household_power_consumption.txt",
                   sep=";",
                   header=T,
                   stringsAsFactors=F)

# paste time and date columns
data$Date<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")

# define as numerical the character columns
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)

# subset the data from the 2 dates requested
sub_data<-subset(data,Date<"2007-02-03")
sub_data<-subset(sub_data,Date>="2007-02-01")

# remove the "data" object from working environment
rm(data)



### Create plot3

# set local system to have english weekday names (mine is in french)
Sys.setlocale("LC_TIME", "English")



##  Get the vertical limits for the third plot

ymax <- max(max(sub_data$Sub_metering_1),
            max(sub_data$Sub_metering_2),
            max(sub_data$Sub_metering_3))
ymin <- min(min(sub_data$Sub_metering_1),
            min(sub_data$Sub_metering_2),
            min(sub_data$Sub_metering_3))

png("plot3.png")

plot(sub_data$Date,
     sub_data$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type = "l",
     ylim = c(ymin,ymax))
points(sub_data$Date,
       sub_data$Sub_metering_2,
       col = "red",
       type = "l")
points(sub_data$Date,
       sub_data$Sub_metering_3,
       col = "blue",
       type = "l")

legend(par("usr")[2],
       par("usr")[4],
       yjust=1,
       xjust=1,
       c(colnames(sub_data)[7:9]),
       lwd=1,
       lty=1,
       col=c('black','red', 'blue'))

dev.off()
