# This is the readme file for Coursera Getting And Cleaning Data class course project assignment by Jaakko Puurunen.

## Date: Feb-22, 2015

## Course project description:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The course discussion board had [an excellent thread] (https://class.coursera.org/getdata-011/forum/thread?thread_id=69) which was used as guidance along other discussion threads.

## My implementation

My own script does not follow steps given exactly as I decided to read only the columns needed for the tidy data set. Script logic is:

1. Read activity data  into a data frame (1 column)
2. Read subject data from train directory and column bind that with above step so we have a data frame with two columns (activity, subject)
3. Read measurement data from train directory and column bind that with activity and subject data (logic how to read measurement data is explained later)
4. Repeat same for test data and row bind that with train data which produces the whole dataset.
5. Set names for columns at this point. Names are taken from features.txt and modified to work with R by removing special characters "(),".
6. Read activity data into a data frame which has numbers 1-6 in column 1 and labels for those in column 2.
7. Mutate activity column in data set by replacing numeric value with label.
8. Group data set by activity and subject.
9. Summarise each group with mean function which produces the final wide tidy dataset.
10. Write tidy data into a file.

Note that the script assumes that working directory contains test and train subdirectories and features as acitivity files are at the same level.

The logic for reading measurement data is to determine which columns have a "mean()" or "std()" measurement and then only read those columns with read.table function. That is achieved by first creating a vector of 561 elements set to "NULL" initially and then overwriting the indices with "numeric" for those columns having mean or std data. This vector is then used as the colClasses parameter for read.table function and that returns only columns with values other than "NULL" in colClasses value.