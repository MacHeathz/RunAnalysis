## Assignment task 1.	Merge the training and the test sets to create one data set.
  dati<- rbind(read.csv("UCI HAR Dataset/test/X_test.txt",colClasses = rep("numeric",561), sep="", header=FALSE),read.csv("UCI HAR Dataset/train/X_train.txt",colClasses = rep("numeric",561), sep="", header=FALSE))
# get the name of the column variables
  colnames(dati) <- read.csv("UCI HAR Dataset/features.txt",sep="", header=FALSE,stringsAsFactors = FALSE)[,2]

## Assignment task 2.	Extracts only the measurements on the mean and standard deviation for each measurement
#filter mean() and std()
# variables called MeanFreq will not be considered as they are "weighted averages" as the codebook says and not means
# variables called angle(...Mean) will not be considered as they are angles and not means
  dati <- dati[,grepl("std\\(", names(dati)) | grepl("mean\\(", names(dati))]

## Assignment task 3.Use descriptive activity names to name the activities in the data set
# read activity from file and apply to dataset
  activity <- rbind(read.csv("UCI HAR Dataset/test/y_test.txt",sep="", header = FALSE),read.csv("UCI HAR Dataset/train/y_train.txt",sep="", header = FALSE))
  activitytable <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="", header = FALSE)
  activity[,1] <- activitytable[activity[,1],2]
  colnames(activity) <- "Activity"
#add subjects of activity and give them descriptive name
  subject <- rbind(read.csv("UCI HAR Dataset/test/subject_test.txt",sep="", header = FALSE),read.csv("UCI HAR Dataset/train/subject_train.txt",sep="", header = FALSE))
  colnames(subject) <- "Subject"
#add activity & subject columns to data to obtain a complete data frame
  dati <- cbind(activity,subject,dati)
#order by subject and activity
  dati <- dati[ order(dati[,2], dati[,1]), ]
#overwrite numerical values with descriptive names for Subject -> subject "1" becomes "Subject 1"
#make subject as factor (can be useful later on
  dati[,2]=paste("Subject", dati[,2],sep = " ")
  dati[,2] <- as.factor(dati[,2])

## Assignment task  4.	Appropriately labels the data set with descriptive variable names. 
# extract variable names
  vettorenomi <- colnames(dati)
# edit columns names with extensive description
  vettorenomi <-sub("Body","Body ",vettorenomi)
  vettorenomi <-sub(" Body"," Body ",vettorenomi)
  vettorenomi <-sub("^t","Time Domain ",vettorenomi)
  vettorenomi <-sub("^f","Frequency Domain ",vettorenomi)
  vettorenomi <-sub("Acc","Acceleration ",vettorenomi)
  vettorenomi <-sub("-mean\\(\\)-","Mean in Axis-",vettorenomi)
  vettorenomi <-sub("-mean\\(\\)","Mean",vettorenomi)
  vettorenomi <-sub("Gravity","Gravity ",vettorenomi)
  vettorenomi <-sub("-std\\(\\)-","Std. Dev. in Axis-",vettorenomi)
  vettorenomi <-sub("-std\\(\\)","Std. Dev. ",vettorenomi)
  vettorenomi <-sub("Gyro","Gyroscopical ",vettorenomi)
  vettorenomi <-sub("Mag","Magnitude ",vettorenomi)
  vettorenomi <-sub("Jerk","Jerk ",vettorenomi)
# overwrite variable names (USED str(dati) to verify variable names)
  colnames(dati) <- vettorenomi

## Assignment task 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  library(data.table)
#transform data frame to data Table
  tidydataset <- data.table(dati)
  tidydataset <- tidydataset[, lapply(.SD, mean), by=c("Subject", "Activity")]
  write.table(tidydataset, "Tidydataset.txt", row.names = FALSE)
