require(quantmod)

getSymbols("IBM",src="yahoo",return.class="its")

buildData(Next(Op(T))~OpCl(T))
specifyModel(Next(Op(T)~OpCl(T))


  getSymbols("YHOO",src="google") # from google finance
[1] "YHOO"
getSymbols("GOOG",src="yahoo")  # from yahoo finance
[1] "GOOG"
getSymbols("DEXJPUS",src="FRED")  # FX rates from FRED
[1] "DEXJPUS"
getSymbols("XPT/USD",src="Oanda")  # Platinum from Oanda
[1] "XPTUSD" 

# Specify lookup parameters, and save for future sessions. 

setSymbolLookup(YHOO='google',GOOG='yahoo')
setSymbolLookup(DEXJPUS='FRED')
setSymbolLookup(XPTUSD=list(name="XPT/USD",src="oanda"))
saveSymbolLookup(file="mysymbols.rda")
# new sessions call loadSymbolLookup(file="mysymbols.rda")

getSymbols(c("YHOO","GOOG","DEXJPUS","XPTUSD")) 
[1] "YHOO" "GOOG" "DEXJPUS" "XPTUSD" 

 # Specify lookup parameters, and save for future sessions.

getSymbols("AAPL",src="yahoo")
[1] "AAPL"
barChart(AAPL)
# Add multi-coloring and change background to white
candleChart(AAPL,multi.col=TRUE,theme="white") 
Non-OHLC and Volume series are handled automatically
getSymbols("XPT/USD",src="oanda")
[1] "XPTUSD"
chartSeries(XPTUSD,name="Platinum (.oz) in $USD") 

chartSeries(to.weekly(XPTUSD),up.col='white',dn.col='blue') 
require(TTR)
getSymbols("AAPL")
[1] "AAPL"
chartSeries(AAPL)
addMACD()
addBBands()

# Create a quantmod object for use in
# in later model fitting. Note there is
# no need to load the data before hand.

setSymbolLookup(SPY='yahoo',
VXN=list(name='^VIX',src='yahoo'))

mm <- specifyModel(Next(OpCl(SPY)) ~ OpCl(SPY) + Cl(VIX))

modelData(mm) 



> GS['2007'] #returns all Goldman's 2007 OHLC
> GS['2008'] #now just 2008
> GS['2008-01'] #now just January of 2008
> GS['2007-06::2008-01-12'] #Jun of 07 through Jan 12 of 08
>
> GS['::'] # everything in GS
> GS['2008::'] # everything in GS, from 2008 onward
> non.contiguous <- c('2007-01','2007-02','2007-12')
> GS[non.contiguous] 

> last(GS) #returns the last obs.
> last(GS,8) #returns the last 8 obs.
> 
> # let's try something a bit cooler.
> last(GS, '3 weeks')
> last(GS, '-3 weeks') # all except the last 3 weeks
> last(GS, '3 months')
> last(first(GS, '2 weeks'), '3 days') 


unclass(periodicity(df_spec_stock_xts))
> periodicity(GS)
> unclass(periodicity(GS))
> to.weekly(GS)
> to.monthly(GS)
> periodicity(to.monthly(GS))
> ndays(GS); nweeks(GS); nyears(GS)
> 
> # Let's try some non-OHLC to start
> getFX("USD/EUR")
[1] "USDEUR"
> periodicity(USDEUR)
> to.weekly(USDEUR)
> periodicity(to.weekly(USDEUR)) 
########################

require(qtbase)
qrect(x0, y0, x1, y1)


> endpoints(GS,on="months") 
> 
> # find the maximum closing price each week
> apply.weekly(GS,FUN=function(x) { max(Cl(x)) } )
> 
> # the same thing - only more general
> period.apply(GS,endpoints(GS,on='weeks'),
+ FUN=function(x) { max(Cl(x)) } )
>
> # same thing - only 50x faster!
> as.numeric(period.max(Cl(GS),endpoints(GS,on='weeks'))) 


> # Quick returns - quantmod style
> 
> getSymbols("SBUX")
[1] "SBUX"
> dailyReturn(SBUX) # returns by day
> weeklyReturn(SBUX) # returns by week
> monthlyReturn(SBUX) # returns by month, indexed by yearmon
> 
> # daily,weekly,monthly,quarterly, and yearly
> allReturns(SBUX) # note the plural 


