
# SET UP PATHS
parent <- dirname(getwd())
datadir <- file.path(parent, "twitterData")

# READ IN DATA
isilen <- read.table(file.path(datadir, "isilKeywordSent_en2.txt"), header=TRUE)
isilar <- read.table(file.path(datadir, "isilKeywordSent_ar2.txt"), header=TRUE)
trumpdata <- read.table(file.path(datadir, "trumpSent2.tsv"), header=TRUE)
# convert string dates to R date objects
isilen$date <- as.Date(isilen$date)
isilar$date <- as.Date(isilar$date)
trumpdata$date <- as.Date(trumpdata$date)
