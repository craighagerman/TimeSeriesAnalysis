
# TO DO - add in a MACD hisotram

# Display the original TS observation
macdplot1 <- function(indata, sentType) {
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  colnames(xt) <- "observation"
  # draw plot
  dygraph(xt, main="Time Series", group="macd-ts") %>%
    dySeries("observation",  color="gray")
}

# Draw a plot of the Moving Average Convergence Divergence
macdplot2 <- function(indata, sentType) {
  # craete an event vector
  annotations <- indata$event
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  # compute Moving Average Convergence Divergence
  macd <- MACD(xt, nFast=7, nSlow=28, nSig = 9, maType="EMA", percent=FALSE )
  # draw plot
  dyG <- dygraph(macd, main="MACD vs signal", group="macd-ts") %>%
    dyRangeSelector()
  
  dyG %>%
    dyCallbacks(
      highlightCallback = sprintf(
        'function(e, x, pts, row) {
        var customLegend = %s
        var legend = document.getElementById("eventDivMACD");
        legend.innerHTML = "<br>" + customLegend[row];  }',
        jsonlite::toJSON( annotations )
      )
    )  
  
  }