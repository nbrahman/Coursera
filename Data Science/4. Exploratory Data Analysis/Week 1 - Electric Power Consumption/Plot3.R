# reading the data set
dataComplete = read.table("./household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# filtering the required data
dataRequired = subset(dataComplete,Date=="1/2/2007"|Date=="2/2/2007")
rm(dataComplete)
# converting datetime as usggested
dataRequired$Date <- as.Date(dataRequired$Date, format="%d/%m/%Y")
dateTime = paste(as.Date(dataRequired$Date), dataRequired$Time)
dataRequired$Timestamp = as.POSIXct(dateTime)
# plotting line graph
plot(dataRequired$Sub_metering_1~dataRequired$Timestamp, type = "l", xlab = "", ylab = "Energy sub metering")
# adding an additional red trend line for datetime v Sub metering 2 data
lines(dataRequired$Sub_metering_2~dataRequired$Timestamp, type = "l", col = "red" )
# adding an additional blue trend line for datetime v Sub metering 3 data
lines(dataRequired$Sub_metering_3~dataRequired$Timestamp, type = "l", col = "blue" )
# adding legend to graph
legend ("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# saving the graph to PNG file
dev.copy(png, file="./plot3.png", height=480, width=480)
dev.off()