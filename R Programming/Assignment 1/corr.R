source('complete.R')

get_data <- function(directory, treshold = 0) {
  csv_data <- list()
  valid_count <- 0
  for (csv_file in list.files(directory)) {
    csv_file <- paste(directory, "/", csv_file, sep="")
    t <- read.csv(csv_file)
    if (count_complete(t) > treshold) {
      valid_count <- valid_count + 1
      csv_data[[valid_count]] <- list(t$sulfate, t$nitrate)
    }
 }
  csv_data
}

calc_cor <- function(data) {
  num_data <- length(data)
  rv <- numeric()
  
  if (num_data == 0) return(rv)
  i_loop <- 1
  for (i in 1:num_data) {
    d <- data[[i]]
    d_s <- d[[1]]
    d_n <- d[[2]]
    c  <- cor(d_s, d_n, use="pairwise.complete.obs")
    if (!is.na(c)) {
      rv[i_loop] <- c
      i_loop <- i_loop + 1      
    }
  }
  rv
}

corr <- function(directory, treshold = 0) {
  print("Getting data")
  csv_data <- get_data(directory, treshold)
  print(length(csv_data))
  print("Calculating correlations")
  cor_data <- calc_cor(csv_data)
  cor_data
}

