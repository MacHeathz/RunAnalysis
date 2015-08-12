library(dplyr)

# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.
run_analysis <- function (){
  train <- list.files("traindir")
  test <- list.files("testdir")

  ## We'll use the %>% operator from dplyr, see ?chain
  merge_data(train, test) %>%         #1
  extract_measurements(mean, sd) %>%  #2
  set_activity_names %>%              #3
  label_dataset %>%                   #4
  tidy_dataset                        #5
}

merge_data <- function (set1, set2) {
  
}

extract_measurements <- function (dataset, ...) {
  
}

set_activity_names <- function (dataset) {
  
}

label_dataset <- function (dataset) {
  
}

tidy_dataset <- function(dataset) {
  
}