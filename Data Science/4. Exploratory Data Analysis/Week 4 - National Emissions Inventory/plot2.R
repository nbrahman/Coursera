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
EmmTotalByYear = aggregate(Emissions ~ year, BaltimoreNEI, sum)

# plot the graph
png("plot2.png",width=480,height=480)
plot(EmmTotalByYear$year, EmmTotalByYear$Emissions/(10^6), type="l", xlab = "Year", col="purple",
     ylab = expression ("Total" ~ PM[2.5] ~"Emissions (tons)"), 
     main = expression ("Baltimore, Maryland" ~ PM[2.5] ~"Emissions by year"))
dev.off()
rm ("NEI")
rm ("SCC")
rm ("BaltimoreNEI")
rm ("EmmTotalByYear")