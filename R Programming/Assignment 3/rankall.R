OUTCOME_COLUMNS <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

get_colums_to_read <- function(outcome_col_num) {
  
  read_cols <- c(rep("NULL", 46)) # don't read any columns by defauly
  read_cols[2] <- "character" # hospital name
  read_cols[7] <- "character" # state id
  read_cols[OUTCOME_COLUMNS[outcome_col_num]] <- "character" # selected outcome column as string
  read_cols
  
}

rankall <- function(outcome, num = "best") {
  
  org_num <- num
  # get outcome column and do error handling
  col_num <- which(names(OUTCOME_COLUMNS) == outcome)
  if (identical(col_num, integer(0))) { stop("invalid outcome") }
  
  read_cols <- get_colums_to_read(col_num)

  d <- read.csv("outcome-of-care-measures.csv", colClasses = read_cols)
  
  if (num == "best") { num <- 1 }
  
  d[,3] <- as.numeric(d[, 3])
  l <- split(d, d$State) # 

  v1 <- character(0)
  v2 <- character(0)
  
  num_states = length(l)
  for (i in 1:num_states)
  {
    data <- l[[i]]
    state <- data[1,2]
    print(state)
    v2[i] <- state

   #if (state == "NV") print(data)
    data <- data[complete.cases(data),] # filter out NAs
   
   if (org_num == "worst") { num <- nrow(data) }
   if (num > nrow(data)) { v1[i] <- NA }

   #print(paste("num", num))
   #print(paste("nrow", nrow(data)))
   
    data <- data[order(data[,3]),] # sort
    #if (state == "NV") print(data)
    
    rate <- data[num,3]
    
    if (is.na(rate)) {
      v1[i] <- NA
    }
    else
    {
      data <- subset(data, data[3] == rate)
      data <- data[order(data[,1]),] # sort
      
      #print(data)
      v1[i] <- data[1,1]
    } 
  }
  rv <- data.frame(v1, v2)
  colnames(rv) <- c("hospital", "state")
  rownames(rv) <-  rv$state
  rv
  
}