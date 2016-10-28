library (ggplot2)

# read the objects in not available readily
if(!exists("NEI"))
{
  NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC"))
{
  SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
}

# subset the data based on condition
SubsetData = subset (NEI, type=="ON-ROAD" & fips=="24510")

# aggregate() the Emissions by year
aggSubset = aggregate(Emissions ~ year, SubsetData, sum)

# plot the graph
png("plot5.png",width=480,height=480)
g = qplot(year, Emissions, data = aggSubset, geom= "line") + 
    ggtitle (expression("Vehicle source based " ~ PM[2.5] ~"Emissions in Baltimore by year")) +
    xlab ("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
print (g)
rm ("aggSubset")
rm ("NEI")
rm ("SCC")
rm ("SubsetData")
dev.off()