source('files.R')

pollutantmean <- function(directory, pollutant, id = 1:332) {
  pol <- if (pollutant == "sulfate") "sulfate" else "nitrate"
  #data_dir <- paste(src_dir, '/', directory, sep = '')
  csv_files <- get_csv_files(directory, id)
  
  mean_data = numeric()
  i_file <- 1
  for(i in id) {
    t <- read.csv(csv_files[i_file])
    mean_data <- c(mean_data, t[, pol])
    i_file <- i_file + 1
  }
  mean(mean_data, na.rm = TRUE)
}