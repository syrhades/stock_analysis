Welcome to Quandl!
Your API key is:
bauLwKZiFsjxybxUU41m

and can be found in your account settings

Any help you need to get started using our data can be found in the help section
QEPx05

Quandl.api_key("bauLwKZiFsjxybxUU41m")

quandldata = quandl.api(path="datasets/NSE/OIL", http="GET")
plot(quandldata[,1])
    data = quandl.get("WIKI/FB")

library(Quandl)
library(xts)
Quandl.api_key("bauLwKZiFsjxybxUU41m")
golddata <- Quandl("LBMA/GOLD")


Quandl.api_key("bauLwKZiFsjxybxUU41m")
stockid <- Quandl("DY4/600016")


Quandl.search("silver")
ag_data <- Quandl("LBMA/SILVER")

transfrom(ag_data,Datexts=as.xts(Date))
ag_data <- Quandl("LBMA/SILVER",type="xts")


ag_dataxts <- Quandl("LBMA/SILVER",type="xts")
ag_dataxts$USD %>%plot
JPY_dataxts <- Quandl("CME/JPYF2016",type="xts")


JPY_dataxts <- Quandl("CHRIS",type="xts")
Quandl.search("CURRFX")
GBPCNY_dataxts <- Quandl("CURRFX/GBPCNY",type="xts")
USDCNY_dataxts <- Quandl("CURRFX/USDCNY",type="xts")
JPYCNY_dataxts <- Quandl("CURRFX/JPYCNY",type="xts")
AUDCNY_dataxts <- Quandl("CURRFX/AUDCNY",type="xts")

AUDCNY_dataxts %>% plot
matplot(GBPCNY_dataxts$Rate, type = "l")
AUDCNY_dataxts$Rate %>%plot
AUDCNY_dataxts["2010/"]$Rate %>%plot
AUDCNY_dataxts["2009/"]$Rate %>%plot




currency_ts <- lapply(as.list(currencies),Quandl,type="xts")

Q <- cbind(currency_ts[[1]]$Rate,currency_ts[[3]]$Rate,currency_ts[[6]]$Rate,currency_ts[[7]]$Rate)
matplot(Q, type = "l", xlab = "", ylab = "", main = "USD, GBP, CAD, AUD",
xaxt = 'n', yaxt = 'n',col = rainbow(ncol(Q)))

matplot(Q, type = "l")

library(quantmod)
bmw_stock<- new.env()
getSymbols("BMW.DE", env = bmw_stock, src = "yahoo", from =
as.Date("2010-01-01"), to = as.Date("2013-12-31"))
BMW<-bmw_stock$BMW.DE
chartSeries(BMW,multi.col=TRUE,theme="white")
addMACD()
addBBands()



d <- read.csv2("data.csv", stringsAsFactors = F)
for (i in c(3:17,19)){d[,i] = as.numeric(d[,i])}
boxplot_data <- split( d$Total.Return.YTD..I., d$BICS.L1.Sect.Nm )
windows()
par(mar = c(10,4,4,4))
boxplot(boxplot_data, las = 2, col = "grey")

help(package="quantmod")



chartSeries.demo <- function(x) {
  data(sample_matrix, package="xts")
  data <- as.xts(sample_matrix)
  cat("A simple xts object:\n")
  print(str(data))
  
  cat("chartSeries(data)\n")
  chartSeries(data)
  readline("Press <Enter> to continue")
  cat("Now we can add builtin indicators:\n\n")
  cat("Moving Average Convergence Divergence Indicator (from TTR)\n> addMACD()\n")
  plot(addMACD())
  readline("Press <Enter> to continue")
  cat("Add Bollinger Bands\n> addBBands()\n")
  plot(addBBands())
  readline("Press <Enter> to continue")
  cat("Drop Bollinger Bands\n> dropTA('BBands')\n")
  dropTA('BBands')
  readline("Press <Enter> to continue")
  cat("Zoom chart from full data to last 3 months\n> zoomChart(\"last 3 months\")\n")
  zoomChart('last 3 months')
  readline("Press <Enter> to continue")
  cat("Zoom back to full data\n> zoomChart()\n\n")
  zoomChart()
  rm(data)
}




Op(x)
Hi(x)
Lo(x)
Cl(x)
Vo(x)
Ad(x)

seriesHi(x)
seriesLo(x)
seriesIncr(x, thresh=0, diff.=1L)
seriesDecr(x, thresh=0, diff.=1L)

OpCl(x)
ClCl(x)
HiCl(x)
LoCl(x)
LoHi(x)
OpHi(x)
OpLo(x)
OpOp(x)

HLC(x)
OHLC(x)
OHLCV(x)


chartSeries.demo(data)

getSymbols('IBM',src='yahoo')
Ad(IBM)
Cl(IBM)
ClCl(IBM)

seriesHi(IBM)
seriesHi(Lo(IBM))
HLC(IBM)
allReturns(IBM)




> OpCl(GS) %>%head
                 OpCl.GS
2007-01-03  0.0005981804
2007-01-04 -0.0068424483
2007-01-05  0.0031245780
2007-01-08  0.0235116450
2007-01-09  0.0026530855
2007-01-10  0.0231563773
> GS%>% head
           GS.Open GS.High GS.Low GS.Close GS.Volume GS.Adjusted
2007-01-03  200.60  203.32 197.82   200.72   6494900    178.6391
2007-01-04  200.22  200.67 198.07   198.85   6460200    176.9748
2007-01-05  198.43  200.00 197.90   199.05   5892900    177.1528
2007-01-08  199.05  203.95 198.10   203.73   7851000    181.3180
2007-01-09  203.54  204.90 202.00   204.08   7147100    181.6295
2007-01-10  203.40  208.44 201.50   208.11   8025700    185.2161


