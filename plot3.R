## Exploratory Data Analysis Assignment 1
## 1/10/2015 - Produces Plot 3  - Graphs Sub Meter measurements vs time# assumes input file is household_power_consumption.txt 
# assumes input file is household_power_consumption.txt 
library(data.table)

file<-"household_power_consumption.txt"

dtime <- difftime(as.POSIXct("2007-02-03"), 
                  as.POSIXct("2007-02-01"),
                  units="mins") ## calculates number of minutes in two days 

rowsToRead <- as.numeric(dtime) ## number of minutes in two days =
## number of rows to be read


powcon <- data.frame(fread(file, 
                           skip="1/2/2007",      #skips row until it finds the first row of the date range
                           nrows = rowsToRead,   #reads in two days worth of rows
                           na.strings = c("?", ""))) #creates a datatable from rows read

setnames(powcon,
         colnames(fread(file,
                        nrows=0))) ## read the row names from the original file and add them to the table

powcon$datetime<-as.POSIXct(paste (powcon$Date,powcon$Time),
                            format="%d/%m/%Y%H:%M:%S") #add date to time field and paste set type to time

powcon<-powcon[,c(10,3:9)] ##remove original date/time column 
                            ## and reorder columns so date/time is first


png(file="plot3.png")  ##open output device

with(powcon,plot(datetime,Sub_metering_1,type="n",xlab = "",ylab = "Energy sub metering"))
with(powcon,lines(datetime,Sub_metering_1,col="black"))
with(powcon,lines(datetime,Sub_metering_2,col="red"))
with(powcon,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty = 1, col= c("black","red","blue"), legend = names(powcon)[6:8])

dev.off()  ##close output device
