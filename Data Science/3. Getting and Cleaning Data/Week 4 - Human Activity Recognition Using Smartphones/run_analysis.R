if (!require("plyr")) {
    install.packages("plyr")
}

require (plyr)

# check if directory already exists else create the directory and
# download the referred file with specific naming convention
dataDir = "./C3_W4_A1"
if (!file.exists(dataDir))
{
 dir.create(dataDir)
}
srcFileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dstFile = paste(dataDir, "/C3_W4_A1_Dataset.zip", sep = "")
print ("Downloading zipfile")
download.file(srcFileURL,destfile = dstFile)

# unzipping the file
print ("Extracting zipfile")
unzip (zipfile = dstFile, exdir = dataDir)

# reading the data from files into variables
dataDir = paste (dataDir, "/UCI HAR Dataset", sep = "")
activity_labels = read.table(paste(dataDir,"/activity_labels.txt", sep = ""))
features = read.table(paste(dataDir,"/features.txt", sep = ""), header = FALSE)

activity_labels[,2] = as.character(activity_labels[,2])
features[,2] = as.character(features[,2])

# separate features containing mean or standard deviation 
# and store the list in a separate variable
required_features = grep("mean\\(\\)|std\\(\\)", features[,2])
required_features.names = features[required_features,2]
required_features.names = gsub('-mean', 'Mean', required_features.names)
required_features.names = gsub('-std', 'Std', required_features.names)
required_features.names = gsub('[-()]', '', required_features.names)

# load the training data set
print ("Loading the training data set")
trainFeaturesData = read.table(paste(dataDir,"/train/X_train.txt", sep = ""), header = FALSE)
trainFeaturesData = trainFeaturesData [required_features]
trainActivitiesData = read.table(paste(dataDir,"/train/Y_train.txt", sep = ""), header = FALSE)
trainSubjectsData = read.table(paste(dataDir,"/train/subject_train.txt", sep = ""), header = FALSE)
trainData = cbind(trainSubjectsData, trainActivitiesData, trainFeaturesData)

# load the testing data set
print ("Loading the testing data set")
testFeaturesData = read.table(paste(dataDir,"/test/X_test.txt", sep = ""), header = FALSE)
testFeaturesData = testFeaturesData [required_features]
testActivitiesData = read.table(paste(dataDir,"/test/Y_test.txt", sep = ""), header = FALSE)
testSubjectsData = read.table(paste(dataDir,"/test/subject_test.txt", sep = ""), header = FALSE)
testData = cbind(testSubjectsData, testActivitiesData, testFeaturesData)

# merging the data and adding the labels
print ("Merging and labelling data set")
mergedData = rbind (trainData, testData)
colnames(mergedData) = c("Subject", "Activity", required_features.names)

# factorizing activity and subject variables into merged data
print ("Factorizing activity and subject variables")
mergedData$Activity = factor(mergedData$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
mergedData$Subject = as.factor(mergedData$Subject)

# labelling the data with descriptive variable names
print ("Labelling the data with descriptive variable names")
names(mergedData) = gsub("^f", "frequency", names(mergedData))
names(mergedData) = gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData) = gsub("^t", "time", names(mergedData))
names(mergedData) = gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData) = gsub("Mag", "Magnitude", names(mergedData))
names(mergedData) = gsub("BodyBody", "Body", names(mergedData))
write.table(mergedData, file = paste(dataDir,"/mergedData.txt", sep = ""), row.name = FALSE)

# creating independent and tidy data set and writing it to a file
print ("Creating independent and tidy data set and writing it to a file")
library(plyr)
tidyData = aggregate(. ~Subject + Activity, mergedData, mean)
tidyData = tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file = paste(dataDir,"/tidyData.txt", sep = ""), row.name = FALSE)