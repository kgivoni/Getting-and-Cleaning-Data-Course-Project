
## --------------------------------------------
## Step 0: download the zip file and unzip it
## --------------------------------------------
#remote_zip_url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#local_zip_file <- download.file(remote_zip_url, "Downloads/proj3.zip")

#unzip ("Downloads/proj3.zip", exdir = "Downloads/proj3")

#unlink(remote_zip_url)

#setwd("/Users/kinneretgivoni/Downloads/proj3/UCI HAR Dataset")

## --------------
## read the data
## --------------
## general
activity_labels1 <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/activity_labels.txt", header = FALSE)
features <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/features.txt", header = FALSE)


## ----------------
## read train data
## ----------------

subject_train <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/train/X_train.txt", header=FALSE)
y_train <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/train/y_train.txt", header=FALSE)

## ----------------
## read test data
## ----------------

subject_test <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/test/X_test.txt", header=FALSE)
y_test <- read.table("/Users/kinneretgivoni/Downloads/proj3/UCI_HAR_Dataset/test/y_test.txt", header=FALSE)

## ------------------------------------------------------------------------
## Step 1: Merges the training and the test sets to create one data set.
## ------------------------------------------------------------------------

colnames(subject_train) <- "subjectId";
colnames(subject_test) <- "subjectId";
colnames(X_train) <- features[,2]; 
colnames(X_test) <- features[,2]; 
colnames(y_train) <- "activityId";
colnames(y_test) <- "activityId";

all_train_data <- cbind(subject_train, y_train, X_train)
all_test_data <- cbind(subject_test, y_test, X_test)

merge_all <- rbind(all_train_data, all_test_data)

## -----------------------------------------------------------------------------------------
## Step 2:
## Extracts only the measurements on the mean and standard deviation for each measurement.
## -----------------------------------------------------------------------------------------
listValidColNames <- (grepl("subjectId", colnames_data) | grepl("activityId",colnames_data) | grepl("-mean..",colnames_data) | grepl("-std..",colnames_data))
clean_data <- merge_all[listValidColNames==TRUE]


## -----------------------------------------------------------------------------------------
## Step 3:
## Uses descriptive activity names to name the activities in the data set
## -----------------------------------------------------------------------------------------
colnames(activity_labels) <- c("activityId", "description")
explained_data <- merge(clean_data, activity_labels, by="activityId", all.x=TRUE)


## -----------------------------------------------------------------------------------------
## Step 4:
## Appropriately labels the data set with descriptive variable names.
## -----------------------------------------------------------------------------------------
col_names <- colnames(explained_data)
col_names1 <- gsub('\\(\\)',"",col_names)
col_names2 <- gsub("-mean","Mean",col_names1)
col_names3 <- gsub("-std","Std",col_names2)
colnames(explained_data) <- col_names3

## -----------------------------------------------------------------------------------------
## Step 5: 
## From the data set in step 4, 
## creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
## -----------------------------------------------------------------------------------------

# remove desciprion field 
narrow_data <- select(explained_data, -description)
library(plyr)

# summarize the data
sum_data = ddply(narrow_data, c("subjectId", "activityId"), numcolwise(mean))

x <- 5
y < 6

# ignore ....mean_data <- dcast(narrow_data, activityId ~ subjectId, mean)
#  ignore ....group_data <- group_by(narrow_data, activityId, subjectId)