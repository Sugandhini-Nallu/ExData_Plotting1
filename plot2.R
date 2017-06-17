#This Program reads the text file into R with selected data on the Date Field 
#Then creates a base plot for Datetime and Global Active Power

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

# Convert Global active Power to numeric value
global_active_power <- as.numeric(file_data$Global_active_power)

#Convert Date and Time fields to their orginal format
Datetime <- strptime(paste(file_data$Date,file_data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

#Create a png file to store the Graph
png("plot2.png", width = 480, height = 480)

#Create a base graph for Date_time and global active power
plot(Datetime, global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Close the png file
dev.off()