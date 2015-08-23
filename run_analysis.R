#####################################################################################
##                                                                                 ##
##                        Welcome, my excellent friends!                           ##
##                                                                                 ##
## Here's my take on the RunAnalysis Peer Assignment for the Getting and Cleaning  ##
## Data course on Coursera.                                                        ##
##                                                                                 ##
## The assignment gave five steps in which to process the data. I tried them, but  ##
## thought they could be made simpler and quicker by using a different order. So   ##
## I do all the steps, just not in the order that the assignment specified.        ##
##                                                                                 ##
## What's important to know, is that I tried not to repeat myself in the code,     ##
## following the Don't Repeat Yourself (DRY) principle. For that, I created some   ##
## functions in which I placed code that was called repeatedly, like the           ##
## load_data_subset and load_file functions.                                       ##
##                                                                                 ##
## I also created the download_if_needed and load_data functions to make the main  ##
## run_analysis function shorter and more readable. The load_tidy_headers function ##
## is called from load_data function and is also used to make load_data less       ##
## less cluttered. All functions are explained in the comments.                    ##
##                                                                                 ##
## To run this script, source it and type run_analysis().                          ##
## It loads the dplyr library. If you don't have it, install it using              ##
## install.packages(dplyr). It also loads the downloader package to download       ##
## data files if they are not present. Install this package with                   ##
## install.packages(downloader).                                                   ##
##                                                                                 ##
## The output is written to 'tidy_run_analysis.txt' in the current working         ##
## directory.                                                                      ##
##                                                                                 ##
## For more info, see the comments or the README.md and CodeBook.md files.         ##
##                                                                                 ##
#####################################################################################

# Load dplyr w/o showing all the startup messages
suppressPackageStartupMessages(library(dplyr))

# Download and unzip data if needed. Checks whether the supplied dir and
# exist. If not, it attempts to download the zipfile from the
# supplied url. For this, it uses the downloader package. So there's a dependency
# on this package. If you don't have it, install it by using
# install.packages('downloader')
#
# (string) dir The directory the data should be in.
# (string) url The url where the data zipfile can be downloaded.
# (string) zip The name of the zipfile.
#
# Returns null
#
download_if_needed <- function(dir, url, zip) {
  if (!dir.exists(dir)) {
    print("Data directory not found.")
    if (!file.exists(zip)) {
      # use downloader package for platform-independent https handling
      print("Downloading data.")
      suppressPackageStartupMessages(library(downloader))
      download(url, zip)
    }
    print("Unzipping data zipfile.")
    unzip(zip)
  }
}

# Load the given file using read.table, and create a dplyr table from it using
# as.tbl().
# I use this function to do all the file loading in one place so I can easily
# decide to insert print statements or change the way it reads files.
# 
# (string) filename: a string with the path to the file that should be read.
# 
# Returns A dataframe, wrapped in a dplyr table using dplyr::as.tbl()
#
load_file <- function(filename) {
  as.tbl(read.table(filename))
}

# Load the dataset from the supplied base_dir, in the data_subset subdirectory.
# I use this to load the test and train data with two calls to this function.
# It also sets the activity names as defined in the supplied activity_labels.
#
# (string) base_dir The path to the directory containing all data.
# (string) data_subset The name of the data subset to load
# (character vector) activity_labels
#
# Returns A dplyr wrapped dataframe (since it uses the load_file function)
#         with added 'Activity' and 'Subject' columns in the 1 and 2 positions.
#
load_data_subset <- function(base_dir, data_subset, activity_labels) {
  print(paste("Loading ", data_subset, "ing data.", sep = ""))
  dir <- file.path(base_dir, data_subset)

  # Read data plus subjects and activities from files
  data <- load_file(file.path(dir, paste("X_", data_subset, ".txt", sep = "")))
  subjects <- load_file(file.path(dir, paste("subject_", data_subset, ".txt", sep = "")))
  activities <- load_file(file.path(dir, paste("y_", data_subset, ".txt", sep = "")))
  
  # Join the activity numbers and their names using dplyr's full_join. The second
  # column then contains the names in the preserved order.
  named_activities <- full_join(activities, activity_labels, by = "V1")[2]
  
  # Use dplyr's bind_cols to prepend activities and subjects to the data
  bind_cols(named_activities, subjects, data)
}

# Load the column header names and 'tidy' them by making them more human
# readable. The column names are constructed of several components that I 
# seperate and make more descriptive.
#
# (string) filename The path to the file containing the column names.
#
# Returns A dplyr wrapped dataframe containing human readable column names.
load_tidy_headers <- function (filename) {
  headers <- load_file(filename)
 
  # transpose using t() to turn it from long to wide form.
  headers <- t(headers[2])

  # Use several gsub statements to make variables more readable.
  headers <- gsub("^t", "time-", headers)
  headers <- gsub("^f", "frequency-", headers)
  headers <- gsub("BodyBody", "body-", headers)
  headers <- gsub("Body", "body-", headers)
  headers <- gsub("Acc", "accelerometer-", headers)
  headers <- gsub("Gyro", "gyroscope-", headers)
  headers <- gsub("Jerk", "jerk-", headers)
  headers <- gsub("Mag", "magnitude-", headers)
  headers <- gsub("Gravity", "gravity-", headers)
  headers <- gsub("--", "-", headers)
  headers
}

# Loads all data from the supplied directory using load_data_subset().
# 
# (string) dir The directory containing all data
# 
# Returns A dplyr wrapped dataframe with all column names set and containing data
#         from both train and test data subsets.
load_data <- function(dir) {
  print(paste("Loading data from", dir))
  
  # load column headers and make them more readable by (see load_tidy_headers)
  headers <- load_tidy_headers(file.path(dir, "features.txt"))
  col_names <- append(c("Activity", "Subject"), headers)
  
  # Load activity labels
  activity_labels <- load_file(file.path(dir, "activity_labels.txt"))
  
  # Loading train and test data. Setting column names here is necessary for
  # bind_rows to  work correctly (it binds rows by column names). Since the
  # train and test datasets have equally many columns and they mean the same
  # thing, this is no problem. Note the use of dplyr's %>% chain functionality.
  train_data <- load_data_subset(dir, "train", activity_labels) %>% setNames(col_names)
  test_data <- load_data_subset(dir, "test", activity_labels) %>% setNames(col_names)
    
  print("All data loaded.")
  
  # Use dplyr's bind_rows to combine train and test data, and return the result.
  print("Combining test and train datasets.")
  bind_rows(train_data, test_data)
}

# Main function to run this script. Calls the other (sub)functions that are defined
# in this file. If necessary, it downloads the data and unzips. Then it loads the 
# train and test datasets, adds the Activity and Subject columns, sets columnnames,
# and includes names for all activities. It then selects the mean() and std() columns,
# groups on Activity and Subject, and for each variable (column) calculates the mean
# per group. The resulting data is written to the file "tidy_run_analysis.txt".
#
# Returns The final tidy dataset, wrapped in a dplyr object using as.tbl
#
run_analysis <- function() {
  # Setup
  data_url <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  data_dir <- file.path(getwd(), "UCI HAR Dataset")
  data_zip <- paste(data_dir, ".zip", sep="")
  tidy_file <- "tidy_run_analysis.txt"
  
  # Remove tidy output file if it is present (since we are replacing it)
  if (file.exists(tidy_file)) file.remove(tidy_file)
  
  # Download files if not already there
  download_if_needed(data_dir, data_url, data_zip)
  
  # Load data, select, group and summarise using mean() function. The data is
  # then written to 'tidy_run_analysis.txt'.
  # I like the dplyr chain functionality %>% so I make good use of it. :)
  # For explanation, try ?chain
  result <- load_data(data_dir) %>%
    select(Activity:Subject, contains("mean()"), contains("std()")) %>%
    group_by(Activity, Subject) %>%
    summarise_each(funs(mean))
  
  write.table(result, file = tidy_file, row.names = FALSE)
  
  print("Selected, grouped and summarised the data.")
  print(paste("Tidy data has been written to '", tidy_file, "'.", sep = ""))
  print("Thank you for your patience.")
  
  result
}

# Uncomment this to make the script run with Rscript or when it is loaded with source().
run_analysis()
