library(httr)
library(httpuv)
library(jsonlite)

## Question 1

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
myapp <- oauth_app("github", 
                   key = "9bbbb0e797c2dbd42ebc",
                   secret = "8278611527f8a6b7b6a17cf427bb6b890da8754b")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

# all jeffs repos
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

# get content
jeffs_repos <- content(req)

# tidy content using json casting magic
jeffs_repos <- fromJSON(toJSON(jeffs_repos))

datasharing_repo <- jeffs_repos[which(jeffs_repos$name == "datasharing"), ]
print(datasharing_repo$created_at)

## Question 2
library(sqldf)

acs <- read.csv('getdata_data_ss06pid.csv')
head(sqldf("select pwgtp1 from acs where AGEP < 50"))

## Question 3
sort(unique(acs$AGEP))
sqldf("select DISTINCT AGEP from acs")

## Question 4
leek_webpage <- "http://biostat.jhsph.edu/~jleek/contact.html"
con = url(leek_webpage)
htmlCode = readLines(con)
close(con)

print(paste(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100])))

## Question 5
flo <- read.fwf("getdata_wksst8110.for",
        widths = c(-1, 9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
        skip = 4,
        colClasses = c("character", "numeric",
                       "numeric", "numeric",
                       "numeric", "numeric",
                       "numeric", "numeric",
                       "numeric")
        )

sum(flo[4])
