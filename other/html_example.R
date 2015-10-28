library(RCurl)

# Fetch the webpage
if (url.exists("http://steamcommunity.com")) {
  html_page <- getURL("http://steamcommunity.com/app/299660/reviews/?browsefilter=toprated&p=1#scrollTop=0")
} else {
  stop(paste("website failed to respond", 
             "or no network connection can be established.", sep = ""))
}

# Convert the webpage into a parsable HTML form
html_page <- htmlTreeParse(html_page, useInternalNode = TRUE)

# Extract the review ratings and comments
ratings <- xpathSApply(html_page, "//div [@class='title']",  xmlValue)
comments <- xpathSApply(html_page, "//div [@class='apphub_CardTextContent']",  xmlValue)
comments <- gsub("[\t\r\n]", "|", comments)
comments <- gsub("#", "", gsub("[[:alnum:]]+.*, [[:digit:]]{4}", "", gsub("[|]{2,}", "#", comments)))

# Build a data frame combining the ratings and comments
reviews <- as.data.frame(cbind(ratings, comments))
names(reviews) <- c('rating', 'comment')

# Write the extracted data to a comma-separated-values file with column headings
write.table(reviews, "reviews.csv", sep = ",", col.names = TRUE, row.names = FALSE)

# Prepare to convert the representation to XML

# Read the comma-separated-values file containing the reviews
reviews <- read.csv("reviews.csv")

# Build the XML document
xml <- xmlTree("reviews")
for (i in 1:nrow(reviews)) {
  xml$addTag("review", close=FALSE)
  for (j in names(reviews)) {
    xml$addTag(j, reviews[i, j])
  }
  xml$closeTag()
}

# Write the reviews to a file (layout: single line)
saveXML(xml, file="reviews.xml")

# Housekeeping to restructure the layout making it easy to read (layout: multi-line)
xml <- getURL("file://reviews.xml")
xml <- xmlTreeParse(xml, useInternalNodes = TRUE)
saveXML(xml, file="reviews.xml")

xml
