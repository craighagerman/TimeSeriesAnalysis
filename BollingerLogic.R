
library(quantmod)
library(TTR)
library(xts)

isOutlier <- function(o, u, d) {
  if (is.na(u) | is.na(d)) return (FALSE)
  if ((o > u) | (o < d)) return (TRUE)
  else return (FALSE)
}

bollingerplot <- function(indata, sentType, nperiods, stddev, dateCol ) { 
    bb20 = as.data.frame(BBands(indata[,eval(sentType)], n=nperiods, sd=stddev))
    bb20$date <- dateCol
    bb20[,eval(sentType)] <- indata[,eval(sentType)]
    keeps <- c("date", sentType, "dn", "mavg", "up")
    df <- bb20[keeps]
    # add a new df column for outliers
    df$outliers <- apply(df[, c(sentType, 'up', 'dn')], 1, function(x) { if (isOutlier(x[1], x[2], x[3])) x[1] else NA } )
    # convert to xts for input to dygraph
    df <- xts(df[,-1], order.by=df[,1])
    index(df) <- index(df) - 0
    
    dygraph(df, main = paste("Bollinger Bands:" , sentType, "(", nperiods, "days )")) %>%
      dySeries(sentType, drawPoints=TRUE, color="gray") %>%
      dySeries("dn", drawPoints=FALSE, color="lightpink") %>%
      dySeries("up", drawPoints=FALSE, color="lightpink") %>%
      dySeries("mavg", drawPoints=FALSE, color="blue") %>%
      dySeries("outliers", drawPoints=TRUE, pointSize=3, strokeWidth=0, color="red") %>%
      dyRangeSelector()  
}

bollingerchart <- function(indata, sentType, nperiods, stddev) { 
  keeps <- c("date", sentType)
  df <- indata[keeps]
  myxt <- xts(df[,-1], order.by=df$date)
  chartSeries(
      myxt,
      name = paste("Basic Bollinger Bands", "20/2"),
      theme = chartTheme("white"),
      #TA = c(addBBands(),addTA(RSI(myxt)))
      TA = c(addBBands())
    )
}



