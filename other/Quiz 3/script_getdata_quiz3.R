# Question 1.
library(downloader)
library(data.table)
filename <- '06hid.csv'
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", '06hid.csv')
housing <- fread(filename)

# Logical vector:
# agricultureLogical <- (households on > 10 acres who sold > 10000 worth of agricultural products)
# Then use which() to get households where this is TRUE
agricultureLogical <- housing$AGS == 6 & housing$ACR ==3
which(agricultureLogical)  # 1st three values are: 125, 238, 262

# Alternative (using data.table, way fast)
result_dt <- housing[AGS == 6 & ACR == 3, ]


# Question 2
library(jpeg)
jeff <- "jeff.jpg"
download("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", jeff)
pic <- jpeg::readJPEG(jeff, native = TRUE)
quantile(pic, probs = c(0.3, 0.8)) # -15258512 -10575416
# Check 30% quantile (is off by 638 on Linux systems):
-15258512 - 638 # -15259150

if(exists("rasterImage")) {
  plot(1:2, type="n")
  rasterImage(pic, 1.0, 1.27, 1.8, 2.0)
}

# Question 3. Compare GDP and EDU data from countries
# Match the data based on the country shortcode. How many of the IDs match?
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame? 
gdp_file <- "FGDP.csv"
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", gdp_file)

# Skip first three lines, select only columns that matter, read only rows that contain data.
DT_G <- fread(gdp_file, skip = 3, sep = ",", select = c(1, 2, 4, 5),
                      nrows = 192,
                      verbose = TRUE, showProgress = TRUE)[2:191]

n <- gsub(" ", "_", names(DT_G))
n <- gsub("\\)", "", n)
n[1] <- "CountryCode"
setNames(DT_G, n)

# Set GDP and GDP rank to numeric
DT_G[, US_dollars := vapply(X = DT_G[, US_dollars],
                    FUN = function(val) {as.numeric(gsub(",", "", val))},
                    FUN.VALUE = numeric(1))]
DT_G[, Ranking := as.numeric(Ranking)]

edu_file <- "edstats.csv"
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", edu_file)
DT_E <- fread(edu_file, sep = ",", verbose = TRUE, showProgress = TRUE)
n <- gsub(" ", "", names(DT_E))
setNames(DT_E, n)

setkey(DT_G, CountryCode)
setkey(DT_E, CountryCode)

# inner join is somewhat difficult on data.table. First determine the intersect of their keys
# then do two joins. Alternative that's identical and much shorter: DT <- merge(DT_G, DT_E)
is <- intersect(DT_G[, CountryCode], DT_E[, CountryCode])
DT_Es <- DT_E[is,]
DT <- DT_G[DT_Es]

setkey(DT, Ranking, IncomeGroup)
setorder(DT, -Ranking)

print(paste("Matches", nrow(DT), "countries."))
print(paste("13th country:", DT[13, LongName])) # St. Kitts and Nevis

# Question 4: What is the average GDP ranking for the "High income: OECD" and
# "High income: nonOECD" group?
setorder(DT, Ranking)
DT[, mean(Ranking), by = IncomeGroup] # 32.96667 91.91304

# Question 5: Cut the GDP ranking into 5 separate quantile groups. Make a table
# versus Income.Group. How many countries are Lower middle income but among the
# 38 nations with highest GDP?

# Option 1. Direct & verbose answer, in the spirit of Jeff's video lectures
table(DT$IncomeGroup, cut(DT$Ranking,
                          breaks=quantile(DT$Ranking,
                          probs=seq(0, 1, length=6))))

# Option 2, using Hmisc package. Like Jeff showed too.
library(Hmisc)
table(DT$IncomeGroup, cut2(DT$Ranking, g=5))
DT[, Qrank_Hmisc:=cut2(DT$Ranking, g=5)]

# Option 3, using data.table
QDT_top38 <- DT[, Qrank:=findInterval(Ranking, quantile(Ranking, seq(0,1,length=6)))][1:38]
Answer <- QDT_top38[IncomeGroup == "Lower middle income" & Qrank == 1,
                  .(LongName, Qrank, US_dollars, IncomeGroup)]

# Or (what was asked):
DC <-cut(DT[, Ranking], quantile(DT[, Ranking], c(0.2, 0.4, 0.6, 0.8, 1)))
table(QDT_top38[, IncomeGroup], QDT_top38[, Qrank])

print(paste("The number of countries with lower income but among top 38 GDP nations is:", nrow(Answer)))
