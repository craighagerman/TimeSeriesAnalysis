library(dygraphs)
library(TTR)
library(xts)


# rsidataplot <- function(indata, sentType) {
#   keeps <- c("date", sentType)
#   df <- indata[keeps]
#   xt <- xts(df[,-1], order.by=df$date)
#   colnames(xt) <- "observation"
#   dygraph(xt, main="Observation", group="rsi-ts") 
# }


rsiplot <- function(indata, sentType) {
  # create an event vector
  annotations <- indata$event
  rsi <- RSI(indata[,eval(sentType)])
  keeps <- c("date", sentType)
  df <- indata[keeps]
  df$rsi <- rsi
  xt <- xts(df[,-1], order.by=df$date)
  dyG <- dygraph(xt$rsi, main="Relative Strength Index", group="rsi-ts")  %>%
    dyAxis("y", label = "RSI", valueRange = c(10, 90))   %>%
    dyLimit(70, color="red") %>%
    dyLimit(30, color="red")

  dyG %>%
    dyCallbacks(
      highlightCallback = sprintf(
        'function(e, x, pts, row) {
        var customLegend = %s
        var legend = document.getElementById("eventDivRSI");
        legend.innerHTML = "<br>" + customLegend[row];  }',
        jsonlite::toJSON( annotations )
      )
    )  
}


