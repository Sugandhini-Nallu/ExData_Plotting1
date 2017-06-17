#This Program reads the text file into R with selected data on the Date Field 
#Then creates a base plot for Datetime and Sub Meterings

#Store the filename
file_name <- "household_power_consumption.txt"

#Read the file lines
file_lines <- readLines(file_name)

#Select the lines with Dates in "1/2/2007" or "2/2/2007"
# id captures the indexes of the file with selected dates
id <- grep("^[1|2]/2/2007", file_lines)

#Read the file only with the selected indexes using textConnection, instead reading the 
#entire data set, we are only reading selective rows by filtering on the Date
file_data <- read.table(textConnection(file_lines[id]), sep = ";", header = TRUE, 
                        dec = ".", stringsAsFactors = FALSE )

#Assign the column names to the new data set 
names(file_data) <- c("Date","Time","Global_active_power","Global_reactive_power",
                      "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                      "Sub_metering_3")


#Convert Date and Time fields to their orginal format
Datetime      <- strptime(paste(file_data$Date,file_data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

#Convert Sub metering to numeric formats
Submetering_1 <- as.numeric(file_data$Sub_metering_1)
Submetering_2 <- as.numeric(file_data$Sub_metering_2)
Submetering_3 <- as.numeric(file_data$Sub_metering_3)

#Create a png file to store the Graph
png("plot3.png", width = 480, height = 480)

#Create a base graph for Date_time and Sub metering 1
plot(Datetime, Submetering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Add lines for Sub metering 2
lines(Datetime, Submetering_2, col = "red")

#Add lines for Sub metering 3
lines(Datetime, Submetering_3, col = "blue")

#Add the text in the top right portion of the graph
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close the png file
dev.off()