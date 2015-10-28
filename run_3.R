setwd("UCI HAR Dataset")

## This is one R script called run_analysis.R，which function as following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation
## for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data
## set 
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy 
## data set with the average of each variable for each activity and each
## subject.

## Step 0: preparation raw data and conditions
## 0.1 install dplyr
library(dplyr)
library(tidyr)

## 0.2 read from test and training dataset
xtest<-tbl_df(read.table("test/X_test.txt"))
ytest<-tbl_df(read.table("test/y_test.txt", 
                         col.names = "activity"))
subjecttest<-tbl_df(read.table("test/subject_test.txt",
                               col.names = "subjectID"))
xtrain<-tbl_df(read.table("train/X_train.txt"))
ytrain<-tbl_df(read.table("train/y_train.txt",
                          col.names = "activity"))
subjecttrain<-tbl_df(read.table("train/subject_train.txt",
                                col.names = "subjectID"))
                     
## Step 1. merge data
## 1.1 row merge for test and train data
my_xdata<-rbind(xtest,xtrain)
my_ydata<-rbind(ytest,ytrain)
my_subject<-rbind(subjecttest,subjecttrain)

## 1.2 colume merge for x,y and subject
my_data<-cbind(my_xdata,my_ydata,my_subject)

## Step 2. extract the colume about the mean and standard deviation
## 2.1 separate the feature by "-"
feature<-tbl_df(read.table("features.txt"))
sep_feature<-separate(feature,V2,c("a1","a2","a3"),sep="-", 
                      remove = FALSE, extra = "drop")
## 2.2 extract the features about the mean and standard deviation
my_feature<-filter(sep_feature,a2 == "mean()" | a2 == "std()") 
num<-my_feature$V1
mean_std_data<-select(my_data,num_range("V",num),activity,subjectID)

## Step 3. substitute the activity labels in the dataset 
activity_labels<-read.table("activity_labels.txt")
mean_std_data$activity = as.character(mean_std_data$activity)

for(i in 1:6){
        mean_std_data[mean_std_data$activity == i,"activity"] <- 
                as.character(activity_labels[i,2])
}

## Step 4:label the dataset with Appropriately labels
## 4.1 use the feature name as labels
## replace "-" with "_" and delete "()" in the feature name
feature_name<-gsub("-","_",(as.character(my_feature$V2)))
feature_name<-gsub("\\(\\)","",feature_name)                   
names(mean_std_data)<-c(feature_name,
                        "activity","subjectID")

## Step 5: computer average of each variable for each activity 
## and each subject.
by_group<-group_by(mean_std_data,activity,subjectID)
mean_data<-by_group%>%summarise_each(funs(mean))

## Result: write to the output file
write.table(mean_data,"meanresult.txt", quote = FALSE, 
            row.names = FALSE, col.names = FALSE)
meanfeature <- data.frame(names(mean_data))
write.table(meanfeature,"meanfeature.txt", quote = FALSE,
            col.names = FALSE)


