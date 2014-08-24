# Script for Producing Tidy Data Set from Samsung Data
rm(list = ls())
dir_path = 'UCI_HAR_Dataset'
activity_labels_path = paste0(dir_path,'/activity_labels.txt')
feature_labels_path = paste0(dir_path,'/features.txt')

# Function for reading raw data from given directory
read_data <- function(dir_path,label){
  data_path = paste0(dir_path,'/',label,'/X_',label,'.txt')
  data = read.table(data_path,header=F)
  subject_path = paste0(dir_path,'/',label,'/subject_',label,'.txt')
  subject = read.table(subject_path,header=F)
  activity_label_path = paste0(dir_path,'/',label,'/y_',label,'.txt')
  activity_label = read.table(activity_label_path,header=F)
  cbind(subject,activity_label,data)
}

# Combining Data from training and testing DBs
combined_data <- rbind(read_data(dir_path,'train'),read_data(dir_path,'test'))

# Subjects
subjects = combined_data[,1]
num_subjects = length(unique(subjects))

# Reading activity labels mapping data
activity_labels_data = read.table(activity_labels_path)
activities = as.character(combined_data[,2])
num_activity = nrow(activity_labels_data)
for ( i in 1:num_activity ){
  activities[which(combined_data[,2] == i)] = as.character(activity_labels_data[i,2])
}

# Reading feature labels and selecting the features
# on the mean and standard deviation for each measurement
feature_labels = read.table(feature_labels_path)
indices = grep(".*-(mean|std)\\(\\).*",feature_labels[,2])
label_indices = feature_labels[indices,1]+2
label_names = as.character(feature_labels[indices,2])

# Extracting the data for the appropriate (mean/SD) features
extracted_data = combined_data[,label_indices]
names(extracted_data) = label_names

# Tidy data - Average of each variable for each activity and each subject
tidy_data = aggregate(extracted_data,
                      by=list(subject=subjects,activity=activities),mean)
label_names = paste0("avg-",label_names)
names(tidy_data)[3:ncol(tidy_data)] = label_names
# Storing tidy data
write.table(tidy_data,file=paste0(dir_path,"/tidy_data.txt"),row.names=F)
