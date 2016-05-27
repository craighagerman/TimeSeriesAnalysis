# runApp("/Users/chagerman/Projects/TimeSeriesAnalysis/src/R/TimeSeriesAnalysis")

library(markdown)
library(shiny)
library(dygraphs)

shinyUI(navbarPage("Time Series",
    tabPanel("About"),

    tabPanel("IQR Outliers",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetiqr", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentiqr", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
                 sliderInput("iqr", "IQR Multiplier", 1.0, 3.0, 1.5, 0.5)
                 #htmlOutput("x_value")
                 
               ),
               
               mainPanel(
                 dygraphOutput("iqrtsplot")
               )
      )),

tabPanel("Bollinger Bands",
         sidebarLayout(
           sidebarPanel(
             selectInput("datasetbb", "Twitter dataset:", 
                         choices = c("Trump", "ISIL Arabic", "ISIL English")),
             selectInput("sentbb", "Sentiment:",
                         choices = c("Total Volume", "Positive %", "Negative %", "Net %")),
             selectInput("nperiods", "Number of Periods:", choices = c("1 week", "2 weeks", "4 weeks", "3 months")),
             sliderInput("stddev", "Number of Standard Deviations:", min=1.0, max=3.5, value=2.0, step=0.5)
           ),
           
           mainPanel(
             dygraphOutput("BBdygraph"),
             plotOutput("BBplot")
           )
         )),


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
                 dygraphOutput("MACDdygraph1", width = "100%", height = "100px"),
                 htmlOutput("space"),
                 dygraphOutput("MACDdygraph2"),
                 #htmlOutput("space"),
                 htmlOutput("aboutMacd2")
               )
             )),



    tabPanel("RSI",
             sidebarLayout(
               sidebarPanel(
                 selectInput("datasetrsi", "Twitter dataset:", 
                             choices = c("Trump", "ISIL Arabic", "ISIL English")),
                 selectInput("sentrsi", "Sentiment:",
                             choices = c("Total Volume", "Positive %", "Negative %", "Net %"))
               ),
               
               mainPanel(
                 dygraphOutput("rsitsplot1", width = "100%", height = "100px"),
                 dygraphOutput("rsitsplot2")
               )
             ))
             
))
