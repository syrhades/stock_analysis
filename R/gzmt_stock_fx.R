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


###################################
# repair data
#####################################
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
#df2<-transform(df1,test=frm.datagen(df1))


df1<-mutate(df1,date=frm.datagen(date))


#df1$date<-frm.datagen(df1$date)
olch=df1[2:6]
xtsobject=xts(olch, as.Date(df1$date))     #°üxts
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

#colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type")
#BS_table<-mutate(df1,avgprice=mean(high,open,low,close))

BS_table["avgprice"]<-apply(BS_table[2:5],1,mean)
colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type","avgprice")


par(mfrow = c(1, 1))
test3d<-BS_table[100:200,2:3]
hist3D(z = as.matrix(test3d), scale = FALSE, expand = 0.01, border = "black")


#########################################################
# daply
#########################################################
daply(baseball, .(year), nrow)
# Several different ways of summarising by variables that should not be
# included in the summary

daply(baseball[, c(2, 6:9)], .(year), colwise(mean))
daply(baseball[, 6:9], .(baseball$year), colwise(mean))
daply(baseball, .(year), function(df) colwise(mean)(df[, 6:9]))


Split data frame, apply function, and return results in a data frame.

Description

For each subset of a data frame, apply function then combine results into a data frame. To apply a function for each row, use adply with .margins set to 1. 

Usage
ddply(.data, .variables, .fun = NULL, ..., .progress = "none",
  .inform = FALSE, .drop = TRUE, .parallel = FALSE, .paropts = NULL)

diff(1:10, 2)
diff(1:10, 2, 2)
x <- cumsum(cumsum(1:10))
diff(x, lag = 2)
diff(x, differences = 2)

diff(.leap.seconds)


#################################
#test pylr function
##################################
count(BS_table, vars = "type")
# No progress bar
l_ply(1:100, identity, .progress = "none")
## Not run: 
# Use the Tcl/Tk interface
l_ply(1:100, identity, .progress = "tk")

## End(Not run)
# Text-based progress (|======|)
l_ply(1:100, identity, .progress = "text")
# Choose a progress character, run a length of time you can see
l_ply(1:10000, identity, .progress = progress_text(char = "."))



Examples
# Summarize a dataset by two variables
dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)

# Note the use of the '.' function to allow
# group and sex to be used without quoting
ddply(dfx, .(group, sex), summarize,
 mean = round(mean(age), 2),
 sd = round(sd(age), 2))

# An example using a formula for .variables

ddply(baseball[1:100,], ~ year, nrow)

ddply(BS_table, ~ type, nrow)

ddply(BS_table, .(type), c("nrow", "ncol"))


# Applying two functions; nrow and ncol
ddply(baseball, .(lg), c("nrow", "ncol"))

# Calculate mean runs batted in for each year
rbi <- ddply(baseball, .(year), summarise,
  mean_rbi = mean(rbi, na.rm = TRUE))
# Plot a line chart of the result
plot(mean_rbi ~ year, type = "l", data = rbi)

# make new variable career_year based on the
# start year for each player (id)
base2 <- ddply(baseball, .(id), mutate,
 career_year = year - min(year) + 1
)

##################
linmod <- function(df) {
  lm(rbi ~ year, data = mutate(df, year = year - min(year)))
}
models <- dlply(baseball, .(id), linmod)
models[[1]]

coef <- ldply(models, coef)
with(coef, plot(`(Intercept)`, year))
qual <- laply(models, function(mod) summary(mod)$r.squared)
hist(qual)




#################################
#draw function
##################################
main<-function(){
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
}
###################################
# save file 
#####################################


ggsave(file = "e:/output.pdf",dpi = 300)
pdf(file = "e:/output.pdf", width = 6, height = 6)
# If inside a script, you will need to explicitly print() plots
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
}
qplot(wt, mpg, data = mtcars)

dev.off()


ggsave(file = "e:/output2.pdf",dpi = 300)
pdf(file = "e:/output2.pdf", width = 6, height = 6)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2,2)))
vplayout <- function(x,y)
  viewport(layout.pos.row = x, layout.pos.col =y)
print(a,vp=vplayout(1,1:2))
print(b,vp=vplayout(2,1))
print(c,vp=vplayout(2,2))
dev.off()

###############################
ddply(diamonds,.(color),subset,carat ==min(carat))
ddply(diamonds,.(color),subset,carat ==order(carat)<=2)
ddply(diamonds,.(color),subset,carat quantile(carat,0.99))

ddply(diamonds,.(color),transform,price = scale(price))
ddply(diamonds,.(color),transform,price = price - mean(price))


colwise
If you want t o ap p ly a f u n ct ion t o e ver y colu m n in t h e d at a f r am e, you
m i g ht fin d t h e colwise() function handy. This function converts a function
that op erates on ve ctors t o a f unction t hat op e rates column-wise on data
frame s. 


nmissing <- function(x) sum(is.na(x))
nmissing(msleep$name)

nmissing(msleep$brainwt)

nmissing_df <- colwise(nmissing)
nmissing_df(msleep)

colwise(nmissing)(msleep)

ddply(msleep2,.(vore),numcolwise(median),na.rm=T)

ddply(BS_table,.(type),numcolwise(median),na.rm=T)

require(reshape2)
melt_bs_table<- melt(BS_table,id="Date",measure = c("close","high"))
gline<-ggplot(melt_bs_table, aes(Date, value)£¬colour=variable) 
gline+geom_line()

qplot(Date,value,data=melt_bs_table,geom="line",colour=variable)


#######################
# Count number of missing values
nmissing <- function(x) sum(is.na(x))

# Apply to every column in a data frame
colwise(nmissing)(baseball)
# This syntax looks a little different.  It is shorthand for the
# the following:
f <- colwise(nmissing)
f(baseball)

# This is particularly useful in conjunction with d*ply
ddply(baseball, .(year), colwise(nmissing))

# To operate only on specified columns, supply them as the second
# argument.  Many different forms are accepted.
ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))

# Alternatively, you can specify a boolean function that determines
# whether or not a column should be included
ddply(baseball, .(year), colwise(nmissing, is.character))
ddply(baseball, .(year), colwise(nmissing, is.numeric))
ddply(baseball, .(year), colwise(nmissing, is.discrete))

# These last two cases are particularly common, so some shortcuts are
# provided:
ddply(baseball, .(year), numcolwise(nmissing))
ddply(baseball, .(year), catcolwise(nmissing))

# You can supply additional arguments to either colwise, or the function
# it generates:
numcolwise(mean)(baseball, na.rm = TRUE)
numcolwise(mean, na.rm = TRUE)(baseball)

#######################
BS_table1<-ddply(BS_table,.(type),subset,close quantile(close,0.99))
subset(airquality, Temp 80 & Temp <90, select = c(Ozone, Temp))
subset(airquality, Temp 80 |Temp <70, select = c(Ozone, Temp))




BS_table1<-ddply(BS_table,.(type),subset,close quantile(close,0.99) | close < quantile(close,0.1))

BS_table1<-ddply(BS_table,.(type),subset,close < mean(close) |close quantile(close,0.99))

plot<-ggplot(BS_table1, aes(Date, close)) +
    geom_point(aes(colour = vol))
    plot
  plot+scale_colour_gradient2()

####################################
had.co.nz/plyr

www.jstatsoft.org/v21/i12/




qplot(x, y,data = diamonds, na.rm = TRUE)
last_plot()+ xlim(3, 11) + ylim(3, 11)
last_plot()+ xlim(4, 10) + ylim(4, 10)
last_plot()+ xlim(4, 5) + ylim(4, 5)
last_plot()+ xlim(4, 4.5) + ylim(4, 4.5)




gradient_rb <- scale_colour_gradient(low = "red", high = "blue")
qplot(cty, hwy, data = mpg, colour = displ) + gradient_rb
qplot(bodywt, brainwt, data = msleep, colour = awake, log="xy") +
gradient_rb



xquiet <- scale_x_continuous("", breaks = NULL)
yquiet <- scale_y_continuous("", breaks = NULL)
quiet <- list(xquiet, yquiet)
qplot(mpg, wt, data = mtcars) + quiet
qplot(displ, cty, data = mpg) + quiet


###########
geom_lm <- function(formula = y ~ x) {
geom_smooth(formula = formula, se = FALSE, method = "lm")
}
qplot(mpg, wt, data = mtcars) + geom_lm()
library(splines)
qplot(mpg, wt, data = mtcars) + geom_lm(y ~ ns(x, 3))


qplot(x, y, data = data)
ggplot(data, aes(x, y)) + geom_point()


qplot(x, y, data = data, shape = shape, colour = colour)
ggplot(data, aes(x, y, shape = shape, colour = colour)) +
geom_point()



qplot(x, y, data = data, colour = I("red"))
ggplot(data, aes(x, y)) + geom_point(colour = "red")

qplot(x, y, data = data, colour = I("red"))
ggplot(BS_table, aes(Date, close)) + geom_point(colour = "red")
ggplot(BS_table, aes(Date, close)) + geom_point(colour = type)
ggplot(BS_table, aes(Date, close,colour = type,shape=type)) + geom_point()

qplot(x, y, data = data, geom = "line")
ggplot(data, aes(x, y)) + geom_line()

qplot(x, y, data = data, geom = c("point", "smooth"))
ggplot(data, aes(x, y)) + geom_point() + geom_smooth()

qplot(x, y, data = data, stat = "bin")
ggplot(data, aes(x, y)) + geom_point(stat = "bin")

qplot(Date, close, data = BS_table, stat = "bin")
ggplot(BS_table, aes(Date, close)) + geom_point(stat = "bin")


qplot(x, y, data = data, geom = c("point", "smooth"),
method = "lm")
ggplot(data, aes(x, y)) +
geom_point(method = "lm") + geom_smooth(method = "lm")


qplot(x, y, data = data, xlim = c(1, 5), xlab = "my label")
ggplot(data, aes(x, y)) + geom_point() +
scale_x_continuous("my label", limits = c(1, 5))
qplot(x, y, data = data, xlim = c(1, 5), ylim = c(10, 20))
ggplot(data, aes(x, y)) + geom_point() +
scale_x_continuous(limits = c(1, 5))
scale_y_continuous(limits = c(10, 20))
Like plot(), qplot() has a convenient way of log transforming the axes.
There are many other possible transformations that are not accessible from
within qplot() see Section 6.4.2 for more details.
qplot(x, y, data = data, log="xy")
ggplot(data, aes(x, y)) + geom_point() +
scale_x_log10() + scale_y_log10()

http://research.stowers-institute.org/efg/R/color/chart
#############################################

