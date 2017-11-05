install.packages('reshape2')
library(reshape2)
rm(list=ls())

## Download data and unpack zip:

url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
file='project_data.zip'


if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url,file)
  }  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}


#read data

activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')
features <- read.table('UCI HAR Dataset/features.txt')

#choose features with mean and std
MeanStdID <- grep(".*mean.*|.*std.*", features[,2])
MeanStdLabel <- features[MeanStdID,2]
MeanStdLabel = gsub('-mean', 'Mean', MeanStdLabel)
MeanStdLabel = gsub('-std', 'Std', MeanStdLabel)
MeanStdLabel <- gsub('[-()]', '', MeanStdLabel)

#read train and test data

Xtrain<-read.table('UCI HAR Dataset/train/X_train.txt')[MeanStdID]
names(Xtrain)<-MeanStdLabel
Ytrain<-read.table('UCI HAR Dataset/train/Y_train.txt')
names(Ytrain)<-c('ActivityID')
Strain <- read.table('UCI HAR Dataset/train/subject_train.txt')
names(Strain)<-c('Subject')

Xtest<-read.table('UCI HAR Dataset/test/X_test.txt')[MeanStdID]
names(Xtest)<-MeanStdLabel
Ytest<-read.table('UCI HAR Dataset/test/Y_test.txt')
names(Ytest)<-c('ActivityID')
Stest <- read.table('UCI HAR Dataset/test/subject_test.txt')
names(Stest)<-c('Subject')

#merge data
Train<-cbind(Strain,Ytrain,Xtrain)
Test<-cbind(Stest,Ytest,Xtest)
AllData<-rbind(Train,Test)

AllData$ActivityID<-factor(AllData$ActivityID, levels=activityLabels[,1], labels=activityLabels[,2])
AllData$Subject<-as.factor(AllData$Subject)




#calculate means
TranspData <- melt(AllData, id = c("Subject", "ActivityID"))
Means <- dcast(TranspData, Subject + ActivityID ~ variable, mean)

#export data
write.table(Means,file='UCI HAR Dataset/Means.txt',row.name = FALSE)

