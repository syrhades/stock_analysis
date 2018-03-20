# install step


require(devtools)
install_github('rCharts', 'ramnathv')

library(rCharts)
names(iris) = gsub("\\.", "", names(iris))
p1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
p1



library(rCharts)
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
hair_eye_male[,1] <- paste0("Hair",hair_eye_male[,1])
hair_eye_male[,2] <- paste0("Eye",hair_eye_male[,2])
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male,
type = "multiBarChart")
n1


library(rCharts)
a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble",
title = "Zoom demo", subtitle = "bubble chart",
size = "Age", group = "Exer")
a$colors('rgba(223, 83, 83, .5)', 'rgba(119, 152, 191, .5)',
'rgba(60, 179, 113, .5)')
a$chart(zoomType = "xy")
a$exporting(enabled = T)
a


# demo

..p. <- function() invisible(readline("\nPress <return> to continue: "))
library(rCharts)

## {title: Scatter Chart}
p1 <- nPlot(mpg ~ wt, group = 'cyl', data = mtcars, type = 'scatterChart')
p1$xAxis(axisLabel = 'Weight')
p1

..p.() # ================================

## {title: MultiBar Chart}
hair_eye = as.data.frame(HairEyeColor)
p2 <- nPlot(Freq ~ Hair, group = 'Eye', data = subset(hair_eye, Sex == "Female"), type = 'multiBarChart')
p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
p2

..p.() # ================================

## {title: MultiBar Horizontal Chart}
p3 <- nPlot(~ cyl, group = 'gear', data = mtcars, type = 'multiBarHorizontalChart')
p3$chart(showControls = F)
p3

..p.() # ================================

## {title: Pie Chart}
p4 <- nPlot(~ cyl, data = mtcars, type = 'pieChart')
p4

..p.() # ================================

## {title: Donut Chart}
p5 <- nPlot(~ cyl, data = mtcars, type = 'pieChart')
p5$chart(donut = TRUE)
p5

..p.() # ================================

## {title: Line Chart}
data(economics, package = 'ggplot2')
p6 <- nPlot(uempmed ~ date, data = economics, type = 'lineChart')
p6

..p.() # ================================

## {title: Line with Focus Chart }
ecm <- reshape2::melt(economics[,c('date', 'uempmed', 'psavert')], id = 'date')
p7 <- nPlot(value ~ date, group = 'variable', data = ecm, type = 'lineWithFocusChart')
#test format dates on the xAxis
#also good test of javascript functions as parameters
#dates from R to JSON will come over as number of days since 1970-01-01
#so convert to milliseconds 86400000 in a day and then format with d3
#on lineWithFocusChart type xAxis will also set x2Axis unless it is specified
p7$xAxis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )
#test xAxis also sets x2Axis
p7

..p.() # ================================

#now test setting x2Axis to something different
#test format dates on the x2Axis
#test to show %Y format which is different than xAxis
p7$x2Axis( tickFormat="#!function(d) {return d3.time.format('%Y')(new Date( d * 86400000 ));}!#" )
p7

..p.() # ================================

#test set xAxis again to make sure it does not override set x2Axis
p7$xAxis( NULL, replace = T)
p7

..p.() # ================================

## {title: Stacked Area Chart}
dat <- data.frame(t=rep(0:23,each=4),var=rep(LETTERS[1:4],4),val=round(runif(4*24,0,50)))
p8 <- nPlot(val ~ t, group =  'var', data = dat, type = 'stackedAreaChart', id = 'chart')
p8


..p.() # ================================

## {title: InteractiveGuidline(Multi-Tooltips) on Line}
p9 <- nPlot(value ~ date, group = 'variable', data = ecm, type = 'lineChart')
p9$xAxis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )
#try new interactive guidelines feature
p9$chart(useInteractiveGuideline=TRUE)
p9


..p.() # ================================

## {title: InteractiveGuidline(Multi-Tooltips) on Stack}
p10 <- p8
p10$chart(useInteractiveGuideline=TRUE)
p10

..p.() # ================================

## {title: showDistX and showDistY}
p11 <- p1
p11$chart(showDistX = TRUE, showDistY = TRUE)
p11

..p.() # ================================

## {title: multiChart}
p12 <- nPlot(value ~ date, group = 'variable', data = ecm, type = 'multiChart')
p12$params$multi = list(
  uempmed = list(type="area",yAxis=1),
  psavert = list(type="line",yAxis=2)
)
p12$setTemplate(script = system.file(
  "/libraries/nvd3/layouts/multiChart.html",
  package = "rCharts"
))
p12

..p.() # ================================

## ## {title: Facets}
## facet has not been supported yet.
## 
## p13 <- nPlot(mpg ~ wt, data = mtcars, group = "gear", type = "scatterChart")
## p13$params$facet = "cyl"
## p13$templates$script = system.file(
##   "/libraries/nvd3/layouts/nvd3FacetPlot.html",
##   package = "rCharts"
## )
## p13
## 
## ..p.() # ================================
## 
## hair_eye = as.data.frame(HairEyeColor)
## p14 <- nPlot(Freq ~ Hair, group = 'Sex', data = hair_eye, type = 'multiBarChart')
## p14$params$facet="Eye"
## p14$templates$script = system.file(
##   "/libraries/nvd3/layouts/nvd3FacetPlot.html",
##   package = "rCharts"
## )
## p14
## 
## ..p.() # ================================
## 
## p15 <- nPlot(Freq ~ Hair, group = 'Eye', data = hair_eye, type = 'multiBarChart')
## p15$params$facet="Sex"
## p15$templates$script = system.file(
##   "/libraries/nvd3/layouts/nvd3FacetPlot.html",
##   package = "rCharts"
## )
## p15
## 
## ..p.() # ================================

## {title: Sparklines}
p16 <- nPlot(uempmed ~ date, data = economics, type = 'sparklinePlus',height=100,width=500)
p16$chart(xTickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#")
p16

..p.() # ================================

## semi replicate sparkline with a full nvd3 model by setting short height and turning off lots of things
require(quantmod)

spy <- getSymbols("SPY",auto.assign=FALSE,from="2013-01-01")
colnames(spy) <- c("open","high","low","close","volume","adjusted")

spy.df <- data.frame(index(spy),spy)
colnames(spy.df)[1] <- "date"

p17 <- nPlot(
  x = "date",
  y = "volume",
  data = spy.df,
  type = "multiBarChart",
  height = 200)
p17$chart(showControls = FALSE, showLegend = FALSE, showXAxis = FALSE, showYAxis = FALSE) 
p17$xAxis(tickFormat = 
  "#!function(d) {return d3.time.format('%Y-%m-%d')(new Date(d * 24 * 60 * 60 * 1000));}!#"
)
p17


..p.() # ================================

## {title: ohlcBar}
## ohlcBar not fully implemented on nvd3 side, so no axes or interactive controls
## note do not melt if using ohlcBar
p18 <- nPlot(
  x = "date",
  y = "close",
  data = spy.df,
  type = "ohlcBar"
)
p18

..p.() # ================================

require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c('category', 'year')
x1 <- xPlot(value ~ year, group = 'category', data = uspexp, 
  type = 'line-dotted')
x1

h1 <- Highcharts$new()
h1$chart(type = "spline")
h1$series(data = c(1, 3, 2, 4, 5, 4, 6, 2, 3, 5, NA), dashStyle = "longdash")
h1$series(data = c(NA, 4, 1, 3, 4, 2, 9, 1, 2, 3, 4), dashStyle = "shortdot")
h1$legend(symbolWidth = 80)
h1

r1 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = 'point', color = 'gear')
r1

graph_chart1.addHandler(function(type, e){
  var data = e.evtData;
  if (type === 'click'){
    return alert("You clicked on car with mpg: " + data.mpg.in[0]);
  }
}

Morris

The next library we will be exploring is Morris.

data(economics, package = 'ggplot2')
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = 'date', y = c('psavert', 'uempmed'), type = 'Line',
  data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1


m1 <- mPlot(x = 'date', y = c('psavert', 'uempmed'), type = 'Bar',
  data = econ)
# m1$set(pointSize = 0, lineWidth = 1)
m1

NVD3

Next, I will demonstrate my all time favorite d3js library, NVD3, which produces amazing interactive visualizations with little customization.

hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
  type = 'multiBarChart')
n1

map3 <- Leaflet$new()
map3$setView(c(51.505, -0.09), zoom = 13)
map3$marker(c(51.5, -0.09), bindPopup = "<p> Hi. I am a popup </p>")
map3$marker(c(51.495, -0.083), bindPopup = "<p> Hi. I am another popup </p>")
map3


Rickshaw

usp = reshape2::melt(USPersonalExpenditure)
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group = 'Var1', data = usp, type = 'area')
p4


