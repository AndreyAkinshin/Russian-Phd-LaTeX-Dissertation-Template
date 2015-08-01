# Analysis of data on Course Project at Getting and Cleaning data course of Data Science track at Coursera.

# Part 1. Merges the training and the test sets to create one data set.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

if (!file.exists("UCI HAR Dataset")) {
    stop("You need 'UCI HAR Dataset' folder full of data")
}


library(plyr) # for mapvalues


#getting common data
features <- read.csv("UCI HAR Dataset/features.txt",sep=" ", header = FALSE,
                     colClasses = c("numeric","character"))
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="",
                            header = FALSE,colClasses = c("numeric","character"))

#getting train set data
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt",
                          header = FALSE,colClasses = "numeric",col.names="Subject")
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE,
                    colClasses = "numeric")
x_train <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="", header = FALSE,
                    colClasses = "numeric",col.names=features$V2,check.names = FALSE)

activity_train <- as.data.frame(mapvalues(y_train$V1, from = activity_labels$V1,
                                          to = activity_labels$V2))
names(activity_train) <- "Activity"



#getting test set data
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt",
                         header = FALSE,colClasses = "numeric",col.names="Subject")
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE,
                   colClasses = "numeric")
x_test <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="", header = FALSE,
                   colClasses = "numeric",col.names=features$V2,check.names = FALSE)

activity_test <- as.data.frame(mapvalues(y_test$V1, from = activity_labels$V1,
                                         to = activity_labels$V2))
names(activity_test) <- "Activity"


# Forming full dataframe
data_train <- cbind(x_train,subject_train,activity_train)
data_test <- cbind(x_test,subject_test,activity_test)
data <- rbind(data_train, data_test)

# Cleaning memory
rm(features, activity_labels, subject_train, y_train, x_train, activity_train,
   subject_test, y_test, x_test, activity_test, data_train, data_test)


# Part 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

cols2match <- grep("(mean|std)",names(data))

# Excluded gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean,
# tBodyGyroJerkMean, as these represent derivations of angle data, as
# opposed to the original feature vector. 

# Subsetting data frame, also moving last columns to be first
Subsetted_data_frame <- data[ ,c(562, 563, cols2match)]

# Part 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

library(dplyr) # for %>% and summarise_each

               
tidydata <- Subsetted_data_frame %>% group_by(Subject,Activity) %>% 
            summarise_each(funs(mean))

write.table(tidydata, "tidydata.txt", row.names=FALSE)
