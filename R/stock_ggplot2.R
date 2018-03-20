#GMMA
#function (x, short = c(3, 5, 8, 10, 12, 15), long = c(30, 35, 
#    40, 45, 50, 60), maType) 
#https://github.com/cosname/ggplot2-translation

library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)
require(data.table)
require(sqldf)


#
datafile<-"~/sdcard1/stock_data/done_601006.txt"
datafile<-"E:/stock_data/done_600519.txt"
df1<-read.table(datafile,header=TRUE,sep=",")
frm.datagen<-function(datastr){
	year=substr(datastr,0,4)
	month=substr(datastr,5,6)
	#cat(month)
	day=substr(datastr,7,8)
	#cat(day)
	paste(year,"-",month,"-",day)
	return(paste(year,"-",month,"-",day, sep = ""))
}
df1$date<-frm.datagen(df1$date)
olch=df1[2:6]
xtsobject=xts(olch, as.Date(df1$date))     #包xts
xtsobject<-cbind(xtsobject,close1=Lag(xtsobject$close))
colnames(xtsobject)[[6]]<-"close1"

head(is.na(xtsobject$close1))
xts_non_na<-xtsobject[!is.na(xtsobject$close1)]
func_up_down <- function(x, c1, c2) {
  if (x[c1]>x[c2]) return("UP")
  if (x[c1]<x[c2]) return("DOWN")
  if (x[c1]==x[c2]) return("EQUAL")
}

typepoint<-apply(xts_non_na,1,func_up_down,c1="close",c2="close1")
dftypepoint<-as.data.frame(unlist(typepoint))
dftypepoint<-cbind(BS_POINT=dftypepoint,Date=as.Date(row.names(dftypepoint)))

valuedf<-as.data.frame(xts_non_na)
valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
BS_table<-merge(valuedf,dftypepoint)
BS_table["avgprice"]<-apply(BS_table[2:5],1,mean)
colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type")
=============================

qplot(Date,close,data=BS_table,colour=factor(type))

qplot(close,vol,data=BS_table,colour=factor(type))
qplot(close,data=BS_table,geom="histogram")
qplot(close,data=BS_table,geom="density")

qplot(close,data=BS_table,geom="density",colour=type)
qplot(close,data=BS_table,geom="density",fill=type)
qplot(close,data=BS_table,geom="histogram",fill=type)

qplot(close,data=BS_table,geom="bar")
qplot(close,data=BS_table,geom="bar",colour=type)
qplot(close,data=BS_table,geom="bar",,weight=vol,colour=type)+scale_y_continuous("vol")

qplot(close,vol,data=BS_table,geom="line")
qplot(close,vol,data=BS_table,geom=c("point","path"))
qplot(close,vol,data=BS_table,geom=c("point","path"),colour=type)

qplot(close,data=BS_table,facets=type ~ ., geom="histogram",binwidth=0.1)

qplot(close,..density..,data=BS_table,facets=type ~ ., geom="histogram",binwidth=0.1)
qplot(close,..density..,data=BS_table,facets=type ~ ., geom="density")

qplot(type,close,data=BS_table, geom="boxplot")
map variables to aesthetics
facert datasets
Transform scales
compute aesthetics
train scales
map scales
render geoms

p<-qplot(close,..density..,data=BS_table,facets=type ~ ., geom="density")
current_price<-tail(BS_table$close,1)
p<-p+geom_vline(aes(xintercept = current_price,colour = "red",size = 2),BS_table)
p



# geom calls are just a short cut for layer
ggplot(mpg, aes(displ, hwy)) + geom_point()
# shortcut for
ggplot(mpg, aes(displ, hwy)) +
  layer(geom = "point", stat = "identity", position = "identity",
    params = list(na.rm = FALSE)
  )


summary(p)
save(p,file="~/sdcard1/plot.rdata")
ggsave("~/sdcard1/plogt.png",width=5,height=5)

p<-ggplot(data=BS_table,aes(close,colour=type))+geom_density()

p<-ggplot(data=BS_table,aes(close,colour=type))+
layer(
geom="bar",
geom_params=list(fill="steelblue"),
stat="bin",
stat_params=list(binwidth=2)
)

p<-ggplot(data=BS_table,aes(close,colour=type))+
geom_histogram(binwidth=2,fill="steelblue")


page64

p<-ggplot(data=BS_table)
p<-p+aes(close,colour=type)
p<-p+geom_histogram(binwidth=2,fill="steelblue")


p<-ggplot(data=BS_table)
p+aes(Date,close,group=type)
p+geom_line()

p<-ggplot(data=BS_table,aes(Date,close,group=type,color=type))
p+geom_line()
df_noEqual<-sqldf("select * from BS_table where type != 'EQUAL'")

close_box<-ggplot(data=BS_table,aes(type,close,color=type))
close_box+geom_boxplot()
#close_box+geom_line(aes(group=type),color="#3366ff")
close_box 


p<-ggplot(data=BS_table)
p<-p+aes(close,colour=type)
p<-p+geom_histogram(aes(y = ..density..),binwidth=0.1,fill="steelblue")

p
p<-ggplot(data=BS_table)
p<-p+aes(close,colour=type)
p+stat_bin(aes(ymax = ..count.. ),binwidth=0.1,geom ="area")
p+stat_bin(aes(size = ..density.. ),binwidth=0.1,geom ="point",position = "identity")
p+stat_bin(aes(y=1,fill = ..count..),binwidth=0.1,geom ="tile",position = "identity")
p+stat_bin(aes(size = ..density.. ),binwidth=0.1,geom ="point",position = "dodge")
p+stat_bin(aes(ymax = 1,size = ..density.. ),binwidth=0.1,geom ="point",position = "fill")
p+geom_bar(position="stack")
p+geom_bar(position="dodge")
p+geom_bar(position="fill")
p+geom_bar(position="stack")+labs(title="title xxx")
p+geom_text(aes(label=label))+labs(title="geom_text")


p+geom_bar(position="stack")+facet_grid(type ~ .)
p+geom_freqpoly(aes(y= ..density..),binwidth=0.1)+facet_grid(type ~ .)
########################

p<-ggplot(data=BS_table,aes(close,vol))
#p+aes(x=close,y=vol)+theme(legend.position="none")
p+geom_point()
p+stat_binhex()
p+stat_bin2d(binwidth=c(0.01,30))
p+geom_point()+geom_density2d()
p+stat_density2d(geom="point",aes(size=..density..),contour=F)+scale_size_area()
#########################
p<-ggplot(data=BS_table,aes(Date,avgprice))
p+geom_crossbar(aes(ymin = low, ymax = high), width = 0.2)

p<-ggplot(data=BS_table[1:10,],aes(Date,avgprice))
p+geom_crossbar(aes(ymin = low, ymax = high), width = 0.2)+scale_color_gradient()
  geom_density2d()
  
#####################
# using geom_rect  get area about close price scope
library(scales)
range(BS_table$Date)
p<-ggplot(data=BS_table,aes(Date,avgprice))
p+geom_line()
close_min=range(BS_table$close)[1]
close_max=range(BS_table$close)[2]
date_1<-BS_table$Date[BS_table$close==close_max]
date_2<-BS_table$Date[BS_table$close==close_min]
#p+geom_line()+geom_rect(aes(NULL,NULL,xmin = date_2, xmax = date_1, ymin = close_min, ymax = close_max),alpha=0.2,data=BS_table)
#geom rect 
p1<-p+geom_rect(aes(NULL,NULL,xmin = date_2, xmax = date_1, ymin = close_min, ymax = close_max,fill="green"),colour = I("red"),alpha=I(0.2),data=BS_table)+geom_line()
p1+annotate("text", label = "high point", x = date_1, y = close_max, size = 8, colour = "red")
p1+geom_text(angle = 45)+annotate("text", label = "low point", x = date_2, y = close_min, size = 2, colour = "green")


p+geom_rect(aes(NULL,NULL,xmin = date_2, xmax = date_1, ymin = close_min, ymax = close_max),alpha=0.2,data=BS_table)+scale_fill_manual(values = c("blue"))+geom_line()


#权重概念
p<-ggplot(data=BS_table,aes(Date,avgprice))
p+geom_point(size=vol)+scale_size_area()
qplot(Date,avgprice,data=BS_table,size=vol,color=type)+scale_size_area()

位置标度
颜色标度
手动离散型
同一标度
########
plot<-qplot(cty,hwy,data=mpg)
plot+aes(x=drv)+scale_x_discrete()
plot+aes(x=drv)+scale_x_continuous()


p<-qplot(sleep_total,sleep_cycle,data=msleep,colour = vore)
p+ scale_colour_hue()
p+ scale_colour_hue("What does\nit eat?",
    breaks=c("herbi","carni","omni",NA),
    labels =c("plants","meat","both","don't know")
    )
p+scale_colour_brewer(palette = "Set1")

had.co.nz/ggplot2

p<-qplot(cty,hwy,data=mpg,colour=displ)
p+scale_x_continuous("City mpg")
p+xlab("City mpg")
p+ylab("Highway mpg")
p+labs(x="City mpg",y="Highway",colour="Displacement")
p+xlab(expression(frac(miles,gallon)))

p<-qplot(cyl,wt,data=mtcars)
p+scale_x_continuous(breaks=c(5.5,6.5))
p+scale_x_continuous(limits=c(5.5,6.5))

p<-qplot(wt,cyl,data=mtcars,colour=cyl)
p+scale_color_gradient(breaks=c(5.5,6.5))
p+scale_color_gradient(limits=c(5.5,6.5))
xlim("a","b","c")
xlim(as.Date(c("2008-05-01","2008-08-01")))


qplot(log10(carat), log10(price), data = diamonds)
qplot(carat, price, data = diamonds) +
scale_x_log10() + scale_y_log10()


qplot(close,vol,data=BS_table,size=vol,color=type)+scale_size_area()+scale_y_log10()#改變y坐標的刻度單位

qplot(close,vol,data=BS_table,size=vol,color=type)+scale_size_area()+scale_y_continuous(trans = "log10")

scale_x_log10() #
scale_x_continuous(trans = "log10")

日期表示格式
plot <- qplot(Date, close, data = BS_table, geom = "line") +
ylab("Price Close") 
plot + scale_x_date(date_labels = "%b %d")
plot + scale_x_date(date_breaks = "1 week", date_labels = "%W")
plot + scale_x_date(date_minor_breaks = "1 day")
plot + scale_x_date(date_breaks = "6 months", date_labels = "%m")

geom_hline(xintercept = 0, colour = "grey50")
plot
plot + scale_x_date(major = "10 years")
plot + scale_x_date(
limits = as.Date(c("2004-01-01", "2005-01-01")),
format = "%Y-%m-%d"
)

Co de Meaning
%S second (00-59)
%M minute (00-59)
%l hour, in 12-hour clock (1-12)
%I hour, in 12-hour clock (01-12)
%H hour, in 24-hour clock (00-23)
%a day of the week, abbreviated (Mon-Sun)
%A day of the week, full (Monday-Sunday)
%e day of the month (1-31)
%d day of the month (01-31)
%m month, numeric (01-12)
%b month, abbreviated (Jan-Dec)
%B month, full (January-December)
%y year, without century (00-99)
%Y year, with century (0000-9999)

plot <- qplot(date, psavert, data = economics, geom = "line") +
ylab("Personal savings rate") +
geom_hline(xintercept = 0, colour = "grey50")
plot
plot + scale_x_date(major = "10 years")
plot + scale_x_date(
limits = as.Date(c("2004-01-01", "2005-01-01")),
format = "%Y-%m-%d"
)
###########
important function
###########
COLOUR scale_

plot<-ggplot(BS_table, aes(Date, close)) +
  geom_point(aes(colour = vol))
  
plot+scale_colour_gradient2()
plot+scale_colour_gradientn(colours = terrain.colors(10))

plot+scale_colour_gradient2(low = "white", mid ="grey",high = "black",midpoint = mean(BS_table$vol))

fill_gradn <- function(pal) {
  scale_fill_gradientn(colours = pal(7), limits = c(0, 0.04))
}
require(colorspace)
plot + fill_gradn(rainbow_hcl)
plot + fill_gradn(diverge_hcl)
plot + fill_gradn(heat_hcl)
plot + fill_gradn(sequential_hcl)
plot + fill_gradn(terrain_hcl)
plot + fill_gradn(sequential_hcl)

plot + fill_gradn(sequential_hcl)

plot +scale_fill_brewer()

lineplot<-ggplot(BS_table, aes(Date, close)) +
  geom_line(aes(colour = vol))
lineplot +scale_fill_brewer()




>===============================================
library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)
require(data.table)
require(sqldf)


#
datafile<-"~/sdcard1/stock_data/done_601006.txt"
datafile<-"E:/stock_data/done_601006.txt"
df1<-read.table(datafile,header=TRUE,sep=",")
frm.datagen<-function(datastr){
	year=substr(datastr,0,4)
	month=substr(datastr,5,6)
	#cat(month)
	day=substr(datastr,7,8)
	#cat(day)
	paste(year,"-",month,"-",day)
	return(paste(year,"-",month,"-",day, sep = ""))
}
df1$date<-frm.datagen(df1$date)
olch=df1[2:6]
xtsobject=xts(olch, as.Date(df1$date))     #包xts
xtsobject<-cbind(xtsobject,close1=Lag(xtsobject$close))
colnames(xtsobject)[[6]]<-"close1"

head(is.na(xtsobject$close1))
xts_non_na<-xtsobject[!is.na(xtsobject$close1)]
func_up_down <- function(x, c1, c2) {
  if (x[c1]>x[c2]) return("UP")
  if (x[c1]<x[c2]) return("DOWN")
  if (x[c1]==x[c2]) return("EQUAL")
}

typepoint<-apply(xts_non_na,1,func_up_down,c1="close",c2="close1")
dftypepoint<-as.data.frame(unlist(typepoint))
dftypepoint<-cbind(BS_POINT=dftypepoint,Date=as.Date(row.names(dftypepoint)))

valuedf<-as.data.frame(xts_non_na)
valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
BS_table<-merge(valuedf,dftypepoint)
BS_table["avgprice"]<-apply(BS_table[2:5],1,mean)
colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type")

############
p <- ggplot(BS_table, aes(x = close, fill = type)) +
  geom_histogram(position = "dodge", bins  = 50)
p + scale_fill_brewer()
# the order of colour can be reversed
p + 
scale_fill_brewer(direction = -1,palette = "Set2")+
scale_x_continuous(breaks = c(2,4,6,8,10))+
facet_grid(type ~ .)


p + 
scale_fill_brewer(direction = -1,palette = "Pastel1")+
scale_x_continuous(breaks = c(2,4,6,8,10))+
facet_grid(type ~ .)


colours <- c(DOWN = "red", UP = "green", EQUAL = "yellow")
point_plot<-ggplot(BS_table, aes(Date, close)) 
point_plot+ 
  aes(size=vol)+
  geom_point(aes(colour = type))+
  scale_colour_manual(values = colours)
  ##############################
  facet_grid
  facet_wrap
  
  mpg2 <- subset(mpg, cyl ! = 5 & drv %in% c("4", "f"))
  qplot(cty, hwy, data = mpg2) + facet_grid(. ~ .)
  
  qplot(cty, hwy, data = mpg2) + facet_grid(. ~ cyl)
  
unique(msleep$vore)
?scale_x_continuous
=============================================
p <- qplot(displ, hwy, data = mpg2) +
geom_smooth(method = "lm", se = F)
p + facet_grid(cyl ~ drv)
p + facet_grid(cyl ~ drv, margins = T)


movies$decade <- round_any(movies$year, 10, floor)
qplot(rating, ..density.., data=subset(movies, decade > 1890),
geom="histogram", binwidth = 0.5) +
facet_wrap(~ decade, ncol = 6)


ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class)

# Control the number of rows and columns with nrow and ncol
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class, nrow = 4)


# You can facet by multiple variables
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~ cyl + drv)
# Or use a character vector:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(c("cyl", "drv"))

# Use the `labeller` option to control how labels are printed:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(c("cyl", "drv"), labeller = "label_both")

# To change the order in which the panels appear, change the levels
# of the underlying factor.
mpg$class2 <- reorder(mpg$class, mpg$displ)
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class2)

# By default, the same scales are used for all panels. You can allow
# scales to vary across the panels with the `scales` argument.
# Free scales make it easier to see patterns within each panel, but
# harder to compare across panels.
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class, scales = "free")

# To repeat the same data in every panel, simply construct a data frame
# that does not contain the facetting variable.
ggplot(mpg, aes(displ, hwy)) +
  geom_point(data = transform(mpg, class = NULL), colour = "grey85") +
  geom_point() +
  facet_wrap(~class)

# Use `switch` to display the facet labels near an axis, acting as
# a subtitle for this axis. This is typically used with free scales
# and a theme without boxes around strip labels.
ggplot(economics_long, aes(date, value)) +
  geom_line() +
  facet_wrap(~variable, scales = "free_y", nrow = 2, switch = "x") +
  theme(strip.background = element_blank())
  
em <- melt(economics, id = "date")
qplot(date, value, data = em, geom = "line", group = variable) +
facet_grid(variable ~ ., scale = "free_y")



mpg3 <- within(mpg2, {
model <- reorder(model, cty)
manufacturer <- reorder(manufacturer, -cty)
})
models <- qplot(cty, model, data = mpg3)
models
models + facet_grid(manufacturer ~ ., scales = "free",
space = "free") + opts(strip.text.y = theme_text())

>>>>>>>>>>>>>>>>>>
qplot(color, data=diamonds, geom = "bar", fill = cut,
position="dodge")
qplot(cut, data = diamonds, geom = "bar", fill = cut) +
facet_grid(. ~ color) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8,
colour = "grey50"))

table(cut_interval(1:100, 10))
table(cut_interval(1:100, 11))

table(cut_number(runif(1000), 10))

table(cut_width(runif(1000), 0.1))
table(cut_width(runif(1000), 0.1, boundary = 0))
table(cut_width(runif(1000), 0.1, center = 0))



# NOTE: Use these plots with caution - polar coordinates has
# major perceptual problems.  The main point of these examples is
# to demonstrate how these common plots can be described in the
# grammar.  Use with EXTREME caution.

#' # A pie chart = stacked bar chart + polar coordinates
pie <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
 geom_bar(width = 1)
pie + coord_polar(theta = "y")


(p <- qplot(disp, wt, data=mtcars) + geom_smooth())
p + scale_x_continuous(limits = c(325, 500))
p + coord_cartesian(xlim = c(325, 500))
(d <- ggplot(diamonds, aes(carat, price)) +
stat_bin2d(bins = 25, colour="grey70") +
opts(legend.position = "none"))
d + scale_x_continuous(limits = c(0, 2))
d + coord_cartesian(xlim = c(0, 2))


(d <- ggplot(diamonds, aes(carat, price)) +
stat_bin2d(bins = 25, colour="grey70") +
opts(legend.position = "none"))
d + scale_x_continuous(limits = c(0, 2))
d + coord_cartesian(xlim = c(0, 2))

qplot(displ, cty, data = mpg) + geom_smooth()
qplot(cty, displ, data = mpg) + geom_smooth()
qplot(cty, displ, data = mpg) + geom_smooth() + coord_flip()


# Stacked barchart
(pie <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
geom_bar(width = 1))
# Pie chart
pie + coord_polar(theta = "y")
# The bullseye chart
pie + coord_polar()

hgram <- qplot(rating, data = movies, binwidth = 1)


hgram <- qplot(close, data = BS_table, binwidth = 1)




hgram <- qplot(close, data = BS_table, binwidth = 1)
> hgram
> previous_theme <- theme_set(theme_bw())
> hgram
> hgram + previous_theme
hgram + labs(title= "This is a histogram")
hgram + theme(plot.title= element_text(size = 20))
hgram + theme(plot.title= element_text(size = 20,colour="red"))


hgram + theme(axis.line=element_line(colour = "red"))
hgram + theme(panel.grid.major = element_line(colour ="blue"),axis.line=element_line(colour = "red"))


hgram + theme(plot.background=element_rect(colour ="red"))

hgram + theme(plot.background=element_rect(fill ="green",colour=NA))


old_theme<-theme_update(
  plot.background = element_rect(fill = "#3366FF"),
  panel.background = element_rect(fill = "#003DF5"),
  axis.text.x = element_text(colour = "#CCFF33"),
  axis.text.y = element_text(colour = "#CCFF33",hjust = 1),
  axis.title.x = element_text(colour = "#CCFF33",face = "bold"),
  axis.title.y = element_text(colour = "#CCFF33",face = "bold"),

)

p <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point()
p
old <- theme_set(theme_bw())
p
theme_set(old)
p

old <- theme_update(panel.background = element_rect(colour = "pink"))
p
theme_set(old)
theme_get()

ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(color = mpg)) +
  theme(legend.position = c(0.95, 0.95),
        legend.justification = c(1, 1))
last_plot() +
 theme(legend.background = element_rect(fill = "white", colour = "white", size = 3))



qplot(cut,data = diamonds,geom = "bar")
theme_set(old_theme)

=======================
Theme element Ty p e Description
axis.line segment line along axis
axis.text.x text x axis label
axis.text.y text y axis label
axis.ticks segment axis tick marks
axis.title.x text horizontal tick labels
axis.title.y text vertical tick labels
legend.background rect background of legend
legend.key rect background underneath legend keys
legend.text text legend labels
legend.title text legend name
panel.background rect background of panel
panel.border rect border around panel
panel.grid.major line major grid lines
panel.grid.minor line minor grid lines
plot.background rect background of the entire plot
plot.title text plot title
strip.background rect background of facet labels
strip.text.x text text for horizontal strips
strip.text.y text text for vertical strips

# A coxcomb plot = bar chart + polar coordinates
cxc <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = 1, colour = "black")
cxc + coord_polar()
# A new type of plot?
cxc + coord_polar(theta = "y")

# The bullseye chart
pie + coord_polar()

# Hadley's favourite pie chart
df <- data.frame(
  variable = c("does not resemble", "resembles"),
  value = c(20, 80)
)
ggplot(df, aes(x = "", y = value, fill = variable)) +
  geom_bar(width = 1, stat = "identity") +
  scale_fill_manual(values = c("red", "yellow")) +
  coord_polar("y", start = pi / 3) +
  labs(title = "Pac man")

# Windrose + doughnut plot
if (require("ggplot2movies")) {
movies$rrating <- cut_interval(movies$rating, length = 1)
movies$budgetq <- cut_number(movies$budget, 4)

doh <- ggplot(movies, aes(x = rrating, fill = budgetq))

# Wind rose
doh + geom_bar(width = 1) + coord_polar()
# Race track plot
doh + geom_bar(width = 0.9, position = "fill") + coord_polar(theta = "y")
}




>>>>>>>>>>>>>>>>>>
ggplot(luv_colours, aes(u, v)) +
  geom_point(aes(colour = col), size = 3) +
  scale_color_identity() +
  coord_equal()

df <- data.frame(
  x = 1:4,
  y = 1:4,
  colour = c("red", "green", "blue", "yellow")
)
ggplot(df, aes(x, y)) + geom_tile(aes(fill = colour))
ggplot(df, aes(x, y)) +
  geom_tile(aes(fill = colour)) +
  scale_fill_identity()

# To get a legend guide, specify guide = "legend"
ggplot(df, aes(x, y)) +
  geom_tile(aes(fill = colour)) +
  scale_fill_identity(guide = "legend")
# But you'll typically also need to supply breaks and labels:
ggplot(df, aes(x, y)) +
  geom_tile(aes(fill = colour)) +
  scale_fill_identity("trt", labels = letters[1:4], breaks = df$colour,
  guide = "legend")

# cyl scaled to appropriate size
ggplot(mtcars, aes(mpg, wt)) + geom_point(aes(size = cyl))

# cyl used as point size
ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(size = cyl)) +
  scale_size_identity()



ggplot(huron, aes(year)) +
geom_line(aes(y = level - 5, colour = "below")) +
geom_line(aes(y = level + 5, colour = "above")) +
scale_colour_manual("Direction",
c("below" = "blue", "above" = "red"))


huron <- data.frame(year = 1875:1972, level = LakeHuron)
ggplot(huron, aes(year)) +
geom_line(aes(y = level - 5), colour = "blue") +
geom_line(aes(y = level + 5), colour = "red")


dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
(d <- ggplot(dsamp, aes(carat, price)) +
  geom_point(aes(colour = clarity)))

# Change scale label
d + scale_colour_brewer()
d + scale_colour_brewer("Diamond\nclarity")

# Select brewer palette to use, see ?scales::brewer_pal for more details
d + scale_colour_brewer(palette = "Greens")
d + scale_colour_brewer(palette = "Set1")


# scale_fill_brewer works just the same as
# scale_colour_brewer but for fill colours
p <- ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(position = "dodge", binwidth = 1000)
p + scale_fill_brewer()
# the order of colour can be reversed
p + scale_fill_brewer(direction = -1)
# the brewer scales look better on a darker background
p + scale_fill_brewer(direction = -1) + theme_dark()


# Use distiller variant with continous data
v <- ggplot(faithfuld) +
  geom_tile(aes(waiting, eruptions, fill = density))
v
v + scale_fill_distiller()
v + scale_fill_distiller(palette = "Spectral")

df <- data.frame(
  x = runif(100),
  y = runif(100),
  z1 = rnorm(100),
  z2 = abs(rnorm(100))
)

# Default colour scale colours from light blue to dark blue
ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z2))

# For diverging colour scales use gradient2
ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z1)) +
  scale_colour_gradient2()

plot<-ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z1))

plot+ scale_colour_gradientn(colours = terrain.colors(10))


update_geom_defaults("point", aes(colour = "darkblue"))
qplot(mpg, wt, data=mtcars)
update_stat_defaults("bin", aes(y = ..density..))
qplot(rating, data = movies, geom = "histogram", binwidth = 1)


qplot(mpg, wt, data = mtcars)
ggsave(file = "e:/output.pdf")
pdf(file = "e:/output.pdf", width = 6, height = 6)
# If inside a script, you will need to explicitly print() plots
qplot(mpg, wt, data = mtcars)
qplot(wt, mpg, data = mtcars)
dev.off()


ggsave(filename, plot = last_plot(), device = NULL, path = NULL,
  scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
  dpi = 300, limitsize = TRUE, ...)


########################
qplot(log10(carat), log10(price), data = diamonds)
qplot(carat, price, data = diamonds) +
scale_x_log10() + scale_y_log10()


Name Function f( x) Inverse f − 1(y)
asn tanh − 1(x) tanh(y)
exp ex log(y)
identity x y
log log(x) ey
log10 log 10(x) 10y
log2 log 2(x) 2y
logit log( 1 −x x ) 1+e1(y)
pow10 10x log10(y)
probit Φ(x) Φ− 1(y)
recip x− 1 y− 1
reverse −x −y
sqrt x1/2 y2
Table 6.2: List of built-in transformers

###########################
library(ggplot2)ls("package:ggplot2",pattern="^geom_.+")


stat_summary
df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  upper = c(1.1, 5.3, 3.3, 4.2),
  lower = c(0.8, 4.6, 2.4, 3.6)
)

p <- ggplot(df, aes(trt, resp, colour = group))
p + geom_linerange(aes(ymin = lower, ymax = upper))
p + geom_pointrange(aes(ymin = lower, ymax = upper))
p + geom_crossbar(aes(ymin = lower, ymax = upper), width = 0.2)
p + geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2)



https://www.sogou.com/sgo?query=%E4%B9%8C%E9%B8%A6%E6%95%91%E8%B5%8E%E4%B9%9D%E8%BF%9E%E6%8B%9B&ie=utf8&_ast=1467964032&_asf=null&w=01029901&hdq=sogou-clse-7221e5c8ec6b08ef-0099&duppid=1&cid=&lxea=2-1-1-8.0.0.8004-3-CN3100-0-1-3&sut=1949&sst0=1467963984882&lkt=0%2C0%2C0
toad for oracle

name description
abline line, sp ecified by s lop e and i nt ercept
area area plots
b a r b a r s , r e c t a n g l e s w i t h b a s e s o n y - a x i s
blank b lank, draws nothing
b ox p l o t b ox- a n d - w h i s ker pl o t
cont our d isplay contours of a 3 d surface in 2d
crossbar hollow bar with m iddle i ndicated by horizontal l ine
density d isplay a smo oth density estimate
density 2d contours from a 2d density estimate
errorbar error bars
histogram histogram
hline line, horizontal
interval base for all interval (range) geoms
jitter points, jittered to reduce overplotting
line connect observations, in order of x value
linerange an interval represented by a vertical line
path connect observations, in original order
point points, as for a scatterplot
pointrange an interval represented by a vertical line, with a point
in the middle
polygon polygon, a filled path
quantile add quantile lines from a quantile regression
ribbon ribbons, y range with continuous x values
rug marginal rug plots
segment single line segments
smooth add a smoothed condition mean
step connect observations by stairs
text textual annotations
tile tile plot as densely as possible, assuming that every
tile is the same size
vline line, vertical
########################

DT <- data.table(a=rep(1:3, each=2), b=1:6)

DT2 <- transform(DT, c = a^2)
DT[, c:=a^2]
identical(DT,DT2)

DT2 <- within(DT, {
  b <- rev(b)
  c <- a*2
  rm(a)
})
DT[,`:=`(b = rev(b),
         c = a*2,
         a = NULL)]
identical(DT,DT2)

DT$d = ave(DT$b, DT$c, FUN=max)               # copies entire DT, even if it is 10GB in RAM
DT = DT[, transform(.SD, d=max(b)), by="c"]   # same, but even worse as .SD is copied for each group
DT[, d:=max(b), by="c"]                       # same result, but much faster, shorter and scales

# Multiple update by group. Convenient, fast, scales and easy to read.
DT[, `:=`(minb = min(b),
          meanb = mean(b),
          bplusd = sum(b+d)),  by=c%/%5]
DT
