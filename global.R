
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



# ----- LOAD EVENTS -----
eventdir <- "/Users/chagerman/Data/ISIL-related-events"
#fnames <- c("2013_events.tsv", "2014_events.tsv", "2015_events.tsv", "2016_events.tsv")

df1 <- read.table(file.path(eventdir, "2013_events.tsv"), sep="\t", quote="", header=TRUE)
df2 <- read.table(file.path(eventdir, "2014_events.tsv"), sep="\t", quote="", header=TRUE)
df3 <- read.table(file.path(eventdir, "2015_events.tsv"), sep="\t", quote="", header=TRUE)
df4 <- read.table(file.path(eventdir, "2016_events.tsv"), sep="\t", quote="", header=TRUE)
df1$date <- as.Date(df1$date)
df2$date <- as.Date(df2$date)
df3$date <- as.Date(df3$date)
df4$date <- as.Date(df4$date)
eventdf <- rbind(df1, df2, df3, df4)
eventdf$event <- sapply(eventdf$event, as.character)

# add events to indata above
isilen <- as.data.frame(merge(eventdf, isilen, by="date", all.x=F, all.y=T))
isilar <- as.data.frame(merge(eventdf, isilar, by="date", all.x=F, all.y=T))
trumpdata <- as.data.frame(merge(eventdf, trumpdata, by="date", all.x=F, all.y=T))
isilen[is.na(isilen)] <- ""
isilar[is.na(isilar)] <- ""
trumpdata[is.na(trumpdata)] <- ""

