plot

obama_vs_mccain <-  obama_vs_mccain[!is.na(obama_vs_mccain$Turnout), ]
with(obama_vs_mccain,  plot(Income,  Turnout))
with(obama_vs_mccain,  plot(Income,  Turnout,  col = "violet" ,  pch = 20))
with(obama_vs_mccain,  plot(Income,  Turnout,  log = "y" ))
#Fig. 14-3
with(obama_vs_mccain,  plot(Income,  Turnout,  log = "xy" ))
#Fig. 14-4

par(mar = c(3, 3, 0.5, 0.5),  oma = rep.int(0, 4),  mgp = c(2, 1, 0))
regions <-  levels(obama_vs_mccain$Region)
plot_numbers <-  seq_along(regions)
layout(matrix(plot_numbers,  ncol = 5,  byrow = TRUE))
for(region in regions)
{
regional_data <-  subset(obama_vs_mccain,  Region == region)
with(regional_data,  plot(Income,  Turnout))
}

library(lattice)
xyplot(Turnout ~ Income,  obama_vs_mccain)
xyplot(mpg ~ wt,  mtcars)
xyplot(mpg ~ wt,  mtcars, col = "violet" ,  pch = 20)

xyplot(
mpg ~ wt,  mtcars,
scales = list(log = TRUE) #both axes log scaled (Fig. 14-8)
)
xyplot(
mpg ~ wt,  mtcars,
scales = list(y = list(log = TRUE)) #y-axis log scaled (Fig. 14-9)
)

xyplot(
Turnout ~ Income |  Region,
obama_vs_mccain,
scales = list(
log = TRUE,
relation = "same" ,
alternating = FALSE
),
layout = c(5, 2)
)

xyplot(
mpg ~ wt| cyl,  mtcars ,
scales = list(
log = TRUE,
relation = "same" ,
alternating = FALSE
),
layout = c(5, 2)
)



(lat1 <-  xyplot(
mpg ~ wt| cyl,  
mtcars
))
#Fig. 14-11
(lat2 <-  update(lat1,  col = "violet" ,  pch = 20))
#Fig. 14-12


library(ggplot2)
ggplot(mtcars,  aes(mpg,  wt)) +
geom_point()


ggplot(mtcars,  aes(mpg,  wt)) +
geom_point(color = "violet" ,  shape = 20)

ggplot(mtcars,  aes(mpg,  wt)) +
geom_point() +
scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) +
scale_y_log10(breaks = seq(50, 75, 5))


ggplot(mtcars,  aes(mpg,  wt)) +
geom_point() +
scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) +
scale_y_log10(breaks = seq(50, 75, 5)) +
facet_wrap(~ cyl,  ncol = 4)

(gg1 <- ggplot(mtcars, aes(mpg,  wt)) +
geom_point()
)

(gg2 <-  gg1 +
facet_wrap(~ cyl,  ncol = 5) +
theme(axis.text.x = element_text(angle = 30,  hjust = 1))
)

with(
crab_tag$daylog,
plot(Date, - Max.Depth,  type = "l" ,  ylim = c(- max(Max.Depth), 0))
)


with(
 crab_tag$daylog,
 lines(Date, - Min.Depth,  col = "blue" )
)

with(
 mtcars,
 lines(mpg,wt,  col = "blue" )
)

xyplot(- Min.Depth + - Max.Depth ~ Date,  crab_tag$daylog,  type = "l" )

ggplot(crab_tag$daylog,  aes(Date, - Min.Depth)) +
 geom_line()


 ggplot(crab_tag$daylog,  aes(Date)) +
geom_line(aes(y = - Max.Depth)) +
geom_line(aes(y = - Min.Depth))


library(reshape2)
crab_long <-  melt(
crab_tag$daylog,
id.vars = "Date" ,
measure.vars = c("Min.Depth" , "Max.Depth" )
)
ggplot(crab_long,  aes(Date, - value,  group = variable)) +
geom_line()



Histograms
If you want to explore the distribution of a continuous variable, histograms are the
obvious choice.7
For the next examples we’ll return to the obama_vs_mccain dataset, this time looking at
the distribution of the percentage of votes for Obama. In base, the hist function draws
a histogram, as shown in Figure 14-26. Like plot, it doesn’t have a data argument, so
we have to wrap it inside a call to with:
with(obama_vs_mccain,  hist(Obama))

The number of breaks is calculated by default by Sturges’s algorithm. It is good practice
to experiment with the width of bins in order to get a more complete understanding of
the distribution. This can be done in a variety of ways: you can pass hist a single number
to specify the number of bins, or a vector of bin edges, or the name of a different algo‐
rithm for calculating the number of bins ("scott"  and "fd"  are currently supported on
top of the default of"sturges" ), or a function that calculates one of the first two options.
It’s really flexible. In the following examples, the results of which are shown in Figures
14-27 to 14-31, the main argument creates a main title above the plot. It works for the
plot function too:
with(obama_vs_mccain,
hist(Obama, 4,  main = "An exact number of bins" )
)
#Fig. 14-27

with(obama_vs_mccain,
hist(Obama,  seq.int(0, 100, 5),  main = "A vector of bin edges" )
)
#Fig. 14-28

with(obama_vs_mccain,
hist(Obama, "FD" ,  main = "The name of a method" )
)

with(obama_vs_mccain,
hist(Obama,  nclass.scott,  main = "A function for the number of bins" )
)

binner <- function(x)
{
seq(min(x,  na.rm = TRUE),  max(x,  na.rm = TRUE),  length.out = 50)
}
with(obama_vs_mccain,
hist(Obama,  binner,  main = "A function for the bin edges" )
)

utils::str(hist(islands, col = "gray", labels = TRUE))


hist(Obama,  seq.int(0, 100, 5),  main = "A vector of bin edges" )

with(obama_vs_mccain,
 hist(Obama,  seq.int(0, 100, 5),  main = "A vector of bin edges" )
)4


binner <- function(x)
{
 seq(min(x,  na.rm = TRUE),  max(x,  na.rm = TRUE),  length.out = 50)
}
with(obama_vs_mccain,
 hist(Obama,  binner,  main = "A function for the bin edges" )
)

with(mtcars,
 hist(wt,  binner,  main = "A function for the bin edges" )
)

with(obama_vs_mccain,  hist(Obama,  freq = FALSE))

histogram(~ Obama,  obama_vs_mccain)
#Fig. 14-33
histogram(~ Obama,  obama_vs_mccain,  breaks = 10)

histogram(~ Obama,  obama_vs_mccain)
#Fig. 14-33
histogram(~ wt,  mtcars,  breaks = 10)


lattice histograms support counts, probability densities, and percentage y-axes via the
type argument, which takes the string "count" , "density" , or "percent" . Figure 14-35
shows the "percent"  style:
histogram(~ wt,  mtcars,  type = "percent" )
histogram(~ wt,  mtcars,  type = "count" )
histogram(~ wt,  mtcars,  type = "density" )


ggplot(obama_vs_mccain,  aes(Obama)) +
geom_histogram(binwidth = 5)

ggplot(obama_vs_mccain,  aes(Obama, .. density.. )) +
geom_histogram(binwidth = 5)


boxplot(Obama ~ Region,  data = obama_vs_mccain)

This type of plot is often clearer if we reorder the box plots from smallest to largest, in
some sense. The reorder function changes the order of a factor’s levels, based upon
some numeric score. In Figure 14-39 we score the Region levels by the median Obama
value for each region:

ovm <-  within(
obama_vs_mccain,
Region <-  reorder(Region,  Obama,  median)
)
boxplot(Obama ~ Region,  data = ovm)
The switch from base to lattice is very straightforward. In this simplest case, we can
make a straight swap ofboxplot for bwplot (“bw” is short for “b (box) and w (whisker),”
in case you hadn’t figured it out). Notice the similarity of Figure 14-40 to Figure 14-38:
bwplot(Obama ~ Region,  data = ovm)


ovm <-  within(
mtcars,
wt <-  reorder(wt,  mpg,  median)
)
boxplot(Obama ~ Region,  data = ovm)

ggplot(ovm,  aes(Region,  Obama)) +
geom_boxplot()

ovm <-  ovm[! (ovm$State %in% c("Alaska" , "Hawaii" )), ]
ovm <-  ovm[! (ovm$State %in% c("Alaska" , "Hawaii" )), ]
?par
par(las = 1,  mar = c(3, 9, 1, 1))
with(ovm,  barplot(Catholic,  names.arg = State,  horiz = TRUE))

religions <-  with(ovm,  rbind(Catholic,  Protestant,  Non.religious,  Other))
colnames(religions) <-  ovm$State
par(las = 1,  mar = c(3, 9, 1, 1))
barplot(religions,  horiz = TRUE,  beside = FALSE)

barchart(mpg ~ wt,  mtcars)

barchart(
State ~ Catholic + Protestant + Non.religious + Other,
ovm,
stack = TRUE
)

ggplot2 requires a tiny bit of work be done to the data to replicate this plot. We need
the data in long form, so we must first melt the columns that we need:
religions_long <-  melt(
ovm,
id.vars = "State" ,
measure.vars = c("Catholic" , "Protestant" , "Non.religious" , "Other" )
)
Like base, gplot2 defaults to vertical bars; adding coord_flip swaps this. Finally, since
we already have the lengths of each bar in the dataset (without further calculation) we
must pass stat = "identity"  to the geom. Bars are stacked by default, as shown in
Figure 14-46:

ggplot(religions_long,  aes(State,  value,  fill = variable)) +
geom_bar(stat = "identity" ) +
coord_flip()

To avoid the bars being stacked, we would have to pass the argument position =
"dodge"  to geom_bar. Figure 14-47 shows this:
ggplot(religions_long,  aes(State,  value,  fill = variable)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
coord_flip()


ggplot(df_zc3,  aes(item,  bl_VV2,  fill = item)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
coord_flip()




par(mfrow=c(2,2))
x<-seq(0,150,10)
y<-16+x*0.4+rnorm(length(x),0,6)
plot(x,y,pch=16,xlab="label for x axis",ylab="label for y axis")
plot(x,y,pch=16,xlab="label for x axis",ylab="label for y axis",
las=1,cex.lab=1.2, cex.axis=1.1)
plot(x,y,pch=16,xlab="label for x axis",ylab="label for y axis",
las=2,cex=1.5)
plot(x,y,pch=16,xlab="label for x axis",ylab="label for y axis",
las=3,cex=0.7,cex.lab=1.3, cex.axis=1.3)