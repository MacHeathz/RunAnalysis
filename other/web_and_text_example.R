# I look at the source of http://ec.europa.eu/taxation_customs/taxation/gen_info/good_governance_matters/lists_of_countries/index_en.htm to find where the javascript is
dataURL <- "http://ec.europa.eu/taxation_customs/js/blacklist.js"
dataCode <- readLines(dataURL)
blklstart <- grep("var blacklisting ", dataCode)
blklend <- grep("};", dataCode[blklstart:length(dataCode)])[1] + blklstart -1
blackblock <- dataCode[(blklstart+1):(blklend-1)]
blackblock <- gsub('"',"",blackblock)

makeItBetter <- function(x){
    bits <- strsplit(x, split=":")
    accuser <- trimws(bits[[1]][1])
    accused <- unlist((strsplit(bits[[1]][2], split=",")))
    accused <- gsub("\\[","",accused)
    accused <- gsub("\\]","",accused)
    accused <- na.omit(accused)
    return(data.frame(accused=accused, accuser=rep(accuser, times=length(accused))))
}

taxhavenList <- lapply(blackblock, makeItBetter)
taxhavenDF <- do.call(rbind,taxhavenList)
havenrating <- aggregate(accuser ~ accused, taxhavenDF, length)
