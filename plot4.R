## Exploratory Data Analysis Assignment 1
## 1/10/2015 - Produces Plot 4  - 4 Graphs  
# assumes input file is household_power_consumption.txt in working directory

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


png(file="plot4.png") ##output grpahs to file "plot4.png"
##windows()

##Generate plots

par(mfrow=c(2,2))  ##Establish 2x2 plot layout


##  Plot 1: Global Active Power vs time  plot
with(powcon,plot(datetime,Global_active_power,
                 type="n",
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)"))

with(powcon,lines(datetime,Global_active_power))


##  Plot 2: Voltage vs time plot
with(powcon,plot(datetime,Voltage,
                 type="n",                 
                 ylab = "Voltage"))

with(powcon,lines(datetime,Voltage))

##Plot 3 Submetering vs time  plot
with(powcon,plot(datetime,Sub_metering_1,type="n",xlab = "",ylab = "Energy sub metering"))
with(powcon,lines(datetime,Sub_metering_1,col="black"))
with(powcon,lines(datetime,Sub_metering_2,col="red"))
with(powcon,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty = 1, col= c("black","red","blue"), legend = names(powcon)[6:8])

##  Plot 4: Global Reactive power vs time plot
with(powcon,plot(datetime,
                 Global_reactive_power,
                 type="n"))

with(powcon,
     lines(datetime,
           Global_reactive_power))


dev.off()