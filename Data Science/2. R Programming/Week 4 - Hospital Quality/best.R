best <- function(state, outcome)
{
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    ## read the CSV & assign the NA values appropriately
    oocm<-read.csv("outcome-of-care-measures.csv", colClasses = "character",na.strings="Not Available")

    ## Not sure about exact way to do the state validation.
    ## Hence comparing the state argument value with the already available state values
    if (sum(levels(factor(oocm$State))==state)!=0)
    {
        ## validation for outcome
        if ((outcome=="heart attack") | (outcome=="heart failure") | (outcome=="pneumonia"))
        {
            ## assign the desired column number
            if (outcome=="heart attack")
            {
                colNum = 11
            }
            else if (outcome=="heart failure")
            {
                colNum = 17
            }
            else if (outcome=="pneumonia")
            {
                colNum = 23
            }
            
            ## filter the rows having missing value
            listHosps <- oocm[is.na(oocm[[names(oocm)[colNum]]])==FALSE,]

            ## filter the rows for the individual state argument
            listHosps <- listHosps[listHosps$State==state,]

            ## convert the output column to numeric for sorting purposes
            listHosps[,colNum] <- as.numeric(listHosps[,colNum])

            ## print or return the final output
            listHosps[order(listHosps[colNum],listHosps[2],decreasing = FALSE),][1,2]
        }
        else
        {
            ## Invalid outcome error message
            stop ("invalid outcome")
        }
    }
    else
    {
        ## Invalid state error message
        stop ("invalid state")
    }
}