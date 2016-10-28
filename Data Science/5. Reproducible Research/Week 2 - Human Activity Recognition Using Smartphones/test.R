activity_data <- read.csv("activity.csv", na.strings = "NA")
activity_data$date <- as.Date(activity_data$date, "%Y-%m-%d")
meanEachInterval <- aggregate(steps ~ interval, activity_data, mean)
activity_data_modified <- activity_data
for (int in seq(0, 2355, 5)) {
  idx <- which(activity_data_modified$interval == int & is.na(activity_data_modified$steps))
  activity_data_modified[idx, "steps"] <- meanEachInterval[meanEachInterval$interval == int, "steps"]
}
activity_data_modified$categoryDay <- format(activity_data_modified$date, "%u")
activity_data_modified$categoryDay[activity_data_modified$categoryDay %in% 1:5] <- "weekday"
activity_data_modified$categoryDay[activity_data_modified$categoryDay %in% 6:7] <- "weekend"
activity_data_modified$categoryDay <- as.factor(activity_data_modified$categoryDay)

library(ggplot2)
library(grid)

options(scipen = 1000)
newIntervalMean <- aggregate(steps ~ categoryDay + interval, activity_data_modified, mean)
# Means of weekdays and weekends
avgWeekDay <- mean(subset(newIntervalMean, categoryDay == "weekday")$step)
avgWeekEnd <- mean(subset(newIntervalMean, categoryDay == "weekend")$step)
# See "Explanations" below: Find the first and last intervals when the steps are above their means
startWeekDay <- min(subset(newIntervalMean, categoryDay == "weekday" & steps >= avgWeekDay)$interval)
endWeekDay <- max(subset(newIntervalMean, categoryDay == "weekday" & steps >= avgWeekDay)$interval)
startWeekEnd <- min(subset(newIntervalMean, categoryDay == "weekend" & steps >= avgWeekEnd)$interval)
endWeekEnd <- max(subset(newIntervalMean, categoryDay == "weekend" & steps >= avgWeekEnd)$interval)
# Lines we use for annotations
meanLines <- data.frame(categoryDay = c("weekday", "weekend"), mean = c(avgWeekDay, avgWeekEnd),
                        start = c(startWeekDay, startWeekEnd),
                        end = c(endWeekDay, endWeekEnd))

ggplot(newIntervalMean, aes(interval, steps)) + geom_line() + facet_grid(categoryDay ~ .) +
  geom_hline(aes(yintercept = mean), data = meanLines, col = "red") + 
  geom_vline(aes(xintercept = start), data = meanLines, col = "blue", linetype = "dashed") +
  geom_vline(aes(xintercept = end), data = meanLines, col = "blue", linetype = "dashed") +
  labs(x = "5-Minute Interval ID (e.g., 730 for interval [07:30, 07:35))", y = "Average Number of Steps", 
       title = "Average Number of Steps for Each 5-Minute Interval") +
  scale_x_continuous(breaks = seq(0, 2400, 200)) +
  theme(text = element_text(size = 14), strip.text = element_text(size = 14), 
        axis.title.x = element_text(vjust = -0.5), axis.title.y = element_text(vjust = +1.0),
        title = element_text(vjust = +1.0), plot.title = element_text(face = "bold"))