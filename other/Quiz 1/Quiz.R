## Question 1: how many properties are worth > 1 mln dollars? (column: VAL)
dat1 <- read.csv('getdata_data_ss06hid.csv')
nrow(dat1[which(dat1$VAL >= 24), ]) ## 53

## Question 2: FES variable in dat1 is not tidy data since it has multiple
## variables in one column

## Question 3: 
## Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
##  dat 
## What is the value of:
##  sum(dat$Zip*dat$Ext,na.rm=T) 
library(xlsx)
dat <- read.xlsx('getdata_data_DATA.gov_NGAP.xlsx', sheetIndex=1, rowIndex=18:23, colIndex=7:15)
sum(dat$zip*dat$Ext,na.rm=T) ## 36534720

## Question 4: how many restaurants have zipcode 21231?
library(XML)
dat2 <- XML::xmlTreeParse('getdata_data_restaurants.xml')
root <- XML::xmlRoot(dat2)
zips <- XML::getNodeSet(root, "//zipcode[text()=21231]")
XML::xmlSize(zips) ## 127

## Question 5: What is the fastest way to calculate mean of variable pwgtp15,
## grouped by sex?
library(data.table)
DT <- fread('getdata_data_ss06pid.csv')
DT[,mean(pwgtp15),by=SEX] ## <- answer
