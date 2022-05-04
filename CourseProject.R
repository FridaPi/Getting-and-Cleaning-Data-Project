#set directory
setwd("C:/Users/tracy.lemieux/OneDrive - Government of Alberta/Documents/R/Coursera/Coursera Courses/Getting and Cleaning Data/")

library(dplyr)
library(data.table)

## Load Data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Step 1: merge data
X <- rbind(xtrain, xtest)
Y <- rbind(ytrain, ytest)
subject <- rbind(subjecttrain, subjecttest)
mergeddata <- cbind(subject, Y, X)

##F Step 2: find subset (mean and standard deviation)
tidydata <- mergeddata %>% select(subject, code, contains("mean"), contains("std"))

## Step 3: apply activity names
tidydata$code <- activities[tidydata$code, 2]

## Step 4: clean variable names
names(tidydata)[2] = "activity"
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "Time", names(tidydata))
names(tidydata)<-gsub("^f", "Frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "TimeBody", names(tidydata))
names(tidydata)<-gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "Angle", names(tidydata))
names(tidydata)<-gsub("gravity", "Gravity", names(tidydata))

## Step 5:  average each subject and each activity
finaldata <- tidydata %>%
        group_by(subject, activity) %>%
        summarise_all(mean)

## export to Excel
library("writexl")
write_xlsx(finaldata,"finaldata.xlsx")
