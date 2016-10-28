corr <- function (directory, threshold = 0)
{
  ## 'directory' is a charactor vector of length 1 indicating
  ## the location of CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations(on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0.
  
  ## Return a numeric vector of correlations
  ## Note: Do not round the result
  
  ## validating the arguments
  if (directory != "")
  {
    final_data <- numeric()
    files_full <- list.files(directory, full.names=TRUE)
    x <- 1
    for (i in 1:length(files_full))
    {
      fc <- read.csv(files_full[i])
      if (sum(complete.cases(fc)) > threshold)
      {
        final_data [x] <- cor (fc$sulfate,fc$nitrate, use="complete.obs")
        x <- x + 1
      }
    }
  }
  else
  {
    print ("Invalid directory!!!")
  }
  final_data
}