CleaningDataProject
===================

Script for combining train and test data sets and extracting certain features from Human Activity Recognition Data

This repository contains run_analysis.R script file. The raw data directory path ("dir_path") can be set at the beginning of the script. Also, the acitivity label description file path, feature label map file path can be provided by setting "activity_labels_path" and "feature_labels_path" accordingly. In the raw data directory path, it is assumed that two folders for training and testing data (X,y and subject data) exist.

The following steps describe the cleaning procedure to obtain required tidy data.

1) X, y, subject data are column binded for both training and testing data. Both training and testing data are combined (row binded) to obtain complete raw data set

2) Also, the activity label map and feature label map are obtained.

3) Activity label description vector (activities) is obtained using combined raw data and activity label map.

4) Features on the mean and standard deviation for each measurement are extracted from combined raw data.

5) Finally, Tidy data containing Average of each variable for each activity and each subject is obtained.

The tidy data is stored to disk in the same path as raw data directory path named "tidy_data.txt"
