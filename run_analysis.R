library(dplyr)

# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.

dataset_url <-
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_dir <- "UCI HAR Dataset"
dataset_zip <- paste(dataset_dir, ".zip", sep="")
train_dir <- file.path(dataset_dir, "train")
test_dir <- file.path(dataset_dir, "test")

merge_data <- function (set1, set2) {
  rbind(set1, set2)
}

extract_measurements <- function (dataset, ...) {
  headers <- read.table(file.path(dataset_dir, "features.txt"))
  #names(dataset) <- headers[,2]
  dataset[, grep("mean|std", headers[, 2])]
}

set_activity_names <- function (dataset) {
  train_labels <- read.table(file.path(train_dir, "y_train.txt"))
  test_labels <- read.table(file.path(test_dir, "y_test.txt"))
  alllabels <- rbind(train_labels, test_labels)
  
  activities <- read.table(file.path(dataset_dir, "activity_labels.txt"))
  named_activities = merge(alllabels, activities, by.x = 1, by.y = 1)

  cbind(named_activities[,2], dataset)
}

label_dataset <- function (dataset) {
  headers <- read.table(file.path(dataset_dir, "features.txt"))
  head_ms <- headers[grep("mean|std", headers[, 2]), 2]
  names(dataset)[2:80] <- head_ms
  names(dataset)[1] <- "Activity"
  dataset
}

tidy_dataset <- function(dataset) {
  # append subjects
  train_subjects <- read.table(file.path(train_dir, "subject_train.txt"))
  test_subjects <- read.table(file.path(test_dir, "subject_test.txt"))
  
  allsubjects <- rbind(train_subjects, test_subjects)
  names(allsubjects) = "Subject"
  target <- which(names(dataset) == 'Activity')[1]
  subj_dataset <- cbind(dataset[,1:target, drop=FALSE],
                        allsubjects,
                        dataset[, (target+1):ncol(dataset), drop=FALSE]
                       )

  # average all variables for each activity and each subject
  #grouped <- group_by(subj_dataset, Activity, Subject)
  woohoo <- aggregate(subj_dataset[, 3:ncol(subj_dataset)], by = list(subj_dataset$Activity, subj_dataset$Subject), FUN = mean)
}

run_analysis <- function (){
  # Download and unzip if needed
  if (!dir.exists(dataset_dir)) {
    download.file(dataset_url, dataset_zip)
    unzip(dataset_zip)
  }
  
  train_data <- read.table(file.path(train_dir, "X_train.txt"))
  test_data <- read.table(file.path(test_dir, "X_test.txt"))
  
  ## We'll use the %>% operator from dplyr, see ?chain
  dsm <- merge_data(train_data, test_data)# %>%         #1
  dse <- extract_measurements(dsm, mean, sd)# %>%  #2
  dss <- set_activity_names(dse)# %>%              #3
  dsl <- label_dataset(dss)# %>%                   #4
  dst <- tidy_dataset(dsl)                        #5
}
