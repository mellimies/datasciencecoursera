# Getting and cleaning data, course project script.
# Author: Jaakko Puurunen
# Assume current working directory contains (is parent for) test and train directories.

library(dplyr)

get_features <- function() {
  f <- read.csv('features.txt', header=FALSE, sep=' ', colClasses=c("NULL", "character"), stringsAsFactors=FALSE)
}

get_columns_to_read <- function() {

  # Read features.txt from current directory
  # Files has no header and is space separated, need only second column
  
  f <- get_features()
  
  includeCols = grep("mean[(]|std[(]", t(f))
  message(paste("Number of columns to read: ", length(includeCols)))
  #print(includeCols)
  includeCols
}

get_col_names <- function() {
  
  f <- get_features()

  # Create a vector of length features and initialize all as "NULL", then get all
  # "mean" and "std" occurrences from features and set them to numeric (must transpose for grep to work).
  
  cols <- rep("NULL", nrow(f))
  cols[get_columns_to_read()] = "numeric"
  cols  
  
}

# y_train.txt contains activity label for each measurement on one row
# subject_train.txt contains subject id (person identifier) for each measurement
# -> we can combine y_file and subject_file in a data frame with columns activity, subject
# (add column names later)

NUM_ROWS=-1 # for testing, set to -1 to read all rows

data.train <- read.table('train/y_train.txt', nrows=NUM_ROWS) # activity
data.train <- cbind(data.train, read.table('train/subject_train.txt', nrows=NUM_ROWS)) # subject
data.train <- cbind(data.train, read.table('train/X_train.txt', colClasses = get_col_names(), nrows=NUM_ROWS))

# interesting: read.tables is about 20-30 times faster than read.fwf.

#print(dim(data.train))
#print(summary(data.train))

# read test data

data.test <- read.table('test/y_test.txt', nrows=NUM_ROWS) # activity
data.test <- cbind(data.test, read.table('test/subject_test.txt', nrows=NUM_ROWS)) # subject
data.test <- cbind(data.test, read.table('test/X_test.txt', colClasses = get_col_names(), nrows=NUM_ROWS))

#print(dim(data.test))
#print(summary(data.test))

# row bind test data to train data  

tidy_data <- rbind(data.train, data.test)

# UGLY but cannot figure out a better way to fix column names now

n <- get_features()
n <- gsub("[(),-]", "", t(n)) # remove '(),-' characters
n <- gsub("BodyBody", "Body", n)
n <- t(n)

# Fix column names

names(tidy_data) <- c("activity", "subject", n[get_columns_to_read(),])

# Read activity data and substitute numeric values to labels

activity_names <- read.table('activity_labels.txt')
tidy_data <- mutate(tidy_data, activity = activity_names$V2[activity])

# Group by activity and subject, then summarise those groups with mean function

td <- arrange(tidy_data, activity, subject) %>%
group_by(activity, subject) %>% 
summarise_each(funs(mean))
#print(td)


write.table(td, "course_project_data.csv", row.names=FALSE)
