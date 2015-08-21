---
title: "CodeBook"
author: "Florian"
date: "August 21, 2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
This is my submission for the Course Project in the Getting and Cleaning Data course on Cousera. The assignment was to write a script plus documentation for tidying a dataset consisting of measurements of phone gyroscope and acceleration sensors while test subjects were conducting several activities.

##Study design and data processing

###Collection of the raw data
The raw data was collected in a test environment, where 30 human subjects were measured while performing several activities while wearing a Samsung Galaxy S phone on their belt.

###Notes on the original (raw) data 
The raw data contains several variables that were aggregates of the raw measurements.

##Creating the tidy datafile

###Guide to create the tidy data file
To create the tidy data file yourself, just source the 'run_analysis.R' script in R and call the 'run_analysis()' function. For convenience, you can also uncomment the last line in the script, which calls the run_analysis function, and invoke 'Rscript run_analysis.R' from the command line. Note that the script will download the data files and begin processing. The final result will be written to 'tidy_run_analysis.txt'.

###Cleaning of the data
In creating the tidy data file, the script takes the following steps:
 1. Download the data (if not already present in the current directory)
 2. Load column names and subjects. Column names are made more human readable (more tidy) by:
   * Replacing 'BodyBody' with 'Body'
   * Adding dashes after 't', 'f', and 'Acc' and 'Body'
 3. Load train and test datasets.
 4. Combine the train and test datasets each with activity names and subjects.
 5. Setting column headers on the train and test datasets.
 6. Joining the train and test datasets.
 7. Selecting the columns containing mean() and std().
 8. Grouping the dataset by Activity and Subject.
 9. Calculating the mean() for each variable, for each group.
 10. Writing the result to the output file named 'tidy_run_analysis.txt'.

[see also the README document that describes the code in greater detail](README.md)

##Description of the variables in the tiny_run_analysis.txt file
The final output of the script is a dataset containing 180 observations of 68 variables. The 180 rows is easily deducted, since there were 6 activities and 30 test subjects in total. Since we grouped on Activity and Subject, we arrive at 6x30 = 180 groups for which the mean was calculated on all variables.
```
> dataset
Source: local data frame [180 x 68]
Groups: Activity

   Activity Subject time-body-acceleration-mean()-X time-body-acceleration-mean()-Y
1    LAYING       1                       0.2215982                     -0.04051395
2    LAYING       2                       0.2813734                     -0.01815874
3    LAYING       3                       0.2755169                     -0.01895568
4    LAYING       4                       0.2635592                     -0.01500318
5    LAYING       5                       0.2783343                     -0.01830421
6    LAYING       6                       0.2486565                     -0.01025292
7    LAYING       7                       0.2501767                     -0.02044115
8    LAYING       8                       0.2612543                     -0.02122817
9    LAYING       9                       0.2591955                     -0.02052682
10   LAYING      10                       0.2802306                     -0.02429448
..      ...     ...                             ...                             ...
Variables not shown: time-body-acceleration-mean()-Z (dbl), time-gravity-acceleration-mean()-X
  (dbl), time-gravity-acceleration-mean()-Y (dbl), time-gravity-acceleration-mean()-Z (dbl),
  time-body-acceleration-jerk-mean()-X (dbl), time-body-acceleration-jerk-mean()-Y (dbl),
  time-body-acceleration-jerk-mean()-Z (dbl), time-body-gyroscope-mean()-X (dbl),
  time-body-gyroscope-mean()-Y (dbl), time-body-gyroscope-mean()-Z (dbl),
  time-body-gyroscope-jerk-mean()-X (dbl), time-body-gyroscope-jerk-mean()-Y (dbl),
  time-body-gyroscope-jerk-mean()-Z (dbl), time-body-acceleration-magnitude-mean() (dbl),
  time-gravity-acceleration-magnitude-mean() (dbl), time-body-acceleration-jerk-magnitude-mean()
  (dbl), time-body-gyroscope-magnitude-mean() (dbl), time-body-gyroscope-jerk-magnitude-mean()
  (dbl), frequency-body-acceleration-mean()-X (dbl), frequency-body-acceleration-mean()-Y (dbl),
  frequency-body-acceleration-mean()-Z (dbl), frequency-body-acceleration-jerk-mean()-X (dbl),
  frequency-body-acceleration-jerk-mean()-Y (dbl), frequency-body-acceleration-jerk-mean()-Z
  (dbl), frequency-body-gyroscope-mean()-X (dbl), frequency-body-gyroscope-mean()-Y (dbl),
  frequency-body-gyroscope-mean()-Z (dbl), frequency-body-acceleration-magnitude-mean() (dbl),
  frequency-body-acceleration-jerk-magnitude-mean() (dbl),
  frequency-body-gyroscope-magnitude-mean() (dbl), frequency-body-gyroscope-jerk-magnitude-mean()
  (dbl), time-body-acceleration-std()-X (dbl), time-body-acceleration-std()-Y (dbl),
  time-body-acceleration-std()-Z (dbl), time-gravity-acceleration-std()-X (dbl),
  time-gravity-acceleration-std()-Y (dbl), time-gravity-acceleration-std()-Z (dbl),
  time-body-acceleration-jerk-std()-X (dbl), time-body-acceleration-jerk-std()-Y (dbl),
  time-body-acceleration-jerk-std()-Z (dbl), time-body-gyroscope-std()-X (dbl),
  time-body-gyroscope-std()-Y (dbl), time-body-gyroscope-std()-Z (dbl),
  time-body-gyroscope-jerk-std()-X (dbl), time-body-gyroscope-jerk-std()-Y (dbl),
  time-body-gyroscope-jerk-std()-Z (dbl), time-body-acceleration-magnitude-std() (dbl),
  time-gravity-acceleration-magnitude-std() (dbl), time-body-acceleration-jerk-magnitude-std()
  (dbl), time-body-gyroscope-magnitude-std() (dbl), time-body-gyroscope-jerk-magnitude-std()
  (dbl), frequency-body-acceleration-std()-X (dbl), frequency-body-acceleration-std()-Y (dbl),
  frequency-body-acceleration-std()-Z (dbl), frequency-body-acceleration-jerk-std()-X (dbl),
  frequency-body-acceleration-jerk-std()-Y (dbl), frequency-body-acceleration-jerk-std()-Z (dbl),
  frequency-body-gyroscope-std()-X (dbl), frequency-body-gyroscope-std()-Y (dbl),
  frequency-body-gyroscope-std()-Z (dbl), frequency-body-acceleration-magnitude-std() (dbl),
  frequency-body-acceleration-jerk-magnitude-std() (dbl),
  frequency-body-gyroscope-magnitude-std() (dbl), frequency-body-gyroscope-jerk-magnitude-std()
  (dbl)
```

### Activity
### Subject
### time-body-acceleration-mean()-X
### time-body-acceleration-mean()-Y
### time-body-acceleration-mean()-Z
### time-gravity-acceleration-mean()-X
### time-gravity-acceleration-mean()-Y
### time-gravity-acceleration-mean()-Z
### time-body-acceleration-jerk-mean()-X
### time-body-acceleration-jerk-mean()-Y
### time-body-acceleration-jerk-mean()-Z
### time-body-gyroscope-mean()-X
### time-body-gyroscope-mean()-Y
### time-body-gyroscope-mean()-Z
### time-body-gyroscope-jerk-mean()-X
### time-body-gyroscope-jerk-mean()-Y
### time-body-gyroscope-jerk-mean()-Z
### time-body-acceleration-magnitude-mean()
### time-gravity-acceleration-magnitude-mean()
### time-body-acceleration-jerk-magnitude-mean()
### time-body-gyroscope-magnitude-mean()
### time-body-gyroscope-jerk-magnitude-mean()
### frequency-body-acceleration-mean()-X
### frequency-body-acceleration-mean()-Y
### frequency-body-acceleration-mean()-Z
### frequency-body-acceleration-jerk-mean()-X
### frequency-body-acceleration-jerk-mean()-Y
### frequency-body-acceleration-jerk-mean()-Z
### frequency-body-gyroscope-mean()-X
### frequency-body-gyroscope-mean()-Y
### frequency-body-gyroscope-mean()-Z
### frequency-body-acceleration-magnitude-mean()
### frequency-body-acceleration-jerk-magnitude-mean()
### frequency-body-gyroscope-magnitude-mean()
### frequency-body-gyroscope-jerk-magnitude-mean()
### time-body-acceleration-std()-X
### time-body-acceleration-std()-Y
### time-body-acceleration-std()-Z
### time-gravity-acceleration-std()-X
### time-gravity-acceleration-std()-Y
### time-gravity-acceleration-std()-Z
### time-body-acceleration-jerk-std()-X
### time-body-acceleration-jerk-std()-Y
### time-body-acceleration-jerk-std()-Z
### time-body-gyroscope-std()-X
### time-body-gyroscope-std()-Y
### time-body-gyroscope-std()-Z
### time-body-gyroscope-jerk-std()-X
### time-body-gyroscope-jerk-std()-Y
### time-body-gyroscope-jerk-std()-Z
### time-body-acceleration-magnitude-std()
### time-gravity-acceleration-magnitude-std()
### time-body-acceleration-jerk-magnitude-std()
### time-body-gyroscope-magnitude-std()
### time-body-gyroscope-jerk-magnitude-std()
### frequency-body-acceleration-std()-X
### frequency-body-acceleration-std()-Y
### frequency-body-acceleration-std()-Z
### frequency-body-acceleration-jerk-std()-X
### frequency-body-acceleration-jerk-std()-Y
### frequency-body-acceleration-jerk-std()-Z
### frequency-body-gyroscope-std()-X
### frequency-body-gyroscope-std()-Y
### frequency-body-gyroscope-std()-Z
### frequency-body-acceleration-magnitude-std()
### frequency-body-acceleration-jerk-magnitude-std()
### frequency-body-gyroscope-magnitude-std()
### frequency-body-gyroscope-jerk-magnitude-std()

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

####Notes on variable Activity:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

####Notes on variable Subject:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)
