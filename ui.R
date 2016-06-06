# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/src/R/TimeSeriesAnalysis")

library(markdown)
library(shiny)
library(shinydashboard)
library(dygraphs)

shinyUI(navbarPage("Time Series",
    tabPanel("About",
             htmlOutput("aboutTS")
             ),

    
    # -----------     MOVING AVERAGES     -----------
    tabPanel("Moving Average",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetSma", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentSma", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
                 checkboxInput("semacheck", "Exponential"),
                 htmlOutput("aboutSma1"),
                 htmlOutput("aboutSma2")
               ),
               mainPanel(
                 dygraphOutput("smatsplot"),
                 #htmlOutput("aboutSma2")
                 textOutput("eventDivMA")
               )
             )),


    
    
    # -----------     IQR OUTLIERS     -----------
    tabPanel("IQR Outliers",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetiqr", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentiqr", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
                 sliderInput("iqrslider", "IQR Multiplier", 1.0, 3.0, 1.5, 0.5),
                 htmlOutput("aboutIqr1")
                 
               ),
# 
#                mainPanel(
#                 dygraphOutput("iqrtsplot"),
#                 htmlOutput("aboutIqr2")
#                )               
               
               mainPanel(
                 fluidRow(
                    box(dygraphOutput("iqrtsplot"), width=9),
                    box(textOutput("eventDivID"), title = "Events", collapsible = TRUE, width=3)
                 
                 ),
                 htmlOutput("aboutIqr2")
               )


      )),





  # -----------     BOLLINGER BANDS     -----------    
  tabPanel("Bollinger Bands",
         sidebarLayout(
           sidebarPanel(
             selectInput("datasetbb", "Twitter dataset:", 
                         choices = c("Trump", "ISIL Arabic", "ISIL English")),
             selectInput("sentbb", "Sentiment:",
                         choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
             selectInput("nperiods", "Number of Periods:", choices = c("1 week", "2 weeks", "4 weeks", "3 months")),
             sliderInput("stddev", "Number of Standard Deviations:", min=1.0, max=3.5, value=2.0, step=0.5),
             htmlOutput("aboutbb1")
           ),
           mainPanel(
             dygraphOutput("BBdygraph"),
             plotOutput("BBplot"),
             htmlOutput("aboutbb2")
           )
         )),





    # -----------     MACD     ----------- 
    tabPanel("MACD",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetmacd", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentmacd", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
                 textOutput("aboutMacd1")
                 ),
               mainPanel(
                 tabsetPanel(type="pills",
                   tabPanel("Interpretation", 
                            dygraphOutput("MACDdygraph1a", width = "100%", height = "100px"),
                            dygraphOutput("MACDdygraph2a"),
                            htmlOutput("aboutMacd2")),
                   tabPanel("Isil Events", 
                            dygraphOutput("MACDdygraph1b", width = "100%", height = "100px"),
                            dygraphOutput("MACDdygraph2b"),
                            textOutput("eventDivMACD"))
                 )
               )
             )),



  # -----------     RSI     -----------
    tabPanel("RSI",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetrsi", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentrsi", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
                 htmlOutput("aboutRsi1")
               ),
               
#                mainPanel(
#                  dygraphOutput("rsitsplot1", width = "100%", height = "100px"),
#                  dygraphOutput("rsitsplot2"),
#                  textOutput("eventDivRSI")
#                  #htmlOutput("aboutRsi2")
#                )

                mainPanel(
                  tabsetPanel(
                    tabPanel("XYZ", 
                      dygraphOutput("rsitsplot1a", width = "100%", height = "100px"),
                      dygraphOutput("rsitsplot2a"),
                      htmlOutput("aboutRsi2")),
                    tabPanel("Zzzz", 
                      dygraphOutput("rsitsplot1b", width = "100%", height = "100px"),
                      dygraphOutput("rsitsplot2b"),
                      textOutput("eventDivRSI")
                      )
                    )
                  )
             ))
             
))
