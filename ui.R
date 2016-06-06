# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/src/R/TimeSeriesAnalysis")

library(markdown)
library(shiny)
library(shinydashboard)
library(dygraphs)

shinyUI(navbarPage("Time Series",
    tabPanel("About",
             htmlOutput("aboutTS")
             ),

    
    # -----------     MOVING AVERAGES     --------------------------------------------
    tabPanel("Moving Average",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetSma", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English"), selected="ISIL English"),
                 selectInput("sentSma", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %"), selected="Net %"),
                 checkboxInput("semacheck", "Exponential"),
                 htmlOutput("aboutSma1")
               ),

               mainPanel(
                 tabsetPanel(
                   tabPanel("Interpretation", 
                            dygraphOutput("smatsplot1a"),
                            htmlOutput("aboutSma2")
                    ),
                   tabPanel("Events", 
                            dygraphOutput("smatsplot1b"),
                            textOutput("eventDivMA")
                   )
                 )
               )
             )),
    
    
    # -----------     IQR OUTLIERS     --------------------------------------------
    tabPanel("IQR Outliers",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetiqr", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English"), selected="ISIL English"),
                 selectInput("sentiqr", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %"), selected="Net %"),
                 sliderInput("iqrslider", "IQR Multiplier", 1.0, 3.0, 1.5, 0.5),
                 htmlOutput("aboutIqr1")
                 
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Interpretation", 
                            dygraphOutput("iqrtsplot1a"),
                            htmlOutput("aboutIqr2")
                            ),
                   tabPanel("Events", 
                            dygraphOutput("iqrtsplot1b"),
                            textOutput("eventDivIQR")
                            )
                   )
                 )
      )),


  # -----------     BOLLINGER BANDS     --------------------------------------------    
  tabPanel("Bollinger Bands",
         sidebarLayout(
           sidebarPanel(
             selectInput("datasetbb", "Twitter dataset:", 
                         choices = c("Trump", "ISIL Arabic", "ISIL English"), selected="ISIL English"),
             selectInput("sentbb", "Sentiment:",
                         choices = c("Total Volume", "Positive %", "Negative %", "Net %"), selected="Net %"),
             selectInput("nperiods", "Number of Periods:", choices = c("1 week", "2 weeks", "4 weeks", "3 months"), selected="2 weeks"),
             sliderInput("stddev", "Number of Standard Deviations:", min=1.0, max=3.5, value=2.0, step=0.5),
             htmlOutput("aboutbb1")
           ),
           mainPanel(
             tabsetPanel(
               tabPanel("Interpretation", 
                        dygraphOutput("BBdygraph1a"),
                        htmlOutput("aboutbb2")
               ),
               tabPanel("Events", 
                        dygraphOutput("BBdygraph1b"),
                        textOutput("eventDivBB")
               ),
               tabPanel("quantmod BB",
                        plotOutput("BBplot")
               )
             )
             )
  )),


    # -----------     MACD     --------------------------------------------
    tabPanel("MACD",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetmacd", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English"), selected="ISIL English"),
                 selectInput("sentmacd", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %"), selected="Net %"),
                 textOutput("aboutMacd1")
                 ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Interpretation", 
                            dygraphOutput("MACDdygraph1a", width = "100%", height = "100px"),
                            dygraphOutput("MACDdygraph2a"),
                            htmlOutput("aboutMacd2")),
                   tabPanel("Events", 
                            dygraphOutput("MACDdygraph1b", width = "100%", height = "100px"),
                            dygraphOutput("MACDdygraph2b"),
                            textOutput("eventDivMACD")),
                   tabPanel("Histogram Events", 
                          dygraphOutput("MACDdygraph3a"),
                          dygraphOutput("MACDdygraph3b"),
                          textOutput("eventDivMACDhistogram"))
                  )
                 )
             )),



  # -----------     RSI     --------------------------------------------
    tabPanel("RSI",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetrsi", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English"), selected="ISIL English"),
                 selectInput("sentrsi", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %"), selected="Net %"),
                 htmlOutput("aboutRsi1")
               ),
                mainPanel(
                  tabsetPanel(
                    tabPanel("Interpretation", 
                      dygraphOutput("rsitsplot1a", width = "100%", height = "100px"),
                      dygraphOutput("rsitsplot2a"),
                      htmlOutput("aboutRsi2")),
                    tabPanel("Events", 
                      dygraphOutput("rsitsplot1b", width = "100%", height = "100px"),
                      dygraphOutput("rsitsplot2b"),
                      textOutput("eventDivRSI")
                      )
                    )
                  )
             ))
             
))
