strategy_cpp_file = "~/sdcard/bbands_market_maker.cpp"
Rcpp::sourceCpp( strategy_cpp_file )

timeframe = 60   # time interval
step      = 0.01 # bar step
alpha     = 0.98 # decay coefficient
cut       = 100  # cut threshold
vp = roll_volume_profile( ticks[ time %bw% '2016-05-09' ], timeframe, step, alpha, cut )

profiles = rbindlist( vp$profile )
# normalize profiles volume
profiles[, volume_norm := volume / max( volume ), by = time ]

# plot indicator values as heat vector
candles = to_candles( ticks, timeframe )[ time %bw% '2016-05-09' ]
plot_ts( candles )
profiles[, rect( 
  xleft   = t_to_x( time - timeframe ),
  xright  = t_to_x( time ),
  ybottom = price - step / 2,
  ytop    = price + step / 2,
  col     = rgb( 0.70, 0.13, 0.13, volume_norm ),
  border = NA
) ]



# Rolling Linear Regression

# Rolling linear regression calculates regression coefficients over n past paired values.

symbols = c( 'AAPL', 'MSFT' )
prices = lapply_named( symbols, get_yahoo_data, from = '2010-01-01', to = '2016-01-01' )
prices = lmerge( prices, 'date', 'close' )

roll_lm = roll_lm( prices$AAPL, prices$MSFT, 50 )

layout( matrix( 1:5, ncol = 1 ) )
par( mar = c( 0, 4.1, 0, 2.1 ), xaxt = 'n' )
plot_ts( prices )
plot_ts( prices[ , .( date, alpha     = roll_lm$alpha     ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, beta      = roll_lm$beta      ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, r         = roll_lm$r         ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 0, 2.1 ), xaxt = 's' )
plot_ts( prices[ , .( date, r.squared = roll_lm$r.squared ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 4.1, 2.1 ) )


# Crossover

# Crossover is binary indicator indicating the moment when one value goes above or below another.

sma_short = sma( candles$'close', 50 )
sma_long  = sma( candles$'close', 100 )
crossover = crossover( sma_short, sma_long )

plot_ts( candles )

candles[ crossover == 'UP', abline( v = t_to_x( time ), col = 'blue' ) ]
candles[ crossover == 'DN', abline( v = t_to_x( time ), col = 'red' ) ]
plot_ts( candles[ , .( time, sma_short, sma_long ) ], col = c( 'firebrick', 'goldenrod' ), add = T )





    Overview

    Data

    Simple Moving Average

    Exponential Moving Average

    Rolling Range

    Rolling Quantile

    Rolling Standard Deviation

    Relative Strength Index

    Rolling Percent Rank

    Rolling Linear Regression

    Crossover

    Bollinger Bands

    Stochastic Oscillator

    Rolling Volume Profile

QuantTools

    Get Started
    Examples

    Source
    Donate
    Contact

Overview

Indicators are very popular tools to generate trading signals. Even though basic indicators are well known their application is limited to your imagination only. You can apply indicators to not only price but on other indicators or their combination. The most common described below.
Data

Data used in all examples is a sample of stock tick data. QuantTools have this data set already we just have to load it. Ticks are converted to candles to make plots readable.

library( QuantTools )
# load ticks data set
data( ticks )
# convert them to hourly candles
timeframe = 60 * 60 
candles = to_candles( ticks, timeframe )
candles

##                      time   open    high     low  close  volume      id
##    1: 2016-01-19 10:00:00  98.39  98.640  97.660  97.88  375858    2619
##    2: 2016-01-19 11:00:00  97.89  98.090  96.895  97.00  444659    5915
##   ---                                                                  
## 1177: 2016-09-13 16:00:00 107.84 108.315 107.740 108.03  707425 2298417
## 1178: 2016-09-14 10:00:00 108.66 110.970 108.660 110.95 1421707 2305273

Simple Moving Average

Simple moving average also called SMA is the most popular indicator. It shows the average of n past values. Can be used for time series smoothing.

sma = sma( candles$'close', 20 )

plot_ts( candles )
plot_ts( candles[ , .( time, sma ) ], col = 'firebrick', add = T )

    Note: corresponding c++ indicator class is Sma

Exponential Moving Average

Exponentially weighted moving average aka EMA is exponentially weighted SMA. EMAs have faster response to recent value changes than SMAs.

ema = ema( candles$'close', 20 )

plot_ts( candles )
plot_ts( candles[ , .( time, ema ) ], col = 'firebrick', add = T )

    Note: corresponding c++ indicator class is Ema

Rolling Range

Rolling range is minimum and maximum values over n past values. Can be used to identify price range.

roll_range = roll_range( candles$'close', 20 )

plot_ts( candles )
plot_ts( candles[ , cbind( time, roll_range ) ], col = 'firebrick', add = T )

    Note: corresponding c++ indicator class is RollRange

Rolling Quantile

Rolling quantile shows quantile value of n past values.

roll_quantile = roll_quantile( candles$'close', 20, 0.5 )

plot_ts( candles )
plot_ts( candles[ , .( time, roll_quantile ) ], col = 'firebrick', add = T )

    Note: corresponding c++ indicator class is RollRange

Rolling Standard Deviation

Rolling standard deviation shows standard deviation over n past values.

roll_sd = roll_sd( candles$'close', 20 )

layout( matrix( 1:2, ncol = 1 ) )
plot_ts( candles, mar = c( 0, 4.1, 4.1, 2.1 ), xaxt = 'n' )
plot_ts( candles[ , .( time, roll_sd ) ], col = 'firebrick', mar = c( 5.1, 4.1, 0, 2.1 ) )

    Note: corresponding c++ indicator class is RollSd

Relative Strength Index

Relative strength index aka RSI measurs the velocity and magnitude of directional price movements.

rsi = rsi( candles$'close', 30 )

layout( matrix( 1:2, ncol = 1 ) )
plot_ts( candles, mar = c( 0, 4.1, 4.1, 2.1 ), xaxt = 'n' )
plot_ts( candles[ , .( time, rsi ) ], col = 'firebrick', mar = c( 5.1, 4.1, 0, 2.1 ) )

    Note: corresponding c++ indicator class is Rsi

Rolling Percent Rank

Rolling percent rank normalizes values to a range from 0 to 100.

roll_percent_rank = roll_percent_rank( candles$'close', 50 )

layout( matrix( 1:2, ncol = 1 ) )
plot_ts( candles, mar = c( 0, 4.1, 4.1, 2.1 ), xaxt = 'n' )
plot_ts( candles[ , .( time, roll_percent_rank ) ], col = 'firebrick', mar = c( 5.1, 4.1, 0, 2.1 ) )

    Note: corresponding c++ indicator class is RollPercentRank

Rolling Linear Regression

Rolling linear regression calculates regression coefficients over n past paired values.

symbols = c( 'AAPL', 'MSFT' )
prices = lapply_named( symbols, get_yahoo_data, from = '2010-01-01', to = '2016-01-01' )
prices = lmerge( prices, 'date', 'close' )

roll_lm = roll_lm( prices$AAPL, prices$MSFT, 50 )

layout( matrix( 1:5, ncol = 1 ) )
par( mar = c( 0, 4.1, 0, 2.1 ), xaxt = 'n' )
plot_ts( prices )
plot_ts( prices[ , .( date, alpha     = roll_lm$alpha     ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, beta      = roll_lm$beta      ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, r         = roll_lm$r         ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 0, 2.1 ), xaxt = 's' )
plot_ts( prices[ , .( date, r.squared = roll_lm$r.squared ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 4.1, 2.1 ) )

    Note: corresponding c++ indicator class is RollLinReg

Crossover

Crossover is binary indicator indicating the moment when one value goes above or below another.

sma_short = sma( candles$'close', 50 )
sma_long  = sma( candles$'close', 100 )
crossover = crossover( sma_short, sma_long )

plot_ts( candles )

candles[ crossover == 'UP', abline( v = t_to_x( time ), col = 'blue' ) ]
candles[ crossover == 'DN', abline( v = t_to_x( time ), col = 'red' ) ]
plot_ts( candles[ , .( time, sma_short, sma_long ) ], col = c( 'firebrick', 'goldenrod' ), add = T )

    Note: corresponding c++ indicator class is Crossover

Bollinger Bands

Bollinger bands is a mix of Rolling Range and SMA indicators. It shows the average price and its range over n past values based on price volatility.

bbands = bbands( candles$'close', 20, 2 ) 

plot_ts( candles )
plot_ts( candles[ , cbind( time, bbands ) ], col = c( 'darkmagenta', 'darkgreen', 'goldenrod' ), add = T )

    Note: corresponding c++ indicator class is BBands

Stochastic Oscillator

Stochastic oscillator shows position of price in respect to its range over n past values.

stochastic = stochastic( candles, 50, 10, 5 )

layout( matrix( 1:2, ncol = 1 ) )
plot_ts( candles, mar = c( 0, 4.1, 4.1, 2.1 ), xaxt = 'n' )
plot_ts( candles[ , cbind( time, stochastic ) ], 
         col = c( 'darkmagenta', 'darkseagreen', 'goldenrod' ), mar = c( 5.1, 4.1, 0, 2.1 ) )

    Note: corresponding c++ indicator class is Stochastic

Rolling Volume Profile

This indicator is not common. Volume profile is the distribution of volume over price. It is formed tick by tick and partially forgets past values over time interval. When volume on any bar is lower than specified critical value the bar is cut.

timeframe = 60   # time interval
step      = 0.01 # bar step
alpha     = 0.98 # decay coefficient
cut       = 100  # cut threshold
vp = roll_volume_profile( ticks[ time %bw% '2016-05-09' ], timeframe, step, alpha, cut )

profiles = rbindlist( vp$profile )
# normalize profiles volume
profiles[, volume_norm := volume / max( volume ), by = time ]

# plot indicator values as heat vector
candles = to_candles( ticks, timeframe )[ time %bw% '2016-05-09' ]
plot_ts( candles )
profiles[, rect( 
  xleft   = t_to_x( time - timeframe ),
  xright  = t_to_x( time ),
  ybottom = price - step / 2,
  ytop    = price + step / 2,
  col     = rgb( 0.70, 0.13, 0.13, volume_norm ),
  border = NA
) ]

Animation below shows how market profile evolves over time. If you don’t see the video right-click and select ‘download video’ to play it locally.

    Note: corresponding c++ indicator class is RollVolumeProfile

© 2016 Stanislav Kovalevsky. All rights reserved.


http://geog.uoregon.edu/datagraphics/color_scales.htm



 Categorical.12 

require(dichromat)


    BrowntoBlue.10

    BrowntoBlue.12

    BluetoDarkOrange.12

    BluetoDarkOrange.18

    DarkRedtoBlue.12

    DarkRedtoBlue.18

    BluetoGreen.14

    BluetoGray.8

    BluetoOrangeRed.14

    BluetoOrange.10

    BluetoOrange.12

    BluetoOrange.8

    LightBluetoDarkBlue.10

    LightBluetoDarkBlue.7

    Categorical.12

    GreentoMagenta.16

    SteppedSequential.5


  pal <- function(col, ...)
  image(seq_along(col), 1, matrix(seq_along(col), ncol = 1),
  col = col, axes = FALSE, ...)

opar <- par(mar = c(1, 2, 1, 1))
layout(matrix(1:6, ncol = 1))
pal(colorschemes$BrowntoBlue.10, main = "Brown to Blue (10)")
pal(colorRampPalette(colorschemes$BrowntoBlue.10, space = "Lab")(100),
  main = "Brown to Blue Ramp")
pal(dichromat(colorschemes$BrowntoBlue.10),
  main = "Brown to Blue (10) -- deuteranopia")
pal(colorschemes$Categorical.12, main = "Categorical (12)")
pal(dichromat(colorschemes$Categorical.12),
  main = "Categorical (12) -- deuteranopia")
pal(dichromat(colorschemes$Categorical.12, "protan"),
  main = "Categorical (12) -- protanopia")
par(opar)

require(Rcpp)

sourceCpp(code='
  #include <Rcpp.h>

  // [[Rcpp::export]]
  int fibonacci(const int x) {
    if (x == 0) return(0);
    if (x == 1) return(1);
    return (fibonacci(x - 1)) + fibonacci(x - 2);
  }'
)

fibonacci(2)

