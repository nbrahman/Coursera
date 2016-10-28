pollutantmean <- function (directory, pollutant, id = 1:332)
{
  ## 'directory' is a charactor vector of length 1 indicating
  ## the location of CSV files
  
  ## 'pollutant' is a charactor vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the 
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## Note: Do not round the result
  
  ## validating the arguments
  if (directory != "")
  {
    if (pollutant != "")
    {
      if ((pollutant == "sulfate") | (pollutant == "nitrate"))
      {
        final_data <- data.frame()
        files_full <- list.files(directory, full.names=TRUE)
        for (i in 1:length(id))
        {
          final_data <- rbind (final_data, read.csv(files_full[id[i]]))
        }
        x <- mean(final_data[,pollutant],na.rm=TRUE)
        x
      }
      else
      {
        print ("Invalid pollutant 2!")
      }
    }
    else
    {
      print ("Invalid pollutant 1!")
    }
  }
  else
  {
    print ("Invalid directory!!!")
  }
}