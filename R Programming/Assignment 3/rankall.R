library(data.table)

OUTCOME_COLUMNS <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

get_colums_to_read <- function(outcome_col_num) {
  read_cols <- c(rep("NULL", 46)) # don't read any columns by defauly
  read_cols[2] <- "character" # hospital name
  read_cols[7] <- "character" # state id
  read_cols[OUTCOME_COLUMNS[outcome_col_num]] <- "numeric" # double for data.table
  read_cols
}

rankall <- function(outcome, num = "best") {
  col_num <- which(names(OUTCOME_COLUMNS) == outcome)
  if (identical(col_num, integer(0))) { stop("invalid outcome") }
  
  row_position <- ifelse(is.numeric(num), num, 1) 

  # use scoping rules to reduce arguments
  get_hospital_by_rank <- function(rate_data) {
    hotel_rate <- rate_data[row_position, rate]
    x <- rate_data[rate == hotel_rate] # all hotels having this rate
    setkey(x, hospital) # sort
    x[1,hospital] # return first hospital
  }
  
  read_cols <- get_colums_to_read(col_num)

  data <- na.omit(fread("outcome-of-care-measures.csv", colClasses = read_cols, na.strings = "Not Available"))
  setnames(data, c("hospital", "state", "rate"))

  data$rate <- as.numeric(data$rate) # there has to be a way to read numeric data directly
  ifelse(num == "worst", setorder(data, state, -rate), setorder(data, state, rate) ) # ugly
  
  x <- split(data, data$state)
  x <- lapply(x, function(x) { get_hospital_by_rank(x) } )
  data.frame(unlist(x))
}

