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

# merge the NEI & SCC dataset based on SCC
ConsolidatedData = merge (NEI, SCC, by="SCC")

# subset the data based on coal-combustion
SubsetData = subset (ConsolidatedData, grepl("Comb", ConsolidatedData$Short.Name, ignore.case=TRUE) & grepl("Coal", ConsolidatedData$Short.Name, ignore.case=TRUE))

# aggregate() the Emissions by year
aggCoalCombData = aggregate(Emissions ~ (year + type), SubsetData, sum)

# plot the graph
png("plot4.png",width=480,height=480)
g = ggplot(aggCoalCombData, aes (year, Emissions/(10^5), color = type)) + geom_line() + 
    ggtitle (expression("Coal Combustion" ~ PM[2.5] ~"Emissions by source type & year")) +
    xlab ("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))+
    stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line")
print (g)
dev.off()
rm ("NEI")
rm ("SCC")
rm ("ConsolidatedData")
rm ("SubsetData")
rm ("aggCoalCombData")