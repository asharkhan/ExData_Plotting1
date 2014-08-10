# download data to local working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip("data.zip", overwrite = TRUE)

# read all data. May take time and memory depeding on your computer 
allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# convert first column to date object
allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")

# get data only for the two days that interest us.
d <- subset(allData, Date == "2007-02-01" | Date == "2007-02-02")

# convert columns from factor to numeric values
d[,3] <- as.numeric(levels(d[,3]))[d[,3]]
d[,4] <- as.numeric(levels(d[,4]))[d[,4]]
d[,5] <- as.numeric(levels(d[,5]))[d[,5]]
d[,7] <- as.numeric(levels(d[,7]))[d[,7]]
d[,8] <- as.numeric(levels(d[,8]))[d[,8]]
d[,9] <- as.numeric(levels(d[,9]))[d[,9]]

# convert time column from factor to time 
d$Time <- strptime(paste(d[,1], d[,2]), format = "%Y-%m-%d %H:%M:%S")

# open png graphics device
png(file = "plot4.png")

# prepare to plot 4 charts
par(mfcol = c(2, 2), mar = c(4, 4, 2, 2))

# plot 1
plot(d$Time, d$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# plot 2
plot(d$Time, d$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(d$Time, d$Sub_metering_2, type = "l", col = "red")
points(d$Time, d$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# plot 3
plot(d$Time, d$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 4
plot(d$Time, d$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# close device
dev.off()