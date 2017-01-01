# Coursera - Data Science Specialization course designed and conducted by John Hopkins University
This repository contains the Assignments / Projects done for Data Science specialization course by Coursera designed and conducted by John Hopkins University).

##Course 1
This repository contains the basic stuff for tools required for Data Science (like creating Markdown files, confirming R & R Studio installations, working on GitHub, etc).

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

##Course 2 Week 3 - Lexical Scoping

In this project, we were needed to write an R function that is able to cache potentially time-consuming computations. For example, taking the mean of a numeric vector is typically a fast operation. However, for a very long vector, it may take too long to compute the mean, especially if it has to be computed repeatedly (e.g. in a loop). If the contents of a vector are not changing, it may make sense to cache the value of the mean so that when we need it again, it can be looked up in the cache rather than recomputed. In this Programming Assignment will take advantage of the scoping rules of the R language and how they can be manipulated to preserve state inside of an R object.

###Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than compute it repeatedly.

Following two functions were written to complete the project requirements

**1. makeCacheMatrix:** This function creates a special "matrix" object that can cache its inverse.

**2. cacheSolve:** This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve will retrieve the inverse from the cache.

Computing the inverse of a square matrix is done with the '**solve**' function in R.

The R source code includes the appropriate code to validate the arguments passed to all the functions along with the validation if the passed matrix is actually reversible.

##Course 2 Week 4 - Hospital Quality

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov) run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining whether hospitals should be fined for not providing high quality care to patients.

The Hospital Compare web site contains a lot of data and we will only look at a small subset for this assignment. The zip file for this assignment contains three files

- **outcome-of-care-measures.csv:** Contains information about 30-day mortality and readmission rates for heart attacks, heart failure, and pneumonia for over 4,000 hospitals
- **hospital-data.csv:** Contains information about each hospital
- **Hospital_Revised_Flatfiles.pdf:** Descriptions of the variables in each file (i.e the code book)

###Part 2 Finding the best hospital in a state

'**best**' is a function that takes two arguments

1. the 2-character abbreviated name of a state and
2. an outcome name

The function reads the '**outcome-of-care-measures.csv**' file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in that state.

The hospital name is the name provided in the '**Hospital.Name**' variable. The outcomes can be one of '**heart attack**', '**heart failure**', or '**pneumonia**'. 

Hospitals that do not have data on a particular outcome will be excluded from the set of hospitals when deciding the rankings. 

If there is a tie for the best hospital for a given outcome, then the hospital names will be sorted in alphabetical order and the first hospital in that set is chosen (i.e. if hospitals 'b', 'c', and 'f' are tied for best, then hospital 'b' will be returned).

The function checks the validity of its arguments

- If an invalid state value is passed, the function throws an error via the stop function with the exact message '**invalid state**'
- If an invalid outcome value is passed, the function throws an error via the stop function with the exact message '**invalid outcome**'

###Part 3 Ranking hospitals by outcome in a state

'**rankhospital**' function takes three arguments

1. the 2-character abbreviated name of a state (state)
2. an outcome (outcome) and
3. the ranking of a hospital in that state for that outcome (num)

The function reads the '**outcome-of-care-measures.csv**' file and returns a character vector with the name of the hospital that has the ranking specified by the '**num**' argument.

For example, the call rankhospital("MD", "heart failure", 5) returns a character vector containing the name of the hospital with the 5th lowest 30-day death rate for heart failure.

The '**num**' argument can take values 'best', 'worst', or an integer indicating the ranking (smaller numbers are better). 

If the number given by '**num**' is larger than the number of hospitals in that state, then the function returns NA. 

Hospitals that do not have data on a particular outcome are excluded from the set of hospitals when deciding the rankings. 

It may occur that multiple hospitals have the same 30-day mortality rate for a given cause of death. In those cases ties are broken by using the hospital name. The '**order**' function is used to sort multiple vectors in this manner (i.e. where one vector is used to break ties in another vector).

The function checks the validity of its arguments

- If an invalid state value is passed, the function throws an error via the stop function with the exact message '**invalid state**'
- If an invalid outcome value is passed, the function throws an error via the stop function with the exact message '**invalid outcome**'
- The num variable can take values \best", \worst", or an integer indicating the ranking (smaller numbers are better).

###Part 4 Ranking hospitals in all states

'**rankall**' function takes two arguments

1. an outcome name (outcome) and 
2. a hospital ranking (num)

The function reads the '**outcome-of-care-measures.csv**' file and returns a 2-column data frame containing the hospital in each state that has the ranking specified in '**num**'.

For example the function call rankall("heart attack", "best") returns a data frame containing the names of the hospitals that are the best in their respective states for 30-day heart attack death rates.

The function returns a value for every state (some may be NA). The first column in the data frame is named hospital, which contains the hospital name, and the second column is named state, which contains the 2-character abbreviation for the state name.

Hospitals that do not have data on a particular outcome are excluded from the set of hospitals when deciding the rankings.

The ties are handled in the same way that the '**rankhospital**' function handles ties.

The function checks the validity of its arguments.

- If an invalid outcome value is passed, the function throws an error via the stop function with the exact message '**invalid outcome**'
- The num variable can take values \best", \worst", or an integer indicating the ranking (smaller numbers are better).

If the number given by '**num**' is larger than the number of hospitals in that state, then the function returns NA.
