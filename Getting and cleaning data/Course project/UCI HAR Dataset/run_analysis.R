# Getting and cleaning data, course project script.
# Author: Jaakko Puurunen
# Assume current working directory contains (is parent for) test and train directories.

get_columns_to_read <- function() {
  # Read features.txt from current directory
  # Files has no header and is space separated, need only second column
  f <- read.csv('features.txt', header=FALSE, sep=' ', colClasses=c("NULL", "character"))
  
  # Create a vector of length features and initialize all as "NULL", then search all
  # "mean" and "std" occurrences from features (must transpose for grep to work).
  # 79 features match the pattern.
  
  cols <- rep("NULL", nrow(f))
  includeCols = grep("mean|std", t(f))
  #print(includeCols)
  cols[includeCols] = "numeric"
  cols
}


#a <- get_columns_to_read()
#print(a)

# Read train data. It contains 561 columns, each 16 characters long. Read only the columns
# that contain mean or std

p <- read.fwf('train/X_train.txt', rep(16, 561), colClasses = get_columns_to_read())