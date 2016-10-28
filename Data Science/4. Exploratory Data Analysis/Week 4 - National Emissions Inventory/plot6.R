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

# subset the data based on required condition
SubsetData = subset (NEI, type=="ON-ROAD" & (fips=="24510" | fips=="06037"))

# aggregate() the Emissions by year
aggSubset = aggregate(Emissions ~ (year+fips), SubsetData, sum)
aggSubset$county = ifelse(aggSubset$fips == "06037", "Los Angeles", "Baltimore")

# plot the graph
png("plot6.png",width=480,height=480)
g = ggplot(aggSubset, aes (year, Emissions, color=county)) + geom_line() + 
    ggtitle (expression("Year wise Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  in Los Angeles and Baltimore")) +
    xlab ("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) #+
    #stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line")
print (g)
#rm ("aggSubset")
dev.off()
rm ("NEI")
rm ("SCC")
rm ("SubsetData")
rm ("aggSubset")