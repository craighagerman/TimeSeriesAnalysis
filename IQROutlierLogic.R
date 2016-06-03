
# the following is Rob Hyndman's 'tsoutliers' code (refactored)
IQROutliers <- function(x, odates, multiplier=1.5) {
  x <- as.ts(x)
  if(frequency(x)>1)
    resid <- stl(x,s.window="periodic",robust=TRUE)$time.series[,3]
  else {
    tt <- 1:length(x)
    resid <- residuals(loess(x ~ tt))
  }
  resid.q <- quantile(resid,prob=c(0.25,0.75))
  iqr <- diff(resid.q)
  limits <- resid.q + multiplier*iqr*c(-1,1)
  # compute 'score' - the number of IQRs above/below the multiplier threshold
  score <- abs(pmin((resid-limits[1])/iqr,0) + pmax((resid - limits[2])/iqr,0))
  # identify which data points in original data were identified as outliers
  outlierPoints <- ts(rep(NA,length(x)))
  outlierPoints[score>0] <- x[score>0]
  tsp(outlierPoints) <- tsp(x)
  return (outlierPoints)    
}


createXtsObject <- function(x, dates) {
  time <- as.POSIXct(dates)
  xt <- xts(x, order.by = time)
  return (xt)
}


iqrOutlierPlot <- function(indata, sentType, sliderVal){
  indata$outliers <- IQROutliers(indata[,eval(sentType)], indata$date, sliderVal)
  annotations <- indata$event
  #keeps <- c("date", sentType, "outliers")
  keeps <- c("date", sentType, "outliers", "event")
  df <- indata[keeps]
  xt <- xts(df[,-1], order.by=df$date)
  dyG <- dygraph(xt) %>%
    dySeries(sentType, drawPoints=TRUE, color="gray") %>%
    dySeries("outliers", drawPoints=TRUE, pointSize=3, strokeWidth=0, color="red") %>%
    dySeries("event", drawPoints=FALSE, strokeWidth=0 ) %>%
    dyLegend(labelsDiv = "eventDivID") %>%
    dyRangeSelector()  
    

  # working/good with default label and external div label
  dyG %>%
    dyCallbacks(
      highlightCallback = sprintf(
        'function(e, x, pts, row) {
          var customLegend = %s
          var legendel = document.getElementById("eventDivID");
          legendel.innerHTML = legendel.innerHTML + "<br>" + customLegend[row]; 
        }',
        jsonlite::toJSON( annotations )
      )
    )  
}



