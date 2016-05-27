# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/Rexploration/timeseries")

# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/Rexploration/BollingerApp")

library(dygraphs)
library(datasets)
library(TTR)
library(xts)
source("BollingerLogic.R")
source("MACDLogic.R")
source("IQROutlierLogic.R")
source("RSILogic.R")


# isOutlier <- function(o, u, d) {
#   if (is.na(u) | is.na(d)) return (FALSE)
#   if ((o > u) | (o < d)) return (TRUE)
#   else return (FALSE)
# }

shinyServer(function(input, output) {
  # REACTIVE INPUT ------------------
  datasetInput <- reactive({
    switch(input$dataset,
           "Trump" = trumpdata,
           "ISIL Arabic" = isilar,
           "ISIL English" = isilen)
  })
  sentInput <- reactive({
    switch(input$sent,
           "Total Volume" = "total",
           "Positive %" = "posPct", 
           "Negative %" = "negPct", 
           "Net %" = "netPct")
  })
  periodInput <- reactive({
    switch(input$nperiods,
           "1 week" = 7,
           "2 weeks" = 14, 
           "4 weeks" = 28, 
           "3 months" = 84)
  })
  

  
  

  
  
    
  
  # REACTIVE OUTPUT -----------------
  output$space <- renderUI({
    div(HTML("<br>&nbsp<br>&nbsp<br>"))
  })
  
  # Bollinger Bands App  ----------------------------------------------------------
  datasetInputbb <- reactive({
    switch(input$datasetbb,
           "Trump" = trumpdata,
           "ISIL Arabic" = isilar,
           "ISIL English" = isilen)
  })
  sentInputbb <- reactive({
    switch(input$sentbb,
           "Total Volume" = "total",
           "Positive %" = "posPct", 
           "Negative %" = "negPct", 
           "Net %" = "netPct")
  })
  output$BBdygraph <- renderDygraph({
    indata <- datasetInputbb()
    sentType <- sentInputbb()
    nperiods <- periodInput()
    bollingerplot(indata, sentType, nperiods, input$stddev, indata$date )
  })
  output$BBplot <- renderPlot({
    indata <- datasetInputbb()
    sentType <- sentInputbb()
    nperiods <- periodInput()
    bollingerchart(indata, sentType, nperiods, input$stddev)
  })
  
  
  # MACD vs Signal App  ----------------------------------------------------------
  datasetInputmacd <- reactive({
    switch(input$datasetmacd,
           "Trump" = trumpdata,
           "ISIL Arabic" = isilar,
           "ISIL English" = isilen)
  })
  sentInputmacd <- reactive({
    switch(input$sentmacd,
           "Total Volume" = "total",
           "Positive %" = "posPct", 
           "Negative %" = "negPct", 
           "Net %" = "netPct")
  })
    output$MACDdygraph1 <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot1(indata, sentType)
  })
  output$MACDdygraph2 <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot2(indata, sentType)
  })
  output$aboutMacd1 <- renderText({
    'Moving average convergence divergence (MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of prices."
      (Investopedia) A nine-day EMA of the MACD (called the signal line) is plotted on top of the MACD. The crossover of the two functions as a trigger for
    buy and sell signals.'
  })
  output$aboutMacd2 <- renderUI({
    h <-  '<h2>Interpreting MACD</h2>'
    interpretation1 <- '<p><b>Crossover</b> - When MACD falls below the signal line it is a bearish signal (sell). When MACD rises
      above the signal line it is a bullish signal (buy)'
    interpretation2 <- '<p><b>Divergence</b> - When the observation diverges from the MACD it signals the end 
      of the current trend.</p>'
    interpretation3 <- '<p><b>Dramatic Rise</b> - When the MACD rises dramatically (i.e. the shorter MA 
      pulls away from the longer MA) it signals the security is overbought and will soon return to normal levels</p>'
    interpretation4 <- '<p><b>Zero line movement</b> - When the MACD is above zero the short term average is above 
      the long term average, signalling upward momentum. (and vice versa) </p>'
    
    div(HTML(paste(h, interpretation1, interpretation2, interpretation3, interpretation4)))
  })

  
  
  
  
  
  
  
  # IQR Outliers  ----------------------------------------------------------------
  datasetInputiqr <- reactive({
    switch(input$datasetiqr,
           "Trump" = trumpdata,
           "ISIL Arabic" = isilar,
           "ISIL English" = isilen)
  })
  sentInputiqr <- reactive({
    switch(input$sentiqr,
           "Total Volume" = "total",
           "Positive %" = "posPct", 
           "Negative %" = "negPct", 
           "Net %" = "netPct")
  })
    output$iqrtsplot <- renderDygraph({
    indata <- datasetInputiqr()
    sentType <- sentInputiqr()
    iqrOutlierPlot(indata, sentType)
  })
  
  
  
  
   
  # RSI plot ---------------------------------------------------------------------
    datasetInputrsi <- reactive({
      switch(input$datasetrsi,
             "Trump" = trumpdata,
             "ISIL Arabic" = isilar,
             "ISIL English" = isilen)
    })
    sentInputrsi <- reactive({
      switch(input$sentrsi,
             "Total Volume" = "total",
             "Positive %" = "posPct", 
             "Negative %" = "negPct", 
             "Net %" = "netPct")
    })
  output$rsitsplot1 <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsidataplot(indata, sentType)
  })

  output$rsitsplot2 <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsiplot(indata, sentType)
  })
  
  
  
})







