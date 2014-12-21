## This script performs the following actions
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

datasetDir <- "UCI HAR Dataset"
training_set <- "train/X_train.txt"
training_labels <- "train/y_train.txt"
test_set <- "test/X_test.txt"
test_labels <- "test/y_test.txt"

if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)


## download data set files
if (!file.exists("Dataset.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip", method="curl")
}
unzip("Dataset.zip", list = FALSE)

## activity labels
activity_labels <- read.csv(paste(datasetDir, "activity_labels.txt", sep="/"), sep="", col.names = c("val","name"), header=FALSE)

## Get a vector of all column names
columnNames <- make.names(read.csv(paste(datasetDir, "features.txt", sep="/"), sep="", col.names=c("val","name"), stringsAsFactors=FALSE, header=FALSE)[,2],
                          unique = TRUE)

## logical/Boolean vector of columns that match either 'mean' or 'std'
selectedColumns <- grepl("mean|std", columnNames)

## Process test and training data

for (myset in c("test","train")) {
    message(paste("Processing", myset, "data"))
    mydir <- paste(datasetDir, myset, sep="/")
    ## Get a vector of subjects, to splice in with the raw data
    subject <- scan(paste(mydir, paste("subject_", myset, ".txt", sep=""), sep="/"))

    ## Get a vector of activities
    activity <- scan(paste(mydir,
                             paste("y_", myset, ".txt", sep=""),
                             sep="/")
                       )
    ## let's associate the subjects with the data
    ## subject id is the only field in subject_{train,test}.txt
    measurements <- read.csv(paste(mydir,
                                   paste("X_", myset, ".txt", sep=""),
                                   sep="/"),
                             sep="", ## whitespace is separator
                             strip.white = TRUE, ## strip meaningless whitespace from start of each record
                             col.names = make.names(columnNames, unique = TRUE), ## deal with dup names
                             header = FALSE,
                             stringsAsFactors = FALSE)

    ## Extract only the fields we need (mean and std deviation)
    measurements <- measurements[, selectedColumns]

    ## splice in subject, activity ID and activity label
    if (myset == "test")
        test_measurements <- cbind(as.data.frame(subject), as.data.frame(activity), measurements)
    else
        train_measurements <- cbind(as.data.frame(subject), as.data.frame(activity), measurements)
}

## Merge test and training data sets
message("Merging test and training data.")
alldata <- rbind(test_measurements, train_measurements)

## aggregate the results to create our target data set
alldata$subject <- as.factor(alldata$subject)
alldata$activity <- as.factor(alldata$activity)
options(warn=-1)   ## subject and activity columns will generate warnings
tidydata <- aggregate(alldata, by=list(activity = alldata$activity, subject=alldata$subject), mean)
options(warn=0)   ## turn warnings back on


## delete the mean of subject and activity, which is meaningless
tidydata[,3] = NULL
tidydata[,3] = NULL

## Write our tidy table
message("Writing tidy data set as 'tidydata.txt'")
write.table(tidydata, "tidydata.txt", sep="\t", row.names=FALSE, quote=FALSE)

## Note: load in and view the resulting data set with
##   tidyset <- read.table("tidydata.txt")
##   View(tidyset)
