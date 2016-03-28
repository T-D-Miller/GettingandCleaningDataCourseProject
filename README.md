# GettingandCleaningDataCourseProject
This is the final course project for the Coursera Course "Getting and Cleaning Data"

## Contents and descriptions

This repo contains the following:

The UCI "Human Activity Recognition Using Smartphones Data Set" found 
here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
more information here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R - An R script that takes the above data set and parses it into a more clean
usable file.  The script combines the test and train data, properly lables all variables,
keeps only mean and standard deviation features, renames activities to be readable, and
summarizes the data to show the average of each feature for each subject for each activity. The
script outputs 2 text files, one with the clean data, and the other with the summarized data.

CleanAccelerometerData.txt - The resulting cleaned data from the above script

SummaryofCleanAccelerometerData.txt - The resulting summarized data from the above script

CodeBook.md - A code book containing more information on the data and on the transformations performed