complete <- function (directory, id = 1:332)
{
  ## 'directory' is a charactor vector of length 1 indicating
  ## the location of CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number & 'nobs' is the
  ## number of complete cases
  
  ## validating the arguments
  if (directory != "")
  {
      final_data <- data.frame(id=integer(),
                               nobs=integer(),
                               stringsAsFactors = FALSE)
      files_full <- list.files(directory, full.names=TRUE)
      head(final_data)
      for (i in 1:length(id))
      {
        x <- read.csv(files_full[id[i]])
        t <- complete.cases(x)
        final_data <- rbind(final_data, data.frame(id = id[i], nobs = sum(t)))
      }
      print (final_data)
  }
  else
  {
    print ("Invalid directory!!!")
  }
}