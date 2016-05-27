library(dygraphs)
library(TTR)
library(xts)

# 
# iqrOutlierPlot <- function(indata, sentType){
#   indata$outliers <- IQROutliers(indata[,eval(sentType)], indata$date)
#   keeps <- c("date", sentType, "outliers")
#   df <- indata[keeps]
#   xt <- xts(df[,-1], order.by=df$date)
#   dygraph(xt) %>%
#     dySeries(sentType, drawPoints=TRUE, color="gray") %>%
#     dySeries("outliers", drawPoints=TRUE, pointSize=3, strokeWidth=0, color="red") %>%
#     dyRangeSelector()
# }



rsidataplot <- function(indata, sentType) {
  keeps <- c("date", sentType)
  df <- indata[keeps]
  xt <- xts(df[,-1], order.by=df$date)
  colnames(xt) <- "observation"
  dygraph(xt, main="Observation", group="rsi-ts") 
}


rsiplot <- function(indata, sentType) {
  rsi <- RSI(indata[,eval(sentType)])
  keeps <- c("date", sentType)
  df <- indata[keeps]
  df$rsi <- rsi
  xt <- xts(df[,-1], order.by=df$date)
  dygraph(xt$rsi, main="Relative Strength Index", group="rsi-ts")  %>%
    dyAxis("y", label = "RSI", valueRange = c(10, 90))   %>%
    dyLimit(70, color="red") %>%
    dyLimit(30, color="red")

  
#   # optionally, plot with chartSeries() instead
#   chartSeries(
#     xt$netPct,
#     theme = chartTheme("white"),
#     TA = c(addBBands(),addTA(RSI(xt$netPct)))
#   )

}







