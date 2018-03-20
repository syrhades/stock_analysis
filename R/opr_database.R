苏州市工业园区金鸡湖大道1355号国际科技园3期5楼A1~3单元。
	
 在Ubuntu / Ubuntu Kylin下安装和卸载 Nodepadqq
        对于Ubuntu发行版本可以通过PPA安装，命令如下：

sudo add-apt-repository ppa:notepadqq-team/notepadqq
sudo apt-get update
sudo apt-get install notepadqq

           类似的，卸载命令如下：

sudo apt-get remove notepadqq
sudo add-apt-repository --remove ppa:notepadqq-team/notepadqq

#最后给一个用find+grep的方法找出文件内含有^M的文件名
#find . -type f  -exec grep -l ^M {} \;

#grep的-l参数，是返回的文件名的意思
#fstab
#/dev/sdb /opt/seeburger ext4 rw,relatime,data=ordered 0 0
#/etc/mtab


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

colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type")
#BS_table<-mutate(df1,avgprice=mean(high,open,low,close))


rmat = matrix(rnorm(15),5,3,dimnames=list(NULL,c('A','B','C')))
class
model
methods
summary()



> showClass(class(BS_table))
Class "data.frame" [package "methods"]

Slots:
                                                                  
Name:                .Data               names           row.names
Class:                list           character data.frameRowLabels
                          
Name:             .S3Class
Class:           character

Extends: 
Class "list", from data part
Class "oldClass", directly
Class "vector", by class "list", distance 2

BS_table@.Data


> BS_table@names
错误: 非S4类别的对象(类别为"data.frame")没有"names"这样的槽
> BS_table$names
NULL
> BS_table@row.names
错误: 非S4类别的对象(类别为"data.frame")没有"row.names"这样的槽
> row.names(BS_table)
   [1] "1"    "2"    "3"    "4"    "5"    "6"    "7"    "8"    "9"    "10"  
> names(BS_table)
[1] "Date"              "BS_POINT.open"     "BS_POINT.high"    
[4] "BS_POINT.low"      "BS_POINT.close"    "BS_POINT.vol"     
[7] "BS_POINT.close1"   "unlist(typepoint)"


> slot(BS_table,'names')
[1] "Date"              "BS_POINT.open"     "BS_POINT.high"    
[4] "BS_POINT.low"      "BS_POINT.close"    "BS_POINT.vol"     
[7] "BS_POINT.close1"   "unlist(typepoint)"
> 
> slot(BS_table,'.S3Class')
[1] "data.frame"



rpage<- url('http://www.r-project.org/main.shtml','r')
while(1){
	l=readlines(rpage,1)
	if(length(l) == 0) break;
	if(regexpr('has been released',l) > -1){
	ver = sub('</a.*$','',l)
	print(gsub('^ *','',ver))
	}
}
close(rpage)

gfile=gzfile('xxx.gz')
write.table(mydata,sep=',',file=gfile)


计算文件行数
nrec<- as.numeric(system('cat comma.txt|wc -l',intern=TRUE))

nrec<- as.numeric(system('cat /etc/passwd|wc -l',intern=TRUE))


1:10
seq(1,10)
seq(0, by=5, length = 11)
seq(0, 1, length.out = 11)
seq(stats::rnorm(20)) # effectively 'along'
seq(1, 9, by = 2)     # matches 'end'
seq(1, 9, by = pi)    # stays below 'end'
seq(1, 6, by = 3)
seq(1.575, 5.125, by = 0.05)
seq(17) # same as 1:17, or even better seq_len(17)


Generate factors by specifying the pattern of their levels.
Usage

gl(n, k, length = n*k, labels = seq_len(n), ordered = FALSE)

Arguments
n 	

an integer giving the number of levels.
k 	

an integer giving the number of replications.
length 	

an integer giving the length of the result.
labels 	

an optional vector of labels for the resulting factor levels.
ordered 	

a logical indicating whether the result should be ordered or not.
Value

The result has levels from 1 to n with each value replicated in groups of length k out to a total length of length.

gl is modelled on the GLIM function of the same name.
See Also

The underlying factor().
Examples

## First control, then treatment:
gl(2, 8, labels = c("Control", "Treat"))
## 20 alternating 1s and 2s
gl(2, 1, 20)
## alternating pairs of 1s and 2s
gl(2, 2, 20)


> example(expand.grid)

expnd.> require(utils)

expnd.> expand.grid(height = seq(60, 80, 5), weight = seq(100, 300, 50),
expnd.+             sex = c("Male","Female"))
   height weight    sex
1      60    100   Male
2      65    100   Male
3      70    100   Male
4      75    100   Male
5      80    100   Male
6      60    150   Male
7      65    150   Male
8      70    150   Male
9      75    150   Male
10     80    150   Male
11     60    200   Male
12     65    200   Male
13     70    200   Male
14     75    200   Male
15     80    200   Male
16     60    250   Male
17     65    250   Male
18     70    250   Male
19     75    250   Male
20     80    250   Male
21     60    300   Male
22     65    300   Male
23     70    300   Male
24     75    300   Male
25     80    300   Male
26     60    100 Female
27     65    100 Female
28     70    100 Female
29     75    100 Female
30     80    100 Female
31     60    150 Female
32     65    150 Female
33     70    150 Female
34     75    150 Female
35     80    150 Female
36     60    200 Female
37     65    200 Female
38     70    200 Female
39     75    200 Female
40     80    200 Female
41     60    250 Female
42     65    250 Female
43     70    250 Female
44     75    250 Female
45     80    250 Female
46     60    300 Female
47     65    300 Female
48     70    300 Female
49     75    300 Female
50     80    300 Female

expnd.> x <- seq(0, 10, length.out = 100)

expnd.> y <- seq(-1, 1, length.out = 20)

expnd.> d1 <- expand.grid(x = x, y = y)

expnd.> d2 <- expand.grid(x = x, y = y, KEEP.OUT.ATTRS = FALSE)

expnd.> object.size(d1) - object.size(d2)
8832 bytes

expnd.> ##-> 5992 or 8832 (on 32- / 64-bit platform)
expnd.> ## Don't show: 
expnd.> stopifnot(object.size(d1) > object.size(d2))

expnd.> ## End(Don't show)
expnd.> 
expnd.> 
expnd.> 


input<- expand.grid(x=0:10,y=0:10)
res<-apply(input,1,function(row) row[1]^2+row[2]^2)
head(cbind(input,res))

page42 
2.9
Examples
x <- 1:12
# a random permutation
sample(x)
# bootstrap resampling -- only if length(x) > 1 !
sample(x, replace = TRUE)

# 100 Bernoulli trials
sample(c(0,1), 100, replace = TRUE)

## More careful bootstrapping --  Consider this when using sample()
## programmatically (i.e., in your function or simulation)!

# sample()'s surprise -- example
x <- 1:10
    sample(x[x >  8]) # length 2
    sample(x[x >  9]) # oops -- length 10!
    sample(x[x > 10]) # length 0

resample <- function(x, ...) x[sample.int(length(x), ...)]
resample(x[x >  8]) # length 2
resample(x[x >  9]) # length 1
resample(x[x > 10]) # length 0

## R 3.x.y only
sample.int(1e10, 12, replace = TRUE)
sample.int(1e10, 12) # not that there is much chance of duplicates

table

Examples
require(stats) # for rpois and xtabs
## Simple frequency distribution
table(rpois(100, 5))
## Check the design:
with(warpbreaks, table(wool, tension))
table(state.division, state.region)

# simple two-way contingency table
with(airquality, table(cut(Temp, quantile(Temp)), Month))

a <- letters[1:3]
table(a, sample(a))                    # dnn is c("a", "")
table(a, sample(a), deparse.level = 0) # dnn is c("", "")
table(a, sample(a), deparse.level = 2) # dnn is c("a", "sample(a)")

## xtabs() <-> as.data.frame.table() :
UCBAdmissions ## already a contingency table
DF <- as.data.frame(UCBAdmissions)
class(tab <- xtabs(Freq ~ ., DF)) # xtabs & table
## tab *is* "the same" as the original table:
all(tab == UCBAdmissions)
all.equal(dimnames(tab), dimnames(UCBAdmissions))

a <- rep(c(NA, 1/0:3), 10)
table(a)
table(a, exclude = NULL)
b <- factor(rep(c("A","B","C"), 10))
table(b)
table(b, exclude = "B")
d <- factor(rep(c("A","B","C"), 10), levels = c("A","B","C","D","E"))
table(d, exclude = "B")
print(table(b, d), zero.print = ".")

## NA counting:
is.na(d) <- 3:4
d. <- addNA(d)
d.[1:7]
table(d.) # ", exclude = NULL" is not needed
## i.e., if you want to count the NA's of 'd', use
table(d, useNA = "ifany")

## Two-way tables with NA counts. The 3rd variant is absurd, but shows
## something that cannot be done using exclude or useNA.
with(airquality,
   table(OzHi = Ozone > 80, Month, useNA = "ifany"))
with(airquality,
   table(OzHi = Ozone > 80, Month, useNA = "always"))
with(airquality,
   table(OzHi = Ozone > 80, addNA(Month)))



unique
x <- c(3:5, 11:8, 8 + 0:5)
(ux <- unique(x))
(u2 <- unique(x, fromLast = TRUE)) # different order
stopifnot(identical(sort(ux), sort(u2)))

length(unique(sample(100, 100, replace = TRUE)))
## approximately 100(1 - 1/e) = 63.21

unique(iris)



duplicated
x <- c(9:20, 1:5, 3:7, 0:8)
## extract unique elements
(xu <- x[!duplicated(x)])
## similar, same elements but different order:
(xu2 <- x[!duplicated(x, fromLast = TRUE)])

## xu == unique(x) but unique(x) is more efficient
stopifnot(identical(xu,  unique(x)),
          identical(xu2, unique(x, fromLast = TRUE)))

duplicated(iris)[140:143]

duplicated(iris3, MARGIN = c(1, 3))
anyDuplicated(iris) ## 143

anyDuplicated(x)
anyDuplicated(x, fromLast = TRUE)

xx<-sample(1:10)
xx
rle(xx)
?rep
rep(1:4, 2)
xx<-rep(1:4, 2)
rle(xx)


seq1<-c(1,3,4,5,2,2,2,7,6)

rle.seq1<-rle(seq1)
any(rle.seq1$values == 2 & rle.seq1$lengths >= 3)

RODBC
install.pacage("RODBC")
odbcConnectExcel

library(RODBC)
sheet="c:/xxx.xls"
con=odbcConnectExcel(sheet)

tbls=sqlTables(con)
qry=paste("select * from",tbls$TABLE_NAME[1],sep=' ')
result=sqlQuery(con,qry)

gdata package


save(x,y,z,file='/tmp/mydata.rda')
load('mydata.rda')

foreign package

連接數據庫

myDataSetName

odbcConnectExcel

library(RODBC)
con=odbcConnect('myDataSetName')
odbcTables(con,tableName="TADDRESS")
odbcTables(con,tableName="tEntities")


odbcQuery(con,"select * from tAS2Address")
ddd<-odbcFetchRows(con)
ddd
class(ddd)
df<-as.data.frame(ddd)



dbApply

as.Date('1915-6-16')
as.Date('1915-6-16',format='%m/%d/%Y')

thedate = as.Date('1/15/2001',format='%m/%d/%Y')
ndate=as.numeric(thedate)
ndate



> thedate = as.Date('1/15/2001',format='%m/%d/%Y')
> ndate=as.numeric(thedate)
> ndate
[1] 11337
> class(ndate)
[1] "numeric"
> class(ndate)='Date'
> ndate
[1] "2001-01-15"
> 

weekdays(ndate)
Examples
## locale-specific version of the date
format(Sys.Date(), "%a %b %d")

## read in date info in format 'ddmmmyyyy'
## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
## lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
## Sys.setlocale("LC_TIME", lct)
z

## read in date/time info in format 'm/d/y'
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
as.Date(dates, "%m/%d/%y")

## date given as number of days since 1900-01-01 (a date in 1989)
as.Date(32768, origin = "1900-01-01")
## Excel is said to use 1900-01-01 as day 1 (Windows default) or
## 1904-01-01 as day 0 (Mac default), but this is complicated by Excel
## incorrectly treating 1900 as a leap year.
## So for dates (post-1901) from Windows Excel
as.Date(35981, origin = "1899-12-30") # 1998-07-05
## and Mac Excel
as.Date(34519, origin = "1904-01-01") # 1998-07-05
## (these values come from http://support.microsoft.com/kb/214330)

## Experiment shows that Matlab's origin is 719529 days before ours,
## (it takes the non-existent 0000-01-01 as day 1)
## so Matlab day 734373 can be imported as
as.Date(734373, origin = "1970-01-01") - 719529 # 2010-08-23
## (value from 
## http://www.mathworks.de/de/help/matlab/matlab_prog/represent-date-and-times-in-MATLAB.html)

## Time zone effect
z <- ISOdate(2010, 04, 13, c(0,12)) # midnight and midday UTC
as.Date(z) # in UTC
## these time zone names are common
as.Date(z, tz = "NZ")
as.Date(z, tz = "HST") # Hawaii



chron package

library(chron)
dtimes <- c("2002-06-08 12:45:01",
"2002-06-07 12:45:01",
"2002-06-08 12:45:01",
"2002-06-09 12:45:01",
"2002-06-18 12:45:01",
"2002-06-28 12:45:01")
dtparts = t(as.data.frame(strsplit(dtimes,' ')))
row.names(dtparts) <-NULL
thetimes<-chron(dates=dtparts[,1],times=dtparts[,2],format=c('y-m-d','h:m:s'))

as.POSIXlt(dtimes)
dts = c(1,2,3,4,5,6,7,8)
mydates<-dts
class(mydates)<- c('POSIXt','POSIXct')

mydates <- structure(dts,class=c('POSIXt','POSIXct'))
strptime,
strftime

## locale-specific version of date()
format(Sys.time(), "%a %b %d %X %Y %Z")

## time to sub-second accuracy (if supported by the OS)
format(Sys.time(), "%H:%M:%OS3")

## read in date info in format 'ddmmmyyyy'
## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
## lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- strptime(x, "%d%b%Y")
## Sys.setlocale("LC_TIME", lct)
z

## read in date/time info in format 'm/d/y h:m:s'
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
times <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")
x <- paste(dates, times)
strptime(x, "%m/%d/%y %H:%M:%S")

## time with fractional seconds
z <- strptime("20/2/06 11:16:16.683", "%d/%m/%y %H:%M:%OS")
z # prints without fractional seconds
op <- options(digits.secs = 3)
z
options(op)

## time zones name are not portable, but 'EST5EDT' comes pretty close.
(x <- strptime(c("2006-01-08 10:07:52", "2006-08-07 19:33:02"),
               "%Y-%m-%d %H:%M:%S", tz = "EST5EDT"))
attr(x, "tzone")

## An RFC 822 header (Eastern Canada, during DST)
strptime("Tue, 23 Mar 2010 14:36:38 -0400",  "%a, %d %b %Y %H:%M:%S %z")

## Make sure you know what the abbreviated names are for you if you wish
## to use them for input (they are matched case-insensitively):
format(seq.Date(as.Date('1978-01-01'), by = 'day', len = 7), "%a")
format(seq.Date(as.Date('2000-01-01'), by = 'month', len = 12), "%b")
#####################################################
BS_table["avgprice"]<-apply(BS_table[2:5],1,mean)
colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type","avgprice")

options(stringsAsFactors=FALSE)


city = read.fwf("city.txt",widths=c(18,-19,8),as.is=TRUE)
city$V2 = as.numeric(gsub(',','',city$V2))
自省
class(slm)
apropos('.*\\.lm$')
require(stats)


## Not run: apropos("lm")
apropos("GLM")                      # more than a dozen
## that may include internal objects starting '.__C__' if
## methods is attached
apropos("GLM", ignore.case = FALSE) # not one
apropos("lq")

cor <- 1:pi
find("cor")                         #> ".GlobalEnv"   "package:stats"
find("cor", numeric = TRUE)                     # numbers with these names
find("cor", numeric = TRUE, mode = "function")  # only the second one
rm(cor)

## Not run: apropos(".", mode="list")  # a long list

# need a DOUBLE backslash '\\' (in case you don't see it anymore)
apropos("\\[")

# everything % not diff-able
length(apropos("."))

# those starting with 'pr'
apropos("^pr")

# the 1-letter things
apropos("^.$")
# the 1-2-letter things
apropos("^..?$")
# the 2-to-4 letter things
apropos("^.{2,4}$")

# the 8-and-more letter things
apropos("^.{8,}$")
table(nchar(apropos("^.{8,}$")))


getAnywhere

getAnywhere("format.dist")
getAnywhere("simpleLoess") # not exported from stats
argsAnywhere(format.dist)

names(slm)

library(methods)

isS4(xxx)


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
gline<-ggplot(melt_bs_table, aes(Date, value)，colour=variable) 
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



Examples
## locale-specific version of date()
format(Sys.time(), "%a %b %d %X %Y %Z")

## time to sub-second accuracy (if supported by the OS)
format(Sys.time(), "%H:%M:%OS3")

## read in date info in format 'ddmmmyyyy'
## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
## lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- strptime(x, "%d%b%Y")
## Sys.setlocale("LC_TIME", lct)
z

## read in date/time info in format 'm/d/y h:m:s'
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
times <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")
x <- paste(dates, times)
strptime(x, "%m/%d/%y %H:%M:%S")

## time with fractional seconds
z <- strptime("20/2/06 11:16:16.683", "%d/%m/%y %H:%M:%OS")
z # prints without fractional seconds
op <- options(digits.secs = 3)
z
options(op)

## time zones name are not portable, but 'EST5EDT' comes pretty close.
(x <- strptime(c("2006-01-08 10:07:52", "2006-08-07 19:33:02"),
               "%Y-%m-%d %H:%M:%S", tz = "EST5EDT"))
attr(x, "tzone")

## An RFC 822 header (Eastern Canada, during DST)
strptime("Tue, 23 Mar 2010 14:36:38 -0400",  "%a, %d %b %Y %H:%M:%S %z")

## Make sure you know what the abbreviated names are for you if you wish
## to use them for input (they are matched case-insensitively):
format(seq.Date(as.Date('1978-01-01'), by = 'day', len = 7), "%a")
format(seq.Date(as.Date('2000-01-01'), by = 'month', len = 12), "%b")



ISOdate(2006,5,16,7,15,04,tz="PDT")
(z <- Sys.time() - 3600)
Sys.time() - z                # just over 3600 seconds.

## time interval between release days of R 1.2.2 and 1.2.3.
ISOdate(2001, 4, 26) - ISOdate(2001, 2, 26)

as.difftime(c("0:3:20", "11:23:15"))
as.difftime(c("3:20", "23:15", "2:"), format = "%H:%M") # 3rd gives NA
(z <- as.difftime(c(0,30,60), units = "mins"))
as.numeric(z, units = "secs")
as.numeric(z, units = "hours")
format(z)

attributes(BS_table)

x <- cbind(a = 1:3, pi = pi) # simple matrix with dimnames
attributes(x)

## strip an object's attributes:
attributes(x) <- NULL
x # now just a vector of length 6

mostattributes(x) <- list(mycomment = "really special", dim = 3:2,
   dimnames = list(LETTERS[1:3], letters[1:5]), names = paste(1:6))
x # dim(), but not {dim}names

attr {base} R Documentation 

Object Attributes

Description

Get or set specific attributes of an object. 

Usage
attr(x, which, exact = FALSE)
attr(x, which) <- value


Arguments

x 
an object whose attributes are to be accessed.
 
which 
a non-empty character string specifying which attribute is to be accessed.
 
exact 
logical: should which be matched exactly?
 
value 
an object, the new value of the attribute, or NULL to remove the attribute.
 

Details

These functions provide access to a single attribute of an object. The replacement form causes the named attribute to take the value specified (or create a new attribute with the value given). 

The extraction function first looks for an exact match to which amongst the attributes of x, then (unless exact = TRUE) a unique partial match. (Setting options(warnPartialMatchAttr = TRUE) causes partial matches to give warnings.) 

The replacement function only uses exact matches. 

Note that some attributes (namely class, comment, dim, dimnames, names, row.names and tsp) are treated specially and have restrictions on the values which can be set. (Note that this is not true of levels which should be set for factors via the levels replacement function.) 

The extractor function allows (and does not match) empty and missing values of which: the replacement function does not. 

Both are primitive functions. 

Value

For the extractor, the value of the attribute matched, or NULL if no exact match is found and no or more than one partial match is found. 

References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole. 

See Also

attributes 

Examples
# create a 2 by 5 matrix
x <- 1:10
attr(x,"dim") <- c(2, 5)

seq(as.Date('1976-7-4'),by='days',length=10)

(ff <- factor(substring("statistics", 1:10, 1:10), levels = letters))
as.integer(ff)      # the internal codes
(f. <- factor(ff))  # drops the levels that do not occur
ff[, drop = TRUE]   # the same, more transparently

factor(letters[1:20], labels = "letter")

class(ordered(4:1)) # "ordered", inheriting from "factor"
z <- factor(LETTERS[3:1], ordered = TRUE)
## and "relational" methods work:
stopifnot(sort(z)[c(1,3)] == range(z), min(z) < max(z))


## suppose you want "NA" as a level, and to allow missing values.
(x <- factor(c(1, 2, NA), exclude = NULL))
is.na(x)[2] <- TRUE
x  # [1] 1    <NA> <NA>
is.na(x)
# [1] FALSE  TRUE FALSE

## Using addNA()
Month <- airquality$Month
table(addNA(Month))
table(addNA(Month, ifany = TRUE))


data=c(1,2,3,1,2,2,2,2,3,3)
factor(data,labels=c("I","II","III"))
levels(data)=c("I","II","III")


lets=sample(letters,size=100,replace=TRUE)
let2=factor(lets)
table(let2[1:5])


Examples
Z <- stats::rnorm(10000)
table(cut(Z, breaks = -6:6))
sum(table(cut(Z, breaks = -6:6, labels = FALSE)))
sum(graphics::hist(Z, breaks = -6:6, plot = FALSE)$counts)

cut(rep(1,5), 4) #-- dummy
tx0 <- c(9, 4, 6, 5, 3, 10, 5, 3, 5)
x <- rep(0:8, tx0)
stopifnot(table(x) == tx0)

table( cut(x, b = 8))
table( cut(x, breaks = 3*(-2:5)))
table( cut(x, breaks = 3*(-2:5), right = FALSE))

##--- some values OUTSIDE the breaks :
table(cx  <- cut(x, breaks = 2*(0:4)))
table(cxl <- cut(x, breaks = 2*(0:4), right = FALSE))
which(is.na(cx));  x[is.na(cx)]  #-- the first 9  values  0
which(is.na(cxl)); x[is.na(cxl)] #-- the last  5  values  8


## Label construction:
y <- stats::rnorm(100)
table(cut(y, breaks = pi/3*(-3:3)))
table(cut(y, breaks = pi/3*(-3:3), dig.lab = 4))

table(cut(y, breaks =  1*(-3:3), dig.lab = 4))
# extra digits don't "harm" here
table(cut(y, breaks =  1*(-3:3), right = FALSE))
#- the same, since no exact INT!

## sometimes the default dig.lab is not enough to be avoid confusion:
aaa <- c(1,2,3,4,5,2,3,4,5,6,7)
cut(aaa, 3)
cut(aaa, 3, dig.lab = 4, ordered = TRUE)

## one way to extract the breakpoints
labs <- levels(cut(aaa, 3))
cbind(lower = as.numeric( sub("\\((.+),.*", "\\1", labs) ),
      upper = as.numeric( sub("[^,]*,([^]]*)\\]", "\\1", labs) ))

Examples
quantile(x <- rnorm(1001)) # Extremes & Quartiles by default
quantile(x,  probs = c(0.1, 0.5, 1, 2, 5, 10, 50, NA)/100)

### Compare different types
p <- c(0.1, 0.5, 1, 2, 5, 10, 50)/100
res <- matrix(as.numeric(NA), 9, 7)
for(type in 1:9) res[type, ] <- y <- quantile(x,  p, type = type)
dimnames(res) <- list(1:9, names(y))
round(res, 3)

nums[nums>10]
which(nums>10)
seq(along=nums)[nums>10]

x[order(x)]   sort(x)

stack.x.a = stack.x[order(stack.x[,'Air.Flow']),]

require(stats)

(ii <- order(x <- c(1,1,3:1,1:4,3), y <- c(9,9:1), z <- c(2,1:9)))
## 6  5  2  1  7  4 10  8  3  9
rbind(x, y, z)[,ii] # shows the reordering (ties via 2nd & 3rd arg)

## Suppose we wanted descending order on y.
## A simple solution for numeric 'y' is
rbind(x, y, z)[, order(x, -y, z)]
## More generally we can make use of xtfrm
cy <- as.character(y)
rbind(x, y, z)[, order(x, -xtfrm(cy), z)]

## Sorting data frames:
dd <- transform(data.frame(x, y, z),
                z = factor(z, labels = LETTERS[9:1]))
## Either as above {for factor 'z' : using internal coding}:
dd[ order(x, -y, z), ]
## or along 1st column, ties along 2nd, ... *arbitrary* no.{columns}:
dd[ do.call(order, dd), ]

set.seed(1)  # reproducible example:
d4 <- data.frame(x = round(   rnorm(100)), y = round(10*runif(100)),
                 z = round( 8*rnorm(100)), u = round(50*runif(100)))
(d4s <- d4[ do.call(order, d4), ])
(i <- which(diff(d4s[, 3]) == 0))
#   in 2 places, needed 3 cols to break ties:
d4s[ rbind(i, i+1), ]

## rearrange matched vectors so that the first is in ascending order
x <- c(5:1, 6:8, 12:9)
y <- (x - 5)^2
o <- order(x)
rbind(x[o], y[o])

## tests of na.last
a <- c(4, 3, 2, NA, 1)
b <- c(4, NA, 2, 7, 1)
z <- cbind(a, b)
(o <- order(a, b)); z[o, ]
(o <- order(a, b, na.last = FALSE)); z[o, ]
(o <- order(a, b, na.last = NA)); z[o, ]


##  speed examples for long vectors:
x <- factor(sample(letters, 1e6, replace = TRUE))
system.time(o <- sort.list(x)) ## 0.4 secs
stopifnot(!is.unsorted(x[o]))
system.time(o <- sort.list(x, method = "quick", na.last = NA)) # 0.1 sec
stopifnot(!is.unsorted(x[o]))
system.time(o <- sort.list(x, method = "radix")) # 0.01 sec
stopifnot(!is.unsorted(x[o]))
xx <- sample(1:26, 1e7, replace = TRUE)
system.time(o <- sort.list(xx, method = "radix")) # 0.1 sec
xx <- sample(1:100000, 1e7, replace = TRUE)
system.time(o <- sort.list(xx, method = "radix")) # 0.5 sec
system.time(o <- sort.list(xx, method = "quick", na.last = NA)) # 1.3 sec

order(..., na.last = TRUE, decreasing = FALSE)

sort.list(x, partial = NULL, na.last = TRUE, decreasing = FALSE,
          method = c("shell", "quick", "radix"))


Arguments

... 
a sequence of numeric, complex, character or logical vectors, all of the same length, or a classed R object.
 
x 
an atomic vector.
 
partial 
vector of indices for partial sorting. (Non-NULL values are not implemented.)
 
decreasing 
logical. Should the sort order be increasing or decreasing?
 
na.last 
for controlling the treatment of NAs. If TRUE, missing values in the data are put last; if FALSE, they are put first; if NA, they are removed (see ‘Note’.)
 
method 
the method to be used: partial matches are allowed. The default is "shell" except for some special cases: see ‘Details’. For details of methods "shell" and "quick", see the help for sort.
 
sortframe = function(df,...)df[do.call(order,list(...))]

iris[rev(1:nrow(iris))]

x = matrix(1:12,4,3)
x[,1]
x[,1,drop=FALSE]

x[,1] <3
x[x[,1] < 3,]
offd=row(tt) != col(tt)

subset(dd,b>10)

subset(df,sr>10,select =c(pop15,pop73))
subset(df,sr>10,select =c(pop15,pop73))

subset(airquality, Temp > 80, select = c(Ozone, Temp))
subset(airquality, Day == 1, select = -Temp)
subset(airquality, select = Ozone:Wind)

with(airquality, subset(Ozone, Temp > 80))

## sometimes requiring a logical 'subset' argument is a nuisance
nm <- rownames(state.x77)
start_with_M <- nm %in% grep("^M", nm, value = TRUE)
subset(state.x77, start_with_M, Illiteracy:Murder)
# but in recent versions of R this can simply be
subset(state.x77, grepl("^M", nm), Illiteracy:Murder)


dt <- data.table(a=sample(c('a', 'b', 'c'), 20, replace=TRUE),
                 b=sample(c('a', 'b', 'c'), 20, replace=TRUE),
                 c=sample(20), key=c('a', 'b'))

sub <- subset(dt, a == 'a')
all.equal(key(sub), key(dt))


paste('X',1:5,sep=‘ ’)
paste(c('X','Y'),1:5,sep=‘ ’)
page106

substring(state.name,2,6)
mystring = "dog cat duck"
substring(mystring,c(1,5,9),c(3,7,12))

Examples:

     substr("abcdef", 2, 4)
     substring("abcdef", 1:6, 1:6)
     ## strsplit is more efficient ...
     
     substr(rep("abcdef", 4), 1:4, 4:5)
     x <- c("asfef", "qwerty", "yuiop[", "b", "stuff.blah.yech")
     substr(x, 2, 5)
     substring(x, 2, 4:6)
     
     substring(x, 2) <- c("..", "+++")
     x

expr='.*\\.txt'
nchar(expr)
cat(expr,'\n')

strs=c('a','dog','cat')
expr=paste(strs,collapse='|')
expr


strsplit
> example(strsplit)

strspl> noquote(strsplit("A text I want to display with spaces", NULL)[[1]])
 [1] A   t e x t   I   w a n t   t o   d i s p l a y   w i t h   s p a c e s

strspl> x <- c(as = "asfef", qu = "qwerty", "yuiop[", "b", "stuff.blah.yech")

strspl> # split x on the letter e
strspl> strsplit(x, "e")
$as
[1] "asf" "f"  

$qu
[1] "qw"  "rty"

[[3]]
[1] "yuiop["

[[4]]
[1] "b"

[[5]]
[1] "stuff.blah.y" "ch"          


strspl> unlist(strsplit("a.b.c", "."))
[1] "" "" "" "" ""

strspl> ## [1] "" "" "" "" ""
strspl> ## Note that 'split' is a regexp!
strspl> ## If you really want to split on '.', use
strspl> unlist(strsplit("a.b.c", "[.]"))
[1] "a" "b" "c"

strspl> ## [1] "a" "b" "c"
strspl> ## or
strspl> unlist(strsplit("a.b.c", ".", fixed = TRUE))
[1] "a" "b" "c"

strspl> ## a useful function: rev() for strings
strspl> strReverse <- function(x)
strspl+         sapply(lapply(strsplit(x, NULL), rev), paste, collapse = "")

strspl> strReverse(c("abc", "Statistics"))
[1] "cba"        "scitsitatS"

strspl> ## get the first names of the members of R-core
strspl> a <- readLines(file.path(R.home("doc"),"AUTHORS"))[-(1:8)]

strspl> a <- a[(0:2)-length(a)]

strspl> (a <- sub(" .*","", a))
 [1] "Douglas"   "John"      "Peter"     "Seth"      "Robert"    "Kurt"     
 [7] "Ross"      "Michael"   "Friedrich" "Uwe"       "Thomas"    "Martin"   
[13] "Martin"    "Duncan"    "Paul"      "Martyn"    "Brian"     "Deepayan" 
[19] "Duncan"    "Luke"      "Simon"     ""          "plus"      "Stefano"  
[25] ""          "Current"   "with"     

strspl> # and reverse them
strspl> strReverse(a)
 [1] "salguoD"   "nhoJ"      "reteP"     "hteS"      "treboR"    "truK"     
 [7] "ssoR"      "leahciM"   "hcirdeirF" "ewU"       "samohT"    "nitraM"   
[13] "nitraM"    "nacnuD"    "luaP"      "nytraM"    "nairB"     "nayapeeD" 
[19] "nacnuD"    "ekuL"      "nomiS"     ""          "sulp"      "onafetS"  
[25] ""          "tnerruC"   "htiw"     

strspl> ## Note that final empty strings are not produced:
strspl> strsplit(paste(c("", "a", ""), collapse="#"), split="#")[[1]]
[1] ""  "a"

strspl> # [1] ""  "a"
strspl> ## and also an empty string is only produced before a definite match:
strspl> strsplit("", " ")[[1]]    # character(0)
character(0)

strspl> strsplit(" ", " ")[[1]]   # [1] ""
[1] ""


strsplit(str,' +')

strsplit(str,'')

grep('^pop',names(LifeCycleSavings))
grep('^pop',names(LifeCycleSavings),value=TRUE)

head(LifeCycleSavings[,grep('^pop',names(LifeCycleSavings))])

grep('\\<dog\\',inp,ignore.case=TRUE)

any(grep('profit',str1))

wh=regexpr('[a-z][0-9]',tst)

substring(tst,wh,wh+attr(wh,'match.length')-1)

wh1=gregexpr('[a-z][0-9]',tst)

res1=list()
for(i in 1:length(wh1))
	res1[[i]] =substring(tst[i],wh1[[i]],wh1[[i]]+attr(wh1[[i]],'match.length')-1)


getexpr=function(str,greg) substring(str,greg,greg+attr(greg,'match.length')-1)

res2=mapply(getexpr,tst,wh1)

gsub('\\(([0-9.]+)\\','-\\1',values)

sub('value=([^ ]+)','\\1',str)
sub('^.*value=([^ ]+).*$','\\1',str)


page118
SendStatusMD
数据汇总
Aye <- sample(c("Yes", "Si", "Oui"), 177, replace = TRUE)
Bee <- sample(c("Hum", "Buzz"), 177, replace = TRUE)
Sea <- sample(c("White", "Black", "Red", "Dead"), 177, replace = TRUE)
(A <- table(Aye, Bee, Sea))
addmargins(A)

ftable(A)
ftable(addmargins(A))

# Non-commutative functions - note differences between resulting tables:
ftable(addmargins(A, c(1, 3),
       FUN = list(Sum = sum, list(Min = min, Max = max))))
ftable(addmargins(A, c(3, 1),
       FUN = list(list(Min = min, Max = max), Sum = sum)))

# Weird function needed to return the N when computing percentages
sqsm <- function(x) sum(x)^2/100
B <- table(Sea, Bee)
round(sweep(addmargins(B, 1, list(list(All = sum, N = sqsm))), 2,
            apply(B, 2, sum)/100, "/"), 1)
round(sweep(addmargins(B, 2, list(list(All = sum, N = sqsm))), 1,
            apply(B, 1, sum)/100, "/"), 1)

# A total over Bee requires formation of the Bee-margin first:
mB <-  addmargins(B, 2, FUN = list(list(Total = sum)))
round(ftable(sweep(addmargins(mB, 1, list(list(All = sum, N = sqsm))), 2,
                   apply(mB, 2, sum)/100, "/")), 1)

## Zero.Printing table+margins:
set.seed(1)
x <- sample( 1:7, 20, replace = TRUE)
y <- sample( 1:7, 20, replace = TRUE)
tx <- addmargins( table(x, y) )
print(tx, zero.print = ".")

sweep
Examples
require(stats) # for median
med.att <- apply(attitude, 2, median)
sweep(data.matrix(attitude), 2, med.att)  # subtract the column medians

## More sweeping:
A <- array(1:24, dim = 4:2)

## no warnings in normal use
sweep(A, 1, 5)
(A.min <- apply(A, 1, min))  # == 1:4
sweep(A, 1, A.min)
sweep(A, 1:2, apply(A, 1:2, median))

## warnings when mismatch
sweep(A, 1, 1:3)  # STATS does not recycle
sweep(A, 1, 6:1)  # STATS is longer

## exact recycling:
sweep(A, 1, 1:2)  # no warning
sweep(A, 1, as.array(1:2))  # warning

ftable
可以扁平化多維表
ftable(UCBAdmissions)

ftable> ## Start with a contingency table.
ftable> ftable(Titanic, row.vars = 1:3)
                   Survived  No Yes
Class Sex    Age                   
1st   Male   Child            0   5
             Adult          118  57
      Female Child            0   1
             Adult            4 140
2nd   Male   Child            0  11
             Adult          154  14
      Female Child            0  13
             Adult           13  80
3rd   Male   Child           35  13
             Adult          387  75
      Female Child           17  14
             Adult           89  76
Crew  Male   Child            0   0
             Adult          670 192
      Female Child            0   0
             Adult            3  20

ftable> ftable(Titanic, row.vars = 1:2, col.vars = "Survived")
             Survived  No Yes
Class Sex                    
1st   Male            118  62
      Female            4 141
2nd   Male            154  25
      Female           13  93
3rd   Male            422  88
      Female          106  90
Crew  Male            670 192
      Female            3  20

ftable> ftable(Titanic, row.vars = 2:1, col.vars = "Survived")
             Survived  No Yes
Sex    Class                 
Male   1st            118  62
       2nd            154  25
       3rd            422  88
       Crew           670 192
Female 1st              4 141
       2nd             13  93
       3rd            106  90
       Crew             3  20

ftable> ## Don't show: 
ftable> . <- integer()

ftable> (f04 <- ftable(Titanic, col.vars= .))
Class Sex    Age   Survived     
1st   Male   Child No          0
                   Yes         5
             Adult No        118
                   Yes        57
      Female Child No          0
                   Yes         1
             Adult No          4
                   Yes       140
2nd   Male   Child No          0
                   Yes        11
             Adult No        154
                   Yes        14
      Female Child No          0
                   Yes        13
             Adult No         13
                   Yes        80
3rd   Male   Child No         35
                   Yes        13
             Adult No        387
                   Yes        75
      Female Child No         17
                   Yes        14
             Adult No         89
                   Yes        76
Crew  Male   Child No          0
                   Yes         0
             Adult No        670
                   Yes       192
      Female Child No          0
                   Yes         0
             Adult No          3
                   Yes        20

ftable> (f10 <- ftable(Titanic, col.vars= 1, row.vars= .))
Class 1st 2nd 3rd Crew
                      
      325 285 706  885

ftable> (f01 <- ftable(Titanic, col.vars= ., row.vars= 1))
Class     
1st    325
2nd    285
3rd    706
Crew   885

ftable> (f00 <- ftable(Titanic, col.vars= ., row.vars= .))
     
 2201

ftable> stopifnot(
ftable+   dim(f04) == c(32,1),
ftable+   dim(f10) == c(1,4),
ftable+   dim(f01) == c(4,1),
ftable+   dim(f00) == c(1,1))

ftable> ## End(Don't show)
ftable> ## Start with a data frame.
ftable> x <- ftable(mtcars[c("cyl", "vs", "am", "gear")])

ftable> x
          gear  3  4  5
cyl vs am              
4   0  0        0  0  0
       1        0  0  1
    1  0        1  2  0
       1        0  6  1
6   0  0        0  0  0
       1        0  2  1
    1  0        2  2  0
       1        0  0  0
8   0  0       12  0  0
       1        0  0  2
    1  0        0  0  0
       1        0  0  0

ftable> ftable(x, row.vars = c(2, 4))
        cyl  4     6     8   
        am   0  1  0  1  0  1
vs gear                      
0  3         0  0  0  0 12  0
   4         0  0  0  2  0  0
   5         0  1  0  1  0  2
1  3         1  0  2  0  0  0
   4         2  6  2  0  0  0
   5         0  1  0  0  0  0

ftable> ## Start with expressions, use table()'s "dnn" to change labels
ftable> ftable(mtcars$cyl, mtcars$vs, mtcars$am, mtcars$gear, row.vars = c(2, 4),
ftable+        dnn = c("Cylinders", "V/S", "Transmission", "Gears"))
          Cylinders     4     6     8   
          Transmission  0  1  0  1  0  1
V/S Gears                               
0   3                   0  0  0  0 12  0
    4                   0  0  0  2  0  0
    5                   0  1  0  1  0  2
1   3                   1  0  2  0  0  0
    4                   2  6  2  0  0  0
    5                   0  1  0  0  0  0


xtabs(~state.region+hiinc)
## 'esoph' has the frequencies of cases and controls for all levels of
## the variables 'agegp', 'alcgp', and 'tobgp'.
xtabs(cbind(ncases, ncontrols) ~ ., data = esoph)
## Output is not really helpful ... flat tables are better:
ftable(xtabs(cbind(ncases, ncontrols) ~ ., data = esoph))
## In particular if we have fewer factors ...
ftable(xtabs(cbind(ncases, ncontrols) ~ agegp, data = esoph))

## This is already a contingency table in array form.
DF <- as.data.frame(UCBAdmissions)
## Now 'DF' is a data frame with a grid of the factors and the counts
## in variable 'Freq'.
DF
## Nice for taking margins ...
xtabs(Freq ~ Gender + Admit, DF)
## And for testing independence ...
summary(xtabs(Freq ~ ., DF))

## Create a nice display for the warp break data.
warpbreaks$replicate <- rep(1:9, len = 54)
ftable(xtabs(breaks ~ wool + tension + replicate, data = warpbreaks))

### ---- Sparse Examples ----

if(require("Matrix")) {
 ## similar to "nlme"s  'ergoStool' :
 d.ergo <- data.frame(Type = paste0("T", rep(1:4, 9*4)),
                      Subj = gl(9, 4, 36*4))
 print(xtabs(~ Type + Subj, data = d.ergo)) # 4 replicates each
 set.seed(15) # a subset of cases:
 print(xtabs(~ Type + Subj, data = d.ergo[sample(36, 10), ], sparse = TRUE))

 ## Hypothetical two-level setup:
 inner <- factor(sample(letters[1:25], 100, replace = TRUE))
 inout <- factor(sample(LETTERS[1:5], 25, replace = TRUE))
 fr <- data.frame(inner = inner, outer = inout[as.integer(inner)])
 print(xtabs(~ inner + outer, fr, sparse = TRUE))
}


===============================
df[,sapply(df,class)=='numeric']
?replicate
Examples
require(stats); require(graphics)

x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
# compute the list mean for each list element
lapply(x, mean)
# median and quartiles for each list element
lapply(x, quantile, probs = 1:3/4)
sapply(x, quantile)
i39 <- sapply(3:9, seq) # list of vectors
sapply(i39, fivenum)
vapply(i39, fivenum,
       c(Min. = 0, "1st Qu." = 0, Median = 0, "3rd Qu." = 0, Max. = 0))

## sapply(*, "array") -- artificial example
(v <- structure(10*(5:8), names = LETTERS[1:4]))
f2 <- function(x, y) outer(rep(x, length.out = 3), y)
(a2 <- sapply(v, f2, y = 2*(1:5), simplify = "array"))
a.2 <- vapply(v, f2, outer(1:3, 1:5), y = 2*(1:5))
stopifnot(dim(a2) == c(3,5,4), all.equal(a2, a.2),
          identical(dimnames(a2), list(NULL,NULL,LETTERS[1:4])))

hist(replicate(100, mean(rexp(10))))

## use of replicate() with parameters:
foo <- function(x = 1, y = 2) c(x, y)
# does not work: bar <- function(n, ...) replicate(n, foo(...))
bar <- function(n, x) replicate(n, foo(x = x))
bar(5, x = 3)

scale(state.x77,center=apply(state.x77,2,median),scale=apply(state.x77,2,mad) )

summfn=function(x)c(n=sum(!is.na(x)),mean=mean(x),sd=sd(x))
apply(state.x77,2,sumfun)

x=1:12
apply(matrix(x,ncol=3,byrow=TRUE),1,sum)

colMeans(USJudgeRatings)
rowSums(USJudgeRatings >=8)
page128
maxes=apply(state.x77,2,max)
swept=sweep(state.x77,2,maxes,"/")


perl -ne '/ERROR/&&print $.$_' f:/tpm1.log
 
awk '$0~/ERROR/{print NR $0}' f:/tpm1.log
cat f:\tpm1.log|grep "Error|ERROR|error"

page 134
maxeig = function(df) eigen(cor(df))$val[1]
frames = split(iris[-5],iris[5])
sapply(frames,maxeig)

tapply(1:nrow(iris),iris['Species'],function(ind,data)eigen(cor(data[ind,-5]))$val[1],data=iris)

max.e = by(iris,iris$Species,function(df)eigen(cor(df[-5]))$val[1])
as.data.frame(as.table(max.e))
sumfun = function(x)data.frame(n=length(x$uptake),mean=mean(x$uptake),sd=sd(x$uptake))
bb= by(C02,C02[c('Type','Treatment')],sumfun)

do.call(rbind,bb)

cbind(expand.grid(dimnames(bb)),do.call(rbind.bb))

1. How can I list just the names of matching fies?
grep -l ’main’ *.c
lists the names of all C fies in the current directory whose contents mention ‘main’.
2. How do I search directories recursively?
grep -r ’hello’ /home/gigi
searches for ‘hello’ in all fies under the /home/gigi directory. For more control
over which fies are searched, use find, grep, and xargs. For example, the following
command searches only C fies:
find /home/gigi -name ’*.c’ -print0 | xargs -0r grep -H ’hello’
This diffrs from the command:
grep -H ’hello’ *.c
which merely looks for ‘hello’ in all fies in the current directory whose names end in
‘.c’. The ‘find ... ’ command line above is more similar to the command:
grep -rH --include=’*.c’ ’hello’ /home/gigi
3. What if a pattern has a leading ‘-’?
grep -e ’--cut here--’ *
searches for all lines matching ‘--cut here--’. Without -e, grep would attempt to
parse ‘--cut here--’ as a list of options.
4. Suppose I want to search for a whole word, not a part of a word?
grep -w ’hello’ *
searches only for instances of ‘hello’ that are entire words; it does not match ‘Othello’.
For more control, use ‘\<’ and ‘\>’ to match the start and end of words. For example:
grep ’hello\>’ *
searches only for words ending in ‘hello’, so it matches the word ‘Othello’.
5. How do I output context around the matching lines?
grep -C 2 ’hello’ *
prints two lines of context around each matching line.
6. How do I force grep to print the name of the fie?
Append /dev/null:
grep ’eli’ /etc/passwd /dev/null
gets you:
/etc/passwd:eli:x:2098:1000:Eli Smith:/home/eli:/bin/bash
Alternatively, use -H, which is a GNU extension:
grep -H ’eli’ /etc/passwd
7. Why do people use strange regular expressions on ps output?
ps -ef | grep ’[c]ron’
If the pattern had been written without the square brackets, it would have matched
not only the ps output line for cron, but also the ps output line for grep. Note that
on some platforms, ps limits the output to the width of the screen; grep does not have
any limit on the length of a line except the available memory.
8. Why does grep report “Binary fie matches”?
If grep listed all matching “lines” from a binary fie, it would probably generate
output that is not useful, and it might even muck up your display. So GNU
grep suppresses output from fies that appear to be binary fies. To force GNU
grep to output lines even from fies that appear to be binary, use the -a or
‘--binary-files=text’ option. To eliminate the “Binary fie matches” messages, use
the -I or ‘--binary-files=without-match’ option.
9. Why doesn’t ‘grep -lv’ print non-matching fie names?
‘grep -lv’ lists the names of all fies containing one or more lines that do not match.
To list the names of all fies that contain no matching lines, use the -L or --files
without-match option.
10. I can do “OR” with ‘| ’, but what about “AND”?
grep ’paul’ /etc/motd | grep ’franc,ois’
fids all lines that contain both ‘paul’ and ‘franc,ois’.
11. Why does the empty pattern match every input line?
The grep command searches for lines that contain strings that match a pattern. Every
line contains the empty string, so an empty pattern causes grep to fid a match on
each line. It is not the only such pattern: ‘^’, ‘$’, ‘.*’, and many other patterns cause
grep to match every line.
To match empty lines, use the pattern ‘^$’. To match blank lines, use the pattern
‘^[[:blank:]]*$’. To match no lines at all, use the command ‘grep -f /dev/null’.
12. How can I search in both standard input and in fies?
Use the special fie name ‘-’:
cat /etc/passwd | grep ’alain’ - /etc/motd
13. How to express palindromes in a regular expression?
It can be done by using back-references; for example, a palindrome of 4 characters can
be written with a BRE:
grep -w -e ’\(.\)\(.\).\2\1’ file
It matches the word “radar” or “civic.”
Guglielmo Bondioni proposed a single RE that fids all palindromes up to 19 characters
long using 9 subexpressions and 9 back-references:
grep -E -e ’^(.?)(.?)(.?)(.?)(.?)(.?)(.?)(.?)(.?).?\9\8\7\6\5\4\3\2\1$’ file
Note this is done by using GNU ERE extensions; it might not be portable to other
implementations of grep.
14. Why is this back-reference failing?
echo ’ba’ | grep -E ’(a)\1|b\1’
This gives no output, b ecause the fist alternate ‘(a)\1’ does not match, as there is
no ‘aa’ in the input, so the ‘\1’ in the second alternate has nothing to refer back to,
meaning it will never match anything. (The second alternate in this example can only
match if the fist alternate has matched—making the second one superflous.)
15. How can I match across lines?
Standard grep cannot do this, as it is fundamentally line-based. Therefore, merely
using the [:space:] character class does not match newlines in the way you might
expect.
With the GNU grep option -z (--null-data), each input “line” is terminated by a
null byte; see Section 2.1.7 [Other Options], page 8. Thus, you can match newlines in
the input, but typically if there is a match the entire input is output, so this usage is
often combined with output-suppressing options like -q, e.g.:
printf ’foo\nbar\n’ | grep -z -q ’foo[[:space:]]\+bar’
If this does not suffi, you can transform the input before giving it to grep, or turn
to awk, sed, perl, or many other utilities that are designed to operate across lines.
16. What do grep, fgrep, and egrep stand for?
The name grep comes from the way line editing was done on Unix. For example, ed
uses the following syntax to print a list of matching lines on the screen:
global/regular expression/print
g/re/p
fgrep stands for Fixed grep; egrep stands for Extended grep.


?cast
#Air quality example
names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)

cast(aqm, day ~ month ~ variable)
cast(aqm, month ~ variable, mean)
cast(aqm, month ~ . | variable, mean)
cast(aqm, month ~ variable, mean, margins=c("grand_row", "grand_col"))
cast(aqm, day ~ month, mean, subset=variable=="ozone")
cast(aqm, month ~ variable, range)
cast(aqm, month ~ variable + result_variable, range)
cast(aqm, variable ~ month ~ result_variable,range)

#Chick weight example
names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)

cast(chick_m, time ~ variable, mean) # average effect of time
cast(chick_m, diet ~ variable, mean) # average effect of diet
cast(chick_m, diet ~ time ~ variable, mean) # average effect of diet & time

# How many chicks at each time? - checking for balance
cast(chick_m, time ~ diet, length)
cast(chick_m, chick ~ time, mean)
cast(chick_m, chick ~ time, mean, subset=time < 10 & chick < 20)

cast(chick_m, diet + chick ~ time)
cast(chick_m, chick ~ time ~ diet)
cast(chick_m, diet + chick ~ time, mean, margins="diet")

#Tips example
cast(melt(tips), sex ~ smoker, mean, subset=variable=="total_bill")
cast(melt(tips), sex ~ smoker | variable, mean)

ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
cast(ff_d, subject ~ time, length)
cast(ff_d, subject ~ time, length, fill=0)
cast(ff_d, subject ~ time, function(x) 30 - length(x))
cast(ff_d, subject ~ time, function(x) 30 - length(x), fill=30)
cast(ff_d, variable ~ ., c(min, max))
cast(ff_d, variable ~ ., function(x) quantile(x,c(0.25,0.5)))
cast(ff_d, treatment ~ variable, mean, margins=c("grand_col", "grand_row"))
cast(ff_d, treatment + subject ~ variable, mean, margins="treatment")

我似朝露降人世，转去匆匆瞬即逝

library(caTools)
x <- y <- seq(-4*pi, 4*pi, len=200)
r <- sqrt(outer(x^2, y^2, "+"))
image = array(0, c(200, 200, 10))
for(i in 1:10) image[,,i] = cos(r-(2*pi*i/10))/(r^.25)
write.gif(image, "e:/wave.gif", col="rainbow")
y = read.gif("e:/wave.gif")
for(i in 1:10) image(y$image[,,i], col=y$col, breaks=(0:256)-0.5, asp=1)


x = "Hello R!!" # character
y = base64encode(x)
z = base64decode(y, typeof(x))
x = "bis6sp" # character
y = base64encode(x)
z = base64decode(y, typeof(x))


library(MASS)
data(cats) # 加载数据集
head(cats) # 打印前 6 行数据
colAUC(cats[,2:3], cats[,1], plotROC=TRUE)

4. 向量元素的无序组合
combs(v,k) 函数，用于创建无序的组合的矩阵，矩阵的列表示以几种元素进行组合，矩
阵的行表示每种不同的组合。参数 v 是向量； k 是数值，小于等于 v 的长度 [1:length(v)]。
> combs(2:5, 3)
[,1] [,2] [,3]
[1,] 2 3 4
[2,] 2 3 5
[3,] 2 4 5
[4,] 3 4 5
> combs(c("cats", "dogs", "mice"), 2)
[,1] [,2]
[1,] "cats" "dogs"
[2,] "cats" "mice"
[3,] "dogs" "mice"
> a = combs(1:4, 2) # 快速组合构建矩阵
> a

> BJsales # 取 datasets::BJsales 数据集
Time Series:
Start = 1
End = 150
Frequency = 1
[1] 200.1 199.5 199.4 198.9 199.0 200.2 198.6 200.0 200.3 201.2 201.6 201.5
[13] 201.5 203.5 204.9 207.1 210.5 210.5 209.8 208.8 209.5 213.2 213.7 215.1
[25] 218.7 219.8 220.5 223.8 222.8 223.8 221.7 222.3 220.8 219.4 220.1 220.6
> plot(BJsales,col="black", lty=1,lwd=1, main = "Moving Window Means")
> lines(runmean(BJsales, 3), col="red", lty=2, lwd=2)
> lines(runmean(BJsales, 8), col="green", lty=3, lwd=2)
> lines(runmean(BJsales,15), col="blue", lty=4, lwd=2)
> lines(runmean(BJsales,24), col="magenta", lty=5, lwd=2)
> lines(runmean(BJsales,50), col="cyan", lty=6, lwd=2)

plot(BJsales,col="black", lty=1,lwd=1, main = "Moving Window Means")
lines(runmean(BJsales, 3), col="red", lty=2, lwd=2)
lines(runmean(BJsales, 8), col="green", lty=3, lwd=2)
lines(runmean(BJsales,15), col="blue", lty=4, lwd=2)
lines(runmean(BJsales,24), col="magenta", lty=5, lwd=2)
lines(runmean(BJsales,50), col="cyan", lty=6, lwd=2)
lines(runmin (BJsales,50), col="red",lty=1, lwd=1)
?runif


plot(x, main = "Moving Window Analysis Functions (window size=25)")
lines(runmin (x,k), col="red",lty=1, lwd=1)
lines(runmax (x,k), col="cyan",lty=1, lwd=1)
lines(runmean(x,k), col="blue",lty=1, lwd=1)
lines(runmed (x,k), col="green",lty=2, lwd=2)

plot(BS_table$close,col="black", lty=1,lwd=1, main = "Moving Window Means")
#lines(runmean(BS_table$close, 3), col="red", lty=2, lwd=2)
#lines(runmean(BS_table$close, 8), col="green", lty=3, lwd=2)
#lines(runmean(BS_table$close,15), col="blue", lty=4, lwd=2)
#lines(runmean(BS_table$close,24), col="magenta", lty=5, lwd=2)
#lines(runmean(BS_table$close,50), col="cyan", lty=6, lwd=2)
lines(runmin (BS_table$close,50), col="red",lty=1, lwd=1)
lines(runmax (BS_table$close,50), col="red",lty=1, lwd=1)



（ 1）基础对象
 zoo: 有序的时间序列对象。
 zooreg: 规则的时间序列对象，继承 zoo 对象。与 zoo 相比，不同之处在于 zooreg 要
求数据是连续的。
（ 2）类型转换
 as.zoo: 把一个对象转型为 zoo 类型。
 plot.zoo: 为 plot 函数提供 zoo 的接口。
 xyplot.zoo: 为 lattice 的 xyplot 函数提供 zoo 的接口。
 ggplot2.zoo: 为 ggplot2 包提供 zoo 的接口。
（ 3）数据操作
 coredata: 查看或编辑 zoo 的数据部分。
 index: 查看或编辑 zoo 的索引部分。
 window.zoo: 按时间过滤数据。
 merge.zoo: 合并多个 zoo 对象。
 read.zoo: 从文件读写 zoo 序列。
 aggregate.zoo: 计算 zoo 数据。
 rollapply: 对 zoo 数据的滚动处理。
 rollmean: 对 zoo 数据的滚动计算均值。
（ 4） NA 值处理
 na.fill: NA 值的填充。
 na.locf: 替换 NA 值。
 na.aggregate: 计算统计值替换 NA 值。
 na.approx: 计算插值替换 NA 值。
 na.StructTS: 计算季节 Kalman 滤波替换 NA 值。
 na.trim: 过滤有 NA 的记录。
（ 5）辅助工具
 is.regular: 检查是否是规则的序列。
 lag.zoo: 计算步长和差分。
 MATCH: 取交集。
 ORDER: 值排序，输出索引。
（ 6）显示控制
 yearqtr: 以年季度显示时间。
 yearmon: 以年月显示时间。
 xblocks: 作图沿 x 轴分割图形。
 make.par.list: 用于给 plot.zoo 和 xyplot.zoo 数据格式转换。

> x.Date <- as.Date("2003-02-01") + c(1, 3, 7, 9, 14) – 1 # 定义一个不连续的日期的向量
> x.Date
[1] "2003-02-01" "2003-02-03" "2003-02-07" "2003-02-09" "2003-02-14"
> class(x.Date)
[1] "Date"
> x <- zoo(rnorm(5), x.Date) # 定义不连续的 zoo 对象
> x
2003-02-01 2003-02-03 2003-02-07 2003-02-09 2003-02-14
0.01964254 0.03122887 0.64721059 1.47397924 1.29109889
> class(x)
[1] "zoo"
> plot(x) # 画图显示

> x.Date <- as.Date("2003-02-01") + c(1, 3, 7, 9, 14) – 1 # 定义一个不连续的日期的向量
> x.Date
[1] "2003-02-01" "2003-02-03" "2003-02-07" "2003-02-09" "2003-02-14"
> class(x.Date)
[1] "Date"
> x <- zoo(rnorm(5), x.Date) # 定义不连续的 zoo 对象
> x
2003-02-01 2003-02-03 2003-02-07 2003-02-09 2003-02-14
0.01964254 0.03122887 0.64721059 1.47397924 1.29109889
> class(x)
[1] "zoo"
> plot(x) # 画图显示

> y <- zoo(matrix(1:12, 4, 3),0:10)
> y
0 1 5 9
1 2 6 10
2 3 7 11
3 4 8 12
 frequency: 每个时间单元显示的数量。
 deltat: 连续观测的采样周期，不能与 frequency 同时出现，例如，取每月的数据，为
1/12。
 ts.eps: 时间序列间隔，当数据时间间隔小于 ts.eps 时，使用 ts.eps 作为时间间隔。通
过 getOption(“ ts.eps” ) 设置，默认是 1e-05。
 order.by: 索引部分，字段唯一性要求，用于排序 , 继承 zoo 的 order.by。
以下代码构建一个 zooreg 对象，以连续的年（季度）时间为索引，产生的结果是

> zooreg(1:10, frequency = 4, start = c(1959, 2))
1959(2) 1959(3) 1959(4) 1960(1) 1960(2) 1960(3) 1960(4) 1961(1) 1961(2) 1961(3)
1 2 3 4 5 6 7 8 9 10
> as.zoo(ts(1:10, frequency = 4, start = c(1959, 2)))
1959(2) 1959(3) 1959(4) 1960(1) 1960(2) 1960(3) 1960(4) 1961(1) 1961(2) 1961(3)
1 2 3 4 5 6 7 8 9 10
> zr<-zooreg(rnorm(10), frequency = 4, start = c(1959, 2))
> plot(zr)

3. zoo 对象与 zooreg 对象的区别
zoo 对象与 zooreg 对象的区别体现在计算步长和差分方面。
 lag（步长）： zoo 根据索引计算， zooreg 根据值计算。
 diff（差分）： zoo 根据索引计算， zooreg 根据值计算。
例如，对同一组值不连续的数据 (1, 2, 3, 6, 7, 8)，二者的计算结果如下。
> x <- c(1, 2, 3, 6, 7, 8)
> zz <- zoo(x, x)
> zr <- as.zooreg(zz)
> lag(zz, k = -1) # 计算步长
2 3 6 7 8
1 2 3 6 7
> lag(zr, k = -1)
2 3 4 7 8 9
1 2 3 6 7 8
> diff(zz) # 计算差分
2 3 6 7 8
1 1 3 1 1
> diff(zr)
2 3 7 8
1 1 1 1


4. zoo 对象的类型转换
首先，把对象从其他类型转型到 zoo 类型。
> as.zoo(rnorm(5)) # 把一个基本类型的向量转型到 zoo 类型
1 2 3 4 5
-0.4892119 0.5740950 0.7128003 0.6282868 1.0289573
> as.zoo(ts(rnorm(5), start = 1981, freq = 12))
1981(1) 1981(2) 1981(3) 1981(4) 1981(5)
2.3198504 0.5934895 -1.9375893 -1.9888237 1.0944444
> x <- as.zoo(ts(rnorm(5), start = 1981, freq = 12)); x # 把一个 ts 类型转型到 zoo 类型
1981(1) 1981(2) 1981(3) 1981(4) 1981(5)
1.8822996 1.6436364 0.1260436 -2.0360960 -0.1387474
其次，把对象从 zoo 类型转型到其他类型。
> as.matrix(x) # 把 zoo 类型，转型到矩阵

5. 用 ggplot2 画时间序列
由 于 ggplot2 不 支 持 zoo 类 型 的 数 据， 因 此 需 要 通 过 ggplot2::fortify() 函 数， 调 用
zoo::fortify.zoo() 函数，把 zoo 类型转换成 ggplot2 可识别的类型后， ggplot2 才可以对 zoo
类型数据的画图。以下代码用 ggplot2 画 zoo 类型的时间序列图，产生的结果是图 2-4。
> library(ggplot2) # 加载 ggplot2 包
> library(scales)
> x.Date <- as.Date(paste(2003, 02, c(1, 3, 7, 9, 14), sep = "-")) # 构建数据对象
> x <- zoo(rnorm(5), x.Date)
> xlow <- x - runif(5)
> xhigh <- x + runif(5)
> z <- cbind(x, xlow, xhigh)
> z # 显示数据集
x xlow xhigh
2003-02-01 -0.36006612 -0.88751958 0.006247816
2003-02-03 1.35216617 0.97892538 2.076360524
2003-02-07 0.61920828 0.23746410 1.156569424
2003-02-09 0.27516116 0.09978789 0.777878867
2003-02-14 0.02510778 -0.80107410 0.541592929
# 对 zoo 类型的数据，用 fortify() 转换成 data.frame 类型
5. 用 ggplot2 画时间序列
由 于 ggplot2 不 支 持 zoo 类 型 的 数 据， 因 此 需 要 通 过 ggplot2::fortify() 函 数， 调 用
zoo::fortify.zoo() 函数，把 zoo 类型转换成 ggplot2 可识别的类型后， ggplot2 才可以对 zoo
类型数据的画图。以下代码用 ggplot2 画 zoo 类型的时间序列图，产生的结果是图 2-4。
> library(ggplot2) # 加载 ggplot2 包
> library(scales)
> x.Date <- as.Date(paste(2003, 02, c(1, 3, 7, 9, 14), sep = "-")) # 构建数据对象
> x <- zoo(rnorm(5), x.Date)
> xlow <- x - runif(5)
> xhigh <- x + runif(5)
> z <- cbind(x, xlow, xhigh)
> z # 显示数据集
x xlow xhigh
2003-02-01 -0.36006612 -0.88751958 0.006247816
2003-02-03 1.35216617 0.97892538 2.076360524
2003-02-07 0.61920828 0.23746410 1.156569424
2003-02-09 0.27516116 0.09978789 0.777878867
2003-02-14 0.02510778 -0.80107410 0.541592929
# 对 zoo 类型的数据，用 fortify() 转换成 data.frame 类型
> g<-ggplot(aes(x = Index, y = Value), data = fortify(x, melt = TRUE))
> g<-g+geom_line()
> g<-g+geom_line(aes(x = Index, y = xlow), colour = "red", data = fortify(xlow))
> g<-g+geom_ribbon(aes(x = Index, y = x, ymin = xlow, ymax = xhigh), data =
fortify(x), fill = "darkgray")
> g<-g+geom_line()
> g<-g+xlab("Index") + ylab("x")
> g
图 2-4　用 ggplot2 画的时间序列图
6. zoo 对象的数据操作
使用 coredata() 函数修改 zoo 类型的数据部分。
> x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
> x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
> coredata(x) # 查看数据部分
[,1] [,2]
[1,] -1.04571765 0.92606273
[2,] -0.89621126 0.03693769
[3,] 1.26938716 -1.06620017

> coredata(x) <- matrix(1:20, ncol = 2) # 修改数据部分
> x # 查看修改后的数据集
2003-01-01 1 11
2003-01-03 2 12
2003-01-05 3 13
2003-01-07 4 14
2003-02-09 5 15
2003-02-11 6 16
2003-02-13 7 17
2003-03-15 8 18
2003-03-17 9 19
2003-04-19 10 20

使用 index() 函数修改 zoo 类型的索引部分。
> x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
> x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
> index(x) # 查看索引部分
[1] "2003-01-01" "2003-01-03" "2003-01-05" "2003-01-07" "2003-02-09"
[6] "2003-02-11" "2003-02-13" "2003-03-15" "2003-03-17" "2003-04-19"
> index(x) <- 1:nrow(x) # 修改索引部分
> index(x) # 查看修改后的索引部分
[1] 1 2 3 4 5 6 7 8 9 10
使用 window.zoo() 函数按时间过滤数据。
> x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
> x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
> window(x, start = as.Date("2003-02-01"), end = as.Date("2003-03-01"))
# 取日期从 2003-02-01 到 2003-03-01 之间的数据
2003-02-09 0.7021167 -0.3073809
2003-02-11 2.5071111 0.6210542
2003-02-13 -1.8900271 0.1819022
> window(x, index = x.date[1:6], start = as.Date("2003-02-01"))
# 取日期从 2003-02-01 开始的，且索引日期在 x.date[1:6] 中的数据
2003-02-09 0.7021167 -0.3073809
2003-02-11 2.5071111 0.6210542

使用 index() 函数修改 zoo 类型的索引部分。
> x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
> x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
> index(x) # 查看索引部分
[1] "2003-01-01" "2003-01-03" "2003-01-05" "2003-01-07" "2003-02-09"
[6] "2003-02-11" "2003-02-13" "2003-03-15" "2003-03-17" "2003-04-19"
> index(x) <- 1:nrow(x) # 修改索引部分
> index(x) # 查看修改后的索引部分
[1] 1 2 3 4 5 6 7 8 9 10
使用 window.zoo() 函数按时间过滤数据。
> x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
> x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
> window(x, start = as.Date("2003-02-01"), end = as.Date("2003-03-01"))
# 取日期从 2003-02-01 到 2003-03-01 之间的数据
2003-02-09 0.7021167 -0.3073809
2003-02-11 2.5071111 0.6210542
2003-02-13 -1.8900271 0.1819022
> window(x, index = x.date[1:6], start = as.Date("2003-02-01"))
# 取日期从 2003-02-01 开始的，且索引日期在 x.date[1:6] 中的数据
2003-02-09 0.7021167 -0.3073809
2003-02-11 2.5071111 0.6210542

使用 merge.zoo() 合并多个 zoo 对象。
> y1 <- zoo(matrix(1:10, ncol = 2), 1:5);y1 # 创建 2 个 zoo 数据
1 1 6
2 2 7
3 3 8
4 4 9
5 5 10
> y2 <- zoo(matrix(rnorm(10), ncol = 2), 3:7);y2
3 1.4810127 0.13575871
4 -0.3914258 0.06404148
5 0.6018237 1.85017952
6 1.2964150 -0.12927481
7 0.2211769 0.32381709
> merge(y1, y2, all = FALSE) # 以相同的索引值合并数据
y1.1 y1.2 y2.1 y2.2
3 3 8 0.9514985 1.7238941
4 4 9 -1.1131230 -0.2061446
5 5 10 0.6169665 -1.3141951
> merge(y1, y2, all = FALSE, suffixes = c("a", "b")) # 自定义数据列的名字
a.1 a.2 b.1 b.2
3 3 8 0.9514985 1.7238941
4 4 9 -1.1131230 -0.2061446
5 5 10 0.6169665 -1.3141951
> merge(y1, y2, all = TRUE) # 合并完整的数据集，空数据默认以 NA 填充
y1.1 y1.2 y2.1 y2.2
1 1 6 NA NA
2 2 7 NA NA
3 3 8 0.9514985 1.7238941
4 4 9 -1.1131230 -0.2061446
5 5 10 0.6169665 -1.3141951
6 NA NA 0.5134937 0.0634741
7 NA NA 0.3694591 -0.2319775
> merge(y1, y2, all = TRUE, fill = 0) # 合并完整的数据集，空数据以 0 填充
y1.1 y1.2 y2.1 y2.2
1 1 6 0.0000000 0.0000000
2 2 7 0.0000000 0.0000000

使用 aggregate.zoo() 函数对 zoo 数据进行计算。
> x.date <- as.Date(paste(2004, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
# 创建 zoo 类型数据集 x
> x <- zoo(rnorm(12), x.date); x
2004-01-01 2004-01-03 2004-01-05 2004-01-07 2004-02-09 2004-02-11
0.67392868 1.95642526 -0.26904101 -1.24455152 -0.39570292 0.09739665
2004-02-13 2004-03-15 2004-03-17 2004-04-19
-0.23838695 -0.41182796 -1.57721805 -0.79727610
> x.date2 <- as.Date(paste(2004, rep(1:4, 4:1), 1, sep = "-")); x.date2
# 创建时间向量 x.date2
[1] "2004-01-01" "2004-01-01" "2004-01-01" "2004-01-01" "2004-02-01"
[6] "2004-02-01" "2004-02-01" "2004-03-01" "2004-03-01" "2004-04-01"
> x2 <- aggregate(x, x.date2, mean); x2 # 计算 x 以 x.date2 为时间分割规则的均值
2004-01-01 2004-02-01 2004-03-01 2004-04-01
0.2791904 -0.1788977 -0.9945230 -0.7972761

7. zoo 对象数据函数化处理
使用 rollapply() 函数对 zoo 数据进行函数化处理。
> z <- zoo(11:15, as.Date(31:35))
> rollapply(z, 2, mean) # 从起始日开始，计算连续 2 日的均值
1970-02-01 1970-02-02 1970-02-03 1970-02-04
11.5 12.5 13.5 14.5
> rollapply(z, 3, mean) # 从起始日开始，计算连续 3 日的均值
1970-02-02 1970-02-03 1970-02-04
12 13 14
等价操作变换：用 rollapply() 实现 aggregate() 的操作。
> z2 <- zoo(rnorm(6))
> rollapply(z2, 3, mean, by = 3) # means of nonoverlapping groups of 3
2 5
-0.3065197 0.6350963
> aggregate(z2, c(3,3,3,6,6,6), mean) # same
3 6
-0.3065197 0.6350963
等价操作变换：用 rollapply() 实现 rollmean() 的操作。
> rollapply(z2, 3, mean) # uses rollmean which is optimized for mean
2 3 4 5
-0.3065197 -0.7035811 -0.1672344 0.6350963
> rollmean(z2, 3) # same
2 3 4 5
-0.3065197 -0.7035811 -0.1672344 0.6350963


8. NA 值处理
使用 na.fill() 函数进行 NA 填充。
> z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA));z # 创建有 NA 值的 zoo 对象
1 2 3 4 5 6 7 8
NA 2 NA 3 4 5 9 NA
> na.fill(z, "extend") # 用 extend 的方法，填充 NA 值，即 NA 前后项的均值填充
1 2 3 4 5 6 7 8
2.0 2.0 2.5 3.0 4.0 5.0 9.0 9.0
> na.fill(z, -(1:3)) # 自定义填充 NA 值，即 -(1:3) 循环填充
1 2 3 4 5 6 7 8
-1 2 -2 3 4 5 9 -3
> na.fill(z, c("extend", NA)) # 用 extend，配合自定义的方法，即 extend 和自定义规则循环填充
1 2 3 4 5 6 7 8
2 2 NA 3 4 5 9 9
使用 na.locf() 函数进行 NA 替换。
> z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA, 11));z
1 2 3 4 5 6 7 8 9
NA 2 NA 3 4 5 9 NA 11
> na.locf(z) # 用 NA 的前一项的值，替换 NA 值
2 3 4 5 6 7 8 9
2 2 3 4 5 9 9 11
> na.locf(z, fromLast = TRUE) # 用 NA 的后一项的值，替换 NA 值
1 2 3 4 5 6 7 8 9
2 2 3 3 4 5 9 11 11
使用 na.aggregate() 函数的统计计算的值替换 NA 值。
> z <- zoo(c(1, NA, 3:9),c(as.Date("2010-01-01") + 0:2,as.Date("2010-02-01") +
0:2,as.Date("2011-01-01") + 0:2));z

2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01
1 NA 3 4 5 6 7
2011-01-02 2011-01-03
8 9
> na.aggregate(z) # 计算排除 NA 的其他项的均值，替换 NA 值
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01
1.000 5.375 3.000 4.000 5.000 6.000 7.000
2011-01-02 2011-01-03
8.000 9.000
> na.aggregate(z, as.yearmon) # 以索引的年月分组的均值，替换 NA 值
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01
1 2 3 4 5 6 7
2011-01-02 2011-01-03
8 9
> na.aggregate(z, months) # 以索引的月份分组的均值，替换 NA 值
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01
1.0 5.6 3.0 4.0 5.0 6.0 7.0
2011-01-02 2011-01-03
8.0 9.0
> na.aggregate(z, format, "%Y") # 以正则表示的索引的年份分组的均值，替换 NA 值
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01
1.0 3.8 3.0 4.0 5.0 6.0 7.0
2011-01-02 2011-01-03
8.0 9.0
使用 na.approx() 函数计算插值替换 NA 值。
> z <- zoo(c(2, NA, 1, 4, 5, 2), c(1, 3, 4, 6, 7, 8));z
1 3 4 6 7 8
2 NA 1 4 5 2
> na.approx(z)
1 3 4 6 7 8
2.000000 1.333333 1.000000 4.000000 5.000000 2.000000
> na.approx(z, 1:6)
1 3 4 6 7 8
2.0 1.5 1.0 4.0 5.0 2.0
使用 na.StructTS() 函数计算季节 Kalman 滤波替换 NA 值，产生的结果是图 2-5。
> z <- zooreg(rep(10 * seq(4), each = 4) + rep(c(3, 1, 2, 4), times = 4),
start = as.yearqtr(2000), freq = 4)
> z[10] <- NA
> zout <- na.StructTS(z);zout
> plot(cbind(z, zout), screen = 1, col = 1:2, type = c("l", "p"), pch = 20)
图 2-5　替换 NA 值的时间序列
使用 na.trim() 函数，去掉有 NA 的行。
> xx <- zoo(matrix(c(1, 4, 6, NA, NA, 7), 3), c(2, 4, 6));xx
2 1 NA
4 4 NA
6 6 7
> na.trim(xx)
6 6 7
9. 数据显示格式
以“年 + 季度”格式输出
> x <- as.yearqtr(2000 + seq(0, 7)/4);x # 以年季默认格式输出
[1] "2000 Q1" "2000 Q2" "2000 Q3" "2000 Q4" "2001 Q1" "2001 Q2" "2001 Q3"
[8] "2001 Q4"
> format(x, "%Y Quarter %q") # 以年季自定义格式输出
[1] "2000 Quarter 1" "2000 Quarter 2" "2000 Quarter 3" "2000 Quarter 4"
[5] "2001 Quarter 1" "2001 Quarter 2" "2001 Quarter 3" "2001 Quarter 4"
> as.yearqtr("2001 Q2")

[1] "2001 Q2"
> as.yearqtr("2001 q2")
[1] "2001 Q2"
> as.yearqtr("2001-2")
[1] "2001 Q2"
以“年 + 月份”格式输出
> x <- as.yearmon(2000 + seq(0, 23)/12) ;x # 以年月默认格式输出
[1] " 一月  2000" " 二月  2000" " 三月  2000" " 四月  2000" " 五月  2000"
[6] " 六月  2000" " 七月  2000" " 八月  2000" " 九月  2000" " 十月  2000"
[11] " 十一月  2000" " 十二月  2000" " 一月  2001" " 二月  2001" " 三月  2001"
[16] " 四月  2001" " 五月  2001" " 六月  2001" " 七月  2001" " 八月  2001"
[21] " 九月  2001" " 十月  2001" " 十一月  2001" " 十二月  2001"
> as.yearmon("mar07", "%b%y")
[1] NA
> as.yearmon("2007-03-01")
[1] " 三月  2007"
> as.yearmon("2007-12")
[1] " 十二月  2007"

> set.seed(0)
> flow <- ts(filter(rlnorm(200, mean = 1), 0.8, method = "r"))
> rgb <- hcl(c(0, 0, 260), c = c(100, 0, 100), l = c(50, 90, 50), alpha = 0.3)
> plot(flow)
> xblocks(flow > 30, col = rgb[1]) ## high values red
> xblocks(flow < 15, col = rgb[3]) ## low value blue
> xblocks(flow >= 15 & flow <= 30, col = rgb[2]) ## the rest gray
11. 从文件读入时间序列数据创建 zoo 对象
我们首先创建一个文件，并将其命名为 read.csv，代码如下。
~ vi read.csv
2003-01-01,1.0073644,0.05579711
2003-01-03,-0.2731580,0.06797239
2003-01-05,-1.3096795,-0.20196174
2003-01-07,0.2225738,-1.15801525
2003-02-09,1.1134332,-0.59274327
2003-02-11,0.8373944,0.76606538
2003-02-13,0.3145168,0.03892812
2003-03-15,0.2222181,0.01464681
2003-03-17,-0.8436154,-0.18631697
2003-04-19,0.4438053,1.40059083
然后读入文件并生成 zoo 序列。
> r <- read.zoo(file="read.csv",sep = ",", format = "%Y-%m-%d")  # 以 zoo 格式读入数据
> r # 查看数据
V2 V3
2003-01-01 1.0073644 0.05579711
2003-01-03 -0.2731580 0.06797239
2003-01-05 -1.3096795 -0.20196174
2003-01-07 0.2225738 -1.15801525
2003-02-09 1.1134332 -0.59274327
2003-02-11 0.8373944 0.76606538
2003-02-13 0.3145168 0.03892812
2003-03-15 0.2222181 0.01464681
2003-03-17 -0.8436154 -0.18631697
2003-04-19 0.4438053 1.40059083
> class(r) # 查看数据类型
[1] "zoo"
我们已经完全掌握了 zoo 库及 zoo 对象的使用，接下来就可以放手去用 R 处理时间序
列数据了！
1. xts 数据结构
xts 扩展 zoo 的基础结构，由 3 部分组成，如图 2-7 所示。
 索引部分：时间类型向量。
 数据部分：以矩阵为基础类型，支持可以与矩阵相互转换的任何类型。
 属性部分：附件信息，包括时区和索引时间类型的格式等。

内部存储是一个时
间向量！
任何矩阵类型 包括隐藏属性和用户属性
.indexCLASS, indexFORMAT,
indexTZ,. CLASS,index
索引 数据 属性
Index Matrix Attr
图 2-7 xts 数据结构

2. xts 的 API 介绍
（ 1） xts 基础
 xts: 定义 xts 数据类型，继承 zoo 类型。
 coredata.xts: 查看或编辑 xts 对象的数据部分。
 xtsAttributes: 查看或编辑 xts 对象的属性部分。
 [.xts]: 用 [] 语法，取数据子集。
 dimnames.xts: 查看或编辑 xts 维度名。
 sample_matrix: 测试数据集，包括 180 条 xts 对象的记录， matrix 类型。
 xtsAPI: C 语言 API 接口。
（ 2）类型转换
 as.xts: 转换对象到 xts(zoo) 类型。
 as.xts.methods: 转换对象到 xts 函数。
 plot.xts: 为 plot 函数提供 xts 的接口作图。
 .parseISO8601: 把字符串 (ISO8601 格式 ) 输出为 POSIXct 类型的，包括开始时间和
结束时间的 list 对象。
 firstof: 创建一个开始时间， POSIXct 类型。
 lastof: 创建一个结束时间， POSIXct 类型。
 indexClass: 取索引类型。
 .indexDate: 索引的日期。
 .indexday: 索引的日期，同 .indexDate。
 .indexyday: 索引的年 ( 日 ) 值。
 .indexmday: 索引的月 ( 日 ) 值。
 .indexwday: 索引的周 ( 日 ) 值。
 .indexweek: 索引的周值。
 .indexmon: 索引的月值。
 .indexyear: 索引的年值。
 .indexhour: 索引的时值。
 .indexmin: 索引的分值。
 .indexsec: 索引的秒值。
（ 3）数据处理
 align.time: 以下一个时间对齐数据，秒，分钟，小时。
 endpoints: 按时间单元提取索引数据。
 merge.xts: 合并多个 xts 对象，重写 zoo::merge.zoo 函数。
 rbind.xts: 数据按行合并，为 rbind 函数提供 xts 的接口。
 split.xts: 数据分割，为 split 函数，提供 xts 的接口。
 na.locf.xts: 替换 NA 值，重写 zoo:na.locf 函数。
（ 4）数据统计
 apply.daily: 按日分割数据，执行函数。
 apply.weekly: 按周分割数据，执行函数。
 apply.monthly: 按月分割数据，执行函数。
 apply.quarterly: 按季分割数据，执行函数。
 apply.yearly: 按年分割数据，执行函数。
 to.period: 按期间分割数据。
 period.apply: 按期间执行自定义函数。
 period.max: 按期间计算最大值。
 period.min: 按期间计算最小值。
 period.prod: 按期间计算指数。
 period.sum: 按期间求和。
 nseconds: 计算数据集包括多少秒。
 nminutes: 计算数据集包括多少分。
 nhours: 计算数据集包括多少时。
 ndays: 计算数据集包括多少日。
 nweeks: 计算数据集包括多少周。
 nmonths: 计算数据集包括多少月。
 nquarters: 计算数据集包括多少季。
 nyears: 计算数据集包括多少年。
 periodicity: 查看时间序列的期间。
（ 5）辅助工具
 first: 从开始到结束设置条件取子集。
 last: 从结束到开始设置条件取子集。
 timeBased: 判断是否是时间类型。
 timeBasedSeq: 创建时间的序列。
 diff.xts: 计算步长和差分。
 isOrdered: 检查向量是否是顺序的。
 make.index.unique: 强制时间唯一，增加毫秒随机数。
 axTicksByTime: 计算 X 轴刻度标记位置按时间描述。
 indexTZ: 查询 xts 对象的时区。


> sample.xts <- as.xts(sample_matrix, descr='my new xts object')
# 创建一个 xts 对象，并设置属性 descr
> class(sample.xts) # xts 是继承 zoo 类型的对象
[1] "xts" "zoo"
> str(sample.xts) # 打印对象结构
An ' xts' object on 2007-01-02/2007-06-30 containing:
Data: num [1:180, 1:4] 50 50.2 50.4 50.4 50.2 ...
- attr(*, "dimnames")=List of 2
..$ : NULL
..$ : chr [1:4] "Open" "High" "Low" "Close"
Indexed by objects of class: [POSIXct,POSIXt] TZ:
xts Attributes:
List of 1
$ descr: chr "my new xts object"
> attr(sample.xts,'descr') # 查看对象的属性 descr
[1] "my new xts object"


在 [] 中，通过字符串匹配进行 xts 数据查询。
> head(sample.xts['2007']) # 选出 2007 年的数据
Open High Low Close
2007-01-02 50.03978 50.11778 49.95041 50.11778
2007-01-03 50.23050 50.42188 50.23050 50.39767
2007-01-04 50.42096 50.42096 50.26414 50.33236
2007-01-05 50.37347 50.37347 50.22103 50.33459
2007-01-06 50.24433 50.24433 50.11121 50.18112
2007-01-07 50.13211 50.21561 49.99185 49.99185
> head(sample.xts['2007-03/']) # 选出 2007 年 03 月的数据
Open High Low Close
2007-03-01 50.81620 50.81620 50.56451 50.57075
2007-03-02 50.60980 50.72061 50.50808 50.61559
2007-03-03 50.73241 50.73241 50.40929 50.41033
2007-03-04 50.39273 50.40881 50.24922 50.32636
2007-03-05 50.26501 50.34050 50.26501 50.29567
2007-03-06 50.27464 50.32019 50.16380 50.16380
> head(sample.xts['2007-03-06/2007']) # 选出 2007 年 03 月 06 日到 2007 年的数据
Open High Low Close
2007-03-06 50.27464 50.32019 50.16380 50.16380
2007-03-07 50.14458 50.20278 49.91381 49.91381

2007-03-08 49.93149 50.00364 49.84893 49.91839
2007-03-09 49.92377 49.92377 49.74242 49.80712
2007-03-10 49.79370 49.88984 49.70385 49.88698
2007-03-11 49.83062 49.88295 49.76031 49.78806
> sample.xts['2007-01-03'] # 选出 2007 年 01 月 03 日的数据
Open High Low Close
2007-01-03 50.2305 50.42188 50.2305 50.39767
2. 用 xts 对象画图
用 xts 对象可以画曲线图（图 2-8）和 K 线图（图 2-9），下面是产生这两种图的代码，
首先是曲线图：
> data(sample_matrix)
> plot(as.xts(sample_matrix))
Warning message:
In plot.xts(as.xts(sample_matrix)) :
only the univariate series will be plotted
警告信息提示，只有单变量序列将被绘制，即只画出第一列数据 sample_matrix[,1] 的
曲线。

> plot(as.xts(sample_matrix), type='candles') # 画 K 线图
3. xts 对象的类型转换
创建首尾时间函数 firstof() 和 lastof()。
> firstof(2000) # 2000 年的第一天，时分秒显示省略
[1] "2000-01-01 CST"
> firstof(2005,01,01)
[1] "2005-01-01 CST"
> lastof(2007) # 2007 年的最后一天，最后一秒
[1] "2007-12-31 23:59:59.99998 CST"
> lastof(2007,10)
[1] "2007-10-31 23:59:59.99998 CST"
创建首尾时间。
> .parseISO8601('2000') # 以 ISO8601 格式，创建 2000 年首尾时间
$first.time
[1] "2000-01-01 CST"
$last.time
[1] "2000-12-31 23:59:59.99998 CST"
> .parseISO8601('2000-05/2001-02')

# 以 ISO8601 格式，创建 2000 年 05 月开始， 2001 年 02 月结束的时间
$first.time
[1] "2000-05-01 CST"
$last.time
[1] "2001-02-28 23:59:59.99998 CST"
> .parseISO8601('2000-01/02')
$first.time
[1] "2000-01-01 CST"
$last.time
[1] "2000-02-29 23:59:59.99998 CST"
> .parseISO8601('T08:30/T15:00')
$first.time
[1] "1970-01-01 08:30:00 CST"
$last.time
[1] "1970-12-31 15:00:59.99999 CST"



创建以时间类型为索引的 xts 对象。
> x <- timeBasedSeq('2010-01-01/2010-01-02 12:00') # 创建 POSIXt 类型时间
> head(x)
[1] "2010-01-01 00:00:00 CST"
[2] "2010-01-01 00:01:00 CST"
[3] "2010-01-01 00:02:00 CST"
[4] "2010-01-01 00:03:00 CST"
[5] "2010-01-01 00:04:00 CST"
[6] "2010-01-01 00:05:00 CST"
> class(x)
[1] "POSIXt" "POSIXct"
> x <- xts(1:length(x), x) # 以时间为索引创建 xts 对象
> head(x)
 [,1]
2010-01-01 00:00:00 1
2010-01-01 00:01:00 2
2010-01-01 00:02:00 3
2010-01-01 00:03:00 4
2010-01-01 00:04:00 5
2010-01-01 00:05:00 6
> indexClass(x)
[1] "POSIXt" "POSIXct"
格式化索引时间的显示。
> indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3" # 通过正则格式化索引的时间显示
> head(x)
 [,1]
 
 2010- 一月 -01 00:00:00.000 1
2010- 一月 -01 00:01:00.000 2
2010- 一月 -01 00:02:00.000 3
2010- 一月 -01 00:03:00.000 4
2010- 一月 -01 00:04:00.000 5
2010- 一月 -01 00:05:00.000 6
查看索引时间。
> .indexhour(head(x)) # 按小时取索引时间
[1] 0 0 0 0 0 0
> .indexmin(head(x)) # 按分钟取索引时间
[1] 0 1 2 3 4 5
4. xts 对象的数据处理
数据对齐。
> x <- Sys.time() + 1:30
> align.time(x, 10) # 整 10 秒对齐，秒位为 10 的整数倍
[1] "2013-11-18 15:42:30 CST" "2013-11-18 15:42:30 CST"
[3] "2013-11-18 15:42:30 CST" "2013-11-18 15:42:40 CST"
[5] "2013-11-18 15:42:40 CST" "2013-11-18 15:42:40 CST"
[7] "2013-11-18 15:42:40 CST" "2013-11-18 15:42:40 CST"
[29] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
> align.time(x, 60) # 整 60 秒对齐，秒位为 0，分位为整数
[1] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[3] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[5] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[7] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[9] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[11] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
按时间分割数据，并计算。
> xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
> apply.monthly(xts.ts,mean) # 按月计算均值，以每月的最后一日显示
[,1]
2007-01-31 0.17699984
2007-02-28 0.30734220
2007-03-31 -0.08757189
2007-04-30 0.18734688
2007-05-31 0.04496954
2007-06-30 0.06884836
2007-07-31 0.25081814
2007-08-19 -0.28845938

创建以时间类型为索引的 xts 对象。
> x <- timeBasedSeq('2010-01-01/2010-01-02 12:00') # 创建 POSIXt 类型时间
> head(x)
[1] "2010-01-01 00:00:00 CST"
[2] "2010-01-01 00:01:00 CST"
[3] "2010-01-01 00:02:00 CST"
[4] "2010-01-01 00:03:00 CST"
[5] "2010-01-01 00:04:00 CST"
[6] "2010-01-01 00:05:00 CST"
> class(x)
[1] "POSIXt" "POSIXct"
> x <- xts(1:length(x), x) # 以时间为索引创建 xts 对象
> head(x)
[,1]
2010-01-01 00:00:00 1
2010-01-01 00:01:00 2
2010-01-01 00:02:00 3
2010-01-01 00:03:00 4
2010-01-01 00:04:00 5
2010-01-01 00:05:00 6
> indexClass(x)
[1] "POSIXt" "POSIXct"

格式化索引时间的显示。
> indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3" # 通过正则格式化索引的时间显示
> head(x)
[,1]

2010- 一月 -01 00:00:00.000 1
2010- 一月 -01 00:01:00.000 2
2010- 一月 -01 00:02:00.000 3
2010- 一月 -01 00:03:00.000 4
2010- 一月 -01 00:04:00.000 5
2010- 一月 -01 00:05:00.000 6
查看索引时间。
> .indexhour(head(x)) # 按小时取索引时间
[1] 0 0 0 0 0 0
> .indexmin(head(x)) # 按分钟取索引时间
[1] 0 1 2 3 4 5
4. xts 对象的数据处理
数据对齐。
> x <- Sys.time() + 1:30
> align.time(x, 10) # 整 10 秒对齐，秒位为 10 的整数倍
[1] "2013-11-18 15:42:30 CST" "2013-11-18 15:42:30 CST"
[3] "2013-11-18 15:42:30 CST" "2013-11-18 15:42:40 CST"
[5] "2013-11-18 15:42:40 CST" "2013-11-18 15:42:40 CST"
[7] "2013-11-18 15:42:40 CST" "2013-11-18 15:42:40 CST"
[29] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
> align.time(x, 60) # 整 60 秒对齐，秒位为 0，分位为整数
[1] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[3] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[5] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[7] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[9] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
[11] "2013-11-18 15:43:00 CST" "2013-11-18 15:43:00 CST"
按时间分割数据，并计算。
> xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
> apply.monthly(xts.ts,mean) # 按月计算均值，以每月的最后一日显示
[,1]
2007-01-31 0.17699984
2007-02-28 0.30734220
2007-03-31 -0.08757189
2007-04-30 0.18734688
2007-05-31 0.04496954
2007-06-30 0.06884836
2007-07-31 0.25081814
2007-08-19 -0.28845938

> apply.monthly(xts.ts,function(x) var(x))
# 按月计算自定义函数 ( 方差 ) ，以每月的最后一日显示
[,1]
2007-01-31 0.9533217
2007-02-28 0.9158947
2007-03-31 1.2821450
2007-04-30 1.2805976
2007-05-31 0.9725438
2007-06-30 1.5228904
2007-07-31 0.8737030
2007-08-19 0.8490521
> apply.quarterly(xts.ts,mean) # 按季计算均值，以每季的最后一日显示
[,1]
2007-03-31 0.12642053
2007-06-30 0.09977926
2007-08-19 0.04589268
> apply.yearly(xts.ts,mean) # 按年计算均值，以年季的最后一日显示
[,1]
2007-08-19 0.09849522

使用 to.period() 函数按间隔分割数据。
> data(sample_matrix)
> to.period(sample_matrix) # 默认按月分割矩阵数据
 sample_matrix.Open sample_matrix.High sample_matrix.Low sample_matrix.Close
2007-01-31 50.03978 50.77336 49.76308 50.22578
2007-02-28 50.22448 51.32342 50.19101 50.77091
2007-03-31 50.81620 50.81620 48.23648 48.97490
2007-04-30 48.94407 50.33781 48.80962 49.33974
2007-05-31 49.34572 49.69097 47.51796 47.73780
2007-06-30 47.74432 47.94127 47.09144 47.76719
> class(to.period(sample_matrix))
[1] "matrix"
> samplexts <- as.xts(sample_matrix) # 默认按月分割 xts 类型数据
> to.period(samplexts)
 samplexts.Open samplexts.High samplexts.Low samplexts.Close
2007-01-31 50.03978 50.77336 49.76308 50.22578
2007-02-28 50.22448 51.32342 50.19101 50.77091
2007-03-31 50.81620 50.81620 48.23648 48.97490
2007-04-30 48.94407 50.33781 48.80962 49.33974
2007-05-31 49.34572 49.69097 47.51796 47.73780
2007-06-30 47.74432 47.94127 47.09144 47.76719
> class(to.period(samplexts))
[1] "xts" "zoo"

使用 endpoints() 函数，按间隔分割索引数据。
> data(sample_matrix)
> endpoints(sample_matrix) # 默认按月分割
[1] 0 30 58 89 119 150 180
> endpoints(sample_matrix, 'days',k=7) # 按每 7 日分割
 [1] 0 6 13 20 27 34 41 48 55 62 69 76 83 90 97 104 111 118 125
[20] 132 139 146 153 160 167 174 180
> endpoints(sample_matrix, 'weeks') # 按周分割
 [1] 0 7 14 21 28 35 42 49 56 63 70 77 84 91 98 105 112 119 126
[20] 133 140 147 154 161 168 175 180
> endpoints(sample_matrix, 'months') # 按月分割
[1] 0 30 58 89 119 150 180
使用 merge() 函数进行数据合并，按列合并。
> (x <- xts(4:10, Sys.Date()+4:10)) # 创建 2 个 xts 数据集
 [,1]
2013-11-22 4
2013-11-23 5
2013-11-24 6
2013-11-25 7
2013-11-26 8
2013-11-27 9
2013-11-28 10
> (y <- xts(1:6, Sys.Date()+1:6))
 [,1]
2013-11-19 1
2013-11-20 2
2013-11-21 3
2013-11-22 4
2013-11-23 5
2013-11-24 6
> merge(x,y) # 按列合并数据，空项以 NA 填空
 x y
2013-11-19 NA 1
2013-11-20 NA 2
2013-11-21 NA 3
2013-11-22 4 4
2013-11-23 5 5
2013-11-24 6 6
2013-11-25 7 NA
2013-11-26 8 NA
2013-11-27 9 NA
2013-11-28 10 NA
> merge(x,y, join='inner') # 按索引合并数据
x y
2013-11-22 4 4
2013-11-23 5 5
2013-11-24 6 6
> merge(x,y, join='left') # 以左侧为基础合并数据
x y
2013-11-22 4 4
2013-11-23 5 5
2013-11-24 6 6
2013-11-25 7 NA
2013-11-26 8 NA
2013-11-27 9 NA
2013-11-28 10 NA
使用 rbind() 函数进行数据合并，按行合并。
> x <- xts(1:3, Sys.Date()+1:3)
> rbind(x,x) # 按行合并数据
[,1]
2013-11-19 1
2013-11-19 1
2013-11-20 2
2013-11-20 2
2013-11-21 3
2013-11-21 3
使用 split() 函数进行数据切片，按行切片。
> data(sample_matrix)
> x <- as.xts(sample_matrix)
> split(x)[[1]] # 默认按月进行切片，打印第一个月的数据
Open High Low Close
2007-01-02 50.03978 50.11778 49.95041 50.11778
2007-01-03 50.23050 50.42188 50.23050 50.39767
2007-01-04 50.42096 50.42096 50.26414 50.33236
2007-01-05 50.37347 50.37347 50.22103 50.33459
2007-01-06 50.24433 50.24433 50.11121 50.18112
2007-01-07 50.13211 50.21561 49.99185 49.99185
2007-01-08 50.03555 50.10363 49.96971 49.98806
> split(x, f="weeks")[[1]] # 按周切片，打印前 1 周数据
Open High Low Close
2007-01-02 50.03978 50.11778 49.95041 50.11778
2007-01-03 50.23050 50.42188 50.23050 50.39767
2007-01-04 50.42096 50.42096 50.26414 50.33236
2007-01-05 50.37347 50.37347 50.22103 50.33459
2007-01-06 50.24433 50.24433 50.11121 50.18112
2007-01-07 50.13211 50.21561 49.99185 49.99185
2007-01-08 50.03555 50.10363 49.96971 49.98806
NA 值处理。
> x <- xts(1:10, Sys.Date()+1:10)
> x[c(1,2,5,9,10)] <- NA
> x
[,1]
2013-11-19 NA
2013-11-20 NA
2013-11-21 3
2013-11-22 4
2013-11-23 NA
2013-11-24 6
2013-11-25 7
2013-11-26 8
2013-11-27 NA
2013-11-28 NA
> na.locf(x) # 取 NA 的前一个，替换 NA 值
[,1]
2013-11-19 NA
2013-11-20 NA
2013-11-21 3
2013-11-22 4
2013-11-23 4
2013-11-24 6
2013-11-25 7
2013-11-26 8
2013-11-27 8
2013-11-28 8
> na.locf(x, fromLast=TRUE) # 取 NA 后一个，替换 NA 值
[,1]
2013-11-19 3
2013-11-20 3
2013-11-21 3
2013-11-22 4
2013-11-23 6
2013-11-24 6
2013-11-25 7

5. xts 对象的数据统计计算
对 xts 对象可以进行各种数据统计计算，比如取开始时间和结束时间，计算时间区间，
按期间计算统计指标。
（ 1）取 xts 对象的开始时间和结束时间，具体代码如下：
> xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
> start(xts.ts) # 取开始时间
[1] "2007-01-01"
> end(xts.ts) # 取结束时间
[1] "2007-08-19"
> periodicity(xts.ts) # 以日为单位，打印开始和结束时间
Daily periodicity from 2007-01-01 to 2007-08-19
（ 2）计算时间区间函数，具体代码如下：
> data(sample_matrix)
> ndays(sample_matrix) # 计算数据有多少日
[1] 180
> nweeks(sample_matrix) # 计算数据有多少周
[1] 26
> nmonths(sample_matrix) # 计算数据有多少月
[1] 6
> nquarters(sample_matrix) # 计算数据有多少季
[1] 2
> nyears(sample_matrix) # 计算数据有多少年
[1] 1
（ 3）按期间计算统计指标，具体代码如下：
> zoo.data <- zoo(rnorm(31)+10,as.Date(13514:13744,origin="1970-01-01"))
> ep <- endpoints(zoo.data,'weeks') # 按周获得期间索引
> ep
[1] 0 7 14 21 28 35 42 49 56 63 70 77 84 91 98 105 112 119
[19] 126 133 140 147 154 161 168 175 182 189 196 203 210 217 224 231
> period.apply(zoo.data, INDEX=ep, FUN=function(x) mean(x)) # 计算周的均值
2007-01-07 2007-01-14 2007-01-21 2007-01-28 2007-02-04 2007-02-11 2007-02-18
10.200488 9.649387 10.304151 9.864847 10.382943 9.660175 9.857894
2007-02-25 2007-03-04 2007-03-11 2007-03-18 2007-03-25 2007-04-01 2007-04-08
10.495037 9.569531 10.292899 9.651616 10.089103 9.961048 10.304860
2007-04-15 2007-04-22 2007-04-29 2007-05-06 2007-05-13 2007-05-20 2007-05-27

9.658432 9.887531 10.608082 9.747787 10.052955 9.625730 10.430030
2007-06-03 2007-06-10 2007-06-17 2007-06-24 2007-07-01 2007-07-08 2007-07-15
9.814703 10.224869 9.509881 10.187905 10.229310 10.261725 9.855776
2007-07-22 2007-07-29 2007-08-05 2007-08-12 2007-08-19
9.445072 10.482020 9.844531 10.200488 9.649387
> head(period.max(zoo.data, INDEX=ep)) # 计算周的最大值
[,1]
2007-01-07 12.05912
2007-01-14 10.79286
2007-01-21 11.60658
2007-01-28 11.63455
2007-02-04 12.05912
2007-02-11 10.67887
> head(period.min(zoo.data, INDEX=ep)) # 计算周的最小值
[,1]
2007-01-07 8.874509
2007-01-14 8.534655
2007-01-21 9.069773
2007-01-28 8.461555
2007-02-04 9.421085
2007-02-11 8.534655
> head(period.prod(zoo.data, INDEX=ep)) # 计算周的一个指数值
[,1]
2007-01-07 11140398
2007-01-14 7582350
2007-01-21 11930334
2007-01-28 8658933
2007-02-04 12702505
2007-02-11 7702767
6. xts 对象的时间序列操作
检查时间类型。
> class(Sys.time());timeBased(Sys.time()) # Sys.time() 是时间类型 POSIXct
[1] "POSIXct" "POSIXt"
[1] TRUE
> class(Sys.Date());timeBased(Sys.Date()) # Sys.Date() 是时间类型 Date
[1] "Date"
[1] TRUE
> class(20070101);timeBased(20070101) # 20070101 不是时间类型
[1] "numeric"
[1] FALSE
使用 timeBasedSeq() 函数创建时间序列。
> timeBasedSeq('1999/2008') # 按年
[1] "1999-01-01" "2000-01-01" "2001-01-01" "2002-01-01" "2003-01-01"
[6] "2004-01-01" "2005-01-01" "2006-01-01" "2007-01-01" "2008-01-01"
> head(timeBasedSeq('199901/2008')) # 按月
[1] " 十二月  1998" " 一月  1999" " 二月  1999" " 三月  1999" " 四月  1999"
[6] " 五月  1999"
> head(timeBasedSeq('199901/2008/d'),40) # 按日
[1] " 十二月  1998" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[6] " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[11] " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[16] " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[21] " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[26] " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999" " 一月  1999"
[31] " 一月  1999" " 一月  1999" " 二月  1999" " 二月  1999" " 二月  1999"
[36] " 二月  1999" " 二月  1999" " 二月  1999" " 二月  1999" " 二月  1999"
> timeBasedSeq('20080101 0830',length=100) # 按数量创建， 100 分钟的数据集
$from
[1] "2008-01-01 08:30:00 CST"
$to
[1] NA
$by
[1] "mins"
$length.out
[1] 100
按索引取数据 first() 和 last()。
> x <- xts(1:100, Sys.Date()+1:100)
> head(x)
[,1]
2013-11-19 1
2013-11-20 2
2013-11-21 3
2013-11-22 4
2013-11-23 5
2013-11-24 6
> first(x, 10) # 取前 10 条数据
[,1]
2013-11-19 1
2013-11-20 2
2013-11-21 3
2013-11-22 4
2013-11-23 5
2013-11-24 6
2013-11-25 7
2013-11-26 8
2013-11-27 9
2013-11-28 10
> first(x, '1 day') # 取 1 天的数据
[,1]
2013-11-19 1
> last(x, '1 weeks') # 取最后 1 周的数据
[,1]
2014-02-24 98
2014-02-25 99
2014-02-26 100
计算步长 lag() 和差分 diff()。
> x <- xts(1:5, Sys.Date()+1:5)
> lag(x) # 以 1 为步长
[,1]
2013-11-19 NA
2013-11-20 1
2013-11-21 2
2013-11-22 3
2013-11-23 4
> lag(x, k=-1, na.pad=FALSE) # 以 -1 为步长，并去掉 NA 值
[,1]
2013-11-19 2
2013-11-20 3
2013-11-21 4
2013-11-22 5
> diff(x) # 1 阶差分
[,1]
2013-11-19 NA
2013-11-20 1
2013-11-21 1
2013-11-22 1
2013-11-23 1
> diff(x, lag=2) # 2 阶差分
[,1]
2013-11-19 NA

2013-11-20 NA
2013-11-21 2
2013-11-22 2
2013-11-23 2
使用 isOrdered() 函数，检查向量是否排序好的。
> isOrdered(1:10, increasing=TRUE)
[1] TRUE
> isOrdered(1:10, increasing=FALSE)
[1] FALSE
> isOrdered(c(1,1:10), increasing=TRUE)
[1] FALSE
> isOrdered(c(1,1:10), increasing=TRUE, strictly=FALSE)
[1] TRUE
使用 make.index.unique() 函数，强制唯一索引。
> x <- xts(1:5, as.POSIXct("2011-01-21") + c(1,1,1,2,3)/1e3)
> x
[,1]
2011-01-21 00:00:00.000 1
2011-01-21 00:00:00.000 2
2011-01-21 00:00:00.000 3
2011-01-21 00:00:00.002 4
2011-01-21 00:00:00.003 5
> make.index.unique(x) # 增加毫秒级精度，保证索引的唯一性
[,1]
2011-01-21 00:00:00.000999 1
2011-01-21 00:00:00.001000 2
2011-01-21 00:00:00.001001 3
2011-01-21 00:00:00.002000 4
2011-01-21 00:00:00.003000 5
查询 xts 对象时区。
> x <- xts(1:10, Sys.Date()+1:10)
> indexTZ(x) # 时区查询
[1] "UTC"
> tzone(x)
[1] "UTC"
> str(x)
An ' xts'  object on 2013-11-19/2013-11-28 containing:
Data: int [1:10, 1] 1 2 3 4 5 6 7 8 9 10
Indexed by objects of class: [Date] TZ: UTC
xts Attributes:
NULL



计算步长 lag() 和差分 diff()。
> x <- xts(1:5, Sys.Date()+1:5)
> lag(x) # 以 1 为步长
[,1]
2013-11-19 NA
2013-11-20 1
2013-11-21 2
2013-11-22 3
2013-11-23 4
> lag(x, k=-1, na.pad=FALSE) # 以 -1 为步长，并去掉 NA 值
[,1]
2013-11-19 2
2013-11-20 3
2013-11-21 4
2013-11-22 5
> diff(x) # 1 阶差分
[,1]
2013-11-19 NA
2013-11-20 1
2013-11-21 1
2013-11-22 1
2013-11-23 1
> diff(x, lag=2) # 2 阶差分
[,1]
2013-11-19 NA

2013-11-20 NA
2013-11-21 2
2013-11-22 2
2013-11-23 2
使用 isOrdered() 函数，检查向量是否排序好的。
> isOrdered(1:10, increasing=TRUE)
[1] TRUE
> isOrdered(1:10, increasing=FALSE)
[1] FALSE
> isOrdered(c(1,1:10), increasing=TRUE)
[1] FALSE
> isOrdered(c(1,1:10), increasing=TRUE, strictly=FALSE)
[1] TRUE
使用 make.index.unique() 函数，强制唯一索引。
> x <- xts(1:5, as.POSIXct("2011-01-21") + c(1,1,1,2,3)/1e3)
> x
[,1]
2011-01-21 00:00:00.000 1
2011-01-21 00:00:00.000 2
2011-01-21 00:00:00.000 3
2011-01-21 00:00:00.002 4
2011-01-21 00:00:00.003 5
> make.index.unique(x) # 增加毫秒级精度，保证索引的唯一性
[,1]
2011-01-21 00:00:00.000999 1
2011-01-21 00:00:00.001000 2
2011-01-21 00:00:00.001001 3
2011-01-21 00:00:00.002000 4
2011-01-21 00:00:00.003000 5
查询 xts 对象时区。
> x <- xts(1:10, Sys.Date()+1:10)
> indexTZ(x) # 时区查询
[1] "UTC"
> tzone(x)
[1] "UTC"
> str(x)
An ' xts'  object on 2013-11-19/2013-11-28 containing:
Data: int [1:10, 1] 1 2 3 4 5 6 7 8 9 10
Indexed by objects of class: [Date] TZ: UTC
xts Attributes:
NULL

2.3.3 xtsExtra 包的使用
plot.xts() 函数的参数列表如下：
> names(formals(plot.xts))
[1] "x" "y" "screens" "layout.screens" "..."
[6] "yax.loc" "auto.grid" "major.ticks" "minor.ticks" "major.format"
[11] "bar.col.up" "bar.col.dn" "candle.col" "xy.labels" "xy.lines"
[16] "ylim" "panel" "auto.legend" "legend.names" "legend.loc"
[21] "legend.pars" "events" "blocks" "nc" "nr"

> data(sample_matrix)
> sample_xts <- as.xts(sample_matrix)
> plot(sample_xts[,1])
> class(sample_xts[,1])
[1] "xts" "zoo"
从图 2-10 似乎看不出 xtsExtra::plot.xts() 函数与 xts::plot.xts() 函数的不同效果。接下
来，我们画点稍微复杂的图形。
1. 画 K 线图
下面就来画 K 线图，默认红白配色，如图 2-11 所示。
> plot(sample_xts[1:30, ], type = "candles")

画 K 线图：自定义颜色，如图 2-12 所示。
> plot(sample_xts[1:30, ], type = "candles", bar.col.up = "blue", bar.col.dn =
"violet", candle.col = "green4")

 plot(sample_xts[,1:2])
 plot(sample_xts[,rep(1:4, each = 3)])
 plot(sample_xts[,1:4], layout.screens = matrix(c(1,1,1,1,2,3,4,4),ncol = 2,
 byrow = TRUE))
 
 3. 对 screens 配置
画双屏幕显示，每屏幕 2 条线，如图 2-16 所示。
> plot(sample_xts, screens = 1:2)
画双屏幕显示，指定曲线出现的屏幕和颜色，如图 2-17 所示。
> plot(sample_xts, screens = c(1,2,1,2), col = c(1,3,2,2))

plot(10^sample_xts, screens = 1:2, log= c("","y"))

 plot(sample_xts[1:75,1:2] - 50.5, type = c("l","h"), lwd = c(1,2))
 
 > plot(sample_xts[,c(1:4, 3:4)], layout = matrix(c(1,1,1,1,2,2,3,4,5,6), ncol = 2
byrow = TRUE), yax.loc = "left")

plot(sample_xts[,1], events = list(time = c("2007-03-15","2007-05-01"), label
= "bad days"), blocks = list(start.time = c("2007-03-05", "2007-04-15"), end.
time = c("2007-03-20","2007-05-30"), col = c("lightblue1", "lightgreen")))

5. 双坐标的时间序列
画双坐标视图，如图 2-22 所示。
> plot(sample_xts[,1],sample_xts[,2])

画双坐标梯度视图，如图 2-23 所示。
> cr <- colorRampPalette(c("#00FF00","#FF0000"))
> plot(sample_xts[,1],sample_xts[,2], xy.labels = FALSE, xy.lines = TRUE, col =
cr(NROW(sample_xts)), type = "l")


对于不同层次的R语言用户，也有了市场细分。入门的朋友可以从《R语言编程艺术》开始学习；有一定R语言基础的朋友可以阅读《R语言实战》；需要扩展知识面的朋友可以阅读《R的极客理想——工具篇》；在掌握了R语言的各种入门技术后，高级的R语言开发者可以阅读本；用R做可视化的朋友，可以阅读《ggplot2：数据分析与图形艺术》；正在学习统计学的朋友，可以阅读《统计建模与R软件》；准备用R做金融的朋友，可以阅读《时间序列分析及应用：R语言（原书第2版）》

和《金融数据分析导论：基于R语言》。

《R语言编程艺术》《R语言实战》《ggplot2：数据分析与图形艺术》《R语言核心技术手册（第2版）》《R数据可视化手册》《R语言统计入门（第2版）》等多本图书。

笔者的个人博客——粉丝日志（http://blog.fens.me），原创了大量的R语言技术实战文章，包括R的极客理想系列文章、RHadoop实践系列文章、R利剑NoSQL系列文章，并写作“R的极客理想”系列图书。谢益辉的个人博客（http://yihui.name），博客中主要包括各种有趣的技术和吐槽文章。谢益辉是统计之都的创始人，现任RStudio公司程序员。刘思喆的个人博客——贝吉塔行星（http://www.bjt.name），博客中主要包括R语言企

业级应用的文章。刘思喆现任京东推荐算法经理。李舰的个人博客（http://jliblog.com），博客中主要包括R语言建模的文章。李舰现任Mango So-lutions中国区数据总监。邓一硕的个人博客——格物堂（http://yishuo.org），博客中主要包括R语言金融数据分析的文章。阿稳的个人博客——不周山（http://www.wen-true.net/blog），博客中主要包括R语言并行技术的文章。


R CMD BATCH --vanilla < z.r
R CMD BATCH z.R


rep()
seq()
any()
all()

x<-1:10
any(x>8)
any(x>88)
all(x>88)
all(x>0)

any(x>8)

f<-function(x,c) return((x+c)^2)
f(1:3,0)
f(1:3,1)
f(1:3,1:3)

f<-function(x,c) {
  if(length(c) != 1) stop("vector c not allowed")
  return((x+c)^2)
}

z12<-function(z) return(c(z,z^2))

z12<-function(z) return(matrix(c(z,z^2),ncol=2))


#sapply simplify Applying

z12<-function(z) return(c(z,z^2))
sapply(1:8,z12)

mean(x,na.rm=TRUE)
for (i in 1:10) if (i %%2 == 0) z <- c(z,i)

seq(2,10,2)
2*1:5

#filter
z<-c(5,2,3,8)
w<- z[z*z > 8]
w

x[x>3] <-0

subset(x,x>5) #自动remove NA
which(z*z > 8)


first1a <- function(x) return(which(x == 1)[1])

向量化的ifelse
ifelse(b,u,v)

x<-1:10
y<-ifelse(x %% 2 == 0,5,12) 

x<-c(5,2,9,12)
ifelse(x>6,2*x,3*x)


x<-1:10
z<-1:10*2
y<-ifelse(x %% 2 == 0,x,z) 


findud <- function(v){
	vud <- v[-1] -v[-length(v)]
	return(ifelse(vud > 0,1,-1))
}

udcorr <- function(x,y) {
	ud <-lappy(list(x,y),findud)
	return(mean(ud[[1]] == ud[[2]]))
}


ifelse(g == "M",1,ifelse(g == "F",2,3))


grps <- list()
for (gen in c("M","F","I")) grps[[gen]] <- which(g==gen)

all(x == y)

identical(x,y)
names(x) <- c("a","b","ab")

y <- matrix(c(1,2,3,4),nrow = 2,ncol = 2 )
m <- matrix(c(1,2,3,4,5,6),nrow = 2,byrow = T )

y %*% y

3*y
y+y

z<-matrix(1:9,nrow=3,byrow =T)
z[,2:3]
z[2:3,]
z[2:3,2]
y[-2,]

library(pixmap)
mtrush1<- read.pnm("mtrush1.pgm")
mtrush1
plot(mtrush1)

x[x[,2] >= 3,]

x[,2] >= 3

m[m[,1] > 1 & m[,2] > 5,]
m
which(m > 2)

apply(m,dimcode,f,fargs)
apply(z,2,mean)
colMeans()

f<-function(x,y) x/y
> f(z[1,],2)
[1] 0.5 1.0 1.5
> apply(z,1,f,2)
     [,1] [,2] [,3]
[1,]  0.5  2.0  3.5
[2,]  1.0  2.5  4.0
[3,]  1.5  3.0  4.5

> t(apply(z,1,f,2))
     [,1] [,2] [,3]
[1,]  0.5  1.0  1.5
[2,]  2.0  2.5  3.0
[3,]  3.5  4.0  4.5


copymaj<-function(rw,d){
maj <- sum(rw[1:d])/d
return(if(maj > 0.5) 1 else 0)
}
 
x
apply(x,1,copymaj,3)

#find ols
findols <- function(x) {
	findol <- function(xrow){
		mdn <- median(xrow)
		devs <- abs(xrow-mdn)
		return(which.max(devs))
	}
	return(apply(x,1,findol))
}

findols(rs)

x<-c(x[1:3],20,x[4:6])

x<-x[-2:-4] #delete elements 2 through 4

rbind()
cbind()  column bind

m<-matrix(1:6,nrow=3)

m<-m[c(1,3),]

dim(z)
nrow(z)
ncol(z)


#防止降维，数据类型发生改变
r<-z[2,,drop=FALSE]

colnames(z) <- c("a","b")

tests<-array(data=c(firsttest,secondtest),dim=c(3,2,2))

/usr/lib/oracle/<your version>/client64/lib/ 
/usr/lib/oracle/12.1/client64/lib/ 

j<-list(name="joe",salary=55000,union=T)
tags

z<-vector(mode="list")

z[["abc"]] <-3

z<- vector(mode="list")

j[["salary"]]
j$salary
j[[2]]

lst$c
lst[["c"]]
lst[[1]]
lst["c"]
返回子列表
j[1:2]
[[]] 提取列表的一个组件，返回值是组件本身的类型。而不是列表

z<-list(a="abc",b=12)

z$c<-"sailing"

z[[4]]<-28
z[5:7] <- c(FALSE,TRUE,TRUE)
把相应的值设为<-NULL
c(list("Joe",55000,T),list(5))

length(j)


###sample
findwords <- function(tf){
#read in the words from the file, into a vector of mode character
txt <-scan(tf,"")
wl<-list()
for (i in 1:length(txt)){
	wrd <- txt[i]
	wl[[wrd]] <- c(wl[[wrd]],i)
	}
	return(wl)
}

names(j)

ulj <- unlist(j)
ulj
class(ulj)

w<- list(a=5,b="xyz")
wu<- unlist(w)
class(wu)
wun<-unname(wu)

lapply() sapply() 用于list
lapply(list(1:3,25:29),median)
sapply(list(1:3,25:29),median) #直接输出矩阵

#sort wrdlst， the output of findwords() alphabetically by word
alphawl <- function(wrdlst){
	nms<-names(wrdlst)
	sn<-sort(nms)
	return(wrdlst[sn]) 
}


#orders the output of findwords() by word frequencies
freqwl<-function(wrdlst){
  freqs<-sapply(wrdlst,length)
  return(wrdlst[order(freqs)])
}

nyt<-findwords("nyt.txt")
snyt<-freqwl(nyt)
nwords<-length(snyt)
freqwl<-sapply(snyt[round(0.9*nwords):nwords],length)
barplot(freqs9)

lapply(c("M","F","I"),function(gender) which(g==gender))
c(list(a=1,b=2,c=list(d=5,e=9)),recursive=T)

kids<- c("jack","jill")
ages<- c(12,10)
d<-data.frame(kids,ages,stringsAsFactors=FALSE)
d

d[[1]]

d[,1]
d$kids
str(d)

examsquiz<-read.table("exams",header=TRUE)
head(examsquiz)

extract sub dataframe
examsquiz[2:5,]
examsquiz[2:5,2]
class(examsquiz[2:5,2])
examsquiz[2:5,2,drop=FALSE]

examsquiz[examsquiz$Exam.1 >= 3.8,]

subset(examsquiz,Exam.1 >= 3.8)
subset(examsquiz,examsquiz$Exam.1 >= 3.8)

complete.case(d4)
	
d4[complete.case(d4),]
rbind(d,list("Laura",19))

cbind()

examsquiz$examdiff<-examsquiz$1 -examsquiz$2
d$one<-1
apply(d,1,max)
merge(x,y)
merge(d1,d3,by.x="kids",by.y="pals")

count.fields("DA",sep=",")
all(count.fields("DA",sep=",")>=5)
table(count.fields("DA",sep=","))
da<-read.csv("DA",header=TRUE,stringsAsFactors=FALSE)
for (col in 1:6)
	print(unique(sort(da[,col])))

lappply(d,sort)
as.data.frame(dl)

lftn<-function(clmn){
	glm(abamf$Gender ~  clmn,family=binomial)$coef
}
loall<-sapply(abamf[,-1],lftn)


	





################################
merge2fy<- function(fy1,fy2){
	outdf<-merge(fy1,fy2)
	for (fy in list(fy1,fy2)){
		saplout<- sapply((fy[[2]]),sepsoundtone)
		tmpdf <- data.frame(fy[,1],t(saplout),row.names=NULL,stringsAsFactors=F)
		consname<-paste(names(fy)[[2]]," cons",sep="")
		restname<-paste(names(fy)[[2]]," sound",sep="")
		tonename<-paste(names(fy)[[2]]," tone",sep="")
		names(tmpdf) <- c("ch char",consname,restname,tonename)
		outdf<-merge(outdf,tmpdf)
		
	}
	return(outdf)
}

sepsoundtone<- function(pronun){
nchr <- nchar(pronun)
vowels<-nchar(pronun)

}



x<-c(5,12,13,12)
xf<-factor(x)
xf
str(xf)
unclass(xf)

length(xf)

xff<-factor(x,levels=c(5,12,13,88))


factor >>>>>
tapply
tapply(x,f,g)

ages<-c(25,26,55,37,21,42)
affils<-c("R","D","D","R","U","D")
tapply(ages,affils,mean)


tapply 按factor分组统计

tapply(d$income,list(d$gender,d$over25),mean)

split(x,f)
split(d$income,list(d$gender,d$over25))

findwords<-function(tf){
#read in the words from the file,into a vector of mode character
txt<-scan(tf,"")
words<-split(1:length(txt),txt)
return(words)

}

by

by(aba,aba$Gender,function(m) lm(m[,2]~m[,3]))

u<-c(22,8,33,6,8,29,-2)
fl<-list(c(5,12,13,12,13,5,13),c("a","bc","a","a","bc","a","a"))
tapply(u,fl,length)

table(f1)


class(cttab)
cttab[1,1]

apply(cttab,1,sum)
addmargins(cttab) # add margins table
dimnames(cttab)

提取子表
subtable(cttab,list(Vote.for.X=c("No","Yes"),Voted.for.X.Last.Time=c("No","Yes")))

##########################################

 获取数据（从各种数据源将数据导入程序）；
 整理数据（编码缺失值、修复或删除错误数据、将变量转换成更方便的格式）；
 注释数据（以记住每段数据的含义）；
 总结数据（通过描述性统计量了解数据的概况）；
 数据可视化（一图胜千言）；
 数据建模（解释数据间的关系，检验假设）；
 整理结果（创建具有出版水平的表格和图形）。

www.statmethods.net

help.start() 打开帮助文档首页
help(" foo") 或?foo 查看函数foo的帮助（引号可以省略）
help.search(" foo") 或??foo 以foo为关键词搜索本地帮助文档
example(" foo") 函数foo的使用示例（引号可以省略）
RSiteSearch(" foo") 以foo为关键词搜索在线文档和邮件列表存档
apropos(" foo", mode="function") 列出名称中含有foo的所有可用函数
data() 列出当前已加载包中所含的所有可用示例数据集
vignette() 列出当前已安装包中所有可用的vignette文档
vignette(" foo") 为主题foo显示指定的vignette文档



getwd() 显示当前的工作目录
setwd(" mydirectory") 修改当前的工作目录为mydirectory
ls() 列出当前工作空间中的对象
rm( objectlist) 移除（删除）一个或多个对象
help(options) 显示可用选项的说明
options() 显示或设置当前选项
history(#) 显示最近使用过的#个命令（默认值为25）
savehistory(" myfile") 保存命令历史到文件myfile中（默认值为.Rhistory）
loadhistory(" myfile") 载入一个命令历史文件（默认值为.Rhistory）
save.image(" myfile") 保存工作空间到文件myfile中（默认值为.RData）
save( objectlist, file=" myfile") 保存指定对象到一个文件中
load(" myfile") 读取一个工作空间到当前会话中（默认值为.RData）
q() 退出 R。将会询问你是否保存工作空间



1. 输入
函数source(" filename") 可在当前会话中执行一个脚本。如果文件名中不包含路径， R将
假设此脚本在当前工作目录中。举例来说， source("myscript.R") 将执行包含在文件
myscript.R中的R语句集合。依照惯例，脚本文件以.R作为扩展名，不过这并不是必需的。
2. 文本输出
函数sink(" filename") 将输出重定向到文件filename中。默认情况下，如果文件已经存
在，则它的内容将被覆盖。使用参数append=TRUE可以将文本追加到文件后，而不是覆盖它。
参数split=TRUE可将输出同时发送到屏幕和输出文件中。不加参数调用命令sink() 将仅向屏幕
返回输出结果。
3. 图形输出
虽然sink() 可以重定向文本输出，但它对图形输出没有影响。要重定向图形输出，使用
表1-4中列出的函数即可。最后使用dev.off() 将输出返回到终端。
表1-4 用于保存图形输出的函数
函 数 输 出
pdf("filename.pdf") PDF文件
win.metafile("filename.wmf") Windows图元文件
png("filename.png") PBG文件
jpeg("filename.jpg") JPEG文件
bmp("filename.bmp") BMP文件
postscript("filename.ps") PostScript文件

http://cran.r-project.org/web/packages

函数.libPaths() 能够显示库所在的位置， 函数library() 则可以显示库中
有哪些包。

update.packages()
help(package=" package_name")


其中infile是包含了要执行的R代码所在文件的文件名， outfile是接收输出文件的文件名，
options部分则列出了控制执行细节的选项。依照惯例， infile的扩展名是.R， outfile的扩
展名为.Rout。
对于Windows，则需使用：

将路径调整为R.exe所在的相应位置和脚本文件所在位置。要进一步了解如何调用R，包括命
令行选项的使用方法，请参考CRAN（ http://cran.r-project.org）上的文档“Introduction to R” ①。

with(mtcars,{
summary(mpg,disp,wt)
plot(mpg,disp)
plot(mpg,wt)
})

2. 实例标识符
在病例数据中，病人编号（ patientID）用于区分数据集中不同的个体。在R中， 实例标识
符（ case identifier）可通过数据框操作函数中的rowname选项指定。例如，语句：
将patientID指定为R中标记各类打印输出和图形中实例名称所用的变量。

patientdata<-data.frame(patientId,age,diabetes,status,row.names=patientId)

status <- factor(status, ordered=TRUE)
语句status <- factor(status, ordered=TRUE) 会将向量编码为(3, 2, 1, 3)，并在内部将这
些值关联为1=Excellent、 2=Improved以及3=Poor。另外，针对此向量进行的任何分析都会将
——————————
你可以通过指定levels选项来覆盖默认排序。例如：


status <- factor(status,order=TRUE,levels=c("Poor","Improved","Excellent"))

各水平的赋值将为1=Poor、 2=Improved、 3=Excellent。请保证指定的水平与数据中的真实值
相匹配，因为任何在数据中出现而未在参数中列举的数据都将被设为缺失值。
代码清单2-6演示了普通因子和有序因子的不同是如何影响数据分析的。




====================================================================
 read.table
function (file, header = FALSE, sep = "", quote = "\"'", dec = ".", 
    numerals = c("allow.loss", "warn.loss", "no.loss"), row.names, 
    col.names, as.is = !stringsAsFactors, na.strings = "NA", 
    colClasses = NA, nrows = -1, skip = 0, check.names = TRUE, 
    fill = !blank.lines.skip, strip.white = FALSE, blank.lines.skip = TRUE, 
    comment.char = "#", allowEscapes = FALSE, flush = FALSE, 
    stringsAsFactors = default.stringsAsFactors(), fileEncoding = "", 
    encoding = "unknown", text, skipNul = FALSE) 
	
> odbcConnectExcel
function (xls.file, readOnly = TRUE, ...) 

library(xlsx)
read.xlsx(workbook,1)

www.omegahat.org/RSXML
Webscraping using readLines and RCurl
www.programmingr.com
表2-2 RODBC中的函数
函 数 描 述
odbcConnect( dsn,uid="",pwd="") 建立一个到ODBC数据库的连接
sqlFetch( channel, sqltable) 读取ODBC数据库中的某个表到一个数据框中
sqlQuery( channel, query) 向ODBC数据库提交一个查询并返回结果
sqlSave( channel, mydf,tablename=
sqtable,append=FALSE)
将数据框写入或更新（ append=TRUE）到ODBC数据库的
某个表中
sqlDrop( channel, sqtable) 删除ODBC数据库中的某个表
close( channel) 关闭连接

library(RODBC)
myconn<-odbcConnect("mydsn",uid="Rob",pwd="aa")
crimedat<-sqlFetch(myconn,Crime)
pundat<-sqlQuery(myconn,"select * from Punishment")
close(myconn)

基于DBI的包有RMySQL、 ROracle、 RPostgreSQL和RSQLite。


factor(patientdata$gender,
		levels=c(1,2),
		labels=c("male","female")
		)
		
在本章末尾，我们来简要总结一下实用的数据对象处理函数（参见表2-3）。
表2-3 处理数据对象的实用函数
函 数 用 途
length( object) 显示对象中元素/成分的数量
dim( object) 显示某个对象的维度
str( object) 显示某个对象的结构
class( object) 显示某个对象的类或类型
mode( object) 显示某个对象的模式
names( object) 显示某对象中各成分的名称
c( object, object,…) 将对象合并入一个向量

cbind( object, object, …) 按列合并对象
rbind( object, object, …) 按行合并对象
Object 输出某个对象
head( object) 列出某个对象的开始部分
tail( object) 列出某个对象的最后部分
ls() 显示当前的对象列表
rm( object, object, …) 删除一个或更多个对象。语句rm(list = ls())
将删除当前工作环境中的几乎所有对象*
newobject <- edit( object) 编辑对象并另存为newobject
fix( object) 直接编辑对象

pdf("mygraph.pdf")
	attach(mtcars)
	plot(wt,mpg)
	abline(lm(mpg~wt))
	title("Regression of mpg on weight")

	detach(mtcars)
dev.off()

dev.new()
	plot
dev.new()
	plot

opar<-par(no.readonly=TRUE)
par(lty=2,pch=17)
plot(dose,drugA,type="b")
par(opar)

6
7
pch 指定绘制点时使用的符号（见图3-4）
cex 指定符号的大小。 cex是一个数值，表示绘图符号相对于默认大小的缩放倍数。默认大小
为1， 1.5表示放大为默认值的1.5倍， 0.5表示缩小为默认值的50%，等等
lty 指定线条类型（参见图3-5）
lwd 指定线条宽度。 lwd是以默认值的相对大小来表示的（默认值为1 ）。例如， lwd=2 将生
成一条两倍于默认宽度的线条


2
3
4
5
col 默认的绘图颜色。某些函数（如lines和pie）可以接受一个含有颜色值的向量
并自动循环使用。 例如， 如果设定col=c(" red" , " blue" ) 并需要绘制三条线，
则第一条线将为红色，第二条线为蓝色，第三条线又将为红色
col.axis 坐标轴刻度文字的颜色
col.lab 坐标轴标签（名称）的颜色
col.main 标题颜色
col.sub 副标题颜色
fg 图形的前景色
bg 图形的背景色


在R中，可以通过颜色下标、颜色名称、十六进制的颜色值、 RGB值或HSV值来指定颜色。
举例来说， col=1、 col="white" 、 col="#FFFFFF" 、 col=rgb(1,1,1) 和col=hsv(0,0,1)
都是表示白色的等价方式。函数rgb() 可基于红—绿—蓝三色值生成颜色，而hsv() 则基于色相 —
饱和度—亮度值来生成颜色。请参考这些函数的帮助以了解更多细节。

8
9
1
1
1
函数colors() 可以返回所有可用颜色的名称。 Earl F. Glynn为R中的色彩创建了一个优秀的
在线图表，参见http://research.stowers-institute.org/efg/R/Color/Chart。 R中也有多种用于创建连续
型颜色向量的函数，包括rainbow() 、 heat.colors() 、 terrain.colors() 、 topo.colors()
以及cm.colors() 。举例来说， rainbow(10) 可以生成10种连续的“彩虹型”颜色。多阶灰度
色可使用gray() 函数生成。这时要通过一个元素值为0和1 之间的向量来指定各颜色的灰度。
gray(0:10/10) 将生成10阶灰度色。试着使用以下代码：
来观察这些函数的工作方式。本章始终会有使用颜色参数的示例。


16
15
cex 表示相对于默认大小缩放倍数的数值。默认大小为1， 1.5表示放大为默认值的1.5
倍， 0.5表示缩小为默认值的50%，等等
cex.axis 坐标轴刻度文字的缩放倍数。类似于cex

参 数 描 述
cex.lab 坐标轴标签（名称）的缩放倍数。类似于cex
cex.main 标题的缩放倍数。类似于cex
cex.sub 副标题的缩放倍数。类似于cex
表3-5 用于指定字体族、字号和字样的参数
参 数 描 述
font 整数。用于指定绘图使用的字体样式。 1=常规， 2=粗体， 3=斜体， 4=粗斜体， 5=
符号字体（以Adobe符号编码表示）
font.axis 坐标轴刻度文字的字体样式
font.lab 坐标轴标签（名称）的字体样式
font.main 标题的字体样式
font.sub 副标题的字体样式
ps 字体磅值（ 1 磅约为1/72英寸）。文本的最终大小为 ps*cex
family 绘制文本时使用的字体族。标准的取值为serif（衬线）、 sans（无衬线）和mono
（等宽）





