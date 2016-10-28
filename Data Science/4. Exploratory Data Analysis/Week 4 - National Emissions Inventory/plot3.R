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

# subset the Baltimore City, Maryland (fips == "24510") data
BaltimoreNEI = subset (NEI, fips == "24510")

# aggregate() the Emissions by year
EmmTotalByYearType = aggregate(Emissions ~ (year +  type), BaltimoreNEI, sum)

# plot the graph
png("plot3.png",width=480,height=480)
g = ggplot(EmmTotalByYearType, aes (year, Emissions/(10^6), color=type)) + geom_line() + 
    ggtitle (expression("Baltimore, Maryland" ~ PM[2.5] ~"Emissions by source type & year")) +
    xlab ("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
print (g)
dev.off()
rm ("NEI")
rm ("SCC")
rm ("BaltimoreNEI")
rm ("EmmTotalByYearType")