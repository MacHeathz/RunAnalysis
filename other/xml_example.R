library(XML)

xml <- xmlTreeParse(file = "http://clerk.house.gov/evs/2015/roll489.xml", isURL = TRUE, useInternalNodes=TRUE)
xmlroot <- xmlRoot(xml)

# Get legislator names
xpathSApply(xml, "//legislator [@name-id]", xmlValue)

# Get legislators who are Republicans
xpathSApply(xml, "//legislator [@party='R']", xmlValue)

# Get legislators who are Democrats or represent Texas
xpathSApply(xml, "//legislator [@party='D' or  @state='TX']", xmlValue)

# Get legislators who are Democrats and represent Texas
xpathSApply(xml, "//legislator [@party='D' and  @state='TX']", xmlValue)

# Get legislator names and votes
result <- getNodeSet(xmlroot, "//vote-data/recorded-vote")
sapply(result, xmlSApply, xmlValue)

# If all you want are counts use the following as an example. 
# How many legislators are there?
xmlSize(xpathSApply(xml, "//legislator", xmlValue))

# Get legislators who are Democrats, represent Texas, and voted 'yea'.
result <- getNodeSet(xmlroot, 
                     "//vote-data/recorded-vote[vote = 'Yea']/legislator [@party='D' and  @state='TX']")
sapply(result, xmlSApply, xmlValue)

# Alternate query format
result <- getNodeSet(xmlroot, 
                     "//vote-data/recorded-vote[contains(vote, 'Yea')]/legislator [@party='D' and  @state='TX']")
sapply(result, xmlSApply, xmlValue)
