# Getting and Cleaning Data - Course Project

This repository contains the code and documentation for course project for the Getting and Cleaning Data Coursera course.
The dataset being used is: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files
 * `codebook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data
 * `run_analysis.R` contains the code to perform the required analysis mentioned in Project Statement
 * The outputs, merged dataset and tidy dataset are stored in "mergedData.txt" and "tidyData.txt" file respectively

## Brief Working
The R script, `run_analysis.R`, does the following:  

 * Download the dataset (if it does not exists already) in the specified directory
 * Load the activity and feature data
 * Loads both the training and test datasets, keeping only the required columns
 * Loads the activity and subject data for each dataset, and merges those columns with the dataset
 * Merges the two datasets
 * Converts the `activity` and `subject` columns into factors
 * Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair
 * Saves / writes the merged and tidy datasets into files