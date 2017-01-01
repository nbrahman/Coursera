Economic and Human Impact of Storms and other Weather Events in the United States
========================================================
author: "Nikhil"
date: "December 21, 2016"
autosize: true



1. What is mean total number of steps taken per day?
========================================================

```r
# 1.1 Calculate the total number of steps taken per day
steps <- aggregate (steps~date, activity_data, FUN=sum, na.action=na.omit)

# 1.2. Make a histogram of the total number of steps taken each day
p=plot_ly(type = "histogram", x=steps$steps, 
          hoverinfo=text)%>%
  layout(title="Histogram of Total Number of Steps",
            bargap= 0.015,
            xaxis=list(title="Number of Steps"),
            yaxis=list(title="Frequency"))

htmlwidgets::saveWidget(as.widget(p), file = "demo.html")
```

========================================================
<iframe src="demo.html" style="position:absolute;height:100%;width:100%"></iframe>


========================================================

```r
# 1.3. Calculate and report the mean and median of the total number of steps taken per day
mean(steps$steps,na.rm=TRUE)
```

```
[1] 10766.19
```

```r
median(steps$steps,na.rm=TRUE)
```

```
[1] 10765
```

2. What is the average daily activity pattern?
========================================================

```r
#1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
intervalMean <- aggregate (x=list(steps=activity_data$steps), by=list(interval=as.numeric(as.character(activity_data$interval))), FUN=mean, na.rm=TRUE)
p=plot_ly(x=intervalMean$interval, y=intervalMean$steps, type="scatter", mode="lines")%>%
  layout(title="Average number of steps for each 5 minute interval",
            xaxis=list(title="5 minute interval"),
            yaxis=list(title="Averages number of steps"))

htmlwidgets::saveWidget(as.widget(p), file = "demo2.html")
```

========================================================
<iframe src="demo2.html" style="position:absolute;height:100%;width:100%"></iframe>


========================================================

```r
#2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
intervalMean[which.max(intervalMean$steps),]
```

```
    interval    steps
104      835 206.1698
```



3. Total Number of steps taken each day
========================================================

```r
p=plot_ly(type = "histogram", x=newSteps$steps, 
          hoverinfo=text)%>%
  layout(title="New Histogram of Total Number of Steps",
            bargap= 0.015,
            xaxis=list(title="Number of Steps"),
            yaxis=list(title="Frequency"))

htmlwidgets::saveWidget(as.widget(p), file = "demo3.html")
```

========================================================
<iframe src="demo3.html" style="position:absolute;height:100%;width:100%"></iframe>


========================================================

```r
mean(newSteps$steps)
```

```
[1] 10766.19
```

```r
median(newSteps$steps)
```

```
[1] 10766.19
```

Thanks
========================================================

