# Prepare_data
Getting and Cleaning Data Course Project

The main R scipt is attached in the run_analysis.R file
The aim of the analysis is to prepare the clean data and the script does following:

1) downloads data from the web:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2) reads the train and test data, but only the columns with the mean and standard deviation
3) changes the column names - descriptions of the measures and names the activities using the labels from the activity table
4) merges the data sets into one data set
5) for the merged data set calculates the means of each variable grouping the data set by the activities, and subjects
6) the data from 5) is saved into final dataset file.
