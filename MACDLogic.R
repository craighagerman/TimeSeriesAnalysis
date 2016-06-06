
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
  macdSignal <- MACD(xt, nFast=7, nSlow=28, nSig = 9, maType="EMA", percent=FALSE )
  macd.histogram <- macdSignal$macd - macdSignal$signal
  # draw plot
  dyG <- dygraph(macdSignal, main="MACD vs signal", group="macd-ts") %>%
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



# Draw a plot of the Moving Average Convergence Divergence without annotation (plotted above histogram)
macdplot_unannotated <- function(indata, sentType) {
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  # compute Moving Average Convergence Divergence
  macdSignal <- MACD(xt, nFast=7, nSlow=28, nSig = 9, maType="EMA", percent=FALSE )
  # draw plot
  dygraph(macdSignal, main="MACD vs signal", group="macd-ts") %>%
    dyRangeSelector()
  }


# Draw a plot of the Moving Average Convergence Divergence
macdhistogramplot <- function(indata, sentType) {
  # craete an event vector
  annotations <- indata$event
  # create xts object
  time <- as.POSIXct(indata$date)
  xt <- xts(x = indata[,eval(sentType)], order.by = time)
  # compute Moving Average Convergence Divergence
  macdSignal <- MACD(xt, nFast=7, nSlow=28, nSig = 9, maType="EMA", percent=FALSE )
  macd.histogram <- macdSignal$macd - macdSignal$signal
  #barplot(macd.histogram, ylim=c(-0.06, 0.06), col="gray")

  dyG <- dygraph(macd.histogram, main="MACD Histogram", group="macd-ts") %>%
    #dyOptions(colors= c('#0c93d6','#f5b800'), stackedGraph=TRUE,
    dyOptions(colors= c('gray','green'), stackedGraph=TRUE,
              plotter = 
                "function barChartPlotter(e) {
              var ctx = e.drawingContext;
              var points = e.points;
              var y_bottom = e.dygraph.toDomYCoord(0);
              
              var bar_width = 2/3 * (points[1].canvasx - points[0].canvasx);
              ctx.fillStyle = e.color;
              
              for (var i = 0; i < points.length; i++) {
              var p = points[i];
              var center_x = p.canvasx;
              
              ctx.fillRect(center_x - bar_width / 2, p.canvasy,
              bar_width, y_bottom - p.canvasy);
              ctx.strokeRect(center_x - bar_width / 2, p.canvasy,
              bar_width, y_bottom - p.canvasy);
              }
  }")
  
  dyG %>%
    dyCallbacks(
      highlightCallback = sprintf(
        'function(e, x, pts, row) {
        var customLegend = %s
        var legend = document.getElementById("eventDivMACDhistogram");
        legend.innerHTML = "<br>" + customLegend[row];  }',
        jsonlite::toJSON( annotations )
      )
    )  
}


