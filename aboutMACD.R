

macdplot1 <- function(indata, sentType) {
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  colnames(xt) <- "observation"
  # draw plot
  dygraph(xt, main="Time Series", group="macd-ts") %>%
    dySeries("observation",  color="gray") %>%
    dyRangeSelector()
}

macdplot2 <- function(indata, sentType) {
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  # compute Moving Average Convergence Divergence
  macd <- MACD(xt, nFast=7, nSlow=28, nSig = 9, maType="EMA", percent=FALSE )
  # draw plot
  dygraph(macd, main="MACD vs signal", group="macd-ts") %>%
    dyRangeSelector()
}