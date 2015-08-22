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
Several things are done to the data: the train and test datasets are combined, (human readable) column names are added as well as an Activity column (with activity names) and a Subject column. Mean and std columns are selected, and the mean values for each activity and subject combination are determined for each variable. Everything is then written to a 'tidy_run_analysis.txt' file.

[see also the README document that describes the code in greater detail](README.md)

###Constraints
Only columns that use a mean() or std() function are selected. I am aware that there are other columns that contain a meanFreq for example. However, they don't contain values of raw data, they have been processed, and because I only wanted to consider raw data values, I left those out.

##Description of the variables in the tiny_run_analysis.txt file
The final output of the script is a dataset containing 180 observations of 68 variables. The 180 rows is easily deducted, since there were 6 activities and 30 test subjects in total. Since we grouped on Activity and Subject, we arrive at 6x30 = 180 groups for which the mean was calculated on all variables.

Dplyr provides a summary of the tidy dataset:
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
Activities performed by the test subjects, in plain text.
They can be of the following values:
 * LAYING
 * SITTING
 * STANDING
 * WALKING
 * WALKING_DOWNSTAIRS
 * WALKING_UPSTAIRS

### Subject
Numbers indicating the test subjects. There were 30 test subjects in total.

### Other
The other variables are all normalized, between -1 and 1. They consist of combinations of the following components, depending on what they measured and how they were calculated:
 * _time_: Time domain signals, captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
 * _frequency_: Frequency domain signals, obtained by applying a Fast Fourier Transform (FFT) to some signals.
 * _accelerometer_: Accelerometer sensor of the phone.
 * _gyroscope_: Gyroscope sensor of the phone.
 * _body_: Body acceleration, calculated from the time domain signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
 * _gravity_: Gravity acceleration, calculated from the time domain signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
 * _jerk_: Jerk signals. The body linear acceleration and angular velocity were derived in time to obtain these Jerk signals.
 * _magnitude_: The magnitude of three-dimensional signals were calculated using the Euclidean norm.
 * _mean()_: Calculated mean.
 * _std()_: Calculated standard deviation.
 * _X_, _Y_, and _Z_: 3-axial components of the sensors, in _X_, _Y_, and _Z_ direction.

In order, the other variables are:
 * time-body-acceleration-mean()-X
 * time-body-acceleration-mean()-Y
 * time-body-acceleration-mean()-Z
 * time-gravity-acceleration-mean()-X
 * time-gravity-acceleration-mean()-Y
 * time-gravity-acceleration-mean()-Z
 * time-body-acceleration-jerk-mean()-X
 * time-body-acceleration-jerk-mean()-Y
 * time-body-acceleration-jerk-mean()-Z
 * time-body-gyroscope-mean()-X
 * time-body-gyroscope-mean()-Y
 * time-body-gyroscope-mean()-Z
 * time-body-gyroscope-jerk-mean()-X
 * time-body-gyroscope-jerk-mean()-Y
 * time-body-gyroscope-jerk-mean()-Z
 * time-body-acceleration-magnitude-mean()
 * time-gravity-acceleration-magnitude-mean()
 * time-body-acceleration-jerk-magnitude-mean()
 * time-body-gyroscope-magnitude-mean()
 * time-body-gyroscope-jerk-magnitude-mean()
 * frequency-body-acceleration-mean()-X
 * frequency-body-acceleration-mean()-Y
 * frequency-body-acceleration-mean()-Z
 * frequency-body-acceleration-jerk-mean()-X
 * frequency-body-acceleration-jerk-mean()-Y
 * frequency-body-acceleration-jerk-mean()-Z
 * frequency-body-gyroscope-mean()-X
 * frequency-body-gyroscope-mean()-Y
 * frequency-body-gyroscope-mean()-Z
 * frequency-body-acceleration-magnitude-mean()
 * frequency-body-acceleration-jerk-magnitude-mean()
 * frequency-body-gyroscope-magnitude-mean()
 * frequency-body-gyroscope-jerk-magnitude-mean()
 * time-body-acceleration-std()-X
 * time-body-acceleration-std()-Y
 * time-body-acceleration-std()-Z
 * time-gravity-acceleration-std()-X
 * time-gravity-acceleration-std()-Y
 * time-gravity-acceleration-std()-Z
 * time-body-acceleration-jerk-std()-X
 * time-body-acceleration-jerk-std()-Y
 * time-body-acceleration-jerk-std()-Z
 * time-body-gyroscope-std()-X
 * time-body-gyroscope-std()-Y
 * time-body-gyroscope-std()-Z
 * time-body-gyroscope-jerk-std()-X
 * time-body-gyroscope-jerk-std()-Y
 * time-body-gyroscope-jerk-std()-Z
 * time-body-acceleration-magnitude-std()
 * time-gravity-acceleration-magnitude-std()
 * time-body-acceleration-jerk-magnitude-std()
 * time-body-gyroscope-magnitude-std()
 * time-body-gyroscope-jerk-magnitude-std()
 * frequency-body-acceleration-std()-X
 * frequency-body-acceleration-std()-Y
 * frequency-body-acceleration-std()-Z
 * frequency-body-acceleration-jerk-std()-X
 * frequency-body-acceleration-jerk-std()-Y
 * frequency-body-acceleration-jerk-std()-Z
 * frequency-body-gyroscope-std()-X
 * frequency-body-gyroscope-std()-Y
 * frequency-body-gyroscope-std()-Z
 * frequency-body-acceleration-magnitude-std()
 * frequency-body-acceleration-jerk-magnitude-std()
 * frequency-body-gyroscope-magnitude-std()
 * frequency-body-gyroscope-jerk-magnitude-std()
