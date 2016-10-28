##Course 2 Week 2 - Air Pollution Study
In this project, we were needed to write three functions that are meant to interact with dataset that accompanies this project.

The zip file contained 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:

1. **Date:** the date of the observation in YYYY-MM-DD format (year-month-day)
2. **sulfate:** the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
3. **nitrate:** the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

**In each file, there were many days where either sulfate or nitrate (or both) are missing (coded as NA). This is common with air pollution monitoring data in the United States.**

###Part 1: pollutantmean

'**pollutantmean**' is a function that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. It takes three arguments:

- '**directory**'
- '**pollutant**'
- '**id**'

Given a vector monitor ID numbers, it reads that monitors' particulate matter data from the directory specified in the '**directory**' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.

###Part 2: complete

'**complete**' is a function that reads a directory full of files and reports the number of completely observed cases in each data file. It takes two arguments:

- '**directory**'
- '**id**'

Given a vector monitor ID numbers, it reads that monitors' particulate matter data from the directory specified in the '**directory**' argument and returns a data frame where the first column is the name of the file and the second column is the number of complete cases.

###Part 3: corr

'**corr**' is a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. It returns a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function returns a numeric vector of length 0. This function uses the '**cor**' function in R which calculates the correlation between two vectors.

The R source code includes the appropriate code to validate the arguments passed to all the functions.
