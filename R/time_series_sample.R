data(AirPassengers)
AP <- AirPassengers
start(AP); end(AP); frequency(AP)
summary(AP)
plot(AP, ylab = "Passengers (1000 ' s)")

layout(1:2)
plot(aggregate(AP))
boxplot(AP ~ cycle(AP))

www <- "http://www.massey.ac.nz/~pscowper/ts/Maine.dat"
Maine.month <- read.table(www, header = TRUE)
attach(Maine.month)
class(Maine.month)

Maine.month.ts <- ts(unemploy, start = c(1996, 1), freq = 12)

Maine.annual.ts <- aggregate(Maine.month.ts)/12

layout(1:2)
plot(Maine.month.ts, ylab = "unemployed (%)")
plot(Maine.annual.ts, ylab = "unemployed (%)")
Maine.Feb <- window(Maine.month.ts, start = c(1996,2), freq = TRUE)
Maine.Aug <- window(Maine.month.ts, start = c(1996,8), freq = TRUE)
Feb.ratio <- mean(Maine.Feb) / mean(Maine.month.ts)
Aug.ratio <- mean(Maine.Aug) / mean(Maine.month.ts)
Feb.ratio
[1] 1.223
Aug.ratio


www <- "http://www.massey.ac.nz/~pscowper/ts/USunemp.dat"
US.month <- read.table(www, header = T)
attach(US.month)
US.month.ts <- ts(USun, start=c(1996,1), end=c(2006,10), freq = 12)
plot(US.month.ts, ylab = "unemployed (%)")

Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
Beer.ts <- ts(CBE[, 2], start = 1958, freq = 12)
Choc.ts <- ts(CBE[, 1], start = 1958, freq = 12)
plot(cbind(Elec.ts, Beer.ts, Choc.ts))

AP.elec <- ts.intersect(AP, Elec.ts)

AP <- AP.elec[,1]; Elec <- AP.elec[,2]
layout(1:2)
plot(AP, main = "", ylab = "Air passengers / 1000 ' s")
plot(Elec, main = "", ylab = "Electricity production / MkWh")
plot(as.vector(AP), as.vector(Elec),
xlab = "Air passengers / 1000 ' s",
ylab = "Electricity production / MWh")
abline(reg = lm(Elec ~ AP))

cor(AP, Elec)



www <- "http://www.massey.ac.nz/~pscowper/ts/pounds_nz.dat"
Z <- read.table(www, header = T)
Z[1:4, ]
] 2.92 2.94 3.17 3.25
Z.ts <- ts(Z, st = 1991, fr = 4)

plot(Z.ts, xlab = "time / years",
ylab = "Quarterly exchange rate in $NZ / pound")

Z.92.96 <- window(Z.ts, start = c(1992, 1), end = c(1996, 1))
Z.96.98 <- window(Z.ts, start = c(1996, 1), end = c(1998, 1))
layout (1:2)
plot(Z.92.96, ylab = "Exchange rate in $NZ/pound",
xlab = "Time (years)" )
plot(Z.96.98, ylab = "Exchange rate in $NZ/pound",
xlab = "Time (years)" )

www <- "http://www.massey.ac.nz/~pscowper/ts/global.dat"
Global <- scan(www)
Global.ts <- ts(Global, st = c(1856, 1), end = c(2005, 12),
fr = 12)
Global.annual <- aggregate(Global.ts, FUN = mean)
plot(Global.ts)
plot(Global.annual)

New.series <- window(Global.ts, start=c(1970, 1), end=c(2005, 12))
New.time <- time(New.series)
plot(New.series); abline(reg=lm(New.series ~ New.time))


require(graphics)

m <- decompose(co2)
m$figure
plot(m)

## example taken from Kendall/Stuart
x <- c(-50, 175, 149, 214, 247, 237, 225, 329, 729, 809,
       530, 489, 540, 457, 195, 176, 337, 239, 128, 102, 232, 429, 3,
       98, 43, -141, -77, -13, 125, 361, -45, 184)
x <- ts(x, start = c(1951, 1), end = c(1958, 4), frequency = 4)
m <- decompose(x)
## seasonal figure: 6.25, 8.62, -8.84, -6.03
round(decompose(x)$figure / 10, 2)



read.table reads data into a data frame
attach makes names of column variables available
ts produces a time series object
aggregate creates an aggregated series
ts.plot produces a time plot for one or more series
window extracts a subset of a time series
time extracts the time from a time series object
ts.intersect creates the intersection of one or more time series
cycle returns the season for each value in a series
decompose decomposes a series into the components
trend, seasonal effect, and residual
stl decomposes a series using loess smoothing
summary summarises an R object


