# download data to local working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip("data.zip", overwrite = TRUE)

# read all data. May take time and memory depeding on your computer 
allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# convert first column to date object
allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")

# get data only for the two days that interest us.
d <- subset(allData, Date == "2007-02-01" | Date == "2007-02-02")

# convert Global Active Power Column from factor to numeric values
d[,3] <- as.numeric(levels(d[,3]))[d[,3]]

# convert time column from factor to time 
d$Time <- strptime(paste(d[,1], d[,2]), format = "%Y-%m-%d %H:%M:%S")

# plot the chart
plot(d$Time, d$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# save it to file
dev.copy(png, file = "plot2.png")
dev.off()