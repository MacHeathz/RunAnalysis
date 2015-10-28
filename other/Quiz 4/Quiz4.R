library(readr)
library(data.table)
data <- fread('getdata-data-ss06hid.csv')

# Question 1. Apply strsplit() to split all the names of the data
# frame on the characters "wgtp". What is the value of the 123
# element of the resulting list?
split <- strsplit(names(data), split = "wgtp")
split[[123]] # "" "15

# Question 2. Remove the commas from the GDP numbers in millions of dollars
# and average them. What is the average? 
gdp <- read_csv('getdata-data-GDP.csv',
                skip = 5, n_max = 190,
                col_types = "ci_cc_____", # The 5th column (USD) can be correctly converted using i here, but we do it like this for the assignment's sake.
                col_names = FALSE)

mean(as.numeric(gsub(",", "", gdp$X5)))

# Question 3. In the data set from Question 2 what is a regular expression that would
# allow you to count the number of countries whose name begins with "United"? Assume
# that the variable with the country names in it is named countryNames. How many
# countries begin with United?
countryNames <- gdp$X4
length(grep("^United", countryNames)) # 3

# Question 4. Match the data based on the country shortcode. Of the countries
# for which the end of the fiscal year is available, how many end in June? 
names(gdp) <- c("CountryCode", "Ranking", "Economy", "GDP in USD")
edu <- read.csv("getdata-data-EDSTATS_Country.csv")
merged <- merge(gdp, edu, by = "CountryCode")
notes <- merged$Special.Notes
sum(grepl(ignore.case = TRUE, x = notes, pattern = "Fiscal year end: June")) # 13

# Question 5. You can use the quantmod (http://www.quantmod.com/) package to
# get historical stock prices for publicly traded companies on the NASDAQ
# and NYSE. Use the following code to download data on Amazon's stock price
# and get the times the data was sampled. How many values were collected
# in 2012? How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
sampleDates <- ymd(sampleTimes)
sum(year(dates) == 2012) # 250
sum(sapply(dates, function(d){
    year(d) == 2012 && wday(d, label = TRUE) == "Mon"
})) # 47