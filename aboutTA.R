# 
# #
# # ---------- MACD ------------------------------------------------------------
# #
# output$aboutSma1 <- renderText({
#   'Moving average convergence divergence (MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of prices."
#   (Investopedia) A nine-day EMA of the MACD (called the signal line) is plotted on top of the MACD. The crossover of the two functions as a trigger for
#   buy and sell signals.'
# })
# output$aboutSma2 <- renderUI({
#   h <-  '<h2>Interpreting MACD</h2>'
#   interpretation1 <- '<p><b>Crossover</b> - When MACD falls below the signal line it is a bearish signal (sell). When MACD rises
#   above the signal line it is a bullish signal (buy)'
#   interpretation2 <- '<p><b>Divergence</b> - When the observation diverges from the MACD it signals the end 
#   of the current trend.</p>'
#   interpretation3 <- '<p><b>Dramatic Rise</b> - When the MACD rises dramatically (i.e. the shorter MA 
#   pulls away from the longer MA) it signals the security is overbought and will soon return to normal levels</p>'
#   interpretation4 <- '<p><b>Zero line movement</b> - When the MACD is above zero the short term average is above 
#   the long term average, signalling upward momentum. (and vice versa) </p>'
#   div(HTML(paste(h, interpretation1, interpretation2, interpretation3, interpretation4)))
# })
# 
# 




#
# ---------- MACD ------------------------------------------------------------
#
macd_def <- 'Moving average convergence divergence (MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of prices."
  (Investopedia) A nine-day EMA of the MACD (called the signal line) is plotted on top of the MACD. The crossover of the two functions as a trigger for
  buy and sell signals.'

macd_inter <- '<h2>Interpreting MACD</h2>
  <p><b>Crossover</b> - When MACD falls below the signal line it is a bearish signal (sell). When MACD rises
  above the signal line it is a bullish signal (buy)</p>
  <p><b>Divergence</b> - When the observation diverges from the MACD it signals the end 
  of the current trend.</p>
  <p><b>Dramatic Rise</b> - When the MACD rises dramatically (i.e. the shorter MA 
  pulls away from the longer MA) it signals the security is overbought and will soon return to normal levels</p>
  <p><b>Zero line movement</b> - When the MACD is above zero the short term average is above 
  the long term average, signalling upward momentum. (and vice versa) </p>'



#
# ---------- SMA ------------------------------------------------------------
#
sma_def <- '<p><u>Simple Moving Average</u></p>
  <p> The average value over a sliding window of time. Short-term moving averages respond quickly to changes while longer-term moving averages are slow to react. The crossover points of two such moving average lines are trend and momentum indicators. </p>
  <p><u>Exponential Moving Average</u></p>
  <p>Similar to a simple moving average except more weight is given to recent data.'

sma_inter <- '<p><u>asset-MA-crossover</u></p>
  <p>Plot a single MA line against the underlying pattern.</p>
  <p><b>cross below a MA line</b> - beginning of a downward trend.</p>
  <p><b>cross above a MA line</b> - beginning of an upward trend.</p>

  <p><u>MA-MA-crossover</u></p>
  <p>Plot two MA lines against the underlying pattern; one short term, one long term. In finance 50/100 or 50/200 is common, but some people use short periods such as 10/20 or 15/30.</p>
  <p><b>short crosses long MA from below</b> - a buy signal; upward trend reversal</p>
  <p><b>short above long MA</b> - upward trend signal; keep in</p>
  <p><b>short crosses long MA from above</b> - a sell signal, downward trend reversal</p>
  <p><b>long above short</b> - bearish signal; stay out of the market</p>

  <p><u>triple-crossover or MA-ribbon</u></p>
  <p>Draw 3 or more MA lines. Use additional MA lines to validate the signal given by others. e.g. plot 5/10/20 MA lines - the 5-day line cross over the others is taken as the primary signal with the 10-day cross over the 20-day line taken used as confirmation.</p>'







