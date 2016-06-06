# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/src/R/TimeSeriesAnalysis")



library(dygraphs)
library(datasets)
library(TTR)
library(xts)
source("BollingerLogic.R")
source("MACDLogic.R")
source("IQROutlierLogic.R")
source("RSILogic.R")
source("SMA.R")
source("aboutTA.R")




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
  

  
  # ==========     REACTIVE OUTPUT     ==========
  output$space <- renderUI({
    div(HTML("<br>&nbsp<br>&nbsp<br>"))
  })
  output$aboutTS <- renderUI({
    div(HTML(ts_def))
  })
  

  
  
  # -----------     MOVING AVERAGES     --------------------------------------------
  datasetInputSma <- reactive({
    switch(input$datasetSma,
           "Trump" = trumpdata,
           "ISIL Arabic" = isilar,
           "ISIL English" = isilen)
  })
  sentInputSma <- reactive({
    switch(input$sentSma,
           "Total Volume" = "total",
           "Positive %" = "posPct", 
           "Negative %" = "negPct", 
           "Net %" = "netPct")
  })

  output$smatsplot1a <- renderDygraph({
    indata <- datasetInputSma()
    sentType <- sentInputSma()
    smaPlot(indata, sentType, input$semacheck)
  })
  output$smatsplot1b <- renderDygraph({
    indata <- datasetInputSma()
    sentType <- sentInputSma()
    smaPlot(indata, sentType, input$semacheck)
  })
  output$aboutSma1 <- renderUI({
    div(HTML(sma_def))
  })
  output$aboutSma2 <- renderUI({
    div(HTML(sma_inter))
  })
  
  
  # -----------     IQR OUTLIERS     --------------------------------------------
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
  
  output$iqrtsplot1a <- renderDygraph({
    indata <- datasetInputiqr()
    sentType <- sentInputiqr()
    iqrOutlierPlot(indata, sentType, input$iqrslider)
  })
  output$iqrtsplot1b <- renderDygraph({
    indata <- datasetInputiqr()
    sentType <- sentInputiqr()
    iqrOutlierPlot(indata, sentType, input$iqrslider)
  })
  
  output$aboutIqr1 <- renderUI({
    div(HTML(iqr_def))
  })
  output$aboutIqr2 <- renderUI({
    div(HTML(iqr_inter))
  })
  
  

  # -----------     BOLLINGER BANDS     --------------------------------------------
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

  output$BBdygraph1a <- renderDygraph({
    indata <- datasetInputbb()
    sentType <- sentInputbb()
    nperiods <- periodInput()
    bollingerplot(indata, sentType, nperiods, input$stddev, indata$date )
  })
  output$BBdygraph1b <- renderDygraph({
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
  output$aboutbb1 <- renderUI({
    div(HTML(bb_def))
  })
  output$aboutbb2 <- renderUI({
    div(HTML(bb_inter))
  })
  
  
  
  # -----------     MACD     --------------------------------------------
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
    output$MACDdygraph1a <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot1(indata, sentType)
  })
  output$MACDdygraph2a <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot2(indata, sentType)
  })
  output$MACDdygraph1b <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot1(indata, sentType)
  })
  output$MACDdygraph2b <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot2(indata, sentType)
  })
  output$MACDdygraph3a <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdplot_unannotated(indata, sentType)
  })
  output$MACDdygraph3b <- renderDygraph({
    indata <- datasetInputmacd()
    sentType <- sentInputmacd()
    macdhistogramplot(indata, sentType)
  })
  

  
  
  
  
  output$aboutMacd1 <- renderText({
    'Moving average convergence divergence (MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of prices."
      (Investopedia) A nine-day EMA of the MACD (called the signal line) is plotted on top of the MACD. The crossover of the two functions as a trigger for
    buy and sell signals. '
  })

  output$aboutMacd1 <- renderText({
    macd_def
  })
  
  output$aboutMacd2 <- renderUI({
    div(HTML(macd_inter))
  })
  
  output$eventDivMACDhistogram <- renderText({
    "one 
    two 
    three 
    four"
  })
  
  
   
   
  # -----------     RSI     --------------------------------------------
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
    
  output$rsitsplot1a <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsidataplot(indata, sentType)
  })

  output$rsitsplot2a <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsiplot(indata, sentType)
  })
  output$rsitsplot1b <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsidataplot(indata, sentType)
  })
  
  output$rsitsplot2b <- renderDygraph({
    indata <- datasetInputrsi()
    sentType <- sentInputrsi()
    rsiplot(indata, sentType)
  })
  output$aboutRsi1 <- renderUI({
    div(HTML(rsi_def))
  })
  output$aboutRsi2 <- renderUI({
    div(HTML(rsi_inter))
  })
  

  
  
  
  
})







