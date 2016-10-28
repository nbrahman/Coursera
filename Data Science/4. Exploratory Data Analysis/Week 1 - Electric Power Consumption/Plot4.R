# reading the data set
dataComplete = read.table("./household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# filtering the required data
dataRequired = subset(dataComplete,Date=="1/2/2007"|Date=="2/2/2007")
rm(dataComplete)
# converting datetime as usggested
dataRequired$Date <- as.Date(dataRequired$Date, format="%d/%m/%Y")
dateTime = paste(as.Date(dataRequired$Date), dataRequired$Time)
dataRequired$Timestamp = as.POSIXct(dateTime)
# defining the row - column structure along with the required margins
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(dataRequired, {
  # plotting line graph for Active Power vs. Date Time
  plot(Global_active_power~Timestamp, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  # plotting line graph for Voltage vs. Date Time
  plot(Voltage~Timestamp, type="l", ylab="Voltage (volt)", xlab="")
  # plotting line graph for Sub Metering 1 vs. Date Time
  plot(Sub_metering_1~Timestamp, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  # adding an additional red trend line for Sub metering 2 vs Date Time
  lines(Sub_metering_2~Timestamp,col='Red')
  # adding an additional red trend line for Sub metering 3 vs Date Time
  lines(Sub_metering_3~Timestamp,col='Blue')
  # adding legend to graph
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # plotting line graph for Reactive Power vs. Date Time
  plot(Global_reactive_power~Timestamp, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})
# saving the graph to PNG file
dev.copy(png, file="./plot4.png", height=480, width=480)
dev.off()