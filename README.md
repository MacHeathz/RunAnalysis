---
title: "README"
author: "Florian"
date: "August 21, 2015"
output:
  html_document:
    keep_md: yes
---

## How to use run_analysis.R
The main script consists of run_analysis.R. You should source it and then run it by calling the function run_analysis(). Alternatively, it is also possible to run the script by uncommenting the last line and running it using Rscript.

## How it works
The script will start by looking for the data zipfile or directory in the current directory. If it can't be found, it will download and unzip the data. Once the data is downloaded, the script runs the following steps:
 1. Load column names and subjects. Column names are made more human readable (more tidy) by:
   * Replacing 'BodyBody' with 'Body'
   * Adding dashes after 't', 'f', and 'Acc' and 'Body'
 2. Load train and test datasets.
 3. Combine the train and test datasets each with activity names and subjects.
 4. Setting column headers on the train and test datasets.
 5. Joining the train and test datasets.
 6. Selecting the columns containing mean() and std().
 7. Grouping the dataset by Activity and Subject.
 8. Calculating the mean() for each variable, for each group.
 9. Writing the result to the output file named 'tidy_run_analysis.txt'.

## Dependencies
The script uses the dplyr package for tidying the data. Downloading is done using the downloader package. You can install either of them by calling install.packages().

## Functions
The script defines the following functions:
`run_analysis()`: The main function that sets everything in motion. It calls `load_data`, that returns a combined dataset. `load_data` calls `load_data_subset` twice, for both the test and train data. They are combined, together with column names, activities (with names) and subjects. The column names are also processed to be more easily human readable, using `load_tidy_headers`. All files are loaded using the `load_file` function.

More details on the functions can be found in the code as comments.