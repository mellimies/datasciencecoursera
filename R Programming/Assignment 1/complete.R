source('files.R')

count_complete <- function(data_frame) {
  sum((!is.na(data_frame$sulfate) & !is.na(data_frame$nitrate)))
}

complete <- function(directory, id = 1:332) {
  
  csv_files <- get_csv_files(directory, id)
  num_files <- length(csv_files)

  v_id = numeric(num_files)
  v_nobs = numeric(num_files)
  
  i_file <- 1
  for(i in id) {
    print(i)
    t <- read.csv(csv_files[i_file])
    v_id[i_file] <- i
    v_nobs[i_file] <-  count_complete(t)
    i_file <- i_file + 1
  }
  t <- data.frame(v_id, v_nobs)
  names(t) <- c("id", "nobs")
  t
}