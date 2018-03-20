DMwR-package	Functionsanddataforthebook"DataMiningwithR"
help(package="DMwR")

Quandl("XSHG/600463_UADJ", api_key="bauLwKZiFsjxybxUU41m")
https://www.quandl.com/api/v3/datasets/XSHG/600463_UADJ.xml?api_key=bauLwKZiFsjxybxUU41m
quandl.get("XSHG/600463_UADJ", authtoken="bauLwKZiFsjxybxUU41m")
https://www.quandl.com/api/v3/datasets/XSHG/600463_UADJ.json?api_key=bauLwKZiFsjxybxUU41m
https://www.quandl.com/search-beta


https://blog.quandl.com/stock-market-data-guide
http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=300397&type=1&pn=1
http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=000425&type=1&pn=1
http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=600463&type=1&pn=1
http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=601991&type=1&pn=1

require(Quandl)

http://pdf.dfcfw.com/pdf/H2_AN201603300014149836_1.pdf


1http://finance.yahoo.com.
2
^GSPCisthetickerIDofS&P500atYahoofinancefromwherethequoteswereobtained.
3http://www.liaad.up.pt/~ltorgo/DataMiningWithR.
http://www.dcc.fc.up.pt/~ltorgo/DataMiningWithR/code.html


library(xts)
x1<-xts(rnorm(100),seq(as.POSIXct("2000-01-01"),len=100,
by="day"))

x1[1:5]

x2<-xts(rnorm(100),seq(as.POSIXct("2000-01-0113:00"),
len=100,by="min"))
x2[1:4]

x3<-xts(rnorm(3),as.Date(c("2005-01-01","2005-01-10",
"2005-01-12")))
x3

x1[as.POSIXct("2000-01-04")]
x1["2000-01-05"]
x1["20000105"]
x1["2000-04"]
x1["2000-03-27/"]
x1["2000-03-27/"]
x1["/20000103"]


mts.vals<-matrix(round(rnorm(25),2),5,5)
colnames(mts.vals)<-paste('ts',1:5,sep='')
mts<-xts(mts.vals,as.POSIXct(c('2003-01-01','2003-01-04',
'2003-01-05','2003-01-06','2003-02-16')))
mts
mts["2003-01",c("ts2","ts5")]

index(mts)
Thefunctionsindex()andtime()canbeusedto“extract”thetimetags
informationofanyxtsobject,whilethecoredata()functionobtainsthe
datavaluesofthetimeseries:
index(mts)
[1]"2003-01-01WET""2003-01-04WET""2003-01-05WET""2003-01-06WET"
[5]"2003-02-16WET"
coredata(mts)
ts1ts2ts3ts4ts5
[1,]0.96-0.16-1.030.170.62
[2,]0.101.64-0.83-0.550.49
[3,]0.380.03-0.09-0.641.37
[4,]0.730.98-0.660.09-0.89
[5,]2.680.101.441.37-1.37


GSPC<-as.xts(read.zoo("sp500.csv",header=T))

library(tseries)
GSPC<-as.xts(get.hist.quote("^GSPC",start="1970-01-02",
quote=c("Open","High","Low","Close","Volume","AdjClose")))

GSPC<-as.xts(get.hist.quote("GBPCNY=X",start="1970-01-02",
quote=c("Open","High","Low","Close","Volume","AdjClose")))



GSPC<-as.xts(get.hist.quote("GBPCNY",start="1970-01-02",
quote=c("Open","High","Low","Close","Volume","AdjClose")))


http://finance.yahoo.com/quote/CNY=X/?p=CNY=X
USD/CNY(CNY=X)
GBP/CNY(GBPCNY=X)

frm_get_fx<-function(symbol){
	as.xts(get.hist.quote(symbol,start="1970-01-02",
	quote=c("Open","High","Low","Close","Volume","AdjClose")))%>%return
}
GBPCNY<-frm_get_fx("CNY=X")
cny<-as.xts(get.hist.quote("CNY=X",start="1970-01-02",
quote=c("Open","High","Low","Close","Volume","AdjClose")))

Asthefunctionget.hist.quote()returnsanobjectofclasszoo,wehave
againusedthefunctionas.xts()tocoerceittoxts.Weshouldremarkthat
ifyouissuethesecommands,youwillgetmoredatathanwhatisprovided
withtheobjectinthebookpackage.Ifyouwanttoensurethatyougetthe
sameresultsinfuturecommandsinthischapter,youshouldinsteadusethe
command


library(quantmod)
getSymbols("GBPCNY=X")

getSymbols("^GSPC",from="1970-01-01",to="2009-09-15")
colnames(GSPC)<-c("Open","High","Low","Close","Volume","AdjClose")


setSymbolLookup(IBM=list(name='IBM',src='yahoo'),GBPCNY=list(name='GBP/CNY',src='oanda'))
getSymbols(c('IBM','GBPCNY'))
head(GBPCNY)


odbcClose(ch)

library(RODBC)
ch<-odbcConnect("QuotesDSN",uid="myusername",pwd="mypassword")
allQuotes<-sqlFetch(ch,"gspc")
GSPC<-xts(allQuotes[,-1],order.by=as.Date(allQuotes[,1]))
head(GSPC)
1970-01-02
1970-01-05
1970-01-06
1970-01-07
1970-01-08
1970-01-09
Open
92.06
93.00
93.46
92.82
92.63
92.68
High
93.54
94.25
93.81
93.38
93.47
93.25
Low
91.79
92.53
92.13
91.93
91.99
91.82
Close
93.00
93.46
92.82
92.63
92.68
92.40
VolumeAdjClose
8050000
93.00
11490000
93.46
11460000
92.82
10010000
92.63
10670000
92.68
9380000
92.40
odbcClose(ch)

library(DBI)
library(RMySQL)
drv<-dbDriver("MySQL")
ch<-dbConnect(drv,dbname="Quotes","myusername","mypassword")
allQuotes<-dbGetQuery(ch,"select*fromgspc")
GSPC<-xts(allQuotes[,-1],order.by=as.Date(allQuotes[,1]))
head(GSPC)
dbDisconnect(ch)
[1]TRUE
dbUnloadDriver(drv)

AnotherpossibilityregardingtheuseofdatainaMySQLdatabaseisto
usetheinfrastructureprovidedbythequantmodpackagethatwedescribedin
Section3.2.3.Ineffect,thefunctiongetSymbols()canuseassourceaMySQL
database.Thefollowingisasimpleillustrationofitsuseassumingadatabase
astheonedescribedabove:

http://cran.at.r-project.org/web/views/HighPerformanceComputing.html



setSymbolLookup(GSPC=list(name='gspc',src='mysql',
db.fields=c('Index','Open','High','Low','Close','Volume','AdjClose'),
user='xpto',password='ypto',dbname='Quotes'))
getSymbols('GSPC')
[1]"GSPC"




Stock.Close<-c(102.12,102.62,100.12,103.00,103.87,103.12,105.12)
Close.Dates<-as.Date(c(10660,10661,10662,10665,10666,10667,10668),origin="1970-01-01")
Stock.Close<-zoo(Stock.Close,Close.Dates)

Next(Stock.Close)#oneperiodahead
Next(Stock.Close,k=1)#same

merge(Next(Stock.Close),Stock.Close)

##Notrun:
#asimplewaytobuildamodelofnextdays
#IBMclose,giventodays.Technicallyboth
#methodsareequal,thoughtheformerisseen
#asmoreintuitive...ymmv
specifyModel(Next(Cl(IBM))~Cl(IBM))
specifyModel(Cl(IBM)~Lag(Cl(IBM)))

Stock.Open<-c(102.25,102.87,102.25,100.87,103.44,103.87,103.00)
Stock.Close<-c(102.12,102.62,100.12,103.00,103.87,103.12,105.12)

Delt(Stock.Open)#oneperiodpct.pricechange
Delt(Stock.Open,k=1)#same
Delt(Stock.Open,type='arithmetic')#usingarithmeticdifferences(default)
Delt(Stock.Open,type='log')#usinglogdifferences

Delt(Stock.Open,Stock.Close)#OpentoClosepct.change
Delt(Stock.Open,Stock.Close,k=0:2)#...for0,1,and2periods


GSPC%>%time%>%str
Date[1:11817],format:"1970-01-02""1970-01-05""1970-01-06""1970-01-07""1970-01-08""1970-01-09"...


T.ind<-function(quotes,tgt.margin=0.025,n.days=10){
v<-apply(HLC(quotes),1,mean)
r<-matrix(NA,ncol=n.days,nrow=NROW(quotes))
for(xin1:n.days)r[,x]<-Next(Delt(v,k=x),x)
x<-apply(r,1,function(x)sum(x[xtgt.marginx<
-tgt.margin]))
if(is.xts(quotes))
xts(x,time(quotes))
elsex
}

candleChart(last(GSPC,"3months"),theme="white",TA=NULL)
avgPrice<-function(p)apply(HLC(p),1,mean)
addAvgPrice<-newTA(FUN=avgPrice,col=1,legend="AvgPrice")
addT.ind<-newTA(FUN=T.ind,col="red",legend="tgtRet")
addAvgPrice(on=1)
addT.ind(on=1)


myATR<-function(x)ATR(HLC(x))[,"atr"]
mySMI<-function(x)SMI(HLC(x))[,"SMI"]
myADX<-function(x)ADX(HLC(x))[,"ADX"]
myAroon<-function(x)aroon(x[,c("High","Low")])$oscillator
myBB<-function(x)BBands(HLC(x))[,"pctB"]
myChaikinVol<-function(x)Delt(chaikinVolatility(x[,c("High",
"Low")]))[,1]
myCLV<-function(x)EMA(CLV(HLC(x)))[,1]
myEMV<-function(x)EMV(x[,c("High","Low")],x[,"Volume"])[,
2]
myMACD<-function(x)MACD(Cl(x))[,2]
myMFI<-function(x)MFI(x[,c("High","Low","Close")],
x[,"Volume"])
mySAR<-function(x)SAR(x[,c("High","Close")])[,1]
myVolat<-function(x)volatility(OHLC(x),calc="garman")[,
1]


data(GSPC)
library(randomForest)
data.model<-specifyModel(T.ind(GSPC)~Delt(Cl(GSPC),k=1:10)+
myATR(GSPC)+mySMI(GSPC)+myADX(GSPC)+myAroon(GSPC)+
myBB(GSPC)+myChaikinVol(GSPC)+myCLV(GSPC)+
CMO(Cl(GSPC))+EMA(Delt(Cl(GSPC)))+myEMV(GSPC)+
myVolat(GSPC)+myMACD(GSPC)+myMFI(GSPC)+RSI(Cl(GSPC))+
mySAR(GSPC)+runMean(Cl(GSPC))+runSD(Cl(GSPC)))
set.seed(1234)
rf<-buildModel(data.model,method='randomForest',
training.per=c(start(GSPC),index(GSPC["1999-12-31"])),
ntree=50,importance=T)

getSymbols('GSPC',src='yahoo')
q.model=specifyModel(Next(OpCl(GSPC))~Lag(OpHi(GSPC),0:3))
buildModel(q.model,method='lm',training.per=c('2006-08-01','2006-09-30'))


ex.model<-specifyModel(T.ind(IBM)~Delt(Cl(IBM),k=1:3))
data<-modelData(ex.model,data.window=c("2009-01-01",
"2009-08-10"))

m<-myFavouriteModellingTool(ex.model@model.formula,as.data.frame(data))

?model.formula

varImpPlot


set.seed(4543)
data(mtcars)
mtcars.rf<-randomForest(mpg~.,data=mtcars,ntree=1000,keep.forest=FALSE,
importance=TRUE)
varImpPlot(mtcars.rf)



set.seed(4543)
data(mtcars)
mtcars.rf<-randomForest(mpg~.,data=mtcars,ntree=1000,
keep.forest=FALSE,importance=TRUE)
importance(mtcars.rf)
importance(mtcars.rf,type=1)


imp<-importance(mtcars.rf,type=1)
rownames(imp)[which(imp>10)]

data.model<-specifyModel(T.ind(GSPC)~Delt(Cl(GSPC),k=1))
rf<-buildModel(data.model,method='randomForest',
training.per=c(start(GSPC),index(GSPC["2016-10-27"])),
ntree=50,importance=T)

index(GSPC["1999-12-31"])
2016-10-2722.0500


library(quantmod)
getSymbols("DIA")
head(DIA)

t_ridao<-function(price,t.margin=0.02,time=9){
v<-apply(HLC(price),1,mean)
r<-matrix(NA,ncol=time,nrow=NROW(price))
for(xin1:time)r[,x]<-Next(Delt(v,k=x),x)
x<-apply(r,1,function(x)sum(x[x>t.margin|x<-t.margin]))
if(is.xts(price))
xts(x,time(price))elsex
}

candleChart(last(DIA,"4months"),theme="white",TA=NULL)
avgprice<-function(x)apply(HLC(x),1,mean)
addavgprice<-newTA(FUN=avgprice,col=1,legend="Avgprice")
addT_radio<-newTA(FUN=t_radio,col="red",legend="tgtRat")
addavgprice(on=1)
addT_radio()

names(DIA)<-c("Open","High","Low","Close","Volume","Adjusted")

head(DIA)

T_ATR<-function(x)ATR(HLC(x))[,"atr"]
T_SMI<-function(x)SMI(HLC(x))[,"SMI"]
T_ADX<-function(x)ADX(HLC(x))[,"ADX"]
T_Aroon<-function(x)aroon(x[,c("High","Low")])$oscillator
T_BB<-function(x)BBands(HLC(x))[,"pctB"]
T_CV<-function(x)Delt(chaikinVolatility(x[,c("High","Low")]))[,1]
T_CLV<-function(x)EMA(CLV(HLC(x)))[,1]
T_EMV<-function(x)EMV(x[,c("High","Low")],x[,"Volume"])[,2]
T_MACD<-function(x)MACD(Cl(x))[,2]
T_MFI<-function(x)MFI(x[,c("High",'Low',"Close")],x[,"Volume"])
T_SAR<-function(x)SAR(x[,c("High","Close")])[,1]
T_Volat<-function(x)volatility(OHLC(x),salc="garman")[,1]

myATR<-function(x)ATR(HLC(x))[,"atr"]


library(randomForest)
data_model<-specifyModel(t_radio(DIA)~Delt(Cl(DIA),k=1:10)+T_ATR(DIA)
	+T_CV(DIA)+T_CLV(DIA)+CMO(Cl(DIA))+EMA(Delt(Cl(DIA)))+T_EMV(DIA)+T_Volat(DIA)+T_MACD(DIA)+T_MFI(DIA)+RSI(Cl(DIA))+T_SAR(DIA)+runMean(Cl(DIA))+runSD(Cl(DIA)))


t_ridao<-function(price,t.margin=0.02,time=9){
v<-apply(HLC(price),1,mean)
r<-matrix(NA,ncol=time,nrow=NROW(price))
for(xin1:time)r[,x]<-Next(Delt(v,k=x),x)
x<-apply(r,1,function(x)sum(x[x>t.margin|x<-t.margin]))
if(is.xts(price))
xts(x,time(price))elsex
}


data_model<-specifyModel(t_ridao(DIA)~myATR(DIA))
data_model<-specifyModel(t_ridao(DIA)~Delt(Cl(DIA),k=1:10)+T_ATR(DIA)+T_SMI(DIA)+T_ADX(DIA)
	+T_Aroon(DIA)+T_BB(DIA)
	)
rf<-buildModel(data_model,method="randomForest",training.per=c(start(DIA),index(DIA["2009-12-31"])),ntree=500,importance=T)
plot(rf)

varImpPlot(rf@fitted.model,type=1)


data.model<-data_model
Tdata.train<-as.data.frame(modelData(data.model,
data.window=c('2007-01-03','2010-01-03')))

Tdata.eval<-na.omit(as.data.frame(modelData(data.model,
data.window=c('2010-01-03','2016-11-01'))))

Tform<-as.formula('t_ridao.DIA~.')

###################################################
#temptableprepos

df1<-read.table("e:/temp_stock.txt",sep="",head=T,stringsAsFactors=F)

colnames(df1)<-c("item","V1","V2","V3")

df1<-transform(df1,V1=gsub(",","",V1))
df1<-transform(df1,V2=gsub(",","",V2))
df1<-transform(df1,V3=gsub(",","",V3))
df1<-transform(df1,V1=V1%>%as.double)
df1<-transform(df1,V2=V2%>%as.double)
df1<-transform(df1,V3=V3%>%as.double)
df2<-df1[,-1]



integrand<-function(x)1/((x+1)*sqrt(x))
integrate(integrand,lower=0,upper=Inf)

my_matrix<-matrix(c(1,2,3,4,5,6),
nrow=2,ncol=3)
my_matrix

my_matrix<-matrix(c(1,2,3,4,5,6),
nrow=2,ncol=3,byrow=TRUE)
my_matrix

dimnames(my_matrix)<-list(c("one","hello"),
c("column1","column2","c3"))

attributes(my_matrix)
new_matrix_1<-my_matrix*my_matrix

new_matrix_2<-sqrt(my_matrix)
mat1<-matrix(rnorm(1000),nrow=100)
round(mat1[1:5,2:6],3)

mat2<-mat1[1:25,]^2
head(round(mat2,0),9)[,1:7]

df<-data.frame(price=c(89.2,23.2,21.2),
symbol=c("MOT","AAPL","IBM"),
action=c("Buy","Sell","Buy"))


df3<-data.frame(price=c(89.2,23.2,21.2),
symbol=c("MOT","AAPL","IBM"),
action=c("Buy","Sell","Buy"),
stringsAsFactors=FALSE)
class(df3$symbol)

my_list<-list(a=c(1,2,3,4,5),
b=matrix(1:10,nrow=2,ncol=5),
c=data.frame(price=c(89.3,98.2,21.2),
stock=c("MOT","IBM","CSCO")))
my_list

first_element<-my_list[[1]]

second_element<-my_list[["b"]]
second_element
part_of_list<-my_list[c(1,3)]
part_of_list

size_of_list<-length(my_list)

env<-new.env()
env[["first"]]<-5
env[["second"]]<-6
env$third<-7
ls(env)

get("first",envir=env)

rm("second",envir=env)
ls(env)

env_2<-env
env_2$third<-42
get("third",envir=env)

ggvis,rCharts,andrgl

plot(rnorm(1000),main="Somereturns",cex.main=0.9,
xlab="Time",ylab="Returns")
grid()
abline(v=400,lwd=2,lty=1)
abline(h=2,lwd=3,lty=3)



#Createa2-row,2-columnformat
par(mfrow=c(2,2))
#Firstplot(points).
plot(rnorm(100),main="Graph1")
#Secondplot(lines).
plot(rnorm(100),main="Graph2",type="l")
#Thirdplot(steps)withaverticalline
plot(rnorm(100),main="Graph3",type="s")
abline(v=50,lwd=4)
#Fourthplot
plot(rnorm(100),type="h",main="Graph4")
#Resettheplotwindow
par(mfrow=c(1,1))

plot(rnorm(100),main="Alineplot",
cex.main=0.8,
xlab="x-axis",
ylab="y-axis",
type="l")
#Extratext
mtext("Sometextatthetop",side=3)
#Atx=40andy=-1coordinates
legend(40,-1,"Alegend")

formals(plot.default)
##$x


some_list<-list()
for(z in c("hello","goodbye")){
some_list[[z]]<-z
}

filter_and_sort_symbols<-function(symbols){
#Name:filter_symbols
#Purpose:Converttouppercaseifnot
#andremoveanynonvalidsymbols
#Input:symbols=vectorofstocktickers
#Output:filtered_symbols=filteredsymbols
#Convertsymbolstouppercase
symbols<-toupper(symbols)
#Validatethesymbolnames
valid<-regexpr("^[A-Z]{2,4}$",symbols)
#Returnonlythevalidones
return(sort(symbols[valid==1]))
}

extract_prices<-function(filtered_symbols,file_path){
#Name:extract_prices
#Purpose:Readpricedatafromspecifiedfile
#Inputs:filtered_symbols=vectorofsymbols,
#file_path=locationofpricedata
#Output:prices=data.frameofpricespersymbol
#Readinthe.csvpricefile
all_prices<-read.csv(file=file_path,header=TRUE,
stringsAsFactors=FALSE)
#Makethedatesrownames
rownames(all_prices)<-all_prices$Date
#RemovetheoriginalDatecolumn
all_prices$Date<-NULL
#Extractonlytherelevantdatacolumns
valid_columns<-colnames(all_prices)%in%filtered_symbols
return(all_prices[,valid_columns])
}



filter_prices<-function(prices){
#Name:filter_prices
#Purpose:Identifytherowswithmissingvalues
#Inputs:prices=data.frameofprices
#Output:missing_rows=vectorofindexeswhere
#dataismissinginanyofthecolumns
#Returnsabooleanvectorofgoodorbadrows
valid_rows<-complete.cases(prices)
#Identifytheindexofthemissingrows
missing_rows<-which(valid_rows==FALSE)
return(missing_rows)
}

compute_pairwise_correlations<-function(prices){
#Name:compute_pairwise_correlations
#Purpose:Calculatespairwisecorrelationsofreturns
#andplotsthepairwiserelationships
#Inputs:prices=data.frameofprices
#Output:correlation_matrix=Acorrelationmatrix
#Convertpricestoreturns
returns<-apply(prices,2,function(x)diff(log(x)))
#Plotallthepairwiserelationships
pairs(returns,main="Pairwisereturnscatterplot")
#Computethepairwisecorrelations
correlation_matrix<-cor(returns,use="complete.obs")
return(correlation_matrix)
}

#Stocktickersenteredbyuser
symbols<-c("IBM","XOM","2SG","TEva",
"G0og","CVX","AAPL","BA")
#Locationofourdatabaseofprices
file_path<-"path/prices.csv"
#Filterandsortthesymbols
filtered_symbols<-filter_and_sort_symbols(symbols)
filtered_symbols
##[1]"AAPL""BA""CVX""IBM""TEVA""XOM"
#Extractprices
prices<-extract_prices(filtered_symbols,file_path)
#Filterprices
missing_rows<-filter_prices(prices)
missing_rows
##integer(0)
#Computecorrelations
correlation_matrix<-compute_pairwise_correlations(prices)
correlation_matrix


#Stocktickersenteredbyuser
symbols<-c("IBM","XOM","2SG","TEva",
"G0og","CVX","AAPL","BA")
#Locationofourdatabaseofprices
file_path<-"path/prices.csv"
#Filterandsortthesymbols
filtered_symbols<-filter_and_sort_symbols(symbols)
filtered_symbols
##[1]"AAPL""BA""CVX""IBM""TEVA""XOM"
#Extractprices
prices<-extract_prices(filtered_symbols,file_path)
#Filterprices
missing_rows<-filter_prices(prices)
missing_rows
##integer(0)
#Computecorrelations
correlation_matrix<-compute_pairwise_correlations(prices)
correlation_matrix

aapl <- aapl[rev(rownames(aapl)), , drop = FALSE]

prices <- aapl$V1
plot(prices, main = "AAPL plot", type = 'l')


#Loadthe.csvfile
aapl_2<-read.csv(file="path/aapl.csv",header=TRUE,
stringsAsFactors=FALSE)
#Reversetheentries
aapl_2<-aapl_2[rev(rownames(aapl_2)),]


# Install and load the package
install.packages("RJSONIO")
library(RJSONIO)
# Read the file
out <- fromJSON(content = "path/sample_json_file.json" )
# Look at the structure of the resulting object
str(out)
## List of 2
## $ CVX : Named chr [1:3] "USD" "Basic Materials...
## ..- attr(*, "names")= chr [1:3] "Currency"...
## $ GOOG: Named chr [1:3] "USD" "Technology"...
## ..- attr(*, "names")= chr [1:3] "Currency"...

save(aapl_2, file = "path/aapl_2.rdata")

load(file = "path/aapl_2.rdata")

identical(aapl_old, aapl_2)
## [1] TRUE

library(XLConnect)
# Create a workbook object
book <- loadWorkbook("path/strategy.xlsx")
# Convert it into a data frame
signals = readWorksheet(book, sheet = "signals", header
= TRUE)
signals
strength=readWorksheet(book,sheet="strength",header
=TRUE)
strength


#Setupanewspreadsheet
book<-loadWorkbook("demo_sheet.xlsx",create=TRUE)
#Createasheetcalledstock1
createSheet(book,name="stock1")
#Creatingasheetcalledstock2
createSheet(book,name="stock2")
#Loaddataintoworkbook
df<-data.frame(a=c(1,2,3),b=c(4,5,6))
writeWorksheet(book,data=df,sheet="stock1",header=TRUE)
#Savetheworkbook
saveWorkbook(book,file="path/demo_sheet.xlsx")

# Load the RODBC package
require(RODBC)
# Establish a connection to MySQL
con <- odbcConnect("rfortraders")
# Choose the database name and table name
database_name <- "OptionsData"
table_name <- "ATMVolatilities"
symbol <- "SPY"
sql_command <- paste0("SELECT Symbol, Date, Maturity,
Delta,CallPut,ImpliedVolatilityFROM",
database_name,".",table_name,
"WHEREMaturity=91
ANDSymbolIN('",symbol,"');")
iv<-sqlQuery(con,sql_command)
#disconnectfromdatabase
odbcClose(con)


#Loadthenecessarypackage
require(RMySQL)
#Establishaconnection
con<-dbConnect(MySQL(),user="your_login",
password="your_password",
dbname="OptionsData",
host="location_of_database")
#Listthetablesandfields
dbListTables(con)
#Definethecommandandextractadataframe
sql_command<-paste0("SELECTSymbol,Date,Maturity,
Delta,CallPut,ImpliedVolatilityFROM",
database_name,".",table_name,
"WHEREMaturity=91
ANDSymbolIN('",symbol,"');")
result<-dbGetQuery(con,sql_command)
dbDisconnect(con)
results<-dbSendQuery(con,sql_command)
partial_results<-fetch(results,n=100)

# Load the flight database that comes with dplyr
library(hflights)
# Look at number of rows and columns
dim(hflights)
## [1] 227496 21

# First, coerce the data into a data.table
flights_dt <- tbl_dt(hflights)
# What type of object is this?
class(flights_dt)
## [1] "tbl_dt" "tbl" "data.table" "data.frame"

flights_dt <- tbl_df(hflights)

#Create a grouping by carrier
carrier_group<-group_by(flights_dt,UniqueCarrier)

#Now compute the summary statistics
summarise(carrier_group,avg_delay=mean(ArrDelay,na.rm=TRUE))

by_cyl <- group_by(mtcars, cyl)
do(by_cyl, head(., 2))
Source: local data frame [6 x 11]
Groups: cyl [3]

    mpg    cyl  disp    hp  drat    wt  qsec    vs     am  gear  carb
  <dbl> <fctr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <fctr> <dbl> <dbl>
1  22.8      4 108.0    93  3.85 2.320 18.61     1      1     4     1
2  24.4      4 146.7    62  3.69 3.190 20.00     1      0     4     2
3  21.0      6 160.0   110  3.90 2.620 16.46     0      1     4     4
4  21.0      6 160.0   110  3.90 2.875 17.02     0      1     4     4
5  18.7      8 360.0   175  3.15 3.440 17.02     0      0     3     2
6  14.3      8 360.0   245  3.21 3.570 15.84     0      0     3     4
> 

> do(by_cyl, head(., 1))
Source: local data frame [3 x 11]
Groups: cyl [3]

    mpg    cyl  disp    hp  drat    wt  qsec    vs     am  gear  carb
  <dbl> <fctr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <fctr> <dbl> <dbl>
1  22.8      4   108    93  3.85  2.32 18.61     1      1     4     1
2  21.0      6   160   110  3.90  2.62 16.46     0      1     4     4
3  18.7      8   360   175  3.15  3.44 17.02     0      0     3     2
> do(by_cyl, head(., 3))
Source: local data frame [9 x 11]
Groups: cyl [3]

    mpg    cyl  disp    hp  drat    wt  qsec    vs     am  gear  carb
  <dbl> <fctr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <fctr> <dbl> <dbl>
1  22.8      4 108.0    93  3.85 2.320 18.61     1      1     4     1
2  24.4      4 146.7    62  3.69 3.190 20.00     1      0     4     2
3  22.8      4 140.8    95  3.92 3.150 22.90     1      0     4     2
4  21.0      6 160.0   110  3.90 2.620 16.46     0      1     4     4
5  21.0      6 160.0   110  3.90 2.875 17.02     0      1     4     4
6  21.4      6 258.0   110  3.08 3.215 19.44     1      0     3     1
7  18.7      8 360.0   175  3.15 3.440 17.02     0      0     3     2
8  14.3      8 360.0   245  3.21 3.570 15.84     0      0     3     4


by_cyl <- group_by(mtcars, cyl)
do(by_cyl, head(., 2))

models <- by_cyl %>% do(mod = lm(mpg ~ disp, data = .))
models

summarise(models, rsq = summary(mod)$r.squared)
models %>% do(data.frame(coef = coef(.$mod)))
models %>% do(data.frame(
  var = names(coef(.$mod)),
  coef(summary(.$mod)))
)

models <- by_cyl %>% do(
  mod_linear = lm(mpg ~ disp, data = .),
  mod_quad = lm(mpg ~ poly(disp, 2), data = .)
)
models
compare <- models %>% do(aov = anova(.$mod_linear, .$mod_quad))
# compare %>% summarise(p.value = aov$`Pr(>F)`)

if (require("nycflights13")) {
# You can use it to do any arbitrary computation, like fitting a linear
# model. Let's explore how carrier departure delays vary over the time
carriers <- group_by(flights, carrier)
group_size(carriers)

mods <- do(carriers, mod = lm(arr_delay ~ dep_time, data = .))
mods %>% do(as.data.frame(coef(.$mod)))
mods %>% summarise(rsq = summary(mod)$r.squared)

## Not run: 
# This longer example shows the progress bar in action
by_dest <- flights %>% group_by(dest) %>% filter(n() > 100)
library(mgcv)
by_dest %>% do(smooth = gam(arr_delay ~ s(dep_time) + month, data = .))

## End(Not run)
}


by_cyl <- group_by(mtcars, cyl)
do(by_cyl, head(., 2))


library(xts)
data(sample_matrix)
xts_matrix<-as.xts(sample_matrix, descr ='my new xts object')
plot(xts_matrix[,1], main = "Our first xts plot",
cex.main = 0.8)

plot(xts_matrix, main = "Candle plot on xts object",
cex.main = 0.8, type = "candles")

plot(xts_matrix["2007-01-01::2007-02-12"],
main="An xts candle plot with subsetting",
cex.main=0.8,type="candles")

range<-"2007-03-15::2007-06-15"
plot(xts_matrix(range))


start_date <- "2007-05-05"
end_date <- "2007-12-31"
plot(xts_matrix[paste(start_date, "::",
end_date, sep = "")])
# Defaults to space separator
paste("Hello", "World", "in R")
## [1] "Hello World in R"
paste("Hello", "Again", sep = "**")


paste(c(1,2,3,4,5),collapse="oooo")

price_vector <- c(101.02, 101.03, 101.03, 101.04, 101.05,
101.03, 101.02, 101.01, 101.00, 100.99)
dates <- c("03/12/2013 08:00:00.532123",
"03/12/2013 08:00:01.982333",
"03/12/2013 08:00:01.650321",
"03/12/2013 08:00:02.402321",
"03/12/2013 08:00:02.540432",
"03/12/2013 08:00:03.004554",
"03/12/2013 08:00:03.900213",
"03/12/2013 08:00:04.050323",
"03/12/2013 08:00:04.430345",
"03/12/2013 08:00:05.700123")

# Allow the R console to display the microsecond field
options(digits.secs = 6)
# Create the time index with the correct format
time_index <- strptime(dates, format = "%d/%m/%Y %H:%M:%OS")
# Pass the time index into the its object
xts_price_vector <- xts(price_vector, time_index)


# Plot the price of the fictitious stock
plot(xts_price_vector, main = "Fictitious price series",
cex.main = 0.8)
# Add a horizontal line where the mean value is
abline(h = mean(xts_price_vector), lwd = 2)
# Add a vertical blue line at a specified time stamp
my_time <- as.POSIXct("03/12/2013 08:00:03.004554",
format = "%d/%m/%Y %H:%M:%OS")
abline(v = my_time, lwd = 2, lty = 2)



es_price <- c(1700.00, 1700.25, 1700.50, 1700.00, 1700.75,
1701.25, 1701.25, 1701.25, 1700.75, 1700.50)
es_time <- c("09/12/2013 08:00:00.532123",
"09/12/2013 08:00:01.982333",
"09/12/2013 08:00:05.650321",
"09/12/2013 08:10:02.402321",
"09/12/2013 08:12:02.540432",
"09/12/2013 08:12:03.004554",
"09/12/2013 08:14:03.900213",
"09/12/2013 08:15:07.090323",
"09/12/2013 08:16:04.430345",
"09/12/2013 08:18:05.700123")
# create an xts time series object
xts_es <- xts(es_price, as.POSIXct(es_time,
format = "%d/%m/%Y %H:%M:%OS"))
names(xts_es) <- c("price")



time_diff <- difftime(index(xts_es)[2], index(xts_es)[1],
units = "secs")
time_diff


diffs <- c()
for(i in 2:length(index(xts_es))){
diffs[i]<-difftime(index(xts_es)[i],index(xts_es)[i-1],
units="secs")
}
diffs



par(mfrow=c(2,1))
diffs<-as.numeric(diffs)
plot(diffs,main="TimedifferenceinsecondsforEStrades",
xlab="",ylab="Timedifferences",
cex.lab=0.8,
cex.main=0.8)
grid()
hist(diffs,main="TimedifferenceinsecondsforEStrades",
xlab="Time difference(secs)",ylab="Observations",
breaks=20,
cex.lab=0.8,
cex.main=0.8)
grid()


library(quantmod)
AAPL<-getSymbols("AAPL",auto.assign=FALSE)
head(AAPL)

chartSeries(AAPL, subset='2010::2010-04',
theme = chartTheme('white'),
TA = "addVo(); addBBands()")

reChart(subset='2009-01-01::2009-03-03')


chartSeries(AAPL, subset='2011::2012',
theme = chartTheme('white'),
TA = "addBBands(); addDEMA()")

addVo()
addDPO()


chartSeries(AAPL, theme = chartTheme('white'), TA = NULL)
# Custom function creation
my_indicator <- function(x) {
return(x + 90)
}


add_my_indicator<-newTA(FUN=my_indicator,preFUN=Cl,
legend.name="MyFancyIndicator",on=1)
add_my_indicator()


#Createamatrixwithpriceandvolume
df<-AAPL[,c("AAPL.Adjusted","AAPL.Volume")]
names(df)<-c("price","volume")

#Create
df$return<-diff(log(df[,1]))
df<-df[-1,]



Next , we will use the cut() function to create buckets of returns. We are specifi
cally interested in the magnitude of the returns. A total of three bucketswill be used
for this demonstration:
df$cuts <- cut(abs(df$return),


breaks=c(0,0.02,0.04,0.25),
include.lowest=TRUE)
#Createanothercolumnforthemean
df$means<-NA
for(iin1:3){
group<-which(df$cuts==i)
if(length(group)>0){
df$means[group]<-mean(df$volume[group])
}
}

# Load ggplot2
library(ggplot2)
ggplot(df) +
geom_histogram(aes(x=volume)) +
facet_grid(cuts ~ .) +
geom_vline(aes(xintercept=means), linetype="dashed", size=1)

https://www.quandl.com/data/XSHG-Shanghai-Stock-Exchange-Prices

600463


# Set the seed
set.seed(100)
X <- rnorm(1000000, mean = 2.33, sd = 0.5)
mu <- mean(X)
sd <- sd(X)
hist(X, breaks = 100)
abline(v = mu, lwd = 3, lty = 2)

sample5<-sample(X,5,replace=TRUE)
sample10<-sample(X,10,replace=TRUE)
sample50<-sample(X,50,replace=TRUE)

mean_list<-list()
for(i in 1:10000){
mean_list[[i]]<-mean(sample(X,10,replace=TRUE))
}
hist(unlist(mean_list),breaks=500,
xlab="Meanof10samplesfromX",
main="Convergenceofsampledistribution",
cex.main=0.8)
abline(v=mu,lwd=3,col="white",lty=2)


mean_list <- list()
for(i in 1:10000) {
	mean_list[[i]]<-mean(sample(population,10,replace=TRUE))
}
hist(unlist(mean_list),main="Distributionofaverages",
cex.main=0.8,
xlab="Averageof10samples")
abline(v=0.5,lwd=3)

# Unbiasedness and efficiency
population_variance <- function(x) {
mean <- sum(x) / length(x)
return(sum((x - mean) ^ 2) / length(x))
}
# Create a population
population <- as.numeric(1:100000)
variance <- population_variance(population)


output <- list()
for(i in 1:1000) {
output[[i]] <- population_variance(sample(population,
10, replace = TRUE))
}
variance_estimates <- unlist(output)
hist(variance_estimates, breaks = 100, cex.main = 0.9)
average_variance <- mean(variance_estimates)
abline(v = average_variance, , lty = 2, lwd = 2)
abline(v = variance, lwd = 2)



sample_variance<-function(x){
mean<-sum(x)/length(x)
return(sum((x-mean)^2)/(length(x)-1))
}
output<-list()
for(i in 1:1000){
output[[i]]<-sample_variance(sample(population,
10,replace=TRUE))
}
sample_variance_estimates<-unlist(output)
average_sample_variance<-mean(sample_variance_estimates)
average_sample_variance



plot(c(-1,1),c(0.5,0.5),type="h",lwd=3,
xlim=c(-2,2),main="Probabilitymassfunctionofcoin
toss",
ylab="Probability",
xlab="RandomVariable",
cex.main=0.9)

#Extractpricesandcomputestatistics
prices<-SPY$SPY.Adjusted
mean_prices<-round(mean(prices),2)
sd_prices<-round(sd(prices),2)
#Plotthehistogramalongwithalegend
hist(prices,breaks=100,prob=T,cex.main=0.9)
abline(v=mean_prices,lwd=2)
legend("topright",cex=0.8,border=NULL,bty="n",
paste("mean=",mean_prices,";sd=",sd_prices))

plot_4_ranges<-function(data,start_date,end_date,title){
#Settheplotwindowtobe2rowsand2columns
par(mfrow=c(2,2))
for(iin1:4){
#Createastringwiththeappropriatedaterange
range<-paste(start_date[i],"::",end_date[i],sep="")
#Createthepricevectorandnecessarystatistics
time_series<-data[range]
mean_data<-round(mean(time_series,na.rm=TRUE),3)
sd_data<-round(sd(time_series,na.rm=TRUE),3)
#Plotthehistogramalongwithalegend
hist_title<-paste(title,range)
hist(time_series,breaks=100,prob=TRUE,
xlab="",main=hist_title,cex.main=0.8)
legend("topright",cex=0.7,bty='n',
paste("mean=",mean_data,";sd=",sd_data))
}
#Resettheplotwindow
par(mfrow=c(1,1))
}


x<-seq(1:100)
y<-x^2
#Generatetheplot
plot(x,y)
#Fittheregression
reg_parabola<-lm(y~x)
#Superimposethebestfitlineontheplot
abline(reg_parabola,lwd=2)
#Lookattheresults
summary(reg_parabola)

plot(x, sqrt(y))
reg_transformed <- lm(sqrt(y) ~ x)
abline(reg_transformed)
summary(reg_transformed)


#Generate1000IIDnumbersfromanormaldistribution.
z<-rnorm(1000,0,1)
#Autocorrelationofreturnsandsquaredreturns
par(mfrow=c(2,1))
acf(z,main="returns",cex.main=0.8,
cex.lab=0.8,cex.axis=0.8)
grid()
acf(z^2,main="returnssquared",
cex.lab=0.8,cex.axis=0.8)
grid()


par(mfrow = c(1, 1))
acf(sv[, 1] ^ 2, main = "Actual returns squared",
cex.main = 0.8, cex.lab = 0.8, cex.axis = 0.8)
grid()

################
pepsi<-getSymbols('PEP',from='2013-01-01',
to='2014-01-01',adjust=T,auto.assign=FALSE)
coke<-getSymbols('COKE',from='2013-01-01',
to='2014-01-01',adjust=T,auto.assign=FALSE)
Sys.setenv(TZ="UTC")
prices<-cbind(pepsi[,6],coke[,6])
price_changes<-apply(prices,2,diff)
plot(price_changes[,1],price_changes[,2],
xlab="Cokepricechanges",
ylab="Pepsipricechanges",
main="Pepsivs.Coke",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
grid()

Ordinary Least Squares versus Total Least Squares

#Getthedata
SPY<-getSymbols('SPY',from='2011-01-01',
to='2012-12-31',adjust=T,auto.assign=FALSE)
AAPL<-getSymbols('AAPL',from='2011-01-01',
to='2012-12-31',adjust=T,auto.assign=FALSE)
#Computepricedifferences
x<-diff(as.numeric(SPY[,4]))
y<-diff(as.numeric(AAPL[,4]))
plot(x,y,main="Scatterplotofreturns.SPYvs.AAPL",
cex.main=0.8,cex.lab=0.8,cex.axis=0.8)
abline(lm(y~x))
abline(lm(x~y),lty=2)
grid()
#Totalleastsquaresregression
r<-prcomp(~x+y)
slope<-r$rotation[2,1]/r$rotation[1,1]
intercept<-r$center[2]-slope*r$center[1]
#Showthefirstprincipalcomponentontheplot
abline(a=intercept,b=slope,lty=3)



#Functiontocalculatethespread
calculate_spread<-function(x,y,beta){
return(y-beta*x)
}
#Functiontocalculatethebetaandlevel
#givenstartandenddates
calculate_beta_and_level<-function(x,y,
start_date,end_date){
require(xts)
time_range<-paste(start_date,"::",
end_date,sep="")
x<-x[time_range]
y<-y[time_range]
dx<-diff(x[time_range])
dy<-diff(y[time_range])
r<-prcomp(~dx+dy)
beta<-r$rotation[2,1]/r$rotation[1,1]
spread<-calculate_spread(x,y,beta)
names(spread)<-"spread"
level<-mean(spread,na.rm=TRUE)
outL<-list()
outL$spread<-spread
outL$beta<-beta
outL$level<-level
return(outL)
}
#Functiontocalculatebuyandsellsignals
#withupperandlowerthreshold
calculate_buy_sell_signals<-function(spread,beta,
level,lower_threshold,upper_threshold){
buy_signals<-ifelse(spread<=level
lower_threshold,1,0)
sell_signals<-ifelse(spread>=level+
upper_threshold,1,0)
#bindthesevectorsintoamatrix
output<-cbind(spread,buy_signals,
sell_signals)
colnames(output)<-c("spread","buy_signals",
"sell_signals")
return(output)
}


# Implementation
# Pick an in-sample date range
start_date <- "2009-01-01"
end_date <- "2011-12-31"
x <- SPY[, 6]
y <- AAPL[, 6]
results <- calculate_beta_and_level(x, y,
start_date, end_date)
results$beta
## [1] 4.923278
results$level
## [1] -239.0602
plot(results$spread, ylab = "Spread Value",
main = "AAPL - beta * SPY",
cex.main = 0.8,
cex.lab = 0.8,
cex.axis = 0.8)

#Outofsamplestartandenddates
start_date_out_sample<-"2012-01-01"
end_date_out_sample<-"2012-10-22"
range<-paste(start_date_out_sample,"::",
end_date_out_sample,sep="")
#Outofsampleanalysis
spread_out_of_sample<-calculate_spread(x[range],
y[range],results$beta)
plot(spread_out_of_sample,main="AAPL-beta*SPY",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
abline(h=results$level,lwd=2)


#Rollingwindowoftradingdays
window_length<-10
#Timerange
start_date<-"2011-01-01"
end_date<-"2011-12-31"
range<-paste(start_date,"::",
end_date,sep="")
#Ourstockpair
x<-SPY[range,6]
y<-AAPL[range,6]
dF<-cbind(x,y)
names(dF)<-c("x","y")
#Functionthatwewillusetocalculatebetas
run_regression<-function(dF){
return(coef(lm(y~x-1,data=as.data.frame(dF))))
}
rolling_beta<-function(z,width){
rollapply(z,width=width,FUN=run_regression,
by.column=FALSE,align="right")
}
betas<-rolling_beta(diff(dF),10)
data<-merge(betas,dF)
data$spread<-data$y-lag(betas,1)*data$x

returns<-diff(dF)/dF
return_beta<-rolling_beta(returns,10)
data$spreadR<-diff(data$y)/data$y
return_beta*diff(data$x)/data$x

threshold<-sd(data$spread,na.rm=TRUE)

plot(data$spread,main="AAPLvs.SPYIn-Sample",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
abline(h=threshold,lty=2)
abline(h=-threshold,lty=2)


################################
#Constructtheoutofsamplespread
#Keepthesame10dayrollingwindow
window_length<-10
#Timerange
start_date<-"2012-01-01"
end_date<-"2013-12-31"
range<-paste(start_date,"::",
end_date,sep="")
#Ourstockpair
x<-SPY[range,6]
y<-AAPL[range,6]
#Bindthesetogetherintoamatrix
dF<-cbind(x,y)
names(dF)<-c("x","y")
#Calculatetheoutofsamplerollingbeta
beta_out_of_sample<-rolling_beta(diff(dF),10)
#Buyandsellthreshold
data_out<-merge(beta_out_of_sample,dF)
data_out$spread<-data_out$y
lag(beta_out_of_sample,1)*data_out$x
#Plotthespreadwithin-samplebands
plot(data_out$spread,main="AAPLvs.SPYoutofsample",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
abline(h=threshold,lwd=2)
abline(h=-threshold,lwd=2)


#Generatesellandbuysignals
buys<-ifelse(data_out$spread>threshold,1,0)
sells<-ifelse(data_out$spread<-threshold,-1,0)
data_out$signal<-buys+sells


plot(data_out$spread,main="AAPLvs.SPYoutofsample",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
abline(h=threshold,lty=2)
abline(h=-threshold,lty=2)
point_type<-rep(NA,nrow(data_out))
buy_index<-which(data_out$signal==1)
sell_index<-which(data_out$signal==-1)
point_type[buy_index]<-21
point_type[sell_index]<-24
points(data_out$spread,pch=point_type)

num_of_buy_signals<-sum(buys,na.rm=TRUE)
num_of_sell_signals<-sum(abs(sells),na.rm=TRUE)

#################################################
prev_x_qty<-0
position<-0
trade_size<-100
signal<-as.numeric(data_out$signal)
signal[is.na(signal)]<-0
beta<-as.numeric(data_out$beta_out_of_sample)
qty_x<-rep(0,length(signal))
qty_y<-rep(0,length(signal))
for(iin1:length(signal)){
if(signal[i]==1&&position==0){
#buythespread
prev_x_qty<-round(beta[i]*trade_size)
qty_x[i]<--prev_x_qty
qty_y[i]<-trade_size
position<-1
}
if(signal[i]==-1&&position==0){
#sellthespreadinitially
prev_x_qty<-round(beta[i]*trade_size)
qty_x[i]<-prev_x_qty
qty_y[i]<--trade_size
position<--1
}
if(signal[i]==1&&position==-1){
#weareshortthespreadandneedtobuy
qty_x[i]<--(round(beta[i]*trade_size)+
prev_x_qty)
prev_x_qty<-round(beta[i]*trade_size)
qty_y[i]<-2*trade_size
position<-1
}
if(signal[i]==-1&&position==1){
#wearelongthespreadandneedtosell
qty_x[i]<-round(beta[i]*trade_size)+prev_x_qty
prev_x_qty<-round(beta[i]*trade_size)
qty_y[i]<- -2*trade_size
position<- -1
}
}

qty_x[length(qty_x)]<--sum(qty_x)
qty_y[length(qty_y)]<--sum(qty_y)


data_out$qty_x<-qty_x
data_out$qty_y<-qty_y


#functionforcomputingtheequitycurve
compute_equity_curve<-function(qty,price){
cash_buy<-ifelse(sign(qty)==1,
qty*price,0)
cash_sell<-ifelse(sign(qty)==-1,
-qty*price,0)
position<-cumsum(qty)
cumulative_buy<-cumsum(cash_buy)
cumulative_sell<-cumsum(cash_sell)
equity<-cumulative_sell-cumulative_buy+
position*price

return(equity)
}
#Addtheequitycurvecolumnstothedata_outtable
data_out$equity_curve_x<-compute_equity_curve(
data_out$qty_x,data_out$x)
data_out$equity_curve_y<-compute_equity_curve(
data_out$qty_y,data_out$y)


plot(data_out$equity_curve_x+
data_out$equity_curve_y,type='l',
main="AAPL/SPYspread",ylab="P&L",
cex.main=0.8,
cex.axis=0.8,
cex.lab=0.8)


#CalculatestheSharperatio
sharpe_ratio<-function(x,rf){
sharpe<-(mean(x,na.rm=TRUE)-rf)/
sd(x,na.rm=TRUE)
return(sharpe)
}
#Calculatesthemaximumdrawdownprofile
drawdown<-function(x){
cummax(x)-x
}


par(mfrow=c(2,1))
equity_curve<-data_out$equity_curve_x+data_out$equity_curve_y
plot(equity_curve,main="EquityCurve",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)
plot(drawdown(equity_curve),main="Drawdownofequitycurve",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)


equity<-as.numeric(equity_curve[,1])
equity_curve_returns<-diff(equity)/equity[-length(equity)]
#RemoveanyinfinitiesandNaN
invalid_values<-is.infinite(equity_curve_returns)
|is.nan(equity_curve_returns)
sharpe_ratio(equity_curve_returns[!invalid_values],0.03)

omega_ratio <- function(r, T) {
omega <- mean(pmax(r - T, 0)) / mean(pmax(T - r, 0))
return(omega)
}
	

###############################################
#Findoutwherethetradesoccur
trade_dates<-data_out$qty_x[data_out$qty_x!=0]
#Thetrade_datesobjectisanxtsobjectwhoseindex
#containsthenecessarytimeinformation
duration<-as.numeric(diff(index(trade_dates)))
#Summarystatistics
summary(duration)
##Min.1stQu.MedianMean3rdQu.Max.
##1.0013.5021.0031.8444.00128.00
#4.Histogramoftradeduration
hist(duration,breaks=20,
main="Histogramoftradedurations",
cex.main=0.8,
cex.lab=0.8,
cex.axis=0.8)


#####################################
x.date <- as.Date(paste(2003, 2, c(1, 3, 7, 9, 14), sep = "-"))
x <- zoo(rnorm(5), x.date)

## query index/time of a zoo object
index(x)
time(x)


x
index(x) <- as.POSIXct(format(time(x)),tz="")
x
index(x) <- 1:5
x
time(x) <- 6:10
x

## query start and end of a zoo object
start(x)
end(x)

## query index of a usual matrix
xm <- matrix(rnorm(10), ncol = 2)
index(xm)
time(x)



#Suppresseswarnings
options("getSymbols.warning4.0"=FALSE)
#Dosomehousecleaning
rm(list=ls(.blotter),envir=.blotter)
#Setthecurrencyandthetimezone
currency('USD')
Sys.setenv(TZ="UTC")
#Definesymbolsofinterest
symbols<-c("XLB",#SPDRMaterialssector
"XLE",#SPDREnergysector
"XLF",#SPDRFinancialsector
"XLP",#SPDRConsumerstaplessector
"XLI",#SPDRIndustrialsector
"XLU",#SPDRUtilitiessector
"XLV",#SPDRHealthcaresector
"XLK",#SPDRTechsector
"XLY",#SPDRConsumerdiscretionarysector
"RWR",#SPDRDowJonesREITETF
"EWJ",#iSharesJapan
"EWG",#iSharesGermany
"EWU",#iSharesUK
"EWC",#iSharesCanada
"EWY",#iSharesSouthKorea
"EWA",#iSharesAustralia
"EWH",#iSharesHongKong
"EWS",#iSharesSingapore
"IYZ",#iSharesU.S.Telecom
"EZU",#iSharesMSCIEMUETF
"IYR",#iSharesU.S.RealEstate
"EWT",#iSharesTaiwan
"EWZ",#iSharesBrazil
"EFA",#iSharesEAFE
"IGE",#iSharesNorthAmericanNaturalResources
"EPP",#iSharesPacificExJapan
"LQD",#iSharesInvestmentGradeCorporateBonds
"SHY",#iShares1-3yearTBonds
"IEF",#iShares3-7yearTBonds
"TLT"#iShares20+yearBonds
)
#SPDRETFsfirst,iSharesETFsafterwards
if(!"XLB"%in%ls()){
#Ifdataisnotpresent,getitfromyahoo
suppressMessages(getSymbols(symbols,from=from,
to=to,src="yahoo",adjust=TRUE))
}
#Definetheinstrumenttype
stock(symbols,currency="USD",multiplier=1)



#######################


library(microbenchmark)
install.packages("microbenchmark")

sum_with_loop_in_r <- function(max_value) {
sum <- 0
for(i in 1:max_value) {
sum <- sum + i
}
return(sum)
}
sum_with_vectorization_in_r = function(max_value) {
numbers <- as.double(1:max_value)
return(sum(numbers))
}
library(microbenchmark)
microbenchmark(loop = sum_with_loop_in_r(1e5),
vectorized = sum_with_vectorization_in_r(1e5))


Most of the R code we write is interpreted code. The compiler package
allows us to compile certain functions within R, thus making them faster to
execute during runtime. More information on this package can be found here:
http://homepage.stat.uiowa.edu/luke/R/compiler/compiler.pdf. The compiler utility has been available since R version 2.13.0.
require(compiler)

compiled_sum_with_loop_in_r<-cmpfun(sum_with_loop_in_r)
microbenchmark(loop=sum_with_loop_in_r(1e5),
compiled=compiled_sum_with_loop_in_r(1e5),
vectorized=sum_with_vectorization_in_r(1e5))


my_data = data.frame (returns = c(0.03, 0.04, 0.05, 0.032, 0.01,
0.23, 0.4, 0.05, 0.066, 0.5),
stock = c ("SPY", "CVX", "CVX", "SPY", "XOM",
"XOM", "CVX", "SPY", "SPY", "XOM"))
ggplot (my_data, aes (x=returns, fill=stock)) +
geom_density (alpha = 0.2)



fun1 <- function(x)
{
    # your logic
    return(rt1.xts)
}
fun2 <- function(x)
{
    # your logic
    return(rt2.xts)
}
fun3 <- function(x)
{
    # your logic
    return(rt3.xts)
}

ta1 <- newTA(FUN=fun1,on=1,...)
ta2 <- newTA(FUN=fun2,...)
ta3 <- newTA(FUN=fun3,...)

cn.theme <- chartTheme(up.col = "red",dn.col = "green")
chartSeries(rc.xts,name="",theme=cn.theme,TA=c(ta1(),ta2(),ta3(),addBBands(n=26)))

作者：于飞
链接：https://www.zhihu.com/question/40693419/answer/87834108
来源：知乎
著作权归作者所有，转载请联系作者获得授权。


addBBands2<-
function (n = 20, sd = 2, maType = "SMA", draw = "bands", on = -1) 
{
    draw.options <- c("bands", "percent", "width")
    draw <- draw.options[pmatch(draw, draw.options)]
    lchob <- get.current.chob()
    x <- as.matrix(lchob@xdata)
    chobTA <- new("chobTA")
    if (draw == "bands") {
        chobTA@new <- FALSE
    }
    else {
        chobTA@new <- TRUE
        on <- NULL
    }
    xx <- if (is.OHLC(x)) {
        cbind(Hi(x), Lo(x), Cl(x))
    }
    else x
    bb <- BBands(xx, n = n, maType = maType, sd = sd)
    chobTA@TA.values <- bb[lchob@xsubset, ]
    chobTA@name <- "chartBBands"
    chobTA@call <- match.call()
    chobTA@on <- on
    chobTA@params <- list(xrange = lchob@xrange, colors = lchob@colors, 
        color.vol = lchob@color.vol, multi.col = lchob@multi.col, 
        spacing = lchob@spacing, width = lchob@width, bp = lchob@bp, 
        x.labels = lchob@x.labels, time.scale = lchob@time.scale, 
        n = n, ma = maType, sd = sd, draw = draw)
    return(chobTA)
}
