# reading the data set
dataComplete = read.table("./household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# filtering the required data
dataRequired = subset(dataComplete,Date=="1/2/2007"|Date=="2/2/2007")
rm(dataComplete)
# converting datetime as usggested
dataRequired$Timestamp = paste(dataRequired$Date, dataRequired$Time)
# plotting line graph
plot(strptime(dataRequired$Timestamp, "%d/%m/%Y %H:%M:%S"), dataRequired$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
# saving the graph to PNG file
dev.copy(png, file="./plot2.png", height=480, width=480)
dev.off()