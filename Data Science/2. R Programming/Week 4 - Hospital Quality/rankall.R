rankall <- function(outcome, num = "best")
{
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name

    ## read the CSV & assign the NA values appropriately
    oocm<-read.csv("outcome-of-care-measures.csv", colClasses = "character",na.strings="Not Available")
    

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

        ## initialize state vector
        state <- levels(factor(oocm[,7]))

        ## initialize hospital list vector
        hospital <- vector(mode="character")

        ## looping to find the nth best hospital in each state
        for (i in seq(state))
        {
            ## call to rankhospital to find the nth best hospital in individual frame
            hospital[i] <- rankhospital(state[i], outcome, num)
        }

        ## converting the final output into data frame with desired format
        data.frame(hospital, state)
    }
    else
    {
        ## Invalid outcome error message
        stop ("invalid outcome")
    }
}