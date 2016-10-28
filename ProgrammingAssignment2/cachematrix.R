## Put comments here that give an overall description of what your
## functions do

## makeCacheMatrix will accept x as input, will 
## 1. validate if x is a matrix else will return appropriate error message
## 2. validate if x is containing all numeric elements else will return appropriate error message
## 3. if both the above validations are ok then will process the matrix depending upon the functionality

makeCacheMatrix <- function(x = matrix())
{
    ## Check if the input matrix 'x' a numeric matrix
    if (sum (apply (x, 2, is.numeric))!=0)
    {
        ## process input matrix 'x' depending upon the functionality
        m <- NULL
        set <- function(y)
        {
            x <<- y
            m <<- NULL
        }
        
        get <- function()
        {
            x
        }
    
        setInverse <- function(inverse)
        {
            m <<- inverse
        }
    
        getInverse <- function()
        {
            m
        }
        
        list(set = set, get = get,
            setInverse = setInverse,
            getInverse = getInverse)
    }
    else
    {
        ## return the error message
        message ("The matrix input is either partly or completely not a numeric matrix")
    }
}


## cacheSolve will accept x as input, will 
## 1. validate if inverse matrix for x can be computed or not
##      If not then will return appropriate error message
## 2. if the above validation is ok
##      then will calculate Inverse of the supplied matrix 
##      using solve () function and will store it in cache by calling appropriate function

cacheSolve <- function(x, ...)
{
    ## Check if inverse matrix can be calculated for input matrix 'x'
    data <- x$get()
    if (class(try(solve(data),silent=TRUE))=="matrix")
    {
        ## compute & return inverse matrix for input matrix 'x'
        m <- x$getInverse()
        if(!is.null(m))
        {
            message("getting cached data")
            return(m)
        }
        m <- solve(data, ...)
        x$setInverse(m)
        m
    }
    else
    {
        ## return the error message
        message ("Inverse matrix cannot be computed for input matrix")
    }
}
