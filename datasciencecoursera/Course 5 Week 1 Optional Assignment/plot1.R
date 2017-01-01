# read the objects in not available readily
if(!exists("payments"))
{
  payments = read.csv("./payments.csv")
}

# plot the first graph
pdf("plot1.pdf")
with (my_data, 
      plot (Average.Covered.Charges, Average.Total.Payments, 
            col="red", 
            xlab="Average Covered Charges", 
            ylab="Average Total Payments", 
            main="Comparison between Average Covered Charges \nand Average Total Payments"
            )
      )
dev.off()
rm ("payments")