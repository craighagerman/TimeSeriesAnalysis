

smaPlot <- function(indata, sentType, expon, n1=7, n2=14, n3=21, n4=28, n5=60){
  indata$sma1 <- if (expon) EMA(indata[,eval(sentType)], n=n1) else SMA(indata[,eval(sentType)], n=n1)
  indata$sma2 <- if (expon) EMA(indata[,eval(sentType)], n=n2) else SMA(indata[,eval(sentType)], n=n2)
  indata$sma3 <- if (expon) EMA(indata[,eval(sentType)], n=n3) else SMA(indata[,eval(sentType)], n=n3)
  indata$sma4 <- if (expon) EMA(indata[,eval(sentType)], n=n4) else SMA(indata[,eval(sentType)], n=n4)
  indata$sma5 <- if (expon) EMA(indata[,eval(sentType)], n=n5) else SMA(indata[,eval(sentType)], n=n5)
  keeps <- c("date", sentType, "sma1", "sma2", "sma3", "sma4", "sma5")
  df <- indata[keeps]
  xt <- xts(df[,-1], order.by=df$date)
  dygraph(xt) %>%
    dySeries(sentType, drawPoints=TRUE, color="gray") %>%
    dySeries("sma1", drawPoints=FALSE, label=paste("n", n1, sep=""), color="green") %>%
    dySeries("sma2", drawPoints=FALSE, label=paste("n", n2, sep=""), color="blue") %>%
    dySeries("sma3", drawPoints=FALSE, label=paste("n", n3, sep=""), color="purple") %>%
    dySeries("sma4", drawPoints=FALSE, label=paste("n", n4, sep=""), color="red") %>%
    dySeries("sma5", drawPoints=FALSE, label=paste("n", n5, sep=""), color="gold") %>%
    dyRangeSelector()
}

