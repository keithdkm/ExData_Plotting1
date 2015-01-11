## Exploratory Data Analysis Assignment 1
## 1/10/2015 - Produces Plot 1  - Histogram of Global Active Power 
# assumes input file is household_power_consumption.txt in working directory


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

png(file="plot1.png")  ##open PNG graphics device

hist(powcon$Global_active_power,
     col = "red" ,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
