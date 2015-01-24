OUTCOME_COLUMNS <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

get_colums_to_read <- function(outcome_col_num) {
  
  read_cols <- c(rep("NULL", 46)) # don't read any columns by defauly
  read_cols[2] <- "character" # hospital name
  read_cols[7] <- "character" # state id
  read_cols[OUTCOME_COLUMNS[outcome_col_num]] <- "character" # selected outcome column as string
  read_cols
  
}

rankhospital <- function(state, outcome, num = "best") {
  
  # get outcome column and do error handling
  col_num <- which(names(OUTCOME_COLUMNS) == outcome)
  if (identical(col_num, integer(0))) { stop("invalid outcome") }
  
  read_cols <- get_colums_to_read(col_num)
  
  # read data (only the columns needed here)
  d <- read.csv("outcome-of-care-measures.csv", colClasses = read_cols)
  
  if (!state %in% d$State) { stop("invalid state") }
  
  d <- subset(d, d$State == state) # process only requested state
  
  d[,3] <- as.numeric(d[, 3]) # 
  d <- d[complete.cases(d),]
  d <- d[order(d[,3], decreasing=FALSE),]

  #print(head(d))
  
  # now we have the whole data sorted -> we can check the rank
  # validate first
  
  if (num == "best") { num <- 1 }
  if (num == "worst") { num <- nrow(d) }
  if (num > nrow(d)) { return(NA) }
  
  row <- d[num,] # select requested row
  rate <- row[[3]] # select rate based on row
  d <- d[which(d[3] == rate, TRUE)]
  d <- d[order(d, decreasing=FALSE)]
  d[1]
  #d
  
}