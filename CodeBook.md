The run_analysis.R loads the data and cleans the data into tidydata following the project description.

1.  Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

2.  Description of the data
features <- features.txt : 561 rows, 2 columns
        The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals              tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns
        List of 6 activities performed
subjecttest <- test/subject_test.txt : 2947 rows, 1 column
        test data of 9/30 volunteer test subjects being observed
xtest <- test/X_test.txt : 2947 rows, 561 columns
        recorded features test data
ytest <- test/y_test.txt : 2947 rows, 1 columns
        test data of activities'code labels
subjecttrain <- test/subject_train.txt : 7352 rows, 1 column
        train data of 21/30 volunteer subjects being observed
xtrain <- test/X_train.txt : 7352 rows, 561 columns
        recorded features train data
ytrain <- test/y_train.txt : 7352 rows, 1 columns
        train data of activities'code labels

3.  Merge the training and test data into one data set
        -X (10299 rows, 561 columns) (use rbind() to merge xtrain and xtest)
        -Y (10299 rows, 1 column) use rbind() to merge ytrain and ytest)
        -Subject (10299 rows, 1 column) use rbind to merge subjecttrain and subjecttest
        -mergeddata (10299 rows, 563 column) use cbind() to merge Subject, Y and X

4. Extracts only the measurements on the mean and standard deviation for each measurement
        tidydata (10299 rows, 88 columns) is created by subsetting mergeddata, selecting only columns: subject,            code and the measurements on the mean and standard deviation (std) for each measurement

5.  Descriptive Activity Names
        Replace activity code numbers in tidydata with activity descriptions

6.  Column Names
        Replace abbreviations with full names
All Acc in column's name replaced by Accelerometer
All Gyro in column's name replaced by Gyroscope
All BodyBody in column's name replaced by Body
All Mag in column's name replaced by Magnitude
All start with character f in column's name replaced by Frequency
All start with character t in column's name replaced by Time

7.  Final Data
        - From the data set in step 6, creates a second, independent tidy data set with the average of each                variable for each activity and each subject
        - finaldata (180 rows, 88 columns) is created by grouping by subject and activity and finding the means for         each variable.

8.  Export finaldata into finaldata.xlsx file.
