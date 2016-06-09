
# Demo of event annotation - plot total negative, & positive tweet with event annotation overlaid

sentimentPlot <- function(indata){
  annotations <- indata$event
  indata$negativeMinus <-  0 - indata$negative
  keeps <- c("date", "negativeMinus", "positive")
  df <- indata[keeps]
  xt <- xts(df[,-1], order.by=df$date)

  dyG <- dygraph(xt) %>%
    dySeries("negativeMinus", drawPoints=FALSE, fillGraph=TRUE, color="hotpink", strokeWidth=1) %>%
    dySeries("positive", drawPoints=FALSE, fillGraph=TRUE, color="green",  strokeWidth=1) %>%    
    dyRangeSelector()
  
  dyG %>%
    dyCallbacks(
      highlightCallback = sprintf(
        'function(e, x, pts, row) {
        var customLegend = %s
        var legend = document.getElementById("eventDivSentiment");
        legend.innerHTML = "<br>" + customLegend[row];  }',
        jsonlite::toJSON( annotations )
      )
    ) 
}
