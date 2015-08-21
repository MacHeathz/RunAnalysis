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
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable Activity:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

####Notes on variable Subject:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)