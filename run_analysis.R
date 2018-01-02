#read in test data

XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

#read in training data

XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")

#read in features and activities

features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

#Part 1:Merges the training and the test sets to create one data set.

X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)

#Part 2:Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std<-grep("mean\\(\\)|std\\(\\)", features[,2])
A<-X[,mean_std] 

#Part 3: Uses descriptive activity names to name the activities in the data set

Y[,1]<-activity[Y[,1],2] 

#Part 4:Appropriately labels the data set with descriptive variable names. 



names<-features[index,2] ## getting names for variables

names(A)<-names ## updating colNames for new dataset
names(Subject)<-"SubjectID"
names(Y)<-"Activity"


#Part 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanedDataSet<-data.table(CleanedData)
TidyDataSet <- CleanedDataSet[, lapply(.SD, mean), by = 'SubjectID,Activity']


write.table(TidyDataSet, file = "TidyData.txt", row.names = FALSE)

