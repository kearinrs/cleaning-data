#install plyr to split and merge datasets
if (!require("plyr")) {
  install.packages("plyr")
}

# Read in the training data from files

#features <- read.table("./features.txt")
#activityLabels <- read.table("./activity_labels.txt")
activity_labels <- read.table("./activity_labels.txt", col.names = c("ActivityID", "ActivityName"))
features <- read.table("./features.txt", col.names = c("FeatureID", "FeatureName"), colClasses = c("character"))
XTrain = read.table('./train/X_train.txt',header=FALSE); #imports x_train.txt
YTrain = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt


#merge xtrain and y train to create final training data set
trainingData = cbind(YTrain,subjectTrain,XTrain);

#repeat on the test data
#read in test datasets

subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
XTest = read.table('./test/X_test.txt',header=FALSE); #imports x_test.txt
YTest = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

#create final test data set 

testData = cbind(YTrain,subjectTrain,XTrain);


# combining training and test data sets

combined = rbind(trainingData, testData);



#assign labels for the merged data


merged_labels <- rbind(rbind(features, c(nrow(features) + 1, "Subject")), c(nrow(features) + 2, "ActivityID"))
colnames(combined) <- merged_labels[,2]


#extract mean and sd measurements

extracted_combined <- combined[grep(".*mean.*|.*std.*|Subject|ActivityID", names(combined))];

extracted_combined <- join(extracted_combined, activity_labels, by = "ActivityID", match = "first")
extracted_combined <- extracted_combined[,-1]


#cleaning data and altering the column names

colnames(extracted_combined) = gsub("\\()","",colnames(extracted_combined))
colnames(extracted_combined) = gsub("-std$","StdDev",colnames(extracted_combined))
colnames(extracted_combined) = gsub("-mean","Mean",colnames(extracted_combined))
colnames(extracted_combined) = gsub("^(t)","time",colnames(extracted_combined))
colnames(extracted_combined) = gsub("^(f)","freq",colnames(extracted_combined))
colnames(extracted_combined) = gsub("([Gg]ravity)","Gravity",colnames(extracted_combined))
colnames(extracted_combined) = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colnames(extracted_combined))
colnames(extracted_combined) = gsub("[Gg]yro","Gyro",colnames(extracted_combined))
colnames(extracted_combined) = gsub("AccMag","AccMagnitude",colnames(extracted_combined))
colnames(extracted_combined) = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colnames(extracted_combined))
colnames(extracted_combined) = gsub("JerkMag","JerkMagnitude",colnames(extracted_combined))
colnames(extracted_combined) = gsub("GyroMag","GyroMagnitude",colnames(extracted_combined))


# Create a tidy data set with the average of each variable for each activity and each subject.
average_by_activity_subject <- ddply(extracted_combined, c("Subject","ActivityName"), numcolwise(mean))
write.table(average_by_activity_subject, file = "average_by_activity_subject.txt", row.name=FALSE)
