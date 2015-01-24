OUTCOME_COLUMNS <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

get_colums_to_read <- function(outcome_col_num) {

  read_cols <- c(rep("NULL", 46)) # don't read any columns by defauly
  read_cols[2] <- "character" # hospital name
  read_cols[7] <- "character" # state id
  read_cols[OUTCOME_COLUMNS[outcome_col_num]] <- "character" # selected outcome column as string
  read_cols
  
}

best <- function(state, outcome) {
  
  # get outcome column and do error handling
  col_num <- which(names(OUTCOME_COLUMNS) == outcome)
  if (identical(col_num, integer(0))) { stop("invalid outcome") }
  
  read_cols <- get_colums_to_read(col_num)
  
  # read data (only the columns needed here)
  d <- read.csv("outcome-of-care-measures.csv", colClasses = read_cols)
  
  if (!state %in% d$State) { stop("invalid state") }
  
  d[,3] <- as.numeric(d[, 3]) # all good now, convert string data to numeric
  
  d <- subset(d, d$State == state)
  max_outcome = min(d[,3], na.rm = TRUE)
  d <- d[which(d[3] == max_outcome, TRUE)]
  d <- d[order(d)]
  d
  
}