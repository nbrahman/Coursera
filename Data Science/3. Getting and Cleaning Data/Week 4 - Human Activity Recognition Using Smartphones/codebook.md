Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
* The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The run_analysis.R script performs the following steps to clean the data:  

 1. Read  ".\C3_W4_A1\UCI HAR Dataset\activity_lables.txt" and ".\C3_W4_A1\UCI HAR Dataset\features.txt" and store the data into ***activity_lables*** and ***features*** variables respectively
 2. Extract the list of features or columns required in final data
 3. Transform the column names' list extracted in step 2
 4. Read "X_train.txt", "Y_train.txt" and "subject_train.txt" from the ".\C3_W4_A1\UCI HAR Dataset\train" folder and store them in ***trainFeaturesData***, ***trainActivitiesData*** and ***trainSubjectsData*** variables respectively
 5. Remove the unwanted columns, keep only the columns extracted in step 2 from ***trainFeaturesData*** and store the modified data into the ***trainFeaturesData*** again
 6. Combine the ***trainFeaturesData***, ***trainActivitiesData*** and ***trainSubjectsData*** variables' data based on columns and store the modified data into *trainData* variable
 7. Read "X_test.txt", "Y_test.txt" and "subject_test.txt" from the ".\C3_W4_A1\UCI HAR Dataset\test" folder and store them in ***testFeaturesData***, ***testActivitiesData*** and ***testSubjectsData*** variables respectively
 8. Remove the unwanted columns, keep only the columns extracted in step 2 from ***testFeaturesData*** and store the modified data into the ***testFeaturesData*** again
 9. Combine the ***testFeaturesData***, ***testActivitiesData*** and ***testSubjectsData*** variables' data based on columns and store the modified data into ***testData*** variable
 10. Combine the ***trainData*** and ***testData*** variables' data based on rows and store the modified data into ***mergedData*** variable
 11. Update the column names for ***mergedData*** variable
 12. Factorize *subject* and *activity* columns from ***mergedData*** variable
 13. Update the ***mergedData*** column names with descriptive variable names
 11. Write the ***mergedData*** out to "mergedData.txt" file in specified directory
 12. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject
 13. Write the ***tidyData*** out to "tidyData.txt" file in specified directory.

# Variables

* `trainFeaturesData`, `trainActivitiesData`, `trainSubjectsData`, `testFeaturesData`, `testActivitiesData`, `testSubjectsData` contain the data from the downloaded files.
* `trainData` and `testData` contains the column level merged data for all the training and testing data variables (mentioned in above step) respectively for further analysis.
* `activity_labels` and `features` contains the data for activities and features
* `required_features.names` contains the finalized column names of all the required data columns
* `mergedData` contains the merged data for training and testing datasets
* `tidyData` contains the relevant averages which will be later stored in a `.txt` file. `aggregate()` and `order()` functions are used to compute the averages and to sort the final data respectively

#Result Summary

## Identifiers

* `subject` - The ID of the test subject
* `activity` - The type of activity performed when the corresponding measurements were taken

## Measurements

* `Subject`
* `Activity`
* `timeBodyAccelerometerMeanX`
* `timeBodyAccelerometerMeanY`
* `timeBodyAccelerometerMeanZ`
* `timeBodyAccelerometerStdX`
* `timeBodyAccelerometerStdY`
* `timeBodyAccelerometerStdZ`
* `timeGravityAccelerometerMeanX`
* `timeGravityAccelerometerMeanY`
* `timeGravityAccelerometerMeanZ`
* `timeGravityAccelerometerStdX`
* `timeGravityAccelerometerStdY`
* `timeGravityAccelerometerStdZ`
* `timeBodyAccelerometerJerkMeanX`
* `timeBodyAccelerometerJerkMeanY`
* `timeBodyAccelerometerJerkMeanZ`
* `timeBodyAccelerometerJerkStdX`
* `timeBodyAccelerometerJerkStdY`
* `timeBodyAccelerometerJerkStdZ`
* `timeBodyGyroscopeMeanX`
* `timeBodyGyroscopeMeanY`
* `timeBodyGyroscopeMeanZ`
* `timeBodyGyroscopeStdX`
* `timeBodyGyroscopeStdY`
* `timeBodyGyroscopeStdZ`
* `timeBodyGyroscopeJerkMeanX`
* `timeBodyGyroscopeJerkMeanY`
* `timeBodyGyroscopeJerkMeanZ`
* `timeBodyGyroscopeJerkStdX`
* `timeBodyGyroscopeJerkStdY`
* `timeBodyGyroscopeJerkStdZ`
* `timeBodyAccelerometerMagnitudeMean`
* `timeBodyAccelerometerMagnitudeStd`
* `timeGravityAccelerometerMagnitudeMean`
* `timeGravityAccelerometerMagnitudeStd`
* `timeBodyAccelerometerJerkMagnitudeMean`
* `timeBodyAccelerometerJerkMagnitudeStd`
* `timeBodyGyroscopeMagnitudeMean`
* `timeBodyGyroscopeMagnitudeStd`
* `timeBodyGyroscopeJerkMagnitudeMean`
* `timeBodyGyroscopeJerkMagnitudeStd`
* `frequencyBodyAccelerometerMeanX`
* `frequencyBodyAccelerometerMeanY`
* `frequencyBodyAccelerometerMeanZ`
* `frequencyBodyAccelerometerStdX`
* `frequencyBodyAccelerometerStdY`
* `frequencyBodyAccelerometerStdZ`
* `frequencyBodyAccelerometerJerkMeanX`
* `frequencyBodyAccelerometerJerkMeanY`
* `frequencyBodyAccelerometerJerkMeanZ`
* `frequencyBodyAccelerometerJerkStdX`
* `frequencyBodyAccelerometerJerkStdY`
* `frequencyBodyAccelerometerJerkStdZ`
* `frequencyBodyGyroscopeMeanX`
* `frequencyBodyGyroscopeMeanY`
* `frequencyBodyGyroscopeMeanZ`
* `frequencyBodyGyroscopeStdX`
* `frequencyBodyGyroscopeStdY`
* `frequencyBodyGyroscopeStdZ`
* `frequencyBodyAccelerometerMagnitudeMean`
* `frequencyBodyAccelerometerMagnitudeStd`
* `frequencyBodyAccelerometerJerkMagnitudeMean`
* `frequencyBodyAccelerometerJerkMagnitudeStd`
* `frequencyBodyGyroscopeMagnitudeMean`
* `frequencyBodyGyroscopeMagnitudeStd`
* `frequencyBodyGyroscopeJerkMagnitudeMean`
* `frequencyBodyGyroscopeJerkMagnitudeStd`

## Activity Labels

* `WALKING` (value `1`)
* `WALKING_UPSTAIRS` (value `2`)
* `WALKING_DOWNSTAIRS` (value `3`)
* `SITTING` (value `4`)
* `STANDING` (value `5`)
* `LAYING` (value `6`)