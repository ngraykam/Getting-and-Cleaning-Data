# Project for course "Getting and Cleaning Data"
# Get the data

# 1.Download the file, store it and unzip it in the data folder

  if(!file.exists("./data")){dir.create("./data")}
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url=fileURL,destfile="./data/Dataset.zip")
  unzip(zipfile="./data/Dataset.zip",exdir="./data")

# 2. List the files
  path_dataset <- file.path("./data" , "UCI HAR Dataset")
  files<-list.files(path_dataset, recursive=TRUE)
  files

# The files that will be used to load the data are listed below:
# test/subject_test.txt
# test/X_test.txt
# test/y_test.txt
# train/subject_train.txt
# train/X_train.txt
# train/y_train.txt

# 3. Read the data from the files

  dataActivityTest  <- read.table(file.path(path_dataset, "test" , "Y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(path_dataset, "train", "Y_train.txt"),header = FALSE)

  dataSubjectTrain <- read.table(file.path(path_dataset, "train", "subject_train.txt"),header = FALSE)
  dataSubjectTest  <- read.table(file.path(path_dataset, "test" , "subject_test.txt"),header = FALSE)

  dataFeaturesTest  <- read.table(file.path(path_dataset, "test" , "X_test.txt" ),header = FALSE)
  dataFeaturesTrain <- read.table(file.path(path_dataset, "train", "X_train.txt"),header = FALSE)

# 4. View the structures of the datasets

  str(dataActivityTest)
  str(dataActivityTrain)
  str(dataSubjectTest) 
  str(dataSubjectTrain) 
  str(dataFeaturesTest) 
  str(dataFeaturesTrain) 

# Merge the Training dataset and the Test dataset

# 1. Combine the rows
  dataActivity<- rbind(dataActivityTrain, dataActivityTest)
  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

# 2. Assign names to variables
  names(dataActivity)<- c("activity")
  names(dataSubject)<-c("subject")
  
  dataFeaturesNames <- read.table(file.path(path_dataset, "features.txt"),head=FALSE)
  names(dataFeatures)<- dataFeaturesNames$V2

# 3. Combine the columns of dataActivity, dataSubject and dataFeatures
   UCIData <- cbind(dataActivity, dataSubject, dataFeatures)

# Extracts only the measurements on the mean and standard deviation for each measurement

# 1. Select rows of Features with the mean and standard deviation
  mean_std_FeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# 2. Subset the data frame UCIData by seleted rows of Features
  selectedColumns<-c(as.character(mean_std_FeaturesNames), "subject", "activity" )
  UCIData<-subset(UCIData,select=selectedColumns)

# Uses descriptive activity names to name the activities in the data set

# 1. Read the labels from "activity_labels.txt"
  activityLabels <- read.table(file.path(path_dataset, "activity_labels.txt"),header = FALSE)

# 2. Check the structure of activityLabels
  activityLabels

# 3. Create column names for activityLabels
  colnames(activityLabels) <- c("activity","activityName")
  activityLabels

# 4. Add the activity label to the dataset (UCIData) using a merge on activity
  UCIData <- merge(x=UCIData, y=activityLabels, by="activity")

# 5. Exclude the activity field
  library("dplyr")
  UCIData <- select(UCIData, -activity)

# 6. Rename the activityName field to activity
  colnames(UCIData)[68] <- "activity"

# 7. Check that activity has been merged correctly
  head(UCIData$activity, 10)
  tail(UCIData$activity, 10)

# Appropriately labels the data set with descriptive variable names

# 1. Variable names replaced
  names(UCIData)<-gsub("^t", "time", names(UCIData))
  names(UCIData)<-gsub("^f", "frequency", names(UCIData))
  names(UCIData)<-gsub("Acc", "Accelerometer", names(UCIData))
  names(UCIData)<-gsub("Gyro", "Gyroscope", names(UCIData))
  names(UCIData)<-gsub("Mag", "Magnitude", names(UCIData))
  names(UCIData)<-gsub("BodyBody", "Body", names(UCIData))

# 2. Check the results
  names(UCIData)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
  library(dplyr)
  tidyUCIData<-aggregate(. ~subject + activity, UCIData, mean)
  tidyUCIData<-tidyUCIData[order(tidyUCIData$subject,tidyUCIData$activity),]
  write.table(tidyUCIData, file = "tidy.txt", row.name=FALSE)



 

