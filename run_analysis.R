## The purpose of this script is to take in acceleormeter data from
## this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and return a tidy data set to be used in further calcuations, as well as
## a summary of that data set showing the average of each variable for
## each subject for each activity.

## To run this script it is assumed that you have downloaded the above dataset,
## extracted it, and set your working directory so that the folder containing
## the data "UCI HAR Dataset" is in your working directory.  You will also need
## to install the dplyr package.

library(dplyr) ## Loads the dplyr package for later use

## Create a table of all feature data from the test and train datasets, and assign proper column names

xtr <- read.table("UCI HAR Dataset/train/X_train.txt") ## Load train feature data
xte <- read.table("UCI HAR Dataset/test/X_test.txt") ## Load test feature data
x <- rbind(xtr, xte) ## Combine test and train feature data by rows
featurenames <- read.table("UCI HAR Dataset/features.txt") ## load the names of each feature, to be used as variable names
colnames(x) <- featurenames[,2] ## Assigne the feature names as variable names
rm(xtr) ## Clean unnecessary data from the workspace
rm(xte) ## Clean unnecessary data from the workspace
rm(featurenames) ## Clean unnecessary data from the workspace

## Creates a table of all activity data from the test and train datasets, and lablel the variable appropriately

ytr <- read.table("UCI HAR Dataset/train/y_train.txt") ## Load train activity data
yte <- read.table("UCI HAR Dataset/test/y_test.txt") ## Load test activity data
y <- rbind(ytr, yte) ## combine train and test activity data by rows
colnames(y) <- c("Activity") ## Assign a descriptive variable name
rm(ytr) ## Clean unnecessary data from the workspace
rm(yte) ## Clean unnecessary data from the workspace

## Create a  table of all subject data from both test and train datasets, and label the variable appropriately

subjtr <- read.table("UCI HAR Dataset/train/subject_train.txt") ## Load train subject data
subjte <- read.table("UCI HAR Dataset/test/subject_test.txt") ## Load test subject data
subj <- rbind(subjtr, subjte) ## combine train and test data by rows
colnames(subj) <- c("Subject") ## Assign a descriptive variable name
rm(subjtr) ## Clean unnecessary data from the workspace
rm(subjte) ## Clean unnecessary data from the workspace

## Extract only the columns containing mean and standard deviation features from the feature data

indicies <- grep("-mean\\(\\)|-std\\(\\)", colnames(x)) ## Create a list of column indicies using a regular expression
x <- x[,indicies] ## Keep only the desired variables
rm(indicies) ## Clean unnecessary data from the workspace

## Create one data frame containing subject, activity and desired feature data

acceldata <- cbind(subj,y,x) ## Combine the subject activity and feature data by columns
rm(subj) ## Clean unnecessary data from the workspace
rm(y) ## Clean unnecessary data from the workspace
rm(x) ## Clean unnecessary data from the workspace

## Change the activity data to readable activity names rather than numbers corresponding to activities

activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt") ## Load the activity names per number
acceldata <- mutate(acceldata, Activity = activitylabels[Activity,2]) ## Change the Activity variable to use names rather than numbers
rm(activitylabels) ## Clean unnecessary data from the workspace

## Create a new data frame containing the mean of each feature for each suject and activity level

acceldatasummary <- acceldata %>% ## Begin a dplyr chain that will create the summary frame
    group_by(Subject, Activity) %>% ## Group the data by subject and activity
    summarise_each(funs(mean)) ## Take the mean for each subject and activity for each feature column
## Rename all feature columns to reflect the fact that they now contain averages of their previous data
colnames(acceldatasummary) <- c("Subject", "Activity", paste("Average of", colnames(acceldatasummary[3:68]), sep = " "))

## Write both the cleaned raw data and the averages per subject per activity to text files

write.table(acceldata, "CleanAccelerometerData.txt") ## Write the cleaned raw data to a .txt file
write.table(acceldatasummary, "SummaryofCleanAccelerometerData.txt") ## Write the averages of feature data to a .txt file
