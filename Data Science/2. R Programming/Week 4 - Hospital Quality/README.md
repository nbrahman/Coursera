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
