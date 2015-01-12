src_dir <- '/Users/jaska/Desktop/Code/Coursera/R Programming/Assignment 1'
setwd(src_dir)

get_csv_files <- function(directory, id) {
  csv_files = character(max(id))
  for (i in id) {
    csv_files[i] <- paste(src_dir, '/', directory, '/', sprintf("%03d", i), '.csv', sep='')
  }
  csv_files
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  pol <- if (pollutant == "sulfate") "sulfate" else "nitrate"
  data_dir <- paste(src_dir, '/', directory, sep = '')
  csv_files <- get_csv_files(directory, id)
  
  mean_data = numeric()
  
  for(i in id) {
    t <- read.csv(csv_files[i])
    mean_data <- c(mean_data, t[, pol])
  }
  mean(mean_data, na.rm = TRUE)
}