bench <- function (n, func, ...) {
  runtimes <- sapply(1:n, function(x){
    system.time(func(...))["elapsed"]
  })
  mean(runtimes)
}

#################### TEST AREA ###################################

file <- 
  '~/R/Coursera/assignments/getdata-031/RunAnalysis/UCI HAR Dataset/train/X_train.txt'

load_table_no_col_classes <- function (filename) {
  read.table(filename, header = FALSE,
             quote = "", comment.char = "",
             row.names = NULL, stringsAsFactors = FALSE)
}
load_table <- function (filename) {
  initial <- read.table(filename, header = FALSE, nrows = 100)
  classes_found <- sapply(initial, class)
  read.table(filename, header = FALSE, colClasses = classes_found,
             quote = "", comment.char = "",
             row.names = NULL, stringsAsFactors = FALSE)
}
library(readr)
load_readr <- function (filename) {
     theList <- rep_len(c(16), 561)
     read_fwf(filename, fwf_widths(theList))
}
library(data.table)
load_fread_dt <- function (filename) {
   txt <- readLines(filename, n = -1)
   txt <- gsub("  ", " \\+", txt)
   txt <- paste(txt, collapse = "\n")
   fread(txt, drop = 1)
}

run_tests <- function (n=5, filepath=file) {
  print(paste("Load read.table No colClasses:", bench(n, load_table_no_col_classes, filepath)))
  print(paste("Load read.table Optimized:", bench(n, load_table, filepath)))
  print(paste("Load read_fwf (readr):", bench(n, load_readr, filepath)))
  print(paste("Load fread:", bench(n, load_fread_dt, filepath)))
}
