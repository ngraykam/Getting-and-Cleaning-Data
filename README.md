# Getting-and-Cleaning-Data
Project for course "Getting and Cleaning Data"
This is the project for the course Getting and Cleaning Data. The R script, run_analysis.R, performs the works below.

1. Get the data:

   1.1 Download the file, store it and unzip it in the data folder.
   
   1.2 List the files.
   
   1.3 Read the data from the files.
   
   1.4 View the structures of the datasets.

2. Merge the Training dataset and the Test dataset:

   2.1 Combine the rows.
   
   2.2 Assign names to variables.
   
   2.3 Combine the columns of dataActivity, dataSubject and dataFeatures.

3. Extract only the measurements on the mean and standard deviation for each measurement:

   3.1 Select rows of Features with the mean and standard deviation.
   
   3.2 Subset the data frame UCIData by seleted rows of Features.

4. Use descriptive activity names to name the activities in the data set:

   4.1 Read the labels from "activity_labels.txt".
   
   4.2 Check the structure of activityLabels.
   
   4.3 Create column names for activityLabels.
   
   4.4 Add the activity label to the dataset (UCIData) using a merge on activity.
   
   4.5 Exclude the activity field.
   
   4.6 Rename the activityName field to activity.
   
   4.7 Check that activity has been merged correctly.
   

5. Appropriately labels the data set with descriptive variable names:

   5.1 Variable names replaced.
   
   5.2 Check the results.

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. The result is stored in the file tidy.txt.
