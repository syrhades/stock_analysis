# 波兰 妙可麦可纯牛奶
#https://s.taobao.com/search?q=%E6%B3%A2%E5%85%B0+%E5%A6%99%E5%8F%AF%E9%BA%A6%E5%8F%AF%E7%BA%AF%E7%89%9B%E5%A5%B6&s_from=newHeader&ssid=s5-e&search_type=item&sourceId=tb.item

#install.packages(c("ggplot2", "gcookbook"))
require(ggplot2)
require(gcookbook)
plot(mtcars$wt, mtcars$mpg)
qplot(mtcars$wt, mtcars$mpg)
# dex or a name for sheetName :
# data <- read.xlsx("datafile.xls", sheetIndex=2)
# data <- read.xlsx("datafile.xls", sheetName="Revenues")
# With read.xls() , you can load from other sheets by specifying a number for sheet :
# data <- read.xls("datafile.xls", sheet=2)
# install.packages("xlsx")
# library(xslx)
# data <- read.xlsx("datafile.xlsx", 1)
# For reading older Excel files in the .xls format, the gdata package has the function
# read.xls() :
# # Only need to install once
# install.packages("gdata")
# library(gdata)
# # Read first sheet
# data <- read.xls("datafile.xls")

qplot(wt, mpg, data=mtcars)
# This is equivalent to:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

plot(pressure$temperature, pressure$pressure, type="p")

plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="red")


qplot(pressure$temperature, pressure$pressure, geom="line")


qplot(temperature, pressure, data=pressure, geom="line")
# This is equivalent to:
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line()
# Lines and points together
qplot(temperature, pressure, data=pressure, geom=c("line", "point"))
# Equivalent to:
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()


barplot(BOD$demand, names.arg=BOD$Time)

# Generate a table of counts
barplot(table(mtcars$cyl))


qplot(BOD$Time, BOD$demand, geom="bar", stat="identity")
# Convert the x variable to a factor, so that it is treated as discrete
qplot(factor(BOD$Time), BOD$demand, geom="bar", stat="identity")


# cyl is continuous here
qplot(mtcars$cyl)
# Treat cyl as discrete
qplot(factor(mtcars$cyl))



# Bar graph of values. This uses the BOD data frame, with the
#"Time" column for x values and the "demand" column for y values.
qplot(Time, demand, data=BOD, geom="bar", stat="identity")
# This is equivalent to:
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
# Bar graph of counts
qplot(factor(cyl), data=mtcars)
# This is equivalent to:
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()


hist(mtcars$mpg)
# Specify approximate number of bins with breaks
hist(mtcars$mpg, breaks=10)

With the ggplot2 package, you can get a similar result using qplot() (Figure 2-9):
qplot(mtcars$mpg)
If the vector is in a data frame, you can use the following syntax:
library(ggplot2)
qplot(mpg, data=mtcars, binwidth=4)
# This is equivalent to:
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth=10)
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth=1)


To make a box plot (Figure 2-10), use plot() and pass it a factor of x values and a vector
of y values. When x is a factor (as opposed to a numeric vector), it will automatically
create a box plot:
plot(ToothGrowth$supp, ToothGrowth$len)
If the two vectors are in the same data frame, you can also use formula syntax. With this
syntax, you can combine two variables on the x-axis, as in Figure 2-10:
# Formula syntax
boxplot(len ~ supp, data = ToothGrowth)
# Put interaction of two variables on x-axis
boxplot(len ~ supp + dose, data = ToothGrowth)
With the ggplot2 package, you can get a similar result using qplot() (Figure 2-11), with
geom="boxplot" :
library(ggplot2)
qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")



qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")

ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()
If the two vectors are already in the same data frame, you can use the following syntax:
qplot(supp, len, data=ToothGrowth, geom="boxplot")
# This is equivalent to:
ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()

# Using three separate vectors
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len,
geom="boxplot")
# Alternatively, get the columns from the data frame
qplot(interaction(supp, dose), len, data=ToothGrowth, geom="boxplot")
# This is equivalent to:
	

curve(x^3 - 5*x, from=-4, to=4)

the previously created plot:
# Plot a user-defined function
myfun <- function(xvar) {
1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from=0, to=20)
# Add a line:
curve(1-myfun(x), add = TRUE, col = "red")
With the ggplot2 package, you can get a similar result using

You can plot any function that takes a numeric vector as input and returns a numeric
vector, including functions that you define yourself. Using add=TRUE will add a curve to
the previously created plot:

myfun <- function(xvar) {
1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from=0, to=20)
# Add a line:
curve(1-myfun(x), add = TRUE, col = "red")


# This sets the x range from 0 to 20
qplot(c(0,20), fun=myfun, stat="function", geom="line")
# This is equivalent to:
ggplot(data.frame(x=c(0, 20)), aes(x=x)) + stat_function(fun=myfun, geom="line")


Use ggplot() with geom_bar(stat="identity") and specify what variables you want
on the x- and y-axes (Figure 3-1):
library(gcookbook) # For the data set
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity")

You can convert the continuous
variable to a discrete variable by using factor() :

# There's no entry for Time == 6
BOD
Time demand
1
8.3
2
10.3
3
19.0
4
16.0
5
15.6
7
19.8
# Time is numeric (continuous)
str(BOD)
'data.frame':
6 obs. of 2 variables:
$ Time : num 1 2 3 4 5 7
$ demand: num 8.3 10.3 19 16 15.6 19.8
- attr(*, "reference")= chr "A1.4, p. 270"
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
# Convert Time to a discrete (categorical) variable with factor()
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat="identity")

ggplot(pg_mean, aes(x=group, y=weight)) +
geom_bar(stat="identity", fill="lightblue", colour="black")


Map a variable to fill , and use geom_bar(position="dodge") .
In this example we’ll use the cabbage_exp data set, which has two categorical variables,
Cultivar and Date , and one continuous variable, Weight :
library(gcookbook) # For the data set
cabbage_exp
Cultivar Date Weight
c39 d16
3.18
c39 d20
2.80
c39 d21
2.74
c52 d16
2.26
c52 d20
3.11
c52 d21
1.47
We’ll map Date to the x position and map Cultivar to the fill color (Figure 3-4):
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
geom_bar(position="dodge")



ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
geom_bar(position="dodge")
page39
ggplot(diamonds,  aes(x=cut)) + geom_bar()
# Equivalent to using geom_bar(stat="bin")
ggplot(diamonds,  aes(x=cut)) + geom_bar(stat="bin")

geom_histogram() instead of geom_bar()

# Using Colors in a Bar Graph
library(gcookbook) # For the data set
upc <-  subset(uspopchange,  rank(Change)>40)
upc
ggplot(upc,  aes(x=Abb,  y=Change,  fill=Region)) + geom_bar(stat="identity" )


# The default colors aren’t very appealing, so you may want to set them, using
# scale_fill_brewer() or scale_fill_manual(). With this example, we’ll use the latter,
# and we’ll set the outline color of the bars to black, with colour="black"  (Figure 3-10).
# Note that setting occurs outside of aes(), while mapping occurs within aes():
ggplot(upc,  aes(x=reorder(Abb,  Change),  y=Change,  fill=Region)) +
geom_bar(stat="identity" ,  colour="black" ) +
scale_fill_manual(values=c("#669933" , "#FFCC66" )) +
xlab("State" )

ggplot(upc,  aes(x=reorder(Change,Abb),  y=Change,  fill=Region)) +
geom_bar(stat="identity" ,  colour="black" ) +
scale_fill_manual(values=c("#669933" , "#FFCC66" )) +
xlab("State" )


library(gcookbook) # For the data set
csub <-  subset(climate,  Source=="Berkeley" & Year >= 1900)
csub$pos <-  csub$Anomaly10y >= 0
# Notice that we use position="identity"  with the bars. This will prevent
# a warning message about stacking not being well defined for negative numbers:
ggplot(csub,  aes(x=Year,  y=Anomaly10y,  fill=pos)) +
 geom_bar(stat="identity" ,  position="identity" )

 ggplot(csub,  aes(x=Year,  y=Anomaly10y,  fill=pos)) +
 geom_bar(stat="identity"  )


#  We can change the colors with scale_fill_manual() and remove the legend with
# guide=FALSE, as shown in Figure 3-12. We’ll also add a thin black outline around each
# of the bars by setting colour and specifying size, which is the thickness of the outline,
# in millimeters:
ggplot(csub,  aes(x=Year,  y=Anomaly10y,  fill=pos)) +
 geom_bar(stat="identity" ,  position="identity" ,  colour="black" ,  size=0.25) +
 scale_fill_manual(values=c("#CCEEFF" , "#FFDDDD" ),  guide=FALSE)


 ggplot(csub,  aes(x=Year,  y=Anomaly10y,  fill=pos)) +
 geom_bar(stat="identity" ,  position="identity" ,  colour="black" ,  size=0.1) +
 scale_fill_manual(values=c("#CCEEFF" , "#FFDDDD" ),  guide=FALSE)


 ggplot(csub,  aes(x=Year,  y=Anomaly10y,  fill=pos)) +
 geom_bar(stat="identity" ,  position="identity" ,  colour="black" ,  size=1) +
 scale_fill_manual(values=c("#CCEEFF" , "#FFDDDD" ),  guide=FALSE)

  # Adjusting Bar Width and Spacing

  ggplot(pg_mean,  aes(x=group,  y=weight)) + geom_bar(stat="identity" )
For narrower bars:
ggplot(pg_mean,  aes(x=group,  y=weight)) + geom_bar(stat="identity" ,  width=0.5)
And for wider bars (these have the maximum width of 1):
ggplot(pg_mean,  aes(x=group,  y=weight)) + geom_bar(stat="identity" ,  width=1)

For grouped bars, the default is to have no space between bars within each group. To
add space between bars within a group, make width smaller and set the value for posi
tion_dodge to be larger than width (Figure 3-14).
For a grouped bar graph with narrow bars:
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  width=0.5,  position="dodge" )
And with some space between the bars:
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  width=0.5,  position=position_dodge(0.7))
The first graph used position="dodge" , and the second graph used position=posi
tion_dodge(). This is because position="dodge"  is simply shorthand for position=po
sition_dodge() with the default value of 0.9, but when we want to set a specific value,
we need to use the more verbose command.


All of these will have the same result:
geom_bar(position="dodge" )
geom_bar(width=0.9,  position=position_dodge())
geom_bar(position=position_dodge(0.9))
geom_bar(width=0.9,  position=position_dodge(width=0.9))

3.7. Making a Stacked Bar Graph
library(ggplot2)
library(gcookbook) # For the data set
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
 geom_bar(stat="identity" )


One problem with the default output is that the stacking order is the opposite of the
order of items in the legend. As shown in Figure 3-17, you can reverse the order of items
in the legend by using guides() and specifying the aesthetic for which the legend should
be reversed. In this case, it’s the fill aesthetic:


ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
 geom_bar(stat="identity" ) +
 guides(fill=guide_legend(reverse=TRUE))

 ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
 geom_bar(stat="identity" ) +
 guides(fill=guide_legend(reverse=F))


require(plyr) # Needed for desc()
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar,  order=desc(Cultivar))) +
 geom_bar(stat="identity" )

 require(plyr) # Needed for desc()
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar,  )) +
 geom_bar(stat="identity" )

 ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  colour="black" ) +
guides(fill=guide_legend(reverse=TRUE)) +
scale_fill_brewer(palette="Pastel1" )

For a more polished graph, we’ll keep the reversed legend order, use scale_fill_brew
er() to get a different color palette, and use colour="black"  to get a black outline
(Figure 3-19):
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  colour="black" ) +
guides(fill=guide_legend(reverse=TRUE)) +
scale_fill_brewer(palette="Pastel1" )

Making a Proportional Stacked Bar Graph


First, scale the data to 100% within each stack. This can be done by using ddply() from
the plyr package, with transform(). Then plot the resulting data, as shown in
Figure 3-20:
library(gcookbook) # For the data set
library(plyr)
# Do a group-wise transform(), splitting on "Date"
ce <-  ddply(cabbage_exp, "Date" ,  transform,
 percent_weight = Weight / sum(Weight) * 100)
ggplot(ce,  aes(x=Date,  y=percent_weight,  fill=Cultivar)) +
 geom_bar(stat="identity" )


 ggplot(ce,  aes(x=Date,  y=percent_weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  colour="black" ) +
guides(fill=guide_legend(reverse=TRUE)) +
scale_fill_brewer(palette="Pastel1" )

ggplot(ce,  aes(x=Date,  y=percent_weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  colour="black" ) +
scale_fill_brewer(palette="xxx" )

3.9. Adding Labels to a Bar Graph

# Below the top
ggplot(cabbage_exp,  aes(x=interaction(Date,  Cultivar),  y=Weight)) +
geom_bar(stat="identity" ) +
geom_text(aes(label=Weight),  vjust=1.5,  colour="white" )
# Above the top
ggplot(cabbage_exp,  aes(x=interaction(Date,  Cultivar),  y=Weight)) +
geom_bar(stat="identity" ) +
geom_text(aes(label=Weight),  vjust=-0.2)

ggplot(cabbage_exp,  aes(x=interaction(Date,  Cultivar),  y=Weight)) +
geom_bar(stat="identity" ) +
geom_text(aes(label=Weight),  vjust=0)

# Adjust y limits to be a little higher
ggplot(cabbage_exp,  aes(x=interaction(Date,  Cultivar),  y=Weight)) +
geom_bar(stat="identity" ) +
geom_text(aes(label=Weight),  vjust=-0.2) +
ylim(0,  max(cabbage_exp$Weight) * 1.05)
# Map y positions slightly above bar top - y range of plot will auto-adjust
ggplot(cabbage_exp,  aes(x=interaction(Date,  Cultivar),  y=Weight)) +
geom_bar(stat="identity" ) +
geom_text(aes(y=Weight+0.1,  label=Weight))




ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ,  position="dodge" ) +
geom_text(aes(label=Weight),  vjust=1.5,  colour="white" ,
position=position_dodge(.9),  size=3)

ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=sd)) +
geom_bar(stat="identity" ,  position="dodge" )


# Sort by the day and sex columns
ce <-  arrange(cabbage_exp,  Date,  Cultivar)

ce <-  ddply(ce, "Date" ,  transform,  label_y=cumsum(Weight))
ggplot(ce,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ) +
geom_text(aes(y=label_y,  label=Weight),  vjust=1.5,  colour="white" )



ce <-  arrange(cabbage_exp,  Date,  Cultivar)
# Calculate y position, placing it in the middle
ce <-  ddply(ce, "Date" ,  transform,  label_y=cumsum(Weight)- 0.5*Weight)
ggplot(ce,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(stat="identity" ) +
geom_text(aes(y=label_y,  label=Weight),  colour="white" )

ggplot(ce,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
 geom_bar(stat="identity" ,  colour="black" ) +
 geom_text(aes(y=label_y,  label=paste(format(Weight,  nsmall=2), "kg" )),
 size=4) +
 guides(fill=guide_legend(reverse=TRUE)) +
 scale_fill_brewer(palette="Pastel1" )


 3.10. Making a Cleveland Dot Plot
 tophit <-  tophitters2001[1: 25, ] # Take the top 25 from the tophitters data set
ggplot(tophit,  aes(x=avg,  y=name)) + geom_point()

tophit[,  c("name" , "lg" , "avg" )]

ggplot(tophit,  aes(x=avg,  y=reorder(name,  avg))) +
geom_point(size=3) + # Use a larger dot
theme_bw() +
theme(panel.grid.major.x = element_blank(),
panel.grid.minor.x = element_blank(),
panel.grid.major.y = element_line(colour="grey60" ,  linetype="dashed" ))


ggplot(tophit,  aes(x=reorder(name,  avg),  y=avg)) +
 geom_point(size=3) + # Use a larger dot
 theme_bw() +
 theme(axis.text.x = element_text(angle=60,  hjust=1),
 panel.grid.major.y = element_blank(),
 panel.grid.minor.y = element_blank(),
 panel.grid.major.x = element_line(colour="grey60" ,  linetype="dashed" ))


 ggplot(tophit,  aes(x=reorder(name,  avg),  y=avg)) +
 geom_point(size=3) + # Use a larger dot
 theme_bw() +
 theme(axis.text.x = element_text(angle=60,  hjust=1),
 panel.grid.major.y = element_blank(),
 panel.grid.minor.y = element_blank(),
 panel.grid.major.x = element_line(colour="blue" ,  linetype="dashed" ))


 # Get the names, sorted first by lg, then by avg
nameorder <-  tophit$name[order(tophit$lg,  tophit$avg)]
# Turn name into a factor, with levels in the order of nameorder
tophit$name <-  factor(tophit$name,  levels=nameorder)

ggplot(tophit,  aes(x=avg,  y=name)) +
geom_segment(aes(yend=name),  xend=0,  colour="grey50" ) +
geom_point(size=3,  aes(colour=lg)) +
scale_colour_brewer(palette="Set1" ,  limits=c("NL" , "AL" )) +
theme_bw() +
theme(panel.grid.major.y = element_blank(),  # No horizontal grid lines
legend.position=c(1, 0.55),  # Put legend inside plot area
legend.justification=c(1, 0.5))



ggplot(tophit,  aes(x=avg,  y=name)) +
geom_segment(aes(yend=name),  xend=0,  colour="grey50" ) +
geom_point(size=3,  aes(colour=lg)) +
scale_colour_brewer(palette="Set1" ,  limits=c("NL" , "AL" ),  guide=FALSE) +
 theme_bw() +
 theme(panel.grid.major.y = element_blank()) +
 facet_grid(lg ~ . ,  scales="free_y" ,  space="free_y" )



 Line graphs are typically used for visualizing how one continuous variable, on the yaxis, changes in relation to another continuous variable, on the x-axis. Often the x
variable represents time, but it may also represent some other continuous quantity, like
the amount of a drug administered to experimental subjects.
As with bar graphs, there are exceptions. Line graphs can also be used with a discrete
variable on the x-axis. This is appropriate when the variable is ordered (e.g., “small”,
“medium”, “large”), but not when the variable is unordered (e.g., “cow”, “goose”, “pig”).
Most of the examples in this chapter use a continuous x variable, but we’ll see one
example where the variable is converted to a factor and thus treated as a discrete variable.
4.1. Making a Basic Line Graph

ggplot(BOD,  aes(x=Time,  y=demand)) + geom_line()


Line graphs can be made with discrete (categorical) or continuous (numeric) variables
on the x-axis. In the example here, the variable demand is numeric, but it could be treated
as a categorical variable by converting it to a factor with factor() (Figure 4-2). When
the x variable is a factor, you must also use aes(group=1) to ensure that ggplot() knows
that the data points belong together and should be connected with a line (see Recipe 4.3
for an explanation of why group is needed with factors):
BOD1 <-  BOD # Make a copy of the data
BOD1$Time <-  factor(BOD1$Time)
ggplot(BOD1,  aes(x=Time,  y=demand,  group=1)) + geom_line()
ggplot(BOD1,  aes(x=Time,  y=demand,  group=2)) + geom_line()
ggplot(BOD1,  aes(x=Time,  y=demand)) + geom_line()


With ggplot2, the default y range of a line graph is just enough to include the y values
in the data. For some kinds of data, it’s better to have the y range start from zero. You
can use ylim() to set the range, or you can use expand_limits() to expand the range
to include a value. This will set the range from zero to the maximum value of the demand
column in BOD (Figure 4-3):
# These have the same result
ggplot(BOD,  aes(x=Time,  y=demand)) + geom_line() + ylim(0,  max(BOD$demand))
ggplot(BOD,  aes(x=Time,  y=demand)) + geom_line() + expand_limits(y=0)

4.2. Adding Points to a Line Graph

ggplot(BOD,  aes(x=Time,  y=demand)) + geom_line() + geom_point()

ggplot(worldpop,  aes(x=Year,  y=Population)) + geom_line() + geom_point()
# Same with a log y-axis
ggplot(worldpop,  aes(x=Year,  y=Population)) + geom_line() + geom_point() +
 scale_y_log10()

 Making a Line Graph with Multiple Lines

 In addition to the variables mapped to the x- and y-axes, map another (discrete) variable
to colour or linetype, as shown in Figure 4-6:
# Load plyr so we can use ddply() to create the example data set
library(plyr)
# Summarize the ToothGrowth data
tg <-  ddply(ToothGrowth,  c("supp" , "dose" ),  summarise,  length=mean(len))
# Map supp to colour
ggplot(tg,  aes(x=dose,  y=length,  colour=supp)) + geom_line()
# Map supp to linetype
ggplot(tg,  aes(x=dose,  y=length,  linetype=supp)) + geom_line()

If the x variable is a factor, you must also tell ggplot() to group by that
same variable, as described momentarily

This happens because there are multiple data points at each y location, and ggplot()
thinks they’re all in one group. The data points for each group are connected with a
single line, leading to the sawtooth pattern. If any discrete variables are mapped to aes‐
thetics like colour or linetype, they are automatically used as grouping variables. But
if you want to use other variables for grouping (that aren’t mapped to an aesthetic), they
should be used with group

If your plot has points along with the lines, you can also map variables to properties of
the points, such as shape and fill (Figure 4-9):
ggplot(tg,  aes(x=dose,  y=length,  shape=supp)) + geom_line() +
geom_point(size=4) # Make the points a little larger
ggplot(tg,  aes(x=dose,  y=length,  fill=supp)) + geom_line() +
geom_point(size=4,  shape=21) # Also use a point with a color fill


ggplot(tg,  aes(x=dose,  y=length,  shape=supp)) +
geom_line(position=position_dodge(0.2)) + # Dodge lines by 0.2
geom_point(position=position_dodge(0.2),  size=4) # Dodge points by 0.2

4.4. Changing the Appearance of Lines

The type of line (solid, dashed, dotted, etc.) is set with linetype, the thickness (in mm)
with size, and the color of the line with colour.
These properties can be set (as shown in Figure 4-11) by passing them values in the call
to geom_line():
ggplot(BOD,  aes(x=Time,  y=demand)) +
geom_line(linetype="dashed" ,  size=1,  colour="blue" )


# Load plyr so we can use ddply() to create the example data set
library(plyr)
# Summarize the ToothGrowth data
tg <-  ddply(ToothGrowth,  c("supp" , "dose" ),  summarise,  length=mean(len))
ggplot(tg,  aes(x=dose,  y=length,  colour=supp)) +
 geom_line() +
 scale_colour_brewer(palette="Set1" )



 To set a single constant color for all the lines, specify colour outside ofaes(). The same
works for size, linetype, and point shape (Figure 4-13). You may also have to specify
the grouping variable:
# If both lines have the same properties, you need to specify a variable to
# use for grouping
ggplot(tg,  aes(x=dose,  y=length,  group=supp)) +
geom_line(colour="darkgreen" ,  size=1.5)
# Since supp is mapped to colour, it will automatically be used for grouping
ggplot(tg,  aes(x=dose,  y=length,  colour=supp)) +
geom_line(linetype="dashed" ) +
geom_point(shape=22,  size=3,  fill="white" )


To set a single constant color for all the lines, specify colour outside ofaes(). The same
works for size, linetype, and point shape (Figure 4-13). You may also have to specify
the grouping variable:
# If both lines have the same properties, you need to specify a variable to
# use for grouping
ggplot(tg,  aes(x=dose,  y=length,  group=supp)) +
 geom_line(colour="darkgreen" ,  size=1.5)
# Since supp is mapped to colour, it will automatically be used for grouping
ggplot(tg,  aes(x=dose,  y=length,  colour=supp)) +
 geom_line(linetype="dashed" ) +
 geom_point(shape=22,  size=3,  fill="white" )

 Changing the Appearance of Points

 In geom_point(), set the size, shape, colour, and/or fill outside ofaes() (the result
is shown in Figure 4-14):
ggplot(BOD,  aes(x=Time,  y=demand)) +
 geom_line() +
 geom_point(size=4,  shape=22,  colour="darkred" ,  fill="pink" )

 ggplot(BOD,  aes(x=Time,  y=demand)) +
 geom_line() +
 geom_point(size=4,  shape=21,  fill="white" )


 # Load plyr so we can use ddply() to create the example data set
library(plyr)
# Summarize the ToothGrowth data
tg <-  ddply(ToothGrowth,  c("supp" , "dose" ),  summarise,  length=mean(len))
# Save the position_dodge specification because we'll use it multiple times
pd <-  position_dodge(0.2)
ggplot(tg,  aes(x=dose,  y=length,  fill=supp)) +
 geom_line(position=pd) +
 geom_point(shape=21,  size=3,  position=pd) +
 scale_fill_manual(values=c("black" , "white" ))

  Making a Graph with a Shaded Area

  Use geom_area() to get a shaded area, as in Figure 4-17:
# Convert the sunspot.year data set into a data frame for this example
sunspotyear <-  data.frame(
 Year = as.numeric(time(sunspot.year)),
 Sunspots = as.numeric(sunspot.year)
)
ggplot(sunspotyear,  aes(x=Year,  y=Sunspots)) + geom_area()



ggplot(sunspotyear,  aes(x=Year,  y=Sunspots)) +
geom_area(colour="black" ,  fill="blue" ,  alpha=.2)

4.7. Making a Stacked Area Graph
ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup)) + geom_area()
ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup)) + geom_bar(stat="identity")


The default order of legend items is the opposite of the stacking order. The legend can
be reversed by setting the breaks in the scale. This version of the chart (Figure 4-21)
reverses the legend order, changes the palette to a range of blues, and adds thin
(size=.2) lines between each area. It also makes the filled areas semitransparent
(alpha=.4), so that it is possible to see the grid lines through them:

ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup)) +
geom_area(colour="black" ,  size=.2,  alpha=.4) +
scale_fill_brewer(palette="Blues" ,  breaks=rev(levels(uspopage$AgeGroup)))

Since each filled area is drawn with a polygon, the outline includes the left and right
sides. This might be distracting or misleading. To get rid of it (Figure 4-23), first draw
the stacked areas without an outline (by leaving colour as the default NA value), and
then add a geom_line() on top:
ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup,  order=desc(AgeGroup))) +
geom_area(colour=NA,  alpha=.4) +
scale_fill_brewer(palette="Blues" ) +
geom_line(position="stack" ,  size=.2)


ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup,  order=rev(AgeGroup))) +
geom_area(colour=NA,  alpha=.4) +
scale_fill_brewer(palette="Blues" ) +
geom_line(position="stack" ,  size=.2)


4.8. Making a Proportional Stacked Area Graph

library(gcookbook) # For the data set
library(plyr) # For the ddply() function
# Convert Thousands to Percent
uspopage_prop <-  ddply(uspopage, "Year" ,  transform,
Percent = Thousands / sum(Thousands) * 100)
Once we’ve calculated the proportions, plotting is the same as with a regular stacked
area graph (Figure 4-24):
ggplot(uspopage_prop,  aes(x=Year,  y=Percent,  fill=AgeGroup)) +
geom_area(colour="black" ,  size=.2,  alpha=.4) +
scale_fill_brewer(palette="Blues" ,  breaks=rev(levels(uspopage$AgeGroup)))



4.9. Adding a Confidence Region
Problem
You want to add a confidence region to a graph.
Solution
Use geom_ribbon() and map values to ymin and ymax.
In the climate data set, Anomaly10y is a 10-year running average of the deviation (in
Celsius) from the average 1950–1980 temperature, and Unc10y is the 95% confidence
interval. We’ll set ymax and ymin to Anomaly10y plus or minus Unc10y (Figure 4-25):
library(gcookbook) # For the data set
# Grab a subset of the climate data
clim <-  subset(climate,  Source == "Berkeley" ,
select=c("Year" , "Anomaly10y" , "Unc10y" ))
clim
Year Anomaly10y Unc10y
1800 -0.435 0.505
1801 -0.453 0.493
1802 -0.460 0.486
...
2003 0.869 0.028
2004 0.884 0.029
# Shaded region
ggplot(clim,  aes(x=Year,  y=Anomaly10y)) +
geom_ribbon(aes(ymin=Anomaly10y- Unc10y,  ymax=Anomaly10y+Unc10y),
alpha=0.2) +
geom_line()

# With a dotted line for upper and lower bounds
ggplot(clim,  aes(x=Year,  y=Anomaly10y)) +
geom_line(aes(y=Anomaly10y- Unc10y),  colour="grey50" ,  linetype="dotted" ) +
geom_line(aes(y=Anomaly10y+Unc10y),  colour="grey50" ,  linetype="dotted" ) +
geom_line()


#############################

Scatter plots are used to display the relationship between two continuous variables. In
a scatter plot, each observation in a data set is represented by a point. Often, a scatter
plot will also have a line showing the predicted values based on some statistical model.
This is easy to do with R and ggplot2, and can help to make sense of data when the
trends aren’t immediately obvious just by looking at it.
With large data sets, it can be problematic to plot every single observation because the
points will be overplotted, obscuring one another. When this happens, you’ll probably
want to summarize the data before displaying it. We’ll also see how to do that in this
chapter.

####################################
5.1. Making a Basic Scatter Plot.

Use geom_point(), and map one variable to x and one to y.
In the heightweight data set, there are a number of columns, but we’ll only use two in
this example (Figure 5-1):
library(gcookbook) # For the data set
# List the two columns we'll use
heightweight[,  c("ageYear" , "heightIn" )]
ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) + geom_point()

To use different shapes in a scatter plot, set shape. A common alternative to the default
solid circles (shape #16) is hollow ones (#21), as seen in Figure 5-2 (left):
ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) + geom_point(shape=21)
The size of the points can be controlled with size. The default value of size is 2. The
following will set size=1.5, for smaller points (Figure 5-2, right):
ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) + geom_point(size=1.5)

5.2. Grouping Data Points by a Variable Using
Shape or Color
Problem
You want to group points by some variable, using shape or color.

library(gcookbook)
heightweight[, c("sex", "ageYear", "heightIn")]
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) + geom_point()


# The default shapes and colors may not be very appealing. Other shapes can be used with
# scale_shape_manual() , and other colors can be used with scale_colour_brewer() or
# scale_colour_manual() .
# This will set different shapes and colors for the grouping variables (Figure 5-5, right):
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex, colour=sex)) +
geom_point() +
scale_shape_manual(values=c(1,2)) +
scale_colour_brewer(palette="Set1")


5.3. Using Different Point Shapes
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(shape=3)

# Use slightly larger points and use a shape scale with custom values
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) +
geom_point(size=3) + scale_shape_manual(values=c(1, 4))

# Figure 5-7 shows the shapes that are available in R graphics. Some of the point shapes
# (1–14) have just an outline, some (15–20) are solid, and some (21–25) have an outline
# and fill that can be controlled separately. (You can also use characters for points.)
# For shapes 1–20, the color of the entire point—even the points that are solid—is con‐
# trolled by the colour aesthetic. For shapes 21–25, the outline is controlled by colour
# and the fill is controlled by fill .


# It’s possible to have the shape represent one variable and the fill (empty or solid) rep‐
# resent another variable. This is done a little indirectly, by choosing shapes that have both
# colour and fill , and a color palette that includes NA and another color (the NA will
# result in a hollow shape). For example, we’ll take the heightweight data set and add
# another column that indicates whether the child weighed 100 pounds or more
# (Figure 5-8):
# Make a copy of the data
hw <- heightweight
# Categorize into <100 and >=100 groups
hw$weightGroup <- cut(hw$weightLb, breaks=c(-Inf, 100, Inf),
labels=c("< 100", ">= 100"))
# Use shapes with fill and color, and use colors that are empty (NA) and
# filled
ggplot(hw, aes(x=ageYear, y=heightIn, shape=sex, fill=weightGroup)) +
geom_point(size=2.5) +
scale_shape_manual(values=c(21, 24)) +
scale_fill_manual(values=c(NA, "black"),
guide=guide_legend(override.aes=list(shape=21)))

5.4. Mapping a Continuous Variable to Color or Size

heightweight[, c("sex", "ageYear", "heightIn", "weightLb")]

ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb)) + geom_point()
ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb)) + geom_point()


represent only about 3.5 times the weight. If it is important for the sizes to proportionally
represent the quantities, you can change the range of sizes. By default the sizes of points
go from 1 to 6 mm. You could reduce the range to, say, 2 to 5 mm, with scale_size_con
tinuous(range=c(2, 5)) . However, the point size numbers don’t map linearly to di‐
ameter or area, so this still won’t give a very accurate representation of the values. (See
Recipe 5.12 for details on making the area of dots proportional to the value.)
When it comes to color, there are actually two aesthetic attributes that can be used:
colour and fill . For most point shapes, you use colour . However, shapes 21–25 have
an outline with a solid region in the middle where the color is controlled by fill . These
outlined shapes can be useful when using a color scale with light colors, as in
Figure 5-10, because the outline sets them off from the background. In this example, we
also set the fill gradient to go from black to white and make the points larger so that the
fill is easier to see:


ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
geom_point(shape=21, size=2.5) +
scale_fill_gradient(low="black", high="white")


# Using guide_legend() will result in a discrete legend instead of a colorbar
ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
geom_point(shape=21, size=2.5) +
scale_fill_gradient(low="black", high="white", breaks=12:17,
guide=guide_legend())

# size , and also map sex to colour . Because there is a fair amount of overplotting, we’ll
# make the points 50% transparent by setting alpha=.5 . We’ll also use scale
# _size_area() to make the area of the points proportional to the value (see
# Recipe 5.12), and change the color palette to one that is a little more appealing:
ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb, colour=sex)) +
geom_point(alpha=.5) +
scale_size_area() +
# Make area proportional to numeric value
scale_colour_brewer(palette="Set1")



Figure 5-11. Continuous variable mapped to size and categorical variable mapped to
colour
When a variable is mapped to size , it’s a good idea to not map a variable to shape . This
is because it is difficult to compare the sizes of different shapes; for example, a size 4
triangle could appear larger than a size 3.5 circle. Also, some of the shapes really are
different sizes: shapes 16 and 19 are both circles, but at any given numeric size, shape
19 circles are visually larger than shape 16 circles.
5.5. Dealing with Overplotting

If there’s a high degree of overplotting, there are a number of possible solutions:
• Make the points semitransparent
• Bin the data into rectangles (better for quantitative analysis)
• Bin the data into hexagons
• Use box plots

sp <- ggplot(diamonds, aes(x=carat, y=price))
sp + geom_point()
# We can make the points semitransparent using alpha , as in Figure 5-13. Here, we’ll make
# them 90% transparent and then 99% transparent, by setting alpha=.1 and alpha=.01 :
sp + geom_point(alpha=.1)
sp + geom_point(alpha=.01)


For most graphs, vector formats (such as PDF, EPS, and SVG) result
in smaller output files than bitmap formats (such as TIFF and PNG).
But in cases where there are tens of thousands of points, vector output
files can be very large and slow to render—the scatter plot here with
99% transparent points is 1.5 MB! In these cases, high-resolution bit‐
maps will be smaller and faster to display on computer screens. See
Chapter 14 for more information



# By default, stat_bin_2d() divides the space into 30 groups in the x and y directions,
# for a total of 900 bins. In the second version, we increase the number of bins with
# bins=50 .
# The default colors are somewhat difficult to distinguish because they don’t vary much
# in luminosity. In the second version we set the colors by using scale_fill_gradi
# ent() and specifying the low and high colors. By default, the legend doesn’t show an
# entry for the lowest values. This is because the range of the color scale starts not from
# zero, but from the smallest nonzero quantity in a bin—probably 1, in this case. To make
# the legend show a zero (as in Figure 5-14, right), we can manually set the range from 0
# to the maximum, 6000, using limits (Figure 5-14, left):
sp + stat_bin2d()
sp + stat_bin2d(bins=50) +
scale_fill_gradient(low="lightblue", high="red", limits=c(0, 6000))
# Another alternative is to bin the data into hexagons instead of rectangles, with stat_bin
# hex() (Figure 5-15). It works just like stat_bin2d() . To use it, you must first install the
# hexbin package, with install.packages("hexbin") :
library(hexbin)
sp + stat_binhex() +
scale_fill_gradient(low="lightblue", high="red",
limits=c(0, 8000))


sp + stat_binhex() +
scale_fill_gradient(low="lightblue", high="red",
breaks=c(0, 250, 500, 1000, 2000, 4000, 6000),
limits=c(0, 6000))



# Overplotting can also occur when the data is discrete on one or both axes, as shown in
# Figure 5-16. In these cases, you can randomly jitter the points with position_jit
# ter() . By default the amount of jitter is 40% of the resolution of the data in each direc‐
# tion, but these amounts can be controlled with width and height :
sp1 <- ggplot(ChickWeight, aes(x=Time, y=weight))
sp1 + geom_point()
sp1 + geom_point(position="jitter")
# Could also use geom_jitter(), which is equivalent
sp1 + geom_point(position=position_jitter(width=.5, height=0))

5.6. Adding Fitted Regression Model Lines

library(gcookbook) # For the data set
# The base plot
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + stat_smooth(method=lm)

# 99% confidence region
sp + geom_point() + stat_smooth(method=lm, level=0.99)
# No confidence region
sp + geom_point() + stat_smooth(method=lm, se=FALSE)


sp + geom_point(colour="grey60" ) +
stat_smooth(method=lm,  se=FALSE,  colour="black" )

sp + geom_point(colour="grey60" ) +
stat_smooth(method=lm,  se=FALSE )

sp + geom_point(colour="grey60" ) + stat_smooth()
The linear regression line is not the only way of fitting a model to the data—in fact, it’s
not even the default. If you add stat_smooth() without specifying the method, it will
use a loess (locally weighted polynomial) curve, as shown in Figure 5-19. Both of these
will have the same result:
sp + geom_point(colour="grey60" ) + stat_smooth()
sp + geom_point(colour="grey60" ) + stat_smooth(method=loess)

library(MASS) # For the data set
b <-  biopsy
b$classn[b$class=="benign" ]  <- 0
b$classn[b$class=="malignant" ] <- 1

ggplot(b,  aes(x=V1,  y=classn)) +
geom_point(position=position_jitter(width=0.3,  height=0.06),  alpha=0.4,
shape=21,  size=1.5) +
stat_smooth(method=glm,  family=binomial)


If your scatter plot has points grouped by a factor, using colour or shape, one fit line
will be drawn for each group. First we’ll make the base plot object sps, then we’ll add
the loess lines to it. We’ll also make the points less prominent by making them semi‐
transparent, using alpha=.4 (Figure 5-21):
sps <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) +
geom_point() +
scale_colour_brewer(palette="Set1" )
sps + geom_smooth()

If you want the lines to extrapolate from the data, as shown in the right-hand image of
Figure 5-21, you must use a model method that allows extrapolation, like lm(), and pass
stat_smooth() the option fullrange=TRUE:
sps + geom_smooth(method=lm,  se=FALSE,  fullrange=TRUE)

5.7. Adding Fitted Lines from an Existing Model

In this example, we’ll build a quadratic model using lm() with ageYear as a predictor
of heightIn. Then we’ll use the predict() function and find the predicted values of
heightIn across the range of values for the predictor, ageYear:
library(gcookbook) # For the data set
model <-  lm(heightIn ~ ageYear + I(ageYear^2),  heightweight)
model
Call:
lm(formula = heightIn ~ ageYear + I(ageYear^2), data = heightweight)
Coefficients:
 (Intercept) ageYear I(ageYear^2)
 -10.3136 8.6673 -0.2478
# Create a data frame with ageYear column, interpolating across range
xmin <-  min(heightweight$ageYear)
xmax <-  max(heightweight$ageYear)
predicted <-  data.frame(ageYear=seq(xmin,  xmax,  length.out=100))
# Calculate predicted values of heightIn
predicted$heightIn <-  predict(model,  predicted)
predicted
 ageYear heightIn
 11.58000 56.82624
 11.63980 57.00047
 ...
 17.44020 65.47875
 17.50000 65.47933

 sp <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) +
geom_point(colour="grey40" )
sp + geom_line(data=predicted,  size=1)


# Given a model, predict values of yvar from xvar
# This supports one predictor and one predicted variable
# xrange: If NULL, determine the x range from the model object. If a vector with
# two numbers, use those as the min and max of the prediction range.
# samples: Number of samples across the x range.
# ...: Further arguments to be passed to predict()
predictvals <- function(model,  xvar,  yvar,  xrange=NULL,  samples=100, ... ) {
# If xrange isn't passed in, determine xrange from the models.
# Different ways of extracting the x range, depending on model type
if (is.null(xrange)) {
if (any(class(model) %in% c("lm" , "glm" )))
xrange <-  range(model$model[[xvar]])
else if (any(class(model) %in% "loess" ))
xrange <-  range(model$x)
}
newdata <-  data.frame(x = seq(xrange[1],  xrange[2],  length.out = samples))
names(newdata) <-  xvar
newdata[[yvar]] <-  predict(model,  newdata = newdata, ... )
newdata
}

modlinear <-  lm(heightIn ~ ageYear,  heightweight)
modloess <-  loess(heightIn ~ ageYear,  heightweight)
lm_predicted <-  predictvals(modlinear, "ageYear" , "heightIn" )
loess_predicted <-  predictvals(modloess, "ageYear" , "heightIn" )
sp + geom_line(data=lm_predicted,  colour="red" ,  size=.8) +
geom_line(data=loess_predicted,  colour="blue" ,  size=.8)

library(MASS) # For the data set
b <-  biopsy
b$classn[b$class=="benign" ]  <- 0
b$classn[b$class=="malignant" ] <- 1

fitlogistic <-  glm(classn ~ V1,  b,  family=binomial)
# Get predicted values
glm_predicted <-  predictvals(fitlogistic, "V1" , "classn" ,  type="response" )
ggplot(b,  aes(x=V1,  y=classn)) +
geom_point(position=position_jitter(width=.3,  height=.08),  alpha=0.4,
shape=21,  size=1.5) +
geom_line(data=glm_predicted,  colour="#1177FF" ,  size=1)


5.8. Adding Fitted Lines from Multiple Existing Models

With the heightweight data set, we’ll make a linear model with lm() for each of the
levels of sex, and put those model objects in a list. The model building is done with a
function, make_model(), defined here. If you pass it a data frame, it simply returns an
lm object. The model can be customized for your data:
make_model <- function(data) {
lm(heightIn ~ ageYear,  data)
}
With this function, we can use the dlply() function to build a model for each subset of
data. This will split the data frame into subsets by the grouping variable sex, and apply
make_model() to each subset. In this case, the heightweight data will be split into two
data frames, one for males and one for females, and make_model() will be run on each
subset. With dlply(), the models are put into a list and the list is returned:
library(gcookbook) # For the data set
library(plyr)
models <-  dlply(heightweight, "sex" , .fun = make_model)
# Print out the list of two lm objects, f and m
models
$f
Call:
lm(formula = heightIn ~ ageYear, data = data)
Coefficients:
(Intercept) ageYear
43.963 1.209
$m
Call:
lm(formula = heightIn ~ ageYear, data = data)
Coefficients:
(Intercept) ageYear
30.658 2.301
attr(,"split_type")
[1] "data.frame"
attr(,"split_labels")
sex
1 f
2 m
Now that we have the list of model objects, we can run predictvals() to get predicted
values from each model, using the ldply() function:
predvals <-  ldply(models, .fun=predictvals,  xvar="ageYear" ,  yvar="heightIn" )
predvals
sex ageYear heightIn
f 11.58000 57.96250
f 11.63980 58.03478
f 11.69960 58.10707
...
m 17.38040 70.64912
m 17.44020 70.78671
m 17.50000 70.92430
Finally, we can plot the data with the predicted values (Figure 5-24):
ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) +
geom_point() + geom_line(data=predvals)


predictvals <- function(model,  xvar,  yvar,  xrange=NULL,  samples=100, ... ) {
# If xrange isn't passed in, determine xrange from the models.
# Different ways of extracting the x range, depending on model type
if (is.null(xrange)) {
if (any(class(model) %in% c("lm" , "glm" )))
xrange <-  range(model$model[[xvar]])
else if (any(class(model) %in% "loess" ))
xrange <-  range(model$x)
}
newdata <-  data.frame(x = seq(xrange[1],  xrange[2],  length.out = samples))
names(newdata) <-  xvar
newdata[[yvar]] <-  predict(model,  newdata = newdata, ... )
newdata
}


# First generate prediction data
pred <-  predictvals(model, "ageYear" , "heightIn" )
sp <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) + geom_point() +
geom_line(data=pred)
sp + annotate("text" ,  label="r^2=0.42" ,  x=16.5,  y=52)



Instead of using a plain text string, it’s also possible to enter formulas using R’s math
expression syntax, by setting parse=TRUE:
sp + annotate("text" ,  label="r^2 == 0.42" ,  parse = TRUE,  x=16.5,  y=52)



Text geoms in ggplot2 do not take expression objects directly; instead, they take char‐
acter strings that are turned into expressions with parse(text="a + b").
If you use a math expression, the syntax must be correct for it to be a valid R expression
object. You can test validity by wrapping it in expression() and seeing if it throws an
error (make sure not to use quotes around the expression). In the example here, == is a
valid construct in an expression to express equality, but = is not:
expression(r^2 == 0.42) # Valid
expression(r^2 == 0.42)
expression(r^2 = 0.42) # Not valid
Error: unexpected '=' in "expression(r^2 ="
It’s possible to automatically extract values from the model object and build an expres‐
sion using those values. In this example, we’ll create a string that, when parsed, returns
a valid expression:
eqn <-  as.character(as.expression(
 substitute(italic(y) == a + b * italic(x) * ","  ~~ italic(r)^2 ~ "="  ~ r2,
 list(a = format(coef(model)[1],  digits=3),
 b = format(coef(model)[2],  digits=3),
 r2 = format(summary(model)$r.squared,  digits=2)
 ))))
eqn
"italic(y) == \"37.4\" + \"1.75\" * italic(x) * \",\" ~ ~italic(r)^2 ~ \"=\" ~
\"0.42\""
parse(text=eqn) # Parsing turns it into an expression
expression(italic(y) == "37.4" + "1.75" * italic(x) * "," ~ ~italic(r)^2 ~ "=" ~
"0.42")
Now that we have the expression string, we can add it to the plot. In this example we’ll
put the text in the bottom-right corner, by setting x=Inf and y=-Inf and using horizontal
and vertical adjustments so that the text all fits inside the plotting area (Figure 5-27):
sp + annotate("text" ,  label=eqn,  parse=TRUE,  x=Inf,  y=- Inf,  hjust=1.1,  vjust=- .5)

5.10. Adding Marginal Rugs to a Scatter Plot
ggplot(faithful,  aes(x=eruptions,  y=waiting)) + geom_point() + geom_rug()

c1<-seq(10)
c2<-rep(1,10)
c2
cbind(c1,c2)
df<-cbind(c1,c2)
class(df)
df<-as.data.frame(df)
df<-rbind(df,c(2,1))
df<-as.data.frame(df)
ggplot(df,  aes(x=c1,  y=c2)) + geom_point() + geom_rug()

ggplot(faithful,  aes(x=eruptions,  y=waiting)) + geom_point() +
geom_rug(position="jitter" ,  size=.2)
5.11. Labeling Points in a Scatter Plot

subset(countries,  Year==2009 & healthexp>2000)

For annotating just one or a few points, you can use annotate() or geom_text(). For
this example, we’ll use the countries data set and visualize the relationship between
health expenditures and infant mortality rate per 1,000 live births. To keep things man‐
ageable, we’ll just take the subset of countries that spent more than $2000 USD per capita:
library(gcookbook) # For the data set
subset(countries,  Year==2009 & healthexp>2000)
Name Code Year GDP laborrate healthexp infmortality
Andorra AND 2009 NA NA 3089.636 3.1
Australia AUS 2009 42130.82 65.2 3867.429 4.2
Austria AUT 2009 45555.43 60.4 5037.311 3.6
...
United Kingdom GBR 2009 35163.41 62.2 3285.050 4.7
United States USA 2009 45744.56 65.0 7410.163 6.6
We’ll save the basic scatter plot object in sp and add then add things to it. To manually
add annotations, use annotate(), and specify the coordinates and label (Figure 5-30,
left). It may require some trial-and-error tweaking to get them positioned just right:
sp <-  ggplot(subset(countries,  Year==2009 & healthexp>2000),
aes(x=healthexp,  y=infmortality)) +geom_point()

sp + annotate("text" ,  x=4350,  y=5.4,  label="Canada" ) +
 annotate("text" ,  x=7400,  y=6.8,  label="USA" )

 sp + geom_text(aes(label=Name),  size=4,  vjust=0)

 # Add a little extra to y
sp + geom_text(aes(y=infmortality+.1,  label=Name),  size=4,  vjust=0)

sp + geom_text(aes(label=Name),  size=4,  hjust=0)
sp + geom_text(aes(x=healthexp+100,  label=Name),  size=4,  hjust=0)

It often makes sense to right- or left-justify the labels relative to the points. To left-justify,
set hjust=0 (Figure 5-32, left), and to right-justify, set hjust=1. As was the case with
vjust, the labels will still slightly overlap with the points. This time, though, it’s not a
good idea to try to fix it by increasing or decreasing hjust. Doing so will shift the labels
a distance proportional to the length of the label, making longer labels move further
than shorter ones. It’s better to just set hjust to 0 or 1, and then add or subtract a bit to
or from x (Figure 5-32, right):
sp + geom_text(aes(label=Name),  size=4,  hjust=0)
sp + geom_text(aes(x=healthexp+100,  label=Name),  size=4,  hjust=0)


Next, we’ll use the %in% operator to find where each name that we want to keep is. This
returns a logical vector indicating which entries in the first vector, cdat$Name1, are
present in the second vector, in which we specify the names of the countries we want to
show:
idx <-  cdat$Name1 %in% c("Canada" , "Ireland" , "United Kingdom" , "United States" ,
 "New Zealand" , "Iceland" , "Japan" , "Luxembourg" ,
 "Netherlands" , "Switzerland" )
idx

## The intersection of two sets can be defined via match():
## Simple version:
## intersect <- function(x, y) y[match(x, y, nomatch = 0)]
intersect # the R function in base is slightly more careful
intersect(1:10, 7:20)

1:10 %in% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","%")
sstr[sstr %in% c(letters, LETTERS)]

"%w/o%" <- function(x, y) x[!x %in% y] #--  x without y
(1:10) %w/o% c(3,7,12)
## Note that setdiff() is very similar and typically makes more sense: 
        c(1:6,7:2) %w/o% c(3,7,12)  # -> keeps duplicates
setdiff(c(1:6,7:2),        c(3,7,12)) # -> unique values


cdat$Name1[!idx] <- NA

ggplot(cdat,  aes(x=healthexp,  y=infmortality)) +
geom_point() +
geom_text(aes(x=healthexp+100,  label=Name1),  size=4,  hjust=0) +
xlim(2000, 10000)


You want to make a balloon plot, where the area of the dots is proportional to their
numerical value.
Solution
Use geom_point() with scale_size_area(). For this example, we’ll use a subset of the
countries data set:
library(gcookbook) # For the data set
cdat <-  subset(countries,  Year==2009 &
 Name %in% c("Canada" , "Ireland" , "United Kingdom" , "United States" ,
 "New Zealand" , "Iceland" , "Japan" , "Luxembourg" ,
 "Netherlands" , "Switzerland" ))

 Balloon Plot


 If we just map GDP to size, the value of GDP gets mapped to the radius of the dots
(Figure 5-34, left), which is not what we want; a doubling of value results in a quadrupling
of area, and this will distort the interpretation of the data. We instead want to map it to
the area, and we can do this using scale_size_area() (Figure 5-34, right):
p <-  ggplot(cdat,  aes(x=healthexp,  y=infmortality,  size=GDP)) +
geom_point(shape=21,  colour="black" ,  fill="cornsilk" )
# GDP mapped to radius (default with scale_size_continuous)
p
# GDP mapped to area instead, and larger circles
p + scale_size_area(max_size=15)

# Add up counts for male and female
hec <-  HairEyeColor[,, "Male" ] + HairEyeColor[,, "Female" ]
# Convert to long format
library(reshape2)
hec <-  melt(hec,  value.name="count" )
ggplot(hec,  aes(x=Eye,  y=Hair)) +
geom_point(aes(size=count),  shape=21,  colour="black" ,  fill="cornsilk" ) +
scale_size_area(max_size=20,  guide=FALSE) +
geom_text(aes(y=as.numeric(Hair)- sqrt(count)/22,  label=count),  vjust=1,
colour="grey60" ,  size=4)



5.13. Making a Scatter Plot Matrix
Problem
You want to make a scatter plot matrix.
Solution
A scatter plot matrix is an excellent way of visualizing the pairwise relationships among
several variables. To make one, use the pairs() function from R’s base graphics.
For this example, we’ll use a subset of the countries data set. We’ll pull out the data for
the year 2009, and keep only the columns that are relevant:
library(gcookbook) # For the data set
c2009 <-  subset(countries,  Year==2009,
select=c(Name,  GDP,  laborrate,  healthexp,  infmortality))

panel.cor <- function(x,  y,  digits=2,  prefix="" ,  cex.cor, ... ) {
usr <-  par("usr" )
on.exit(par(usr))
par(usr = c(0, 1, 0, 1))
r <-  abs(cor(x,  y,  use="complete.obs" ))
txt <-  format(c(r, 0.123456789),  digits=digits)[1]
txt <-  paste(prefix,  txt,  sep="" )
if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
text(0.5, 0.5,  txt,  cex = cex.cor * (1 + r) / 2)
}

panel.hist <- function(x, ... ) {
usr <-  par("usr" )
on.exit(par(usr))
par(usr = c(usr[1: 2], 0, 1.5) )
h <-  hist(x,  plot = FALSE)
breaks <-  h$breaks
nB <-  length(breaks)
y <-  h$counts
y <-  y/max(y)
rect(breaks[- nB], 0,  breaks[-1],  y,  col="white" , ... )
}

pairs(c2009[, 2: 5],  upper.panel = panel.cor,
diag.panel = panel.hist,
lower.panel = panel.smooth)


panel.lm <- function (x,  y,  col = par("col" ),  bg = NA,  pch = par("pch" ),
cex = 1,  col.smooth = "black" , ... ) {
points(x,  y,  pch = pch,  col = col,  bg = bg,  cex = cex)
abline(stats:: lm(y ~ x),  col = col.smooth, ... )
}

pairs(c2009[, 2: 5],  pch="." ,
upper.panel = panel.cor,
diag.panel = panel.hist,
lower.panel = panel.lm)


6.1. Making a Basic Histogram

Use geom_histogram() and map a continuous variable to x (Figure 6-1):
ggplot(faithful,  aes(x=waiting)) + geom_histogram()

ggplot(faithful,  aes(x=waiting)) + geom_histogram()
# Store the values in a simple vector
w <-  faithful$waiting
ggplot(NULL,  aes(x=w)) + geom_histogram()

# Set the width of each bin to 5
ggplot(faithful,  aes(x=waiting)) +
geom_histogram(binwidth=1,  fill="white" ,  colour="black" )

diff(range(faithful$waiting))/15


Sometimes the appearance of the histogram will be very dependent on the width of the
bins and where exactly the boundaries between bins are. In Figure 6-3, we’ll use a bin
width of 8. In the version on the left, we’ll use the origin parameter to put boundaries
at 31, 39, 47, etc., while in the version on the right, we’ll shift it over by 4, putting
boundaries at 35, 43, 51, etc.

h <-  ggplot(faithful,  aes(x=waiting)) # Save the base object for reuse
h + geom_histogram(binwidth=8,  fill="white" ,  colour="black" ,  boundary=31)
h + geom_histogram(binwidth=8,  fill="white" ,  colour="black" ,  boundary=35)


h + geom_bar(stat="bin")


6.2. Making Multiple Histograms from Grouped Data

You want to make histograms of multiple groups of data.
Solution
Use geom_histogram() and use facets for each group, as shown in Figure 6-4:
library(MASS) # For the data set
# Use smoke as the faceting variable
ggplot(birthwt,  aes(x=bwt)) + geom_histogram(fill="white" ,  colour="black" ) +
facet_grid(smoke ~ . )


birthwt1 <-  birthwt # Make a copy of the data
# Convert smoke to a factor
birthwt1$smoke <-  factor(birthwt1$smoke)
levels(birthwt1$smoke)
"0" "1"
library(plyr) # For the revalue() function
birthwt1$smoke <-  revalue(birthwt1$smoke,  c("0" ="No Smoke" , "1" ="Smoke" ))
Now when we plot it again, it shows the new labels (Figure 6-4, right).
ggplot(birthwt1,  aes(x=bwt)) + geom_histogram(fill="white" ,  colour="black" ) +
facet_grid(smoke ~ . )

birthwt1 <- birthwt # Make a copy of the data
# Convert smoke to a factor
birthwt1$smoke <- factor(birthwt1$smoke)
levels(birthwt1$smoke)


Now when we plot it again, it shows the new labels (Figure 6-4, right).
ggplot(birthwt1, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
facet_grid(smoke ~ .)
With facets, the axes have the same y scaling in each facet. If your groups have different
sizes, it might be hard to compare the shapes of the distributions of each one. For ex‐
ample, see what happens when we facet the birth weights by race (Figure 6-5, left):
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
facet_grid(race ~ .)
To allow the y scales to be resized independently (Figure 6-5, right), use
scales="free" . Note that this will only allow the y scales to be free—the x scales will
still be fixed because the histograms are aligned with respect to that axis:
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
facet_grid(race ~ ., scales="free")


Another approach is to map the grouping variable to fill , as shown in Figure 6-6. The
grouping variable must be a factor or character vector. In the birthwt data set, the
desired grouping variable, smoke , is stored as a number, so we’ll use the birthwt1 data
set we created above, in which smoke is a factor:
# Convert smoke to a factor
birthwt1$smoke <- factor(birthwt1$smoke)
# Map smoke to fill, make the bars NOT stacked, and make them semitransparent


ggplot(birthwt1, aes(x=bwt, fill=smoke)) +
geom_histogram(position="identity", alpha=0.4)


ggplot(birthwt1, aes(x=bwt, fill=smoke)) +
geom_histogram(alpha=0.4)


The position="identity" is important. Without it, ggplot() will stack the histogram
bars on top of each other vertically, making it much more difficult to see the distribution
of each group.


Making a Density Curve
ggplot(faithful, aes(x=waiting)) + geom_histogram()
You want to make a kernel density curve.
Solution
Use geom_density() and map a continuous variable to x (Figure 6-7):
ggplot(faithful, aes(x=waiting)) + geom_density()
If you don’t like the lines along the side and bottom, you can use geom_line(stat="den
sity") (see Figure 6-7, right):
# The expand_limits() increases the y range to include the value 0
ggplot(faithful, aes(x=waiting)) + geom_line(stat="density") +
expand_limits(y=0)


Like geom_histogram() , geom_density() requires just one column from a data frame.
For this example, we’ll use the faithful data set, which contains data about the Old
Faithful geyser in two columns: eruptions , which is the length of each eruption, and
waiting , which is the length of time to the next eruption. We’ll only use the waiting
column in this example:

The second method mentioned earlier uses geom_line() and tells it to use the "densi
ty" statistical transformation. This is essentially the same as the first method, using
geom_density() , except the former draws it with a closed polygon.
As with geom_histogram() , if you just want to get a quick look at data that isn’t in a data
frame, you can get the same result by passing in NULL for the data frame and giving
ggplot() a vector of values. This would have the same result as the first solution:
# Store the values in a simple vector
w <- faithful$waiting
ggplot(NULL, aes(x=w)) + geom_density()
A kernel density curve is an estimate of the population distribution, based on the sample
data. The amount of smoothing depends on the kernel bandwidth: the larger the band‐
width, the more smoothing there is. The bandwidth can be set with the adjust param‐
eter, which has a default value of 1. Figure 6-8 shows what happens with a smaller and
larger value of adjust :
ggplot(faithful, aes(x=waiting)) +
geom_line(stat="density", adjust=.25, colour="red") +
geom_line(stat="density") +
geom_line(stat="density", adjust=2, colour="blue")
In this example, the x range is automatically set so that it contains the data, but this
results in the edge of the curve getting clipped. To show more of the curve, set the x
limits (Figure 6-9). We’ll also add an 80% transparent fill with alpha=.2 :
ggplot(faithful, aes(x=waiting)) +
geom_density(fill="blue", alpha=.2) +
xlim(35, 105)
# This draws a blue polygon with geom_density(), then adds a line on top
ggplot(faithful, aes(x=waiting)) +
geom_density(fill="blue", colour=NA, alpha=.2) +
geom_line(stat="density") +
xlim(35, 105)
If this edge-clipping happens with your data, it might mean that your curve is too
smooth—if the curve is wider than your data, it might not be the best model of your
data. Or it could be because you have a small data set.



ggplot(faithful, aes(x=waiting)) +
geom_density(fill="blue", colour=NA, alpha=.2) +
geom_line(stat="density",adjust=2) +
xlim(35, 105)

To compare the theoretical and observed distributions, you can overlay the density curve
with the histogram. Since the y values for the density curve are small (the area under
the curve always sums to 1), it would be barely visible if you overlaid it on a histogram
without any transformation. To solve this problem, you can scale down the histogram
to match the density curve with the mapping y=..density.. . Here we’ll add geom_his
togram() first, and then layer geom_density() on top (Figure 6-10):
ggplot(faithful, aes(x=waiting, y=..density..)) +
geom_histogram(fill="cornsilk", colour="grey60", size=.2) +
geom_density() +
xlim(35, 105)

6.4. Making Multiple Density Curves from Grouped Data
Use geom_density() , and map the grouping variable to an aesthetic like colour or
fill , as shown in Figure 6-11. The grouping variable must be a factor or character vector.
In the birthwt data set, the desired grouping variable, smoke , is stored as a number, so
we have to convert it to a factor first:
library(MASS) # For the data set
# Make a copy of the data
birthwt1 <- birthwt
# Convert smoke to a factor
birthwt1$smoke <- factor(birthwt1$smoke)
# Map smoke to colour

ggplot(birthwt1, aes(x=bwt, colour=smoke)) + geom_density()
# Map smoke to fill and make the fill semitransparent by setting alpha
ggplot(birthwt1, aes(x=bwt, fill=smoke)) + geom_density(alpha=.3)


To make these plots, the data must all be in one data frame, with one column containing
a categorical variable used for grouping.
For this example, we used the birthwt data set. It contains data about birth weights and
a number of risk factors for low birth weight:
birthwt
low age lwt race smoke ptl ht ui ftv bwt
0 19 182
2
0
0 0 1
0 2523
0 33 155
3
0
0 0 0
3 2551
0 20 105
1
1
0 0 0
1 2557
...
We looked at the relationship between smoke (smoking) and bwt (birth weight in grams).
The value of smoke is either 0 or 1, but since it’s stored as a numeric vector, ggplot()
doesn’t know that it should be treated as a categorical variable. To make it so ggplot()
knows to treat smoke as categorical, we can either convert that column of the data frame
to a factor, or tell ggplot() to treat it as a factor by using factor(smoke) inside of the
aes() statement. For these examples, we converted it to a factor in the data.
Another method for visualizing the distributions is to use facets, as shown in
Figure 6-12. We can align the facets vertically or horizontally. Here we’ll align them
vertically so that it’s easy to compare the two distributions:

ggplot(birthwt1, aes(x=bwt)) + geom_density() + facet_grid(smoke ~ .)	

One problem with the faceted graph is that the facet labels are just 0 and 1, and there’s
no label indicating that those values are for smoke . To change the labels, we need to
change the names of the factor levels. First we’ll take a look at the factor levels, then we’ll
assign new factor level names, in the same order:
levels(birthwt1$smoke)
"0" "1"
library(plyr) # For the revalue function
birthwt1$smoke <- revalue(birthwt1$smoke, c("0"="No Smoke", "1"="Smoke"))
Now when we plot it again, it shows the new labels (Figure 6-12, right):
ggplot(birthwt1, aes(x=bwt)) + geom_density() + facet_grid(smoke ~ .)
If you want to see the histograms along with the density curves, the best option is to use
facets, since other methods of visualizing both histograms in a single graph can be
difficult to interpret. To do this, map y=..density.. , so that the histogram is scaled
down to the height of the density curves. In this example, we’ll also make the histogram
bars a little less prominent by changing the colors (Figure 6-13):
ggplot(birthwt1, aes(x=bwt, y=..density..)) +
geom_histogram(binwidth=200, fill="cornsilk", colour="grey60", size=.2) +
geom_density() +
facet_grid(smoke ~ .)


levels(birthwt1$smoke)
"0" "1"
library(plyr) # For the revalue function
birthwt1$smoke <- revalue(birthwt1$smoke, c("0"="No Smoke", "1"="Smoke"))


ggplot(birthwt1, aes(x=bwt)) + geom_density() + facet_grid(smoke ~ .)
If you want to see the histograms along with the density curves, the best option is to use
facets, since other methods of visualizing both histograms in a single graph can be
difficult to interpret. To do this, map y=..density.. , so that the histogram is scaled
down to the height of the density curves. In this example, we’ll also make the histogram
bars a little less prominent by changing the colors (Figure 6-13):
ggplot(birthwt1, aes(x=bwt, y=..density..)) +
geom_histogram(binwidth=200, fill="cornsilk", colour="grey60", size=.2) +
geom_density() +
facet_grid(smoke ~ .)


6.5. Making a Frequency Polygon
Problem
You want to make a frequency polygon.
Solution
Use geom_freqpoly() (Figure 6-14):
ggplot(faithful, aes(x=waiting)) + geom_freqpoly()

Also like a histogram, you can control the bin width for the frequency polygon
(Figure 6-14, right):
ggplot(faithful, aes(x=waiting)) + geom_freqpoly(binwidth=4)

Or, instead of setting the width of each bin directly, you can divide the x range into a
particular number of bins:
# Use 15 bins
binsize <- diff(range(faithful$waiting))/15
ggplot(faithful, aes(x=waiting)) + geom_freqpoly(binwidth=binsize)

6.6. Making a Basic Box Plot
Problem
You want to make a box (or box-and-whiskers) plot.
Solution
Use geom_boxplot() , mapping a continuous variable to y and a discrete variable to x
(Figure 6-15):
library(MASS) # For the data set
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot()
# Use factor() to convert numeric variable to discrete


A box plot consists of a box and “whiskers.” The box goes from the 25th percentile to
the 75th percentile of the data, also known as the inter-quartile range (IQR). There’s a
line indicating the median, or 50th percentile of the data. The whiskers start from the
edge of the box and extend to the furthest data point that is within 1.5 times the IQR.
If there are any data points that are past the ends of the whiskers, they are considered
outliers and displayed with dots. Figure 6-16 shows the relationship between a histo‐
gram, a density curve, and a box plot, using a skewed data set.

To change the width of the boxes, you can set width (Figure 6-17, left):
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot(width=.5)

If there are many outliers and there is overplotting, you can change the size and shape
of the outlier points with outlier.size and outlier.shape . The default size is 2 and
the default shape is 16. This will use smaller points, and hollow circles (Figure 6-17,
right):
ggplot(birthwt, aes(x=factor(race), y=bwt)) +
geom_boxplot(outlier.size=1.5, outlier.shape=21)

To make a box plot of just a single group, we have to provide some arbitrary value for
x ; otherwise, ggplot() won’t know what x coordinate to use for the box plot. In this
case, we’ll set it to 1 and remove the x-axis tick markers and label (Figure 6-18):
ggplot(birthwt, aes(x=1, y=bwt)) + geom_boxplot() +
scale_x_continuous(breaks=NULL) +
theme(axis.title.x = element_blank())


ggplot(birthwt, aes(x=1, y=bwt)) + geom_boxplot() +
scale_x_continuous(breaks=NULL) +
 labs(x = "Vehicle Weight", y = "Miles per Gallon") ## add title X Y



 	6.7. Adding Notches to a Box Plot
Problem
You want to add notches to a box plot to assess whether the medians are different.
Solution
Use geom_boxplot() and set notch=TRUE (Figure 6-19):
library(MASS) # For the data set
ggplot(birthwt, aes(x=factor(race), y=bwt)) + geom_boxplot(notch=TRUE)



6.8. Adding Means to a Box Plot
Problem
You want to add markers for the mean to a box plot.
Solution
Use stat_summary(). The mean is often shown with a diamond, so we’ll use shape 23
with a white fill. We’ll also make the diamond slightly larger by setting size=3
(Figure 6-20):

library(MASS) # For the data set
ggplot(birthwt,  aes(x=factor(race),  y=bwt)) + geom_boxplot() +
stat_summary(fun.y="mean" ,  geom="point" ,  shape=23,  size=3,  fill="white" )


ggplot(birthwt,  aes(x=factor(race),  y=bwt)) + geom_boxplot() + stat_summary(fun.y = mean, fun.ymin = min, fun.ymax = max,
  colour = "red")


6.9. Making a Violin Plot
Problem
You want to make a violin plot to compare density estimates of different groups.
Solution
Use geom_violin() (Figure 6-21):
library(gcookbook) # For the data set
# Base plot
p <-  ggplot(heightweight,  aes(x=sex,  y=heightIn))
p + geom_violin()
p + geom_violin() + geom_boxplot(width=.1,  fill="black" ,  outlier.colour=NA) +
stat_summary(fun.y=median,  geom="point" ,  fill="white" ,  shape=21,  size=2.5)

p + geom_violin() + 
geom_boxplot(width=.1,  fill="black" ,  outlier.colour="red") +
stat_summary(fun.y=median,  geom="point" ,  fill="white" ,  shape=21,  size=2.5)


p + geom_violin() + 
geom_boxplot(width=.1,    outlier.colour="red") +
stat_summary(fun.y=median,  geom="point" ,  fill="white" ,  shape=21,  size=2.5)

p + geom_violin(trim=FALSE)

By default, the violins are scaled so that the total area of each one is the same (if
trim=TRUE, then it scales what the area would be including the tails). Instead of equal
areas, you can use scale="count"  to scale the areas proportionally to the number of
observations in each group (Figure 6-24). In this example, there are slightly fewer fe‐
males than males, so the f violin is slightly narrower:

# Scaled area proportional to number of observations
p + geom_violin(scale="count" )

To change the amount of smoothing, use the adjust parameter, as described in
Recipe 6.3. The default value is 1; use larger values for more smoothing and smaller
values for less smoothing

# More smoothing
p + geom_violin(adjust=2)
# Less smoothing
p + geom_violin(adjust=.5)
p + geom_violin(adjust=.1)

6.10. Making a Dot Plot
Problem
You want to make a Wilkinson dot plot, which shows each data point.
Solution
Use geom_dotplot(). For this example (Figure 6-26), we’ll use a subset of the coun
tries data set:
library(gcookbook) # For the data set
countries2009 <-  subset(countries,  Year==2009 & healthexp>2000)
p <-  ggplot(countries2009,  aes(x=infmortality))
p + geom_dotplot()

This kind of dot plot is sometimes called a Wilkinson dot plot. It’s different from the
Cleveland dot plots shown in Recipe 3.10. In these dot plots, the placement of the bins
depends on the data, and the width of each dot corresponds to the maximum width of
each bin. The maximum bin size defaults to 1/30 of the range of the data, but it can be
changed with binwidth.
By default, geom_dotplot() bins the data along the x-axis and stacks on the y-axis. The
dots are stacked visually, and for reasons related to technical limitations of ggplot2, the
resulting graph has y-axis tick marks that aren’t meaningful. The y-axis labels can be
removed by using scale_y_continuous(). In this example, we’ll also use geom_rug()
to show exactly where each data point is (Fig

	frm_test_html("http://stockpage.10jqka.com.cn/600825/finance/#alter")
re1<-frm_test_html("http://stockpage.10jqka.com.cn/600825/finance/#alter")[[1]]
# re1[[5]]%>%htmlTable
lapply(re1,htmlTable)%>%frm_try


This kind of dot plot is sometimes called a Wilkinson dot plot. It’s different from the
Cleveland dot plots shown in Recipe 3.10. In these dot plots, the placement of the bins
depends on the data, and the width of each dot corresponds to the maximum width of
each bin. The maximum bin size defaults to 1/30 of the range of the data, but it can be
changed with binwidth.
By default, geom_dotplot() bins the data along the x-axis and stacks on the y-axis. The
dots are stacked visually, and for reasons related to technical limitations of ggplot2, the
resulting graph has y-axis tick marks that aren’t meaningful. The y-axis labels can be
removed by using scale_y_continuous(). In this example, we’ll also use geom_rug()
to show exactly where each data point is (Figure 6-27):
p + geom_dotplot(binwidth=.25) + geom_rug() +
scale_y_continuous(breaks=NULL) + # Remove tick markers
theme(axis.title.y=element_blank()) # Remove axis label

The dots can also be stacked centered, or centered in such a way that stacks with even
and odd quantities stay aligned. This can by done by setting stackdir="center" or
stackdir="centerwhole" , as illustrated in Figure 6-29:
p + geom_dotplot(binwidth=.25,  stackdir="center" )
 scale_y_continuous(breaks=NULL) + theme(axis.title.y=element_blank())
p + geom_dotplot(binwidth=.25,  stackdir="centerwhole" )
 scale_y_continuous(breaks=NULL) + theme(axis.title.y=element_blank())

 To compare multiple groups, it’s possible to stack the dots along the y-axis, and group
them along the x-axis, by setting binaxis="y" . For this example, we’ll use the height
weight data set (Figure 6-30):
library(gcookbook) # For the data set
ggplot(heightweight,  aes(x=sex,  y=heightIn)) +
 geom_dotplot(binaxis="y" ,  binwidth=.5,  stackdir="center" )

 Dot plots are sometimes overlaid on box plots. In these cases, it may be helpful to make
the dots hollow and have the box plots not show outliers, since the outlier points will be
shown as part of the dot plot (Figure 6-31):
ggplot(heightweight,  aes(x=sex,  y=heightIn)) +
 geom_boxplot(outlier.colour=NA,  width=.4) +
 geom_dotplot(binaxis="y" ,  binwidth=.5,  stackdir="center" ,  fill=NA)
It’s also possible to show the dot plots next to the box plots, as shown in Figure 6-32.
This requires using a bit of a hack, by treating the x variable as a numeric variable and
subtracting or adding a small quantity to shift the box plots and dot plots left and right.

When the x variable is treated as numeric you must also specify the group, or else the
data will be treated as a single group, with just one box plot and dot plot. Finally, since
the x-axis is treated as numeric, it will by default show numbers for the x-axis tick labels;
they must be modified with scale_x_continuous() to show x tick labels as text corre‐
sponding to the factor levels:
ggplot(heightweight,  aes(x=sex,  y=heightIn)) +
 geom_boxplot(aes(x=as.numeric(sex) + .2,  group=sex),  width=.25) +
 geom_dotplot(aes(x=as.numeric(sex) - .2,  group=sex),  binaxis="y" ,
 binwidth=.5,  stackdir="center" ) +
 scale_x_continuous(breaks=1:nlevels(heightweight$sex),
 labels=levels(heightweight$sex))



 6.12. Making a Density Plot of Two-Dimensional Data
Problem
You want to plot the density of two-dimensional (2D) data.
Solution
Use stat_density2d(). This makes a 2D kernel density estimate from the data. First
we’ll plot the density contour along with the data points (Figure 6-33, left):
# The base plot
p <-  ggplot(faithful,  aes(x=eruptions,  y=waiting))
p + geom_point() + stat_density2d()

It’s also possible to map the height of the density curve to the color of the contour lines,
by using ..level..  (Figure 6-33, right):
# Contour lines, with "height" mapped to color
p + stat_density2d(aes(colour=.. level.. ))

Discussion
The two-dimensional kernel density estimate is analogous to the one-dimensional den‐
sity estimate generated by stat_density(), but of course, it needs to be viewed in a
different way. The default is to use contour lines, but it’s also possible to use tiles and
map the density estimate to the fill color, or to the transparency of the tiles, as shown
in Figure 6-34:
# Map density estimate to fill color
p + stat_density2d(aes(fill=.. density.. ),  geom="raster" ,  contour=FALSE)
# With points, and map density estimate to alpha
p + geom_point() +
stat_density2d(aes(alpha=.. density.. ),  geom="tile" ,  contour=FALSE)
We used geom="raster"  in the first of the preceding examples and
geom="tile"  in the second. The main difference is that the raster geom
renders more efficiently than the tile geom. In theory they should appear
the same, but in practice they often do not. If you are writing to a PDF
file, the appearance depends on the PDF viewer. On some viewers, when
tile is used there may be faint lines between the tiles, and when ras
ter is used the edges of the tiles may appear blurry (although it doesn’t
matter in this particular case).

7.1. Adding Text Annotations
Problem
You want to add a text annotation to a plot.
Solution
Use annotate() and a text geom (Figure 7-1):
p <-  ggplot(faithful,  aes(x=eruptions,  y=waiting)) + geom_point()
p + annotate("text" ,  x=3,  y=48,  label="Group 1" ) +
annotate("text" ,  x=4.5,  y=66,  label="Group 2" )
Discussion
The annotate() function can be used to add any type of geometric object. In this case,
we used geom="text" .
Other text properties can be specified, as shown in Figure 7-2:

p + annotate("text" ,  x=- Inf,  y=Inf,  label="Upper left" ,  hjust=- .2,  vjust=2) +
annotate("text" ,  x=mean(range(faithful$eruptions)),  y=- Inf,  vjust=-0.4,
label="Bottom middle" )

7.2. Using Mathematical Expressions in Annotations
Problem
You want to add a text annotation with mathematical notation.
Solution
Use annotate(geom="text") and set parse=TRUE (Figure 7-5):
# A normal curve
p <-  ggplot(data.frame(x=c(-3, 3)),  aes(x=x)) + stat_function(fun = dnorm)
p + annotate("text" ,  x=2,  y=0.3,  parse=TRUE,
label="frac(1, sqrt(2 * pi)) * e ^ {-x^2 / 2}" )

Mathematical expressions made with text geoms using parse=TRUE in ggplot2 have a
format similar to those made with plotmath and expression in base R, except that they
are stored as strings, rather than as expression objects.
To mix regular text with expressions, use single quotes within double quotes (or vice
versa) to mark the plain-text parts. Each block of text enclosed by the inner quotes is
treated as a variable in a mathematical expression. Bear in mind that, in R’s syntax for
mathematical expressions, you can’t simply put a variable right next to another without
something else in between. To display two variables next to each other, as in
Figure 7-6, put a * operator between them; when displayed in a graphic, this is treated
as an invisible multiplication sign (for a visible multiplication sign, use %*%):
p + annotate("text" ,  x=0,  y=0.05,  parse=TRUE,  size=4,
 label="'Function: ' * y==frac(1, sqrt(2*pi)) * e^{-x^2/2}" )


7.3. Adding Lines

Solution
For horizontal and vertical lines, use geom_hline() and geom_vline(), and for angled
lines, use geom_abline() (Figure 7-7). For this example, we’ll use the heightweight
data set:
library(gcookbook) # For the data set
p <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) + geom_point()
# Add horizontal and vertical lines
p + geom_hline(yintercept=60) + geom_vline(xintercept=14)
# Add angled line
p + geom_abline(intercept=37.4,  slope=1.75)

Discussion
The previous examples demonstrate setting the positions of the lines manually, resulting
in one line drawn for each geom added. It is also possible to map values from the data
to xintercept, yintercept, and so on, and even draw them from another data frame.
Here we’ll take the average height for males and females and store it in a data frame,
hw_means. Then we’ll draw a horizontal line for each, and set the linetype and size
(Figure 7-8):
library(plyr) # For the ddply() function
hw_means <-  ddply(heightweight, "sex" ,  summarise,  heightIn=mean(heightIn))
hw_means
 sex heightIn
 f 60.52613
 m 62.06000
p + geom_hline(aes(yintercept=heightIn,  colour=sex),  data=hw_means,
 linetype="dashed" ,  size=1)
If one of the axes is discrete rather than continuous, you can’t specify the intercepts as
just a character string—they must still be specified as numbers. If the axis represents a
factor, the first level has a numeric value of 1, the second level has a value of 2, and so
on. You can specify the numerical intercept manually, or calculate the numerical value
using which(levels(...)) (Figure 7-9):
pg <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_point()
pg + geom_vline(xintercept = 2)
pg + geom_vline(xintercept = which(levels(PlantGrowth$group)=="ctrl" ))

The previous examples demonstrate setting the positions of the lines manually, resulting
in one line drawn for each geom added. It is also possible to map values from the data
to xintercept, yintercept, and so on, and even draw them from another data frame.
Here we’ll take the average height for males and females and store it in a data frame,
hw_means. Then we’ll draw a horizontal line for each, and set the linetype and size
(Figure 7-8):
library(plyr) # For the ddply() function
hw_means <-  ddply(heightweight, "sex" ,  summarise,  heightIn=mean(heightIn))
hw_means
 sex heightIn
 f 60.52613
 m 62.06000
p + geom_hline(aes(yintercept=heightIn,  colour=sex),  data=hw_means,
 linetype="dashed" ,  size=1)
If one of the axes is discrete rather than continuous, you can’t specify the intercepts as
just a character string—they must still be specified as numbers. If the axis represents a
factor, the first level has a numeric value of 1, the second level has a value of 2, and so
on. You can specify the numerical intercept manually, or calculate the numerical value
using which(levels(...)) (Figure 7-9):
pg <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_point()
pg + geom_vline(xintercept = 2)
pg + geom_vline(xintercept = which(levels(PlantGrowth$group)=="ctrl" ))


7.4. Adding Line Segments and Arrows
Problem
You want to add line segments or arrows to a plot.
Solution
Use annotate("segment"). In this example, we’ll use the climate data set and use a
subset of data from the Berkeley source (Figure 7-10):
library(gcookbook) # For the data set
p <-  ggplot(subset(climate,  Source=="Berkeley" ),  aes(x=Year,  y=Anomaly10y)) +
geom_line()
p + annotate("segment" ,  x=1950,  xend=1980,  y=- .25,  yend=- .25)

p + annotate("segment" ,  x=1950,  xend=1980,  y=- .25,  yend= .25)

p + annotate("segment" ,  x=1850,  xend=1820,  y=- .8,  yend=- .95,  colour="blue" ,
size=2,  arrow=arrow()) +
annotate("segment" ,  x=1950,  xend=1980,  y=- .25,  yend=- .25,
arrow=arrow(ends="both" ,  angle=90,  length=unit(.2, "cm" )))

7.5. Adding a Shaded Rectangle
Problem
You want to add a shaded region.
Solution
Use annotate("rect") (Figure 7-12):
library(gcookbook) # For the data set
p <-  ggplot(subset(climate,  Source=="Berkeley" ),  aes(x=Year,  y=Anomaly10y)) +
geom_line()
p + annotate("rect" ,  xmin=1950,  xmax=1980,  ymin=-1,  ymax=1,  alpha=.1,
fill="blue" )

p + annotate("rect" ,  xmin=1950,  xmax=1980,  ymin=-Inf,  ymax=Inf,  alpha=.1,
fill="blue" )


7.6. Highlighting an Item
Problem
You want to change the color of an item to make it stand out.
Solution
To highlight one or more items, create a new column in the data and map it to the color.
In this example, we’ll create a new column, hl, and set its value based on the value of
group:
pg <-  PlantGrowth # Make a copy of the PlantGrowth data
pg$hl <- "no"  # Set all to "no"
pg$hl[pg$group=="trt2" ] <- "yes"  # If group is "trt2", set to "yes"
Then we’ll plot it with manually specified colors and with no legend (Figure 7-13):

ggplot(pg,  aes(x=group,  y=weight,  fill=hl)) + geom_boxplot() +
scale_fill_manual(values=c("grey85" , "#FFDDCC" ),  guide=FALSE)

ggplot(pg,  aes(x=group,  y=weight,  fill=hl)) + geom_boxplot() +
scale_fill_manual(values=c("grey85" , "#FFDDCC" ))


7.7. Adding Error Bars
Problem
You want to add error bars to a graph.
Solution
Use geom_errorbar and map variables to the values for ymin and ymax. Adding the error
bars is done the same way for bar graphs and line graphs, as shown in Figure 7-14 (notice
that default y range is different for bars and lines, though):
library(gcookbook) # For the data set
# Take a subset of the cabbage_exp data for this example
ce <-  subset(cabbage_exp,  Cultivar == "c39" )
# With a bar graph
ggplot(ce,  aes(x=Date,  y=Weight)) +
 geom_bar(fill="white" ,  colour="black" ) +
 geom_errorbar(aes(ymin=Weight- se,  ymax=Weight+se),  width=.2)
# With a line graph
ggplot(ce,  aes(x=Date,  y=Weight)) +
 geom_line(aes(group=1)) +
 geom_point(size=4) +
 geom_errorbar(aes(ymin=Weight- se,  ymax=Weight+se),  width=.2)
net start AS2CONNECT
 
 
 pd <-  position_dodge(.3) # Save the dodge spec because we use it repeatedly
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  colour=Cultivar,  group=Cultivar)) +
 geom_errorbar(aes(ymin=Weight- se,  ymax=Weight+se),
 width=.2,  size=0.25,  colour="black" ,  position=pd) +
 geom_line(position=pd) +
 geom_point(position=pd,  size=2.5)


 7.8. Adding Annotations to Individual Facets
Problem
You want to add annotations to each facet in a plot.
Solution
Create a new data frame with the faceting variable(s), and a value to use in each facet.
Then use geom_text() with the new data frame (Figure 7-17):

# The base plot
p <-  ggplot(mpg,  aes(x=displ,  y=hwy)) + geom_point() + facet_grid(.  ~ drv)
# A data frame with labels for each facet
f_labels <-  data.frame(drv = c("4" , "f" , "r" ),  label = c("4wd" , "Front" , "Rear" ))
p + geom_text(x=6,  y=40,  aes(label=label),  data=f_labels)
# If you use annotate(), the label will appear in all facets
p + annotate("text" ,  x=6,  y=42,  label="label text" )

# This function returns a data frame with strings representing the regression
# equation, and the r^2 value
# These strings will be treated as R math expressions
lm_labels <- function(dat) {
mod <-  lm(hwy ~ displ,  data=dat)
formula <-  sprintf("italic(y) == %.2f %+.2f * italic(x)" ,
round(coef(mod)[1], 2),  round(coef(mod)[2], 2))
r <-  cor(dat$displ,  dat$hwy)
r2 <-  sprintf("italic(R^2) == %.2f" ,  r^2)
data.frame(formula=formula,  r2=r2,  stringsAsFactors=FALSE)
}
library(plyr) # For the ddply() function
labels <-  ddply(mpg, "drv" ,  lm_labels)
labels
drv formula r2
4 italic(y) == 30.68 -2.88 * italic(x) italic(R^2) == 0.65
f italic(y) == 37.38 -3.60 * italic(x) italic(R^2) == 0.36
r italic(y) == 25.78 -0.92 * italic(x) italic(R^2) == 0.04
# Plot with formula and R^2 values
p + geom_smooth(method=lm,  se=FALSE) +
geom_text(x=3,  y=40,  aes(label=formula),  data=labels,  parse=TRUE,  hjust=0) +
geom_text(x=3,  y=35,  aes(label=r2),  data=labels,  parse=TRUE,  hjust=0)


# Find r^2 values for each group
labels <-  ddply(mpg, "drv" ,  summarise,  r2 = cor(displ,  hwy)^2)
labels$r2 <-  sprintf("italic(R^2) == %.2f" ,  labels$r2)

8.1. Swapping X- and Y-Axes
Problem
You want to swap the x- and y-axes on a graph.
Solution
Use coord_flip() to flip the axes (Figure 8-1):
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() + coord_flip()


Sometimes when the axes are swapped, the order of items will be the reverse of what
you want. On a graph with standard x- and y-axes, the x items start at the left and go to
the right, which corresponds to the normal way of reading, from left to right. When you
swap the axes, the items still go from the origin outward, which in this case will be from
bottom to top—but this conflicts with the normal way of reading, from top to bottom.
Sometimes this is a problem, and sometimes it isn’t. If the x variable is a factor, the order
can be reversed by using scale_x_discrete() with limits=rev(levels(...)), as in
Figure 8-2:
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() + coord_flip() +
 scale_x_discrete(limits=rev(levels(PlantGrowth$group)))

 8.2. Setting the Range of a Continuous Axis
Problem
You want to set the range (or limits) of an axis.
Solution
You can use xlim() or ylim() to set the minimum and maximum values of a continuous
axis. Figure 8-3 shows one graph with the default y limits, and one with manually set y
limits:

p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
# Display the basic graph
p
p + ylim(0,  max(PlantGrowth$weight))

Discussion
ylim() is shorthand for setting the limits with scale_y_continuous(). (The same is
true for xlim() and scale_x_continuous().) The following are equivalent:
ylim(0, 10)
scale_y_continuous(limits=c(0, 10))
Sometimes you will need to set other properties ofscale_y_continuous(), and in these
cases using xlim() and scale_y_continuous() together may result in some unexpected
behavior, because only the first of the directives will have an effect. In these two exam‐
ples, ylim(0, 10) should set the y range from 0 to 10, and scale_y_continu
ous(breaks=c(0, 5, 10)) should put tick marks at 0, 5, and 10. However, in both cases,
only the second directive has any effect:
p + ylim(0, 10) + scale_y_continuous(breaks=NULL)
p + scale_y_continuous(breaks=NULL) + ylim(0, 10)
To make both changes work, get rid of ylim() and set both limits and breaks in
scale_y_continuous():
p + scale_y_continuous(limits=c(0, 10),  breaks=NULL)
In ggplot2, there are two ways of setting the range of the axes. The first way is to modify
the scale, and the second is to apply a coordinate transform. When you modify the limits
of the x or y scale, any data outside of the limits is removed—that is, the out-of-range
data is not only not displayed, it is removed from consideration entirely.
With the box plots in these examples, if you restrict the y range so that some of the
original data is clipped, the box plot statistics will be computed based on clipped data,
and the shape of the box plots will change.
With a coordinate transform, the data is not clipped; in essence, it zooms in or out to
the specified range. Figure 8-4 shows the difference between the two methods:
p + scale_y_continuous(limits = c(5, 6.5)) # Same as using ylim()
p + coord_cartesian(ylim = c(5, 6.5))
Finally, it’s also possible to expand the range in one direction, using expand_limits()
(Figure 8-5). You can’t use this to shrink the range, however:
p + expand_limits(y=0)

8.3. Reversing a Continuous Axis

Solution
Use scale_y_reverse or scale_x_reverse (Figure 8-6). The direction of an axis can
also be reversed by specifying the limits in reversed order, with the maximum first, then
the minimum:
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() + scale_y_reverse()
# Similar effect by specifying limits in reversed order
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() + ylim(6.5, 3.5)
Like scale_y_continuous(), scale_y_reverse() does not work with ylim. (The same
is true for the x-axis properties.) If you want to reverse an axis and set its range, you
must do it within the scale_y_reverse() statement, by setting the limits in reversed
order (Figure 8-7):
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() +
scale_y_reverse(limits=c(8, 0))

8.4. Changing the Order of Items on a Categorical Axis

For a categorical (or discrete) axis—one with a factor mapped to it—the order of items
can be changed by setting limits in scale_x_discrete() or scale_y_discrete().
To manually set the order of items on the axis, specify limits with a vector of the levels
in the desired order. You can also omit items with this vector, as shown in Figure 8-8:
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
p + scale_x_discrete(limits=c("trt1" , "ctrl" , "trt2" ))
Discussion
You can also use this method to display a subset of the items on the axis. This will show
only ctrl and trt1 (Figure 8-8, right):
p + scale_x_discrete(limits=c("ctrl" , "trt1" ))
To reverse the order, set limits=rev(levels(...)), and put the factor inside. This will
reverse the order of the PlantGrowth$group factor, as shown in Figure 8-9:
p + scale_x_discrete(limits=rev(levels(PlantGrowth$group)))


p + scale_x_discrete(limits=c("trt" , "ctrl1" , "trt2" ))

p + scale_x_discrete(limits=c("ctrl" , "trt1" ))


8.5. Setting the Scaling Ratio of the X- and Y-Axes
Problem
You want to set the ratio at which the x- and y-axes are scaled.

Use coord_fixed(). This will result in a 1:1 scaling between the x- and y-axes, as shown
in Figure 8-10:
library(gcookbook) # For the data set
sp <-  ggplot(marathon,  aes(x=Half, y=Full)) + geom_point()
sp + coord_fixed()

Discussion
The marathon data set contains runners’ marathon and half-marathon times. In this
case it might be useful to force the x- and y-axes to have the same scaling.
It’s also helpful to set the tick spacing to be the same, by setting breaks in scale_y_con
tinuous() and scale_x_continuous() (also in Figure 8-10):

sp + coord_fixed() +
scale_y_continuous(breaks=seq(0, 420, 30)) +
scale_x_continuous(breaks=seq(0, 420, 30))
If, instead of an equal ratio, you want some other fixed ratio between the axes, set the
ratio parameter. With the marathon data, we might want the axis with half-marathon
times stretched out to twice that of the axis with the marathon times (Figure 8-11). We’ll
also add tick marks twice as often on the x-axis:
sp + coord_fixed(ratio=1/2) +
 scale_y_continuous(breaks=seq(0, 420, 30)) +
 scale_x_continuous(breaks=seq(0, 420, 15))
华硕（ASUS）D552WA6010 15.6英寸笔记本电脑（E1-6010 4G 500G 核芯显卡）黑色 华硕(ASUS)笔记本 AMD AP

 8.6. Setting the Positions of Tick Marks
Problem
You want to set where the tick marks appear on the axis.
Solution
Usually ggplot() does a good job of deciding where to put the tick marks, but if you
want to change them, set breaks in the scale (Figure 8-12):
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() +
 scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6, 8))

 # Set both breaks and labels for a discrete axis
ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() +
scale_x_discrete(limits=c("trt2" , "ctrl" ),  breaks="ctrl" )

8.7. Removing Tick Marks and Labels


To remove just the tick labels, as in Figure 8-14 (left), use theme(axis.text.y = ele
ment_blank()) (or do the same for axis.text.x). This will work for both continuous
and categorical axes:
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
p + theme(axis.text.y = element_blank())


p + theme(axis.ticks = element_blank(),  axis.text.y = element_blank())

p + scale_y_continuous(breaks=NULL)


8.8. Changing the Text of Tick Labels
Problem
You want to change the text of tick labels.
Solution
Consider the scatter plot in Figure 8-15, where height is reported in inches:
library(gcookbook) # For the data set
hwp <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) +
 geom_point()
hwp
To set arbitrary labels, as in Figure 8-15 (right), pass values to breaks and labels in the
scale. One of the labels has a newline (\n) character, which tells ggplot() to put a line
break there:
hwp + scale_y_continuous(breaks=c(50, 56, 60, 66, 72),
 labels=c("Tiny" , "Really\nshort" , "Short" ,
 "Medium" , "Tallish" ))

 Discussion
Instead of setting completely arbitrary labels, it is more common to have your data stored
in one format, while wanting the labels to be displayed in another. We might, for ex‐
ample, want heights to be displayed in feet and inches (like 5’6”) instead of just inches.
To do this, we can define a formatter function, which takes in a value and returns the
corresponding string. For example, this function will convert inches to feet and inches:
footinch_formatter <- function(x) {
foot <-  floor(x/12)
inch <-  x %% 12
return(paste(foot, "'" ,  inch, "\"", sep="" ))
}
Here’s what it returns for values 56–64 (the backslashes are there as escape characters,
to distinguish the quotes in a string from the quotes that delimit a string):
footinch_formatter(56: 64)
"4'8\"" "4'9\"" "4'10\"" "4'11\"" "5'0\"" "5'1\"" "5'2\"" "5'3\"" "5'4\""
Now we can pass our function to the scale, using the labels parameter (Figure 8-16):
hwp + scale_y_continuous(labels=footinch_formatter)
Here, the automatic tick marks were placed every five inches, but that looks a little off
for this data. We can instead have ggplot() set tick marks every four inches, by speci‐
fying breaks (Figure 8-16, right):
hwp + scale_y_continuous(breaks=seq(48, 72, 4),  labels=footinch_formatter)
Another common task is to convert time measurements to HH:MM:SS format, or
something similar. This function will take numeric minutes and convert them to this
format, rounding to the nearest second (it can be customized for your particular needs):
timeHMS_formatter <- function(x) {
h <-  floor(x/60)
m <-  floor(x %% 60)
s <-  round(60*(x %% 1)) # Round to nearest second
lab <-  sprintf("%02d:%02d:%02d" ,  h,  m,  s) # Format the strings as HH:MM:SS
lab <-  gsub("^00:" , "" ,  lab) # Remove leading 00: if present
lab <-  gsub("^0" , "" ,  lab) # Remove leading 0 if present
return(lab)
}
Running it on some sample numbers yields:
timeHMS_formatter(c(.33, 50, 51.25, 59.32, 60, 60.1, 130.23))
"0:20" "50:00" "51:15" "59:19" "1:00:00" "1:00:06" "2:10:14"
The scales package, which is installed with ggplot2, comes with some built-in formatting
functions:


• comma() adds commas to numbers, in the thousand, million, billion, etc. places.
• dollar() adds a dollar sign and rounds to the nearest cent.
• percent() multiplies by 100, rounds to the nearest integer, and adds a percent sign.
• scientific() gives numbers in scientific notation, like 3.30e+05, for large and
small numbers.
8.9. Changing the Appearance of Tick Labels
Problem
You want to change the appearance of tick labels.
Solution
In Figure 8-17 (left), we’ve manually set the labels to be long—long enough that they
overlap:
bp <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot() +
scale_x_discrete(breaks=c("ctrl" , "trt1" , "trt2" ),
labels=c("Control" , "Treatment 1" , "Treatment 2" ))
bp

To rotate the text 90 degrees counterclockwise (Figure 8-17, middle), use:
bp + theme(axis.text.x = element_text(angle=90,  hjust=1,  vjust=.5))
Rotating the text 30 degrees (Figure 8-17, right) uses less vertical space and makes the
labels easier to read without tilting your head:
bp + theme(axis.text.x = element_text(angle=30,  hjust=1,  vjust=1))


The hjust and vjust settings specify the horizontal alignment (left/center/right) and
vertical alignment (top/middle/bottom).
Discussion
Besides rotation, other text properties, such as size, style (bold/italic/normal), and the
font family (such as Times or Helvetica) can be set with element_text(), as shown in
Figure 8-18:
bp + theme(axis.text.x = element_text(family="Times" ,  face="italic" ,
colour="darkred" ,  size=rel(0.9)))
In this example, the size is set to rel(0.9), which means that it is 0.9 times the size of
the base font size for the theme.
These commands control the appearance of only the tick labels, on only one axis. They
don’t affect the other axis, the axis label, the overall title, or the legend. To control all of
these at once, you can use the theming system, as discussed in Recipe 9.3.



8.10. Changing the Text of Axis Labels
Problem
You want to change the text of axis labels.
Solution
Use xlab() or ylab() to change the text of the axis labels (Figure 8-19):
library(gcookbook) # For the data set
hwp <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) +
geom_point()
# With default axis labels
hwp
# Set the axis labels
hwp + xlab("Age in years" ) + ylab("Height in inches" )

By default the graphs will just use the column names from the data frame as axis labels.
This might be fine for exploring data, but for presenting it, you may want more de‐
scriptive axis labels.
Instead of xlab() and ylab(), you can use labs():
hwp + labs(x = "Age in years" ,  y = "Height in inches" )


Another way of setting the axis labels is in the scale specification, like this:
hwp + scale_x_continuous(name="Age in years" )
This may look a bit awkward, but it can be useful if you’re also setting other properties
of the scale, such as the tick mark placement, range, and so on.
This also applies, of course, to other axis scales, such as scale_y_continuous(),
scale_x_discrete(), and so on.
You can also add line breaks with \n, as shown in Figure 8-20:
hwp + scale_x_continuous(name="Age\n(years)" )

8.11. Removing Axis Labels
Problem
You want to remove the label on an axis.
Solution
For the x-axis label, use theme(axis.title.x=element_blank()). For the y-axis label,
do the same with axis.title.y.
We’ll hide the x-axis in this example (Figure 8-21):

p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight)) + geom_boxplot()
p + theme(axis.title.x=element_blank())

Sometimes axis labels are redundant or obvious from the context, and don’t need to be
displayed. In the example here, the x-axis represents group, but this should be obvious
from the context. Similarly, if the y tick labels had kg or some other unit in each label,
the axis label “weight” would be unnecessary.
Another way to remove the axis label is to set it to an empty string. However, if you do
it this way, the resulting graph will still have space reserved for the text, as shown in the
graph on the right in Figure 8-21:
p + xlab("" )
When you use theme() to set axis.title.x=element_blank(), the name of the x or y
scale is unchanged, but the text is not displayed and no space is reserved for it. When
you set the label to "" , the name of the scale is changed and the (empty) text does display.


8.12. Changing the Appearance of Axis Labels
Problem
You want to change the appearance of axis labels.
Solution
To change the appearance of the x-axis label (Figure 8-22), use axis.title.x:
library(gcookbook) # For the data set
hwp <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
hwp + theme(axis.title.x=element_text(face="italic", colour="darkred", size=14))
Discussion
For the y-axis label, it might also be useful to display the text unrotated, as shown in
Figure 8-23 (left). The \n in the label represents a newline character:
hwp + ylab("Height\n(inches)") +
 theme(axis.title.y=element_text(angle=0, face="italic", size=14))
When you call element_text(), the default angle is 0, so if you set axis.title.y but
don’t specify the angle, it will show in this orientation, with the top of the text pointing
up. If you change any other properties of axis.title.y and want it to be displayed in
its usual orientation, rotated 90 degrees, you must manually specify the angle
(Figure 8-23, right):

hwp + ylab("Height\n(inches)") +
theme(axis.title.y=element_text(angle=90, face="italic", colour="darkred",
size=14))


8.13. Showing Lines Along the Axes
Problem
You want to display lines along the x- and y-axes, but not on the other sides of the graph.
Solution
Using themes, use axis.line (Figure 8-24):
library(gcookbook) # For the data set
p <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn)) + geom_point()
p + theme(axis.line = element_line(colour="black" ))

If you are starting with a theme that has a border around the plotting area, like
theme_bw(), you will also need to unset panel.border (Figure 8-24, right):
p + theme_bw() +
 theme(panel.border = element_blank(),
 axis.line = element_line(colour="black" ))


 If the lines are thick, the ends will only partially overlap (Figure 8-25, left). To make
them fully overlap (Figure 8-25, right), set lineend="square" :
# With thick lines, only half overlaps
p + theme_bw() +
 theme(panel.border = element_blank(),
 axis.line = element_line(colour="black" ,  size=4))
# Full overlap
p + theme_bw() +
 theme(panel.border = element_blank(),
 axis.line = element_line(colour="black" ,  size=4,  lineend="square" ))

 8.14. Using a Logarithmic Axis
Problem
You want to use a logarithmic axis for a graph.
Solution
Use scale_x_log10() and/or scale_y_log10() (Figure 8-26):

library(MASS) # For the data set
# The base plot
p <-  ggplot(Animals,  aes(x=body,  y=brain,  label=rownames(Animals))) +
geom_text(size=3)
p
# With logarithmic x and y scales
p + scale_x_log10() + scale_y_log10()


And then we can use those values as the breaks, as in Figure 8-27 (left):
p + scale_x_log10(breaks=10^(-1: 5)) + scale_y_log10(breaks=10^(0: 3))
To instead use exponential notation for the break labels (Figure 8-27, right), use the
trans_format() function, from the scales package:
library(scales)
p + scale_x_log10(breaks=10^(-1: 5),
labels=trans_format("log10" ,  math_format(10^. x))) +
scale_y_log10(breaks=10^(0: 3),
labels=trans_format("log10" ,  math_format(10^. x)))
Another way to use log axes is to transform the data before mapping it to the x and y
coordinates (Figure 8-28). Technically, the axes are still linear—it’s the quantity that is
log-transformed:
ggplot(Animals,  aes(x=log10(body),  y=log10(brain),  label=rownames(Animals))) +
geom_text(size=3)
The previous examples used a log10 transformation, but it is possible to use other trans‐
formations, such as log2 and natural log, as shown in Figure 8-29. It’s a bit more com‐
plicated to use these—scale_x_log10() is shorthand, but for these other log scales, we
need to spell them out:

Figure 8-27. Left: scatter plot with log10 x- and y-axes, and with manually specified
breaks; right: with exponents for the tick labels
library(scales)
# Use natural log on x, and log2 on y
p + scale_x_continuous(trans = log_trans(),
breaks = trans_breaks("log" , function(x) exp(x)),
labels = trans_format("log" ,  math_format(e^. x))) +
scale_y_continuous(trans = log2_trans(),
breaks = trans_breaks("log2" , function(x) 2^x),
labels = trans_format("log2" ,  math_format(2^. x)))
It’s possible to use a log axis for just one axis. It is often useful to represent financial data
this way, because it better represents proportional change. Figure 8-30 shows Apple’s
stock price with linear and log y-axes. The default tick marks might not be spaced well
for your graph; they can be set with the breaks in the scale:
library(gcookbook) # For the data set
ggplot(aapl,  aes(x=date, y=adj_price)) + geom_line()
ggplot(aapl,  aes(x=date, y=adj_price)) + geom_line() +
scale_y_log10(breaks=c(2, 10, 50, 250))


8.15. Adding Ticks for a Logarithmic Axis
Problem
You want to add tick marks with diminishing spacing for a logarithmic axis.
Solution
Use annotation_logticks() (Figure 8-31):
library(MASS) # For the data set
library(scales) # For the trans and format functions
ggplot(Animals,  aes(x=body,  y=brain,  label=rownames(Animals))) +
geom_text(size=3) +
annotation_logticks() +
scale_x_log10(breaks = trans_breaks("log10" , function(x) 10^x),
labels = trans_format("log10" ,  math_format(10^. x))) +
scale_y_log10(breaks = trans_breaks("log10" , function(x) 10^x),
labels = trans_format("log10" ,  math_format(10^. x)))

ggplot(Animals,  aes(x=body,  y=brain,  label=rownames(Animals))) +
geom_text(size=3) +
annotation_logticks() +
scale_x_log10(breaks = trans_breaks("log10" , function(x) 10^x),
labels = trans_format("log10" ,  math_format(10^. x)),
minor_breaks = log10(5) + -2: 5) +
scale_y_log10(breaks = trans_breaks("log10" , function(x) 10^x),
labels = trans_format("log10" ,  math_format(10^. x)),
minor_breaks = log10(5) + -1: 3) +
coord_fixed() +
theme_bw()


8.16. Making a Circular Graph
Problem
You want to make a circular graph.

ggplot(wind,  aes(x=DirCat,  fill=SpeedCat)) +
geom_histogram(binwidth=15,  origin=-7.5) +
coord_polar() +
scale_x_continuous(limits=c(0, 360))


Be cautious when using polar plots, since they can perceptually distort the data. In the
example here, at 210 degrees there are 15 observations with a speed of 15–20 and 13
observations with a speed of >20, but a quick glance at the picture makes it appear that
there are more observations at >20. There are also three observations with a speed of
10–15, but they’re barely visible.
In this example we can make the plot a little prettier by reversing the legend, using a
different palette, adding an outline, and setting the breaks to some more familiar num‐
bers (Figure 8-34):
ggplot(wind,  aes(x=DirCat,  fill=SpeedCat)) +
geom_histogram(binwidth=15,  origin=-7.5,  colour="black" ,  size=.25) +
guides(fill=guide_legend(reverse=TRUE)) +
coord_polar() +
scale_x_continuous(limits=c(0, 360),  breaks=seq(0, 360,  by=45),
minor_breaks=seq(0, 360,  by=15)) +
scale_fill_brewer()
It may also be useful to set the starting angle with the start argument, especially when
using a discrete variable for theta. The starting angle is specified in radians, so if you
know the adjustment in degrees, you’ll have to convert it to radians:
coord_polar(start=-45 * pi / 180)
Polar coordinates can be used with other geoms, including lines and points. There are
a few important things to keep in mind when using these geoms. First, by default, for
the variable that is mapped to y (or r), the smallest actual value gets mapped to the
center; in other words, the smallest data value gets mapped to a visual radius value of 0.
You may be expecting a data value of 0 to be mapped to a radius of 0, but to make sure
this happens, you’ll need to set the limits.
Next, when using a continuous x (or theta), the smallest and largest data values are
merged. Sometimes this is desirable, sometimes not. To change this behavior, you’ll need
to set the limits.
Finally, the theta values of the polar coordinates do not wrap around—it is presently not
possible to have a geom that crosses over the starting angle (usually vertical).
We’ll illustrate these issues with an example. The following code creates a data frame
from the mdeaths time series data set and produces the graph shown on the left in
Figure 8-35:
# Put mdeaths time series data into a data frame
md <-  data.frame(deaths = as.numeric(mdeaths),
 month = as.numeric(cycle(mdeaths)))
 # Calculate average number of deaths in each month
library(plyr) # For the ddply() function
md <-  ddply(md, "month" ,  summarise,  deaths = mean(deaths))
md
month deaths
1 2129.833
2 2081.333
...
11 1377.667
12 1796.500
# Make the base plot
p <-  ggplot(md,  aes(x=month,  y=deaths)) + geom_line() +
scale_x_continuous(breaks=1: 12)
# With coord_polar
p + coord_polar()
The first problem is that the data values (ranging from about 1000 to 2100) are mapped
to the radius such that the smallest data value is at radius 0. We’ll fix this by setting the
y (or r) limits from 0 to the maximum data value, as shown in the graph on the right in
Figure 8-35:
# With coord_polar and y (r) limits going to zero
p + coord_polar() + ylim(0,  max(md$deaths))

The next problem is that the lowest and highest month values, 1 and 12, are shown at
the same angle. We’ll fix this by setting the x limits from 0 to 12, creating the graph on
the left in Figure 8-36 (notice that using xlim() overrides the scale_x_continuous()
in p, so it no longer displays breaks for each month; see Recipe 8.2 for more information):
p + coord_polar() + ylim(0,  max(md$deaths)) + xlim(0, 12)
There’s one last issue, which is that the beginning and end aren’t connected. To fix that,
we need to modify our data frame by adding one row with a month of 0 that has the
same value as the row with month 12. This will make the starting and ending points the
same, as in the graph on the right in Figure 8-36 (alternatively, we could add a row with
month 13, instead of month 0):
# Connect the lines by adding a value for 0 that is the same as 12
mdx <-  md[md$month==12, ]
mdx$month <- 0
mdnew <-  rbind(mdx,  md)
# Make the same plot as before, but with the new data, by using %+%
p %+% mdnew + coord_polar() + ylim(0,  max(md$deaths))


8.17. Using Dates on an Axis

Solution
Map a column of class Date to the x- or y-axis. We’ll use the economics data set for this
example:
# Look at the structure
str(economics)
'data.frame':
478 obs. of 6 variables:
$ date
: Date, format: "1967-06-30" "1967-07-31" ...
$ pce
: num 508 511 517 513 518 ...
$ pop
: int 198712 198911 199113 199311 199498 199657 199808 199920 ...
$ psavert : num 9.8 9.8 9 9.8 9.7 9.4 9 9.5 8.9 9.6 ...
$ uempmed : num 4.5 4.7 4.6 4.9 4.7 4.8 5.1 4.5 4.1 4.6 ...
$ unemploy: int 2944 2945 2958 3143 3066 3018 2878 3001 2877 2709 ...
The column date is an object of class Date , and mapping it to x will produce the result
shown in Figure 8-37:
ggplot(economics, aes(x=date, y=psavert)) + geom_line()


Discussion
ggplot2 handles two kinds of time-related objects: dates (objects of class Date ) and date-
times (objects of class POSIXt ). The difference between these is that Date objects rep‐
resent dates and have a resolution of one day, while POSIXt objects represent moments
in time and have a resolution of a fraction of a second.
Specifying the breaks is similar to with a numeric axis—the main difference is in spec‐
ifying the sequence of dates to use. We’ll use a subset of the economics data, ranging
from mid-1992 to mid-1993. If breaks aren’t specified, they will be automatically se‐
lected, as shown in Figure 8-38 (top):
# Take a subset of economics
econ <- subset(economics, date >= as.Date("1992-05-01") &
date < as.Date("1993-06-01"))
# Base plot - without specifying breaks
p <- ggplot(econ, aes(x=date, y=psavert)) + geom_line()
p
The breaks can be created by using the seq() function with starting and ending dates,
and an interval (Figure 8-38, bottom):
# Specify breaks as a Date vector
datebreaks <- seq(as.Date("1992-06-01"), as.Date("1993-06-01"), by="2 month")
# Use breaks, and rotate text labels
p + scale_x_date(breaks=datebreaks) +
theme(axis.text.x = element_text(angle=30, hjust=1))
Notice that the formatting of the breaks changed. You can specify the formatting by
using the date_format() function from the scales package. Here we’ll use "%Y %b" ,
which results in a format like “1992 Jun”, as shown in Figure 8-39:
library(scales)
p + scale_x_date(breaks=datebreaks, labels=date_format("%Y %b")) +
theme(axis.text.x = element_text(angle=30, hjust=1))
Common date format options are shown in Table 8-1. They are to be put in a string that
is passed to date_format() , and the format specifiers will be replaced with the appro‐
priate values. For example, if you use "%B %d, %Y" , it will result in labels like “June 01,
1992”.
Table 8-1. Date format options
Option Description
%Y Year with century (2012)
%y Year without century (12)
%m Month as a decimal number (08)

p + scale_x_date(breaks=datebreaks, labels=date_format("%B %d, %Y")) +
theme(axis.text.x = element_text(angle=30, hjust=1))

Some of these items are specific to the computer’s locale. Months and days have different
names in different languages (the examples here are generated with a US locale). You
can change the locale with Sys.setlocale() . For example, this will change the date
formatting to use an Italian locale:
# Mac and Linux
Sys.setlocale("LC_TIME", "it_IT.UTF-8")
# Windows
Sys.setlocale("LC_TIME", "italian")
Note that the locale names may differ between platforms, and your computer must have
support for the locale installed at the operating system level.
See Also
See ?Sys.setlocale for more about setting the locale.
See ?strptime for information about converting strings to dates, and for information
about formatting the date output.



8.18. Using Relative Times on an Axis
Problem
You want to use relative times on an axis.

Solution
Times are commonly stored as numbers. For example, the time of day can be stored as
a number representing the hour. Time can also be stored as a number representing the
number of minutes or seconds from some starting time. In these cases, you map a value
to the x- or y-axis and use a formatter to generate the appropriate axis labels
(Figure 8-40):
# Convert WWWusage time-series object to data frame
www <- data.frame(minute = as.numeric(time(WWWusage)),
users = as.numeric(WWWusage))
# Define a formatter function - converts time in minutes to a string
timeHM_formatter <- function(x) {
h <- floor(x/60)
m <- floor(x %% 60)
lab <- sprintf("%d:%02d", h, m) # Format the strings as HH:MM
return(lab)
}
# Default x axis
ggplot(www, aes(x=minute, y=users)) + geom_line()
# With formatted times
ggplot(www, aes(x=minute, y=users)) + geom_line() +
scale_x_continuous(name="time", breaks=seq(0, 100, by=10),
labels=timeHM_formatter)

Discussion
In some cases it might be simpler to specify the breaks and labels manually, with some‐
thing like this:
scale_x_continuous(breaks=c(0, 20, 40, 60, 80, 100),
labels=c("0:00", "0:20", "0:40", "1:00", "1:20", "1:40"))
In the preceding example, we used the timeHM_formatter() function to convert the
numeric time (in minutes) to a string like "1:10" :
timeHM_formatter(c(0, 50, 51, 59, 60, 130, 604))
"0:00" "0:50" "0:51" "0:59" "1:00" "2:10" "10:04"
To convert to HH:MM:SS format, you can use the following formatter function:
timeHMS_formatter <- function(x) {
h <- floor(x/3600)
m <- floor((x/60) %% 60)
s <- round(x %% 60)
# Round to nearest second
lab <- sprintf("%02d:%02d:%02d", h, m, s) # Format the strings as HH:MM:SS
Discussion
In some cases it might be simpler to specify the breaks and labels manually, with some‐
thing like this:
scale_x_continuous(breaks=c(0, 20, 40, 60, 80, 100),
labels=c("0:00", "0:20", "0:40", "1:00", "1:20", "1:40"))
In the preceding example, we used the timeHM_formatter() function to convert the
numeric time (in minutes) to a string like "1:10" :
timeHM_formatter(c(0, 50, 51, 59, 60, 130, 604))
"0:00" "0:50" "0:51" "0:59" "1:00" "2:10" "10:04"
To convert to HH:MM:SS format, you can use the following formatter function:
timeHMS_formatter <- function(x) {
h <- floor(x/3600)
m <- floor((x/60) %% 60)
s <- round(x %% 60)
# Round to nearest second
lab <- sprintf("%02d:%02d:%02d", h, m, s) # Format the strings as HH:MM:SS
lab <- sub("^00:", "", lab)
lab <- sub("^0", "", lab)
return(lab)
# Remove leading 00: if present
# Remove leading 0 if present
}
Running it on some sample numbers yields:
timeHMS_formatter(c(20, 3000, 3075, 3559.2, 3600, 3606, 7813.8))
"0:20"
"50:00"
"51:15"
"59:19"
"1:00:00" "1:00:06" "2:10:14"


9.1. Setting the Title of a Graph
Problem
You want to set the title of a graph.
Solution
Set title with ggtitle() , as shown in Figure 9-1:
library(gcookbook) # For the data set
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
p + ggtitle("Age and Height of Schoolchildren")
# Use \n for a newline
p + ggtitle("Age and Height\nof Schoolchildren")

ggtitle() is equivalent to using labs(title = "Title text") .
If you want to move the title inside the plotting area, you can use one of two methods,
both of which are a little bit of a hack (Figure 9-2). The first method is to use ggti
tle() with a negative vjust value. The drawback of this method is that it still reserves
blank space above the plotting region for the title.
The second method is to instead use a text annotation, setting its x position to the middle
of the x range and its y position to Inf , which places it at the top of the plotting region.
This also requires a positive vjust value to bring the text fully inside the plotting region:
# Move the title inside
p + ggtitle("Age and Height of Schoolchildren") +
theme(plot.title=element_text(vjust = -2.5))
# Use a text annotation instead
p + annotate("text", x=mean(range(heightweight$ageYear)), y=Inf,
label="Age and Height of Schoolchildren", vjust=1.5, size=6)

9.2. Changing the Appearance of Text
Problem
You want to change the appearance of text in a plot.
Solution
To set the appearance of theme items such as the title, axis labels, and axis tick marks,
use theme() and set the item with element_text() . For example, axis.title.x con‐
trols the appearance of the x-axis label and plot.title controls the appearance of the
title text (Figure 9-3, left):
library(gcookbook) # For the data set
# Base plot
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
# Controlling appearance of theme items
p + theme(axis.title.x=element_text(size=16, lineheight=.9, family="Times",
face="bold.italic", colour="red"))
p + ggtitle("Age and Height\nof Schoolchildren") +
theme(plot.title=element_text(size=rel(1.5), lineheight=.9, family="Times",
face="bold.italic", colour="red"))
# rel(1.5) means that the font will be 1.5 times the base font size of the theme.
# For theme elements, font size is in points.
To set the appearance of text geoms (text that’s in the plot itself, with geom_text() or
annotate() ), set the text properties. For example (Figure 9-3, right):
p + annotate("text", x=15, y=53, label="Some text", size = 7, family="Times",
fontface="bold.italic", colour="red")
p + geom_text(aes(label=weightLb), size=4, family="Times", colour="red")
# For text geoms, font size is in mm

Table 9-1. Text properties of theme elements and text geoms
Theme elements Text geoms Description
family family Helvetica , Times , Courier
face fontface plain , bold , italic , bold.italic
colour colour Color (name or "#RRGGBB" )
size size Font size (in points for theme elements; in mm for geoms)
hjust hjust Horizontal alignment: 0=left, 0.5=center, 1=right
vjust vjust Vertical alignment: 0=bottom, 0.5=middle, 1=top
angle angle Angle in degrees
lineheight lineheight Line spacing multiplier

Table 9-2. Theme items that control text appearance in theme()
Element name Description
axis.title Appearance of axis labels on both axes
axis.title.x Appearance of x-axis label
axis.title.y Appearance of y-axis label
axis.ticks
Appearance of tick labels on both axes
axis.ticks.x Appearance of x tick labels
axis.ticks.y Appearance of y tick labels
legend.title Appearance of legend title
legend.text Appearance of legend items
plot.title Appearance of overall plot title
strip.text Appearance of facet labels in both directions
strip.text.x Appearance of horizontal facet labels
strip.text.y Appearance of vertical facet labels


9.3. Using Themes
Problem
You want to use premade themes to control the overall plot appearance.
Solution
To use a premade theme, add theme_bw() or theme_grey() (Figure 9-5):
library(gcookbook) # For the data set
# Base plot
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
# Grey theme (the default)
p + theme_grey()
# Black-and-white theme
p + theme_bw()
Discussion
Some commonly used properties of theme elements in ggplot2 are those things that are
controlled by theme() . Most of these things, like the title, legend, and axes, are outside
the plot area, but some of them are inside the plot area, such as grid lines and the
background coloring.

p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()

The two included themes are theme_grey() and theme_bw() , but it is also possible to
create your own.
You can set the base font family and size with either of the included themes (the default
base font family is Helvetica, and the default size is 12):
p + theme_grey(base_size=16, base_family="Times")
You can set the default theme for the current R session with theme_set() :
# Set default theme for current session
theme_set(theme_bw())
# This will use theme_bw()

p
# Reset the default theme back to theme_grey()
theme_set(theme_grey())

9.4. Changing the Appearance of Theme Elements
Problem
You want to change the appearance of theme elements.
Solution
To modify a theme, add theme() with a corresponding element_xx object. These include
element_line , element_rect , and element_text . The following code shows how to
modify many of the commonly used theme properties (Figure 9-6):
library(gcookbook) # For the data set
# Base plot
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + geom_point()
# Options for the plotting area
p + theme(
panel.grid.major = element_line(colour="red"),
panel.grid.minor = element_line(colour="red", linetype="dashed", size=0.2),
panel.background = element_rect(fill="lightblue"),
panel.border = element_rect(colour="blue", fill=NA, size=2))
# Options for text items
p + ggtitle("Plot title here") +
theme(
axis.title.x = element_text(colour="red", size=14),
axis.text.x = element_text(colour="blue"),
axis.title.y = element_text(colour="red", size=14, angle = 90),
axis.text.y = element_text(colour="blue"),
plot.title = element_text(colour="red", size=20, face="bold"))
# Options for the legend
p + theme(
legend.background = element_rect(fill="grey85", colour="red", size=1),
legend.title = element_text(colour="blue", face="bold", size=14),
legend.text = element_text(colour="red"),
legend.key = element_rect(colour="blue", size=0.25))
# Options for facets
p + facet_grid(sex ~ .) + theme(
strip.background = element_rect(fill="pink"),
strip.text.y = element_text(size=14, angle=-90, face="bold"))
# strip.text.x is the same, but for horizontal facets
Discussion
If you want to use a saved theme and tweak a few parts of it with theme() , the theme()
must come after the theme specification. Otherwise, anything set by theme() will be
unset by the theme you add:
# theme() has no effect if before adding a complete theme
p + theme(axis.title.x = element_text(colour="red")) + theme_bw()
# theme() works if after a compete theme
p + theme_bw() + theme(axis.title.x = element_text(colour="red", size=12))
Many of the commonly used theme properties are shown in Table 9-3.
Table 9-3. Theme items that control text appearance in theme()
Name Description Element type
text All text elements element_text()
rect All rectangular elements element_rect()
line All line elements element_line()
axis.line Lines along axes element_line()
axis.title Appearance of both axis labels element_text()
axis.title.x X-axis label appearance element_text()
axis.title.y Y-axis label appearance element_text()
axis.text Appearance of tick labels on both axes element_text()
axis.text.x X-axis tick label appearance element_text()
axis.text.y Y-axis tick label appearance element_text()
legend.background Background of legend element_rect()
legend.text Legend item appearance element_text()
legend.title Legend title appearance element_text()
legend.position Position of the legend "left" , "right" , "bottom" , "top" , or
two-element numeric vector if you wish to place it
inside the plot area (for more on legend placement,
see Recipe 10.2)
panel.background Background of plotting area element_rect()
panel.border Border around plotting area element_rect(linetype="dashed")
panel.grid.major Major grid lines element_line()
panel.grid.major.x Major grid lines, vertical element_line()
panel.grid.major.y Major grid lines, horizontal element_line()
panel.grid.minor
Minor grid lines
element_line()
panel.grid.minor.x Minor grid lines, vertical element_line()
panel.grid.minor.y Minor grid lines, horizontal element_line()
Name Description Element type
plot.background Background of the entire plot element_rect(fill = "white", col
our = NA)
plot.title Title text appearance element_text()
strip.background Background of facet labels element_rect()
strip.text Text appearance for vertical and horizontal
facet labels element_text()
strip.text.x Text appearance for horizontal facet labels element_text()
strip.text.y Text appearance for vertical facet labels element_text()
9.5. Creating Your Own Themes
Problem
You want to create your own theme.
Solution
You can create your own theme by adding elements to an existing theme (Figure 9-7):
library(gcookbook) # For the data set
# Start with theme_bw() and modify a few things
mytheme <- theme_bw() +
theme(text
= element_text(colour="red"),
axis.title = element_text(size = rel(1.25)))
# Base plot
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
# Plot with modified theme
p + mytheme
Discussion
With ggplot2, you can not only make use of the default themes, but also modify these
themes to suit your needs. You can add new theme elements or change the values of
existing ones, and apply your changes globally or to a single plot.
See Also
The options for modifying themes are listed in Recipe 9.4.
9.5. Creating Your Own Themes
|
221
9.6. Hiding Grid Lines
Problem
You want to hide the grid lines in a plot.
Solution
The major grid lines (those that align with the tick marks) are controlled with pan
el.grid.major . The minor grid lines (the ones between the major lines) are controlled
with panel.grid.minor . This will hide them both, as shown in Figure 9-8 (left):
library(gcookbook) # For the data set
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
p + theme(panel.grid.major = element_blank(),
panel.grid.minor = element_blank())Discussion
It’s possible to hide just the vertical or horizontal grid lines, as shown in the middle and
righthand graphs in Figure 9-8, with panel.grid.major.x , panel.grid.major.y , pan
el.grid.minor.x , and panel.grid.minor.y :
# Hide the vertical grid lines (which intersect with the x-axis)
p + theme(panel.grid.major.x = element_blank(),
panel.grid.minor.x = element_blank())
# Hide the horizontal grid lines (which intersect with the y-axis)
p + theme(panel.grid.major.y = element_blank(),
panel.grid.minor.y = element_blank())


10.1. Removing the Legend

Use guides(), and specify the scale that should have its legend removed (Figure 10-1):
# The base plot (with legend)
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
p
# Remove the legend for fill
p + guides(fill=FALSE)

Another way to remove a legend is to set guide=FALSE in the scale. This will result in
the exact same output as the preceding code:
# Remove the legend for fill
p + scale_fill_discrete(guide=FALSE)
Yet another way to remove the legend is to use the theming system. If you have more
than one aesthetic mapping with a legend (color and shape, for example), this will
remove legends for all of them:

p + theme(legend.position="none" )
Sometimes a legend is redundant, or it is supplied in another graph that will be displayed
with the current one. In these cases, it can be useful to remove the legend from a graph.
In the example used here, the colors provide the same information that is on the x-axis,
so the legend is unnecessary. Notice that with the legend removed, the area used for
graphing the data is larger. If you want to achieve the same proportions in the graphing
area, you will need to adjust the overall dimensions of the graph.
When a variable is mapped to fill, the default scale used is scale_fill_discrete()
(equivalent to scale_fill_hue()), which maps the factor levels to colors that are equally
spaced around the color wheel. There are other scales for fill, such as scale_fill_man
ual(). If you use scales for other aesthetics, such as colour (for lines and points) or
shape (for points), you must use the appropriate scale. Commonly used scales include:
• scale_fill_discrete()
• scale_fill_hue()
• scale_fill_manual()
• scale_fill_grey()
• scale_fill_brewer()
• scale_colour_discrete()
• scale_colour_hue()
• scale_colour_manual()
• scale_colour_grey()
• scale_colour_brewer()
• scale_shape_manual()
• scale_linetype()

10.2. Changing the Position of a Legend
Problem
You want to move the legend from its default place on the right side.
Solution
Use theme(legend.position=...). It can be put on the top, left, right, or bottom by
using one of those strings as the position (Figure 10-2, left):
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot() +
scale_fill_brewer(palette="Pastel2" )
p + theme(legend.position="top" )

The legend can also be placed inside the graphing area by specifying a coordinate po‐
sition, as in legend.position=c(1,0) (Figure 10-2, right). The coordinate space starts
at (0, 0) in the bottom left and goes to (1, 1) in the top right.

Discussion
You can also use legend.justification to set which part of the legend box is set to the
position at legend.position. By default, the center of the legend (.5, .5) is placed at the
coordinate, but it is often useful to specify a different point.
For example, this will place the bottom-right corner of the legend (1,0) in the bottomright corner of the graphing area (1,0):
p + theme(legend.position=c(1, 0),  legend.justification=c(1, 0))

And this will place the top-right corner of the legend in the top-right corner of the
graphing area, as in the graph on the right in Figure 10-3:
p + theme(legend.position=c(1, 1),  legend.justification=c(1, 1))
When placing the legend inside of the graphing area, it may be helpful to add an opaque
border to set it apart (Figure 10-4, left):
p + theme(legend.position=c(.85, .2)) +
theme(legend.background=element_rect(fill="white" ,  colour="black" ))
You can also remove the border around its elements so that it blends in (Figure 10-4,
right):
p + theme(legend.position=c(.85, .2)) +
theme(legend.background=element_blank()) + # Remove overall border
theme(legend.key=element_blank()) # Remove border around each item

10.3. Changing the Order of Items in a Legend
Problem
You want to change the order of the items in a legend.
Solution
Set the limits in the scale to the desired order (Figure 10-5):
# The base plot
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
p
# Change the order of items
p + scale_fill_discrete(limits=c("trt1" , "trt2" , "ctrl" ))
Discussion
Note that the order of the items on the x-axis did not change. To do that, you would
have to set the limits ofscale_x_discrete() (Recipe 8.4), or change the data to have
a different factor level order (Recipe 15.8).

In the preceding example, group was mapped to the fill aesthetic. By default this uses
scale_fill_discrete() (which is the same as scale_fill_hue()), which maps the
factor levels to colors that are equally spaced around the color wheel. We could have
used a different scale_fill_xxx(), though. For example, we could use a grey palette
(Figure 10-6, left):
p + scale_fill_grey(start=.5,  end=1,  limits=c("trt1" , "trt2" , "ctrl" ))
Or we could use a palette from RColorBrewer (Figure 10-6, right):
p + scale_fill_brewer(palette="Pastel2" ,  limits=c("trt1" , "trt2" , "ctrl" ))
All the previous examples were for fill. If you use scales for other aesthetics, such as
colour (for lines and points) or shape (for points), you must use the appropriate scale.
Commonly used scales include:
• scale_fill_discrete()
• scale_fill_hue()
• scale_fill_manual()
• scale_fill_grey()
• scale_fill_brewer()
• scale_colour_discrete()
• scale_colour_hue()
• scale_colour_manual()
• scale_colour_grey()

In the preceding example, group was mapped to the fill aesthetic. By default this uses
scale_fill_discrete() (which is the same as scale_fill_hue()), which maps the
factor levels to colors that are equally spaced around the color wheel. We could have
used a different scale_fill_xxx(), though. For example, we could use a grey palette
(Figure 10-6, left):
p + scale_fill_grey(start=.5,  end=1,  limits=c("trt1" , "trt2" , "ctrl" ))
Or we could use a palette from RColorBrewer (Figure 10-6, right):
p + scale_fill_brewer(palette="Pastel2" ,  limits=c("trt1" , "trt2" , "ctrl" ))
All the previous examples were for fill. If you use scales for other aesthetics, such as
colour (for lines and points) or shape (for points), you must use the appropriate scale.
Commonly used scales include:
• scale_fill_discrete()
• scale_fill_hue()
• scale_fill_manual()
• scale_fill_grey()
• scale_fill_brewer()
• scale_colour_discrete()
• scale_colour_hue()
• scale_colour_manual()
• scale_colour_grey()
Figure 10-6. Left: modified order with a grey palette; right: with a palette from RColor‐
Brewer
• scale_colour_brewer()
• scale_shape_manual()
• scale_linetype()
By default, using scale_fill_discrete() is equivalent to using scale_fill_hue();
the same is true for color scales.
See Also
To reverse the order of the legend, see Recipe 10.4.
To change the order of factor levels, see Recipe 15.8. To order legend items based on
values in another variable, see Recipe 15.9.
10.4. Reversing the Order of Items in a Legend
Problem
You want to reverse the order of items in a legend.
Solution
Add guides(fill=guide_legend(reverse=TRUE)) to reverse the order of the legend,
as in Figure 10-7 (for other aesthetics, replace fill with the name of the aesthetic, such
as colour or size):

# The base plot
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
p
# Reverse the legend order
p + guides(fill=guide_legend(reverse=TRUE))
Figure 10-7. Left: default order for legend; right: reversed order
Discussion
It is also possible to control the legend when specifying the scale, as in the following:
scale_fill_hue(guide=guide_legend(reverse=TRUE))
10.5. Changing a Legend Title
Problem
You want to change the text of a legend title.
Solution
Use labs() and set the value offill, colour, shape, or whatever aesthetic is appropriate
for the legend (Figure 10-8):
# The base plot
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
p
# Set the legend title to "Condition"
p + labs(fill="Condition" )

Discussion
It’s also possible to set the title of the legend in the scale specification. Since legends and
axes are both guides, this works the same way as setting the title of the x- or y-axis.
This would have the same effect as the previous code:
p + scale_fill_discrete(name="Condition" )
If there are multiple variables mapped to aesthetics with a legend (those other than x
and y), you can set the title of each individually. In the example here we’ll use \n to add
a line break in one of the titles (Figure 10-9):
library(gcookbook) # For the data set
# Make the base plot
hw <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) +
 geom_point(aes(size=weightLb)) + scale_size_continuous(range=c(1, 4))
hw
# With new legend titles
hw + labs(colour="Male/Female" ,  size="Weight\n(pounds)" )


hw1 <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  shape=sex,  colour=sex)) +
geom_point()
hw1

To change the title (Figure 10-10, right), you need to set the name for both of them. If
you change the name for just one, it will result in two separate legends (Figure 10-10,
middle):
# Change just shape
hw1 + labs(shape="Male/Female" )
# Change both shape and colour
hw1 + labs(shape="Male/Female" ,  colour="Male/Female" )
It is also possible to control the legend title with the guides() function. It’s a little more
verbose, but it can be useful when you’re already using it to control other properties:
p + guides(fill=guide_legend(title="Condition" ))

10.6. Changing the Appearance of a Legend Title
Problem
You want to change the appearance of a legend title’s text.
Solution
Use theme(legend.title=element_text()) (Figure 10-11):
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
p + theme(legend.title=element_text(face="italic" ,  family="Times" ,  colour="red" ,
 size=14))

 p + guides(fill=guide_legend(title.theme=
element_text(face="italic" ,  family="times" ,  colour="red" ,  size=14)))
See Also
See Recipe 9.2 for more on controlling the appearance of text.

10.7. Removing a Legend Title
Problem
You want to remove a legend title.
Solution
Add guides(fill=guide_legend(title=NULL)) to remove the title from a legend, as
in Figure 10-12 (for other aesthetics, replace fill with the name of the aesthetic, such
as colour or size):
ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot() +
guides(fill=guide_legend(title=NULL))

Discussion
It is also possible to control the legend title when specifying the scale. This has the same
effect as the preceding code:
scale_fill_hue(guide = guide_legend(title=NULL))

10.8. Changing the Labels in a Legend
Problem
You want to change the text of labels in a legend.
Solution
Set the labels in the scale (Figure 10-13, left):
library(gcookbook) # For the data set
# The base plot
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
# Change the legend labels
p + scale_fill_discrete(labels=c("Control" , "Treatment 1" , "Treatment 2" ))

Figure 10-13. Left: manually specified legend labels with the default discrete scale; right:
manually specified labels with a different scale
Discussion
Note that the labels on the x-axis did not change. To do that, you would have to set the
labels ofscale_x_discrete() (Recipe 8.10), or change the data to have different factor
level names (Recipe 15.10).
In the preceding example, group was mapped to the fill aesthetic. By default this uses
scale_fill_discrete(), which maps the factor levels to colors that are equally spaced
around the color wheel (the same as scale_fill_hue()). There are other fill scales
we could use, and setting the labels works the same way. For example, to produce the
graph on the right in Figure 10-13:

p + scale_fill_grey(start=.5,  end=1,
labels=c("Control" , "Treatment 1" , "Treatment 2" ))
If you are also changing the order of items in the legend, the labels are matched to the
items by position. In this example we’ll change the item order, and make sure to set the
labels in the same order (Figure 10-14):
p + scale_fill_discrete(limits=c("trt1" , "trt2" , "ctrl" ),
labels=c("Treatment 1" , "Treatment 2" , "Control" ))


# The base plot
p <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  shape=sex,  colour=sex)) +
geom_point()
p
# Change the labels for one scale
p + scale_shape_discrete(labels=c("Female" , "Male" ))
# Change the labels for both scales
p + scale_shape_discrete(labels=c("Female" , "Male" )) +
scale_colour_discrete(labels=c("Female" , "Male" ))

• scale_fill_discrete()
• scale_fill_hue()
• scale_fill_manual()
• scale_fill_grey()
• scale_fill_brewer()
• scale_colour_discrete()
• scale_colour_hue()
• scale_colour_manual()
• scale_colour_grey()
• scale_colour_brewer()
• scale_shape_manual()
• scale_linetype()
By default, using scale_fill_discrete() is equivalent to using scale_fill_hue();
the same is true for color scales.
10.9. Changing the Appearance of Legend Labels
Problem
You want to change the appearance of labels in a legend.
Solution
Use theme(legend.text=element_text()) (Figure 10-16):

# The base plot
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
# Change the legend label appearance
p + theme(legend.text=element_text(face="italic" ,  family="Times" ,  colour="red" ,
size=14))
Discussion
It’s also possible to specify the legend label appearance via guides(), although this
method is a bit unwieldy. This has the same effect as the previous code:
# Changes the legend title text for the fill legend
p + guides(fill=guide_legend(label.theme=
 element_text(face="italic" ,  family="Times" ,  colour="red" ,  size=14)))


 Solution
Set the labels in the scale, using \n to represent a newline. In this example, we’ll use
scale_fill_discrete() to control the legend for the fill scale (Figure 10-17, left):
p <-  ggplot(PlantGrowth,  aes(x=group,  y=weight,  fill=group)) + geom_boxplot()
# Labels that have more than one line
p + scale_fill_discrete(labels=c("Control" , "Type 1\ntreatment" ,
"Type 2\ntreatment" ))


Discussion
As you can see in the version on the left in Figure 10-17, with the default settings the
lines of text will run into each other when you use labels that have more than one line.
To deal with this problem, you can increase the height of the legend keys and decrease
the spacing between lines, using theme() (Figure 10-17, right). To do this, you will need
to specify the height using the unit() function from the grid package:
library(grid)
p + scale_fill_discrete(labels=c("Control" , "Type 1\ntreatment" ,
"Type 2\ntreatment" )) +
theme(legend.text=element_text(lineheight=.8),
legend.key.height=unit(1, "cm" ))

11.1. Splitting Data into Subplots with Facets
Problem
You want to plot subsets of your data in separate panels.
Solution
Use facet_grid() or facet_wrap(), and specify the variables on which to split.
With facet_grid(), you can specify a variable to split the data into vertical subpanels,
and another variable to split it into horizontal subpanels (Figure 11-1):
# The base plot
p <-  ggplot(mpg,  aes(x=displ,  y=hwy)) + geom_point()
# Faceted by drv, in vertically arranged subpanels
p + facet_grid(drv ~ . )
# Faceted by cyl, in horizontally arranged subpanels
p + facet_grid(.  ~ cyl)
# Split by drv (vertical) and cyl (horizontal)
p + facet_grid(drv ~ cyl)

Figure 11-1. Top: faceting horizontally by drv; bottom left: faceting vertically by cyl; bot‐
tom right: faceting in both directions, with both variables
With facet_wrap(), the subplots are laid out horizontally and wrap around, like words
on a page, as in Figure 11-2:
# Facet on class
# Note there is nothing before the tilde
p + facet_wrap( ~ class)

11.2. Using Facets with Different Axes
Problem
You want subplots with different ranges or items on their axes.
Solution
Set the scales to "free_x" , "free_y" , or "free"  (Figure 11-3):
# The base plot
p <-  ggplot(mpg,  aes(x=displ,  y=hwy)) + geom_point()
# With free y scales
p + facet_grid(drv ~ cyl,  scales="free_y" )
# With free x and y scales
p + facet_grid(drv ~ cyl,  scales="free" )

Discussion
Each row of subplots has its own y range when free y scales are used; the same applies
to columns when free x scales are used.
It’s not possible to directly set the range of each row or column, but you can control the
ranges by dropping unwanted data (to reduce the ranges), or by adding geom_blank()
(to expand the ranges).
See Also
See Recipe 3.10 for an example of faceting with free scales and a discrete axis.
11.3. Changing the Text of Facet Labels
Problem
You want to change the text of facet labels.
Solution
Change the names of the factor levels (Figure 11-4):
mpg2 <-  mpg # Make a copy of the original data
# Rename 4 to 4wd, f to Front, r to Rear
levels(mpg2$drv)[levels(mpg2$drv)=="4" ]  <- "4wd"
levels(mpg2$drv)[levels(mpg2$drv)=="f" ]  <- "Front"

11.3. Changing the Text of Facet Labels
Problem
You want to change the text of facet labels.
Solution
Change the names of the factor levels (Figure 11-4):
mpg2 <-  mpg # Make a copy of the original data
# Rename 4 to 4wd, f to Front, r to Rear
levels(mpg2$drv)[levels(mpg2$drv)=="4" ]  <- "4wd"
levels(mpg2$drv)[levels(mpg2$drv)=="f" ]  <- "Front"

levels(mpg2$drv)[levels(mpg2$drv)=="r" ]  <- "Rear"
# Plot the new data
ggplot(mpg2,  aes(x=displ,  y=hwy)) + geom_point() + facet_grid(drv ~ . )

Unlike with scales where you can set the labels, to set facet labels you must change the
data values. Also, at the time of this writing, there is no way to show the name of the
faceting variable as a header for the facets, so it can be useful to use descriptive facet
labels.
With facet_grid() (but not facet_wrap(), at this time), it’s possible to use a labeller
function to set the labels. The labeller function label_both() will print out both the
name of the variable and the value of the variable in each facet (Figure 11-5, left):
ggplot(mpg2,  aes(x=displ,  y=hwy)) + geom_point() +
facet_grid(drv ~ . ,  labeller = label_both)
Another useful labeller is label_parsed(), which takes strings and treats them as R
math expressions (Figure 11-5, right):
mpg3 <-  mpg
levels(mpg3$drv)[levels(mpg3$drv)=="4" ]  <- "4^{wd}"
levels(mpg3$drv)[levels(mpg3$drv)=="f" ]  <- "- Front %.% e^{pi * i}"
levels(mpg3$drv)[levels(mpg3$drv)=="r" ]  <- "4^{wd} - Front"
ggplot(mpg3,  aes(x=displ,  y=hwy)) + geom_point() +
facet_grid(drv ~ . ,  labeller = label_parsed)

11.4. Changing the Appearance of Facet Labels
and Headers
Problem
You want to change the appearance of facet labels and headers.
Solution
With the theming system, set strip.text to control the text appearance and strip.back
ground to control the background appearance (Figure 11-6):
library(gcookbook) # For the data set
ggplot(cabbage_exp,  aes(x=Cultivar,  y=Weight)) + geom_bar(stat="identity" ) +
facet_grid(.  ~ Date) +
theme(strip.text = element_text(face="bold" ,  size=rel(1.5)),
strip.background = element_rect(fill="lightblue" ,  colour="black" ,
size=1))

12.1. Setting the Colors of Objects
Problem
You want to set the color of some geoms in your graph.
Solution
In the call to the geom, set the values of colour or fill (Figure 12-1):
ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point(colour="red" )
library(MASS) # For the data set
ggplot(birthwt,  aes(x=bwt)) + geom_histogram(fill="red" ),  colour="black"

12.2. Mapping Variables to Colors
Problem
You want to use a variable (column from a data frame) to control the color of geoms.
Solution
In the call to the geom, set the value ofcolour or fill to the name of one of the columns
in the data (Figure 12-2):

library(gcookbook) # For the data set
# These both have the same effect
ggplot(cabbage_exp,  aes(x=Date,  y=Weight,  fill=Cultivar)) +
geom_bar(colour="black" ,  position="dodge" )
ggplot(cabbage_exp,  aes(x=Date,  y=Weight)) +
geom_bar(aes(fill=Cultivar),  colour="black" ,  position="dodge" )
# These both have the same effect
ggplot(mtcars,  aes(x=wt,  y=mpg,  colour=cyl)) + geom_point()
ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point(aes(colour=cyl))


In the cabbage_exp example, the variable Cultivar is mapped to fill. The Cultivar
column in cabbage_exp is a factor, so ggplot2 treats it as a discrete variable. You can
check the type using str():
str(cabbage_exp)
'data.frame': 6 obs. of 6 variables:
$ Cultivar: Factor w/ 2 levels "c39","c52": 1 1 1 2 2 2
$ Date : Factor w/ 3 levels "d16","d20","d21": 1 2 3 1 2 3

In the mtcars example, cyl is numeric, so it is treated as a continuous variable. Because
of this, even though the actual values of cyl include only 4, 6, and 8, the legend has
entries for the intermediate values 5 and 7. To make ggplot() treat cyl as a categorical
variable, you can convert it to a factor in the call to ggplot(), or you can modify the
data so that the column is a character vector or factor (Figure 12-3):
# Convert to factor in call to ggplot()
ggplot(mtcars,  aes(x=wt,  y=mpg,  colour=factor(cyl))) + geom_point()
# Another method: Convert to factor in the data
m <-  mtcars # Make a copy of mtcars
m$cyl <-  factor(m$cyl) # Convert cyl to a factor
ggplot(m,  aes(x=wt,  y=mpg,  colour=cyl)) + geom_point()

12.3. Using a Different Palette for a Discrete Variable
Problem
You want to use different colors for a discrete mapped variable.

Solution
Use one of the scales listed in Table 12-1.
Table 12-1. Discrete fill and color scales
Fill scale Color scale Description
scale_fill_discrete() scale_colour_discrete() Colors evenly spaced around the color wheel (same as
hue)
scale_fill_hue() scale_colour_hue() Colors evenly spaced around the color wheel (same as
discrete)
scale_fill_grey() scale_colour_grey() Greyscale palette
scale_fill_brewer() scale_colour_brewer() ColorBrewer palettes
scale_fill_manual() scale_colour_manual() Manually specified colors
In the example here we’ll use the default palette (hue), and a ColorBrewer palette
(Figure 12-4):
library(gcookbook) # For the data set
# Base plot
p <-  ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup)) + geom_area()
# These three have the same effect
p
p + scale_fill_discrete()
p + scale_fill_hue()
# ColorBrewer palette
p + scale_fill_brewer()

Discussion
Changing a palette is a modification of the color (or fill) scale: it involves a change in
the mapping from numeric or categorical values to aesthetic attributes. There are two
types of scales that use colors: fill scales and color scales.
With scale_fill_hue(), the colors are taken from around the color wheel in the HCL
(hue-chroma-lightness) color space. The default lightness value is 65 on a scale from
0–100. This is good for filled areas, but it’s a bit light for points and lines. To make the
colors darker for points and lines, as in Figure 12-5 (right), set the value ofl (luminance/
lightness):
# Basic scatter plot
h <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) +
geom_point()
# Default lightness = 65
h
# Slightly darker
h + scale_colour_hue(l=45)

The ColorBrewer package provides a number of palettes. You can generate a graphic
showing all of them, as shown in Figure 12-6:
library(RColorBrewer)
display.brewer.all()
The ColorBrewer palettes can be selected by name. For example, this will use the
Oranges palette (Figure 12-7):
p + scale_fill_brewer(palette="Oranges" )

You can also use a palette of greys. This is useful for print when the output is in black
and white. The default is to start at 0.2 and end at 0.8, on a scale from 0 (black) to 1
(white), but you can change the range, as shown in Figure 12-8.
p + scale_fill_grey()
# Reverse the direction and use a different range of greys
p + scale_fill_grey(start=0.7,  end=0)


12.4. Using a Manually Defined Palette for a
Discrete Variable
Problem
You want to use different colors for a discrete mapped variable.
Solution
In the example here, we’ll manually define colors by specifying values with scale_col
our_manual() (Figure 12-9). The colors can be named, or they can be specified with
RGB values:
library(gcookbook) # For the data set
# Base plot
h <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) + geom_point()
# Using color names
h + scale_colour_manual(values=c("red" , "blue" ))
# Using RGB values
h + scale_colour_manual(values=c("#CC6666" , "#7777DD" ))

# Base plot
h <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=sex)) + geom_point()
# Using color names
h + scale_colour_manual(values=c("red" , "blue" ))
Discussion
The order of the items in the values vector matches the order of the factor levels for the
discrete scale. In the preceding example, the order of sex is f, then m, so the first item
in values goes with f and the second goes with m. Here’s how to see the order of factor
levels:
levels(heightweight$sex)
"f" "m"
If the variable is a character vector, not a factor, it will automatically be converted to a
factor, and by default the levels will appear in alphabetical order.
It’s possible to specify the colors in a different order by using a named vector:
h + scale_colour_manual(values=c(m="blue" ,  f="red" ))
There is a large set of named colors in R, which you can see by running color(). Some
basic color names are useful: "white" , "black" , "grey80" , "red" , "blue" , "darkred" ,
and so on. There are many other named colors, but their names are generally not very
informative (I certainly have no idea what "thistle3" and "seashell"  look like), so
it’s often easier to use numeric RGB values for specifying colors.
RGB colors are specified as six-digit hexadecimal (base-16) numbers of the form
"#RRGGBB" . In hexadecimal, the digits go from 0 to 9, and then continue with A (10 in
base 10) to F (15 in base 10). Each color is represented by two digits and can range from
00 to FF (255 in base 10). So, for example, the color "#FF0099"  has a value of 255 for
red, 0 for green, and 153 for blue, resulting in a shade of magenta. The hexadecimal
numbers for each color channel often repeat the same digit because it makes them a
little easier to read, and because the precise value of the second digit has a relatively
insignificant effect on appearance.
Here are some rules of thumb for specifying and adjusting RGB colors:
• In general, higher numbers are brighter and lower numbers are darker.
• To get a shade of grey, set all the channels to the same value.
• The opposites of RGB are CMY: Cyan, Magenta, and Yellow. Higher values for the
red channel make it more red, and lower values make it more cyan. The same is true
for the pairs green and magenta, and blue and yellow.



# Base plot
p <-  ggplot(uspopage,  aes(x=Year,  y=Thousands,  fill=AgeGroup)) + geom_area()
# The palette with grey:
cb_palette <-  c("#999999" , "#E69F00" , "#56B4E9" , "#009E73" , "#F0E442" ,
"#0072B2" , "#D55E00" , "#CC79A7" )
# Add it to the plot
p + scale_fill_manual(values=cb_palette)

12.6. Using a Manually Defined Palette for a
Continuous Variable
Problem
You want to use different colors for a continuous variable.
Solution
In the example here, we’ll specify the colors for a continuous variable using various
gradient scales (Figure 12-12). The colors can be named, or they can be specified with
RGB values:
library(gcookbook) # For the data set
# Base plot
p <-  ggplot(heightweight,  aes(x=ageYear,  y=heightIn,  colour=weightLb)) +
geom_point(size=3)
p
# With a gradient between two colors
p + scale_colour_gradient(low="black" ,  high="white" )
# A gradient with a white midpoint
library(scales)
p + scale_colour_gradient2(low=muted("red" ),  mid="white" ,  high=muted("blue" ),
midpoint=110)
# A gradient of n colors
p + scale_colour_gradientn(colours = c("darkred" , "orange" , "yellow" , "white" ))
For fill scales, use scale_fill_xxx() versions instead, where xxx is one of gradient,
gradient2, or gradientn.
Discussion
Mapping continuous values to a color scale requires a continuously changing palette of
colors. Table 12-2 lists the continuous color and fill scales.
Table 12-2. Continuous fill and color scales
Fill scale Color scale Description
scale_fill_gradient() scale_colour_gradient() Two-color gradient
scale_fill_gradient2() scale_colour_gradient2() Gradient with a middle color and two colors that
diverge from it
scale_fill_gradientn() scale_colour_gradientn() Gradient with n colors, equally spaced

Figure 12-12. Clockwise from top left: default colors, two-color gradient with scale_col‐
our_gradient(), three-color gradient with midpoint with scale_colour_gradient2(), four
color gradient with scale_colour_gradientn()
Notice that we used the muted() function in the examples. This is a function from the
scales package that returns an RGB value that is a less-saturated version of the color
chosen.

12.7. Coloring a Shaded Region Based on Value
Problem
You want to set the color of a shaded region based on the y value

Solution
Add a column that categorizes the y values, then map that column to fill. In this
example, we’ll first categorize the values as positive or negative:
library(gcookbook) # For the data set
cb <-  subset(climate,  Source=="Berkeley" )
cb$valence[cb$Anomaly10y >= 0] <- "pos"
cb$valence[cb$Anomaly10y < 0]  <- "neg"
cb
 Source Year Anomaly1y Anomaly5y Anomaly10y Unc10y valence
 Berkeley 1800 NA NA -0.435 0.505 neg
 Berkeley 1801 NA NA -0.453 0.493 neg
 Berkeley 1802 NA NA -0.460 0.486 neg
 ...
 Berkeley 2002 NA NA 0.856 0.028 pos
 Berkeley 2003 NA NA 0.869 0.028 pos
 Berkeley 2004 NA NA 0.884 0.029 pos
Once we’ve categorized the values as positive or negative, we can make the plot, mapping
valence to the fill color, as shown in Figure 12-13:
ggplot(cb,  aes(x=Year,  y=Anomaly10y)) +
 geom_area(aes(fill=valence)) +
 geom_line() +
 geom_hline(yintercept=0)

 If you look closely at the figure, you’ll notice that there are some stray shaded areas near
the zero line. This is because each of the two colored areas is a single polygon bounded
by the data points, and the data points are not actually at zero. To solve this problem,
we can interpolate the data to 1,000 points by using approx():
# approx() returns a list with x and y vectors
interp <-  approx(cb$Year,  cb$Anomaly10y,  n=1000)
# Put in a data frame and recalculate valence
cbi <-  data.frame(Year=interp$x,  Anomaly10y=interp$y)
cbi$valence[cbi$Anomaly10y >= 0] <- "pos"
cbi$valence[cbi$Anomaly10y < 0]  <- "neg"
It would be more precise (and more complicated) to interpolate exactly where the line
crosses zero, but approx() works fine for the purposes here.
Now we can plot the interpolated data (Figure 12-14). This time we’ll make a few
adjustments—we’ll make the shaded regions partially transparent, change the colors,
remove the legend, and remove the padding on the left and right sides:
ggplot(cbi,  aes(x=Year,  y=Anomaly10y)) +
geom_area(aes(fill=valence),  alpha = .4) +
geom_line() +
geom_hline(yintercept=0) +
scale_fill_manual(values=c("#CCEEFF" , "#FFDDDD" ),  guide=FALSE) +
scale_x_continuous(expand=c(0, 0))

mcor <-  cor(mtcars)
# Print mcor and round to 2 digits
round(mcor,  digits=2)
library(corrplot)
corrplot(mcor)


13.2. Plotting a Function
Problem
You want to plot a function.
Solution
Use stat_function(). It’s also necessary to give ggplot() a dummy data frame so that
it will get the proper x range. In this example we’ll use dnorm(), which gives the density
of the normal distribution (Figure 13-4, left):
# The data frame is only used for setting the range
p <-  ggplot(data.frame(x=c(-3, 3)),  aes(x=x))
p + stat_function(fun = dnorm)

Discussion
Some functions take additional arguments. For example, dt(), the function for the
density of the t-distribution, takes a parameter for degrees of freedom (Figure 13-4,
right). These additional arguments can be passed to the function by putting them in a
list and giving the list to args:
p + stat_function(fun=dt,  args=list(df=2))
It’s also possible to define your own functions. It should take an x value for its first
argument, and it should return a y value. In this example, we’ll define a sigmoid function
(Figure 13-5):
myfun <- function(xvar) {
1/(1 + exp(- xvar + 10))
}
ggplot(data.frame(x=c(0, 20)),  aes(x=x)) + stat_function(fun=myfun)

myfun <- function(xvar) {
1/(exp(xvar))
}
ggplot(data.frame(x=c(0, 20)),  aes(x=x)) + stat_function(fun=myfun,n=200)


By default, the function is calculated at 101 points along the x range. If you have a rapidly
fluctuating function, you may be able to see the individual segments. To smooth out the
curve, pass a larger value of n to stat_function(), as in stat_function(fun=myfun,
n=200).


13.3. Shading a Subregion Under a Function Curve
Problem
You want to shade part of the area under a function curve.
Solution
Define a new wrapper function around your curve function, and replace out-of-range
values with NA (), as shown in Figure 13-6:
# Return dnorm(x) for 0 < x < 2, and NA for all other x
dnorm_limit <- function(x) {
 y <-  dnorm(x)
 y[x < 0 |  x > 2] <- NA
 return(y)
}
# ggplot() with dummy data



Discussion
R has first-class functions, and we can write a function that returns a closure—that is,
we can program a function to program another function.
This function will allow you to pass in a function, a minimum value, and a maximum
value. Values outside the range will again be returned with NA:
limitRange <- function(fun,  min,  max) {
function(x) {
y <-  fun(x)
y[x < min |  x > max] <- NA
return(y)
}
}
Now we can call this function to create another function—one that is effectively the
same as the dnorm_limit() function used earlier:
# This returns a function
dlimit <-  limitRange(dnorm, 0, 2)
# Now we'll try out the new function -- it only returns values for inputs

# between 0 and 2
dlimit(-2: 4)
[1] NA NA 0.39894228 0.24197072 0.05399097 NA NA
We can use limitRange() to create a function that is passed to stat_function():
p + stat_function(fun = dnorm) +
stat_function(fun = limitRange(dnorm, 0, 2),
geom="area" ,  fill="blue" ,  alpha=0.2)
The limitRange() function can be used with any function, not just dnorm(), to create
a range-limited version of that function. The result of all this is that instead of having
to write functions with different hardcoded values for each situation that arises, we can
write one function and simply pass it different arguments depending on the situation.
If you look very, very closely at the graph in Figure 13-6, you may see that the shaded
region does not align exactly with the range we specified. This is because ggplot2 does
a numeric approximation by calculating values at fixed intervals, and these intervals
may not fall exactly within the specified range. As in Recipe 13.2, we can improve the
approximation by increasing the number of interpolated values with stat_func
tion(n=200)


limitRange <- function(fun,  min,  max) {
function(x) {
y <-  fun(x)
y[x < min |  x > max] <- NA
return(y)
}
}

# This returns a function
dlimit <-  limitRange(dnorm, 0, 2)
# Now we'll try out the new function -- it only returns values for inputs
# between 0 and 2
dlimit(-2: 4)
[1] NA NA 0.39894228 0.24197072 0.05399097 NA NA
We can use limitRange() to create a function that is passed to stat_function():
p + stat_function(fun = dnorm) +
stat_function(fun = limitRange(dnorm, 0, 2),
geom="area" ,  fill="blue" ,  alpha=0.2)


13.4. Creating a Network Graph
Problem
You want to create a network graph.
Solution
Use the igraph package. To create a graph, pass a vector containing pairs of items to
graph(), then plot the resulting object (Figure 13-7):
# May need to install first, with install.packages("igraph")
library(igraph)
# Specify edges for a directed graph
gd <-  graph(c(1, 2, 2, 3, 2, 4, 1, 4, 5, 5, 3, 6))
plot(gd)
# For an undirected graph
gu <-  graph(c(1, 2, 2, 3, 2, 4, 1, 4, 5, 5, 3, 6),  directed=FALSE)
# No labels
plot(gu,  vertex.label=NA)

This is the structure of each of the graph objects:
str(gd)
IGRAPH D--- 6 6 --
+ edges:
[1] 1->2 2->3 2->4 1->4 5->5 3->6
str(gu)
IGRAPH U--- 6 6 --
+ edges:
[1] 1--2 2--3 2--4 1--4 5--5 3--6
Discussion
In a network graph, the position of the nodes is unspecified by the data, and they’re
placed randomly. To make the output repeatable, you can set the random seed before
making the plot. You can try different random numbers until you get a result that you
like:
set.seed(229)
plot(gu)
It’s also possible to create a graph from a data frame. The first two rows of the data frame
are used, and each row specifies a connection between two nodes. In the next example
(Figure 13-8), we’ll use the madmen2 data set, which has this structure. We’ll also use
the Fruchterman-Reingold layout algorithm. The idea is that all the nodes have a mag‐
netic repulsion from one another, but the edges between nodes act as springs, pulling
the nodes together:
Figure 13-8. A directed graph from a data frame, with the Fruchterman-Reingold
algorithm
library(gcookbook) # For the data set
madmen2
Name1 Name2
Abe Drexler Peggy Olson
Allison Don Draper
Arthur Case Betty Draper
...
# Create a graph object from the data set
g <-  graph.data.frame(madmen2,  directed=TRUE)

# Remove unnecessary margins
par(mar=c(0, 0, 0, 0))
plot(g,  layout=layout.fruchterman.reingold,  vertex.size=8,  edge.arrow.size=0.5,
vertex.label=NA)
It’s also possible to make a directed graph from a data frame. The madmen data set has
only one row for each pairing, since direction doesn’t matter for an undirected graph.
This time we’ll use a circle layout (Figure 13-9):
g <-  graph.data.frame(madmen,  directed=FALSE)
par(mar=c(0, 0, 0, 0)) # Remove unnecessary margins
plot(g,  layout=layout.circle,  vertex.size=8,  vertex.label=NA)


Solution
The vertices/nodes may have names, but these names are not used as labels by default.
To set the labels, pass in a vector of names to vertex.label (Figure 13-10):
library(igraph)
library(gcookbook) # For the data set
# Copy madmen and drop every other row
m <-  madmen[1:nrow(madmen) %% 2 == 1, ]
g <-  graph.data.frame(m,  directed=FALSE)
# Print out the names of each vertex
V(g)$name
 [1] "Betty Draper" "Don Draper" "Harry Crane" "Joan Holloway"
 [5] "Lane Pryce" "Peggy Olson" "Pete Campbell" "Roger Sterling"
 [9] "Sal Romano" "Henry Francis" "Allison" "Candace"
[13] "Faye Miller" "Megan Calvet" "Rachel Menken" "Suzanne Farrell"
[17] "Hildy" "Franklin" "Rebecca Pryce" "Abe Drexler"
[21] "Duck Phillips" "Playtex bra model" "Ida Blankenship" "Mirabelle Ames"
[25] "Vicky" "Kitty Romano"
plot(g,  layout=layout.fruchterman.reingold,
 vertex.size = 4,  # Smaller nodes
 vertex.label = V(g)$name,  # Set the labels
 vertex.label.cex = 0.8,  # Slightly smaller font
 vertex.label.dist = 0.4,  # Offset the labels
 vertex.label.color = "black" )

 Discussion
Another way to achieve the same effect is to modify the plot object, instead of passing
in the values as arguments to plot(). To do this, use V()$xxx <- instead of passing a
value to a vertex. xxx argument. For example, this will result in the same output as the
previous code:
# This is equivalent to the preceding code
V(g)$size <- 4
V(g)$label <-  V(g)$name
V(g)$label.cex <- 0.8
V(g)$label.dist <- 0.4
V(g)$label.color <- "black"
# Set a property of the entire graph
g$layout <-  layout.fruchterman.reingold
plot(g)


The properties of the edges can also be set, either with the E() function or by passing
values to edge. xxx arguments (Figure 13-11):
# View the edges
E(g)
# Set some of the labels to "M"
E(g)[c(2,11,19)]$label <- "M"
# Set color of all to grey, and then color a few red
E(g)$color <- "grey70"
E(g)[c(2,11,19)]$color <- "red"
plot(g)

13.6. Creating a Heat Map
Problem
You want to make a heat map.
Solution
Use geom_tile() or geom_raster() and map a continuous variable to fill . We’ll use
the presidents data set, which is a time series object rather than a data frame:
presidents

# Base plot
p <- ggplot(pres_rating, aes(x=year, y=quarter, fill=rating))
# Using geom_tile()
p + geom_tile()
# Using geom_raster() - looks the same, but a little more efficient
p + geom_raster()



To better convey useful information, you may want to customize the appearance of the
heat map. With this example, we’ll reverse the y-axis so that it progresses from top to
bottom, and we’ll add tick marks every four years along the x-axis, to correspond with
each presidential term. We’ll also change the color scale using scale_fill_gradi
ent2() , which lets you specify a midpoint color and the two colors at the low and high
ends (Figure 13-13):
p + geom_tile() +
scale_x_continuous(breaks = seq(1940, 1976, by = 4)) +
scale_y_reverse() +
scale_fill_gradient2(midpoint=50, mid="grey70", limits=c(0,100))

13.7. Creating a Three-Dimensional Scatter Plot
Problem
You want to create a three-dimensional (3D) scatter plot.
Solution
We’ll use the rgl package, which provides an interface to the OpenGL graphics library
for 3D graphics. To create a 3D scatter plot, as in Figure 13-14, use plot3d() and pass
in a data frame where the first three columns represent x, y, and z coordinates, or pass
in three vectors representing the x, y, and z coordinates.
# You may need to install first, with install.packages("rgl")
library(rgl)
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=0.75, lit=FALSE)

Discussion
Three-dimensional scatter plots can be difficult to interpret, so it’s often better to use a
two-dimensional representation of the data. That said, there are things that can help
make a 3D scatter plot easier to understand.
In Figure 13-15, we’ll add vertical segments to help give a sense of the spatial positions
of the points:
# Function to interleave the elements of two vectors
interleave <- function(v1, v2) as.vector(rbind(v1,v2))
# Plot the points
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg,
xlab="Weight", ylab="Displacement", zlab="MPG",
size=.75, type="s", lit=FALSE)
# Add the segments
segments3d(interleave(mtcars$wt,
mtcars$wt),
interleave(mtcars$disp, mtcars$disp),
interleave(mtcars$mpg, min(mtcars$mpg)),
alpha=0.4, col="blue")
It’s possible to tweak the appearance of the background and the axes. In Figure 13-16,
we change the number of tick marks and add tick marks and axis labels to the specified
sides:
# Make plot without axis ticks or labels
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg,
xlab = "", ylab = "", zlab = "",
axes = FALSE,
size=.75, type="s", lit=FALSE)
segments3d(interleave(mtcars$wt,
mtcars$wt),
interleave(mtcars$disp, mtcars$disp),
interleave(mtcars$mpg, min(mtcars$mpg)),
alpha = 0.4, col = "blue")
# Draw the box.
rgl.bbox(color="grey50",
emission="grey50",
xlen=0, ylen=0, zlen=0)
# grey60 surface and black text
# emission color is grey50
# Don't add tick marks
# Set default color of future objects to black
rgl.material(color="black")


# Add axes to specific sides. Possible values are "x--", "x-+", "x+-", and "x++".
axes3d(edges=c("x--", "y+-", "z--"),
ntick=6,
# Attempt 6 tick marks on each side
cex=.75)
# Smaller font
# Add axis labels. 'line' specifies
mtext3d("Weight",
edge="x--",
mtext3d("Displacement", edge="y+-",
mtext3d("MPG",
edge="z--",
how far to set the label from the axis.
line=2)
line=3)
line=3)

13.8. Adding a Prediction Surface to a Three-
Dimensional Plot
Problem
You want to add a surface of predicted value to a three-dimensional scatter plot.
Solution
First we need to define some utility functions for generating the predicted values from
a model object:
# Given a model, predict zvar from xvar and yvar
# Defaults to range of x and y variables, and a 16x16 grid
predictgrid <- function(model, xvar, yvar, zvar, res = 16, type = NULL) {
# Find the range of the predictor variable. This works for lm and glm
# and some others, but may require customization for others.
xrange <- range(model$model[[xvar]])
yrange <- range(model$model[[yvar]])
newdata <- expand.grid(x = seq(xrange[1], xrange[2], length.out = res),
y = seq(yrange[1], yrange[2], length.out = res))
names(newdata) <- c(xvar, yvar)
newdata[[zvar]] <- predict(model, newdata = newdata, type = type)
newdata
}
# Convert long-style data frame with x, y, and z vars into a list
# with x and y as row/column values, and z as a matrix.
df2mat <- function(p, xvar = NULL, yvar = NULL, zvar = NULL) {
if (is.null(xvar)) xvar <- names(p)[1]
if (is.null(yvar)) yvar <- names(p)[2]
if (is.null(zvar)) zvar <- names(p)[3]
x <- unique(p[[xvar]])
y <- unique(p[[yvar]])
z <- matrix(p[[zvar]], nrow = length(y), ncol = length(x))
m <- list(x, y, z)

names(m) <- c(xvar, yvar, zvar)
m
}
# Function to interleave the elements of two vectors
interleave <- function(v1, v2) as.vector(rbind(v1,v2))
With these utility functions defined, we can make a linear model from the data and plot
it as a mesh along with the data, using the surface3d() function, as shown in
Figure 13-17:
library(rgl)
# Make a copy of the data set
m <- mtcars
# Generate a linear model
mod <- lm(mpg ~ wt + disp + wt:disp, data = m)
# Get predicted values of mpg from wt and disp
m$pred_mpg <- predict(mod)
# Get predicted mpg from a grid of wt and disp
mpgrid_df <- predictgrid(mod, "wt", "disp", "mpg")
mpgrid_list <- df2mat(mpgrid_df)
# Make the plot with the data points
plot3d(m$wt, m$disp, m$mpg, type="s", size=0.5, lit=FALSE)
# Add the corresponding predicted points (smaller)
spheres3d(m$wt, m$disp, m$pred_mpg, alpha=0.4, type="s", size=0.5, lit=FALSE)
# Add line segments showing the error
segments3d(interleave(m$wt,
m$wt),
interleave(m$disp, m$disp),
interleave(m$mpg, m$pred_mpg),
alpha=0.4, col="red")
# Add the mesh of predicted values
surface3d(mpgrid_list$wt, mpgrid_list$disp, mpgrid_list$mpg,
alpha=0.4, front="lines", back="lines")

Discussion
We can tweak the appearance of the graph, as shown in Figure 13-18. We’ll add each of
the components of the graph separately:
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg,
xlab = "", ylab = "", zlab = "",
axes = FALSE,
size=.5, type="s", lit=FALSE)
# Add the corresponding predicted points (smaller)
spheres3d(m$wt, m$disp, m$pred_mpg, alpha=0.4, type="s", size=0.5, lit=FALSE)
# Add line segments showing the error
segments3d(interleave(m$wt,
m$wt),
interleave(m$disp, m$disp),
interleave(m$mpg, m$pred_mpg),
alpha=0.4, col="red")
# Add the mesh of predicted values
surface3d(mpgrid_list$wt, mpgrid_list$disp, mpgrid_list$mpg,
alpha=0.4, front="lines", back="lines")
# Draw the box
rgl.bbox(color="grey50",
emission="grey50",
xlen=0, ylen=0, zlen=0)
288
|
Chapter 13: Miscellaneous Graphs
# grey60 surface and black text
# emission color is grey50
# Don't add tick marks
# Set default color of future objects to black
rgl.material(color="black")
# Add axes to specific sides. Possible values are "x--", "x-+", "x+-", and "x++".
axes3d(edges=c("x--", "y+-", "z--"),
ntick=6,
# Attempt 6 tick marks on each side
cex=.75)
# Smaller font
# Add axis labels. 'line' specifies
mtext3d("Weight",
edge="x--",
mtext3d("Displacement", edge="y+-",
mtext3d("MPG",
edge="z--",
how far to set the label from the axis.
line=2)
line=3)
line=3)
See Also
For more on changing the appearance of the surface, see ?rgl.material .
13.9. Saving a Three-Dimensional Plot
Problem
You want to save a three-dimensional plot created with the rgl package.
Solution
To save a bitmap image of a plot created with rgl, use rgl.snapshot() . This will capture
the exact image that is on the screen:
library(rgl)
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=0.75, lit=FALSE)
rgl.snapshot('3dplot.png', fmt='png')
You can also use rgl.postscript() to save a Postscript or PDF file:
rgl.postscript('figs/miscgraph/3dplot.pdf', fmt='pdf')
rgl.postscript('figs/miscgraph/3dplot.ps', fmt='ps')
Postscript and PDF output does not support many features of the OpenGL library on
which rgl is based. For example, it does not support transparency, and the sizes of objects
such as points and lines may not be the same as what appears on the screen.
Discussion
To make the output more repeatable, you can save your current viewpoint and restore
it later:
# Save the current viewpoint
view <- par3d("userMatrix")
# Restore the saved viewpoint
par3d(userMatrix = view)
To save view in a script, you can use dput() , then copy and paste the output into your
script:
dput(view)
structure(c(0.907931625843048, 0.267511069774628, -0.322642296552658,
0, -0.410978674888611, 0.417272746562958, -0.810543060302734,
0, -0.0821993798017502, 0.868516683578491, 0.488796472549438,
0, 0, 0, 0, 1), .Dim = c(4L, 4L))
Once you have the text representation of the userMatrix , add the following to your
script:
view <- structure(c(0.907931625843048, 0.267511069774628, -0.322642296552658,
0, -0.410978674888611, 0.417272746562958, -0.810543060302734,
0, -0.0821993798017502, 0.868516683578491, 0.488796472549438,
0, 0, 0, 0, 1), .Dim = c(4L, 4L))
par3d(userMatrix = view)

13.10. Animating a Three-Dimensional Plot
Problem
You want to animate a three-dimensional plot by moving the viewpoint around the plot.
Solution
Rotating a 3D plot can provide a more complete view of the data. To animate a 3D plot,
use play3d() with spin3d() :
library(rgl)
plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=0.75, lit=FALSE)
play3d(spin3d())
Discussion
By default, the graph will be rotated on the z (vertical) axis, until you send a break
command to R.
You can change the rotation axis, rotation speed, and duration:
# Spin on x-axis, at 4 rpm, for 20 seconds
play3d(spin3d(axis=c(1,0,0), rpm=4), duration=20)
To save the movie, use the movie3d() function in the same way as play3d() . It will
generate a series of .png files, one for each frame, and then attempt to combine them
into a single animated .gif file using the convert program from the ImageMagick image
utility.
This will spin the plot once in 15 seconds, at 50 frames per second:
# Spin on z axis, at 4 rpm, for 15 seconds
movie3d(spin3d(axis=c(0,0,1), rpm=4), duration=15, fps=50)
The output file will be saved in a temporary directory, and the name will be printed on
the R console.
If you don’t want to use ImageMagick to convert the output to a .gif, you can specify
convert=FALSE and then convert the series of .png files to a movie using some other
utility.
13.11. Creating a Dendrogram
Problem
You want to make a dendrogram to show how items are clustered

Solution
Use hclust() and plot the output from it. This can require a fair bit of data prepro‐
cessing. For this example, we’ll first take a subset of the countries data set from the year
2009. For simplicity, we’ll also drop all rows that contain an NA , and then select a random
25 of the remaining rows:
library(gcookbook) # For the data set
# Get data from year 2009
c2 <- subset(countries, Year==2009)
# Drop rows that have any NA values
c2 <- c2[complete.cases(c2), ]
# Pick out a random 25 countries
# (Set random seed to make this repeatable)
set.seed(201)
c2 <- c2[sample(1:nrow(c2), 25), ]
c2
6731
1733
...
5966
10148
Name Code Year
GDP laborrate healthexp infmortality
Mongolia MNG 2009 1690.4170
72.9
74.19826
27.8
Canada CAN 2009 39599.0418
67.8 4379.76084
5.2
Macedonia, FYR
Turkmenistan
MKD 2009
TKM 2009
4510.2380
3710.4536
54.0
68.0
313.68971
77.06955
10.6
48.0
Notice that the row names (the first column) are essentially random numbers, since the
rows were selected randomly. We need to do a few more things to the data before making
a dendrogram from it. First, we need to set the row names—right now there’s a column
called Name , but the row names are those random numbers (we don’t often use row
names, but for the hclust() function they’re essential). Next, we’ll need to drop all the
columns that aren’t values used for clustering. These columns are Name , Code , and Year :
rownames(c2) <- c2$Name
c2 <- c2[,4:7]
c2
The values for GDP are several orders of magnitude larger than the values for, say, in
fmortality . Because of this, the effect of infmortality on the clustering will be neg‐
ligible compared to the effect of GDP .This probably isn’t what we want. To address this
issue, we’ll scale the data:
c3 <- scale(c2)
c3
GDP
laborrate
healthexp infmortality
Mongolia
-0.6783472 1.15028714 -0.6341393599 -0.08334689
Canada
1.7504703 0.59747293 1.9736219974 -0.88014885
...
Macedonia, FYR
-0.4976803 -0.89837729 -0.4890859471 -0.68976254
Turkmenistan
-0.5489228 0.61915192 -0.6324002997
0.62883892
attr(,"scaled:center")
GDP
laborrate
healthexp infmortality
12277.960
62.288
1121.198
30.164
attr(,"scaled:scale")
GDP
laborrate
healthexp infmortality
15607.852864
9.225523 1651.056974
28.363384
By default the scale() function scales each column relative to its standard deviation,
but other methods may be used.
Finally, we’re ready to make the dendrogram, as shown in Figure 13-19:
hc <- hclust(dist(c3))
# Make the dendrogram
plot(hc)
# With text aligned
plot(hc, hang = -1)
Discussion
A cluster analysis is simply a way of assigning points to groups in an n-dimensional
space (four dimensions, in this example). A hierarchical cluster analysis divides each
group into two smaller groups, and can be represented with the dendrograms in this
recipe. There are many different parameters you can control in the hierarchical cluster
analysis process, and there may not be a single “right” way to do it for your data.
First, we normalized the data using scale() with its default settings. You can scale your
data differently, or not at all. (With this data set, not scaling the data will lead to GDP
overwhelming the other variables, as shown in Figure 13-20.)
For the distance calculation, we used the default method, "euclidean" , which calculates
the Euclidean distance between the points. The other possible methods are "maximum" ,
"manhattan" , "canberra" , "binary" , and "minkowski" .

c3 <- scale(c2)
c3

The hclust() function provides several methods for performing the cluster analysis.
The default is "complete" ; the other possible methods are "ward" , "single" , "aver
age" , "mcquitty" , "median" , and "centroid" .
See Also
See ?hclust for more information about the different clustering methods.

13.12. Creating a Vector Field
Problem
You want to make a vector field.
Solution
Use geom_segment() . For this example, we’ll use the isabel data set:
library(gcookbook) # For the data set
isabel
x
y
-83.00000 41.70000
-83.00000 41.62786
-83.00000 41.55571
294
|
z
0.035
0.035
0.035
Chapter 13: Miscellaneous Graphs
vx
NA
NA
NA
vy
NA
NA
NA
vz
NA
NA
NA
t
NA
NA
NA
speed
NA
NA
NA



islice <- subset(isabel, z == min(z))
ggplot(islice, aes(x=x, y=y)) +
geom_segment(aes(xend = x + vx/50, yend = y + vy/50),
size = 0.25)
# Make the line segments 0.25 mm thick


# Take a slice where z is equal to the minimum value of z
islice <- subset(isabel, z == min(z))
# Keep 1 out of every 'by' values in vector x
every_n <- function(x, by = 2) {
x <- sort(x)
x[seq(1, length(x), by = by)]
}
# Keep 1 of every 4 values in x and y
keepx <- every_n(unique(isabel$x), by=4)
keepy <- every_n(unique(isabel$y), by=4)
# Keep only those rows where x value is in keepx and y value is in keepy
islicesub <- subset(islice, x %in% keepx & y %in% keepy)
Now that we’ve taken a subset of the data, we can plot it, with arrowheads, as shown in
Figure 13-22:
# Need to load grid for arrow() function
library(grid)
# Make the plot with the subset, and use an arrowhead 0.1 cm long
ggplot(islicesub, aes(x=x, y=y)) +
geom_segment(aes(xend = x+vx/50, yend = y+vy/50),
arrow = arrow(length = unit(0.1, "cm")), size = 0.25)

Discussion
One effect of arrowheads is that short vectors appear with more ink than is proportional
to their length. This could somewhat distort the interpretation of the data. To mitigate
this effect, it may also be useful to map the speed to other properties, like size (line
thickness), alpha , or colour . Here, we’ll map speed to alpha (Figure 13-23, left):
# The existing 'speed' column includes the z component. We'll calculate
# speedxy, the horizontal speed.
islicesub$speedxy <- sqrt(islicesub$vx^2 + islicesub$vy^2)
# Map speed to alpha
ggplot(islicesub, aes(x=x, y=y)) +
geom_segment(aes(xend = x+vx/50, yend = y+vy/50, alpha = speed),
arrow = arrow(length = unit(0.1,"cm")), size = 0.6)
Next, we’ll map speed to colour . We’ll also add a map of the United States and zoom
in on the area of interest, as shown in the graph on the right in Figure 13-23, using
coord_cartesian() (without this, the entire USA will be displayed):


# Get USA map data
usa <-  map_data("usa" )
# Map speed to colour, and set go from "grey80" to "darkred"
ggplot(islicesub,  aes(x=x,  y=y)) +
geom_segment(aes(xend = x+vx/50,  yend = y+vy/50,  colour = speed),
arrow = arrow(length = unit(0.1, "cm" )),  size = 0.6) +
scale_colour_continuous(low="grey80" ,  high="darkred" ) +
geom_path(aes(x=long,  y=lat,  group=group),  data=usa) +
coord_cartesian(xlim = range(islicesub$x),  ylim = range(islicesub$y))



# Keep 1 out of every 5 values in x and y, and 1 in 2 values in z
keepx <-  every_n(unique(isabel$x),  by=5)
keepy <-  every_n(unique(isabel$y),  by=5)
keepz <-  every_n(unique(isabel$z),  by=2)
isub <-  subset(isabel,  x %in% keepx & y %in% keepy & z %in% keepz)
ggplot(isub,  aes(x=x,  y=y)) +
geom_segment(aes(xend = x+vx/50,  yend = y+vy/50,  colour = speed),
arrow = arrow(length = unit(0.1, "cm" )),  size = 0.5) +
scale_colour_continuous(low="grey80" ,  high="darkred" ) +
facet_wrap( ~ z)

13.13. Creating a QQ Plot
Problem
You want to make a quantile-quantile (QQ) plot to compare an empirical distribution
to a theoretical distribution.

Solution
Use qqnorm() to compare to a normal distribution. Give qqnorm() a vector of numerical
values, and add a theoretical distribution line with qqline() (Figure 13-25):
library(gcookbook) # For the data set
# QQ plot of height
qqnorm(heightweight$heightIn)
qqline(heightweight$heightIn)
# QQ plot of age
qqnorm(heightweight$ageYear)
qqline(heightweight$ageYear)
Discussion
The points for heightIn are close to the line, which means that the distribution is close
to normal. In contrast, the points for ageYear veer far away from the line, especially on
the left, indicating that the distribution is skewed. A histogram may also be useful for
exploring how the data is distributed

13.14. Creating a Graph of an Empirical Cumulative
Distribution Function
Problem
You want to graph the empirical cumulative distribution function (ECDF) of a data set.
Solution
Use stat_ecdf() (Figure 13-26):
library(gcookbook) # For the data set
# ecdf of heightIn

ggplot(heightweight,  aes(x=heightIn)) + stat_ecdf()
# ecdf of ageYear
ggplot(heightweight,  aes(x=ageYear)) + stat_ecdf()


Discussion
The ECDF shows what proportion of observations are at or below the given x value.
Because it is empirical, the line takes a step up at each x value where there are one or
more observations.
13.15. Creating a Mosaic Plot
Problem
You want to make a mosaic plot to visualize a contingency table.
Solution
Use the mosaic() function from the vcd package. For this example we’ll use the USBAd
missions data set, which is a contingency table with three dimensions. We’ll first take
a look at the data in a few different ways:
UCBAdmissions
, , Dept = A
Gender
Admit Male Female
Admitted 512 89
Rejected 313 19

... [four other Depts]
, , Dept = F
Gender
Admit Male Female
Admitted 22 24
Rejected 351 317
# Print a "flat" contingency table
ftable(UCBAdmissions)
Dept A B C D E F
Admit Gender
Admitted Male 512 353 120 138 53 22
Female 89 17 202 131 94 24
Rejected Male 313 207 205 279 138 351
Female 19 8 391 244 299 317
dimnames(UCBAdmissions)
$Admit
[1] "Admitted" "Rejected"
$Gender
[1] "Male" "Female"
$Dept
[1] "A" "B" "C" "D" "E" "F"
The three dimensions are Admit, Gender, and Dept. To visualize the relationships be‐
tween the variables (Figure 13-27), use mosaic() and pass it a formula with the variables
that will be used to split up the data:
# You may need to install first, with install.packages("vcd")
library(vcd)
# Split by Admit, then Gender, then Dept
mosaic( ~ Admit + Gender + Dept,  data=UCBAdmissions)



13.16. Creating a Pie Chart
Problem
You want to make a pie chart.
Solution
Use the pie() function. In this example (Figure 13-31), we’ll use the survey data set
from the MASS library:

library(MASS) # For the data set
# Get a table of how many cases are in each level of fold
fold <-  table(survey$Fold)
fold
 L on R Neither R on L
 99 18 120
# Make the pie chart
pie(fold)


We passed pie() an object of class table. We could have instead given it a named vector,
or a vector of values and a vector of labels, like this:
pie(c(99, 18, 120),  labels=c("L on R" , "Neither" , "R on L" ))

13.17. Creating a Map
Problem
You want to create a geographical map.
Solution
Retrieve map data from the maps package and draw it with geom_polygon() (which
can have a color fill) or geom_path() (which can’t have a fill). By default, the latitude
and longitude will be drawn on a Cartesian coordinate plane, but you can use co
ord_map() and specify a projection. The default projection is "mercator" , which, unlike
the Cartesian plane, has a progressively changing spacing for latitude lines
(Figure 13-32):
library(maps) # For map data
# Get map data for USA
states_map <-  map_data("state" )
ggplot(states_map,  aes(x=long,  y=lat,  group=group)) +
geom_polygon(fill="white" ,  colour="black" )
# geom_path (no fill) and Mercator projection
ggplot(states_map,  aes(x=long,  y=lat,  group=group)) +
geom_path() + coord_map("mercator" )
Discussion
The map_data() function returns a data frame with the following columns:
long
Longitude.
lat
Latitude.
group
This is a grouping variable for each polygon. A region or subregion might have
multiple polygons, for example, if it includes islands.

Discussion
The map_data() function returns a data frame with the following columns:
long
Longitude.
lat
Latitude.
group
This is a grouping variable for each polygon. A region or subregion might have
multiple polygons, for example, if it includes islands.

order
The order to connect each point within a group.
region
Roughly, the names of countries, although some other objects are present (such as
some lakes).

subregion
The names of subregions within a region, which can contain multiple groups. For
example, the Alaska subregion includes many islands, each with its own group.
There are a number of different maps available, including world, nz, france, italy, usa
(outline of the United States), state (each state in the USA), and county (each county
in the USA). For example, to get map data for the world:
# Get map data for world
world_map <-  map_data("world" )
world_map
long lat group order region subregion
-133.3664 58.42416 1 1 Canada <NA>
-132.2681 57.16308 1 2 Canada <NA>
-132.0498 56.98610 1 3 Canada <NA>
...
124.7772 11.35419 2284 27634 Philippines Leyte
124.9697 11.30280 2284 27635 Philippines Leyte
125.0155 11.13887 2284 27636 Philippines Leyte
If you want to draw a map of a region in the world map for which there isn’t a separate
map, you can first look for the region name, like so:
sort(unique(world_map$region))
"Afghanistan" "Albania" "Algeria"
"American Samoa" "Andaman Islands" "Andorra"
"Angola" "Anguilla" "Antarctica"
...
"USA" "USSR" "Vanuatu"
"Venezuela" "Vietnam" "Virgin Islands"
"Vislinskiy Zaliv" "Wales" "West Bank"
"Western Sahara" "Yemen" "Yugoslavia"
"Zaire" "Zambia" "Zimbabwe"
# You might have noticed that it's a little out of date!
It’s possible to get data for specific regions from a particular map (Figure 13-33):
east_asia <-  map_data("world" ,  region=c("Japan" , "China" , "North Korea" ,
"South Korea" ))
# Map region to fill color
ggplot(east_asia,  aes(x=long,  y=lat,  group=group,  fill=region)) +
geom_polygon(colour="black" ) +
scale_fill_brewer(palette="Set2" )


east_asia <-  map_data("world" ,  region=c("Japan" , "China" , "North Korea" ,
 "South Korea" ))


 If there is a separate map available for a region, such as nz (New Zealand), that map data
will be at a higher resolution than if you were to extract it from the world map, as shown
in Figure 13-34:
# Get New Zealand data from world map
nz1 <-  map_data("world" ,  region="New Zealand" )
nz1 <-  subset(nz1,  long > 0 & lat > -48) # Trim off islands
ggplot(nz1,  aes(x=long,  y=lat,  group=group)) + geom_path()
# Get New Zealand data from the nz map
nz2 <-  map_data("nz" )
ggplot(nz2,  aes(x=long,  y=lat,  group=group)) + geom_path()
See Also
See the mapdata package for more map data sets. It includes maps of China and Japan,
as well as a high-resolution world map, worldHires.
See the map() function, for quickly generating maps.
See ?mapproject for a list of available map projections.

13.18. Creating a Choropleth Map
Problem
You want to create a map with regions that are colored according to variable values.
Solution
Merge the value data with the map data, then map a variable to fill:
# Transform the USArrests data set to the correct format
crimes <-  data.frame(state = tolower(rownames(USArrests)),  USArrests)
crimes
state Murder Assault UrbanPop Rape
Alabama alabama 13.2 236 58 21.2
Alaska alaska 10.0 263 48 44.5
Arizona arizona 8.1 294 80 31.0
...
West Virginia west virginia 5.7 81 39 9.3
Wisconsin wisconsin 2.6 53 66 10.8
Wyoming wyoming 6.8 161 60 15.6
library(maps) # For map data
states_map <-  map_data("state" )

# Merge the data sets together
crime_map <-  merge(states_map,  crimes,  by.x="region" ,  by.y="state" )
# After merging, the order has changed, which would lead to polygons drawn in
# the incorrect order. So, we sort the data.
head(crime_map)
region long lat group order subregion Murder Assault UrbanPop Rape
alabama -87.46201 30.38968 1 1 <NA> 13.2 236 58 21.2
alabama -87.48493 30.37249 1 2 <NA> 13.2 236 58 21.2
alabama -87.95475 30.24644 1 13 <NA> 13.2 236 58 21.2
alabama -88.00632 30.24071 1 14 <NA> 13.2 236 58 21.2
alabama -88.01778 30.25217 1 15 <NA> 13.2 236 58 21.2
alabama -87.52503 30.37249 1 3 <NA> 13.2 236 58 21.2
library(plyr) # For arrange() function
# Sort by group, then order
crime_map <-  arrange(crime_map,  group,  order)
head(crime_map)
region long lat group order subregion Murder Assault UrbanPop Rape
alabama -87.46201 30.38968 1 1 <NA> 13.2 236 58 21.2
alabama -87.48493 30.37249 1 2 <NA> 13.2 236 58 21.2
alabama -87.52503 30.37249 1 3 <NA> 13.2 236 58 21.2
alabama -87.53076 30.33239 1 4 <NA> 13.2 236 58 21.2
alabama -87.57087 30.32665 1 5 <NA> 13.2 236 58 21.2
alabama -87.58806 30.32665 1 6 <NA> 13.2 236 58 21.2
Once the data is in the correct format, it can be plotted (Figure 13-35), mapping one of
the columns with data values to fill:
ggplot(crime_map,  aes(x=long,  y=lat,  group=group,  fill=Assault)) +
geom_polygon(colour="black" ) +
coord_map("polyconic" )
Discussion
The preceding example used the default color scale, which goes from dark to light blue.
If you want to show how the values diverge from some middle value, you can use
scale_fill_gradient2(), as shown in Figure 13-36:
ggplot(crimes,  aes(map_id = state,  fill=Assault)) +
geom_map(map = states_map,  colour="black" ) +
scale_fill_gradient2(low="#559999" ,  mid="grey90" ,  high="#BB650B" ,
midpoint=median(crimes$Assault)) +
expand_limits(x = states_map$long,  y = states_map$lat) +
coord_map("polyconic" )



# Find the quantile bounds
qa <-  quantile(crimes$Assault,  c(0, 0.2, 0.4, 0.6, 0.8, 1.0))
qa
0% 20% 40% 60% 80% 100%
45.0 98.8 135.0 188.8 254.2 337.0
# Add a column of the quantile category
crimes$Assault_q <-  cut(crimes$Assault,  qa,
labels=c("0-20%" , "20-40%" , "40-60%" , "60-80%" , "80-100%" ),
include.lowest=TRUE)
crimes
state Murder Assault UrbanPop Rape Assault_q
Alabama alabama 13.2 236 58 21.2 60-80%
Alaska alaska 10.0 263 48 44.5 80-100%
...
Wisconsin wisconsin 2.6 53 66 10.8 0-20%
Wyoming wyoming 6.8 161 60 15.6 40-60%
# Generate a discrete color palette with 5 values
pal <-  colorRampPalette(c("#559999" , "grey80" , "#BB650B" ))(5)
pal
"#559999" "#90B2B2" "#CCCCCC" "#C3986B" "#BB650B"
ggplot(crimes,  aes(map_id = state,  fill=Assault_q)) +
geom_map(map = states_map,  colour="black" ) +
scale_fill_manual(values=pal) +
expand_limits(x = states_map$long,  y = states_map$lat) +
coord_map("polyconic" ) +
labs(fill="Assault Rate\nPercentile" )

# Generate a discrete color palette with 5 values
pal <-  colorRampPalette(c("#559999" , "grey80" , "#BB650B" ))(5)


# Find the quantile bounds
qa <-  quantile(crimes$Assault,  c(0, 0.2, 0.4, 0.6, 0.8, 1.0))
qa
0% 20% 40% 60% 80% 100%
45.0 98.8 135.0 188.8 254.2 337.0
# Add a column of the quantile category
crimes$Assault_q <-  cut(crimes$Assault,  qa,
labels=c("0-20%" , "20-40%" , "40-60%" , "60-80%" , "80-100%" ),
include.lowest=TRUE)
crimes
state Murder Assault UrbanPop Rape Assault_q
Alabama alabama 13.2 236 58 21.2 60-80%
Alaska alaska 10.0 263 48 44.5 80-100%
...
Wisconsin wisconsin 2.6 53 66 10.8 0-20%
Wyoming wyoming 6.8 161 60 15.6 40-60%
# Generate a discrete color palette with 5 values
pal <-  colorRampPalette(c("#559999" , "grey80" , "#BB650B" ))(5)
pal
"#559999" "#90B2B2" "#CCCCCC" "#C3986B" "#BB650B"
ggplot(crimes,  aes(map_id = state,  fill=Assault_q)) +
geom_map(map = states_map,  colour="black" ) +
scale_fill_manual(values=pal) +
expand_limits(x = states_map$long,  y = states_map$lat) +
coord_map("polyconic" ) +
labs(fill="Assault Rate\nPercentile" )

13.19. Making a Map with a Clean Background
Problem
You want to remove background elements from a map.
Solution
First, save the following theme:
# Create a theme with many of the background elements removed
theme_clean <- function(base_size = 12) {
require(grid) # Needed for unit() function
theme_grey(base_size) %+replace%
theme(
axis.title = element_blank(),
axis.text = element_blank(),
panel.background = element_blank(),
panel.grid = element_blank(),
axis.ticks.length = unit(0, "cm" ),
axis.ticks.margin = unit(0, "cm" ),
panel.margin = unit(0, "lines" ),
plot.margin = unit(c(0, 0, 0, 0), "lines" ),
complete = TRUE
)
}
ggplot(crimes,  aes(map_id = state,  fill=Assault_q)) +
geom_map(map = states_map,  colour="black" ) +
scale_fill_manual(values=pal) +
expand_limits(x = states_map$long,  y = states_map$lat) +
coord_map("polyconic" ) +
labs(fill="Assault Rate\nPercentile" ) +
theme_clean()


There are two ways to output to PDF files. One method is to open the PDF graphics
device with pdf(), make the plots, then close the device with dev.off(). This method
works for most graphics in R, including base graphics and grid-based graphics like those
created by ggplot2 and lattice:
# width and height are in inches
pdf("myplot.pdf" ,  width=4,  height=4)
# Make plots
plot(mtcars$wt,  mtcars$mpg)
print(ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point())
dev.off()

If you make more than one plot, each one will go on a separate page in the PDF output.
Notice that we called print() on the ggplot object to make sure that it will be output
even when this code is in a script.
The width and height are in inches, so to specify the dimensions in centimeters, you
must do the conversion manually:
# 8x8 cm
pdf("myplot.pdf" ,  width=8/2.54,  height=8/2.54)
If you are creating plots from a script and it throws an error while creating one, R might
not reach the call to dev.off(), and could be left in a state where the PDF device is still
open. When this happens, the PDF file won’t open properly until you manually call
dev.off().
If you are creating a graph with ggplot2, using ggsave() can be a little simpler. It simply
saves the last plot created with ggplot():
ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point()
# Default is inches, but you can specify unit
ggsave("myplot.pdf" ,  width=8,  height=8,  units="cm" )
With ggsave(), you don’t need to print the ggplot object, and if there is an error while
creating or saving the plot, there’s no need to manually close the graphic device.
ggsave() can’t be used to make multipage plots, though.


You want to create a scalable vector graphics (SVG) image of your plot.
Solution
SVG files can be created and used in much the same way as PDF files:
svg("myplot.svg" ,  width=4,  height=4)
plot(... )
dev.off()
# With ggsave()
ggsave("myplot.svg" ,  width=8,  height=8,  units="cm" )



14.5. Outputting to Bitmap (PNG/TIFF) Files
Problem
You want to create a bitmap of your plot, writing to a PNG file.
Solution
There are two ways to output to PNG bitmap files. One method is to open the PDF
graphics device with png(), make the plots, then close the device with dev.off(). This
method works for most graphics in R, including base graphics and grid-based graphics
like those created by ggplot2 and lattice:
# width and height are in pixels
png("myplot.png" ,  width=400,  height=400)
# Make plot
plot(mtcars$wt,  mtcars$mpg)
dev.off()
For outputting multiple plots, put %d in the filename. This will be replaced with 1, 2, 3,
and so on, for each subsequent plot:
# width and height are in pixels
png("myplot-%d.png" ,  width=400,  height=400)

plot(mtcars$wt,  mtcars$mpg)
print(ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point())
dev.off()
Notice that we called print() on the ggplot object to make sure that it will be output
even when this code is in a script.
The width and height are in pixels, and the default is to output at 72 pixels per inch
(ppi). This resolution is suitable for displaying on a screen, but will look pixelated and
jagged in print.
For high-quality print output, use at least 300 ppi. Figure 14-2 shows portions of the
same plot at different resolutions. In this example, we’ll use 300 ppi and create a 4 ×4-
inch PNG file:
ppi <- 300
# Calculate the height and width (in pixels) for a 4x4-inch image at 300 ppi
png("myplot.png" ,  width=4*ppi,  height=4*ppi,  res=ppi)
plot(mtcars$wt,  mtcars$mpg)
dev.off()

ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point()
# Default dimensions are in inches, but you can specify the unit
ggsave("myplot.png" ,  width=8,  height=8,  unit="cm" ,  dpi=300)
With ggsave(), you don’t need to print the ggplot object, and if there is an error while
creating or saving the plot there’s no need to manually close the graphic device.
Although the argument name is dpi, it really controls the pixels per inch
(ppi), not the dots per inch. When a grey pixel is rendered in print, it is
output with many smaller dots of black ink—and so print output has
more dots per inch than pixels per inch.

install.packages("Cairo" ) # One-time installation
CairoPNG("myplot.png" )
plot(... )
dev.off()

14.6. Using Fonts in PDF Files
Problem
You want to use fonts other than the basic ones provided by R in a PDF file.
Solution
The extrafont package can be used to create PDF files with different fonts.
There are a number of steps involved, beginning with some one-time setup. Download
and install Ghostscript, then run the following in R:
install.packages("extrafont" )
library(extrafont)
# Find and save information about fonts installed on your system
font_import()
# List the fonts
fonts()
After the one-time setup is done, there are tasks you need to do in each R session:
library(extrafont)
# Register the fonts with R
loadfonts()

# On Windows, you may need to tell it where Ghostscript is installed
# (adjust the path to match your installation of Ghostscript)
Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.05/bin/gswin32c.exe" )
Finally, you can create a PDF file and embed fonts into it, as in Figure 14-4:
library(ggplot2)
ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point() +
ggtitle("Title text goes here" ) +
theme(text = element_text(size = 16,  family="Impact" ))
ggsave("myplot.pdf" ,  width=4,  height=4)
embed_fonts("myplot.pdf" )

The extrafont package can be used to create bitmap or screen output. The procedure
is similar to using extrafont with PDF files (Recipe 14.6). The one-time setup is almost
the same, except that Ghostscript is not required:
install.packages("extrafont" )
library(extrafont)
# Find and save information about fonts installed on your system
font_import()
# List the fonts
fonts()
After the one-time setup is done, there are tasks you need to do in each R session:


library(extrafont)
# Register the fonts for Windows
loadfonts("win" )
Finally, you can create each output file or display graphs on screen, as in Figure 14-5:
library(ggplot2)
ggplot(mtcars,  aes(x=wt,  y=mpg)) + geom_point() +
ggtitle("Title text goes here" ) +
theme(text = element_text(size = 16,  family="Georgia" ,  face="italic" ))
ggsave("myplot.png" ,  width=4,  height=4,  dpi=300)

you’ll have to clean up and
restructure the data before you can visualize it.
Data sets in R are most often stored in data frames. They’re typically used as twodimensional data structures, with each row representing one case and each column
representing one variable. Data frames are essentially lists of vectors and factors, all of
the same length, where each vector or factor represents one column.
Here’s the heightweight data set:
library(gcookbook) # For the data set
heightweight

Factors and character vectors behave similarly in ggplot2—the main difference is that
with character vectors, items will be displayed in lexicographical order, but with factors,
items will be displayed in the same order as the factor levels, which you can control.

15.1. Creating a Data Frame
Problem
You want to create a data frame from vectors.
Solution
You can put vectors together in a data frame with data.frame():
# Two starting vectors
g <-  c("A" , "B" , "C" )
x <- 1: 3
dat <-  data.frame(g,  x)
dat
g x
A 1
B 2
C 3

Discussion
A data frame is essentially a list of vectors and factors. Each vector or factor can be
thought of as a column in the data frame.
If your vectors are in a list, you can convert the list to a data frame with the as.data
.frame() function:
lst <-  list(group = g,  value = x) # A list of vectors
dat <-  as.data.frame(lst)

15.2. Getting Information About a Data Structure
Problem
You want to find out information about an object or data structure.
Solution
Use the str() function:
str(ToothGrowth)
'data.frame': 60 obs. of 3 variables:
$ len : num 4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
$ supp: Factor w/ 2 levels "OJ","VC": 2 2 2 2 2 2 2 2 2 2 ...
$ dose: num 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
This tells us that ToothGrowth is a data frame with three columns, len, supp, and dose.
len and dose contain numeric values, while supp is a factor with two levels.
Discussion
The str() function is very useful for finding out more about data structures. One com‐
mon source of problems is a data frame where one of the columns is a character vector
instead of a factor, or vice versa. This can cause puzzling issues with analyses or graphs.
When you print out a data frame the normal way, by just typing the name at the prompt
and pressing Enter, factor and character columns appear exactly the same. The difference
will be revealed only when you run str() on the data frame, or print out the column
by itself:
tg <-  ToothGrowth
tg$supp <-  as.character(tg$supp)
str(tg)
'data.frame': 60 obs. of 3 variables:
$ len : num 4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
$ supp: chr "VC" "VC" "VC" "VC" ...
$ dose: num 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
# Print out the columns by themselves
# From old data frame (factor)
ToothGrowth$supp
[1] VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC
[26] VC VC VC VC VC OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ
[51] OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ
Levels: OJ VC
# From new data frame (character)
tg$supp
[1] "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC"
[16] "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC" "VC"
[31] "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ"
[46] "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ" "OJ"
15.3. Adding a Column to a Data Frame
Problem
You want to add a column to a data frame.
Solution
Just assign some value to the new column.
If you assign a single value to the new column, the entire column will be filled with that
value. This adds a column named newcol, filled with NA:
data$newcol <- NA
You can also assign a vector to the new column:
data$newcol <-  vec
If the length of the vector is less than the number of rows in the data frame, then the
vector is repeated to fill all the rows.

Discussion
Each “column” of a data frame is a vector or factor. R handles them slightly differently
from standalone vectors, because all the columns in a data frame have the same length.

15.4. Deleting a Column from a Data Frame
Problem
You want to delete a column from a data frame.
Solution
Assign NULL to that column:
data$badcol <- NULL
Discussion
You can also use the subset() function and put a -  (minus sign) in front of the column(s)
to drop:
# Return data without badcol
data <-  subset(data,  select = - badcol)
# Exclude badcol and othercol
data <-  subset(data,  select = c(- badcol, - othercol))
See Also
Recipe 15.7 for more on getting a subset of a data frame.
15.5. Renaming Columns in a Data Frame
Problem
You want to rename the columns in a data frame.
Solution
Use the names(dat) <-  function:
names(dat) <-  c("name1" , "name2" , "name3" )
Discussion
If you want to rename the columns by name:
library(gcookbook) # For the data set
names(anthoming) # Print the names of the columns
"angle" "expt" "ctrl"
names(anthoming)[names(anthoming) == "ctrl" ] <-  c("Control" )
names(anthoming)[names(anthoming) == "expt" ] <-  c("Experimental" )
names(anthoming)
"angle" "Experimental" "Control"
They can also be renamed by numeric position:
names(anthoming)[1] <- "Angle"
names(anthoming)
"Angle" "Experimental" "Control"


15.6. Reordering Columns in a Data Frame
Problem
You want to change the order of columns in a data frame.
Solution
To reorder columns by their numeric position:
dat <-  dat[c(1, 3, 2)]
To reorder by column name:
dat <-  dat[c("col1" , "col3" , "col2" )]
Discussion
The previous examples use list-style indexing. A data frame is essentially a list of vectors,
and indexing into it as a list will return another data frame. You can get the same effect
with matrix-style indexing:
library(gcookbook) # For the data set
anthoming
angle expt ctrl
-20 1 0
-10 7 3
0 2 3
10 0 3
20 0 1
anthoming[c(1, 3, 2)]  # List-style indexing
angle ctrl expt
-20 0 1
-10 3 7
0 3 2
10 3 0
20 1 0
# Putting nothing before the comma means to select all rows
anthoming[,  c(1, 3, 2)]  # Matrix-style indexing
angle ctrl expt
-20 0 1
-10 3 7
0 3 2
10 3 0
20 1 0

In this case, both methods return the same result, a data frame. However, when retrieving
a single column, list-style indexing will return a data frame, while matrix-style indexing
will return a vector, unless you use drop=FALSE:
anthoming[3]  # List-style indexing
ctrl
0
3
3
3
1
anthoming[, 3]  # Matrix-style indexing
0 3 3 3 1
anthoming[, 3,  drop=FALSE]  # Matrix-style indexing with drop=FALSE
ctrl
0
3
3
3
1

15.7. Getting a Subset of a Data Frame
Problem
You want to get a subset of a data frame.
Solution
Use the subset() function. It can be used to pull out rows that satisfy a set of conditions
and to select particular columns.
We’ll use the climate data set for the examples here:
library(gcookbook) # For the data set
climate
Source Year Anomaly1y Anomaly5y Anomaly10y Unc10y
Berkeley 1800 NA NA -0.435 0.505
Berkeley 1801 NA NA -0.453 0.493
Berkeley 1802 NA NA -0.460 0.486
...
CRUTEM3 2009 0.7343 NA NA NA
CRUTEM3 2010 0.8023 NA NA NA
CRUTEM3 2011 0.6193 NA NA NA

The following will pull out only rows where Source is "Berkeley" and only the columns
named Year and Anomaly10y:
subset(climate,  Source == "Berkeley" ,  select = c(Year,  Anomaly10y))
Year Anomaly10y
1800 -0.435
1801 -0.453
1802 -0.460
...
2002 0.856
2003 0.869
2004 0.884
It is possible to use multiple selection criteria, by using the |  (OR) and & (AND) oper‐
ators. For example, this will pull out only those rows where source is "Berkeley" , be‐
tween the years 1900 and 2000:
subset(climate,  Source == "Berkeley"  & Year >= 1900 & Year <= 2000,
select = c(Year,  Anomaly10y))
Year Anomaly10y
1900 -0.171
1901 -0.162
1902 -0.177
...
1998 0.680
1999 0.734
2000 0.748
You can also get a subset of data by indexing into the data frame with square brackets,
although this approach is somewhat less elegant. The following code has the same effect
as the code we just saw. The part before the comma picks out the rows, and the part after
the comma picks out the columns:
climate[climate$Source=="Berkeley" & climate$Year >= 1900 & climate$Year <= 2000,
c("Year" , "Anomaly10y" )]
If you grab just a single column this way, it will be returned as a vector instead of a data
frame. To prevent this, use drop=FALSE, as in:
climate[climate$Source=="Berkeley" & climate$Year >= 1900 & climate$Year <= 2000,
c("Year" , "Anomaly10y" ),  drop=FALSE]
Finally, it’s also possible to pick out rows and columns by their numeric position. This
gets the second and fifth columns of the first 100 rows:
climate[1: 100,  c(2, 5)]

15.8. Changing the Order of Factor Levels
Problem
You want to change the order of levels in a factor.
Solution
The level order can be specified explicitly by passing the factor to factor() and speci‐
fying levels. In this example, we’ll create a factor that initially has the wrong ordering:
# By default, levels are ordered alphabetically
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))
sizes
small large large small medium
Levels: large medium small
# Change the order of levels
sizes <-  factor(sizes,  levels = c("small" , "medium" , "large" ))
sizes
small large large small medium
Levels: small medium large
The order can also be specified with levels when the factor is first created.
Discussion
There are two kinds of factors in R: ordered factors and regular factors. In both types,
the levels are arranged in some order; the difference is that the order is meaningful for
an ordered factor, but it is arbitrary for a regular factor—it simply reflects how the data
is stored. For graphing data, the distinction between ordered and regular factors is gen‐
erally unimportant, and they can be treated the same.
The order of factor levels affects graphical output. When a factor variable is mapped to
an aesthetic property in ggplot2, the aesthetic adopts the ordering of the factor levels.
If a factor is mapped to the x-axis, the ticks on the axis will be in the order of the factor
levels, and if a factor is mapped to color, the items in the legend will be in the order of
the factor levels.
To reverse the level order, you can use rev(levels()):

factor(sizes,  levels = rev(levels(sizes)))
small large large small medium
Levels: small medium large
See Also
To reorder a factor based on the value of another variable, see Recipe 15.9.
Reordering factor levels is useful for controlling the order of axes and legends. See Rec‐
ipes 8.4 and 10.3 for more information.

15.9. Changing the Order of Factor Levels Based
on Data Values
Problem
You want to change the order of levels in a factor based on values in the data.
Solution
Use reorder() with the factor that has levels to reorder, the values to base the reordering
on, and a function that aggregates the values:
# Make a copy since we'll modify it
iss <-  InsectSprays
iss$spray
[1] A A A A A A A A A A A A B B B B B B B B B B B B C C C C C C C C C C C C D D
[39] D D D D D D D D D D E E E E E E E E E E E E F F F F F F F F F F F F
Levels: A B C D E F
iss$spray <-  reorder(iss$spray,  iss$count,  FUN=mean)
iss$spray
[1] A A A A A A A A A A A A B B B B B B B B B B B B C C C C C C C C C C C C D D
[39] D D D D D D D D D D E E E E E E E E E E E E F F F F F F F F F F F F
attr(,"scores")
A B C D E F
14.500000 15.333333 2.083333 4.916667 3.500000 16.666667
Levels: C E D A B F
Notice that the original levels were ABCDEF, while the reordered levels are CEDABF. The
new order is determined by splitting iss$count into pieces according to the values in
iss$spray, and then taking the mean of each group.

Discussion
The usefulness ofreorder() might not be obvious from just looking at the raw output.
Figure 15-1 shows three graphs made with reorder(). In these graphs, the order in
which the items appear is determined by their values.
Figure 15-1. Left: original data; middle: reordered by the mean of each group; right: re‐
ordered by the median of each group
In the middle graph in Figure 15-1, the boxes are sorted by the mean. The horizontal
line that runs across each box represents the median of the data. Notice that these values
do not increase strictly from left to right. That’s because with this particular data set,
sorting by the mean gives a different order than sorting by the median. To make the
median lines increase from left to right, as in the graph on the right in Figure 15-1, we
used the median() function in reorder().
See Also
Reordering factor levels is also useful for controlling the order of axes and legends. See
Recipes 8.4 and 10.3 for more information.
15.10. Changing the Names of Factor Levels
Problem
You want to change the names of levels in a factor.
Solution
Use revalue() or mapvalues() from the plyr package:
sizes <-  factor(c( "small" , "large" , "large" , "small" , "medium" ))
sizes
small large large small medium

15.9. Changing the Order of Factor Levels Based
on Data Values
Problem
You want to change the order of levels in a factor based on values in the data.
Solution
Use reorder() with the factor that has levels to reorder, the values to base the reordering
on, and a function that aggregates the values:
# Make a copy since we'll modify it
iss <-  InsectSprays
iss$spray
[1] A A A A A A A A A A A A B B B B B B B B B B B B C C C C C C C C C C C C D D
[39] D D D D D D D D D D E E E E E E E E E E E E F F F F F F F F F F F F
Levels: A B C D E F
iss$spray <-  reorder(iss$spray,  iss$count,  FUN=mean)
iss$spray
[1] A A A A A A A A A A A A B B B B B B B B B B B B C C C C C C C C C C C C D D
[39] D D D D D D D D D D E E E E E E E E E E E E F F F F F F F F F F F F
attr(,"scores")
A B C D E F
14.500000 15.333333 2.083333 4.916667 3.500000 16.666667
Levels: C E D A B F
Notice that the original levels were ABCDEF, while the reordered levels are CEDABF. The
new order is determined by splitting iss$count into pieces according to the values in
iss$spray, and then taking the mean of each group.

15.10. Changing the Names of Factor Levels
Problem
You want to change the names of levels in a factor.
Solution
Use revalue() or mapvalues() from the plyr package:
sizes <-  factor(c( "small" , "large" , "large" , "small" , "medium" ))
sizes
small large large small medium

Levels: large medium small
levels(sizes)
"large" "medium" "small"
# With revalue(), pass it a named vector with the mappings
sizes1 <-  revalue(sizes,  c(small="S" ,  medium="M" ,  large="L" ))
sizes1
S L L S M
Levels: L M S
# Can also use quotes -- useful if there are spaces or other strange characters
revalue(sizes,  c("small" ="S" , "medium" ="M" , "large" ="L" ))
# mapvalues() lets you use two separate vectors instead of a named vector
mapvalues(sizes,  c("small" , "medium" , "large" ),  c("S" , "M" , "L" ))
Discussion
The revalue() and mapvalues() functions are convenient, but for a more traditional
(and clunky) R method for renaming factor levels, use the levels()<-  function:
sizes <-  factor(c( "small" , "large" , "large" , "small" , "medium" ))
# Index into the levels and rename each one
levels(sizes)[levels(sizes)=="large" ]  <- "L"
levels(sizes)[levels(sizes)=="medium" ] <- "M"
levels(sizes)[levels(sizes)=="small" ]  <- "S"
sizes
S L L S M
Levels: L M S
If you are renaming all your factor levels, there is a simpler method. You can pass a list
to levels()<- :
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))
levels(sizes) <-  list(S="small" ,  M="medium" ,  L="large" )
sizes
S L L S M
Levels: L M S
With this method, all factor levels must be specified in the list; if any are missing, they
will be replaced with NA.
It’s also possible to rename factor levels by position, but this is somewhat inelegant:
# By default, levels are ordered alphabetically
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))
small large large small medium
Levels: large medium small
levels(sizes)[1] <- "L"
sizes
small L L small medium
Levels: L medium small
# Rename all levels at once
levels(sizes) <-  c("L" , "M" , "S" )
sizes
[1] S L L S M
Levels: L M S
It’s safer to rename factor levels by name rather than by position, since you will be less
likely to make a mistake (and mistakes here may be hard to detect). Also, if your input
data set changes to have more (or fewer) levels, the numeric positions of the existing
levels could change, which could cause serious but nonobvious problems for your
analysis.

If you are renaming all your factor levels, there is a simpler method. You can pass a list
to levels()<- :
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))
levels(sizes) <-  list(S="small" ,  M="medium" ,  L="large" )
sizes
S L L S M
Levels: L M S
With this method, all factor levels must be specified in the list; if any are missing, they
will be replaced with NA.
It’s also possible to rename factor levels by position, but this is somewhat inelegant:
# By default, levels are ordered alphabetically
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))


small large large small medium
Levels: large medium small
levels(sizes)[1] <- "L"
sizes
small L L small medium
Levels: L medium small
# Rename all levels at once
levels(sizes) <-  c("L" , "M" , "S" )
sizes
[1] S L L S M
Levels: L M S

15.11. Removing Unused Levels from a Factor
Problem
You want to remove unused levels from a factor.
Solution
Sometimes, after processing your data you will have a factor that contains levels that are
no longer used. Here’s an example:
sizes <-  factor(c("small" , "large" , "large" , "small" , "medium" ))
sizes <-  sizes[1: 3]
sizes
small large large
Levels: large medium small
To remove them, use droplevels():



sizes <-  droplevels(sizes)
sizes
small large large
Levels: large small
Discussion
The droplevels() function preserves the order of factor levels.
You can use the except argument to keep particular levels.
15.12. Changing the Names of Items in a Character Vector
Problem
You want to change the names of items in a character vector.
Solution
Use revalue() or mapvalues() from the plyr package:
sizes <-  c("small" , "large" , "large" , "small" , "medium" )
sizes
 "small" "large" "large" "small" "medium"
# With revalue(), pass it a named vector with the mappings
sizes1 <-  revalue(sizes,  c(small="S" ,  medium="M" ,  large="L" ))
sizes1
 "S" "L" "L" "S" "M"
# Can also use quotes -- useful if there are spaces or other strange characters
revalue(sizes,  c("small" ="S" , "medium" ="M" , "large" ="L" ))
# mapvalues() lets you use two separate vectors instead of a named vector
mapvalues(sizes,  c("small" , "medium" , "large" ),  c("S" , "M" , "L" ))

Discussion
A more traditional R method is to use square-bracket indexing to select the items and
rename them:
sizes <-  c("small" , "large" , "large" , "small" , "medium" )
sizes
"small" "large" "large" "small" "medium"
sizes[sizes=="small" ]  <- "S"
sizes[sizes=="medium" ] <- "M"
sizes[sizes=="large" ]  <- "L"
sizes
"S" "L" "L" "S" "M"
See Also
If, instead of a character vector, you have a factor with levels to rename, see Recipe 15.10.
15.13. Recoding a Categorical Variable to Another
Categorical Variable
Problem
You want to recode a categorical variable to another variable.
Solution
For the examples here, we’ll use a subset of the PlantGrowth data set:
# Work on a subset of the PlantGrowth data set
pg <-  PlantGrowth[c(1, 2, 11, 21, 22), ]
pg
weight group
4.17 ctrl
5.58 ctrl
4.81 trt1
6.31 trt2
5.12 trt2
In this example, we’ll recode the categorical variable group into another categorical
variable, treatment. If the old value was "ctrl" , the new value will be "No" , and if the
old value was "trt1"  or "trt2" , the new value will be "Yes" .
This can be done with the match() function:
pg <-  PlantGrowth
oldvals <-  c("ctrl" , "trt1" , "trt2" )
newvals <-  factor(c("No" ,  "Yes" ,  "Yes" ))
pg$treatment <-  newvals[ match(pg$group,  oldvals) ]
It can also be done (more awkwardly) by indexing in the vectors:
pg$treatment[pg$group == "ctrl" ] <- "no"
pg$treatment[pg$group == "trt1" ] <- "yes"

pg$treatment[pg$group == "trt2" ] <- "yes"
# Convert to a factor
pg$treatment <-  factor(pg$treatment)
pg
weight group treatment
4.17 ctrl no
5.58 ctrl no
4.81 trt1 yes
6.31 trt2 yes
5.12 trt2 yes
Here, we combined two of the factor levels and put the result into a new column. If you
simply want to rename the levels of a factor, see Recipe 15.10.
Discussion
The coding criteria can also be based on values in multiple columns, by using the & and
|  operators:
pg$newcol[pg$group == "ctrl"  & pg$weight < 5] <- "no_small"
pg$newcol[pg$group == "ctrl"  & pg$weight >= 5] <- "no_large"
pg$newcol[pg$group == "trt1" ] <- "yes"
pg$newcol[pg$group == "trt2" ] <- "yes"
pg$newcol <-  factor(pg$newcol)
pg
weight group weightcat treatment newcol
4.17 ctrl small no no_small
5.58 ctrl large no no_large
4.81 trt1 small yes yes
4.17 trt1 small yes yes
6.31 trt2 large yes yes
5.12 trt2 large yes yes
It’s also possible to combine two columns into one using the interaction() function,
which appends the values with a "."  in between. This combines the weightcat and
treatment columns into a new column, weighttrt:
pg$weighttrt <-  interaction(pg$weightcat,  pg$treatment)
pg
weight group weightcat treatment newcol weighttrt
4.17 ctrl small no no_small small.no
5.58 ctrl large no no_large large.no
4.81 trt1 small yes yes small.yes
4.17 trt1 small yes yes small.yes
6.31 trt2 large yes yes large.yes
5.12 trt2 large yes yes large.yes

See Also
For more on renaming factor levels, see Recipe 15.10.
See Recipe 15.14 for recoding continuous values to categorical values.
15.14. Recoding a Continuous Variable to a
Categorical Variable
Problem
You want to recode a continuous variable to another variable.
Solution
For the examples here, we’ll use a subset of the PlantGrowth data set.
# Work on a subset of the PlantGrowth data set
pg <-  PlantGrowth[c(1, 2, 11, 21, 22), ]
pg
weight group
4.17 ctrl
5.58 ctrl
4.81 trt1
6.31 trt2
5.12 trt2
In this example, we’ll recode the continuous variable weight into a categorical variable,
wtclass, using the cut() function:
pg$wtclass <-  cut(pg$weight,  breaks = c(0, 5, 6,  Inf))
pg
weight group wtclass
4.17 ctrl (0,5]
5.58 ctrl (5,6]
4.81 trt1 (0,5]
4.17 trt1 (0,5]
6.31 trt2 (6,Inf]
5.12 trt2 (5,6]
Discussion
For three categories we specify four bounds, which can include Inf and -Inf. If a data
value falls outside of the specified bounds, it’s categorized as NA. The result of cut() is
a factor, and you can see from the example that the factor levels are named after the
bounds.

To change the names of the levels, set the labels:
pg$wtclass <-  cut(pg$weight,  breaks = c(0, 5, 6,  Inf),
labels = c("small" , "medium" , "large" ))
pg
weight group wtclass
4.17 ctrl small
5.58 ctrl medium
4.81 trt1 small
4.17 trt1 small
6.31 trt2 large
5.12 trt2 medium
As indicated by the factor levels, the bounds are by default open on the left and closed
on the right. In other words, they don’t include the lowest value, but they do include the
highest value. For the smallest category, you can have it include both the lower and upper
values by setting include.lowest=TRUE. In this example, this would result in 0 values
going into the small category; otherwise, 0 would be coded as NA.
If you want the categories to be closed on the left and open on the right, set right =
FALSE:
cut(pg$weight,  breaks = c(0, 5, 6,  Inf),  right = FALSE)
See Also
To recode a categorical variable to another categorical variable, see Recipe 15.13.

15.15. Transforming Variables
Problem
You want to transform a variable in a data frame.
Solution
Reference the new column with the $ operator, and assign some values to it. For this
example, we’ll use a copy of the heightweight data set:
library(gcookbook) # For the data set
# Make a copy of the data
hw <-  heightweight
hw
sex ageYear ageMonth heightIn weightLb
 f 11.92 143 56.3 85.0
f 12.92 155 62.3 105.0
...
m 13.92 167 62.0 107.5
m 12.58 151 59.3 87.0
This will convert heightIn to centimeters and store it in a new column, heightCm:
hw$heightCm <-  hw$heightIn * 2.54
hw
sex ageYear ageMonth heightIn weightLb heightCm
f 11.92 143 56.3 85.0 143.002
f 12.92 155 62.3 105.0 158.242
...
m 13.92 167 62.0 107.5 157.480
m 12.58 151 59.3 87.0 150.622
Discussion
For slightly easier-to-read code, you can use transform() or mutate() from the plyr
package. You only need to specify the data frame once, as the first argument to the
function, meaning these provide a cleaner syntax, especially if you are transforming
multiple variables:
hw <-  transform(hw,  heightCm = heightIn * 2.54,  weightKg = weightLb / 2.204)
library(plyr)
hw <-  mutate(hw,  heightCm = heightIn * 2.54,  weightKg = weightLb / 2.204)
hw
sex ageYear ageMonth heightIn weightLb heightCm weightKg
f 11.92 143 56.3 85.0 143.002 38.56624
f 12.92 155 62.3 105.0 158.242 47.64065
...
m 13.92 167 62.0 107.5 157.480 48.77495
m 12.58 151 59.3 87.0 150.622 39.47368
It is also possible to calculate a new variable based on multiple variables:
# These all have the same effect:
hw <-  transform(hw,  bmi = weightKg / (heightCm / 100)^2)
hw <-  mutate(hw,  bmi = weightKg / (heightCm / 100)^2)
hw$bmi <-  hw$weightKg / (hw$heightCm/100)^2
hw
sex ageYear ageMonth heightIn weightLb heightCm weightKg bmi
f 11.92 143 56.3 85.0 143.002 38.56624 18.85919
f 12.92 155 62.3 105.0 158.242 47.64065 19.02542
...
m 13.92 167 62.0 107.5 157.480 48.77495 19.66736
m 12.58 151 59.3 87.0 150.622 39.47368 17.39926

The main functional difference between transform() and mutate() is that trans
form() calculates the new columns simultaneously, while mutate() calculates the new
columns sequentially, allowing you to base one new column on another new column.
Since bmi is calculated from heightCm and weightKg, it is not possible to calculate all of
them in a single call to transform(); heightCm and weightKg must be calculated first,
and then bmi, as shown here.
With mutate(), however, we can calculate them all in one go. The following code has
the same effect as the previous separate blocks:
hw <-  heightweight
hw <-  mutate(hw,
heightCm = heightIn * 2.54,
weightKg = weightLb / 2.204,
bmi = weightKg / (heightCm / 100)^2)
See Also
See Recipe 15.16 for how to perform group-wise transformations on data.

15.16. Transforming Variables by Group
Problem
You want to transform variables by performing operations on groups of data, as specified
by a grouping variable.
Solution
Use ddply() from the plyr package with the transform() function, and specify the
operations:
library(MASS) # For the data set
library(plyr)
cb <-  ddply(cabbages, "Cult" ,  transform,  DevWt = HeadWt -  mean(HeadWt))
 Cult Date HeadWt VitC DevWt
 c39 d16 2.5 51 -0.40666667
 c39 d16 2.2 55 -0.70666667
 ...
 c52 d21 1.5 66 -0.78000000
 c52 d21 1.6 72 -0.68000000

 Discussion
Let’s take a closer look at the cabbages data set. It has two grouping variables (factors):
Cult, which has levels c39 and c52, and Date, which has levels d16, d20, and d21. It also
has two measured numeric variables, HeadWt and VitC:
cabbages
Cult Date HeadWt VitC
c39 d16 2.5 51
c39 d16 2.2 55
...
c52 d21 1.5 66
c52 d21 1.6 72
Suppose we want to find, for each case, the deviation of HeadWt from the overall mean.
All we have to do is take the overall mean and subtract it from the observed value for
each case:
transform(cabbages,  DevWt = HeadWt -  mean(HeadWt))
Cult Date HeadWt VitC DevWt
c39 d16 2.5 51 -0.093333333
c39 d16 2.2 55 -0.393333333
...
c52 d21 1.5 66 -1.093333333
c52 d21 1.6 72 -0.993333333
You’ll often want to do separate operations like this for each group, where the groups
are specified by one or more grouping variables. Suppose, for example, we want to nor‐
malize the data within each group by finding the deviation of each case from the mean
within the group, where the groups are specified by Cult. In these cases, we can use
ddply() from the plyr package with the transform() function:
library(plyr)
cb <-  ddply(cabbages, "Cult" ,  transform,  DevWt = HeadWt -  mean(HeadWt))
cb
Cult Date HeadWt VitC DevWt
c39 d16 2.5 51 -0.40666667
c39 d16 2.2 55 -0.70666667
...
c52 d21 1.5 66 -0.78000000
c52 d21 1.6 72 -0.68000000
First it splits cabbages into separate data frames based on the value of Cult. There are
two levels of Cult, c39 and c52, so there are two data frames. It then applies the trans
form() function, with the remaining arguments, to each data frame.

Notice that the call to ddply() has all the same parts as the previous call to trans
form(). The only differences are that the parts are slightly rearranged and it adds the
splitting variable, in this case, Cult.
The before and after results are shown in Figure 15-2:
# The data before normalizing
ggplot(cb,  aes(x=Cult,  y=HeadWt)) + geom_boxplot()
# After normalizing
ggplot(cb,  aes(x=Cult,  y=DevWt)) + geom_boxplot()
Figure 15-2. Left: before normalizing; right: after normalizing
You can also split the data frame on multiple variables and perform operations on mul‐
tiple variables. This will split by Cult and Date, forming a group for each unique com‐
bination of the two variables, and then it will calculate the deviation from the mean of
HeadWt and VitC within each group:
ddply(cabbages,  c("Cult" , "Date" ),  transform,
DevWt = HeadWt -  mean(HeadWt),  DevVitC = VitC -  mean(VitC))
Cult Date HeadWt VitC DevWt DevVitC
c39 d16 2.5 51 -0.68 0.7
c39 d16 2.2 55 -0.98 4.7
...
c52 d21 1.5 66 0.03 -5.8
c52 d21 1.6 72 0.13 0.2
See Also
To summarize data by groups, see Recipe 15.17.

15.17. Summarizing Data by Groups
Problem
You want to summarize your data, based on one or more grouping variables.
Solution
Use ddply() from the plyr package with the summarise() function, and specify the
operations to do:
library(MASS) # For the data set
library(plyr)
ddply(cabbages,  c("Cult" , "Date" ),  summarise,  Weight = mean(HeadWt),
VitC = mean(VitC))
Cult Date Weight VitC
c39 d16 3.18 50.3
c39 d20 2.80 49.4
c39 d21 2.74 54.8
c52 d16 2.26 62.5
c52 d20 3.11 58.9
c52 d21 1.47 71.8
Discussion
Let’s take a closer look at the cabbages data set. It has two factors that can be used as
grouping variables: Cult, which has levels c39 and c52, and Date, which has levels d16,
d20, and d21. It also has two numeric variables, HeadWt and VitC:
cabbages
Cult Date HeadWt VitC
c39 d16 2.5 51
c39 d16 2.2 55
...
c52 d21 1.5 66
c52 d21 1.6 72
Finding the overall mean ofHeadWt is simple. We could just use the mean() function on
that column, but for reasons that will soon become clear, we’ll use the summarise()
function instead:
library(plyr)
summarise(cabbages,  Weight = mean(HeadWt))
Weight
2.593333

The result is a data frame with one row and one column, named Weight.
Often we want to find information about each subset of the data, as specified by a
grouping variable. For example, suppose we want to find the mean of each Cult group.
To do this, we can use ddply() with summarise(). Notice how the arguments get shifted
around when we use them together:
library(plyr)
ddply(cabbages, "Cult" ,  summarise,  Weight = mean(HeadWt))
Cult Weight
c39 2.906667
c52 2.280000
The command first splits the data frame cabbages into separate data frames based on
the value ofCult. There are two levels ofCult, c39 and c52, so there are two data frames.
It then applies the summarise() function to each of these data frames; it calculates
Weight by taking the mean() of the HeadWt column in each of the data frames. The
resulting summarized data frames each have one row, and ddply() puts them back
together into one data frame, which is then returned.
Summarizing the data frame by splitting it up with more variables (or columns) is simple:
just use a vector that names the additional variables. It’s also possible to get more than
one summary value by specifying more calculated columns. Here we’ll summarize each
Cult and Date group, getting the average of HeadWt and VitC:
ddply(cabbages,  c("Cult" , "Date" ),  summarise,  Weight = mean(HeadWt),
VitC = mean(VitC))
Cult Date Weight VitC
c39 d16 3.18 50.3
c39 d20 2.80 49.4
c39 d21 2.74 54.8
c52 d16 2.26 62.5
c52 d20 3.11 58.9
c52 d21 1.47 71.8
It’s possible to do more than take the mean. You may, for example, want to compute the
standard deviation and count of each group. To get the standard deviation, use the sd()
function, and to get a count, use the length() function:
ddply(cabbages,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt),
sd = sd(HeadWt),
n = length(HeadWt))
Cult Date Weight sd n
c39 d16 3.18 0.9566144 10
c39 d20 2.80 0.2788867 10
c39 d21 2.74 0.9834181 10
c52 d16 2.26 0.4452215 10
c52 d20 3.11 0.7908505 10
c52 d21 1.47 0.2110819 10
Other useful functions for generating summary statistics include min(), max(), and
median().
Dealing with NAs
One potential pitfall is that NAs in the data will lead to NAs in the output. Let’s see what
happens if we sprinkle a few NAs into HeadWt:
c1 <-  cabbages # Make a copy
c1$HeadWt[c(1, 20, 45)] <- NA # Set some values to NA
ddply(c1,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt),
sd = sd(HeadWt),
n = length(HeadWt))
Cult Date Weight sd n
c39 d16 NA NA 10
c39 d20 NA NA 10
c39 d21 2.74 0.9834181 10
c52 d16 2.26 0.4452215 10
c52 d20 NA NA 10
c52 d21 1.47 0.2110819 10
There are two problems here. The first problem is that mean() and sd() simply return
NA if any of the input values are NA. Fortunately, these functions have an option to deal
with this very issue: setting na.rm=TRUE will tell them to ignore the NAs.
The second problem is that length() counts NAs just like any other value, but since these
values represent missing data, they should be excluded from the count. The length()
function doesn’t have an na.rm flag, but we can get the same effect by using sum(!
is.na(...)). The is.na() function returns a logical vector: it has a TRUE for each NA
item, and a FALSE for all other items. It is inverted by the ! , and then sum() adds up the
number of TRUEs. The end result is a count of non-NAs:
ddply(c1,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt,  na.rm=TRUE),
sd = sd(HeadWt,  na.rm=TRUE),
n = sum(!is.na(HeadWt)))
Cult Date Weight sd n
c39 d16 3.255556 0.9824855 9
c39 d20 2.722222 0.1394433 9
c39 d21 2.740000 0.9834181 10
c52 d16 2.260000 0.4452215 10
c52 d20 3.044444 0.8094923 9
c52 d21 1.470000 0.2110819 10
Missing combinations
If there are any empty combinations of the grouping variables, they will not appear in
the summarized data frame. These missing combinations can cause problems when
making graphs. To illustrate, we’ll remove all entries that have levels c52 and d21. The
graph on the left in Figure 15-3 shows what happens when there’s a missing combination
in a bar graph:
# Copy cabbages and remove all rows with both c52 and d21
c2 <-  subset(c1,  ! ( Cult=="c52" & Date=="d21" ) )
c2a <-  ddply(c2,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt,  na.rm=TRUE),
sd = sd(HeadWt,  na.rm=TRUE),
n = sum(!is.na(HeadWt)))
c2a
Cult Date Weight sd n
c39 d16 3.255556 0.9824855 9
c39 d20 2.722222 0.1394433 9
c39 d21 2.740000 0.9834181 10
c52 d16 2.260000 0.4452215 10
c52 d20 3.044444 0.8094923 9
# Make the graph
ggplot(c2a,  aes(x=Date,  fill=Cult,  y=Weight)) + geom_bar(position="dodge" )
Figure 15-3. Left: bar graph with a missing combination; right: with missing combina‐
tion filled
To fill in the missing combination (Figure 15-3, right), give ddply() the .drop=FALSE
flag:
c2b <-  ddply(c2,  c("Cult" , "Date" ), . drop=FALSE,  summarise,
Weight = mean(HeadWt,  na.rm=TRUE),
sd = sd(HeadWt,  na.rm=TRUE),
n = sum(!is.na(HeadWt)))
c2b
Cult Date Weight sd n
c39 d16 3.255556 0.9824855 9
c39 d20 2.722222 0.1394433 9
c39 d21 2.740000 0.9834181 10
c52 d16 2.260000 0.4452215 10
c52 d20 3.044444 0.8094923 9
c52 d21 NaN NA 0
# Make the graph
ggplot(c2b,  aes(x=Date,  fill=Cult,  y=Weight)) + geom_bar(position="dodge" )
See Also
If you want to calculate standard error and confidence intervals, see Recipe 15.18.
See Recipe 6.8 for an example ofusing stat_summary() to calculate means and overlay
them on a graph.
To perform transformations on data by groups, see Recipe 15.16.
15.18. Summarizing Data with Standard Errors and
Confidence Intervals
Problem
You want to summarize your data with the standard error of the mean and/or confidence
intervals.
Solution
Getting the standard error of the mean involves two steps: first get the standard deviation
and count for each group, then use those values to calculate the standard error. The
standard error for each group is just the standard deviation divided by the square root
of the sample size:
library(MASS) # For the data set
library(plyr)
ca <-  ddply(cabbages,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt,  na.rm=TRUE),
sd = sd(HeadWt,  na.rm=TRUE),
n = sum(!is.na(HeadWt)),
se = sd/sqrt(n))

ca
Cult Date Weight sd n se
c39 d16 3.18 0.9566144 10 0.30250803
c39 d20 2.80 0.2788867 10 0.08819171
c39 d21 2.74 0.9834181 10 0.31098410
c52 d16 2.26 0.4452215 10 0.14079141
c52 d20 3.11 0.7908505 10 0.25008887
c52 d21 1.47 0.2110819 10 0.06674995
In versions of plyr before 1.8, summarise() created all the new columns
simultaneously, so you would have to create the se column separately,
after creating the sd and n columns.
Discussion
Another method is to calculate the standard error in the call ddply. It’s not possible to
refer to the sd and n columns inside of the ddply call, so we’ll have to recalculate them
to get se. This will do the same thing as the two-step version shown previously:
ddply(cabbages,  c("Cult" , "Date" ),  summarise,
Weight = mean(HeadWt,  na.rm=TRUE),
sd = sd(HeadWt,  na.rm=TRUE),
n = sum(!is.na(HeadWt)),
se = sd / sqrtn) )
Confidence Intervals
Confidence intervals are calculated using the standard error of the mean and the degrees
of freedom. To calculate a confidence interval, use the qt() function to get the quantile,
then multiply that by the standard error. The qt() function will give quantiles of the t
distribution when given a probability level and degrees of freedom. For a 95% confidence
interval, use a probability level of .975; for the bell-shaped t-distribution, this will in
essence cut off 2.5% of the area under the curve at either end. The degrees of freedom
equal the sample size minus one.
This will calculate the multiplier for each group. There are six groups and each has the
same number of observations (10), so they will all have the same multiplier:
ciMult <-  qt(.975,  ca$n- 1)
ciMult
# 2.262157 2.262157 2.262157 2.262157 2.262157 2.262157
Now we can multiply that vector by the standard error to get the 95% confidence interval:

ca$ci <-  ca$se * ciMult
Cult Date Weight sd n se ci
c39 d16 3.18 0.9566144 10 0.30250803 0.6843207
c39 d20 2.80 0.2788867 10 0.08819171 0.1995035
c39 d21 2.74 0.9834181 10 0.31098410 0.7034949
c52 d16 2.26 0.4452215 10 0.14079141 0.3184923
c52 d20 3.11 0.7908505 10 0.25008887 0.5657403
c52 d21 1.47 0.2110819 10 0.06674995 0.1509989
We could have done this all in one line, like this:
ca$ci95 <-  ca$se * qt(.975,  ca$n)
For a 99% confidence interval, use .995.
Error bars that represent the standard error of the mean and confidence intervals serve
the same general purpose: to give the viewer an idea of how good the estimate of the
population mean is. The standard error is the standard deviation of the sampling dis‐
tribution. Confidence intervals are easier to interpret. Very roughly, a 95% confidence
interval means that there’s a 95% chance that the true population mean is within the
interval (actually, it doesn’t mean this at all, but this seemingly simple topic is way too
complicated to cover here; if you want to know more, read up on Bayesian statistics).
This function will perform all the steps of calculating the standard deviation, count,
standard error, and confidence intervals. It can also handle NAs and missing combina‐
tions, with the na.rm and .drop options. By default, it provides a 95% confidence in‐
terval, but this can be set with the conf.interval argument:
summarySE <- function(data=NULL,  measurevar,  groupvars=NULL,
conf.interval=.95,  na.rm=FALSE, . drop=TRUE) {
require(plyr)
# New version of length that can handle NAs: if na.rm==T, don't count them
length2 <- function (x,  na.rm=FALSE) {
if (na.rm) sum(!is.na(x))
else length(x)
}
# This does the summary
datac <-  ddply(data,  groupvars, . drop=. drop,
. fun = function(xx,  col,  na.rm) {
c( n = length2(xx[, col],  na.rm=na.rm),
mean = mean (xx[, col],  na.rm=na.rm),
sd = sd (xx[, col],  na.rm=na.rm)
)
},
measurevar,
na.rm
)

# Rename the "mean" column
datac <-  rename(datac,  c("mean" = measurevar))
datac$se <-  datac$sd / sqrt(datac$n) # Calculate standard error of the mean
# Confidence interval multiplier for standard error
# Calculate t-statistic for confidence interval:
# e.g., if conf.interval is .95, use .975 (above/below), and use
# df=n-1, or if n==0, use df=0
ciMult <-  qt(conf.interval/2 + .5,  datac$n- 1)
datac$ci <-  datac$se * ciMult
return(datac)
}
The following usage example has a 99% confidence interval and handles NAs and missing
combinations:
# Remove all rows with both c52 and d21
c2 <-  subset(cabbages,  ! ( Cult=="c52" & Date=="d21" ) )
# Set some values to NA
c2$HeadWt[c(1, 20, 45)] <- NA
summarySE(c2, "HeadWt" ,  c("Cult" , "Date" ),  conf.interval=.99,
na.rm=TRUE, . drop=FALSE)
Cult Date n HeadWt sd se ci
c39 d16 9 3.255556 0.9824855 0.32749517 1.0988731
c39 d20 9 2.722222 0.1394433 0.04648111 0.1559621
c39 d21 10 2.740000 0.9834181 0.31098410 1.0106472
c52 d16 10 2.260000 0.4452215 0.14079141 0.4575489
c52 d20 9 3.044444 0.8094923 0.26983077 0.9053867
c52 d21 0 NaN NA NA NA
Warning message:
In qt(p, df, lower.tail, log.p) : NaNs produced
It will give this warning message when there are missing combinations. This isn’t a
problem; it just indicates that it couldn’t calculate a quantile for a group with no obser‐
vations.
See Also
See Recipe 7.7 to use the values calculated here to add error bars to a graph.

15.19. Converting Data from Wide to Long
Problem
You want to convert a data frame from “wide” format to “long” format.
Solution
Use melt() from the reshape2 package. In the anthoming data set, for each angle, there
are two measurements: one column contains measurements in the experimental con‐
dition and the other contains measurements in the control condition:
library(gcookbook) # For the data set
anthoming
angle expt ctrl
-20 1 0
-10 7 3
0 2 3
10 0 3
20 0 1
We can reshape the data so that all the measurements are in one column. This will put
the values from expt and ctrl into one column, and put the names into a different
column:
library(reshape2)
melt(anthoming,  id.vars="angle" ,  variable.name="condition" ,  value.name="count" )
angle condition count
-20 expt 1
-10 expt 7
0 expt 2
10 expt 0
20 expt 0
-20 ctrl 0
-10 ctrl 3
0 ctrl 3
10 ctrl 3
20 ctrl 1
This data frame represents the same information as the original one, but it is structured
in a way that is more conducive to some analyses.
Discussion
In the source data, there are ID variables and measure variables. The ID variables are
those that specify which values go together. In the source data, the first row holds meas‐
urements for when angle is –20. In the output data frame, the two measurements, for
expt and ctrl, are no longer in the same row, but we can still tell that they belong
together because they have the same value of angle.
The measure variables are by default all the non-ID variables. The names of these vari‐
ables are put into a new column specified by variable.name, and the values are put into
a new column specified by value.name.
If you don’t want to use all the non-ID columns as measure variables, you can specify
measure.vars. For example, in the drunk data set, we can use just the 0-29 and 30-39
groups:
drunk
sex 0-29 30-39 40-49 50-59 60+
male 185 207 260 180 71
female 4 13 10 7 10
melt(drunk,  id.vars="sex" ,  measure.vars=c("0-29" , "30-39" ),
variable.name="age" ,  value.name="count" )
sex age count
male 0-29 185
female 0-29 4
male 30-39 207
female 30-39 13
It’s also possible to use more than one column as the ID variables:
plum_wide
length time dead alive
long at_once 84 156
long in_spring 156 84
short at_once 133 107
short in_spring 209 31
melt(plum_wide,  id.vars=c("length" , "time" ),  variable.name="survival" ,
value.name="count" )
length time survival count
long at_once dead 84
long in_spring dead 156
short at_once dead 133
short in_spring dead 209

long at_once alive 156
long in_spring alive 84
short at_once alive 107
short in_spring alive 31
Some data sets don’t come with a column with an ID variable. For example, in the
corneas data set, each row represents one pair of measurements, but there is no ID
variable. Without an ID variable, you won’t be able to tell how the values are meant to
be paired together. In these cases, you can add an ID variable before using melt():
# Make a copy of the data
co <-  corneas
co
affected notaffected
488 484
478 478
480 492
426 444
440 436
410 398
458 464
460 476
# Add an ID column
co$id <- 1:nrow(co)
melt(co,  id.vars="id" ,  variable.name="eye" ,  value.name="thickness" )
id eye thickness
1 affected 488
2 affected 478
3 affected 480
4 affected 426
5 affected 440
6 affected 410
7 affected 458
8 affected 460
1 notaffected 484
2 notaffected 478
3 notaffected 492
4 notaffected 444
5 notaffected 436
6 notaffected 398
7 notaffected 464
8 notaffected 476
Having numeric values for the ID variable may be problematic for subsequent analyses,
so you may want to convert id to a character vector with as.character(), or a factor
with factor().

See Also
See Recipe 15.20 to do conversions in the other direction, from long to wide.
See the stack() function for another way of converting from wide to long.
15.20. Converting Data from Long to Wide
Problem
You want to convert a data frame from “long” format to “wide” format.
Solution
Use the dcast() function from the reshape2 package. In this example, we’ll use the
plum data set, which is in a long format:
library(gcookbook) # For the data set
plum
length time survival count
long at_once dead 84
long in_spring dead 156
short at_once dead 133
short in_spring dead 209
long at_once alive 156
long in_spring alive 84
short at_once alive 107
short in_spring alive 31
The conversion to wide format takes each unique value in one column and uses those
values as headers for new columns, then uses another column for source values. For
example, we can “move” values in the survival column to the top and fill them with
values from count:
library(reshape2)
dcast(plum,  length + time ~ survival,  value.var="count" )
length time dead alive
long at_once 84 156
long in_spring 156 84
short at_once 133 107
short in_spring 209 31

Discussion
The dcast() function requires you to specify the ID variables (those that remain in
columns) and the variable variables (those that get “moved to the top”). This is done
with a formula where the ID variables are before the tilde (~) and the variable variables
are after it.
In the preceding example, there are two ID variables and one variable variable. In the
next one, there is one ID variable and two variable variables. When there is more than
one variable variable, the values are combined with an underscore:
dcast(plum,  time ~ length + survival,  value.var="count" )
time long_dead long_alive short_dead short_alive
at_once 84 156 133 107
in_spring 156 84 209 31
See Also
See Recipe 15.19 to do conversions in the other direction, from wide to long.
See the unstack() function for another way of converting from long to wide.
15.21. Converting a Time Series Object to Times
and Values
Problem
You have a time series object that you wish to convert to numeric vectors representing
the time and values at each time.
Solution
Use the time() function to get the time for each observation, then convert the times
and values to numeric vectors with as.numeric():
# Look at nhtemp Time Series object
nhtemp
Time Series:
Start = 1912
End = 1971
Frequency = 1
[1] 49.9 52.3 49.4 51.1 49.4 47.9 49.8 50.9 49.3 51.9 50.8 49.6 49.3 50.6 48.4
[16] 50.7 50.9 50.6 51.5 52.8 51.8 51.1 49.8 50.2 50.4 51.6 51.8 50.9 48.8 51.7
[31] 51.0 50.6 51.7 51.5 52.1 51.3 51.0 54.0 51.4 52.7 53.1 54.6 52.0 52.0 50.9
[46] 52.6 50.2 52.6 51.6 51.9 50.5 50.9 51.7 51.4 51.7 50.8 51.9 51.8 51.9 53.0

# Get times for each observation
as.numeric(time(nhtemp))
[1] 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926
[16] 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941
[31] 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956
[46] 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971
# Get value of each observation
as.numeric(nhtemp)
[1] 49.9 52.3 49.4 51.1 49.4 47.9 49.8 50.9 49.3 51.9 50.8 49.6 49.3 50.6 48.4
[16] 50.7 50.9 50.6 51.5 52.8 51.8 51.1 49.8 50.2 50.4 51.6 51.8 50.9 48.8 51.7
[31] 51.0 50.6 51.7 51.5 52.1 51.3 51.0 54.0 51.4 52.7 53.1 54.6 52.0 52.0 50.9
[46] 52.6 50.2 52.6 51.6 51.9 50.5 50.9 51.7 51.4 51.7 50.8 51.9 51.8 51.9 53.0
# Put them in a data frame
nht <-  data.frame(year=as.numeric(time(nhtemp)),  temp=as.numeric(nhtemp))
nht
year temp
1912 49.9
1913 52.3
...
1970 51.9
1971 53.0
Discussion
Time series objects efficiently store information when there are observations at regular
time intervals, but for use with ggplot2, they need to be converted to a format that
separately represents times and values for each observation.
Some time series objects are cyclical. The presidents data set, for example, contains
four observations per year, one for each quarter:
presidents
Qtr1 Qtr2 Qtr3 Qtr4
1945 NA 87 82 75
1946 63 50 43 32
1947 35 60 54 55
...
1972 49 61 NA NA
1973 68 44 40 27
1974 28 25 24 24
To convert it to a two-column data frame with one column representing the year with
fractional values, we can do the same as before:
pres_rating <-  data.frame(
year = as.numeric(time(presidents)),

rating = as.numeric(presidents)
)
pres_rating
year rating
1945.00 NA
1945.25 87
1945.50 82
...
1974.25 25
1974.50 24
1974.75 24
It is also possible to store the year and quarter in separate columns, which may be useful
in some visualizations:
pres_rating2 <-  data.frame(
year = as.numeric(floor(time(presidents))),
quarter = as.numeric(cycle(presidents)),
rating = as.numeric(presidents)
)
pres_rating2
year quarter rating
1945 1 NA
1945 2 87
1945 3 82
...
1974 2 25
1974 3 24
1974 4 24
See Also
The zoo package is also useful for working with time series objects.

using sum(!
is.na(...))



datac <-  rename(datac,  c("mean" = measurevar))

datac$se <-  datac$sd / sqrt(datac$n)



