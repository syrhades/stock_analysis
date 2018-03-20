The Book of R: A First Course in Programming and Statistics

http://static.sse.com.cn/disclosure/listedinfo/announcement/c/2016-04-29/600031_2015_n.pdf

EDI服务器操作系统为linux，远程连接IP: 122.144.131.93 远程端口：2233   服务器系统root密码为：Dell123
ssh root@122.144.131.93 -p 2233

http://www.nasdaq.com/symbol/aapl/financials?query=income-statement




java -jar pdfbox-app-2.0.3.jar ExtractText -html 600031_2015_n.pdf

java -jar pdfbox-app-2.0.3.jar ExtractText  600031_2015_n.pdf 600031.txt

R: Easy R Programming for Beginners, Your Step-By-Step Guide To Learning R Progr (R Programming Series
R For Dummies
R Graphics Cookbook
An Introduction to Statistical Learning: with Applications in R 
R for Data Science
R for Everyone: Advanced Analytics and Graphics
Learning R
Advanced R 
Machine Learning with R
Discovering Statistics Using R
Practical Data Science with R
Statistics: An Introduction Using R
The R Book
R for Marketing Research and Analytics (Use R!)
A Beginner's Guide to R '
Mastering Predictive Analytics with R
R Packages
Hands-On Programming with R: Write Your Own Functions and Simulations
R in a Nutshell
100 Statistical Tests: in R
An Introduction to R for Spatial Analysis and Mapping
Statistics (The Easier Way) with R: an informal text on applied statistics

Machine Learning with R
Quantitative Trading with R: Understanding Mathematical and Computational Tools from a Quant’s Perspective
R in 24 Hours, Sams Teach Yourself
R: Learn R Programming In A DAY! - The Ultimate Crash Course to Learning the Basics of the R Programming Language
Introductory Time Series with R
R for Excel Users: An Introduction to R for Excel Analysts
Introductory Statistics with R (Statistics and Computing)
A Handbook of Statistical Analyses Using R
R Data Mining Projects
A First Course in Statistical Programming with R
R Programming for Data Science
A Modern Approach to Regression with R (Springer Texts in Statistics)
R Machine Learning By Example
Data Mining with Rattle and R: The Art of Excavating Data for Knowledge Discovery (Use R!)
Statistical Computing with R (Chapman & Hall/CRC The R Series)
Simulation for Data Science with R
Automated Data Collection with R: A Practical Guide to Web Scraping and Text Mining
R for SAS and SPSS Users (Statistics and Computing)
The R Student Companion
R Cookbook
R Deep Learning Essentials
An R and S-Plus® Companion to Multivariate Analysis
Learning Base R
Data Analysis with R
Data Mining and Business Analytics with R
Big Data Analytics with R
Multilevel Modeling Using R
Deep Learning Made Easy with R: A Gentle Introduction For Data Science
Applied Predictive Modeling
Essentials of Modern Business Statistics with Microsoft Excel
Deep Learning Made Easy with R: Breakthrough Techniuqes to Transform Performance
Statistical Analysis of Network Data with R (Use R!)
Data Science in R: A Case Studies Approach to Computational Reasoning and Problem Solving 
92 Applied Predictive Modeling Techniques in R: With step by step instructions on how to build them FAST!
Mixed Effects Models and Extensions in Ecology with R
Introducing Monte Carlo Methods with R (Use R!)
Text Analysis with R for Students of Literature (Quantitative Methods in the Humanities and Social Sciences)

Modeling Techniques in Predictive Analytics with Python and R: A Guide to Data Science (FT Press Analytics)
A User’s Guide to Network Analysis in R
Introduction to Scientific Programming and Simulation Using R
Marketing Data Science: Modeling Techniques in Predictive Analytics with R and Python (FT Press Analytics)
Probability and Statistics with R
R High Performance Programming
Mastering Social Media Mining with R














s o m e _ l i s t < - l i s t ( )
f o r ( z i n c ( " h e l l o " , " g o o d b y e " ) ) {
s o m e _ l i s t [ [ z ] ] < - z
}
s o m e _ l i s t
# # $ h e l l o
# # [ 1 ] " h e l l o "
# # $ g o o d b y e
# # [ 1 ] " g o o d b y e "


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

match(x, table, nomatch = NA_integer_, incomparables = NULL)

x %in% table
Arguments

x	
vector or NULL: the values to be matched. Long vectors are supported.

table	
vector or NULL: the values to be matched against. Long vectors are not supported.

nomatch	
the value to be returned in the case when no match is found. Note that it is coerced to integer.

incomparables	
a vector of values that cannot be matched. Any value in x matching a value in this vector is assigned the nomatch value. For historical reasons, FALSE is equivalent to NULL.


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



aapl<-read.table("clipboard")
#OnMac/Linux
aapl<-read.table(pipe("pbpaste"))


aapl<-aapl[rev(rownames(aapl)),,drop=FALSE]
prices<-aapl$V1
plot(prices,main="AAPLplot",type='l')

#Loadthe.csvfile
aapl_2<-read.csv(file="path/aapl.csv",header=TRUE,
stringsAsFactors=FALSE)
#Reversetheentries
aapl_2<-aapl_2[rev(rownames(aapl_2)),]
Thistimearound,wespecifiedthatheadersarepresentintheinputfile.Rknows
tocallthecolumnsbytheircorrectnames,andifwewanttoextracttheclosing
price,thefollowingcommandsuffices:
aapl_close<-aapl_2[,"Close"]
Togetsomequicksummarystatisticsintabularformat,wecanutilizethe
summary()function.
summary(aapl_close)
##Min.1stQu.MedianMean3rdQu.Max.
##11.0025.5040.5096.2977.00702.10

To install quantmod, open up an R console and enter the following command:
install.packages("quantmod") . Notice the quotes around the package name.
Here is a full list of what the install.packages() function arguments are:
install.packages(pkgs, lib, repos = getOption("repos"),
contriburl = contrib.url(repos, type),
method, available = NULL, destdir = NULL,
dependencies = NA, type = getOption("pkgType"),
configure.args = getOption("configure.args"),
configure.vars = getOption("configure.vars"),
clean = FALSE, Ncpus = getOption("Ncpus", 1L),
verbose = getOption("verbose"),
libs_only = FALSE, INSTALL_opts, quiet = FALSE,
keep_outputs = FALSE, ...)

{
"CVX":
{
"Currency": "USD",
"Sector": "Basic Materials",
"Industry": "Major Integrated Oil & Gas"
},
"GOOG":
{
"Currency": "USD",
"Sector": "Technology",
"Industry": "Internet Information Providers"
}
}




Thisfilecanbelocallysavedandthen,viatheRJSONIOpackage,parsedintoa
listobject.
#Installandloadthepackage
install.packages("RJSONIO")
library(RJSONIO)
#Readthefile
out<-fromJSON(content="path/sample_json_file.json")
#Lookatthestructureoftheresultingobject
str(out)
##Listof2
##$CVX:Namedchr[1:3]"USD""BasicMaterials...
##..-attr(*,"names")=chr[1:3]"Currency"...
##$GOOG:Namedchr[1:3]"USD""Technology"...
##..-attr(*,"names")=chr[1:3]"Currency"...

write.csv(aapl_2,file="path/aapl_2.csv")
Thisfileregistersas455KBondisk.
save(aapl_2,file="path/aapl_2.rdata")


aapl_old<-aapl_2
rm(aapl_2)
load(file="path/aapl_2.rdata")
Theidentical()commandcanbeusedtocheckwhethertheobjectsarethe
same.
identical(aapl_old,aapl_2)
##[1]TRUE

Toillustratethefunctionality,wewillusean.xlsxworkbookconsistingoftwo
sheets.Thefirstsheetisnamedsignals,andthesecondsheetisnamedstrength.The
workbookitselfisnamedstrategy.xlsx.
library(XLConnect)
#Createaworkbookobject
book<-loadWorkbook("path/strategy.xlsx")
#Convertitintoadataframe
signals=readWorksheet(book,sheet="signals",header
=TRUE)
signals
##timesignal1signal2
##108:30:000.43-0.20
##208:31:000.540.33
##308:32:000.32-0.21
strength=readWorksheet(book,sheet="strength",header
=TRUE)
strength
##intensityscore
##127.5
##238.4
##365.4
ItisalsopossibletocreateaworkbookandpopulateitwithdatafromR.
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

FormoreinformationonhowtoworkwithExcelfilesinR,thepostbyNicola
SturaroSommacalonhttp://www.r-bloggers.com/read-excel-files-from-r/isuseful.


RODBCpackage,thesecondmethodusestheRMySQLpackage,and
thethirdmethodexploresthedplyrpackage

#LoadtheRODBCpackage
require(RODBC)
#EstablishaconnectiontoMySQL
con<-odbcConnect("rfortraders")
#Choosethedatabasenameandtablename
database_name<-"OptionsData"
table_name<-"ATMVolatilities"
symbol<-"SPY"
sql_command<-paste0("SELECTSymbol,Date,Maturity,
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
#Closetheconnection
dbDisconnect(con)


#GettheCRANversion
install.packages("dplyr")
require(dplyr)
#Or,firstloaddevtools
install.packages("devtools")
require(devtools)
#Getthegithubversion
devtools::install_github("hadley/dplyr")
require(dplyr)



Thebeautyoftheimplementationisthatthedetailsoftheunderlyingdatacon
tainersareabstractedawayfromtheuser.Thetbl()structureisusedasatabular
proxyforthedataextractedfromthelistedrepos.
Herearesomeimportantcommandstobeawareofwhendealingwithdplyr:
•tbl()
•groupby()
•summarise()
•do()
•%>%

#Loadtheflightdatabasethatcomeswithdplyr
library(hflights)
#Lookatnumberofrowsandcolumns
dim(hflights)
##[1]22749621

Arowinthisdataframelookslikethis:
Whatwewanttodoatthispointiscalculateaggregatestatisticsonacertain
subsetofthedata.Asaninitialstep,thedatawillbecoercedintoadata.table
[72].9Wecouldhaveeasilycoercedthedataintoadataframeinstead.
#First,coercethedataintoadata.table
flights_dt<-tbl_df(hflights)
#Whattypeofobjectisthis?
class(flights_dt)
##[1]"tbl_dt""tbl""data.table""data.frame"
Tofindthemedianarrivaldelaytimeforallcarriers,webeginbygroupingthe
databycarrier:

#Createagroupingbycarrier
carrier_group<-group_by(flights_dt,UniqueCarrier)
#Nowcomputethesummarystatistics
summarise(carrier_group,avg_delay=mean(ArrDelay,na.rm
=TRUE))


Thedo()functionallowsonetoapplyanarbitraryfunctiontoagroupofdata.
The%>%operatorcanbeusedtochaintheresultstogether.Anexampleofthiscan
beseenbytyping?dointheRconsole.
ThemasteringofdplyrissomethingIwholeheartedlyrecommendtoallaspiring
dataanalysts.Itshouldbeapartofanydatafilteringordataanalysisworkflow
conductedinR.Itcantakeawhile,however,togetusedtothetidydataparadigm
ofdatamanipulation.Idoconsiderthisanintermediate-leveltopic,andassuch,I
willleaveituptothereadertoexplorethefullgloryofdplyrinmoredetail.





#loadthelibraryxts
library(xts)
#Loadasmalldatasetthatcomesalongwithxts.
#Wecouldhaveusedouroriginal.csvfileaswell.
data(sample_matrix)
#Lookatthedata
head(sample_matrix)
##[1]"matrix"
#Whatisthetypeofthisobject?
class(sample_matrix)
##[1]"matrix"
#Usethestr()commandtogetmoredetailsaboutthisobject.
str(sample_matrix)
##num[1:180,1:4]5050.250.450.450.2...
##-attr(*,"dimnames")=Listof2
##..$:chr[1:180]"2007-01-02""2007-01-03"
##"2007-01-04""2007-01-05"...
##..$:chr[1:4]"Open""High""Low""Close"

xts_matrix<-as.xts(sample_matrix,descr='mynewxtsobject')
Adescriptionisnotrequiredaspartofthedeclaration.Thisisanoptional
parameter.Usingthestr()commandonemoretimeonxtsmatrix
str(xts_matrix}
##An'xts'objecton2007-01-02/2007-06-30containing:
##Data:num[1:180,1:4]5050.250.450.450.2...
##-attr(*,"dimnames")=Listof2
##..$:NULL
##..$:chr[1:4]"Open""High""Low""Close"
##Indexedbyobjectsofclass:[POSIXct,POSIXt]TZ:
##xtsAttributes:
##Listof3
##$tclass:chr[1:2]"POSIXct""POSIXt"
##$tzone:chr""
##$descr:chr"mynewxtsobject"

#Simpleplot
plot(xts_matrix[,1],main="Ourfirstxtsplot",
cex.main=0.8)
#Orwecantrysomethingfancier.
plot(xts_matrix,main="Candleplotonxtsobject",
cex.main=0.8,type="candles")

plot(xts_matrix["2007-01-01::2007-02-12"],
main="Anxtscandleplotwithsubsetting",
cex.main=0.8,type="candles")

Noticethesinglestringargumentthatispassedtothepricematrix.This
time-basedformattingmakesiteasytoworkwithhumanreadabledatesastime
boundaries.
range<-"2007-03-15::2007-06-15"
plot(xts_matrix(range))
Thepaste()functionisusefulforconcatenatingstringstogether.Ittakesthe
inputargumentsandpastesthemtogether.Bydefault,itwillseparatethestrings
withaspace,unlessonespecifiessep="".
start_date<-"2007-05-05"
end_date<-"2007-12-31"
plot(xts_matrix[paste(start_date,"::",
end_date,sep="")])
#Defaultstospaceseparator
paste("Hello","World","inR")
##[1]"HelloWorldinR"
paste("Hello","Again",sep="**")
paste(c(1,2,3,4,5),collapse="oooo")
##[1]"1oooo2oooo3oooo4oooo5"

#Createavectorof10fictitiousstockpricesalongwith
#atimeindexinmicrosecondresolution.
price_vector<-c(101.02,101.03,101.03,101.04,101.05,
101.03,101.02,101.01,101.00,100.99)
dates<-c("03/12/201308:00:00.532123",
"03/12/201308:00:01.982333",
"03/12/201308:00:01.650321",
"03/12/201308:00:02.402321",
"03/12/201308:00:02.540432",
"03/12/201308:00:03.004554",
"03/12/201308:00:03.900213",
"03/12/201308:00:04.050323",
"03/12/201308:00:04.430345",
"03/12/201308:00:05.700123")
#AllowtheRconsoletodisplaythemicrosecondfield
options(digits.secs=6)
#Createthetimeindexwiththecorrectformat
time_index<-strptime(dates,format="%d/%m/%Y%H:%M:%OS")
#Passthetimeindexintotheitsobject
xts_price_vector<-xts(price_vector,time_index)


#Plotthepriceofthefictitiousstock
plot(xts_price_vector,main="Fictitiouspriceseries",
cex.main=0.8)
#Addahorizontallinewherethemeanvalueis
abline(h=mean(xts_price_vector),lwd=2)
#Addaverticalbluelineataspecifiedtimestamp
my_time<-as.POSIXct("03/12/201308:00:03.004554",
format="%d/%m/%Y%H:%M:%OS")
abline(v=my_time,lwd=2,lty=2)

es_price<-c(1700.00,1700.25,1700.50,1700.00,1700.75,
1701.25,1701.25,1701.25,1700.75,1700.50)
es_time<-c("09/12/201308:00:00.532123",
"09/12/201308:00:01.982333",
"09/12/201308:00:05.650321",
"09/12/201308:10:02.402321",
"09/12/201308:12:02.540432",
"09/12/201308:12:03.004554",
"09/12/201308:14:03.900213",
"09/12/201308:15:07.090323",
"09/12/201308:16:04.430345",
"09/12/201308:18:05.700123")
#createanxtstimeseriesobject
xts_es<-xts(es_price,as.POSIXct(es_time,
format="%d/%m/%Y%H:%M:%OS"))
names(xts_es)<-c("price")

Onemetricofinterestthatcomesupinhigh-frequencytradingisthetradeorder
arrivalrate.Wecanexplorethismetricbylookingatthesuccessivedifferencesin
timestampsbetweentrades.Thedifftime()functioncomputesthetimediffer
encebetweentwodate-timeobjects.Thisexamplesetsthetimeunitexplicitlyto
seconds.Thedefaultsettingalsohappenstobethesame.
time_diff<-difftime(index(xts_es)[2],index(xts_es)[1],
units="secs")
time_diff
##Timedifferenceof1.45021secs
Wecancreatealoopthatwillgothroughallthepairsandthenstoretheresults
inavector.
diffs<-c()

for(iin2:length(index(xts_es))){
diffs[i]<-difftime(index(xts_es)[i],index(xts_es)[i-1],
units="secs")
}
Thiswillcertainlywork,butitisnottheoptimalwaytoobtaintheanswer.Here
isavectorizedsolution:
diffs<-index(xts_es)[-1]-index(xts_es)[-length(index(xts_es))]
diffs
##Timedifferencesinsecs
##[1]1.45020993.6679881596.7520001
##[4]120.13811090.4641221120.8956590
##[7]63.190110057.3400221121.2697780
##attr(,"tzone")
class(diffs)
##[1]"difftime"

Theabovelineofcodecanfurtherbeoptimizedbycallingtheindex()function
onceinsteadofthreetimes.
es_times<-index(xts_es)
diffs<-es_times[-1]-es_times[-length(es_times)]
diffs
##Timedifferencesinsecs
##[1]1.45020993.6679881596.7520001
##[4]120.13811090.4641221120.8956590
##[7]63.190110057.3400221121.2697780
##attr(,"tzone")

par(mfrow=c(2,1))
diffs<-as.numeric(diffs)
plot(diffs,main="TimedifferenceinsecondsforEStrades",
xlab="",ylab="Timedifferences",
cex.lab=0.8,
cex.main=0.8)
grid()
hist(diffs,main="TimedifferenceinsecondsforEStrades",


#Loadthequantmodpackagesafterinstallingitlocally.
library(quantmod)
AAPL<-getSymbols("AAPL",auto.assign=FALSE)
head(AAPL)


Theauto.assignparameterallowsforthereturnedobjecttobestoredinalocal
variableratherthantheRsession’s.GlobalEnv.Someoftheotherargumentsto
getSymbols()are:src,time,andverbose.
Thesrcargumentspecifiesthesourceoftheinputdata.Itcanbesettoextract
informationfromsourcessuchas:
•Yahoo
•Google
•Fred
•Oanda
•mysql
•.csvfiles
Thetimeargumentcanbeoftheform''2011/''or''2010-08-09::2010-08-12''.

#Addingsometechnicalindicatorsontopoftheoriginalplot
chartSeries(AAPL,subset='2010::2010-04',
theme=chartTheme('white'),
TA="addVo();addBBands()")
ThereChart()functioncanbeusedtoupdatetheoriginalchartwithout
specifyingthefullsetofarguments:
reChart(subset='2009-01-01::2009-03-03')
Thequantmodpackageexposesarangeoftechnicalindicatorsthatcanseam
lesslybeaddedontopofanychart.ThesetechnicalindicatorsresidewithintheTTR
packagethatwasauthoredbyJoshUlrich[59].TTRisoneofthosedependencies
thatisautomaticallyloadedduringthequantmodinstallationprocess.
chartSeries(AAPL,subset='2011::2012',
theme=chartTheme('white'),
TA="addBBands();addDEMA()")
Technicalindicatorscanalsobeinvokedafterthecharthasbeendrawnbyusing

addVo()
addDPO()
TwomorefunctionsthataredefinitelyworthexploringareaddTA()and
newTA().Theseallowthecreationofcustomindicatorsthatcanberenderedin
asubchartoroverlaidontothemainplot.
Inthisnextexample,wewillplotthepriceofAAPLwithoutanytechnicalindica
tors,andthenwewillcreateacustomindicatorthatusestheclosepriceofthestock.
Thecustomindicatorsimplyadds90totheexistingprice.Onecan,ofcourse,use
thismethodtocreatearbitrarilycomplexindicators.
#Initialchartplotwithnoindicators
chartSeries(AAPL,theme=chartTheme('white'),TA=NULL)
#Customfunctioncreation
my_indicator<-function(x){
return(x+90)
}
add_my_indicator<-newTA(FUN=my_indicator,preFUN=Cl,
legend.name="MyFancyIndicator",on=1)
add_my_indicator()





>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


The simplest and most commonly used family member is lapply, short for “list apply.”
lapply takes a list and a function as inputs, applies the function to each element of the
list in turn, and returns another list of results. Recall our prime factorization list from
Chapter 5:
prime_factors <-  list(
 two = 2,
 three = 3,
 four = c(2, 2),
 five = 5,
 six = c(2, 3),
 seven = 7,
 eight = c(2, 2, 2),
 nine = c(3, 3),
 ten = c(2, 5)
)




lapply(prime_factors,  unique)

you can use a variant of lapply called vapply. vapply stands for “list apply
that returns a vector.” As before, you pass it a list and a function, but vapply takes a
third argument that is a template for the return values. Rather than returning a list, it
simplifies the result to be a vector or an array:
vapply(prime_factors,  length,  numeric(1))
## two three four five six seven eight nine ten
## 1 1 2 1 2 1 3 2 2

sapply(prime_factors,  unique) #returns a list
sapply(prime_factors,  length) #returns a vector
sapply(prime_factors,  summary) #returns an array


complemented <-  c(2, 3, 6, 18) #See http://oeis.org/A000614
lapply(complemented,  rep.int,  times = 4)

rep4x <- function(x) rep.int(4,  times = x)
lapply(complemented,  rep4x)


lapply(complemented, function(x) rep.int(4,  times = x))

The three functions treat the matrices and arrays as
though they were vectors, applying the target function to each element one at a time
(moving down columns). More commonly, when we want to apply a function to an
array, we want to apply it by row or by column. This next example uses the matlab
package, which gives some functionality ported from the rival language.
To run the next example, you first need to install the matlab package

magic4 <-  magic(4)
apply(magic4, 1,  sum)
apply(magic4, 1,  toString)
apply(magic4, 2,  toString)


apply can also be used on data frames, though the mixed-data-type nature means that
this is less common (for example, you can’t sensibly calculate a sum or a product when
there are character columns):



(baldwins <-  data.frame(
name = c("Alec" , "Daniel" , "Billy" , "Stephen" ),
date_of_birth = c(
"1958-Apr-03" , "1960-Oct-05" , "1963-Feb-21" , "1966-May-12"
),
n_spouses = c(2, 3, 1, 1),
n_children = c(1, 5, 3, 2),
stringsAsFactors = FALSE
))
## name date_of_birth n_spouses n_children
## 1 Alec 1958-Apr-03 2 1
## 2 Daniel 1960-Oct-05 3 5
## 3 Billy 1963-Feb-21 1 3
## 4 Stephen 1966-May-12 1 2
apply(baldwins, 1,  toString)
## [1] "Alec, 1958-Apr-03, 2, 1" "Daniel, 1960-Oct-05, 3, 5"
## [3] "Billy, 1963-Feb-21, 1, 3" "Stephen, 1966-May-12, 1, 2"
apply(baldwins, 2,  toString)
## name
## "Alec, Daniel, Billy, Stephen"
## date_of_birth
## "1958-Apr-03, 1960-Oct-05, 1963-Feb-21, 1966-May-12"
## n_spouses
## "2, 3, 1, 1"
## n_children
## "1, 5, 3, 2"

When applied to a data frame by column, apply behaves identically to sapply (remem‐
ber that data frames can be thought of as nonnested lists where the elements are of the
same length):
sapply(baldwins,  toString)
## name
## "Alec, Daniel, Billy, Stephen"
## date_of_birth

Of course, simply printing a dataset in different forms isn’t that interesting. Using sapply
combined with range, on the other hand, is a great way to quickly determine the extent
of your data:
sapply(baldwins,  range)
## name date_of_birth n_spouses n_children
## [1,] "Alec" "1958-Apr-03" "1" "1"
## [2,] "Stephen" "1966-May-12" "3" "5"



The function mapply, short for “multiple argument list apply,” lets you pass in as many
vectors as you like, solving the first problem. A common usage is to pass in a list in one
argument and the names of that list in another, solving the second problem. One little
annoyance is that in order to accommodate an arbitrary number of vector arguments,
the order of the arguments has been changed. For mapply, the function is passed as the
first argument:

msg <- function(name,  factors)
{
ifelse(
length(factors) == 1,
paste(name, "is prime" ),
paste(name, "has factors" ,  toString(factors))
)
}
mapply(msg,  names(prime_factors),  prime_factors)
## two three
## "two is prime" "three is prime"
## four five
## "four has factors 2, 2" "five is prime"
## six seven
## "six has factors 2, 3" "seven is prime"
## eight nine
## "eight has factors 2, 2, 2" "nine has factors 3, 3"
## ten
## "ten has factors 2, 5"

test_add<-function(arg1,arg2){
  arg1+arg2
}
df1<-data.frame(
n_spouses = c(2, 3, 1, 1),
n_children = c(1, 5, 3, 2),
stringsAsFactors = FALSE
)
mapply(test_add,df1[,1],df1[,2])



baby_gender_report <- function(gender)
{
 switch(
 gender,
 male = "It's a boy!" ,
 female = "It's a girl!" ,
 "Um..."
 )
}


If we pass a vector into the function, it will throw an error:
genders <-  c("male" , "female" , "other" )
baby_gender_report(genders)
While it is theoretically possible to do a complete rewrite of a function that is inherently
vectorized, it is easier to use the Vectorize function:
vectorized_baby_gender_report <-  Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)
## male female other
## "It's a boy!" "It's a girl!" "Um..."

> vectorized_baby_gender_report
function (gender) 
{
    args <- lapply(as.list(match.call())[-1L], eval, parent.frame())
    names <- if (is.null(names(args))) 
        character(length(args))
    else names(args)
    dovec <- names %in% vectorize.args
    do.call("mapply", c(FUN = FUN, args[dovec], MoreArgs = list(args[!dovec]), 
        SIMPLIFY = SIMPLIFY, USE.NAMES = USE.NAMES))
}
<environment: 0x00000000144cf5c0>

Split-Apply-Combine
A really common problem when investigating data is how to calculate some statistic on
a variable that has been split into groups. Here are some scores on the classic road safety
awareness computer game, Frogger:

frogger_scores <-  data.frame(
 player = rep(c("Tom" , "Dick" , "Harry" ),  times = c(2, 5, 3)),
 score = round(rlnorm(10, 8), -1)
)

If we want to calculate the mean score for each player, then there are three steps. First,
we split the dataset by player:


scores_by_player <-  with(
 frogger_scores,
 split(score,  player)
)

Next we apply the (mean) function to each element:
(list_of_means_by_player <-  lapply(scores_by_player,  mean))

Finally, we combine the result into a single vector:
(mean_by_player <-  unlist(list_of_means_by_player))
## Dick Harry Tom
## 2368 3387 1880
The last two steps can be condensed into one by using vapply or sapply, but split-applycombine is such a common task that we need something easier. That something is the
tapply function, which performs all three steps in one go:
with(frogger_scores,  tapply(score,  player,  mean))
## Dick Harry Tom
## 2368 3387 1880

The plyr Package

This is where the plyr package comes in handy. The package contains a set of functions
named **ply, where the blanks (asterisks) denote the form of the input and output,
respectively. So, llply takes a list input, applies a function to each element, and returns
a list, making it a drop-in replacement for lapply


library(plyr)
llply(prime_factors,  unique)

laply takes a list and returns an array, mimicking sapply. In the case of an empty input,
it does the smart thing and returns an empty logical vector (unlike sapply, which returns
an empty list):
laply(prime_factors,  length)
## [1] 1 1 2 1 2 1 3 2 2
laply(list(),  length)
## logical(0)


raply replaces replicate (not rapply!), but there are also rlply and rdply functions
that let you return the result in list or data frame form, and an r_ply function that
discards the result (useful for drawing plots):
raply(5,  runif(1)) #array output
## [1] 0.009415 0.226514 0.133015 0.698586 0.112846
rlply(5,  runif(1)) #list output
## [[1]]
## [1] 0.6646
##
## [[2]]
## [1] 0.2304
##
## [[3]]
## [1] 0.613
##
## [[4]]
## [1] 0.5532
##
## [[5]]
## [1] 0.3654
rdply(5,  runif(1)) #data frame output
## .n V1
## 1 1 0.9068
## 2 2 0.0654
## 3 3 0.3788
## 4 4 0.5086
## 5 5 0.3502
r_ply(5,  runif(1)) #discarded output
## NULL


Perhaps the most commonly used function in plyr is ddply, which takes data frames
as inputs and outputs and can be used as a replacement for tapply. Its big strength is
that it makes it easy to make calculations on several columns at once. Let’s add a level
column to the Frogger dataset, denoting the level the player reached in the game:
frogger_scores$level <-  floor(log(frogger_scores$score))
There are several different ways of calling ddply. All methods take a data frame, the
name of the column(s) to split by, and the function to apply to each piece. The column
is passed without quotes, but wrapped in a call to the .  function.
For the function, you can either use colwise to tell ddply to call the function on every
column (that you didn’t mention in the second argument), or use summarize and specify
manipulations of specific columns:
ddply(
frogger_scores,
. (player),
colwise(mean) #call mean on every column except player
)
## player score level
## 1 Dick 2368 7.200
## 2 Harry 3387 7.333
## 3 Tom 1880 7.000
ddply(
frogger_scores,
. (player),
summarize,
mean_score = mean(score), #call mean on score
max_level = max(level) #... and max on level
)
## player mean_score max_level
## 1 Dick 2368 8
## 2 Harry 3387 8
## 3 Tom 1880 7
colwise is quicker to specify, but you have to do the same thing with each column,
whereas summarize is more flexible but requires more typing.
There is no direct replacement for mapply, though the m*ply functions allow looping
with multiple arguments. Likewise, there is no replacement for vapply or rapply.

===========================================

if(TRUE) message("It was true!" )
## It was true!
if(FALSE) message("It wasn't true!" )

if(NA) message("Who knows if it was true?" )
## Error: missing value where TRUE/FALSE needed
if(is.na(NA)) message("The value is missing!" )
## The value is missing!
if(runif(1) > 0.5) message("This message appears with a 50% chance." )

x <- 3
if(x > 2)
{
y <- 2 * x
z <- 3 * y
}

if(FALSE)
{
message("This won't execute..." )
} else
{
message("but this will." )
}
## but this will.

if(FALSE)
{
message("This won't execute..." )
}
else
{
message("and you'll get an error before you reach this." )
}

(r <-  round(rnorm(2), 1))
## [1] -0.1 -0.4
(x <-  r[1] / r[2])
## [1] 0.25
if(is.nan(x))
{
message("x is missing" )
} else if(is.infinite(x))
{
message("x is infinite" )
} else if(x > 0)
{
message("x is positive" )
} else if(x < 0)
{
message("x is negative" )
} else
{
message("x is zero" )
}
## x is positive

x <-  sqrt(-1 + 0i)
(reality <- if(Re(x) == 0) "real" else "imaginary" )
## [1] "real"

(greek <-  switch(
"gamma" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
}
))
## [1] 3

(greek <-  switch(
"delta" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
}
))


(greek <-  switch(
"delta" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
},
4
))

switch(
as.character(2147483647),
"2147483647" = "a big number" ,
"another number"
)
## [1] "a big number"

repeat
{
message("Happy Groundhog Day!" )
}

repeat
{
message("Happy Groundhog Day!" )
action <-  sample(
c(
"Learn French" ,
"Make an ice statue" ,
"Rob a bank" ,
"Win heart of Andie McDowell"
),
1
)
message("action = " ,  action)
if(action == "Win heart of Andie McDowell" ) break
}

repeat
{
message("Happy Groundhog Day!" )
action <-  sample(
c(
"Learn French" ,
"Make an ice statue" ,
"Rob a bank" ,
"Win heart of Andie McDowell"
),
1
)
if(action == "Rob a bank" )
{
message("Quietly skipping to the next iteration" )
next
}
message("action = " ,  action)
if(action == "Win heart of Andie McDowell" ) break
}

action <-  sample(
c(
"Learn French" ,
"Make an ice statue" ,
"Rob a bank" ,
"Win heart of Andie McDowell"
),
1
)
while(action != "Win heart of Andie McDowell" )
{
message("Happy Groundhog Day!" )
action <-  sample(
c(
"Learn French" ,
"Make an ice statue" ,
"Rob a bank" ,
"Win heart of Andie McDowell"
),
1
)
message("action = " ,  action)
}

for(i in 1: 5) message("i = " ,  i)

for(i in 1: 5)
{
j <-  i ^ 2
message("j = " ,  j)
}

for(month in month.name)
{
message("The month of " ,  month)
}

for(yn in c(TRUE, FALSE, NA))
{
message("This statement is " ,  yn)
}

l <-  list(
pi,
LETTERS[1: 5],
charToRaw("not as complicated as it looks" ),
list(
TRUE
)
)
for(i in l)
{
print(i)
}


paste(c("red" , "yellow" ), "lorry" )
## [1] "red lorry" "yellow lorry"
paste(c("red" , "yellow" ), "lorry" ,  sep = "-" )
## [1] "red-lorry" "yellow-lorry"
paste(c("red" , "yellow" ), "lorry" ,  collapse = ", " )
## [1] "red lorry, yellow lorry"
paste0(c("red" , "yellow" ), "lorry" )
## [1] "redlorry" "yellowlorry"
x <- (1: 15) ^ 2
toString(x)
## [1] "1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225"
toString(x,  width = 40)
## [1] "1, 4, 9, 16, 25, 36, 49, 64, 81, 100...."

cat(c("red" , "yellow" ), "lorry" )
## red yellow lorry


Usually, when strings are printed to the console they are shown wrapped in double
quotes. By wrapping a variable in a call to the noquote function, we can suppress those
quotes. This can make the text more readable in some instances:
x <-  c(
"I" , "saw" , "a" , "saw" , "that" , "could" , "out" ,
"saw" , "any" , "other" , "saw" , "I" , "ever" , "saw"
)
y <-  noquote(x)
x
## [1] "I" "saw" "a" "saw" "that" "could" "out" "saw"
## [9] "any" "other" "saw" "I" "ever" "saw"
y
## [1] I saw a saw that could out saw any other saw
## [12] I ever saw



pow <- 1: 3
(powers_of_e <-  exp(pow))
## [1] 2.718 7.389 20.086
formatC(powers_of_e)
## [1] "2.718" "7.389" "20.09"
formatC(powers_of_e,  digits = 3) #3 sig figs
## [1] "2.72" "7.39" "20.1"
formatC(powers_of_e,  digits = 3,  width = 10) #preceding spaces
## [1] " 2.72" " 7.39" " 20.1"

formatC(powers_of_e,  digits = 3,  format = "e" ) #scientific formatting
## [1] "2.718e+00" "7.389e+00" "2.009e+01"
formatC(powers_of_e,  digits = 3,  flag = "+" ) #precede +ve values with +
## [1] "+2.72" "+7.39" "+20.1"

sprintf("%s %d = %f" , "Euler's constant to the power" ,  pow,  powers_of_e)
## [1] "Euler's constant to the power 1 = 2.718282"
## [2] "Euler's constant to the power 2 = 7.389056"
## [3] "Euler's constant to the power 3 = 20.085537"
sprintf("To three decimal places, e ^ %d = %.3f" ,  pow,  powers_of_e)
## [1] "To three decimal places, e ^ 1 = 2.718"
## [2] "To three decimal places, e ^ 2 = 7.389"
## [3] "To three decimal places, e ^ 3 = 20.086"
sprintf("In scientific notation, e ^ %d = %e" ,  pow,  powers_of_e)
## [1] "In scientific notation, e ^ 1 = 2.718282e+00"
## [2] "In scientific notation, e ^ 2 = 7.389056e+00"
## [3] "In scientific notation, e ^ 3 = 2.008554e+01"

format(powers_of_e)
## [1] " 2.718" " 7.389" "20.086"
format(powers_of_e,  digits = 3) #at least 3 sig figs
## [1] " 2.72" " 7.39" "20.09"
format(powers_of_e,  digits = 3,  trim = TRUE) #remove leading zeros
## [1] "2.72" "7.39" "20.09"


format(powers_of_e,  digits = 3,  scientific = TRUE)
## [1] "2.72e+00" "7.39e+00" "2.01e+01"
prettyNum(
 c(1e10, 1e- 20),
 big.mark = "," ,
 small.mark = " " ,
 preserve.width = "individual" ,
 scientific = FALSE
)
## [1] "10,000,000,000" "0.00000 00000 00000 00001"


cat("foo'bar" ,  fill = TRUE)
## foo'bar
cat('foo"bar' ,  fill = TRUE)
## foo"bar



toupper("I'm Shouting" )
## [1] "I'M SHOUTING"
tolower("I'm Whispering" )
## [1] "i'm whispering"


woodchuck <-  c(
 "How much wood would a woodchuck chuck" ,
 "If a woodchuck could chuck wood?" ,
 "He would chuck, he would, as much as he could" ,
 "And chuck as much wood as a woodchuck would" ,
 "If a woodchuck could chuck wood."
)

substring(woodchuck, 1:6, 10)
## [1] "How much w" "f a woodc" " would c" " chuck " " woodc"
## [6] "uch w"
substr(woodchuck, 1: 6, 10)
## [1] "How much w" "f a woodc" " would c" " chuck " " woodc"



splitstr<-strsplit(woodchuck, " " ,  fixed = TRUE)
## [[1]]
## [1] "How" "much" "wood" "would" "a" "woodchuck"
## [7] "chuck"
##
## [[2]]
## [1] "If" "a" "woodchuck" "could" "chuck" "wood?"
##
## [[3]]
## [1] "He" "would" "chuck," "he" "would," "as" "much"
## [8] "as" "he" "could"
##
## [[4]]
## [1] "And" "chuck" "as" "much" "wood" "as"
## [7] "a" "woodchuck" "would"
##
## [[5]]
## [1] "If" "a" "woodchuck" "could" "chuck" "wood."

table(unlist(splitstr))


getwd()
## [1] "d:/workspace/LearningR"
setwd("c:/windows" )
getwd()
## [1] "c:/windows"

"c:\\windows"  #remember to double up the slashes
"\\\\myserver\\mydir"  #UNC names need four slashes at the start

file.path("c:" , "Program Files" , "R" , "R-devel" )
## [1] "c:/Program Files/R/R-devel"
R.home() #same place: a shortcut to the R installation dir
## [1] "C:/PROGRA~1/R/R-devel"
path.expand("." )
## [1] "."
path.expand(".." )
## [1] ".."
path.expand("~" )
## [1] "C:\\Users\\richie\\Documents"

file_name <- "C:/Program Files/R/R-devel/bin/x64/RGui.exe"
basename(file_name)
## [1] "RGui.exe"
dirname(file_name)
## [1] "C:/Program Files/R/R-devel/bin/x64"

heights <-  data.frame(
 height_cm = c(153, 181, 150, 172, 165, 149, 174, 169, 198, 163),
 gender = c(
 "female" , "male" , "female" , "male" , "male" ,
 "female" , "female" , "male" , "male" , "female"
 )
)


class(heights$gender)
## [1] "factor"
Printing the column reveals a little more about the nature of this factor:
heights$gender
## [1] female male female male male female female male male female
## Levels: female male
Each value in the factor is a string that is constrained to be either “female,” “male,” or
missing. This constraint becomes obvious if we try to add a different string to the
genders:
heights$gender[1] <- "Female"  #notice the capital "F"
## Warning: invalid factor level, NA generated
heights$gender
## [1] <NA> male female male male female female male male female
## Levels: female male
The choices “female” and “male” are called the levels of the factor and can be retrieved
with the levels function:
levels(heights$gender)
## [1] "female" "male"
The number of these levels (equivalent to the length of the levels of the factor) can
be retrieved with the nlevels function:
nlevels(heights$gender)
## [1] 2



gender_char <-  c(
"female" , "male" , "female" , "male" , "male" ,
"female" , "female" , "male" , "male" , "female"
)(
gender_fac <-  factor(gender_char))



Changing Factor Levels
We can change the order of the levels when the factor is created by specifying a levels
argument:
factor(gender_char,  levels = c("male" , "female" ))
## [1] female male female male male female female male male female
## Levels: male female
If we want to change the order of the factor levels after creation, we again use the factor
function, this time passing in the existing factor (rather than a character vector):
factor(gender_fac,  levels = c("male" , "female" ))
## [1] female male female male male female female male male female
## Levels: male female

In the next example, directly setting the levels of the factor changes male data to female
data, and female data to male data, which isn’t what we want:
levels(gender_fac) <-  c("male" , "female" )
gender_fac
## [1] male female male female female male male female female male
## Levels: male female
The relevel function is an alternative way of changing the order of factor levels. In this
case, it just lets you specify which level comes first. As you might imagine, the use case
for this function is rather niche—it can come in handy for regression models where you
want to compare different categories to a reference category. Most of the time you will
be better off calling factor if you want to set the levels:
relevel(gender_fac, "male" )
## [1] male female male female female male male female female male
## Levels: male female

Dropping Factor Levels
In the process of cleaning datasets, you may end up removing all the data corresponding
to a factor level. Consider this dataset of times to travel into work using different modes
of transport:
getting_to_work <-  data.frame(
 mode = c(
 "bike" , "car" , "bus" , "car" , "walk" ,
 
 "bike" , "car" , "bike" , "car" , "car"
),
time_mins = c(25, 13, NA, 22, 65, 28, 15, 24, NA, 14)
)

getting_to_work <-  subset(getting_to_work,  !is.na(time_mins))


unique(getting_to_work$mode)
## [1] bike car walk
## Levels: bike bus car walk
If we want to drop the unused levels of the factor, we can use the droplevels function.
This accepts either a factor or a data frame. In the latter case, it drops the unused levels
in all the factors of the input. Since there is only one factor in our example data frame,
the two lines of code in the next example are equivalent:
getting_to_work$mode <-  droplevels(getting_to_work$mode)
getting_to_work <-  droplevels(getting_to_work)
levels(getting_to_work$mode)
## [1] "bike" "car" "walk"


happy_choices <-  c("depressed" , "grumpy" , "so-so" , "cheery" , "ecstatic" )
happy_values <-  sample(
happy_choices,
10000,
replace = TRUE
)
happy_fac <-  factor(happy_values,  happy_choices)
head(happy_fac)
## [1] grumpy depressed cheery ecstatic grumpy grumpy
## Levels: depressed grumpy so-so cheery ecstatic

happy_ord <-  ordered(happy_values,  happy_choices)
head(happy_ord)
## [1] grumpy depressed cheery ecstatic grumpy grumpy
## Levels: depressed < grumpy < so-so < cheery < ecstatic

is.factor(happy_ord)
## [1] TRUE
is.ordered(happy_fac)
## [1] FALSE

ages <- 16 + 50 * rbeta(10000, 2, 3)
grouped_ages <-  cut(ages,  seq.int(16, 66, 10))
head(grouped_ages)
## [1] (26,36] (16,26] (26,36] (26,36] (26,36] (46,56]
## Levels: (16,26] (26,36] (36,46] (46,56] (56,66]

table(grouped_ages)
## grouped_ages
## (16,26] (26,36] (36,46] (46,56] (56,66]
## 1844 3339 3017 1533 267
In this case, the bulk of the workforce falls into the 26-to-36 and 36-to-46 categories (as
a direct consequence of the shape of our beta distribution).
Notice that ages is a numeric variable and grouped_ages is a factor:
class(ages)
## [1] "numeric"
class(grouped_ages)
## [1] "factor"



Converting Categorical Variables to Continuous
dirty <-  data.frame(
 x = c("1.23" , "4..56" , "7.89" )
)
as.numeric(as.character(dirty$x))


This is slightly inefficient, since repeated values have to be converted multiple times. As
the FAQ on R notes, it is better to convert the factor’s levels to be numeric, then recon‐
struct the factor as above:
as.numeric(levels(dirty$x))[as.integer(dirty$x)]
## Warning: NAs introduced by coercion
## [1] 1.23 NA 7.89

factor_to_numeric <- function(f)
{
as.numeric(levels(f))[as.integer(f)]
}

if(TRUE) message("It was true!" )
## It was true!
if(FALSE) message("It wasn't true!" )
Missing values aren’t allowed to be passed to if; doing so throws an error:
if(NA) message("Who knows if it was true?" )
## Error: missing value where TRUE/FALSE needed
Where you may have a missing value, you should test for it using is.na:
if(is.na(NA)) message("The value is missing!" )
## The value is missing!
if(runif(1) > 0.5) message("This message appears with a 50% chance." )

if(FALSE)
{
message("This won't execute..." )
}
else
{
message("and you'll get an error before you reach this." )
}

(r <-  round(rnorm(2), 1))
## [1] -0.1 -0.4
(x <-  r[1] / r[2])
## [1] 0.25
if(is.nan(x))
{
message("x is missing" )
} else if(is.infinite(x))
{
message("x is infinite" )
} else if(x > 0)
{
message("x is positive" )
} else if(x < 0)
{
message("x is negative" )
} else
{
message("x is zero" )
}
## x is positive

x <-  sqrt(-1 + 0i)
(reality <- if(Re(x) == 0) "real" else "imaginary" )

ifelse(rbinom(10, 1, 0.5), "Head" , "Tail" )


(yn <-  rep.int(c(TRUE, FALSE), 6))
## [1] TRUE FALSE TRUE FALSE TRUE FALSE TRUE FALSE TRUE FALSE TRUE
## [12] FALSE
ifelse(yn, 1: 3, -1: -12)
## [1] 1 -2 3 -4 2 -6 1 -8 3 -10 2 -12



yn[c(3, 6, 9, 12)] <- NA
ifelse(yn, 1: 3, -1: -12)
## [1] 1 -2 NA -4 2 NA 1 -8 NA -10 2 NA



(greek <-  switch(
"gamma" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
}
))
## [1] 3
If no names match, then switch (invisibly) returns NULL:
(greek <-  switch(
"delta" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
}
))
## NULL
For these circumstances, you can provide an unnamed argument that matches when
nothing else does:
(greek <-  switch(
"delta" ,
alpha = 1,
beta = sqrt(4),
gamma =
{
a <-  sin(pi / 3)
4 * a ^ 2
},
4
))
## [1] 4



switch can also take a first argument that returns an integer. In this case the remaining
arguments do not need names—the next argument is executed if the first argument
resolves to 1, the argument after that is executed if the first argument resolves to 2, and
so on:
switch(
3,
"first" ,
"second" ,
"third" ,
"fourth"
)
## [1] "third"
As you may have noticed, no default argument is possible in this case. It’s also rather
cumbersome if you want to test for large integers, since you’ll need to provide many
arguments. Under those circumstances it is best to convert the first argument to a string
and use the first syntax:
switch(
as.character(2147483647),
"2147483647" = "a big number" ,
"another number"
)
## [1] "a big number"

for(i in 1: 5) message("i = " ,  i)


for(i in 1: 5)
{
j <-  i ^ 2
message("j = " ,  j)
}


for(month in month.name)
{
message("The month of " ,  month)
}

for(yn in c(TRUE, FALSE, NA))
{
 message("This statement is " ,  yn)
}



l <-  list(
pi,
LETTERS[1: 5],
charToRaw("not as complicated as it looks" ),
list(
TRUE
)
)
for(i in l)
{
print(i)
}



rep(runif(1), 5)
## [1] 0.04573 0.04573 0.04573 0.04573 0.04573
replicate(5,  runif(1))
## [1] 0.5839 0.3689 0.1601 0.9176 0.5388

unique_primes <-  vector("list" ,  length(prime_factors))
for(i in seq_along(prime_factors))
{
unique_primes[[i]] <-  unique(prime_factors[[i]])
}
names(unique_primes) <-  names(prime_factors)
unique_primes
########################

Looping Over Lists
By now, you should have noticed that an awful lot of R is vectorized. In fact, your default
stance should be to write vectorized code. It’s often cleaner to read, and invariably gives
you performance benefits when compared to a loop. In some cases, though, trying to
achieve vectorization means contorting your code in unnatural ways. In those cases, the
apply family of functions can give you pretend vectorization,2 without the pain.
The simplest and most commonly used family member is lapply, short for “list apply.”
lapply takes a list and a function as inputs, applies the function to each element of the
list in turn, and returns another list of results. Recall our prime factorization list from
Chapter 5:
prime_factors <-  list(
two = 2,
three = 3,
four = c(2, 2),
five = 5,
six = c(2, 3),
seven = 7,
eight = c(2, 2, 2),
nine = c(3, 3),
ten = c(2, 5)
)
head(prime_factors)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
Trying to find the unique value in each list element is difficult to do in a vectorized way.
We could write a for loop to examine each element, but that’s a little bit clunky:
unique_primes <-  vector("list" ,  length(prime_factors))
for(i in seq_along(prime_factors))
{
unique_primes[[i]] <-  unique(prime_factors[[i]])
}
names(unique_primes) <-  names(prime_factors)
unique_primes
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5
lapply makes this so much easier, eliminating the nasty boilerplate code for worrying
about lengths and names:
lapply(prime_factors,  unique)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5
When the return value from the function is the same size each time, and you know what
that size is, you can use a variant of lapply called vapply. vapply stands for “list apply
that returns a vector.” As before, you pass it a list and a function, but vapply takes a
third argument that is a template for the return values. Rather than returning a list, it
simplifies the result to be a vector or an array:
vapply(prime_factors,  length,  numeric(1))
## two three four five six seven eight nine ten
## 1 1 2 1 2 1 3 2 2
If the output does not fit the template, then vapply will throw an error. This makes it
less flexible than lapply, since the output must be the same size for each element and
must be known in advance.
There is another function that lies in between lapply and vapply: namelysapply, which
stands for “simplifying list apply.” Like the two other functions, sapply takes a list and
a function as inputs. It does not need a template, but will try to simplify the result to an
appropriate vector or array if it can:
sapply(prime_factors,  unique) #returns a list
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5
sapply(prime_factors,  length) #returns a vector
## two three four five six seven eight nine ten
## 1 1 2 1 2 1 3 2 2
sapply(prime_factors,  summary) #returns an array
## two three four five six seven eight nine ten
## Min. 2 3 2 5 2.00 7 2 3 2.00
## 1st Qu. 2 3 2 5 2.25 7 2 3 2.75
## Median 2 3 2 5 2.50 7 2 3 3.50
## Mean 2 3 2 5 2.50 7 2 3 3.50
## 3rd Qu. 2 3 2 5 2.75 7 2 3 4.25
## Max. 2 3 2 5 3.00 7 2 3 5.00
For interactive use, this is wonderful because you usually automatically get the result in
the form that you want. This function does require some care if you aren’t sure about
what your inputs might be, though, since the result is sometimes a list and sometimes
a vector. This can trip you up in some subtle ways. Our previous length example re‐
turned a vector, but look what happens when you pass it an empty list:
sapply(list(),  length)
## list()
If the input list has length zero, then sapply always returns a list, regardless of the
function that is passed. So if your data could be empty, and you know the return value,
it is safer to use vapply:
vapply(list(),  length,  numeric(1))
## numeric(0)
Although these functions are primarily designed for use with lists, they can also accept
vector inputs. In this case, the function is applied to each element of the vector in turn.
The source function is used to read and evaluate the contents of an R file. (That is, you
can use it to run an R script.) Unfortunately it isn’t vectorized, so if we wanted to run
all the R scripts in a directory, then we need to wrap the directory in a call to lapply.
In this next example, dir returns the names of files in a given directory, defaulting to
the current working directory. (Recall that you can find this with getwd.) The argument
pattern = "\\.R$"  means “only return filenames that end with .R”:
r_files <-  dir(pattern = "\\.R$" )
lapply(r_files,  source)
You may have noticed that in all of our examples, the functions passed to lapply,
vapply, and sapply have taken just one argument. There is a limitation in these func‐
tions in that you can only pass one vectorized argument (more on how to circumvent
that later), but you can pass other scalar arguments to the function. To do this, just pass
in named arguments to the lapply (or sapply or vapply) call, and they will be passed
to the inner function. For example, if rep.int takes two arguments, but the times
argument is allowed to be a single (scalar) number, you’d type:
complemented <-  c(2, 3, 6, 18) #See http://oeis.org/A000614
lapply(complemented,  rep.int,  times = 4)
## [[1]]
## [1] 2 2 2 2
##
## [[2]]
## [1] 3 3 3 3
##
## [[3]]
## [1] 6 6 6 6
##
## [[4]]
## [1] 18 18 18 18
What if the vector argument isn’t the first one? In that case, we have to create our own
function to wrap the function that we really wanted to call. You can do this on a separate
line, but it is common to include the function definition within the call to lapply:
rep4x <- function(x) rep.int(4,  times = x)
lapply(complemented,  rep4x)
## [[1]]
## [1] 4 4
##
## [[2]]
## [1] 4 4 4
##
## [[3]]
## [1] 4 4 4 4 4 4
##
## [[4]]
## [1] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
This last code chunk can be made a little simpler by passing an anonymous function to
lapply. This is the trick we saw in Chapter 5, where we don’t bother with a separate
assignment line and just pass the function to lapply without giving it a name:
lapply(complemented, function(x) rep.int(4,  times = x))
## [[1]]
## [1] 4 4
##
## [[2]]
## [1] 4 4 4
##
## [[3]]
## [1] 4 4 4 4 4 4
##
## [[4]]
## [1] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
Very, very occasionally, you may want to loop over every variable in an environment,
rather than in a list. There is a dedicated function, eapply, for this, though in recent
versions of R you can also use lapply:
env <-  new.env()
env$molien <-  c(1, 0, 1, 0, 1, 1, 2, 1, 3) #See http://oeis.org/A008584
env$larry <-  c("Really" , "leery" , "rarely" , "Larry" )
eapply(env,  length)
## $molien
## [1] 9
##
## $larry
## [1] 4
lapply(env,  length) #same
## $molien
## [1] 9
##
## $larry
## [1] 4
rapply is a recursive version oflapply that allows you to loop over nested lists. This is
a niche requirement, and code is often simpler if you flatten the data first using unlist.

seq_len(length(c(3,6,7,8,9)))


detach("package:matlab")  
3. Though the matrixStats package tries to do exactly that.
install.packages("matlab" )
library(matlab)
## Attaching package: 'matlab'
## The following object is masked from 'package:stats':
##
## reshape
## The following object is masked from 'package:utils':
##
## find, fix
## The following object is masked from 'package:base':
##
## sum
When you load the matlab package, it overrides some functions in the
base, stats, and utils packages to make them behave like their
MATLAB counterparts. After these examples that use the matlab
package, you may wish to restore the usual behavior by unloading the
package. Call detach("package:matlab")  to do this.
The magic function creates a magic square—an n-by-n square matrix of the numbers
from 1 to n^2, where each row and each column has the same total:
(magic4 <-  magic(4))
## [,1] [,2] [,3] [,4]
## [1,] 16 2 3 13
## [2,] 5 11 10 8
## [3,] 9 7 6 12
## [4,] 4 14 15 1
A classic problem requiring us to apply a function by row is calculating the row totals.
This can be achieved using the rowSums function that we saw briefly in Chapter 5:
rowSums(magic4)
## [1] 34 34 34 34
But what if we want to calculate a different statistic for each row? It would be cumber‐
some to try to provide a function for every such possibility.3 The apply function provides
the row/column-wise equivalent of lapply, taking a matrix, a dimension number, and
a function as arguments. The dimension number is 1 for “apply the function across each
row,” or 2 for “apply the function down each column” (or bigger numbers for higher
dimensional arrays):

apply(magic4, 1,  sum) #same as rowSums
## [1] 34 34 34 34
apply(magic4, 1,  toString)
## [1] "16, 2, 3, 13" "5, 11, 10, 8" "9, 7, 6, 12" "4, 14, 15, 1"
apply(magic4, 2,  toString)
## [1] "16, 5, 9, 4" "2, 11, 7, 14" "3, 10, 6, 15" "13, 8, 12, 1"
apply can also be used on data frames, though the mixed-data-type nature means that
this is less common (for example, you can’t sensibly calculate a sum or a product when
there are character columns):
(baldwins <-  data.frame(
name = c("Alec" , "Daniel" , "Billy" , "Stephen" ),
date_of_birth = c(
"1958-Apr-03" , "1960-Oct-05" , "1963-Feb-21" , "1966-May-12"
),
n_spouses = c(2, 3, 1, 1),
n_children = c(1, 5, 3, 2),
stringsAsFactors = FALSE
))
## name date_of_birth n_spouses n_children
## 1 Alec 1958-Apr-03 2 1
## 2 Daniel 1960-Oct-05 3 5
## 3 Billy 1963-Feb-21 1 3
## 4 Stephen 1966-May-12 1 2
apply(baldwins, 1,  toString)
## [1] "Alec, 1958-Apr-03, 2, 1" "Daniel, 1960-Oct-05, 3, 5"
## [3] "Billy, 1963-Feb-21, 1, 3" "Stephen, 1966-May-12, 1, 2"
apply(baldwins, 2,  toString)
## name
## "Alec, Daniel, Billy, Stephen"
## date_of_birth
## "1958-Apr-03, 1960-Oct-05, 1963-Feb-21, 1966-May-12"
## n_spouses
## "2, 3, 1, 1"
## n_children
## "1, 5, 3, 2"
When applied to a data frame by column, apply behaves identically to sapply (remem‐
ber that data frames can be thought of as nonnested lists where the elements are of the
same length):
sapply(baldwins,  toString)
## name
## "Alec, Daniel, Billy, Stephen"
## date_of_birth
## "1958-Apr-03, 1960-Oct-05, 1963-Feb-21, 1966-May-12"
## n_spouses
## "2, 3, 1, 1"
## n_children
## "1, 5, 3, 2"
Of course, simply printing a dataset in different forms isn’t that interesting. Using sapply
combined with range, on the other hand, is a great way to quickly determine the extent
of your data:
sapply(baldwins,  range)
## name date_of_birth n_spouses n_children
## [1,] "Alec" "1958-Apr-03" "1" "1"
## [2,] "Stephen" "1966-May-12" "3" "5"
Multiple-Input Apply
One of the drawbacks of lapply is that it only accepts a single vector to loop over.
Another is that inside the function that is called on each element, you don’t have access
to the name of that element.
The function mapply, short for “multiple argument list apply,” lets you pass in as many
vectors as you like, solving the first problem. A common usage is to pass in a list in one
argument and the names of that list in another, solving the second problem. One little
annoyance is that in order to accommodate an arbitrary number of vector arguments,
the order of the arguments has been changed. For mapply, the function is passed as the
first argument:
msg <- function(name,  factors)
{
ifelse(
length(factors) == 1,
paste(name, "is prime" ),
paste(name, "has factors" ,  toString(factors))
)
}
mapply(msg,  names(prime_factors),  prime_factors)
## two three
## "two is prime" "three is prime"
## four five
## "four has factors 2, 2" "five is prime"
## six seven
## "six has factors 2, 3" "seven is prime"
## eight nine
## "eight has factors 2, 2, 2" "nine has factors 3, 3"
## ten
## "ten has factors 2, 5"
By default, mapply behaves in the same way as sapply, simplifying the output if it thinks
it can. You can turn this behavior off (so it behaves more like lapply) by passing the
argument SIMPLIFY = FALSE.
Instant Vectorization
The function Vectorize is a wrapper to mapply that takes a function that usually accepts
a scalar input, and returns a new function that accepts vectors. This next function is not
vectorized because of its use of switch, which requires a scalar input:
baby_gender_report <- function(gender)
{
switch(
gender,
male = "It's a boy!" ,
female = "It's a girl!" ,
"Um..."
)
}
If we pass a vector into the function, it will throw an error:
genders <-  c("male" , "female" , "other" )
baby_gender_report(genders)
While it is theoretically possible to do a complete rewrite of a function that is inherently
vectorized, it is easier to use the Vectorize function:
vectorized_baby_gender_report <-  Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)
## male female other
## "It's a boy!" "It's a girl!" "Um..."
Split-Apply-Combine
A really common problem when investigating data is how to calculate some statistic on
a variable that has been split into groups. Here are some scores on the classic road safety
awareness computer game, Frogger:
(frogger_scores <-  data.frame(
player = rep(c("Tom" , "Dick" , "Harry" ),  times = c(2, 5, 3)),
score = round(rlnorm(10, 8), -1)
))
## player score
## 1 Tom 2250
## 2 Tom 1510
## 3 Dick 1700
## 4 Dick 410
## 5 Dick 3720
## 6 Dick 1510
## 7 Dick 4500
## 8 Harry 2160
## 9 Harry 5070
## 10 Harry 2930
If we want to calculate the mean score for each player, then there are three steps. First,
we split the dataset by player:
(scores_by_player <-  with(
frogger_scores,
split(score,  player)
))
## $Dick
## [1] 1700 410 3720 1510 4500
##
## $Harry
## [1] 2160 5070 2930
##
## $Tom
## [1] 2250 1510
Next we apply the (mean) function to each element:
(list_of_means_by_player <-  lapply(scores_by_player,  mean))
## $Dick
## [1] 2368
##
## $Harry
## [1] 3387
##
## $Tom
## [1] 1880
Finally, we combine the result into a single vector:
(mean_by_player <-  unlist(list_of_means_by_player))
## Dick Harry Tom
## 2368 3387 1880
The last two steps can be condensed into one by using vapply or sapply, but split-apply
combine is such a common task that we need something easier. That something is the
tapply function, which performs all three steps in one go:
with(frogger_scores,  tapply(score,  player,  mean))
## Dick Harry Tom
## 2368 3387 1880
There are a few other wrapper functions to tapply, namely by and aggregate. They
perform the same function with a slightly different interface.
SQL fans may note that split-apply-combine is the same as a GROUP BY
operation.
The plyr Package
The *apply family of functions are mostly wonderful, but they have three drawbacks
that stop them being as easy to use as they could be. Firstly, the names are a bit obscure.
The “l” in lapply for lists makes sense, but after using R for nine years, I still don’t know
what the “t” in tapply stands for.
Secondly, the arguments aren’t entirely consistent. Most of the functions take a data
object first and a function argument second, but mapply swaps the order, and tapply
takes the function for its third argument. The data argument is sometimes X and some‐
times object, and the simplification argument is sometimes simplify and sometimes
SIMPLIFY.
Thirdly, the form of the output isn’t as controllable as it could be. Getting your results
as a data frame—or discarding the result—takes a little bit of effort.
This is where the plyr package comes in handy. The package contains a set of functions
named **ply, where the blanks (asterisks) denote the form of the input and output,
respectively. So, llply takes a list input, applies a function to each element, and returns
a list, making it a drop-in replacement for lapply:
library(plyr)
llply(prime_factors,  unique)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5
laply takes a list and returns an array, mimicking sapply. In the case of an empty input,
it does the smart thing and returns an empty logical vector (unlike sapply, which returns
an empty list):
laply(prime_factors,  length)
## [1] 1 1 2 1 2 1 3 2 2
laply(list(),  length)
## logical(0)
raply replaces replicate (not rapply!), but there are also rlply and rdply functions
that let you return the result in list or data frame form, and an r_ply function that
discards the result (useful for drawing plots):
raply(5,  runif(1)) #array output
## [1] 0.009415 0.226514 0.133015 0.698586 0.112846
rlply(5,  runif(1)) #list output
## [[1]]
## [1] 0.6646
##
## [[2]]
## [1] 0.2304
##
## [[3]]
## [1] 0.613
##
## [[4]]
## [1] 0.5532
##
## [[5]]
## [1] 0.3654
rdply(5,  runif(1)) #data frame output
## .n V1
## 1 1 0.9068
## 2 2 0.0654
## 3 3 0.3788
## 4 4 0.5086
## 5 5 0.3502
r_ply(5,  runif(1)) #discarded output
## NULL
Perhaps the most commonly used function in plyr is ddply, which takes data frames
as inputs and outputs and can be used as a replacement for tapply. Its big strength is
that it makes it easy to make calculations on several columns at once. Let’s add a level
column to the Frogger dataset, denoting the level the player reached in the game:
frogger_scores$level <-  floor(log(frogger_scores$score))
There are several different ways of calling ddply. All methods take a data frame, the
name of the column(s) to split by, and the function to apply to each piece. The column
is passed without quotes, but wrapped in a call to the .  function.
For the function, you can either use colwise to tell ddply to call the function on every
column (that you didn’t mention in the second argument), or use summarize and specify
manipulations of specific columns:
ddply(
frogger_scores,
. (player),
colwise(mean) #call mean on every column except player
)
## player score level
## 1 Dick 2368 7.200
## 2 Harry 3387 7.333
## 3 Tom 1880 7.000
ddply(
frogger_scores,
. (player),
summarize,
mean_score = mean(score), #call mean on score
max_level = max(level) #... and max on level
)
## player mean_score max_level
## 1 Dick 2368 8
## 2 Harry 3387 8
## 3 Tom 1880 7
colwise is quicker to specify, but you have to do the same thing with each column,
whereas summarize is more flexible but requires more typing.
There is no direct replacement for mapply, though the m*ply functions allow looping
with multiple arguments. Likewise, there is no replacement for vapply or rapply.


So, llply takes a list input, applies a function to each element, and returns
a list, making it a drop-in replacement for lapply

laply(prime_factors,  length)


There are several different ways of calling ddply. All methods take a data frame, the
name of the column(s) to split by, and the function to apply to each piece. The column
is passed without quotes, but wrapped in a call to the .  function.
For the function, you can either use colwise to tell ddply to call the function on every
column (that you didn’t mention in the second argument), or use summarize and specify
manipulations of specific columns:

frogger_scores$level <-  floor(log(frogger_scores$score))
ddply(
 frogger_scores,
 . (player),
 colwise(mean) #call mean on every column except player
)

frogger_scores$level <-  floor(log(frogger_scores$score))
ddply(
 frogger_scores,
 . (player),
   length #call mean on every column except player
)

ddply(
 frogger_scores,
 . (player),
 summarize,
 mean_score = mean(score), #call mean on score
 max_level = max(level) #... and max on level
)



wayans <-  list(
"Dwayne Kim" = list(),
"Keenen Ivory" = list(
"Jolie Ivory Imani" ,
"Nala" ,
"Keenen Ivory Jr" ,
"Bella" ,
"Daphne Ivory"
),
Damon = list(
"Damon Jr" ,
"Michael" ,
"Cara Mia" ,
"Kyla"
),

Kim = list(),
Shawn = list(
"Laila" ,
"Illia" ,
"Marlon"
),
Marlon = list(
"Shawn Howell" ,
"Arnai Zachary"
),
Nadia = list(),
Elvira = list(
"Damien" ,
"Chaunté"
),
Diedre = list(
"Craig" ,
"Gregg" ,
"Summer" ,
"Justin" ,
"Jamel"
),
Vonnie = list()
)

library(lattice)
dotplot(
 variety ~ yield |  site,
 data = barley,
 groups = year
)


Notice that the name of the package is passed to library without being enclosed in
quotes. If you want to programmatically pass the name of the package to library, then
you can set the argument character.only = TRUE. This is mildly useful if you have a
lot of packages to load:
pkgs <-  c("lattice" , "utils" , "rpart" )
for(pkg in pkgs)
{
library(pkg,  character.only = TRUE)
}

The Search Path
You can see the packages that are loaded with the search function:
search()
## [1] ".GlobalEnv" "package:stats" "package:graphics"
## [4] "package:grDevices" "package:utils" "package:datasets"
## [7] "package:methods" "Autoloads" "package:base"
This list shows the order of places that R will look to try to find a variable. The global
environment always comes first, followed by the most recently loaded packages. The
last two values are always a special environment called Autoloads, and the base package.
If you define a variable called var in the global environment, R will find that before it
finds the usual variance function in the stats package, because the global environment
comes first in the search list. If you create any environments (see Chapter 6), they will
also appear on the search path.
Libraries and Installed Packages
The function installed.packages returns a data frame with information about all the
packages that R knows about on your machine. If you’ve been using R for a while, this
can easily be several hundred packages, so it is often best to view the results away from
the console:
View(installed.packages())
installed.packages gives you information about which version of each package is
installed, where it lives on your hard drive, and which other packages it depends upon,
amongst other things. The LibPath column that provides the file location of the package
tells you the library that contains the package. At this point, you may be wondering how
R decides which folders are considered libraries.
The following explanation is a little bit technical, so don’t worry about
remembering the minutiae of how R finds its packages. This informa‐
tion can save you administration effort when you choose to upgrade
R, or when you have problems with packages loading, but it isn’t re‐
quired for day-to-day use of R.
The packages that come with the R install (base, stats, and nearly 30 others) are stored
in the library subdirectory of wherever you installed R. You can retrieve the location of
this with:
R.home("library" ) #or
## [1] "C:/PROGRA~1/R/R-devel/library"

. Library
## [1] "C:/PROGRA~1/R/R-devel/library"
You also get a user library for installing packages that will only be accessible by you.
(This is useful if you install on a family PC and don’t want your six-year-old to update
packages and break compatibility in your code.) The location is OS dependent. Under
Windows, for R version x.y.z, it is in the R/win-library/x.y subfolder of the home di‐
rectory, where the home directory can be found via:
path.expand("~" ) #or
## [1] "C:\\Users\\richie\\Documents"
Sys.getenv("HOME" )
## [1] "C:\\Users\\richie\\Documents"
Under Linux, the folder is similarly located in the R/R.version$platform-library/x.y
subfolder of the home directory. R.version$platform will typically return a string like
“i686-pc-linux-gnu,” and the home directory is found in the same way as under Win‐
dows. Under Mac OS X, it is found in Library/R/x.y/library.
One problem with the default setup of library locations is that when you upgrade R, you
need to reinstall all your packages. This is the safest behavior, since different versions
of R will often need different versions of packages. In practice, on a development ma‐
chine the convenience of not having to reinstall packages often outweighs versioning
worries.4 To make life easier for yourself, it’s a very good idea to create your own library
that can be used by all versions of R. The simplest way of doing this is to define an
environment variable named R_LIBS that contains a path5 to your desired library loca‐
tion. Although you can define environment variables programmatically with R, they
are only available to R, and only for the rest of the session—define them from within
your operating system instead.
You can see a character vector of all the libraries that R knows about using the .lib
Paths function:
. libPaths()
## [1] "D:/R/library"
## [2] "C:/Program Files/R/R-devel/library"
The first value in this vector is the most important, as this is where packages will be
installed by default.

Installing Packages
Factory-fresh installs of R are set up to access the CRAN package repository (via a mirror
—you’ll be prompted to pick the one nearest to you), and CRANextra if you are running
Windows. CRANextra contains a handful of packages that need special attention to
build under Windows, and cannot be hosted on the usual CRAN servers. To access
additional repositories, type setRepositories() and select the repositories that you
want. Figure 10-2 shows the available options.
Figure 10-2. List of available package repositories
Bioconductor contains packages related to genomics and molecular biology, while R
Forge and RForge.net mostly contain development versions of packages that eventually
appear on CRAN. You can see information about all the packages that are available in
the repositories that you have set using available.packages (be warned—there are
thousands, so this takes several seconds to run):
View(available.packages())
As well as these repositories, there are many R packages in online repositories such as
GitHub, Bitbucket, and Google Code. Retrieving packages from GitHub is particularly
easy, as discussed below.
Many IDEs have a point-and-click method of installing packages. In R GUI, the Pack‐
ages menu has the option “Install package(s)…” to install from a repository and “Install
package(s) from local zip files…” to install packages that you downloaded earlier.
Figure 10-3 shows the R GUI menu.
You can also install packages using the install.packages function. Calling it without
any arguments gives you the same GUI interface as if you’d clicked the “Install pack‐
age(s)…” menu option. Usually, you would want to specify the names of the packages
that you want to download and the URL of the repository to retrieve them from. A list
of URLs for CRAN mirrors is available on the main CRAN site.

Figure 10-3. Installing packages in R GUI
This command will (try to) download the time-series analysis packages xts and zoo
and all the dependencies for each, and then install them into the default library location
(the first value returned by .libPaths):
install.packages(
c("xts" , "zoo" ),
repos = "http://www.stats.bris.ac.uk/R/"
)
To install to a different location, you can pass the lib argument to install.packages:
install.packages(
c("xts" , "zoo" ),
lib = "some/other/folder/to/install/to" ,
repos = "http://www.stats.bris.ac.uk/R/"
)
Obviously, you need a working Internet connection for R to be able to download pack‐
ages, and you need sufficient permissions to be able to write files to the library folder.
Inside corporate networks, R’s access to the Internet may be restricted. Under Windows,
you can get R to use internet2.dll to access the Internet, making it appear as though it
is Internet Explorer and often bypassing restrictions. To achieve this, type:
setInternet2()
If all else fails, you can visit http://<cran mirror>web/packages/available_pack‐
ages_by_name.html and manually download the packages that you want (remember to
download all the dependencies too), then install the resultant tar.gz/tgz/zip file:
install.packages(
"path/to/downloaded/file/xts_0.8-8.tar.gz" ,
repos = NULL,  #NULL repo means "package already downloaded"
type = "source"  #this means "build the package now"
)
install.packages(
"path/to/downloaded/file/xts_0.8-8.zip" ,
repos = NULL,  #still need this

type = "win.binary" #Windows only!
)
To install a package directly from GitHub, you first need to install the devtools package:
install.packages("devtools" )
The install_github function accepts the name of the GitHub repository that contains
the package (usually the same as the name of the package itself) and the name of the
user that maintains that repository. For example, to get the development version of the
reporting package knitr, type:
library(devtools)
install_github("knitr" , "yihui" )
Maintaining Packages
After your packages are installed, you will usually want to update them in order to keep
up with the latest versions. This is done with update.packages. By default, this function
will prompt you before updating each package. This can become unwieldy after a while
(having several hundred packages installed is not uncommon), so setting ask =
FALSE is recommended:
update.packages(ask = FALSE)
Very occasionally, you may want to delete a package. It is possible to do this by simply
deleting the folder containing the package contents from your filesystem, or you can do
it programmatically:
remove.packages("zoo" )


#######################################################

Dates and times are very common in data analysis—not least for time-series analysis.
The bad news is that with different numbers of days in each month, leap years, leap
seconds,1 and time zones, they can be fairly awful to deal with programmatically. The
good news is that R has a wide range of capabilities for dealing with times and dates.
While these concepts are fairly fundamental to R programming, they’ve been left until
now because some of the best ways of using them appear in add-on packages. As you
begin reading this chapter, you may feel an awkward sensation that the code is grating
on you. At this point, we’ll seek lubrication from the lubridate package, which makes
your date-time code more readable.
Chapter Goals
After reading this chapter, you should:
• Understand the built-in date classes POSIXct, POSIXlt, and Date
• Be able to convert a string into a date
• Know how to display dates in a variety of formats
• Be able to specify and manipulate time zones
• Be able to use the lubridate package
2. UTC’s acronym is the wrong way around to make it match other universal time standards (UT0, UT1, etc.).
It is essentially identical to (civil) Greenwich Mean Time (GMT), except that Greenwich Mean Time isn’t a
scientific standard, and the British government can’t change UTC.
Date and Time Classes
There are three date and time classes that come with R: POSIXct, POSIXlt, and Date.
POSIX Dates and Times
POSIX dates and times are classic R: brilliantly thorough in their implementation, nav‐
igating all sorts of obscure technical issues, but with awful Unixy names that make
everything seem more complicated than it really is.
The two standard date-time classes in R are POSIXct and POSIXlt. (I said the names
were awful!) POSIX is a set of standards that defines compliance with Unix, including
how dates and times should be specified. ct is short for “calendar time,” and the POSIXct
class stores dates as the number of seconds since the start of 1970, in the Coordinated
Universal Time (UTC) zone.2 POSIXlt stores dates as a list, with components for sec‐
onds, minutes, hours, day of month, etc. POSIXct is best for storing dates and calculating
with them, whereas POSIXlt is best for extracting specific parts of a date.
The function Sys.time returns the current date and time in POSIXct form:
(now_ct <-  Sys.time())
## [1] "2013-07-17 22:47:01 BST"
The class ofnow_ct has two elements. It is a POSIXct variable, and POSIXct is inherited
from the class POSIXt:
class(now_ct)
## [1] "POSIXct" "POSIXt"
When a date is printed, you just see a formatted version of it, so it isn’t obvious how the
date is stored. By using unclass, we can see that it is indeed just a number:
unclass(now_ct)
## [1] 1.374e+09
When printed, the POSIXlt date looks exactly the same, but underneath the storage
mechanism is very different:
(now_lt <-  as.POSIXlt(now_ct))
## [1] "2013-07-17 22:47:01 BST"
class(now_lt)
## [1] "POSIXlt" "POSIXt"

unclass(now_lt)
## $sec
## [1] 1.19
##
## $min
## [1] 47
##
## $hour
## [1] 22
##
## $mday
## [1] 17
##
## $mon
## [1] 6
##
## $year
## [1] 113
##
## $wday
## [1] 3
##
## $yday
## [1] 197
##
## $isdst
## [1] 1
##
## attr(,"tzone")
## [1] "" "GMT" "BST"
You can use list indexing to access individual components of a POSIXlt date:
now_lt$sec
## [1] 1.19
now_lt[["min" ]]
## [1] 47
The Date Class
The third date class in base R is slightly better-named: it is the Date class. This stores
dates as the number of days since the start of 1970.3 The Date class is best used when
you don’t care about the time of day. Fractional days are possible (and can be generated
by calculating a mean Date, for example), but the POSIX classes are better for those
situations:

(now_date <-  as.Date(now_ct))
## [1] "2013-07-17"
class(now_date)
## [1] "Date"
unclass(now_date)
## [1] 15903
Other Date Classes
There are lots of other date and time classes scattered through other R classes. If you
have a choice of which date-time class to use, you should usually stick to one of the three
base classes (POSIXct, POSIXlt, and Date), but you need to be aware of the other classes
if you are using other people’s code that may depend upon them.
Other date and time classes from add-on packages include date, dates, chron, year
mon, yearqtr, timeDate, ti, and jul.
Conversion to and from Strings
Many text file formats for data don’t explicitly support specific date types. For example,
in a CSV file, each value is just a string. In order to access date functionality in R, you
must convert your date strings into variables of one of the date classes. Likewise, to write
back to CSV, you must convert the dates back into strings.
Parsing Dates
When we read in dates from a text or spreadsheet file, they will typically be stored as a
character vector or factor. To convert them to dates, we need to parse these strings. This
can be done with another appallingly named function, strptime (short for “string parse
time”), which returns POSIXlt dates. (There are as.POSIXct and as.POSIXlt functions
too. If you call them on character inputs, then they are just wrappers around
strptime.) To parse the dates, you must tell strptime which bits of the string correspond
to which bits of the date. The date format is specified using a string, with components
specified with a percent symbol followed by a letter. For example, the day of the month
as a number is specified as %d. These components can be combined with other fixed
characters—such as colons in times, or dashes and slashes in dates—to form a full spec‐
ification. The time zone specification varies depending upon your operating system. It
can get complicated, so the minutiae are discussed later, but you usually want "UTC" for
universal time or ""  to use the time zone in your current locale (as determined from
your operating system’s locale settings).

In the following example, %H is the hour (24-hour system), %M is the minute, %S is the
second, %m is the number of the month, %d (as previously discussed) is the day of the
month, and %Y is the four-digit year. The complete list of component specifiers varies
from system to system. See the ?strptime help page for the details:
moon_landings_str <-  c(
"20:17:40 20/07/1969" ,
"06:54:35 19/11/1969" ,
"09:18:11 05/02/1971" ,
"22:16:29 30/07/1971" ,
"02:23:35 21/04/1972" ,
"19:54:57 11/12/1972"
)(
moon_landings_lt <-  strptime(
moon_landings_str,
"%H:%M:%S %d/%m/%Y" ,
tz = "UTC"
))
## [1] "1969-07-20 20:17:40 UTC" "1969-11-19 06:54:35 UTC"
## [3] "1971-02-05 09:18:11 UTC" "1971-07-30 22:16:29 UTC"
## [5] "1972-04-21 02:23:35 UTC" "1972-12-11 19:54:57 UTC"
If a string does not match the format in the format string, it takes the value NA. For
example, specifying dashes instead of slashes makes the parsing fail:
strptime(
moon_landings_str,
"%H:%M:%S %d-%m-%Y" ,
tz = "UTC"
)
## [1] NA NA NA NA NA NA
Formatting Dates
The opposite problem of parsing is turning a date variable into a string—that is, for‐
matting it. In this case, we use the same system for specifying a format string, but now
we call strftime (“string format time”) to reverse the parsing operation. In case you
struggle to remember the name strftime, these days the format function will also
happily format dates in a nearly identical manner to strftime.
In the following example, %I is the hour (12-hour system), %p is the AM/PM indicator,
%A is the full name of the day of the week, and %B is the full name of the month. strftime
works with both POSIXct and POSIXlt inputs:
strftime(now_ct, "It's %I:%M%p on %A %d %B, %Y." )
## [1] "It's 10:47PM on Wednesday 17 July, 2013."

Time Zones
Time zones are horrible, complicated things from a programming perspective. Coun‐
tries often have several, and change the boundaries when some (but not all) switch to
daylight savings time. Many time zones have abbreviated names, but they often aren’t
unique. For example, “EST” can refer to “Eastern Standard Time” in the United States,
Canada, or Australia.
You can specify a time zone when parsing a date string (with strptime) and change it
again when you format it (with strftime). During parsing, if you don’t specify a time
zone (the default is "" ), R will give the dates a default time zone. This is the value returned
by Sys.timezone, which is in turn guessed from your operating system locale settings.
You can see the OS date-time settings with Sys.getlocale("LC_TIME").
The easiest way to avoid the time zone mess is to always record and then analyze your
times in the UTC zone. If you can achieve this, congratulations! You are very lucky. For
everyone else—those who deal with other people’s data, for example—the easiest-to
read and most portable way of specifying time zones is to use the Olson form, which is
“Continent/City” or similar:
strftime(now_ct,  tz = "America/Los_Angeles" )
## [1] "2013-07-17 14:47:01"
strftime(now_ct,  tz = "Africa/Brazzaville" )
## [1] "2013-07-17 22:47:01"
strftime(now_ct,  tz = "Asia/Kolkata" )
## [1] "2013-07-18 03:17:01"
strftime(now_ct,  tz = "Australia/Adelaide" )
## [1] "2013-07-18 07:17:01"
A list of possible Olson time zones is shipped with R in the file returned by
file.path(R.home("share"), "zoneinfo", "zone.tab"). (That’s a file called
zone.tab in a folder called zoneinfo inside the share directory where you installed R.)
The lubridate package described later in this chapter provides convenient access to
this file.
The next most reliable method is to give a manual offset from UTC, in the form "UTC"+n"
or "UTC"- n" . Negative times are east of UTC, and positive times are west. The manual
nature at least makes it clear how the times are altered, but you have to manually do the
daylight savings corrections too, so this method should be used with care. Recent ver‐
sions of R will warn that the time zone is unknown, but will perform the offset correctly:
strftime(now_ct,  tz = "UTC-5" )
## Warning: unknown timezone 'UTC-5'
## [1] "2013-07-18 02:47:01"
strftime(now_ct,  tz = "GMT-5" ) #same
## Warning: unknown timezone 'GMT-5'
## [1] "2013-07-18 02:47:01"
strftime(now_ct,  tz = "-5" ) #same, if supported on your OS
## Warning: unknown timezone '-5'
## [1] "2013-07-18 02:47:01"
strftime(now_ct,  tz = "UTC+2:30" )
## Warning: unknown timezone 'UTC+2:30'
## [1] "2013-07-17 19:17:01"
The third method of specifying time zones is to use an abbreviation—either three letters
or three letters, a number, and three more letters. This method is the last resort, for three
reasons. First, abbreviations are harder to read, and thus more prone to errors. Second,
as previously mentioned, they aren’t unique, so you may not get the time zone that you
think you have. Finally, different operating systems support different sets of abbrevia‐
tions. In particular, the Windows OS’s knowledge of time zone abbreviations is patchy:
strftime(now_ct,  tz = "EST" ) #Canadian Eastern Standard Time
## [1] "2013-07-17 16:47:01"
strftime(now_ct,  tz = "PST8PDT" ) #Pacific Standard Time w/ daylight savings
## [1] "2013-07-17 14:47:01"
One last word of warning about time zones: strftime ignores time zone changes for
POSIXlt dates. It is best to explicitly convert your dates to POSIXct before printing:
strftime(now_ct,  tz = "Asia/Tokyo" )
## [1] "2013-07-18 06:47:01"
strftime(now_lt,  tz = "Asia/Tokyo" ) #no zone change!
## [1] "2013-07-17 22:47:01"
strftime(as.POSIXct(now_lt),  tz = "Asia/Tokyo" )
## [1] "2013-07-18 06:47:01"
Another last warning (really the last one!): if you call the concatenation function, c, with
a POSIXlt argument, it will change the time zone to your local time zone. Calling c on
a POSIXct argument, by contrast, will strip its time zone attribute completely. (Most
other functions will assume that the date is now local, but be careful!)

Arithmetic with Dates and Times
R supports arithmetic with each of the three base classes. Adding a number to a POSIX
date shifts it by that many seconds. Adding a number to a Date shifts it by that many
days:
now_ct + 86400 #Tomorrow. I wonder what the world will be like!
## [1] "2013-07-18 22:47:01 BST"
now_lt + 86400 #Same behavior for POSIXlt
## [1] "2013-07-18 22:47:01 BST"
now_date + 1 #Date arithmetic is in days
## [1] "2013-07-18"
Adding two dates together doesn’t make much sense, and throws an error. Subtraction
is supported, and calculates the difference between the two dates. The behavior is the
same for all three date types. In the following example, note that as.Date will automat‐
ically parse dates of the form %Y-%m-%d or %Y/%m/%d, if you don’t specify a format:
the_start_of_time <-  #according to POSIX
as.Date("1970-01-01" )
the_end_of_time <-  #according to Mayan conspiracy theorists
as.Date("2012-12-21" )
(all_time <-  the_end_of_time -  the_start_of_time)
## Time difference of 15695 days
We can use the now (hopefully) familiar combination ofclass and unclass to see how
the difference in time is stored:
class(all_time)
## [1] "difftime"
unclass(all_time)
## [1] 15695
## attr(,"units")
## [1] "days"
The difference has class difftime, and the value is stored as a number with a unit
attribute of days. Days were automatically chosen as the “most sensible” unit due to the
difference between the times. Differences shorter than one day are given in hours, mi‐
nutes, or seconds, as appropriate. For more control over the units, you can use the
difftime function:
difftime(the_end_of_time,  the_start_of_time,  units = "secs" )
## Time difference of 1.356e+09 secs

difftime(the_end_of_time,  the_start_of_time,  units = "weeks" )
## Time difference of 2242 weeks
The seq function for generating sequences also works with dates. This can be particu‐
larly useful for creating test datasets of artificial dates. The choice of units in the by
argument differs between the POSIX and Date types. See the ?seq.POSIXt
and ?seq.Date help pages for the choices in each case:
seq(the_start_of_time,  the_end_of_time,  by = "1 year" )
## [1] "1970-01-01" "1971-01-01" "1972-01-01" "1973-01-01" "1974-01-01"
## [6] "1975-01-01" "1976-01-01" "1977-01-01" "1978-01-01" "1979-01-01"
## [11] "1980-01-01" "1981-01-01" "1982-01-01" "1983-01-01" "1984-01-01"
## [16] "1985-01-01" "1986-01-01" "1987-01-01" "1988-01-01" "1989-01-01"
## [21] "1990-01-01" "1991-01-01" "1992-01-01" "1993-01-01" "1994-01-01"
## [26] "1995-01-01" "1996-01-01" "1997-01-01" "1998-01-01" "1999-01-01"
## [31] "2000-01-01" "2001-01-01" "2002-01-01" "2003-01-01" "2004-01-01"
## [36] "2005-01-01" "2006-01-01" "2007-01-01" "2008-01-01" "2009-01-01"
## [41] "2010-01-01" "2011-01-01" "2012-01-01"
seq(the_start_of_time,  the_end_of_time,  by = "500 days" ) #of Summer
## [1] "1970-01-01" "1971-05-16" "1972-09-27" "1974-02-09" "1975-06-24"
## [6] "1976-11-05" "1978-03-20" "1979-08-02" "1980-12-14" "1982-04-28"
## [11] "1983-09-10" "1985-01-22" "1986-06-06" "1987-10-19" "1989-03-02"
## [16] "1990-07-15" "1991-11-27" "1993-04-10" "1994-08-23" "1996-01-05"
## [21] "1997-05-19" "1998-10-01" "2000-02-13" "2001-06-27" "2002-11-09"
## [26] "2004-03-23" "2005-08-05" "2006-12-18" "2008-05-01" "2009-09-13"
## [31] "2011-01-26" "2012-06-09"
Many other base functions allow manipulation of dates. You can repeat them, round
them, and cut them. You can also calculate summary statistics with mean and
summary. Many of the possibilities can be seen with methods(class = "POSIXt")  and
methods(class = "Date"), although some other functions will handle dates without
having specific date methods.
Lubridate
If you’ve become disheartened with dates and are considering skipping the rest of the
chapter, do not fear! Help is at hand. lubridate, as the name suggests, adds some much
needed lubrication to the process of date manipulation. It doesn’t add many new features
over base R, but it makes your code more readable, and helps you avoid having to think
too much.
To replace strptime, lubridate has a variety of parsing functions with predetermined
formats. ymd accepts dates in the form year, month, day. There is some flexibility in the
specification: several common separators like hyphens, forward and backward slashes,

4. In fact, most punctuation is allowed.
colons, and spaces can be used;4 months can be specified by number or by full or ab‐
breviated name; and the day of the week can optionally be included. The real beauty is
that different elements in the same vector can have different formats (as long as the year
is followed by the month, which is followed by the day):
library(lubridate)
## Attaching package: 'lubridate'
## The following object is masked from 'package:chron':
##
## days, hours, minutes, seconds, years
john_harrison_birth_date <-  c( #He invented the marine chronometer
"1693-03 24" ,
"1693/03\\24" ,
"Tuesday+1693.03*24"
)
ymd(john_harrison_birth_date) #All the same
## [1] "1693-03-24 UTC" "1693-03-24 UTC" "1693-03-24 UTC"
The important thing to remember with ymd is to get the elements of the date in the right
order. If your date data is in a different form, then lubridate provides other functions
(ydm, mdy, myd, dmy, and dym) to use instead. Each of these functions has relatives that
allow the specification of times as well, so you get ymd_h, ymd_hm, and ymd_hms, as well
as the equivalents for the other five date orderings. If your dates aren’t in any of these
formats, then the lower-level parse_date_time lets you give a more exact specification.
All the parsing functions in lubridate return POSIXct dates and have a default time
zone of UTC. Be warned: these behaviors are different from base R’s strptime! (Al‐
though usually more convenient.) In lubridate terminology, these individual dates are
“instants.”
For formatting dates, lubridate provides stamp, which lets you specify a format in a
more human-readable manner. You specify an example date, and it returns a function
that you can call to format your dates:
date_format_function <-
stamp("A moon landing occurred on Monday 01 January 1900 at 18:00:00." )
## Multiple formats matched: "A moon landing occurred on %A %m January %d%y
## at %H:%M:%OS"(1), "A moon landing occurred on %A %m January %Y at
## %d:%H:%M."(1), "A moon landing occurred on %A %d %B %Y at %H:%M:%S."(1)
## Using: "A moon landing occurred on %A %d %B %Y at %H:%M:%S."
date_format_function(moon_landings_lt)
## [1] "A moon landing occurred on Sunday 20 July 1969 at 20:17:40."

For dealing with ranges of times, lubridate has three different variable types. “Dura‐
tions” specify time spans as multiples of seconds, so a duration of a day is always 86,400
seconds (60 * 60 * 24), and a duration of a year is always 31,536,000 seconds (86,400 *
365). This makes it easy to specify ranges of dates that are exactly evenly spaced, but
leap years and daylight savings time put them out of sync from clock time. In the fol‐
lowing example, notice that the date slips back one day every time there is a leap year.
today gives today’s date:
(duration_one_to_ten_years <-  dyears(1: 10))
## [1] "31536000s (~365 days)" "63072000s (~730 days)"
## [3] "94608000s (~1095 days)" "126144000s (~1460 days)"
## [5] "157680000s (~1825 days)" "189216000s (~2190 days)"
## [7] "220752000s (~2555 days)" "252288000s (~2920 days)"
## [9] "283824000s (~3285 days)" "315360000s (~3650 days)"
today() + duration_one_to_ten_years
## [1] "2014-07-17" "2015-07-17" "2016-07-16" "2017-07-16" "2018-07-16"
## [6] "2019-07-16" "2020-07-15" "2021-07-15" "2022-07-15" "2023-07-15"
Other functions for creating durations are dseconds, dminutes, and so forth, as well as
new_duration for mixed-component specification.
“Periods” specify time spans according to clock time. That means that their exact length
isn’t apparent until you add them to an instant. For example, a period of one year can
be 365 or 366 days, depending upon whether or not it is a leap year. In the following
example, notice that the date stays the same across leap years:
(period_one_to_ten_years <-  years(1: 10))
## [1] "1y 0m 0d 0H 0M 0S" "2y 0m 0d 0H 0M 0S" "3y 0m 0d 0H 0M 0S"
## [4] "4y 0m 0d 0H 0M 0S" "5y 0m 0d 0H 0M 0S" "6y 0m 0d 0H 0M 0S"
## [7] "7y 0m 0d 0H 0M 0S" "8y 0m 0d 0H 0M 0S" "9y 0m 0d 0H 0M 0S"
## [10] "10y 0m 0d 0H 0M 0S"
today() + period_one_to_ten_years
## [1] "2014-07-17" "2015-07-17" "2016-07-17" "2017-07-17" "2018-07-17"
## [6] "2019-07-17" "2020-07-17" "2021-07-17" "2022-07-17" "2023-07-17"
In addition to years, you can create periods with seconds, minutes, etc., as well as
new_period for mixed-component specification.
“Intervals” are defined by the instants at their beginning and end. They aren’t much use
on their own—they are most commonly used for specifying durations and periods when
you known the start and end dates (rather than how long they should last). They can
also be used for converting between durations and periods. For example, given a dura‐
tion of one year, direct conversion to a period can only be estimated, since periods of a
year can be 365 or 366 days (possibly plus a few leap seconds, and possibly plus or minus
an hour or two if the rules for daylight savings change):

a_year <-  dyears(1) #exactly 60*60*24*365 seconds
as.period(a_year) #only an estimate
## estimate only: convert durations to intervals for accuracy
## [1] "1y 0m 0d 0H 0M 0S"
If we know the start (or end) date of the duration, we can use an interval and an
intermediary to convert exactly from the duration to the period:
start_date <-  ymd("2016-02-28" )
(interval_over_leap_year <-  new_interval(
start_date,
start_date + a_year
))
## [1] 2016-02-28 UTC--2017-02-27 UTC
as.period(interval_over_leap_year)
## [1] "11m 30d 0H 0M 0S"
Intervals also have some convenience operators, namely %--% for defining intervals and
%within% for checking if a date is contained within an interval:
ymd("2016-02-28" ) %--% ymd("2016-03-01" ) #another way to specify interval
## [1] 2016-02-28 UTC--2016-03-01 UTC
ymd("2016-02-29" ) %within% interval_over_leap_year
## [1] TRUE
For dealing with time zones, with_tz lets you change the time zone of a date without
having to print it (unlike strftime). It also correctly handles POSIXlt dates (again,
unlike strftime):
with_tz(now_lt,  tz = "America/Los_Angeles" )
## [1] "2013-07-17 14:47:01 PDT"
with_tz(now_lt,  tz = "Africa/Brazzaville" )
## [1] "2013-07-17 22:47:01 WAT"
with_tz(now_lt,  tz = "Asia/Kolkata" )
## [1] "2013-07-18 03:17:01 IST"
with_tz(now_lt,  tz = "Australia/Adelaide" )
## [1] "2013-07-18 07:17:01 CST"
force_tz is a variant of with_tz used for updating incorrect time zones.
olson_time_zones returns a list of all the Olson-style time zone names that R knows
about, either alphabetically or by longitude:

head(olson_time_zones())
## [1] "Africa/Abidjan" "Africa/Accra" "Africa/Addis_Ababa"
## [4] "Africa/Algiers" "Africa/Asmara" "Africa/Bamako"
head(olson_time_zones("longitude" ))
## [1] "Pacific/Midway" "America/Adak" "Pacific/Chatham"
## [4] "Pacific/Wallis" "Pacific/Tongatapu" "Pacific/Enderbury"
Some other utilities are available for arithmetic with dates, particularly floor_date and
ceiling_date:
floor_date(today(), "year" )
## [1] "2013-01-01"
ceiling_date(today(), "year" )
## [1] "2014-01-01"
Summary
• There are three built-in classes for storing dates and times: POSIXct, POSIXlt, and
Date.
• Parsing turns a string into a date; it can be done with strptime.
• Formatting turns a date back into a string; it can be done with strftime.
• Time zones can be specified using an Olson name or an offset from UTC, or (some‐
times) with a three-letter abbreviation.
• The lubridate package makes working with dates a bit easier.
#######################################################

require(stats)

methods(summary)
methods(class = "aov")    # S3 class
## The same, with more details and more difficult to read:
print(methods(class = "aov"), byclass=FALSE)
methods("[[")             # uses C-internal dispatching
methods("$")
methods("$<-")            # replacement function
methods("+")              # binary operator
methods("Math")           # group generic
require(graphics)
methods("axis")           # looks like a generic, but is not

if(require(Matrix)) {
print(methods(class = "Matrix"))  # S4 class
m <- methods("dim")       # S3 and S4 methods
print(m)
print(attr(m, "info"))    # more extensive information

## --> help(showMethods) for related examples
}


 [40] ".mergeImportMethods"                 ".methodsNamespace"                   ".OptRequireMethods"                 
 [43] ".S3methods"                          ".S4methods"                          ".TraceWithMethods"                  
 [46] "addNextMethod"                       "asMethodDefinition"                  "assignMethodsMetaData"              
 [49] "balanceMethodsList"                  "cacheMethod"                         "callNextMethod"                     
 [52] "conformMethod"                       "doPrimitiveMethod"                   "dumpMethod"                         
 [55] "dumpMethods"                         "emptyMethodsList"                    "existsMethod"                       
 [58] "externalRefMethod"                   "finalDefaultMethod"                  "findMethod"                         
 [61] "findMethods"                         "findMethodSignatures"                "getAllMethods"                      
 [64] "getMethod"                           "getMethods"                          "getMethodsForDispatch"              
 [67] "getMethodsMetaData"                  "getS3method"                         "hasMethod"                          
 [70] "hasMethods"                          "insertClassMethods"                  "insertMethod"                       
 [73] "is_s3_method"                        "isS3method"                          "isSealedMethod"                     
 [76] "listFromMethods"                     "loadMethod"                          "makeMethodsList"                    
 [79] "mergeMethods"                        "method.skeleton"                     "method_from_call"                   
 [82] "MethodAddCoerce"                     "methods"                             "methodSignatureMatrix"              
 [85] "MethodsList"                         "MethodsListSelect"                   "methodsPackageMetaName"             
 [88] "namespaceImportMethods"              "NextMethod"                          "p.adjust.methods"                   
 [91] "print.instantiatedProtoMethod"       "promptMethods"                       "registerS3method"                   
 [94] "registerS3methods"                   "removeMethod"                        "removeMethods"                      
 [97] "removeMethodsObject"                 "requireMethods"                      "selectMethod"                       
[100] "setMethod"                           "setPrimitiveMethods"                 "setReplaceMethod"                   
[103] "showMethods"                         "SignatureMethod"                     "testInheritedMethods"               
[106] "UseMethod"                          

## Assuming the methods for plot
## are set up as in the example of help(setMethod),
## print (without definitions) the methods that involve class "track":
showMethods("plot", classes = "track")
hasMethods("plot", classes = "track")
## Not run: 
# Function "plot":
# x = ANY, y = track
# x = track, y = missing
# x = track, y = ANY

require("Matrix")
showMethods("%*%")# many!
    methods(class = "Matrix")# nothing
showMethods(class = "Matrix")# everything
showMethods(Matrix:::isDiagonal) # a non-exported generic

## End(Not run)



if(no4 <- is.na(match("stats4", loadedNamespaces())))
   loadNamespace("stats4")
showMethods(classes = "mle") # -> a method for show()
if(no4) unloadNamespace("stats4")


#######################################################
data()
data(package = . packages(TRUE))
data("kidney" ,  package = "survival" )
library(learningr)
deer_file <-  system.file(
 "extdata" ,
 "RedDeerEndocranialVolume.dlm" ,
 package = "learningr"
)
deer_data <-  read.table(deer_file,  header = TRUE,  fill = TRUE)
str(deer_data,  vec.len = 1) #vec.len alters the amount of output
head(deer_data)


crab_file <-  system.file(
"extdata" ,
"crabtag.csv" ,
package = "learningr"
)(
crab_id_block <-  read.csv(
crab_file,
header = FALSE,
skip = 3,
nrow = 2
))

(crab_tag_notebook <-  read.csv(
crab_file,
header = FALSE,
skip = 8,
nrow = 5
))

(crab_lifetime_notebook <-  read.csv(
crab_file,
header = FALSE,
skip = 15,
nrow = 3
))


# The colbycol and sqldf packages contain functions that allow you to
# read part of a CSV file into R. This can provide a useful speed-up if
# you don’t need all the columns or all the rows


write.csv(
crab_lifetime_notebook,
"Data/Cleaned/crab lifetime data.csv" ,
row.names = FALSE,
fileEncoding = "utf8"
)

text_file <-  system.file(
"extdata" ,
"Shakespeare's The Tempest, from Project Gutenberg pg2235.txt" ,
package = "learningr"
)
the_tempest <-  readLines(text_file)
the_tempest[1926: 1927]

writeLines(
rev(text_file),  #rev reverses vectors
"Shakespeare's The Tempest, backwards.txt"
)

help(package="XML")

library(XML)
xml_file <-  system.file("extdata" , "options.xml" ,  package = "learningr" )

xml_file <- "e:/licenseRequest.xml"
r_options <-  xmlParse(xml_file)
r_options2 <- xmlParse(xml_file,  useInternalNodes = FALSE)
r_options2 <- xmlTreeParse(xml_file) #the same
xpathSApply(r_options, "//component/name" )
xpathSApply(r_options, "//component/name" ) %>% ldply(print)
# htmlParse and
# htmlTreeParse, and they behave in the same way.


library(Runiversal)
ops <-  as.list(options())
cat(makexml(ops),  file = "e:/options.xml" )



########################################################
json

library(RJSONIO)
library(rjson)
jamaican_city_file <-  system.file(
"extdata" ,
"Jamaican Cities.json" ,
package = "learningr"
)(
jamaican_cities_RJSONIO <-  RJSONIO:: fromJSON(jamaican_city_file))
## $Kingston
## $Kingston$population
## [1] 587798
##
## $Kingston$coordinates
## longitude latitude
## 17.98 76.80
##
##
## $`Montego Bay`
## $`Montego Bay`$population
## [1] 96488
##
## $`Montego Bay`$coordinates
## longitude latitude
## 18.47 77.92
special_numbers <-  c(NaN, NA,  Inf, - Inf)
RJSONIO:: toJSON(special_numbers)
## [1] "[ null, null, Inf, -Inf ]"
rjson:: toJSON(special_numbers)
## [1] "[\"NaN\",\"NA\",\"Inf\",\"-Inf\"]"
library(yaml)
yaml.load_file(jamaican_city_file)
## $Kingston
## $Kingston$population
## [1] 587798
##
## $Kingston$coordinates
## $Kingston$coordinates$longitude
## [1] 17.98
##
## $Kingston$coordinates$latitude
## [1] 76.8
##
##
##
## $`Montego Bay`
## $`Montego Bay`$population
## [1] 96488
##
## $`Montego Bay`$coordinates
## $`Montego Bay`$coordinates$longitude
## [1] 18.47
##
## $`Montego Bay`$coordinates$latitude
## [1] 77.92
as.yaml performs the opposite task, converting R objects to YAML strings.
#######################################################
library(xlsx)
bike_file <-  system.file(
"extdata" ,
"Alpe d'Huez.xls" ,
package = "learningr"
)
bike_data <-  read.xlsx2(
bike_file,
sheetIndex = 1,
startRow = 2,
endRow = 38,
colIndex = 2: 8,
colClasses = c(
"character" , "numeric" , "character" , "integer" ,
"character" , "character" , "character"
)
)
head(bike_data)
text<-available.packages()
grep("pdf", text, value = TRUE)

> grep("pdf", text, value = TRUE)
[1] "inpdfr"                                                                                      
[2] "pdfCluster"                                                                                  
[3] "pdfetch"                                                                                     
[4] "pdftables"                                                                                   
[5] "pdftools"                                                                                    
[6] "testthat, covr, rmarkdown, knitr, pdftools, RISmed"                                          
[7] "testthat, devtools, pdftools, janeaustenr, wordcloud2, knitr,\nrmarkdown"                    
[8] "knitr, rmarkdown, magrittr, rsvg, webp, png, pdftools,\nggplot2, raster"                     
[9] "filehash, methods, Rcampdf, Rgraphviz, Rpoppler, SnowballC,\ntm.lexicon.GeneralInquirer, XML"


> grep("ython", text, value = TRUE)
 [1] "findpython"                                                 
 [2] "PythonInR"                                                  
 [3] "rJython"                                                    
 [4] "XRPython"                                                   
 [5] "rJava, rjson, rJython"                                      
 [6] "findpython"                                                 
 [7] "rJython"                                                    
 [8] "findpython, getopt (>= 1.19), rjson"                        
 [9] "findpython"                                                 
[10] "methods, XR, rPython"                                       
[11] "MASS, rPython, deSolve, rootSolve, pander, knitr, rmarkdown"
[12] "testthat, rPython (>= 0.0-5)"                               
[13] "doMC, rPython"  

text
xlsReadWrite package


available.package

library(quantmod)
#If you are using a version before 0.5.0 then set this option
#or pass auto.assign = FALSE to getSymbols.
options(getSymbols.auto.assign = FALSE)
microsoft <-  getSymbols("MSFT" )
head(microsoft)

twitteR


The twitteR package provides access to Twitter’s users and their tweets. There’s a little
bit of setup involved (due to Twitter’s API requiring you to create an application and
register it using OAuth; read the vignette for the package for setup instructions), but
after that the package makes it easy to import Twitter data for network analysis, or simply
look at tweets while pretending to work.


Scraping Web Pages

salary_url <- "http://www.justinmrao.com/salary_data.csv"
local_copy <- "my local copy.csv"
download.file(salary_url,  local_copy)
salary_data <-  read.csv(local_copy)

The next example retrieves the current date and time in several time zones from the
United States Naval Observatory Time Service Department web page. The function
getURL retrieves the page as a character string:
library(RCurl)
time_url <- "http://tycho.usno.navy.mil/cgi-bin/timer.pl"
time_page <-  getURL(time_url)
cat(time_page)

time_doc <-  htmlParse(time_page)
pre <-  xpathSApply(time_doc, "//pre" )[[1]]
values <-  strsplit(xmlValue(pre), "\n" )[[1]][-1]
strsplit(values, "\t+" )

library(httr)
time_page <-  GET(time_url)
time_doc <-  content(page,  useInternalNodes = TRUE)


## <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final"//EN>
## <html>
## <body>
## <TITLE>What time is it?</TITLE>
## <H2> US Naval Observatory Master Clock Time</H2> <H3><PRE>
## <BR>Jul. 17, 20:43:37 UTC Universal Time
## <BR>Jul. 17, 04:43:37 PM EDT Eastern Time
## <BR>Jul. 17, 03:43:37 PM CDT Central Time
## <BR>Jul. 17, 02:43:37 PM MDT Mountain Time
## <BR>Jul. 17, 01:43:37 PM PDT Pacific Time
## <BR>Jul. 17, 12:43:37 PM AKDT Alaska Time
## <BR>Jul. 17, 10:43:37 AM HAST Hawaii-Aleutian Time
## </PRE></H3><P><A HREF="http://www.usno.navy.mil"> US Naval Observatory</A>
##
## </body></html>

#######################################################
Accessing Databases

library(DBI)
library(RSQLite)
Then you define the database driver to be of type “SQLite” and set up a connection to
the database, in this case by naming the file:
driver <-  dbDriver("SQLite" )
db_file <-  system.file(
"extdata" ,
"crabtag.sqlite" ,
package = "learningr"
)
conn <-  dbConnect(driver,  db_file)
The equivalent for a MySQL database would be to load the RMySQL package and set the
driver type to be “MySQL”:
driver <-  dbDriver("MySQL" )
db_file <- "path/to/MySQL/database"
conn <-  dbConnect(driver,  db_file)

query <- "SELECT * FROM IdBlock"
(id_block <-  dbGetQuery(conn,  query))
dbDisconnect(conn)
dbUnloadDriver(driver)

query_crab_tag_db <- function(query)
{
driver <-  dbDriver("SQLite" )
db_file <-  system.file(
"extdata" ,
"crabtag.sqlite" ,
package = "learningr"
)
conn <-  dbConnect(driver,  db_file)
on.exit(
{
#this code block runs at the end of the function,
#even if an error is thrown
dbDisconnect(conn)
dbUnloadDriver(driver)
}
)
dbGetQuery(conn,  query)
}

dbListTables(conn)

dbReadTable(conn, "idblock" )


library(RODBC)
conn <-  odbcConnect("my data source name" )
id_block <-  sqlQuery(conn, "SELECT * FROM IdBlock" )
odbcClose(conn)


#######################################################

The grep, grepl, and regexpr functions all find strings that match a pattern, and sub
and gsub replace matching strings. In classic R style, these functions are meticulously
correct and very powerful, but suffer from funny naming conventions, quirky argument
ordering, and odd return values that have arisen for historical reasons. Fortunately, in
the same way that plyr provides a consistent wrapper around apply functions and
lubridate provides a consistent wrapper around the date-time functions, the stringr
package provides a consistent wrapper around the string manipulation functions. The
difference is that while you will occasionally need to use a base apply or date-time
function, stringr is advanced enough that you shouldn’t need to bother with grep at
all. So, take a look at the ?grep help page, but don’t devote too much of your brain to it.


#######################################################
library(stringr)
?str_detect

# Similarly, it was quite common for power over a kingdom to be shared between several
# people, rather than having a single ruler. (This was especially common when a powerful
# king had several sons.) We can find these instances by looking for either a comma or
# the word “and” in the name column. This time, since we are looking for two things, it is
# easier to specify a regular expression rather than a fixed string. The pipe character, | ,
# has the same meaning in regular expressions as it does in R: it means “or.”
# In this next example, to prevent excessive output we just return the name column and
# ignore missing values (with is.na):
multiple_rulers <-  str_detect(english_monarchs$name, ",|and" )
english_monarchs$name[multiple_rulers & !is.na(multiple_rulers)]


str_split 

str_split_fixed

individual_rulers <-  str_split(english_monarchs$name, ", | and " )
head(individual_rulers[sapply(individual_rulers,  length) > 1])
str_count

th <-  c("th" , "ð" , " þ
sapply( #can also use laply from plyr
th,
function(th)
{
sum(str_count(english_monarchs$name,  th))
}
)

str_replace_all. (A variant function,
str_replace, replaces only the first match.)

english_monarchs$new_name <-  str_replace_all(english_monarchs$name, "[ðþ]" , "th" )
gender <-  c(
"MALE" , "Male" , "male" , "M" , "FEMALE" ,
"Female" , "female" , "f" , NA
)
clean_gender <-  str_replace(
gender,
ignore.case("^m(ale)?$" ),
"Male"
)(
clean_gender <-  str_replace(
clean_gender,
ignore.case("^f(emale)?$" ),
"Female"
))
## [1] "Male" "Male" "Male" "Male" "Female" "Female" "Female" "Female"
## [9] NA

gender <-  c(
"MALE" , "Male" , "male" , "M" , "FEMALE" ,
"Female" , "female" , "f" , NA
)
clean_gender <-  str_replace(
gender,
ignore.case("^m(ale)?$" ),
"Male"
)(
clean_gender <-  str_replace(
clean_gender,
ignore.case("^f(emale)?$" ),
"Female"
))
## [1] "Male" "Male" "Male" "Male" "Female" "Female" "Female" "Female"
## [9] NA


#######################################################
Manipulating Data Frames

Adding and Replacing Columns

english_monarchs <-  mutate(
english_monarchs,
length.of.reign.years = end.of.reign -  start.of.reign,
reign.was.more.than.30.years = length.of.reign.years > 30
)

Dealing with Missing Values

The complete.cases function
tells us which rows are free of missing values:

data("deer_endocranial_volume" ,  package = "learningr" )
has_all_measurements <-  complete.cases(deer_endocranial_volume)
deer_endocranial_volume[has_all_measurements, ]

?mutate

transmute

> mtcars %>% head
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
> mtcars %>% mutate(displ_l = disp / 2) %>% head
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb displ_l
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4    80.0
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4    80.0
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1    54.0
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1   129.0
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2   180.0
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1   112.5
> mtcars %>% head
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
> mtcars %>% transmute(displ_l = disp / 2) %>% head
  displ_l
1    80.0
2    80.0
3    54.0
4   129.0
5   180.0
6   112.5

The na.omit function provides a shortcut to this, removing any rows of a data frame
where there are missing values:

By contrast, na.fail will throw an error if your data frame contains any missing values:
na.fail(deer_endocranial_volume)
Both these functions can accept vectors as well, removing missing values or failing, as
in the data frame case.

na.exclude does the same thing as na.omit; their dual existence is mostly for legacy purposes

#######################################################
Converting Between Wide and Long Form
 reshape2 package
 melt function
 showMethods("melt")
 melt(deer_wide,  measure.vars = c("VolCT" , "VolBead" , "VolLWH" , "VolFinarelli" ))
 The dcast function converts back from long to wide and returns the result as a data
frame (the related function acast returns a vector, matrix, or array):


 deer_wide_again <-  dcast(deer_long,  SkullID ~ variable)
#######################################################
The sqldf package provides a way of manipulating data frames using SQL. In general,
native R functions are more concise and readable than SQL code, but if you come from
a database background this package can ease your transition to R:
The next example compares the native R and sqldf versions of a subsetting query:
library(sqldf)
## Loading required package: DBI
## Loading required package: gsubfn
## Loading required package: proto
## Loading required namespace: tcltk
## Loading required package: chron
## Loading required package: RSQLite
## Loading required package: RSQLite.extfuns
subset(
 deer_endocranial_volume,
 VolCT > 400 |  VolCT2 > 400,
 c(VolCT,  VolCT2)
)
## VolCT VolCT2
## 10 410 413
## 11 405 408
## 13 416 417
## 16 418 NA
query <-
 "SELECT
 VolCT,
 VolCT2
 FROM
 deer_endocranial_volume
 WHERE
 VolCT > 400 OR
 VolCT2 > 400"
sqldf(query)
## Loading required package: tcltk
## VolCT VolCT2
## 1 410 413
## 2 405 408
## 3 416 417
## 4 418 NA
#######################################################
Sorting


Lines <- "DeployID Date.Time LocationQuality Latitude Longitude

STM05-1 28/02/2005 17:35 Good -35.562 177.158
STM05-1 28/02/2005 19:44 Good -35.487 177.129
STM05-1 28/02/2005 23:01 Unknown -35.399 177.064
STM05-1 01/03/2005 07:28 Unknown -34.978 177.268
STM05-1 01/03/2005 18:06 Poor -34.799 177.027
STM05-1 01/03/2005 18:47 Poor -34.85 177.059
STM05-2 28/02/2005 12:49 Good -35.928 177.328
STM05-2 28/02/2005 21:23 Poor -35.926 177.314
"

#################################
## in R
#################################

library(chron)
# in next line replace textConnection(Lines) with "myfile.dat"
DF <- read.table(textConnection(Lines), skip = 1,  as.is = TRUE,
 col.names = c("Id", "Date", "Time", "Quality", "Lat", "Long"))

DF2 <- transform(DF,
       Date = chron(Date, format = "d/m/y"),
       Time = times(paste(Time, "00", sep = ":")),
       Quality = factor(Quality, levels = c("Good", "Poor", "Unknown")))

o <- order(DF2$Date, as.numeric(DF2$Quality), abs(DF2$Time - times("12:00:00")))
DF2 <- DF2[o,]

DF2[tapply(row.names(DF2), DF2$Date, head, 1), ]

# The last line above could alternately be written like this:
do.call("rbind", by(DF2, DF2$Date, head, 1))

#################################
## in sqldf
#################################

DFo <- sqldf("select * from DF order by
 substr(Date, 7, 4) || substr(Date, 4, 2) || substr(Date, 1, 2) DESC,
 Quality DESC,
 abs(substr(Time, 1, 2) + substr(Time, 4, 2) /60 - 12) DESC")
sqldf("select * from DFo group by Date")

#################################
# Here is a second different way to do it in sqldf
# Another way to do it also using sqldf is via nested selects like this using
# the same DF as above
#################################

sqldf("select * from DF u
 where abs(substr(Time, 1, 2) + substr(Time, 4, 2) /60 - 12) =
  (select min(abs(substr(Time, 1, 2) + substr(Time, 4, 2) /60 - 12))
    from DF x where Quality =
      (select min(Quality) from DF y
         where x.Date = y.Date) and x.Date = u.Date)")




#######################################################
Functional Programming
ct2 <-  deer_endocranial_volume$VolCT2 #for convenience of typing
isnt.na <-  Negate(is.na)
identical(isnt.na(ct2),  !is.na(ct2))
Filter takes a function that returns a logical vector and an input vector, and returns
only those values where the function returns TRUE:
Filter(isnt.na,  ct2)
## [1] 346 303 375 413 408 394 417 345 354

Filter takes a function that returns a logical vector and an input vector, and returns
only those values where the function returns TRUE:
Filter(isnt.na,  ct2)
## [1] 346 303 375 413 408 394 417 345 354
The Position function behaves a little bit like which, which we saw in “Vectors” on page
39 in Chapter 4. It returns the first index where applying a predicate to a vector returns
TRUE:
Position(isnt.na,  ct2)
## [1] 7

Find is similar to Position, but it returns the first value rather than the first index:
Find(isnt.na,  ct2)
## [1] 346

Map applies a function element-wise to its inputs. It’s just a wrapper to mapply, with
SIMPLIFY = FALSE. In this next example, we retrieve the average measurement using
each method for each deer in the red deer dataset. First, we need a function to pass to
Map to find the volume of each deer skull:
get_volume <- function(ct,  bead,  lwh,  finarelli,  ct2,  bead2,  lwh2)
{
#If there is a second measurement, take the average
if(!is.na(ct2))
{
ct <- (ct + ct2) / 2
bead <- (bead + bead2) / 2
lwh <- (lwh + lwh2) / 2
}
#Divide lwh by 4 to bring it in line with other measurements
c(ct = ct,  bead = bead,  lwh.4 = lwh / 4,  finarelli = finarelli)
}
Then Map behaves like mapply—it takes a function and then each argument to pass to
that function:
measurements_by_deer <-  with(
deer_endocranial_volume,
Map(
get_volume,
VolCT,
VolBead,
VolLWH,
VolFinarelli,
VolCT2,
VolBead2,
VolLWH2
)
)
head(measurements_by_deer)
## [[1]]
## ct bead lwh.4 finarelli
## 389 375 371 337
##
## [[2]]
## ct bead lwh.4 finarelli
## 389.0 370.0 430.5 377.0
##
## [[3]]
## ct bead lwh.4 finarelli
## 352.0 345.0 373.8 328.0

The Reduce function turns a binary function into one that accepts multiple inputs. For
example, the + operator calculates the sum of two numbers, but the sum function cal‐
culates the sum of multiple inputs. sum(a, b, c, d, e) is (roughly) equivalent to
Reduce("+", list(a, b, c, d, e)).
We can define a simple binary function that calculates the (parallel) maximum of two
inputs:
pmax2 <- function(x,  y) ifelse(x >= y,  x,  y)
If we reduce this function, then it will accept a list of many inputs (like the pmax function
in base R does):
Reduce(pmax2,  measurements_by_deer)
## ct bead lwh.4 finarelli
## 418.0 405.0 463.8 419.0
One proviso is that Reduce repeatedly calls the binary function on pairs of inputs, so:
Reduce("+" ,  list(a,  b,  c,  d,  e))
is the same as:
((((a + b) + c) + d) + e)
This means that you can’t use it for something like calculating the mean, since:
mean(mean(mean(mean(a,  b),  c),  d),  e) != mean(a,  b,  c,  d,  e)

table(cut(obama,  seq.int(0, 100, 10)))
##
## (0,10] (10,20] (20,30] (30,40] (40,50] (50,60] (60,70] (70,80]
## 0 0 0 8 16 16 9 1
## (80,90] (90,100]
## 0 1
#######################################################

There are several functions for getting the extremes of numeric data. min and max are
the most obvious, giving the smallest and largest values of all their inputs, respectively.
pmin and pmax (the “parallel” equivalents) calculate the smallest and largest values at
each point across several vectors of the same length. Meanwhile, the range function
gives the minimum and maximum in a single function call:
min(obama)
## [1] 32.54
with(obama_vs_mccain,  pmin(Obama,  McCain))
## [1] 38.74 37.89 44.91 38.86 36.91 44.71 38.22 6.53 36.93 48.10 46.90
## [12] 26.58 35.91 36.74 48.82 44.39 41.55 41.15 39.93 40.38 36.47 35.99
## [23] 40.89 43.82 43.00 49.23 47.11 41.60 42.65 44.52 41.61 41.78 36.03
## [34] 49.38 44.50 46.80 34.35 40.40 44.15 35.06 44.90 44.75 41.79 43.63
## [45] 34.22 30.45 46.33 40.26 42.51 42.31 32.54
range(obama)
## [1] 32.54 92.46

cummin and cummax provide the smallest and largest values so far in a vector. Similarly,
cumsum and cumprod provide sums and products of the values to date. These functions
make most sense when the input has been ordered in a useful way:
cummin(obama)
## [1] 38.74 37.89 37.89 37.89 37.89 37.89 37.89 37.89 37.89 37.89 37.89
## [12] 37.89 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91
## [23] 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91 35.91
## [34] 35.91 35.91 35.91 34.35 34.35 34.35 34.35 34.35 34.35 34.35 34.35
## [45] 34.22 34.22 34.22 34.22 34.22 34.22 32.54
cumsum(obama)
## [1] 38.74 76.63 121.54 160.40 221.34 275.00 335.59 428.05
## [9] 489.96 540.87 587.77 659.62 695.53 757.38 807.23 861.16
## [17] 902.71 943.86 983.79 1041.50 1103.42 1165.22 1222.55 1276.61
## [25] 1319.61 1368.84 1415.95 1457.55 1512.70 1566.83 1623.97 1680.88
## [33] 1743.76 1793.46 1837.96 1889.34 1923.69 1980.44 2034.91 2097.77
## [41] 2142.67 2187.42 2229.21 2272.84 2307.06 2374.52 2427.15 2484.49
## [49] 2527.00 2583.22 2615.76
cumprod(obama)
## [1] 3.874e+01 1.468e+03 6.592e+04 2.562e+06 1.561e+08 8.377e+09 5.076e+11
## [8] 4.693e+13 2.905e+15 1.479e+17 6.937e+18 4.984e+20 1.790e+22 1.107e+24
## [15] 5.519e+25 2.976e+27 1.237e+29 5.089e+30 2.032e+32 1.173e+34 7.261e+35
## [22] 4.487e+37 2.572e+39 1.391e+41 5.980e+42 2.944e+44 1.387e+46 5.769e+47
## [29] 3.182e+49 1.722e+51 9.841e+52 5.601e+54 3.522e+56 1.750e+58 7.789e+59
## [36] 4.002e+61 1.375e+63 7.801e+64 4.249e+66 2.671e+68 1.199e+70 5.367e+71
## [43] 2.243e+73 9.785e+74 3.349e+76 2.259e+78 1.189e+80 6.817e+81 2.898e+83
## [50] 1.629e+85 5.302e+86
The quantile function provides, as you might expect, quantiles (median, min, and max
are special cases). It defaults to the median, minimum, maximum, and lower and upper
quartiles, and in an impressive feat of overengineering, it gives a choice of nine different
calculation algorithms:
quantile(obama)
## 0% 25% 50% 75% 100%
## 32.54 42.75 51.38 57.34 92.46
quantile(obama,  type = 5) #to reproduce SAS results
## 0% 25% 50% 75% 100%
## 32.54 42.63 51.38 57.34 92.46
quantile(obama,  c(0.9, 0.95, 0.99))
## 90% 95% 99%
## 61.92 65.17 82.16

IQR(obama)
## [1] 14.58
fivenum provides a faster, greatly simplified alternative to quantile. You only get one
algorithm, and only the default quantiles can be calculated. It has a niche use where
speed matters:
fivenum(obama)
## [1] 32.54 42.75 51.38 57.34 92.46
There are some shortcuts for calculating multiple statistics at once. You’ve already met
the summary function, which accepts vectors or data frames:
summary(obama_vs_mccain)
## State Region Obama McCain
## Alabama : 1 IV : 8 Min. :32.5 Min. : 6.53
## Alaska : 1 I : 6 1st Qu.:42.8 1st Qu.:40.39
## Arizona : 1 III : 6 Median :51.4 Median :46.80
## Arkansas : 1 V : 6 Mean :51.3 Mean :47.00
## California: 1 VIII : 6 3rd Qu.:57.3 3rd Qu.:55.88
## Colorado : 1 VI : 5 Max. :92.5 Max. :65.65
## (Other) :45 (Other):14
## Turnout Unemployment Income Population
## Min. :50.8 Min. :3.40 Min. :19534 Min. : 563626
## 1st Qu.:61.0 1st Qu.:5.05 1st Qu.:23501 1st Qu.: 1702662
## Median :64.9 Median :5.90 Median :25203 Median : 4350606
## Mean :64.1 Mean :6.01 Mean :26580 Mean : 6074128
## 3rd Qu.:68.0 3rd Qu.:7.25 3rd Qu.:28978 3rd Qu.: 6656506
## Max. :78.0 Max. :9.40 Max. :40846 Max. :37341989
## NA's :4
## Catholic Protestant Other Non.religious Black
## Min. : 6.0 Min. :26.0 Min. :0.00 Min. : 5 Min. : 0.4
## 1st Qu.:12.0 1st Qu.:46.0 1st Qu.:2.00 1st Qu.:12 1st Qu.: 3.1
## Median :21.0 Median :54.0 Median :3.00 Median :15 Median : 7.4
## Mean :21.7 Mean :53.8 Mean :3.29 Mean :16 Mean :11.1
## 3rd Qu.:29.0 3rd Qu.:62.0 3rd Qu.:4.00 3rd Qu.:19 3rd Qu.:15.2
## Max. :46.0 Max. :80.0 Max. :8.00 Max. :34 Max. :50.7
## NA's :2 NA's :2 NA's :2 NA's :2
## Latino Urbanization
## Min. : 1.2 Min. : 1
## 1st Qu.: 4.3 1st Qu.: 46
## Median : 8.2 Median : 101
## Mean :10.3 Mean : 386
## 3rd Qu.:12.1 3rd Qu.: 221
## Max. :46.3 Max. :9856
##

The cancor function (short for “canonical
correlation”) provides extra details, and the cov function calculates covariances:
with(obama_vs_mccain,  cor(Obama,  McCain))
## [1] -0.9981
with(obama_vs_mccain,  cancor(Obama,  McCain))
## $cor
## [1] 0.9981
##
## $xcoef
## [,1]
## [1,] 0.01275
##
## $ycoef
## [,1]
## [1,] -0.01287
##
## $xcenter
## [1] 51.29
##
## $ycenter
## [1] 47
with(obama_vs_mccain,  cov(Obama,  McCain))
## [1] -121.7


#######################################################
Random Numbers
Random numbers are critical to many analyses, and consequently R has a wide variety
of functions for sampling from different distributions.
The sample Function
We’ve seen the sample function a few times already (it was first introduced in Chapter
3). It’s an important workhorse function for generating random values, and its behavior
has a few quirks, so it’s worth getting to know it more thoroughly. If you just pass it a
number, n, it will return a permutation of the natural numbers from 1 to n:
sample(7)
## [1] 1 2 5 7 4 6 3
If you give it a second value, it will return that many random numbers between 1 and n:
sample(7, 5)
## [1] 7 2 3 1 5
Notice that all those random numbers are different. By default, sample samples without
replacement. That is, each value can only appear once. To allow sampling with replace‐
ment, pass replace = TRUE:
sample(7, 10,  replace = TRUE)
## [1] 4 6 1 7 5 3 6 7 4 2
Of course, returning natural numbers isn’t that interesting most of the time, but sample
is flexible enough to let us sample from any vector that we like. Most commonly, we
might want to pass it a character vector:
sample(colors(), 5) #a great way to pick the color scheme for your house
## [1] "grey53" "deepskyblue2" "gray94" "maroon2"
## [5] "gray18"
If we were feeling more adventurous, we could pass it some dates:
sample(. leap.seconds, 4)
## [1] "2012-07-01 01:00:00 BST" "1994-07-01 01:00:00 BST"
## [3] "1981-07-01 01:00:00 BST" "1990-01-01 00:00:00 GMT"

We can also weight the probability of each input value being returned by passing a prob
argument. In the next example, we use R to randomly decide which month to go on
holiday, then fudge it to increase our chances of a summer break:
weights <-  c(1, 1, 2, 3, 5, 8, 13, 21, 8, 3, 1, 1)
sample(month.abb, 1,  prob = weights)
## [1] "Jul"
Sampling from Distributions
Oftentimes, we want to generate random numbers from a probability distribution. R
has functions available for sampling from almost one hundred distributions, mixtures,
and copulas across the various packages. The ?Distribution help page documents the
facilities available in base R, and the CRAN Task View on distributions gives extensive
directions about which package to look in if you want something more esoteric.
Most of the random number generation functions have the name r<distn>. For exam‐
ple, we’ve already seen runif, which generates uniform random numbers, and rnorm,
which generates normally distributed random numbers. The first parameter for each
of these functions is the number of random numbers to generate, and further parameters
affect the shape of the distribution. For example, runif allows you to set the lower and
upper bounds of the distribution:
runif(5) #5 uniform random numbers between 0 and 1
runif(5, 1, 10) #5 uniform random numbers between 1 and 10
rnorm(5) #5 normal random numbers with mean 0 and std dev 1
rnorm(5, 3, 7) #5 normal random numbers with mean 3 and std dev 7
Random numbers generated by R are, like with any other software, actually
pseudorandom. That is, they are generated by an algorithm rather than a genuinely
random process. R supports several algorithms out of the box, as described on the ?
RNG page, and more specialist algorithms (for parallel number generation, for example)
in other packages. The CRAN Task View on distributions mentioned above also de‐
scribes where to find more algorithms. You can see which algorithms are used for uni‐
form and normal random number generation with the RNGkind function (sampling
from other distributions typically uses some function of uniform or normal random
numbers):
RNGkind()
## [1] "Mersenne-Twister" "Inversion"
Random number generators require a starting point to generate numbers from, known
as a “seed.” By setting the seed to a particular value, you can guarantee that the same
random numbers will be generated each time you run the same piece of code. For ex‐
ample, this book fixes the seed so that the examples are the same each time the book is
built. You can set the seed with the set.seed function. It takes a positive integer as an
input. Which integer you choose doesn’t matter; different seeds just give different ran‐
dom numbers:
set.seed(1)
runif(5)
## [1] 0.2655 0.3721 0.5729 0.9082 0.2017
set.seed(1)
runif(5)
## [1] 0.2655 0.3721 0.5729 0.9082 0.2017
set.seed(1)
runif(5)
## [1] 0.2655 0.3721 0.5729 0.9082 0.2017
You can also specify different generation algorithms, though this is very advanced usage,
so don’t do that unless you know what you are doing.
Distributions
As well as a function for generating random numbers, most distributions also have
functions for calculating their probability density function (PDF), cumulative density
function (CDF), and inverse CDF.
Like the RNG functions with names beginning with r, these functions have names
beginning with d, p, and q, respectively. For example, the normal distribution has func‐
tions dnorm, pnorm, and qnorm. These functions are perhaps best demonstrated visually,
and are shown in Figure 15-1. (The code is omitted, on account of being rather fiddly.)
Figure 15-1. PDF, CDF, and inverse CDF of a normal distribution
Formulae
We’ve already seen the use of formulae in lattice plots and ggplot2 facets. Many
statistical models use formulae in a similar way, in order to specify the structure of the
variables in the model. The exact meaning of the formula depends upon the model
function that it gets passed to (in the same way that a formula in a lattice plot means
something different to a formula in a ggplot2 facet), but there is a common pattern that
most models satisfy: the lefthand side specifies the response variable, the righthand side
specifies independent variables, and the two are separated by a tilde. Returning to the
gonorrhoea dataset as an example, we have:
Rate ~ Year + Age.Group + Ethnicity + Gender
Here, Rate is the response, and we have chosen to include four independent variables
(year/age group/ethnicity/gender). For models that can include an intercept (that’s more
or less all regression models), a formula like this will implicitly include that intercept.
If we passed it into a linear regression model, it would mean:
Rate = α
0 + α1 * Year + α2 * Age.Group + α3 * Ethnicity + α4 * Gender + ϵ
where each α
i is a constant to be determined by the model, andϵ is a normally distributed
error term.
If we didn’t want the intercept term, we could add a zero to the righthand side to suppress
it:
Rate ~ 0 + Year + Age.Group + Ethnicity + Gender
The updated equation given by this formula is:
Rate = α
1 * Year + α2 * Age.Group + α3 * Ethnicity + α4 * Gender + ϵ
Each of these formulae includes only the individual independent variables, without any
interactions between them. To include interactions, we can replace the plusses with
asterisks:
Rate ~ Year * Age.Group * Ethnicity * Gender
This adds in all possible two-way interactions (year and age group, year and ethnicity,
etc.), and three-way interactions (year and age group and ethnicity, etc.), all the way up
to an every-way interaction between all independent variables (year and age group and
ethnicity and gender). This is very often overkill, since a every-way interaction is usually
meaningless.
There are two ways of restricting the level of interaction. First, you can add individual
interactions using colons. In the following example, Year:Ethnicity is a two-way in‐
teraction between those terms, and Year:Ethnicity:Gender is a three-way interaction:
Rate ~ Year + Ethnicity + Gender + Year:Ethnicity + Year:Ethnicity:Gender
This fine-grained approach can become cumbersome to type if you have more than
three or four variables, though, so an alternate syntax lets you include all interactions
up to a certain level using carets (^). The next example includes the year, ethnicity, and
gender, and the three two-way interactions:
Rate ~ (Year + Ethnicity + Gender) ^ 2
You can also include modified versions of variables. For example, a surprising number
of environmental processes generate lognormally distributed variables, which you may
want to include in a linear regression as log(var). Terms like this can be included
directly, but you may have spotted a problem with including var ^ 2. That syntax is
reserved for interactions, so if you want to include powers of things, wrap them in I():
Rate ~ I(Year ^ 2) #year squared, not an interaction
A First Model: Linear Regressions
Ordinary least squares linear regressions are the simplest in an extensive family of re‐
gression models. The function for calculating them is concisely if not clearly named:
lm, short for “linear model.” It accepts a formula of the type we’ve just discussed, and a
data frame that contains the variables to model. Let’s take a look at the gonorrhoea
dataset. For simplicity, we’ll ignore interactions:
model1 <-  lm(Rate ~ Year + Age.Group + Ethnicity + Gender,  gonorrhoea)
If we print the model variable, it lists the coefficients for each input variable (the αi
values). If you look closely, you’ll notice that for both of the categorical variables that
we put into the model (age group and ethnicity), one category has no coefficient. For
example, the 0 to 4 age group is missing, and the American Indians & Alaskan
Natives ethnicity is also missing.
These “missing” categories are included in the intercept. In the following output, the
intercept value of 5,540 people infected with gonorrhoea per 100,000 people applies to
0- to 4-year-old female American Indians and Alaskan Natives in the year 0. To predict
infection rates in the years up to 2013, we would add 2013 times the coefficient for Year,
-2.77. To predict the effect on 25- to 29-year-olds of the same ethnicity, we would add
the coefficient for that age group, 291:
model1
##
## Call:
## lm(formula = Rate ~ Year + Age.Group + Ethnicity + Gender, data = gonorrhoea)
##
## Coefficients:
## (Intercept) Year
## 5540.496 -2.770
## Age.Group5 to 9 Age.Group10 to 14
## -0.614 15.268
## Age.Group15 to 19 Age.Group20 to 24
## 415.698 546.820
## Age.Group25 to 29 Age.Group30 to 34
## 291.098 155.872
## Age.Group35 to 39 Age.Group40 to 44
## 84.612 49.506
## Age.Group45 to 54 Age.Group55 to 64
## 27.364 8.684
## Age.Group65 or more EthnicityAsians & Pacific Islanders
## 1.178 -82.923
## EthnicityHispanics EthnicityNon-Hispanic Blacks
## -49.000 376.204
## EthnicityNon-Hispanic Whites GenderMale
## -68.263 -17.892
The “0- to 4-year-old female American Indians and Alaskan Natives” group was chosen
because it consists of the first level of each of the factor variables. We can see those factor
levels by looping over the dataset and calling levels:
lapply(Filter(is.factor,  gonorrhoea),  levels)
## $Age.Group
## [1] "0 to 4" "5 to 9" "10 to 14" "15 to 19" "20 to 24"
## [6] "25 to 29" "30 to 34" "35 to 39" "40 to 44" "45 to 54"
## [11] "55 to 64" "65 or more"
##
## $Ethnicity
## [1] "American Indians & Alaskan Natives"
## [2] "Asians & Pacific Islanders"
## [3] "Hispanics"
## [4] "Non-Hispanic Blacks"
## [5] "Non-Hispanic Whites"
##
## $Gender
## [1] "Female" "Male"
As well as knowing the size of the effect of each input variable, we usually want to know
which variables were significant. The summary function is overloaded to work with lm
to do just that. The most exciting bit of the output from summary is the coefficients table.
The Estimate column shows the coefficients that we’ve seen already, and the fourth
column, Pr(>|t|), shows the p-values. The fifth column gives a star rating: where the

p-value is less than 0.05 a variable gets one star, less than 0.01 is two stars, and so on.
This makes it easy to quickly see which variables had a significant effect:
summary(model1)
##
## Call:
## lm(formula = Rate ~ Year + Age.Group + Ethnicity + Gender, data = gonorrhoea)
##
## Residuals:
## Min 1Q Median 3Q Max
## -376.7 -130.6 37.1 90.7 1467.1
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 5540.496 14866.406 0.37 0.7095
## Year -2.770 7.400 -0.37 0.7083
## Age.Group5 to 9 -0.614 51.268 -0.01 0.9904
## Age.Group10 to 14 15.268 51.268 0.30 0.7660
## Age.Group15 to 19 415.698 51.268 8.11 3.0e-15
## Age.Group20 to 24 546.820 51.268 10.67 < 2e-16
## Age.Group25 to 29 291.098 51.268 5.68 2.2e-08
## Age.Group30 to 34 155.872 51.268 3.04 0.0025
## Age.Group35 to 39 84.612 51.268 1.65 0.0994
## Age.Group40 to 44 49.506 51.268 0.97 0.3346
## Age.Group45 to 54 27.364 51.268 0.53 0.5937
## Age.Group55 to 64 8.684 51.268 0.17 0.8656
## Age.Group65 or more 1.178 51.268 0.02 0.9817
## EthnicityAsians & Pacific Islanders -82.923 33.093 -2.51 0.0125
## EthnicityHispanics -49.000 33.093 -1.48 0.1392
## EthnicityNon-Hispanic Blacks 376.204 33.093 11.37 < 2e-16
## EthnicityNon-Hispanic Whites -68.263 33.093 -2.06 0.0396
## GenderMale -17.892 20.930 -0.85 0.3930
##
## (Intercept)
## Year
## Age.Group5 to 9
## Age.Group10 to 14
## Age.Group15 to 19 ***
## Age.Group20 to 24 ***
## Age.Group25 to 29 ***
## Age.Group30 to 34 **
## Age.Group35 to 39 .
## Age.Group40 to 44
## Age.Group45 to 54
## Age.Group55 to 64
## Age.Group65 or more
## EthnicityAsians & Pacific Islanders *
## EthnicityHispanics
## EthnicityNon-Hispanic Blacks ***
## EthnicityNon-Hispanic Whites *
## GenderMale
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 256 on 582 degrees of freedom
## Multiple R-squared: 0.491, Adjusted R-squared: 0.476
## F-statistic: 33.1 on 17 and 582 DF, p-value: <2e-16
Comparing and Updating Models
Rather than just accepting the first model that we think of, we often want to find a “best”
model, or a small set of models that provide some insight.
This section demonstrates some metrics for measuring the quality of a model, such as
p-values and log-likelihood measures. By using these metrics to compare models, you
can automatically keep updating your model until you get to a “best” one.
Unfortunately, automatic updating of models like this (“stepwise regression”) is a poor
method for choosing a model, and it gets worse as you increase the number of input
variables.
Better methods for model selection, like model training or model averaging, are beyond
the scope of this book. The CrossValidated statistics Q&A site has a good list of possi‐
bilities.
It is often a mistake to try to find a single “best” model. A good mod‐
el is one that gives you insight into your problem—there may be sev‐
eral that do this.
In order to sensibly choose a model for our dataset, we need to understand a little about
the things that affect gonorrhoea infection rates. Gonorrhoea is primarily sexually
transmitted (with some transmission from mothers to babies during childbirth), so the
big drivers are related to sexual culture: how much unprotected sex people have, and
with how many partners.
The p-value for Year is 0.71, meaning not even close to significant. Over such a short
time series (five years of data), I’d be surprised if there were any changes in sexual culture
big enough to have an important effect on infection rates, so let’s see what happens when
we remove it.
Rather than having to completely respecify the model, we can update it using the update
function. This accepts a model and a formula. We are just updating the righthand side
of the formula, so the lefthand side stays blank. In the next example, .  means “the terms
that were already in the formula,” and – (minus) means “remove this next term”:
model2 <-  update(model1,  ~ . -  Year)
summary(model2)

##
## Call:
## lm(formula = Rate ~ Age.Group + Ethnicity + Gender, data = gonorrhoea)
##
## Residuals:
## Min 1Q Median 3Q Max
## -377.6 -128.4 34.6 92.2 1472.6
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) -25.103 43.116 -0.58 0.5606
## Age.Group5 to 9 -0.614 51.230 -0.01 0.9904
## Age.Group10 to 14 15.268 51.230 0.30 0.7658
## Age.Group15 to 19 415.698 51.230 8.11 2.9e-15
## Age.Group20 to 24 546.820 51.230 10.67 < 2e-16
## Age.Group25 to 29 291.098 51.230 5.68 2.1e-08
## Age.Group30 to 34 155.872 51.230 3.04 0.0025
## Age.Group35 to 39 84.612 51.230 1.65 0.0992
## Age.Group40 to 44 49.506 51.230 0.97 0.3343
## Age.Group45 to 54 27.364 51.230 0.53 0.5934
## Age.Group55 to 64 8.684 51.230 0.17 0.8655
## Age.Group65 or more 1.178 51.230 0.02 0.9817
## EthnicityAsians & Pacific Islanders -82.923 33.069 -2.51 0.0124
## EthnicityHispanics -49.000 33.069 -1.48 0.1389
## EthnicityNon-Hispanic Blacks 376.204 33.069 11.38 < 2e-16
## EthnicityNon-Hispanic Whites -68.263 33.069 -2.06 0.0394
## GenderMale -17.892 20.915 -0.86 0.3926
##
## (Intercept)
## Age.Group5 to 9
## Age.Group10 to 14
## Age.Group15 to 19 ***
## Age.Group20 to 24 ***
## Age.Group25 to 29 ***
## Age.Group30 to 34 **
## Age.Group35 to 39 .
## Age.Group40 to 44
## Age.Group45 to 54
## Age.Group55 to 64
## Age.Group65 or more
## EthnicityAsians & Pacific Islanders *
## EthnicityHispanics
## EthnicityNon-Hispanic Blacks ***
## EthnicityNon-Hispanic Whites *
## GenderMale
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 256 on 583 degrees of freedom
## Multiple R-squared: 0.491, Adjusted R-squared: 0.477
## F-statistic: 35.2 on 16 and 583 DF, p-value: <2e-16

The anova function computes ANalysis Of VAriance tables for models, letting you see
if your simplified model is significantly different from the fuller model:
anova(model1,  model2)
## Analysis of Variance Table
##
## Model 1: Rate ~ Year + Age.Group + Ethnicity + Gender
## Model 2: Rate ~ Age.Group + Ethnicity + Gender
## Res.Df RSS Df Sum of Sq F Pr(>F)
## 1 582 38243062
## 2 583 38252272 -1 -9210 0.14 0.71
The p-value in the righthand column is 0.71, so removing the year term didn’t signif‐
icantly affect the model’s fit to the data.
The Akaike and Bayesian information criteria provide alternate methods of comparing
models, via the AIC and BIC functions. They use log-likelihood values, which tell you
how well the models fit the data, and penalize them depending upon how many terms
there are in the model (so simpler models are better than complex models). Smaller
numbers roughly correspond to “better” models:
AIC(model1,  model2)
## df AIC
## model1 19 8378
## model2 18 8376
BIC(model1,  model2)
## df BIC
## model1 19 8462
## model2 18 8456
You can see the effects of these functions better if we create a silly model. Let’s remove
age group, which appears to be a powerful predictor of gonorrhoea infection rates (as
it should be, since children and the elderly have much less sex than young adults):
silly_model <-  update(model1,  ~ . -  Age.Group)
anova(model1,  silly_model)
## Analysis of Variance Table
##
## Model 1: Rate ~ Year + Age.Group + Ethnicity + Gender
## Model 2: Rate ~ Year + Ethnicity + Gender
## Res.Df RSS Df Sum of Sq F Pr(>F)
## 1 582 38243062
## 2 593 57212506 -11 -1.9e+07 26.2 <2e-16 ***
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

AIC(model1,  silly_model)
## df AIC
## model1 19 8378
## silly_model 8 8598
BIC(model1,  silly_model)
## df BIC
## model1 19 8462
## silly_model 8 8633
In the silly model, anova notes a significant difference between the models, and both
the AIC and the BIC have gone up by a lot.
Returning to our quest for a non-silly model, notice that gender is nonsignificant (p =
0.39). If you did Exercise 14-3 (you did, right?), then this might be interesting to you
because it looked like infection rates were higher in women from a plot. Hold that
thought until the exercises at the end of this chapter. For now, let’s trust the p-value and
remove the gender term from the model:
model3 <-  update(model2,  ~ . -  Gender)
summary(model3)
##
## Call:
## lm(formula = Rate ~ Age.Group + Ethnicity, data = gonorrhoea)
##
## Residuals:
## Min 1Q Median 3Q Max
## -380.1 -136.1 35.8 87.4 1481.5
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) -34.050 41.820 -0.81 0.4159
## Age.Group5 to 9 -0.614 51.218 -0.01 0.9904
## Age.Group10 to 14 15.268 51.218 0.30 0.7657
## Age.Group15 to 19 415.698 51.218 8.12 2.9e-15
## Age.Group20 to 24 546.820 51.218 10.68 < 2e-16
## Age.Group25 to 29 291.098 51.218 5.68 2.1e-08
## Age.Group30 to 34 155.872 51.218 3.04 0.0024
## Age.Group35 to 39 84.612 51.218 1.65 0.0991
## Age.Group40 to 44 49.506 51.218 0.97 0.3342
## Age.Group45 to 54 27.364 51.218 0.53 0.5934
## Age.Group55 to 64 8.684 51.218 0.17 0.8654
## Age.Group65 or more 1.178 51.218 0.02 0.9817
## EthnicityAsians & Pacific Islanders -82.923 33.061 -2.51 0.0124
## EthnicityHispanics -49.000 33.061 -1.48 0.1389
## EthnicityNon-Hispanic Blacks 376.204 33.061 11.38 < 2e-16
## EthnicityNon-Hispanic Whites -68.263 33.061 -2.06 0.0394
##
## (Intercept)
## Age.Group5 to 9

2. Please remind me to change this for the second edition!
## Age.Group10 to 14
## Age.Group15 to 19 ***
## Age.Group20 to 24 ***
## Age.Group25 to 29 ***
## Age.Group30 to 34 **
## Age.Group35 to 39 .
## Age.Group40 to 44
## Age.Group45 to 54
## Age.Group55 to 64
## Age.Group65 or more
## EthnicityAsians & Pacific Islanders *
## EthnicityHispanics
## EthnicityNon-Hispanic Blacks ***
## EthnicityNon-Hispanic Whites *
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 256 on 584 degrees of freedom
## Multiple R-squared: 0.491, Adjusted R-squared: 0.477
## F-statistic: 37.5 on 15 and 584 DF, p-value: <2e-16
Finally, the intercept term looks to be nonsignificant. This is because the default group
is 0- to 4-year-old American Indians and Alaskan Natives, and they don’t have much
gonorrhoea.
We can set a different default with the relevel function. As a non-Hispanic white
person in the 30- to 34-year-old group,2 I’m going to arbitrarily set those as the defaults.
In this next example, notice that we can use the update function to update the data
frame as well as the formula:
g2 <-  within(
gonorrhoea,
{
Age.Group <-  relevel(Age.Group, "30 to 34" )
Ethnicity <-  relevel(Ethnicity, "Non-Hispanic Whites" )
}
)
model4 <-  update(model3,  data = g2)
summary(model4)
##
## Call:
## lm(formula = Rate ~ Age.Group + Ethnicity, data = g2)
##
## Residuals:
## Min 1Q Median 3Q Max
## -380.1 -136.1 35.8 87.4 1481.5
##
## Coefficients:

## Estimate Std. Error t value
## (Intercept) 53.6 41.8 1.28
## Age.Group0 to 4 -155.9 51.2 -3.04
## Age.Group5 to 9 -156.5 51.2 -3.06
## Age.Group10 to 14 -140.6 51.2 -2.75
## Age.Group15 to 19 259.8 51.2 5.07
## Age.Group20 to 24 390.9 51.2 7.63
## Age.Group25 to 29 135.2 51.2 2.64
## Age.Group35 to 39 -71.3 51.2 -1.39
## Age.Group40 to 44 -106.4 51.2 -2.08
## Age.Group45 to 54 -128.5 51.2 -2.51
## Age.Group55 to 64 -147.2 51.2 -2.87
## Age.Group65 or more -154.7 51.2 -3.02
## EthnicityAmerican Indians & Alaskan Natives 68.3 33.1 2.06
## EthnicityAsians & Pacific Islanders -14.7 33.1 -0.44
## EthnicityHispanics 19.3 33.1 0.58
## EthnicityNon-Hispanic Blacks 444.5 33.1 13.44
## Pr(>|t|)
## (Intercept) 0.2008
## Age.Group0 to 4 0.0024 **
## Age.Group5 to 9 0.0024 **
## Age.Group10 to 14 0.0062 **
## Age.Group15 to 19 5.3e-07 ***
## Age.Group20 to 24 9.4e-14 ***
## Age.Group25 to 29 0.0085 **
## Age.Group35 to 39 0.1647
## Age.Group40 to 44 0.0383 *
## Age.Group45 to 54 0.0124 *
## Age.Group55 to 64 0.0042 **
## Age.Group65 or more 0.0026 **
## EthnicityAmerican Indians & Alaskan Natives 0.0394 *
## EthnicityAsians & Pacific Islanders 0.6576
## EthnicityHispanics 0.5603
## EthnicityNon-Hispanic Blacks < 2e-16 ***
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 256 on 584 degrees of freedom
## Multiple R-squared: 0.491, Adjusted R-squared: 0.477
## F-statistic: 37.5 on 15 and 584 DF, p-value: <2e-16
The coefficients and p-values have changed because the reference point is now different,
but there are still a lot of stars on the righthand side of the summary output, so we know
that age and ethnicity have an impact on infection rates.
Plotting and Inspecting Models
lm models have a plot method that lets you check the goodness of fit in six different
ways. In its simplest form, you can just call plot(the_model), and it draws several plots
one after another. A slightly better approach is to use the layout function to see all the
plots together, as demonstrated in Figure 15-2:

plot_numbers <- 1: 6
layout(matrix(plot_numbers,  ncol = 2,  byrow = TRUE))
plot(model4,  plot_numbers)
Figure 15-2. Diagnostic plots for a linear model
At the top end, there are some values that are too high (notice the large positive residuals
at the righthand side of the “Residuals vs Fitted” plot, the points far above the line in
the “Normal Q-Q” plot, and the spikes in the “Cook’s distance” plot). In particular, rows
40, 41, and 160 have been singled out as outliers:
gonorrhoea[c(40, 41, 160), ]
## Year Age.Group Ethnicity Gender Rate
## 40 2007 15 to 19 Non-Hispanic Blacks Female 2239
## 41 2007 20 to 24 Non-Hispanic Blacks Female 2200
## 160 2008 15 to 19 Non-Hispanic Blacks Female 2233

These large values all refer to non-Hispanic black females, suggesting that we are per‐
haps missing an interaction term with ethnicity and gender.
The model variable that is returned by lm is a fairly complex beast. The output isn’t
included here for brevity, but you can explore the structure of these model variables in
the usual way:
str(model4)
unclass(model4)
There are many convenience functions for accessing the various components of the
model, such as formula, nobs, residuals, fitted, and coefficients:
formula(model4)
## Rate ~ Age.Group + Ethnicity
## <environment: 0x000000004ed4e110>
nobs(model4)
## [1] 600
head(residuals(model4))
## 1 2 3 4 5 6
## 102.61 102.93 87.25 -282.38 -367.61 -125.38
head(fitted(model4))
## 1 2 3 4 5 6
## -102.31 -102.93 -87.05 313.38 444.51 188.78
head(coefficients(model4))
## (Intercept) Age.Group0 to 4 Age.Group5 to 9 Age.Group10 to 14
## 53.56 -155.87 -156.49 -140.60
## Age.Group15 to 19 Age.Group20 to 24
## 259.83 390.95
Beyond these, there are more functions for diagnosing the quality of linear regression
models (listed on the ?influence.measures page), and you can access the R^2 value
(“the fraction of variance explained by the model”) from the summary:
head(cooks.distance(model4))
## 1 2 3 4 5 6
## 0.0002824 0.0002842 0.0002042 0.0021390 0.0036250 0.0004217
summary(model4)$r.squared
## [1] 0.4906
These utility functions are great for providing alternative diagnostics. For example, if
you don’t want a base graphics plot of a model, you could roll your own ggplot2 version.
Figure 15-3 shows an example plot of residuals versus fitted values:

diagnostics <-  data.frame(
residuals = residuals(model4),
fitted = fitted(model4)
)
ggplot(diagnostics,  aes(fitted,  residuals)) +
geom_point() +
geom_smooth(method = "loess" )
Figure 15-3. A ggplot2-based diagnostic plot of residuals vs. fitted values
The real beauty of using models is that you can predict outcomes based on whatever
model inputs interest you. It’s more fun when you have a time variable in the model so
that you can predict the future, but in this case we can take a look at infection rates for
specific demographics. In a completely self-interested fashion, I’m going to look at the
infection rates for 30- to 34-year-old non-Hispanic white people:

new_data <-  data.frame(
Age.Group = "30 to 34" ,
Ethnicity = "Non-Hispanic Whites"
)
predict(model4,  new_data)
## 1
## 53.56
The model predicts an infection rate of 54 people per 100,000. Let’s compare it to the
data for that group:
subset(
gonorrhoea,
Age.Group == "30 to 34" & Ethnicity == "Non-Hispanic Whites"
)
## Year Age.Group Ethnicity Gender Rate
## 7 2007 30 to 34 Non-Hispanic Whites Male 41.0
## 19 2007 30 to 34 Non-Hispanic Whites Female 45.6
## 127 2008 30 to 34 Non-Hispanic Whites Male 35.1
## 139 2008 30 to 34 Non-Hispanic Whites Female 40.8
## 247 2009 30 to 34 Non-Hispanic Whites Male 34.6
## 259 2009 30 to 34 Non-Hispanic Whites Female 33.8
## 367 2010 30 to 34 Non-Hispanic Whites Male 40.8
## 379 2010 30 to 34 Non-Hispanic Whites Female 38.5
## 487 2011 30 to 34 Non-Hispanic Whites Male 48.0
## 499 2011 30 to 34 Non-Hispanic Whites Female 40.7
The data points range from 34 to 48, so the prediction is a little bit high.
Other Model Types
Linear regression is barely a hairline scratch on the surface of R’s modeling capabilities.
As R is now the tool of choice in many university statistical departments, more or less
every model conceived is available in R or one of its packages. There are many books
that focus on the statistical side of using R, so this section only provides brief pointers
on where to look for further information.
The modeling capabilities of R are spread across many packages writ‐
ten by many people, and consequently their syntax varies. The caret
package provides wrappers to about 150 models to give them a con‐
sistent interface, along with some tools for model training and valida‐
tion. Max Kuhn’s Applied Predictive Modeling is the definitive refer‐
ence to this package.
The lm function for linear (ordinary least squares regression) models has a generaliza‐
tion, glm, that lets you specify different distributions for error terms and transformations

3. Mixed-effects models are regressions where some of your predictor variables affect the variance of the re‐
sponse rather than the mean. For example, if you measure oxygen levels in people’s bloodstreams, you might
want to know how much variation there is between people and between measurements for a person, but you
don’t care that oxygen levels are higher or lower for a specific person.
on the response variable. You can use it for logistic regression (where the response
variable is logical or categorical), amongst other things, and the syntax is almost identical
to that of lm:
glm(true_or_false ~ some + predictor + variables,  data,  family = binomial())
John Fox’s An R Companion to Applied Regression is basically 472 pages of cool things
you can do with the glm function.
The nlme package (which ships with R) contains the lme function for linear mixed
effects models and nlme for nonlinear mixed-effects models.3 Again, the syntax is more
or less the same as with lm:
lme(y ~ some + fixed + effects,  data,  random = ~ 1 |  random / effects)
Mixed-Effects Models in S and S-PLUS by José Pinheiro and Doug Bates is the canonical
reference, with loads of examples.
For response variables that are proportions, the betareg package contains a function
of the same name that allows beta regression. This is especially important for Exercise
15-3.
For data miners (and others with high-dimensional datasets), the rpart package, which
also ships with R, creates regression trees (a.k.a. decision trees). Even more excitingly,
the randomForest package lets you create a whole forest of regression trees. C50 and
mboost provide gradient boosting, which many regard as even better than random
forests.
kmeans lets you do k-means clustering, and there are several packages that provide
specialist extensions, such as kernlab for weighted k-means, kml for longitudinal k
means, trimclust for trimmed k-means, and skmeans for spherical k-means.
If you do a lot of data mining, you may be interested in Rattle, a GUI that gives easy
access to R’s data-mining models. Graham Williams has written a book about it, Data
Mining with Rattle and R, but start by visiting the website to see if it takes your fancy.
Social scientists may appreciate traditional dimension-reduction models: factor analysis
is supported through the factanal method, and principal components analysis has two
methods (princomp provides S-Plus compatibility, and prcomp uses a more modern,
numerically stable algorithm).
The deSolve package contains many methods for solving systems of ordinary/partial/
delay differential equations.

Summary
• You can generate random numbers from pretty much any distribution ever
conceived.
• Most distributions also have functions available for calculating their PDF/CDF/
inverse CDF.
• Many modeling functions use formulae to specify the form of the model.
• lm runs a linear regression, and there are many support functions for updating,
diagnosing, and predicting with these models.
• R can run a wide range of statistical models.

sample(7, 10,  replace = TRUE)
sample(7, 10)

runif(5) #5 uniform random numbers between 0 and 1
runif(5, 1, 10) #5 uniform random numbers between 1 and 10
rnorm(5) #5 normal random numbers with mean 0 and std dev 1
rnorm(5, 3, 7) #5 normal random numbers with mean 3 and std dev 7


#######################################################
Messages, Warnings, and Errors
We’ve seen the print function on many occasions for displaying variables to the console.
For displaying diagnostic information about the state of the program, R has three func‐
tions. In increasing order of severity, they are message, warning, and stop.
message concatenates its inputs without spaces and writes them to the console. Some
common uses are providing status updates for long-running functions, notifying users
of new behavior when you’ve changed a function, and providing information on default
arguments:
f <- function(x)
{
message("'x' contains " ,  toString(x))
x
}f
(letters[1: 5])
## 'x' contains a, b, c, d, e
## [1] "a" "b" "c" "d" "e"
The main advantage of using message over print (or the lower-level cat) is that the
user can turn off their display. It may seem trivial, but when you are repeatedly running
the same code, not seeing the same message 100 times can have a wonderful effect on
morale:
suppressMessages(f(letters[1: 5]))
## [1] "a" "b" "c" "d" "e"
Warnings behave very similarly to messages, but have a few extra features to reflect their
status as indicators of bad news. Warnings should be used when something has gone
wrong, but not so wrong that your code should just give up. Common use cases are bad
user inputs, poor numerical accuracy, or unexpected side effects:
g <- function(x)
{
if(any(x < 0))
{
warning("'x' contains negative values: " ,  toString(x[x < 0]))
}
x
}g
(c(3, -7, 2, -9))
## Warning: 'x' contains negative values: -7, -9
## [1] 3 -7 2 -9
As with messages, warnings can be suppressed:
suppressWarnings(g(c(3, -7, 2, -9)))
## [1] 3 -7 2 -9
There is a global option, warn, that determines how warnings are handled. By default
warn takes the value 0, which means that warnings are displayed when your code has
finished running.
You can see the current level of the warn option using getOption:
getOption("warn" )
## [1] 1
If you change this value to be less than zero, all warnings are ignored:
old_ops <-  options(warn = -1)
g(c(3, -7, 2, -9))
## [1] 3 -7 2 -9
It is usually dangerous to completely turn off warnings, though, so you should reset the
options to their previous state using:
options(old_ops)
Setting warn to 1 means that warnings are displayed as they occur, and a warn value of
2 or more means that all warnings are turned into errors.
You can access the last warning by typing last.warning.
I mentioned earlier that if the warn option is set to 0, then warnings are shown when
your code finishes running. Actually, it’s a little more complicated than that. If 10 or
fewer warnings were generated, then this is what happens. But if there were more than
10 warnings, you get a message stating how many warnings were generated, and you
have to type warnings() to see them. This is demonstrated in Figure 16-1.
Figure 16-1. Where there are more than 10 warnings, use warnings to see them

Errors are the most serious condition, and throwing them halts further execution. Errors
should be used when a mistake has occurred or you know a mistake will occur. Common
reasons include bad user input that can’t be corrected (by using an as.* function, for
example), the inability to read from or write to a file, or a severe numerical error:
h <- function(x,  na.rm = FALSE)
{
if(!na.rm && any(is.na(x)))
{
stop("'x' has missing values." )
}
x
}h
(c(1, NA))
## Error: 'x' has missing values.
stopifnot throws an error if any of the expressions passed to it evaluate to something
that isn’t true. It provides a simple way of checking that the state of your program is as
expected:
h <- function(x,  na.rm = FALSE)
{
if(!na.rm)
{
stopifnot(!any(is.na(x)))
}
x
}h
(c(1, NA))
## Error: !any(is.na(x)) is not TRUE
For a more extensive set of human-friendly tests, use the assertive package:
library(assertive)
h <- function(x,  na.rm = FALSE)
{
if(!na.rm)
{
assert_all_are_not_na(x)
}
x
}h
(c(1, NA))
## Error: x contains NAs.

Error Handling
Some tasks are inherently risky. Reading from and writing to files or databases is no‐
toriously error prone, since you don’t have complete control over the filesystem, or the
network or database. In fact, any time that R interacts with other software (Java code
via rJava, WinBUGS via R2WinBUGS, or any of the hundreds of other pieces of software
that R can connect to), there is an inherent risk that something will go wrong.
For these dangerous tasks,1 you need to decide what to do when problems occur. Some‐
times it isn’t useful to stop execution when an error is thrown. For example, if you are
looping over files importing them, then if one import fails you don’t want to just stop
executing and lose all the data that you’ve successfully imported already.
In fact, this point generalizes: any time you are doing something risky in a loop, you
don’t want to discard your progress if one of the iterations fails. In this next example,
we try to convert each element of a list into a data frame:
to_convert <-  list(
first = sapply(letters[1: 5],  charToRaw),
second = polyroot(c(1, 0, 0, 0, 1)),
third = list(x = 1: 2,  y = 3: 5)
)
If we run the code nakedly, it fails:
lapply(to_convert,  as.data.frame)
## Error: arguments imply differing number of rows: 2, 3
Oops! The third element fails to convert because of differing element lengths, and we
lose everything.
The simplest way of protecting against total failure is to wrap the failure-prone code
inside a call to the try function:
result <-  try(lapply(to_convert,  as.data.frame))
Now, although the error will be printed to the console (you can suppress this by passing
silent = TRUE), execution of code won’t stop.
If the code passed to a try function executes successfully (without throwing an error),
then result will just be the result of the calculation, as usual. If the code fails, then
result will be an object of class try-error. This means that after you’ve written a line
of code that includes try, the next line should always look something like this:
if(inherits(result, "try-error" ))
{
#special error handling code
} else
{
#code for normal execution
}
## NULL
Since you have to include this extra line every time, code using the try function is a bit
ugly. A prettier alternative2 is to use tryCatch. tryCatch takes an expression to safely
run, just as try does, but also has error handling built into it.
To handle an error, you pass a function to an argument named error. This error
argument accepts an error (technically, an object of class simpleError) and lets you
manipulate, print, or ignore it as you see fit. If this sounds complicated, don’t worry: it’s
easier in practice. In this next example, when an error is thrown, we print the error
message and return an empty data frame:
tryCatch(
lapply(to_convert,  as.data.frame),
error = function(e)
{
message("An error was thrown: " ,  e$message)
data.frame()
}
)
## An error was thrown: arguments imply differing number of rows: 2, 3
## data frame with 0 columns and 0 rows
tryCatch has one more trick: you can pass an expression to an argument named
finally, which runs whether an error was thrown or not (just like the on.exit function
we saw when we were connecting to databases).
Despite having played with try and tryCatch, we still haven’t solved our problem: when
looping over things, if an error is thrown, we want to keep the results of the iterations
that worked.
To achieve this, we need to put try or tryCatch inside the loop:
lapply(
to_convert,
function(x)
{
tryCatch(
as.data.frame(x),
error = function(e) NULL
)
}
)
## $first
## x
## a 61
## b 62
## c 63
## d 64
## e 65
##
## $second
## x
## 1 0.7071+0.7071i
## 2 -0.7071+0.7071i
## 3 -0.7071-0.7071i
## 4 0.7071-0.7071i
##
## $third
## NULL
Since this is a common piece of code, the plyr package contains a function, tryapply,
that deals with exactly this case in a cleaner fashion:
tryapply(to_convert,  as.data.frame)
## $first
## x
## a 61
## b 62
## c 63
## d 64
## e 65
##
## $second
## x
## 1 0.7071+0.7071i
## 2 -0.7071+0.7071i
## 3 -0.7071-0.7071i
## 4 0.7071-0.7071i
Eagle-eyed observers may notice that the failures are simply removed in this case.

3. Space shuttle software was reputed to contain just one bug in 420,000 lines of code, but that level of formal
development methodology, code peer-reviewing, and extensive testing doesn’t come cheap.
Debugging
All nontrivial software contains errors.3 When problems happen, you need to be able
to find where they occur, and hopefully find a way to fix them. This is especially true if
it’s your own code. If the problem occurs in the middle of a simple script, you usually
have access to all the variables, so it is trivial to locate the problem.
More often than not, problems occur somewhere deep inside a function inside another
function inside another function. In this case, you need a strategy to inspect the state
of the program at each level of the call stack. (“Call stack” is just jargon for the list of
functions that have been called to get you to this point in the code.)
When an error is thrown, the traceback function tells you where the last error occurred.
First, let’s define some functions in which the error can occur:
outer_fn <- function(x) inner_fn(x)
inner_fn <- function(x) exp(x)
Now let’s call outer_fn (which then calls inner_fn) with a bad input:
outer_fn(list(1))
## Error: non-numeric argument to mathematical function
traceback now tells us the functions that we called before tragedy struck (see
Figure 16-2).
Figure 16-2. Call stack using traceback
In general, if it isn’t an obvious bug, we don’t know where in the call stack the problem
occurred. One reasonable strategy is to start in the function where the error was thrown,
and work our way up the stack if we need to. To do this, we need a way to stop execution
of the code close to the point where the error was thrown. One way to do this is to add
a call to the browser function just before the error point (we know where the error
occurred because we used traceback):

inner_fn <- function(x)
{
browser() #execution pauses here
exp(x)
}
browser halts execution when it is reached, giving us time to inspect the program. A
really good idea in most cases is to call ls.str to see the values of all the variables that
are in play at the time. In this case we see that x is a list, not a numeric vector, causing
exp to fail.
An alternative strategy for spotting errors is to set the global error option. This strategy
is preferable when the error lies inside someone else’s package, where it is harder to stick
a call to browser. (You can alter functions inside installed packages using the fixInNa
mespace function. The changes persist until you close R.)
The error option accepts a function with no arguments, and is called whenever an error
is thrown. As a simple example, we can set it to print a message after the error has
occurred, as shown in Figure 16-3.
Figure 16-3. Overriding the global error option
While a sympathetic message may provide a sliver of consolation for the error, it isn’t
very helpful in terms of fixing the problem. A much more useful alternative is provided
in the recover function that ships with R. recover lets you step into any function in
the call stack after an error has been thrown (see Figure 16-4).
Figure 16-4. Call stack using error = recover

4. As Tobias Verbeke of Open Analytics once quipped, "debugonce is a very optimistic function. I think de
bugtwice might have been better.”
You can also step through a function line by line using the debug function. This is a bit
boring with trivial single-line functions like inner and outer, so we’ll test it on a more
substantial offering. buggy_count, included in the learningr package, is a buggy ver‐
sion of the count function from the plyr package that fails in an obscure way when you
pass it a factor. Pressing Enter at the command line without typing anything lets us step
through it until we find the problem:
debug(buggy_count)
x <-  factor(sample(c("male" , "female" ), 20,  replace = TRUE))
buggy_count(x)
count (and by extension, our buggy_count) accepts a data frame or a vector as its first
argument. If the df argument is a vector, then the function inserts it into a data frame.
Figure 16-5 shows what happens when we reach this part of the code. When df is a
factor, we want it to be placed inside a data frame. Unfortunately, is.vector returns
FALSE for factors, and the step is ignored. Factors aren’t considered to be vectors, because
they have attributes other than names. What the code really should contain (and does
in the proper version ofplyr) is a call to is.atomic, which is TRUE for factors as well as
other vector types, like numeric.
Figure 16-5. Debugging the buggy_count function
To exit the debugger, type Q at the command line. With the debug function, the debugger
will be started every time that function is called. To turn off debugging, call undebug:
undebug(buggy_count)
As an alternative, use debugonce, which only calls the debugger the first time a function
is called.4
Testing
To make sure that your code isn’t buggy and awful, it is important to test it. Unit test‐
ing is the concept of testing small chunks of code; in R this means testing at the functional


level. (System or integration testing is the larger-scale testing of whole pieces of software,
but that is more useful for application development than data analysis.)
Each time you change a function, you can break code in other functions that rely on it.
This means that each time you change a function, you need to test everything that it
could affect. Attempted manually, this is impossible, or at least time-consuming and
boring enough that you won’t do it. Consequently, you need to automate the task. In R,
you have two choices for this:
1. RUnit has “xUnit” syntax, meaning that it’s very similar to Java’s JUnit, .NET’s
NUnit, Python’s PyUnit, and a whole other family of unit testing suites. This makes
it easiest to learn if you’ve done unit testing in any other language.
2. testthat has its own syntax, and a few extra features. In particular, the caching of
tests makes it much faster for large projects.
Let’s test the hypotenuse function we wrote when we first learned about functions in
“Functions” on page 82. It uses the obvious algorithm that you might use for pen and
paper calculations.5 The function is included in the learningr package:
hypotenuse <- function(x,  y)
{
sqrt(x ^ 2 + y ^ 2)
}
RUnit
In RUnit, each test is a function that takes no inputs. Each test compares the actual result
of running some code (in this case, calling hypotenuse) to an expected value, using one
of the check* functions contained in the package. In this next example we use
checkEqualsNumeric, since we are comparing two numbers:
library(RUnit)
test.hypotenuse.3_4.returns_5 <- function()
{
expected <- 5
actual <-  hypotenuse(3, 4)
checkEqualsNumeric(expected,  actual)
}

There is no universal naming convention for tests, but RUnit looks for
functions with names beginning with test by default. The conven‐
tion used here is designed to maximize clarity. Tests take the name
form of test. name_of_function.description_of_inputs.re
turns_a_value.
Sometimes we want to make sure that a function fails in the correct way. For example,
we can test that hypotenuse fails if no inputs are provided:
test.hypotenuse.no_inputs.fails <- function()
{
checkException(hypotenuse())
}
Many algorithms suffer loss of precision when given very small or very large inputs, so
it is good practice to test those conditions. The smallest and largest positive numeric
values that R can represent are given by the double.xmin and double.xmax components
of the built-in .Machine constant:
. Machine$double.xmin
## [1] 2.225e-308
. Machine$double.xmax
## [1] 1.798e+308
For the small and large tests, we pick values close to these limits. In the case of small
numbers, we need to manually tighten the tolerance of the test. By default, checkE
qualsNumeric considers its test passed when the actual result is within about 1e-8 of
the expected result (it uses absolute, not relative differences). We set this value to be
a few orders of magnitude smaller than the inputs to make sure that the test fails
appropriately:
test.hypotenuse.very_small_inputs.returns_small_positive <- function()
{
expected <-  sqrt(2) * 1e- 300
actual <-  hypotenuse(1e- 300, 1e- 300)
checkEqualsNumeric(expected,  actual,  tolerance = 1e- 305)
}
test.hypotenuse.very_large_inputs.returns_large_finite <- function()
{
expected <-  sqrt(2) * 1e300
actual <-  hypotenuse(1e300, 1e300)
checkEqualsNumeric(expected,  actual)
}

There are countless more possible tests; for example, what happens if we pass missing
values or NULL or infinite values or character values or vectors or matrices or data frames,
or we expect an answer in non-Euclidean space? Thorough testing works your imagi‐
nation hard. Unleash your inner two-year-old and contemplate breaking stuff. On this
occasion, we’ll stop here. Save all your tests into a file; RUnit defaults to looking for files
with names that begin with “runit” and have a .R file extension. These tests can be found
in the tests directory of the learningr package.
Now that we have some tests, we need to run them. This is a two-step process.
First, we define a test suite with defineTestSuite. This function takes a string for a
name (used in its output), and a path to the directory where your tests are contained.
If you’ve named your test functions or files in a nonstandard way, you can provide a
pattern to identify them:
test_dir <-  system.file("tests" ,  package = "learningr" )
suite <-  defineTestSuite("hypotenuse suite" ,  test_dir)
The second step is to run them with runTestSuite (additional line breaks have been
added here as needed, to fit the formatting of the book):
runTestSuite(suite)
##
##
## Executing test function test.hypotenuse.3_4.returns_5 ...
## done successfully.
##
##
##
## Executing test function test.hypotenuse.no_inputs.fails ...
## done successfully.
##
##
##
## Executing test function
## test.hypotenuse.very_large_inputs.returns_large_finite ...
## Timing stopped at: 0 0 0 done successfully.
##
##
##
## Executing test function
## test.hypotenuse.very_small_inputs.returns_small_positive ...
## Timing stopped at: 0 0 0 done successfully.
## Number of test functions: 4
## Number of errors: 0
## Number of failures: 2
This runs each test that it finds and displays whether it passed, failed, or threw an error.
In this case, you can see that the small and large input tests failed. So what went wrong?

The problem with our algorithm is that we have to square each input. Squaring big
numbers makes them larger than the largest (double-precision) number that R can
represent, so the result comes back as infinity. Squaring very small numbers makes them
even smaller, so that R thinks they are zero. (There are better algorithms that avoid this
problem; see the ?hypotenuse help page for links to a discussion of better algorithms
for real-world use.)
RUnit has no built-in checkWarning function to test for warnings. To test that a warning
has been thrown, we need a trick: we set the warn option to 2 so that warnings
become errors, and then restore it to its original value when the test function exits using
on.exit. Recall that code inside on.exit is run when a function exits, regardless of
whether it completed successfully or an error was thrown:
test.log.minus1.throws_warning <- function()
{
old_ops <-  options(warn = 2) #warnings become errors
on.exit(old_ops) #restore old behavior
checkException(log(-1))
}
testthat
Though testthat has a different syntax, the principles are almost the same. The main
difference is that rather than each test being a function, it is a call to one of the expect_*
functions in the package. For example, expect_equal is the equivalent ofRUnit’s check
EqualsNumeric. The translated tests (also available in the tests directory of the lear
ningr package) look like this:
library(testthat)
expect_equal(hypotenuse(3, 4), 5)
expect_error(hypotenuse())
expect_equal(hypotenuse(1e- 300, 1e- 300),  sqrt(2) * 1e- 300,  tol = 1e- 305)
expect_equal(hypotenuse(1e300, 1e300),  sqrt(2) * 1e300)
To run this, we call test_file with the name of the file containing tests, or test_dir
with the name of the directory containing the files containing the tests. Since we have
only one file, we’ll use test_file:
filename <-  system.file(
"tests" ,
"testthat_hypotenuse_tests.R" ,
package = "learningr"
)
test_file(filename)
## ..12
##
## 1. Failure: (unknown) -----------------------------------------------------
## learningr::hypotenuse(1e-300, 1e-300) not equal to sqrt(2) * 1e-300
## Mean relative difference: 1
##
## 2. Failure: (unknown) -----------------------------------------------------
## learningr::hypotenuse(1e+300, 1e+300) not equal to sqrt(2) * 1e+300
## Mean relative difference: Inf
There are two variations for running the tests: test_that tests code that you type at the
command line (or, more likely, copy and paste), and test_package runs all tests from
a package, making it easier to test nonexported functions.
Unlike with RUnit, warnings can be tested for directly via expect_warning:
expect_warning(log(-1))
Magic
The source code that we write, as it exists in a text editor, is just a bunch of strings. When
we run that code, R needs to interpret what those strings contain and perform the
appropriate action. It does that by first turning the strings into one of several lan‐
guage variable types. And sometimes we want to do the opposite thing, converting
language variables into strings.
Both these tasks are rather advanced, dark magic. As is the case with magic in every
movie ever, if you use it without understanding what you are doing, you’ll inevitably
suffer nasty, unexpected consequences. On the other hand, used knowledgeably and
sparingly, there are some useful tricks that you can put up your sleeve.
Turning Strings into Code
Whenever you type a line of code at the command line, R has to turn that string into
something it understands. Here’s a simple call to the arctangent function:
atan(c(- Inf, -1, 0, 1,  Inf))
## [1] -1.5708 -0.7854 0.0000 0.7854 1.5708
We can see what happens to this line of code in slow motion by using the quote function.
quote takes a function call like the one in the preceding line, and returns an object of
class call, which represents an “unevaluated function call”:
(quoted_r_code <-  quote(atan(c(- Inf, -1, 0, 1,  Inf))))
## atan(c(-Inf, -1, 0, 1, Inf))
class(quoted_r_code)
## [1] "call"
The next step that R takes is to evaluate that call. We can mimic this step using the eval
function:

eval(quoted_r_code)
## [1] -1.5708 -0.7854 0.0000 0.7854 1.5708
The general case, then, is that to execute code that you type, R does something like
eval(quote(the stuff you typed at the command line)).
To understand the call type a little better, let’s convert it to a list:
as.list(quoted_r_code)
## [[1]]
## atan
##
## [[2]]
## c(-Inf, -1, 0, 1, Inf)
The first element is the function that was called, and any additional elements contain
the arguments that were passed to it.
One important thing to remember is that in R, more or less everything is a function.
That’s a slight exaggeration, but operators like +; language constructs like switch, if,
and for; and assignment and indexing are functions:
vapply(
list(`+`, `if`, `for`, `<-`, `[`, `[[` ),
is.function,
logical(1)
)
## [1] TRUE TRUE TRUE TRUE TRUE TRUE
The upshot of this is that anything that you type at the command line is really a function
call, which is why this input is turned into call objects.
All of this was a long-winded way of saying that sometimes we want to take text that is
R code and get R to execute it. In fact, we’ve already seen two functions that do exactly
that for special cases: assign takes a string and assigns a value to a variable with that
name, and its reverse, get, retrieves a variable based upon a string input.
Rather than just limiting ourselves to assigning and retrieving variables, we might oc‐
casionally decide that we want to take an arbitrary string of R code and execute it. You
may have noticed that when we use the quote function, we just type the R code directly
into it, without wrapping it in—ahem—quotes. If our input is a string (as in a character
vector of length one), then we have a slightly different problem: we must “parse” the
string. Naturally, this is done with the parse function.
parse returns an expression object rather than a call. Before you get frightened, note
that an expression is basically just a list of calls.

The exact nature of calls and expressions is deep, dark magic, and I
don’t want to be responsible for the ensuing zombie apocalypse when
you try to raise the dead using R. If you are interested in arcana, read
Chapter 6 of the R Language Definition manual that ships with R.
When we call parse in this way, we must explicitly name the text argument:
parsed_r_code <-  parse(text = "atan(c(-Inf, -1, 0, 1, Inf))" )
class(parsed_r_code)
## [1] "expression"
Just as with the quoted R code, we use eval to evaluate it:
eval(parsed_r_code)
## [1] -1.5708 -0.7854 0.0000 0.7854 1.5708
This sort of mucking about with evaluating strings is a handy trick,
but the resulting code is usually fragile and fiendish to debug, mak‐
ing your code unmaintainable. This is the zombie (code) apocalypse
mentioned above.
Turning Code into Strings
There are a few occasions when we want to solve the opposite problem: turning code
into a string. The most common reason for this is to use the name of a variable that was
passed into a function. The base histogram-drawing function, hist, includes a default
title that tells you the name of the data variable:
random_numbers <-  rt(1000, 2)
hist(random_numbers)
To replicate this technique ourselves, we need two functions: substitute and deparse.
substitute takes some code and returns a language object. That usually means a
call, like we would have created using quote, but occasionally it’s a name object, which
is a special type that holds variable names. (Don’t worry about the details, this section
is called “Magic” for a reason.)
The next step is to turn this language object into a string. This is called deparsing. The
technique can be very useful for providing helpful error messages when you check user
inputs to functions. Let’s see the deparse-substitute combination in action:

divider <- function(numerator,  denominator)
{
if(denominator == 0)
{
denominator_name <-  deparse(substitute(denominator))
warning("The denominator, " ,  sQuote(denominator_name), ", is zero." )
}
numerator / denominator
}
top <- 3
bottom <- 0
divider(top,  bottom)
## Warning: The denominator, 'bottom', is zero.
## [1] Inf
substitute has one more trick up its sleeve when used in conjunction with eval. eval
lets you pass it an environment or a data frame, so you can tell R where to look to evaluate
the expression.
As a simple example, we can use this trick to retrieve the levels of the Gender column
of the hafu dataset:
eval(substitute(levels(Gender)),  hafu)
## [1] "F" "M"
This is exactly how the with function works:
with(hafu,  levels(Gender))
## [1] "F" "M"
In fact, many functions use the technique: subset uses it in several places, and lattice
plots use the trick to parse their formulae. There are a few variations on the trick de‐
scribed in Thomas Lumley’s “Standard nonstandard evaluation rules.”
Object-Oriented Programming
Most R code that we’ve seen so far is functional-programming-inspired imperative
programming. That is, functions are first-class objects, but we usually end up with a
data-analysis script that executes one line at a time.
In a few circumstances, it is useful to use an object-oriented programming (OOP) style.
This means that data is stored inside a class along with the functions that are allowed
to act on it. It is an excellent tool for managing complexity in larger programs, and is
particularly suited to GUI development (in R or elsewhere). See Michael Lawrence’s
Programming Graphical User Interfaces in R for more on that topic.
R has six (count ‘em) different OOP systems, but don’t let that worry you—there are
only two of them that you’ll need for new projects.
Three systems are built into R:
1. S3 is a lightweight system for overloading functions (i.e., calling a different version
of the function depending upon the type of input).
2. S4 is a fully featured OOP system, but it’s clunky and tricky to debug. Only use it
for legacy code.
3. Reference classes are the modern replacement for S4 classes.
Three other systems are available in add-on packages (but for new code, you will usually
want to use reference classes instead):
1. proto is a lightweight wrapper around environments for prototype-based pro‐
gramming.
2. R.oo extends S3 into a fully fledged OOP system.
3. OOP is a precursor to reference classes, now defunct.
In many object-oriented programming languages, functions are called
methods. In R, the two words are interchangeable, but “method” is
often used in an OOP context.
S3 Classes
Sometimes we want a function to behave differently depending upon the type of input.
A classic example is the print function, which gives a different style of output for dif‐
ferent variables. S3 lets us call a different function for printing different kinds of vari‐
ables, without having to remember the names of each one.
The print function is very simple—just one line, in fact:
print
## function (x, ...)
## UseMethod("print")
## <bytecode: 0x0000000018fad228>
## <environment: namespace:base>
It takes an input, x (and ... ; the ellipsis is necessary), and calls UseMethod("print").
UseMethod checks the class of x and looks for another function named
print.class_of_x, calling it if it is found. If it can’t find a function of that name, it tries
to call print.default.
For example, if we want to print a Date variable, then we can just type:


today <-  Sys.Date()
print(today)
## [1] "2013-07-17"
print calls the Date-specific function print.Date:
print.Date
## function (x, max = NULL, ...)
## {
## if (is.null(max))
## max <- getOption("max.print", 9999L)
## if (max < length(x)) {
## print(format(x[seq_len(max)]), max = max, ...)
## cat(" [ reached getOption(\"max.print\") -- omitted",
## length(x) - max, "entries ]\n")
## }
## else print(format(x), max = max, ...)
## invisible(x)
## }
## <bytecode: 0x0000000006dc19f0>
## <environment: namespace:base>
Inside print.Date, our date is converted to a character vector (via format), and then
print is called again. There is no print.character function, so this time UseMethod
delegates to print.default, at which point our date string appears in the console.
If a class-specific method can’t be found, and there is no default meth‐
od, then an error is thrown.
You can see all the available methods for a function with the methods function. The
print function has over 100 methods, so here we just show the first few:
head(methods(print))
## [1] "print.abbrev" "print.acf" "print.AES"
## [4] "print.anova" "print.Anova" "print.anova.loglm"
methods(mean)
## [1] mean.Date mean.default mean.difftime mean.POSIXct mean.POSIXlt
## [6] mean.times* mean.yearmon* mean.yearqtr* mean.zoo*
##
## Non-visible functions are asterisked



If you use dots in your function names, like data.frame, then it
can get confusing as to which S3 method gets called. For example,
print.data.frame could mean a print.data method for a frame in‐
put, as well as the correct sense of a print method for a data.frame
object. Consequently, using lower_under_case or lowerCamelCase is
preferred for new function names.
Reference Classes
Reference classes are closer to a classical OOP system than S3 and S4, and should be
moderately intuitive to anyone who has used classes in C++ or its derivatives.
A class is the general template for how the variables should be struc‐
tured. An object is a particular instance of the class. For example, 1:10
is an object of class numeric.
The setRefClass function creates the template for a class. In R terminology, it’s called
a class generator. In some other languages, it would be called a class factory.
Let’s try to build a class for a 2D point as an example. A call to setRefClass looks like
this:
my_class_generator <-  setRefClass(
"MyClass" ,
fields = list(
#data variables are defined here
),
methods = list(
#functions to operate on that data go here
initialize = function(... )
{
#initialize is a special function called
#when an object is created.
}
)
)
Our class needs x and y coordinates to store its location, and we want these to be numeric.
In the following example, we declare x and y to be numeric:
If we didn’t care about the class of x and y, we could declare them with
the special value ANY.
6. In case you were wondering, NA_real_ is a missing number. Usually for missing values we just use NA and
let R figure out the type that it needs to be, but in this case, because we specified that the fields must be numeric,
we need to explicitly state the type.
point_generator <-  setRefClass(
"point" ,
fields = list(
x = "numeric" ,
y = "numeric"
),
methods = list(
#TODO
)
)
This means that if we try to assign them values of another type, an error will be thrown.
Purposely restricting user input may sound counterintuitive, but it can save you from
having more obscure bugs further down the line.
Next we need to add an initialize method. This is called every time we create a point
object. This method takes x and y input numbers and assigns them to our x and y fields.
There are three interesting things to note about it:
1. If the first line of a method is a string, then it is considered to be help text for that
method.
2. The global assignment operator, <<- , is used to assign to a field. Local assignment
(using <- ) just creates a local variable inside the method.
3. It is best practice to let initialize work without being passed any arguments, since
it makes inheritance easier, as we’ll see in a moment. This is why the x and y
arguments have default values.6
With the initialize method, our class generator now looks like this:
point_generator <-  setRefClass(
"point" ,
fields = list(
x = "numeric" ,
y = "numeric"
),
methods = list(
initialize = function(x = NA_real_,  y = NA_real_)
{
"Assign x and y upon object creation."
x <<-  x
y <<-  y
}
)
)
Our point class generator is finished, so we can now create a point object. Every gen‐
erator has a new method for this purpose. The new method calls initialize (if it exists)
as part of the object creation process:
(a_point <-  point_generator$new(5, 3))
## Reference class object of class "point"
## Field "x":
## [1] 5
## Field "y":
## [1] 3
Generators also have a help method that returns the help string for a method that you
specify:
point_generator$help("initialize" )
## Call:
## $initialize(x = , y = )
##
##
## Assign x and y upon object creation.
You can provide a more traditional interface to object-oriented code by wrapping class
methods inside other functions. This can be useful if you want to distribute your code
to other people without having to teach them about OOP:
create_point <- function(x,  y)
{
point_generator$new(x,  y)
}
At the moment, the class isn’t very interesting because it doesn’t do anything. Let’s re‐
define it with some more methods:
point_generator <-  setRefClass(
"point" ,
fields = list(
x = "numeric" ,
y = "numeric"
),
methods = list(
initialize = function(x = NA_real_,  y = NA_real_)
{
"Assign x and y upon object creation."
x <<-  x
y <<-  y
},
distanceFromOrigin = function()
{
"Euclidean distance from the origin"
sqrt(x ^ 2 + y ^ 2)
},

add = function(point)
{
"Add another point to this point"
x <<-  x + point$x
y <<-  y + point$y
. self
}
)
)
These additional methods belong to point objects, unlike new and help, which belong
to the class generator (in OOP terminology, new and help are static methods):
a_point <-  create_point(3, 4)
a_point$distanceFromOrigin()
## [1] 5
another_point <-  create_point(4, 2)
(a_point$add(another_point))
## Reference class object of class "point"
## Field "x":
## [1] 7
## Field "y":
## [1] 6
As well as new and help, generator classes have a few more methods. fields and methods
respectively list the fields and methods of that class, and lock makes a field read-only:
point_generator$fields()
## x y
## "numeric" "numeric"
point_generator$methods()
## [1] "add" "callSuper" "copy"
## [4] "distanceFromOrigin" "export" "field"
## [7] "getClass" "getRefClass" "import"
## [10] "initFields" "initialize" "show"
## [13] "trace" "untrace" "usingMethods"
Some other methods can be called either from the generator object or from instance
objects. show prints the object, trace and untrace let you use the trace function on a
method, export converts the object to another class type, and copy makes a copy.
Reference classes support inheritance, where classes can have children to extend their
functionality. For example, we can create a three-dimensional point class that contains
our original point class, but includes an extra z coordinate.

A class inherits fields and methods from another class by using the contains argument:
three_d_point_generator <-  setRefClass(
"three_d_point" ,
fields = list(
z = "numeric"
),
contains = "point" ,  #this line lets us inherit
methods = list(
initialize = function(x,  y,  z)
{
"Assign x and y upon object creation."
x <<-  x
y <<-  y
z <<-  z
}
)
)
a_three_d_point <-  three_d_point_generator$new(3, 4, 5)
At the moment, our distanceFromOrigin function is wrong, since it doesn’t take the z
dimension into account:
a_three_d_point$distanceFromOrigin() #wrong!
## [1] 5
We need to override it in order for it to make sense in the new class. This is done by
adding a method with the same name to the class generator:
three_d_point_generator <-  setRefClass(
"three_d_point" ,
fields = list(
z = "numeric"
),
contains = "point" ,
methods = list(
initialize = function(x,  y,  z)
{
"Assign x and y upon object creation."
x <<-  x
y <<-  y
z <<-  z
},
distanceFromOrigin = function()
{
"Euclidean distance from the origin"
sqrt(x ^ 2 + y ^ 2 + z ^ 2)
}
)
)

To use the updated definition, we need to recreate our point:
a_three_d_point <-  three_d_point_generator$new(3, 4, 5)
a_three_d_point$distanceFromOrigin()
## [1] 7.071
Sometimes we want to use methods from the parent class (a.k.a. superclass). The call
Super method does exactly this, so we could have written our 3D distanceFromOri
gin (inefficiently) like this:
distanceFromOrigin = function()
{
"Euclidean distance from the origin"
two_d_distance <-  callSuper()
sqrt(two_d_distance ^ 2 + z ^ 2)
}
OOP is a big topic, and even limited to reference classes, it’s worth a book in itself. John
Chambers (creator of the S language, R Core member, and author of the reference classes
code) is currently writing a book on OOP in R. Until that materializes, the ?Reference
Classes help page is currently the definitive reference-class reference.
Summary
• R has three levels of feedback about problems: messages, warnings, and errors.
• Wrapping code in a call to try or tryCatch lets you control how you handle errors.
• The debug function and its relatives help you debug functions.
• The RUnit and testthat packages let you do unit testing.
• R code consists of language objects known as calls and expressions.
• You can turn strings into language objects and vice versa.
• There are six different object-oriented programming systems in R, though only S3
and reference classes are needed for new projects.


#######################################################

#######################################################
#######################################################
#######################################################

system ( paste ( ’"C: /Program Files /Internet Explorer/iexplore.exe",’’cran.r-project.org’ ) , wait = FALSE)
# i n v o k e t h e n o t e p a d
5 system ( "notepad" )
s h e l l . exec ( "C: /WINDOWS /clock" )

. packages ( a l l . a v a i l a b l e = TRUE)


dim ( data ( ) $ r e s u l t s )
data ( ) $ r e s u l t s [ , 4 ]

39. 如何调用 R 的输出信息？
R 提供了 capture.output() 函数， 这个函数可以将 R 的输出信息转化为字符或文件。
glmout <− capture . output ( example ( glm ) )
2 glmout [ 1 : 5 ]

41. 怎样将因子 (factor) 转换为数字
这个问题时有发生， 假设 f 是一个这样的因子对象， 我们可以使用
a s . numeric ( as . character ( f ))
2 # o r
as . numeric ( levels ( f ))[ as . integer ( f )]

43. 为什么当我使用 source() 时， 不能显示输出结果？
对需要显示输出的对象使用 print() ， 或者使用 source(file,echo = TRUE)。 如果 R 代码里面包含
sink() 之类的函数， 必须使用 source(file,echo = TRUE) 才能得到正确的输出结果， 否则 sink 的对
象将为空。
44. R 可以输出可供 TEX 使用的文本么？
可以， 参考 Hmisc 包中的 latex() 函数和 xtable 包中的 xtable()函数。
a <− matrix (1:6 , nr=1) # r e q u i r e ( x t a b l e )
2 colnames (a) <− paste ( "col" , 1:6)
xtable (a)

library(xtable)
a <− matrix (1:6 , nr=1)
colnames (a) <− paste ( "col" , 1:6)
xtable (a)

file.choose()


l i b r a r y (RODBC)
ch <− odbcConnect ( "stocksDSN" , uid = "myuser" ,pwd = "mypassword" )
s t o c k s <− sqlQuery ( ch , "select ∗ from quotes" )
odbcClose ( ch )

48. 如何将字符串转变为命令执行？
这里用到 eval() 和 parse() 函数。 首先使用 parse() 函数将字符串转化为表达式（expression）， 而后
使用 eval() 函数对表达式求解。
1 x <− 1:10
a <− "print(x)"
3 c l a s s ( a )
eval ( parse ( text = a ) )

x <− 1:5
( foo <− c (x [ 1 ] , 0 , x [ 2 : 5 ] ) ) # e x p e c t e d r e s u l t
append (x , 0 , a f t e r = 1)

50. 如何移除某行 (列 ) 数据
可以使用函数 subset(select = ) ； 或者使用下标：
1 x <− data . frame ( matrix (1:30 , nrow = 5 , byrow = T))
dim (x)
3 print (x)
new . x1 <− x[− c ( 1 , 4 ) , ] # r o w
5 new . x2 <− x[, − c [ 2 , 3 ] ] # c o l
new . x1 ; new . x2
事实上， 关于选取特定条件下的数据框数据， subset 函数同使用下标效果相同：
iS <− i r i s $ Species == "setosa"
2 i r i s [ iS , c ( 1 , 3 ) ]
subset ( i r i s , s e l e c t = c ( Sepal . Length , Petal . Length ) , Species == "setosa" )

51. 如何比较两个数据框是否相同？
比较每个元素是否相同， 如果每个元素都相同， 那么这两个数据框也相同
1 a1 <− data . frame (num = 1:8 , l i b = l e t t e r s [ 1 : 8 ] )
a2 <− a1
3 a2 [ [ 3 , 1 ] ] <− 2 −> a2 [ [ 8 , 2 ] ]
any ( a1 ! =a2 ) # a l l ( a 1 == a 2 )
any() 函数可以返回是值是否至少有一个为真的逻辑值。 而数据框中的元素有不相等的情况， 则
a1 ! =a2
将返回至少一个 TRUE， 那么 any() 函数将判断为 TRUE。 同样也可以使用 identical() 函数。
1 in de nt i ca l (a1 , a2 )
如果需要返回两个数据框不相同的位置， 可以使用
1 which ( a1 ! =a2 , arr . ind = TRUE)
arr.ind 参量是 array indices 之意， 返回数据框的行列位置。

1 x <− c ( 9 : 2 0 , 1 : 5 , 3 : 7 , 0 : 8 )
( xu <− x [ ! d u p l i c a t e d ( x ) ] )
3 unique ( x ) # i s m o r e e f f i c i e n t
这里 duplicated 函数返回了元素是否重复的逻辑值。

 53. 如何对数列（ array） 进行维度变换？
使用函数 aperm
1 x <− array ( 1 : 2 4 , 2 : 4 )
xt <− aperm ( x , c ( 2 , 1 , 3 ) )
3 dim ( x ) ; dim ( xt )

R 中使用 NULL 表示无效的对象。
1 l s t <− l i s t ( "a"= l i s t ( "b" =1,"c" =2) , "b"= l i s t ( "d" =3,"e" =4))
l s t [ [ "a" ] ] [ "b" ] <− NULL # o r l s t $ a $ b <− NULL
3 l s t
55. 如何对矩阵按行 (列 ) 作计算？
使用函数 apply()
1 vec =1:20
mat=matrix ( vec , ncol =4)
3 vec
cumsum( vec )
5 mat
apply ( mat , 2 , cumsum)
7 apply ( mat , 1 , cumsum)

i f (FALSE) {
something passby
3 }

58. 如何求解两组平行向量的极值？
pmax() 和 pmin() ， 如：
1 x <− 1:10 ; y <− rev ( x )
pmax( x , y ) ; pmin ( x , y )

59. 如何对不规则数组进行统计分析？
参考 tapply() ：
n <− 1 7 ; f a c <− f a c t o r ( rep ( 1 : 3 , l e n = n ) , l e v e l s = 1 : 5 )
t a b l e ( f a c )
tapply ( 1 : n , fac , sum )
tapply ( 1 : n , fac , mean )
## o r r e v e r s e a l i s t
to <− l i s t ( a = 1 , b = 1 , c = 2 , d = 1)
tapply ( to , u n l i s t ( to ) , names )
tapply() 的常见于方差分析中对各个组别进行 mean、 var（sd） 的计算。 说到概要统计， 不得不说另
外一个函数 aggregate()， 它将 tapply() 函数对象为向量的限制扩展到了数据框。 7
attach ( warpbreaks )
tapply ( breaks , l i s t ( wool , t e n s i o n ) , mean )
aggregate ( breaks , l i s t ( wool , t e n s i o n ) , mean )
## f r o m t h e h e l p
aggregate ( s t a t e . x77 ,
l i s t ( Region = s t a t e . region ,
Cold = s t a t e . x77 [ , "Frost" ] > 130) ,
mean )

60. 判断数据框的列是否为数字？
sapply(dataframe, is.numeric)
61. 一组数中随机抽取数据？
函数 sample()
sample(n) 随机组合 1, . . . , n
sample(x) 随机组合向量 x, length(x) > 1
sample(x, replace = T) 解靴带法
sample(x,n) 非放回的从 x 中抽取 n 项
sample(x,n, replace = T) 放回的从 x 中抽取 n 项
sample(x,n, replace = T ,prob = p) 以概率 p， 放回的从 x 中抽取 n 项

n <− 1000
2 x <− sample ( c ( − 1 ,1) , n , replace=T)
plot ( cumsum(x ) , type="l" ,
4 main="Cumulated sums of Bernoulli variables" )
还可以参考第 17 页中关于模拟已知分布的随机数据函数， 如：
rnorm (100 , mean=0, sd=1)
62. 如何根据共有的列将两个数据框合并？
我们经常会遇到两个数据框拥有相同的时间或观测值， 但这些列却不尽相同。 处理的办法就是使用
merge(x, y ,by.x = ,by.y = ,all = ) 函数。
63. 如何将数据标准化？
参考 scale 函数。
1 x <− c ( rnorm (100) , 2 ∗ rnorm (30))
m <− sca le (x , sca le = F) # o n l y c e n t e r i n g
3 n <− sca le (x , center = F) # o n l y s c a l i n g
64. 为什么 fivenum 和 summary 两个函数返回的结果不同？
因为他们对数据描述机理一致， 所以有些教材将二者等同， 但他们确实有细微差别。
1 > fivenum ( c (1 ,4 ,6 ,17 ,50 ,51 ,70 ,100))
[ 1 ] 1.0 5.0 33.5 60.5 100.0
3 > quantile ( c (1 ,4 ,6 ,17 ,50 ,51 ,70 ,100))
0% 25% 50% 75% 100%
5 1.00 5.50 33.50 55.75 100.00
我们看下他们的的定义： 分位数是指有百分之多少的数据小于的数值（summary() 函数， 即使用分
位数概念）， 我们可以看到 1
4,
34
分位数的定义：
1 +
14
(length(x) − 1), 1
4
分位数
1 +
34
(length(x) − 1), 3
4
分位数
而 fivenum() 函数是完全利用中位数概念。
§E 数学运算
65. 如何做出曲线积分？
R 语言使用 integrate 函数来得到积分结果， 如
1 i n t e g r a t e ( dnorm , − 1.96 , 1 . 9 6 )
i n t e g r a t e ( dnorm , − Inf , I n f )
3 ## a s l o w l y − c o n v e r g e n t i n t e g r a l
integrand <− f u n c t i o n ( x ) { 1 / ( ( x+1) ∗ s q r t ( x ) ) }
5 i n t e g r a t e ( integrand , lower = 0 , upper = I n f )
66. 如何得到一个列向量？
矩阵转置可以使用函数 t() ， R 中默认 x 为 “integer” 类型数据， 这时可以用 t(t(x)) 得到列向量：
1 x <− 1:10 ; c l a s s ( x )
t ( x ) ; c l a s s ( t ( x ) )
3 t ( t ( x ) ) ; c l a s s ( t ( t ( x ) ) )
行向量、 列向量常常会有一个比较容易让人迷糊的地方：
1 x%∗%x
计算的是 xTx（计算 xxT 使用 %o% 或 outer() 函数）。 crossprod() 函数能避免这种情况：
1 XT. y <− c r o s s p r o d (X, y )
它直接计算 XTY， 可以看作前者的另一种表达方式， 当然 crossprod() 更为有效8。 由于 outer() 函
数的矩阵意义， 它常用于三维绘图数据， 比如我们计算
10 ×
sin px2 + y2
px2 + y2
那么对应的 R 函数计算为：
1 f <− f u n c t i o n ( x , y ) { r <− s q r t ( xˆ2+y ˆ 2 ) ; 10 ∗ s i n ( r ) / r }
z <− outer ( x , y , f )
67. R 如何进行复数计算？
参考 complex() 函数的帮助。
x <− 1 + 1 i # x <− c o m p l e x ( 1 , 1 )
2 Mod( x ) ; Conj ( x )
68. 如何生成对角矩阵？
对一个向量使用 diag() 函数， 得到对角线元素为向量的对角矩阵； 对整数 Z 使用此函数得到 Z 维
的单位矩阵。
69. 求矩阵的特征值和特征向量的函数是什么？
参考： eigen 函数

70. 如何构造上（下） 三角矩阵？
参考函数 lower.tri() 和 upp er.tri() 。
Rmat <− matrix (1:16 ,4 ,4)
2 Rmat[ lower . t r i (Rmat ) ] <− 0
Rmat
71. 求立方根如何运算？
xˆ(1/3)。 在 R 里面 sqrt() 函数可以计算开平方， 故新手容易推测开立方也有函数。 事实上 R 里面
使用 ˆ 来作幂函数运算。 ˆ 不但是运算符号， 还可以看作是函数：
1 "ˆ" (x , 1 / 3)
在 R 中的运算符号包括：
R 中的运算符号
数学运算 +,-,*,/,ˆ,%%,%/% 加、 减、 乘、 除、 乘方、 余数、 整除
逻辑运算 >,<,>=,<=, ==, ! = 大于， 小于， 大于等于， 小于等于， 等于， 不等于
72. 如何求矩阵各行 (列 ) 的均值？
如果运算量不是很大， 当然可以使用 apply() 函数。 rowMeans() 和 colMeans() 函数可以更快地得到
你要的结果。
1 m <− 1000 ; n <− 3000
A <− matrix ( 1 :m∗n ,m ,n)
3 system . time (B1 <− matrix ( apply (A,2 , mean ) , m, n , by=T))
system . time (B2 <− matrix ( colMeans (A) , m, n , by=T))
73. 如何计算组合数或得到所有组合？
choose() 用于计算组合数 ¡nk¢， 函数 combn() 可以得到所有元素的组合。 使用 factorial() 计算阶乘。
74. 如何在 R 里面求（偏） 导数？
使用函数 D()
f1 <− expression ( sin (x) ∗x)
2 f2 <− expression (xˆ2 ∗y + yˆ2)
D( f , "x" )
75. 如何求一元方程的根？
使用 uniroot()函数， 不过 uniroot 是基于二分法来计算方程根， 当初始区间不能满足要求时， 会返
回错误信息。
1 f <−function (x)xˆ3 − 2 ∗x − 1
uniroot ( f , c (0 ,2))
如果一元方程的根恰恰是其极值， 那么还可以使用 optimize()函数来求极值。
f <− function (x)xˆ2 + 2 ∗x + 1
2 optimize ( f , c ( − 2 ,2))
76. 如何模拟高斯（正态） 分布数据？
使用 rnorm(n , mean , sd) 来产生 n 个来自 于均值为 mean， 标准差为 sd 的高斯（正态） 分布的数
据。 在 R 里面通过分布前增加字母 ‘d’ 表示概率密度函数， ‘p’ 表示累积分布函数， ‘q’ 表示分位
数函数， ‘r’ 表示产生该分布的随机数。 这些分布具体可以参考第 20 页中 “如何做密度曲线”， 或
R-intro 中的 Probability distributions 章节， 或
help . search ( "distribution" )
使用这些函数可以很轻松的进行相关的分布的概
率计算， 如已知 X˜N(3, 1)， 计算
P(2 6 X 6 5)
利用正态分布的累积分布函数 pnorm
1 pnorm (5 ,3 ,1) − pnorm (2 ,3 ,1)
计算结果为 0.8185946， 即右图中阴影的面积。
0.0 0.1 0.2 0.3 0.4
Density
P(2<x<5)

§F 字符操作
77. R 对大小写敏感么？
R 中有很多基于 Unix 的包， 故 R 对大小写是敏感的。 可以使用 tolower() 、 toupper() 、 casefold()
这类的函数对字符进行转化。
1 x <− "MiXeD cAsE 123"
chartr ( "iXs" , "why" , x)
3 chartr ( "a-cX" , "D-Fw" , x)
tolower (x)
5 toupper (x)
78. R 运行结果输出到文件中时， 文件名中可以用变量代替吗？
可以， 通过使用 paste() 函数。

1 f o r ( var in l e t t e r s [ 1 : 6 ] ) {
x <− var
3 w r i t e . t a b l e ( x , paste ( "FOO " , var , ".txt" , sep = "" ) )
} # You w i l l g e t ” FOO a . t x t ” . . .
79. 在 R 中如何使用正则表达式（ Regular Expressions ）
在 R 中， 有三种类型的正则表达式： extended regular expressions， 使用函数 grep(extended = TRUE)
（默认）； basic regular expressions， 使用 grep(extended = FALSE)； Perl-like regular expressions， 使
用 grep(perl = TRUE)。 比如 “.” 用来匹配任意字符（使用 “\.” 来匹配 “.”）：
grep ( "J." , month . abb )
详细可以参考 help(”regex”)。
80. 如何在字符串中选取特定位置的字符？
参考 substr()函数。
1 s u b s t r ( "abcdef" , 2 , 4 )
s u b s t r i n g ( "abcdef" , 1 : 6 , 1 : 6 )
这个函数同时支持中文， 用她来处理 “简称” 和 “全称” 还是一个不错的选择的。
81. 如何返回字符个数？
参考 nchar 。
nchar ( month . name [ 9 ] )

§G 日期时间
82. 日 期可以做算术运算么？
可以。 一般我们需要使用 as.Date() ， as.POSIXct() 函数将读取的日 期（字符串） 转化为 “Date” 类
型数据， “Date” 类型数据可以进行算术运算。
1 d1 <− c ( "06 /29 /07" ) ; d2 <− c ( "07 /02 /07" )
D1 <− as . Date ( d1 , "%m/%d/%y" )
3 D2 <− as . Date ( d2 , "%m/%d/%y" )
D1 + 2 ; D1 − D2
5 d i f f t i m e (D1 , D2 , u n i t s = "days" )
83. 如何将日 期表示为 “星期日 , 22 七月 2007” 这种格式？
使用 format() 函数。

§H 绘图相关
84. 如何在同一画面画出多张图？
这里提供三种解决方案：
• 修改绘图参数， 如 par(mfrow = c(2,2)) 或 par(mfcol = c(2,2))；
• 更为强大功能的 layout函数， 它可以设置图形绘制顺序和图形大小；
• split.screen()函数。
推荐使用 layout() 函数， Statistics with R 的一个例子：
1 layout ( matrix ( c ( 1 , 1 , 1 ,
2 , 3 , 4 ,
3 2 , 3 , 4 ) , nr = 3 , byrow = T) )
h i s t ( rnorm ( 2 5 ) , c o l = "VioletRed" )
5 h i s t ( rnorm ( 2 5 ) , c o l = "VioletRed" )
h i s t ( rnorm ( 2 5 ) , c o l = "VioletRed" )
7 h i s t ( rnorm ( 2 5 ) , c o l = "VioletRed" )
85. 如何设置图形边缘大小
修改绘图参数 par(mar = c(bottom, left, top, right))， bottom, left, top, right 四个参数分别是距
离 bottom, left, top, right 的长度， 默认距离是 c(5, 4, 4, 2) + 0.1。 或者修改绘图参数 par(mai =
c(bottom, left, top, right))， 以英寸为单位来指定边缘大小。
86. 常用的 p ch 符号都有哪些？
pch 是 plotting character 的缩写。 pch 符号
可以使用 “0 : 25” 来表示 26 个标识（参
看右图 “pch 符号”）。 当然符号也可以使用
#, %, ∗, |, +, −, ., o, O。 值得注意的是， 21 : 25
这几个符号可以在 points 函数使用不同的颜
色填充（bg= 参数）。
10
32
54
76
98
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
1 op <− par ( bg = "light blue" )
x <− seq (0 ,2 ∗ pi , l e n =51)
3 p l o t ( x , s i n ( x ) , type = "o" , bg=par ( "bg" ) )
p o i n t s ( x , s i n ( x ) , pch = 21 , cex =1.5 , bg="red" )
87. 如何在已有图形上加一条水平线
使用低水平绘图命令 abline()， 它可以作出水平线（ y 值 h=）、 垂线（ x 值 v=） 和斜线（截距 a=， 斜
率 b=）。
R 中的绘图命令可以分为 “高水平 ”（ High level）、 “低水平（Low level） ” 和 “交互式”（Interactive）
三种绘图命令。
简要地说， “高水平” 绘图命令可以在图形设备上绘制新图； “低水平” 绘图命令将在已经存在
图形上添加更多的绘图信息， 如点、 线、 多边形等； 使用 “交互式” 绘图命令创建的绘图， 可以使用
如鼠标这类的定点装置来添加或提取绘图信息。 在已有图形上添加信息当然要使用 “低水平” 绘图
命令。
88. 如何做密度曲线？
常用的办法是： 做出 x 的一个序列， 然后做出 dfunction(x)， 比如：
x=seq ( − 3, 3 , . 0 5 )
2 plot (x , dnorm ( x ) , type="l" )
l i n e s (x , dt (x , 1 ) , c o l = "red" )
dfunction(x) 中的 function 是指分布族， 可以参考 R-intro 中的 Probability distributions 章节， 或
help.search(”distribution”)。 关于构造相关分布函数参考第 17 页中 “如何模拟高斯分布数据”。
R 中的分布函数
分布 R 函数 附加参数 默认参数
beta beta shape1(α),shape2(β)
二项 binom size(n),prob(p)
χ2 chisq df
均匀 unif min(a),max(b) min = 0,max = 1
指数 exp rate rate = 1
F f df1(r1),df2(r2)
伽玛 gamma shape(α),scale(θ) scale = 1
超几何 hyper m = N1,n = N2,k = n
正态 norm mean(µ),sd(σ) mean = 0,sd = 1
泊松 pois lamda(λ)
t t df
威布尔 weibull shape(α),scale(θ) scale = 1
89. 如何加图例？
绘制图形后， 使用 legend函数， help(”legend”)
1 with ( i r i s , plot ( Sepal . Length , Sepal . Width ,
pch=as . numeric ( Species ) , cex =1.2))
3 legend ( 6 . 1 , 4 . 4 , c ( "setosa" , "versicolor" , "virginica" ) ,
cex =1.5 , pch =1:3)
90. 怎么做饼图？
参考 pie()函数。 饼图展示数据的能力较差， 因为我们的眼睛对长度单位比较敏感， 而对关联区域和
角度感觉较差。 建议使用条形图（bar chart） 和点图（dot chart）。
91. 如何做茎叶图？
参考 stem 函数。
stem ( f a i t h f u l $ e r u p t i o n s )
92. R 如何做双坐标图？
在 R 中可以通过绘图参数 par(new = TRUE)使得绘制第二个绘图 (hight-level plot) 时保留第一个
绘图区域， 这样两张绘图会重叠在一起， 看起来就是双坐标图。 下面的例子是在同一张图上绘制
GDP 和失业率 (UR)：
1 year <− 1995:2005
x1 <− data . frame ( year , GDP = s o r t ( rnorm ( 1 1 , 1 0 0 0 , 1 0 0 ) ) )
3 x2 <− data . frame ( year , UR = rnorm ( 1 1 , 5 , 1 ) )
par (mar = c ( 5 , 4 , 4 , 6 ) + 0 . 1 )
5 p l o t ( x1 , axes = FALSE, type="l" )
a x i s ( 1 , at = year , l a b e l = year ) ; a x i s ( 2 )
7 par ( new = T, mar = c ( 1 0 , 4 , 1 0 , 6 ) + 0 . 1 )
p l o t ( x2 , axes = FALSE, xlab = "" , ylab = "" , c o l = "red" , type= "b" )
9 mtext ( "UR(%)" , 4 , 3 , c o l="red" )
a x i s ( 4 , c o l ="red" , c o l . a x i s = "red" )
但不推荐使用双坐标图来进行数据描述， 这样很容易造成误解。 并且在 R 中做出并排图形作对比
很容易， 没有必要绘制双坐标图。
93. 如何为绘图加入网格？
使用 grid() 函数，
p l o t ( 1 : 3 )
2 g r i d (NA, 5 , lwd = 2) # g r i d o n l y i n y − d i r e c t i o n
94. 如果绘图时标题太长， 如何换行？
可以使用 strwrap 函数， 这个函数可以将定义段落格式。
p l o t ( 0 , main = paste ( strwrap ( "This is a really long title that
2 i can not type it properly" , width = 50 ) ,

c o l l a p s e = "\n" ) )
95. 可以打开多个图形设备么？
可以。 当打开多个图形设备后， 使用 dev.list()察看图形设备的数目（除了设备一）， 使用 dev.cur()察
看当前使用的图形设备， dev.set()改变激活指定的图形设备， dev.off()关闭图形设备。
96. 坐标 y 上的数字如何水平放置？
仍然是绘图参数问题：
1 ? par # s e e l a s
p l o t ( 0 , 0 , xaxt="n" , type="n" , ylim=c ( 0 , 1 0 0 ) , l a s =1 )
3 mtext ( "35" , s i d e =2, at =35, l i n e =1, l a s =1)
97. 常用的绘图设备都有哪些？
R 支持的图形设备有如下几种（参考?Devices）：
R 图形设备
名称 描述
屏幕 x11 X 窗口
显示 windows Windows 窗口
postscript ps 格式文件
pdf pdf 格式文件
pictex 供 LATEX使用的文件
文件 png png 格式文件
设备 jpeg jpeg 格式文件
bmp bmp 格式文件
xfig 供 XFIG 使用的图形格式
win.metafile a emf 格式的文件
a仅在 Windows 下有效
这里推荐使用 postscript() 函数， 因为 ps 图形格式为矢量绘图格式， 且通用性较强。
98. 如何做雷达图？
R 里面使用 stars 函数来做雷达图。
1 s t a r s ( s t a t e . x77 [ , c ( 7 , 4 , 6 , 2 , 5 , 3 ) ] , f u l l = FALSE,
key . l o c = c (10 , 2 ) )
这里的的 full = FALSE 参数表示只绘制雷达图的上半部分（反之， 绘制整个雷达图）； key.loc 参数
表示基准图例的位置。
99. 为什么 R 不能显示 8 种以上的颜色？
当绘图参数 col 使用数字来代替颜色名时会有这种情形， 这是因为 R 内置调色板默认为 8 种颜色：
p a l e t t e ( )
2 b a r p l o t ( rnorm ( 1 5 , 10 , 3) , c o l = 1 : 1 5 )
p a l e t t e ( rainbow ( 1 5 ) )
4 b a r p l o t ( rnorm ( 1 5 , 10 , 3) , c o l = 1 : 1 5 )
p a l e t t e ( "default" )
在 R 中共有 657 种颜色名称可以使用， 它们的名称可以通过
1 c o l o r s ( )
来得到， 但事实上有些颜色名称代表的颜色重复， R 中颜色名称只能显示 502 种颜色。 当然可以使
用函数 rgb() 来指定任意色彩。
100. 如何用不同的颜色来代表数据？
高级绘图函数一般都有 col 参数可以设置。 对于像 barplot() 这类图形， 可以使用 “颜色组”(color
sets) 来设置颜色， 颜色组包括如下几类：
R 颜色组函数
名称 描述
rainbow() 彩虹色 (        )
heat.colors() 红色至黄色 (        )
terrain.colors() 绿色、 棕色至白色 (        )
topo.colors() 深蓝色至浅棕色 (        )
cm.colors() 浅蓝到白色， 浅紫色 (        )
gay()、 grey() 灰色 (        )
1 x <− 1 : 1 0 ; names ( x ) <− l e t t e r s [ 1 : 1 0 ]
b a r p l o t ( x , c o l = rev ( heat . c o l o r s ( 1 0 ) ) )
3 b a r p l o t ( x , c o l = gray ( ( 1 : 1 0 ) / 1 0 ) ) ;
101. 怎样将 R 的颜色同 RGB 对应起来？
参考函数 col2rgb()
1 w r i t e . t a b l e ( t ( c o l 2 r g b ( rainbow ( 7 ) ) / 2 5 5 ) , sep = "," )
102. 如何调整所绘图形的大小？
Windows 平台下， 正常情况打开绘图窗口， 调整窗口大小， 点击菜单直接保存， 或使用 savePlot()
函数保存； 当然也可以事先用
1 windows ( width = , h e i g h t = )
打开一个定义好大小的窗口， 然后绘图； 还可以使用 pdf() ,postscript() , png() ,jpeg() ,pictex() 等
“后台生成” 函数，


t(col2rgb(rainbow(7))/255)

1 ## s t a r t a PDF f i l e
p d f ( "picture.pdf" , h eig ht =4, width=6)
3 ## y o u r d r a w i n g c o m m a n d s h e r e
dev . o f f ( ) ### c l o s e t h e PDF f i l e
这些函数都有设置图形大小的参数； 还可以使用
dev . copy ( device , f i l e ="" , height , width )
命令。
103. 如何模拟布朗运动？
布朗运动可以用标准正态的随机模拟值的累积和来模拟：
1 # t w o d i m e n s i o n s
n <− 100
3 x <− cumsum( rnorm ( n ) )
y <− cumsum( rnorm ( n ) )
5 p l o t ( x , y , type = ’l’ )
104. 如何获得连接若干点的平滑曲线？
如果已知做出这些点的函数可以使用 curve(expr, from , to, add = T) 函数。 反之， 使用立方曲线差
值函数 spline(x , y , n= ) ， 如：
1 x <− 1 : 5
y <− c ( 1 , 3 , 4 , 2 . 5 , 2 )
3 p l o t ( x , y )
sp <− s p l i n e ( x , y , n = 50)
5 l i n e s ( sp )
105. 网格 (lattice) 绘图和普通绘图有什么区别？
网格（lattice） 绘图实际上是 S-plus 中 Trellis 绘图在 R 中的实现， 是多元数据可视化的方法。 网格
绘图相对于普通绘图来说， 是一种拥有 “固定格式” 的绘图方式， 当然它相对来说较难修改。 如果
数据分属不同的类别， 需要将这些类别下的数据进行比较， 网格绘图是很不错的选择：
1 l i b r a r y ( l a t t i c e )
histogram ( ˜ hei gh t | v o i c e . part , data = s i n g e r )
常用的 lattice 绘图函数有：

常用 lattice 绘图函数
函数 说明
xyplot(y˜x) 双变量散点图
dotplot(y˜x) Cleveland 点图 (逐行逐列累加图)
barchart(y˜x) y 对 x 的条形图
stripplot(y˜x) 一维图， x 必须是数值型， y 可以是因子
bwplot(y˜x) 箱线图
histogram(˜x) 直方图
106. 如何绘制三维图？
参考 persp() ， contour() 函数。 这里需要注意的三维绘图中第三维坐标的形式。 参考第 15 页中的
outer() 函数。
107. 想把一个数值的矩阵映射为一个颜色方格的矩阵， 什么函数？
参考 image() 和 filled.contour() 函数：
x <− y <− seq( −10, 10 , length=50)
2 f <− function (x , y) {
r <− sqrt (xˆ2 + yˆ2)
4 10 ∗ sin ( r ) / r
}
6 z <− outer (x , y , f )
image (x , y , z )
8 f i l l e d . contour (x ,y ,z )
108. 散点图中散点大小同因变量值成比例如何画？
在 R 中做这类图很简单， 因为 R 的很多绘图参数可以使用变量：
x <− 1:10
2 y <− runif (10)
symbols (x ,y , circles = y/2 , inches = F, bg = x)
109. 我想为一个数据框的每一列都做 Q–Q 图？
使用 apply() 函数作用于矩阵的行或列， 且能避免 R 中的显式循环
1 table <− data . frame (x1 = rnorm (100) ,x2 = rnorm (100 ,1 ,1))
par ( ask=TRUE) # w a i t f o r c h a n g i n g
3 results = apply ( table , 2 , qqnorm)
par ( ask=FALSE)
110. 如何在一个直方图上添加一个小的箱线图？

在直方图的空白位置添加另外的小图（像图例一样）， 仍然使用参数 par()：
x <− rnorm (100)
2 hi s t (x)
op <− par ( f i g=c ( . 0 2 , . 5 , . 5 , . 9 8 ) , new=TRUE)
4 boxplot (x)
111. 如何在 R 的绘图中加入数学公式或希腊字符？
参考?plotmath ， 熟悉 LATEX 的用户， 会发现二者语法非常类似。
x <− 1:10 ; plot (x , type = "n" )
2 text (3 ,2 , expression ( paste ( "Temperature (" , degree , "C) in 2003" ) ) )
text (4 ,4 , expression ( bar (x) == sum( frac (x [ i ] , n) , i ==1, n ) ) )
4 text (6 ,6 , expression ( hat ( beta ) == (Xˆ t ∗ X)ˆ { .1 } ∗ Xˆ t ∗ y ))
text (8 ,8 , expression ( z [ i ] == sqrt (x [ i ]ˆ2 + y [ i ] ˆ 2 ) ) )
112. 如何在条形图上显示每个 bar 的数值？
如果明白 barplot() 函数其实是由低级绘图命令 rect() 函数构造的， 那下面的例子也就不难理解了：
1 x <− 1:10 ; names (x) <− l e t t e r s [ 1 : 1 0 ]
b <− barplot (x , col = rev ( heat . colors (10)))
3 text (b , x , l a b e l s = x , pos = 3)
113. 如何绘制椭圆或双曲线？
根据函数式的基本绘图。 直角坐标系下可使用参数方程：
( x
a
) 2 + ( y
b ) 2 = 1 =⇒ x = a sin θ, y = b cos θ, 0 < θ < 2π
1 t <− seq (0 ,2 ∗ pi , length = 100)
x <− sin ( t ) # a =1
3 y <− 2 ∗ cos ( t ) # b =2
plot (x , y , type = ’l’ )
114. 在 word 里如何使用 R 生成的高质量绘图？
矢量绘图的效果是最好的， 比如 eps、 pdf， 而不是位图（png、 jpg、 tiff 等）。 在 word 里面， 可以使
用 eps， 虽然在屏幕上显示不是很好， 但打印效果却不错。
§I 统计模型
115. 有没有直接计算峰度和偏度的函数？

当然自 己写一个也费不了太多时间。 FBasics 包中提供了
skewness ( )
2 k u r t o s i s ( )
可以直接计算偏度和峰度。
116. 如何做交叉列联表？
table() 函数。 table(x) 为 x 的频数表； table(x,y) 为交叉列联表。
x <− with ( a i r q u a l i t y , table ( cut (Temp, q u a n t i l e (Temp) ) , Month ) )
2 prop . table (x , 1 )
117. 如何做线性回归模型？
线性模型是最核心的经典统计方法， 且至今仍然有广泛应用； 很多现代统计方法都是在此基础上发
展起来的。 最简单的线性回归模型为：
yi = α + βxi + ²i
其中 α 为截距项， β 为模型的斜率， ² 为误差项。
lm() 函数提供了线性回归的计算方法。
lm . swiss <− lm ( F e r t i l i t y ˜ . , data = swiss )
lm() 的结果是一个包含回归信息的列表， 它包含以下信息：
coefficients： 回归系数（矩阵）
residuals： 返回模型残差（矩阵）
fitted.values： 模型拟合值
. . . ： . . .
可以使用如下命令得到列表名称:
1 names ( lm . swiss )
summary() 和 anova() 分别返回回归模型的概要信息和方差分析表。
1 summary ( lm . swiss ) # t h e s a m e a s s u m m a r y . l m ( )
anova ( lm . swiss )
提取模型信息的类函数有很多， 其他可以参考 R-intro 中 Statistical models in R 一节。
如果处理数据的量很大， 可以使用 biglm 包中的 biglm() 函数。 这个函数可以用于 “海量” 数
据的回归模拟。
118. 如何更新模型？
参考 update() 函数：

s u m m a r y ( f0 <− lm ( F e r t i l i t y ˜ . , data = s w i s s ) )
2 f1 <− update ( f0 , . ˜ . − Examination )
summary ( f1 )
119. 如何使用逐步回归？
在 R 里， 可以使用计算逐步回归的 step()函数。 它以计算 AIC 信息统计量为准则， 选取最小的 AIC
信息统计量来达到逐步回归的目 的。
1 u t i l s : : example ( lm )
step ( lm . D9)
step 函数可使用 “both,forward,backward” 三种方法， 其默认为 “backward”。 当然你还可以参考
add1， drop1 函数。
120. R 中如何实现分位数回归 (Quantile Regression)
参考 quantreg 和 quantregForest 包
data ( engel )
2 taus <− c ( . 1 5 , . 2 5 , . 5 0 , . 7 5 , . 9 5 , . 9 9 )
rqs <− as . l i s t ( taus )
4 f o r ( i in seq ( along = taus ) ) {
rqs [ [ i ] ] <− rq ( log10 ( foodexp ) ˜ log10 ( income ) ,
6 tau = taus [ i ] , data = engel )
l i n e s ( log10 ( engel $ income ) , f i t t e d ( rqs [ [ i ] ] ) , c o l = i +1) }
8 legend ( "bottomright" , paste ( "tau = " , taus ) , i n s e t = . 0 4 ,
c o l = 2 : ( length ( taus )+1) , l t y =1)
121. 如何得到一个正态总体均值 µ 的区间估计？
很简单， t.test() 函数
1 x <− rnorm (100)
t . t e s t ( x )
122. 如何做聚类分析？
K 均值聚类 (kmeans() )：
x <− rbind ( matrix ( rnorm (100 , sd = 0 . 3 ) , ncol = 2) ,
2 matrix ( rnorm (100 , mean = 1 , sd = 0 . 3 ) , ncol = 2))
c l <− kmeans (x , 2 , 20)
4 p l o t (x , c o l = c l $ c l u s t e r , pch=3, lwd=1)
po in ts ( c l $ centers , c o l = 1 : 2 , pch = 7 , lwd=3)
6 segments ( x [ c l $ c l u s t e r ==1 ,][ ,1] , x [ c l $ c l u s t e r ==1 ,][ ,2] ,
	c l $ c e n t e r s [ 1 , 1 ] , c l $ c e n t e r s [ 1 , 2 ] )
8 segments ( x [ c l $ c l u s t e r ==2 ,][ ,1] , x [ c l $ c l u s t e r ==2 ,][ ,2] ,
c l $ c e n t e r s [ 2 , 1 ] , c l $ c e n t e r s [ 2 , 2 ] ,
10 c o l =2)
层次聚类 (hclust() )：
n <− seq (1 ,50 , by = 4)
2 ( x <− USArrests [ n , ] ) # p r i n t ( )
hc1 <− h c l u s t ( d i s t ( x ) , method = "complete" )
4 hc2 <− h c l u s t ( d i s t ( s c a l e ( x ) ) , method = "complete" )
hc3 <− h c l u s t ( d i s t ( x ) , method = "ave" )
6 layout ( matrix ( c ( 1 , 1 , 2 , 3 ) , nrow = 2 , byrow = T) )
plot ( hc1 ) ; plot ( hc2 ) ; plot ( hc3 )
聚类过程中我们可能只需要对象的分类信息， 那么使用 cutree() 函数也是不错的选择：
1 cutree ( hc , k = 1 : 3 )
当然还有专做聚类的包： cluster
1 l i b r a r y ( c l u s t e r )
c l u s p l o t ( x , pam(x , 2) $ c l u s t e r i n g )
123. 如何做主成分分析？
stats 包中的 princomp 函数。
( pc . cr <− princomp ( USArrests , cor = TRUE) )
2 plot ( pc . cr , type = "lines" # o r ” b a r p l o t ”
) # o r s c r e e p l o t
4 loadings ( pc . cr )
princomp() 中的参数 cor = TRUE 表示使用样本相关矩阵作主成分分析， 反之使用样本协方差矩
阵。 loadings() 返回因子荷载。 screeplot() 绘制碎石图。
124. 怎样做因子分析？
在 R 中， 使用factanal() 函数对矩阵进行极大似然因子分析。
example ( f a c t a n a l )
125. 如何对样本数据进行正态检验？
比较常见的方法： shapiro.test() ， ks.test()(Kolmogorov-Smirnov 检验) ， jarque.bera.test() (需要
tseries 包)。 或者参考专门用作正态检验的 normtest 包， fBasics 包中的相关函数。 这几个包（包
括基础包） 大概提供了十几种检验函数。
126. 如何做配对 t 检验？
参考 t.test() 中的 paired 参数。
1 r e q u i r e ( s t a t s )
## S t u d e n t ’ s p a i r e d t − t e s t
3 t . t e s t ( extra ˜ group , data = s l e e p , paired = TRUE)
这里需要注意的是数据的录入形式（主要区别于 SPSS）：
事实上如果你熟悉统计检验的话， 你完全可以使用
1 apropos ( "test" )
来返回所有关于 “检验” 的信息。 比如一些常用的检验：
extra group
0.7 1
-0.6 1
· · · · · ·
4.6 2
3.4 2
bartlett.test 方差齐次性检验 binom.test 二项检验
chisq.test χ2 检验 cor.test 相关性检验
fisher.test Fisher 精确检验 friedman.test Friedman 秩和检验
kruskal.test Kruskal-Wallis 秩和检验 mcnemar.test McNemar 检验
pairwise.t.test 均值的多重比较 PP.test Phillips-Perron 检验
var.test 方差比检验 wilcox.test Wilcoxon 秩和检验
尽情享用吧！
127. R 如何做结构方程模型？
参考 sem 包。
128. 多项式回归应该使用什么函数？
使用 I() ， 例如：
1 lm ( y ˜ x + I ( x ˆ2) + I ( x ˆ3))
129. 如何使用方差分析（ ANOVA）？
方差分析同线性回归模型很类似， 毕竟它们都是线性模型。 最简单实现方差分析的函数为 aov()， 通
过规定函数内公式形式来指定方差分析类型：
方差分析
aov(x ˜ a) 单因素方差分析
aov(x ˜ a + b) 没有交互作用的双因素方差分析
aov(x ˜ a + b +a:b) 有交互作用的双因素方差分析
aov(x ˜ a*b) 同上
130. 如何求解没有常数项的线性回归模型？
只需在公式中引入 0 即可：
1 r e s u l t <− lm ( smokes ˜ 0 + male + female , data=smokerdata )
131. 如何计算回归模型参数的置信区间？
参考 confint函数， glm 模型和 nls 模型可参考 MASS 包中的 confint.glm和 confint.nls函数。
1 f i t <− lm (100 /mpg ˜ disp + hp + wt + am, data=mtcars )
c o n f i n t ( f i t )
3 c o n f i n t ( f i t , "wt" )
132. logistic 回归相关函数是？
logistic 回归是关于响应变量为 0–1 定性变量的广义线性回归问题， 这里需要使用广义线性模型
glm() 函数， 且广义线性模型的分布族为二项分布。
广义线性模型中的常用分布族
分布 函数 模型
高斯（Gaussian） a E(y) = xTβ 普通线性模型
二项（Binomial） E(y) = 1+exp (exp (xTxTβ)β) Logistic 模型和概率单位（probit） 模型
泊松（Poission） E(y) = exp (xTβ) 对数线性模型
a正态（Normal）
高斯（正态） 分布族的广义线性模型事实上同线性模型是相同的， 即
1 f i t 1 <− glm ( formula , fam il y = gaussian , data )
同线性模型
1 f i t 1 <− lm ( formula , data )
得到的结论是一致的， 当然效率会差很多。
133. 如何使用正交多项式回归？
我们考虑回归方程：
yi = β0 + β1xi + β2x2i + ... + βkxki ,i = 1, 2,...,n,
当多项式的次数 k 比较大时， x,x2,...,xk 会出现线性相关问题。 故需要使用正交多项式回归来克
服这方面的缺点。 在 R 中， 使用 poly() 函数：
1 ( z <− poly ( 1 : 1 0 , 3 ) )
134. 如何求帽子矩阵？
参考 hat(),hatvalues() 函数。
135. D-W 检验在哪里？
car 包中的 durbin.watson 函数， lmtest 包中的 dwtest 函数。
1 help . search ( "Durbin-Watson" )
136. 如何求 Sp earman 等级（或 kendall） 相关系数
cor() 函数默认为求出 Person 相关系数， 修改其 method 参数即可求得 Kendall τ 和 Spearman 秩
相关系数。
1 cor ( longley , method = "spearman" )
名称 方法 用途（条件）
Pearson 线性 正态总体假定
Kendall τ 协同 非参数检验
Spearman 样本秩 非参数检验
137. 如何做 Decision Tree？
基于树型方法的模型（Tree-based model） 并不被统计学背景的研究者所熟悉， 但它在其他领域却时
常被广泛应用。 下面是 Modern Applied Statistics With S 中的例子， 需要加载 rpart 包。
1 l i b r a r y ( r p a r t )
s e t . seed (123)
3 cpus . rp <− r p a r t ( log10 ( p e r f ) ˜ . , cpus [ , 2 : 8 ] , cp = 1e −3)
p l o t ( cpus . rp , uniform = T)
5 t e x t ( cpus . rp , d i g i t s = 3)
138. 如何使用时间序列相关模型？
假设 ²t 是一组均值为 0， 方差为 σ2 的不相关的序列， 那么我们定义 q 阶滑动平均模型为
Xt =
q X0
βj²t−j
p 阶自 回归模型：
Xt =
p X1
αiXt−i + ²t
定义 ARMA(p, q) 过程为
Xt =
p X1
αiXt−i +
q X0
βj²t−j
我们将加入季节因素的 arma 模型称为 arima 模型， R 中使用 arima(x, order = c(0, 0, 0), seasonal =
list(order = c(0, 0, 0)) 对模型进行拟合：
1 r e q u i r e ( g r a p h i c s )
( f i t 1 <− arima ( p r e s i d e n t s , c ( 1 , 0 , 0 ) ) )
3 t s d i a g ( f i t 1 )


可以。 包 Rpad 提供基于同 R 的网页接口， 假设已经安装了包 Rpad ， 可以在本地查看 Rpad 的效
果：
1 l i b r a r y (Rpad)
Rpad ( ) # e n j o y i t
146. R 有类似于 SPSS 的界面么？
有！ 安装包 Rcmdr ， 加载包后， 使用命令
Commander ( )
调出可供使用的图形使用界面。 由于这个图形使用界面需要若干基础包外的其他函数， 故还需要包
car 、 effects 、 abind、 lmtest、 multcomp、 relimp、 RODBC、 rgl 的支持。
147. 怎样来计算函数运行使用时间？
使用 system.time() 。 proc.time() 可以获得 R 进程存在的时间， system.time() 通过调用两次 proc.time()
来计算函数运行的时间。
148. 在 R 中如何处理地图数据？
R 提供了 maps 和 mapdata 两个包来绘制地图， 其中 mapdata 提供了中国地图的相关信息：
1 l i b r a r y ( mapdata )
map( "china" )
不过可惜， 这种方法得到的中国地图没有重庆的行政区划， 且各省的名称都是用数字拼装而成， 不
能用 map 包中的函数像对
map( "state" )
一样进行进一步加工。
不过如果你熟悉地理数据， 那么 maptools 包将是一个不错的选择。 她可以读取、 处理空间对
象， 且提供了同 PBSmapping, spatstat, maps, RArcInfo, Stata tmap, WinBUGS, Mondrian 这类包
的封装接口。
149. Sweave 是用来做什么的？
Sweave 提供了一种为 “混排 TEX 文本和 S 编码” 生成文档的机制。 单个的 Sweave 文档中既包含
TEX 文本又包含 S 编码， 通过编译最终形成的文档包含：
• TEX 文档的编译输出；
• S 编码和（或）；
• S 编码的代码输出（文本、 图形）。
如果想了解更多， 请参考 Sweave User Manual， 或参考附录 A： Sweave 的实例。
它的文档形成过程：
Sweave 文档 −−−−−−−−→Sweave(in R) TEX文档 −−−−−−→LATEX
dvipdfmx
最终 pdf 文档
150. 如何释放 R 运行后占用的内存？
使用函数
1 gc ()
因为 R 是在内存中运算， 所以当 R 读入了体积比较大的数据后， 即使删除了相关对象， 内存空间
仍不能释放。 gc() 函数虽然主要用来报告内存使用情况， 但是一个重要的用途便是释放内存。
151. 用什么文本编辑器比较好？
比较常用的是 Tinn–R ， RWinEdt 9 ， ESS(Emacs Speaks Statistics) ， 甚至任意一款编辑器， 如
UltraEdit10， 这些都支持 R 语法的高亮显示。 如果是 Windows 桌面环境下的用户， 对这些不是很
了解， 记事本也不失为一种选择。



ovid <- Corpus(DirSource(txt),readerControl = list(language = "lat")))


fileName <- system.file("exampleData", "include.xml", package="XML")
root <- xmlParse(fileName)
test <- getNodeSet(root, '//para')
sapply(test, xmlValue)
vdata <- sapply(test, xmlValue)


doc <- xmlParse(system.file("exampleData", "tagnames.xml", package = "XML"))
els <- getNodeSet(doc, "/doc//a[@status]")
sapply(els, function(el) xmlGetAttr(el, "status"))


字符集转化
如果处理的是中文字符，可能还会遇到字符编码转换的问题，可以使用 iconv 处理：
iconv(x, from = "", to = "", sub = NA, mark = TRUE, toRaw = FALSE)

R package
library( roxygen2)
library( testthat)
devtools::session_info( )
.libPaths( )
lapply(.libPaths( ) , dir)

devtools: : load_all( )


install. packages( "formatR")
formatR: : tidy_dir( "R")

install. packages( "lintr")
lintr: : lint_package( )

R.version

install.packages('RMySQL')
install.packages('DMwR')

find(lowess)
apropos(lm)
[1]
[4]
[7]
[10]
[13]
[16]
[19]
[22]
[25]
[28]
[31]
[34]
". __C__anova.glm"
". __C__glm.null"
"anova.glm"
"anova.lmlist"
"contr.helmert"
"glm.fit"
"KalmanForecast"
"KalmanSmooth"
"lm.fit.null"
"lm.wfit.null"
"model.matrix.lm"
"plot.lm"
". __C__anova.glm.null"
". __C__lm"
"anova.glmlist"
"anova.mlm"
"glm"
"glm.fit.null"
"KalmanLike"
"lm"
"lm.influence"
"model.frame.glm"
"nlm"
"plot.mlm"
". __C__glm"
". __C__mlm"
"anova.lm"
"anovalist.lm"
"glm.control"
"hatvalues.lm"
"KalmanRun"
"lm.fit"
"lm.wfit"
"model.frame.lm"
"nlminb"
"predict.glm"

http://cran.r-project.org/


example(lm)
demo(persp)
demo(graphics)
demo(Hershey)i
demo(plotmath)
lattice
MASS
mgcv
nlme
nnet
spatial
survival
lattice graphics for panel plots or trellis graphs
package associated with Venables and Ripley’s book entitled Modern Applied
Statistics using S-PLUS
generalized additive models
mixed-effects models (both linear and non-linear)
feed-forward neural networks and multinomial log-linear models
functions for kriging and point pattern analysis
survival analysis, including penalised likelihood


library(help=spatial)

followed by a list of all the functions and data sets. You can view the full list of the contents
of a library using objects with search() like this. Here are the contents of the spatial
library:
objects(grep("spatial",search()))
[1]
[5]
[9]
[13]
"anova.trls"
"gaucov"
"plot.trls"
"ppregion"
"anovalist.trls"
"Kaver"
"ppgetregion"
"predict.trls"
"correlogram"
"Kenvl"
"ppinit"
"prmat"
"expcov"
"Kfn"
"pplik"
"Psim"


objects(grep("base",search()))

install.packages("akima")
install.packages("chron")
install.packages("Ime4")
install.packages("mcmc")
install.packages("odesolve")
install.packages("spdep")
install.packages("spatstat")
install.packages("tree")

gg<-read.table("c:\\temp\\Gain.txt",header=T)
attach(gg)
names(gg)

model<-lm(Weight~Age+Sex)
summary(model)
options(show.signif.stars=FALSE)
summary(model)

objects()
search()

search()
searchpaths()
(.packages())               # maybe just "base"
.packages(all.available = TRUE)

2+3; 5*7; 3-7

log(x)
exp(x)
log(x,n)
log10(x)
sqrt(x)
factorial(x)
choose(n,x)
gamma(x)
lgamma(x)
floor(x)
ceiling(x)
trunc(x) log to base e of x
antilog of x e x 
log to base n of x
log to base 10 of x
square root of x
x!
binomial coefficients n!/(x! n − x!)
x, for real x x − 1!, for integer x
natural log of x
greatest integer < x
smallest integer > x
closest integer to x between x and 0 trunc(1.5) = 1, trunc(-1.5)
= −1 trunc is like floor for positive values and like ceiling for
negative values
round the value of x to an integer
give x to 6 digits in scientific notation
generates n random numbers between 0 and 1 from a uniform
distribution
cosine of x in radians
sine of x in radians
tangent of x in radians
inverse trigonometric transformations of real or complex numbers
inverse hyperbolic trigonometric transformations of real or
complex numbers
the absolute value of x, ignoring the minus sign if there is one

round(x, digits=0)
signif(x, digits=6)
runif(n)
cos(x)
sin(x)
tan(x)
acos(x), asin(x), atan(x)
acosh(x), asinh(x), atanh(x)
abs(x)
119 %/% 13

floor(5.7)
ceiling(5.7)

rounded<-function(x) floor(x+0.5)
Now we can use the new function:
rounded(5.7)
[1] 6
rounded(5.4)


3/0
[1] Inf
-12/0
[1] -Inf
Calculations involving infinity can be evaluated: for instance,
exp(-Inf)
[1] 0
0/Inf
[1] 0
(0:3)^Inf
[1] 0 1 Inf Inf
Other calculations, however, lead to quantities that are not numbers. These are represented
in R by NaN (‘not a number’). Here are some of the classic cases:
0/0
[1] NaN
Inf-Inf
[1] NaN
Inf/Inf
[1] NaN


You need to understand clearly the distinction between NaN and NA (this stands for
‘not available’ and is the missing-value symbol in R; see below). The function is.nan is
provided to check specifically for NaN, and is.na also returns TRUE for NaN. Coercing
NaN to logical or integer type gives an NA of the appropriate type. There are built-in tests
to check whether a number is finite or infinite:
is.finite(10)
[1] TRUE
is.infinite(10)
[1] FALSE
is.infinite(Inf)
[1] TRUE


x<-c(1:8,NA)
mean(x)
[1] NA
In order to calculate the mean of the non-missing values, you need to specify that the
NA are to be removed, using the na.rm=TRUE argument:
mean(x,na.rm=T)
[1] 4.5

vmv<-c(1:6,NA,NA,9:12)
vmv
[1] 1 2 3 4 5 6 NA NA 9 10 11 12
Making an index of the missing values in an array could use the seq function,
seq(along=vmv)[is.na(vmv)]
[1] 7 8

but the result is achieved more simply using which like this:
which(is.na(vmv))
[1] 7 8
If the missing values are genuine counts of zero, you might want to edit the NA to 0.
Use the is.na function to generate subscripts for this
vmv[is.na(vmv)]<- 0
vmv
[1] 1 2 3 4 5 6 0 0 9 10 11 12
or use the ifelse function like this
vmv<-c(1:6,NA,NA,9:12)
ifelse(is.na(vmv),0,vmv)
[1] 1 2 3 4 5 6 0 0 9 10 11 12


+ - */%% ^ arithmetic
> >= < <= == != relational
! &  logical
~ model formulae
<- -> assignment
$ list indexing (the ‘element name’ operator)
: create a sequence

Named Elements within Vectors
(counts<-c(25,12,7,4,6,2,1,0,2))
names(counts)<-0:8


If you have computed a table of counts, and you want to remove the names, then use the
as.vector function like this:
(st<-table(rpois(2000,2.3)))
0 1 2 3 4 5 6 7 8 9
205 455 510 431 233 102 43 13 7 1
as.vector(st)
[1] 205 455 510 431 233 102 43 13 7 1



max(x) maximum value in x
min(x) minimum value in x
sum(x) total of all the values in x
mean(x) arithmetic average of the values in x
median(x) median value in x
range(x) vector of minx and maxx
var(x) sample variance of x
cor(x,y) correlation between vectors x and y
sort(x) a sorted version of x
rank(x) vector of the ranks of the values in x
order(x) an integer vector containing the permutation to sort x into ascending order
quantile(x) vector containing the minimum, lower quartile, median, upper quartile, and
maximum of x
cumsum(x) vector containing the sum of all of the elements up to that point
cumprod(x) vector containing the product of all of the elements up to that point
cummax(x) vector of non-decreasing numbers which are the cumulative maxima of the
values in x up to that point
cummin(x) vector of non-increasing numbers which are the cumulative minima of the
values in x up to that point
pmax(x,y,z) vector, of length equal to the longest of x y or z, containing the maximum
of x y or z for the ith position in each

pmin(x,y,z) vector, of length equal to the longest of x y or z, containing the minimum
of x y or z for the ith position in each
colMeans(x) column means of dataframe or matrix x
colSums(x) column totals of dataframe or matrix x
rowMeans(x) row means of dataframe or matrix x
rowSums(x) row totals of dataframe or matrix x


Suppose we want the mean growth rate for each detergent:
tapply(Growth.rate,Detergent,mean)
BrandA BrandB BrandC BrandD
3.88 4.01 3.95 3.56

To produce a two-dimensional table we put the two grouping variables in a list. Here we
calculate the median growth rate for water type and daphnia clone:
tapply(Growth.rate,list(Water,Daphnia),median)
Clone1 Clone2 Clone3
Tyne 2.87 3.91 4.62
Wear 2.59 5.53 4.30



Using with rather than attach
with(data, function(    ))
The with function evaluates an R expression in an environment constructed from data.
You will often use the with function other functions like tapply or plot which have no
built-in data argument. If your dataframe is part of the built-in package called datasets
(like OrchardSprays) you can refer to the dataframe directly by name:
with(OrchardSprays,boxplot(decrease~treatment))
Here we calculate the number of ‘no’ (not infected) cases in the bacteria dataframe which
is part of the MASS library:
library(MASS)
with(bacteria,tapply((y=="n"),trt,sum))
placebo drug drug+
12 18 13
and here we plot brain weight against body weight for mammals on log-log axes:
with(mammals,plot(body,brain,log="xy"))
without attaching either dataframe. Here is an unattached dataframe called reg.data:
reg.data<-read.table("c:\\temp\\regression.txt",header=T)
with which we carry out a linear regression and print a summary
with (reg.data, {
model<-lm(growth~tannin)
summary(model) } )
The linear model fitting function lm knows to look in reg.data to find the variables
called growth and tannin because the with function has used reg.data for constructing the
environment from which lm is called. Groups of statements (different lines of code) to
which the with function applies are contained within curly brackets. An alternative is to
define the data environment as an argument in the call to lm like this:
summary(lm(growth~tannin,data=reg.data))
You should compare these outputs with the same example using attach on p. 388. Note that
whatever form you choose, you still need to get the dataframe into your current environment
by using read.table (if, as here, it is to be read from an external file), or from a library
(like MASS to get bacteria and mammals, as above). To see the names of the dataframes
in the built-in package called datasets, type
data()
but to see all available data sets (including those in the installed packages), type
data(package = .packages(all.available = TRUE))



x
[1] 0.99822644 0.98204599 0.20206455 0.65995552 0.93456667 0.18836278
y
[1] 0.51827913 0.30125005 0.41676059 0.53641449 0.07878714 0.49959328
z
[1] 0.26591817 0.13271847 0.44062782 0.65120395 0.03183403 0.36938092
pmin(x,y,z)
[1] 0.26591817 0.13271847 0.20206455 0.53641449 0.03183403 0.18836278
so the first and second minima came from z, the third from x, the fourth from y, the fifth
from z, and the sixth from x. The functions min and max produce scalar results.

Subscripts and Indices
While we typically aim to apply functions to vectors as a whole, there are circumstances
where we want to select only some of the elements of a vector. This selection is done using
subscripts (also known as indices). Subscripts have square brackets [2] while functions
have round brackets (2). Subscripts on vectors, matrices, arrays and dataframes have one
set of square brackets [6], [3,4] or [2,3,2,1] while subscripts on lists have double square
brackets [[2]] or [[i,j]] (see p. 65). When there are two subscripts to an object like a matrix
or a dataframe, the first subscript refers to the row number (the rows are defined as margin
no. 1) and the second subscript refers to the column number (the columns are margin no.
2). There is an important and powerful convention in R such that when a subscript appears
as a blank it is understood to mean ‘all of’. Thus

• [,4] means all rows in column 4 of an object
• [2,] means all columns in row 2 of an object.
There is another indexing convention in R which is used to extract named components from
objects using the $ operator like this: model$coef or model$resid (p. 363). This is known
as ‘indexing tagged lists’ using the element names operator $.

Working with Vectors and Logical Subscripts
Take the example of a vector containing the 11 numbers 0 to 10:
x<-0:10
There are two quite different kinds of things we might want to do with this. We might want
to add up the values of the elements:
sum(x)
[1] 55
Alternatively, we might want to count the elements that passed some logical criterion.
Suppose we wanted to know how many of the values were less than 5:
sum(x<5)
[1] 5
You see the distinction. We use the vector function sum in both cases. But sum(x) adds
up the values of the xs and sum(x<5) counts up the number of cases that pass the logical
condition ‘x is less than 5’. This works because of coercion (p. 25). Logical TRUE has
been coerced to numeric 1 and logical FALSE has been coerced to numeric 0.
That is all well and good, but how do you add up the values of just some of the elements
of x? We specify a logical condition, but we don’t want to count the number of cases that
pass the condition, we want to add up all the values of the cases that pass. This is the final
piece of the jigsaw, and involves the use of logical subscripts. Note that when we counted
the number of cases, the counting was applied to the entire vector, using sum(x<5). To
find the sum of the values of x that are less than 5, we write:
sum(x[x<5])
[1] 10
Let’s look at this in more detail. The logical condition x<5 is either true or false:
x<5
[1] TRUE TRUE TRUE TRUE TRUE FALSE FALSE FALSE FALSE
[10] FALSE FALSE
You can imagine false as being numeric 0 and true as being numeric 1. Then the vector of
subscripts [x<5] is five 1s followed by six 0s:
1*(x<5)
[1] 1 1 1 1 1 0 0 0 0 0 0

Now imagine multiplying the values of x by the values of the logical vector
x*(x<5)
[1] 0 1 2 3 4 0 0 0 0 0 0
When the function sum is applied, it gives us the answer we want: the sum of the values
of the numbers 0 + 1 + 2 + 3 + 4 = 10.
sum(x*(x<5))
[1] 10
This produces the same answer as sum(x[x<5]), but is rather less elegant.
Suppose we want to work out the sum of the three largest values in a vector. There are
two steps: first sort the vector into descending order. Then add up the values of the first
three elements of the sorted array. Let’s do this in stages. First, the values of y:
y<-c(8,3,5,7,6,6,8,9,2,3,9,4,10,4,11)
Now if you apply sort to this, the numbers will be in ascending sequence, and this makes
life slightly harder for the present problem:
sort(y)
[1] 2 3 3 4 4 5 6 6 7 8 8 9 9 10 11
We can use the reverse function, rev like this (use the Up arrow key to save typing):
rev(sort(y))
[1] 11 10 9 9 8 8 7 6 6 5 4 4 3 3 2
So the answer to our problem is 11 + 10 + 9 = 30. But how to compute this? We can use
specific subscripts to discover the contents of any element of a vector. We can see that 10
is the second element of the sorted array. To compute this we just specify the subscript [2]:
rev(sort(y))[2]
[1] 10
A range of subscripts is simply a series generated using the colon operator. We want the
subscripts 1 to 3, so this is:
rev(sort(y))[1:3]
[1] 11 10 9
So the answer to the exercise is just
sum(rev(sort(y))[1:3])
[1] 30
Note that we have not changed the vector y in any way, nor have we created any new
space-consuming vectors during intermediate computational steps.

Addresses within Vectors
There are two important functions for finding addresses within arrays. The function which
is very easy to understand. The vector y (see above) looks like this:
y
[1] 8 3 5 7 6 6 8 9 2 3 9 4 10 4 11
Suppose we wanted to know which elements of y contained values bigger than 5. We type
which(y>5)
[1] 1 4 5 6 7 8 11 13 15
Notice that the answer to this enquiry is a set of subscripts. We don’t use subscripts inside
the which function itself. The function is applied to the whole array. To see the values of
y that are larger than 5, we just type
y[y>5]
[1] 8 7 6 6 8 9 9 10 11
Note that this is a shorter vector than y itself, because values of 5 or less have been left out:
length(y)
[1] 15
length(y[y>5])
[1] 9
To extract every nth element from a long vector we can use seq as an index. In this case
I want every 25th value in a 1000-long vector of normal random numbers with mean value
100 and standard deviation 10:
xv<-rnorm(1000,100,10)
xv[seq(25,length(xv),25)]
[1] 100.98176 91.69614 116.69185 97.89538 108.48568 100.32891 94.46233
[8] 118.05943 92.41213 100.01887 112.41775 106.14260 93.79951 105.74173
[15] 102.84938 88.56408 114.52787 87.64789 112.71475 106.89868 109.80862
[22] 93.20438 96.31240 85.96460 105.77331 97.54514 92.01761 97.78516
[29] 87.90883 96.72253 94.86647 90.87149 80.01337 97.98327 92.77398
[36] 121.47810 92.40182 87.65205 115.80945 87.60231
Finding Closest Values
Finding the value in a vector that is closest to a specified value is straightforward using
which. Here, we want to find the value of xv that is closest to 108.0:
which(abs(xv-108)==min(abs(xv-108)))
[1] 332
The closest value to 108.0 is in location 332. But just how close to 108.0 is this 332nd
value? We use 332 as a subscript on xv to find this out

xv[332]
[1] 108.0076
Thus, we can write a function to return the closest value to a specified value sv
closest<-function(xv,sv){
xv[which(abs(xv-sv)==min(abs(xv-sv)))] }
and run it like this:
closest(xv,108)
[1] 108.0076
Trimming Vectors Using Negative Subscripts
Individual subscripts are referred to in square brackets. So if x is like this:
x<- c(5,8,6,7,1,5,3)
we can find the 4th element of the vector just by typing
x[4]
[1] 7
An extremely useful facility is to use negative subscripts to drop terms from a vector.
Suppose we wanted a new vector, z, to contain everything but the first element of x
z <- x[-1]
z
[1] 8 6 7 1 5 3
Suppose our task is to calculate a trimmed mean of x which ignores both the smallest
and largest values (i.e. we want to leave out the 1 and the 8 in this example). There are two
steps to this. First, we sort the vector x. Then we remove the first element using x[-1] and
the last using x[-length(x)]. We can do both drops at the same time by concatenating both
instructions like this: -c(1,length(x)). Then we use the built-in function mean:
trim.mean <- function (x) mean(sort(x)[-c(1,length(x))])
Now try it out. The answer should be mean(c(5,6,7,5,3)) = 26/5 = 5.2:
trim.mean(x)
[1] 5.2
Suppose now that we need to produce a vector containing the numbers 1 to 50 but
omitting all the multiples of seven (7, 14, 21, etc.). First make a vector of all the numbers
1 to 50 including the multiples of 7:
vec<-1:50
Now work out how many numbers there are between 1 and 50 that are multiples of 7
Logical Arithmetic
Arithmetic involving logical expressions is very useful in programming and in selection of
variables. If logical arithmetic is unfamiliar to you, then persevere with it, because it will
become clear how useful it is, once the penny has dropped. The key thing to understand
is that logical expressions evaluate to either true or false (represented in R by TRUE or
FALSE), and that R can coerce TRUE or FALSE into numerical values: 1 for TRUE and
0 for FALSE. Suppose that x is a sequence from 0 to 6 like this:
x<-0:6
Now we can ask questions about the contents of the vector called x. Is x less than 4?
x<4
[1] TRUE TRUE TRUE TRUE FALSE FALSE FALSE
The answer is yes for the first four values (0, 1, 2 and 3) and no for the last three (4, 5 and
6). Two important logical functions are all and any. They check an entire vector but return
a single logical value: TRUE or FALSE. Are all the x values bigger than 0?
all(x>0)
[1] FALSE
No. The first x value is a zero. Are any of the x values negative?
any(x<0)
[1] FALSE
No. The smallest x value is a zero. We can use the answers of logical functions in arithmetic.
We can count the true values of (x<4), using sum

sum(x<4)
[1] 4
or we can multiply (x<4) by other vectors
(x<4)*runif(7)
[1] 0.9433433 0.9382651 0.6248691 0.9786844 0.0000000 0.0000000
0.0000000
Logical arithmetic is particularly useful in generating simplified factor levels during
statistical modelling. Suppose we want to reduce a five-level factor called treatment to a
three-level factor called t2 by lumping together the levels a and e (new factor level 1) and
c and d (new factor level 3) while leaving b distinct (with new factor level 2):
(treatment<-letters[1:5])
[1] "a" "b" "c" "d" "e"
(t2<-factor(1+(treatment=="b")+2*(treatment=="c")+2*(treatment=="d")))
[1] 1 2 3 3 1
Levels: 1 2 3
The new factor t2 gets a value 1 as default for all the factors levels, and we want to
leave this as it is for levels a and e. Thus, we do not add anything to the 1 if the old
factor level is a or e. For old factor level b, however, we want the result that t2 = 2 so
we add 1 (treatment=="b") to the original 1 to get the answer we require. This works
because the logical expression evaluates to 1 (TRUE) for every case in which the old
factor level is b and to 0 (FALSE) in all other cases. For old factor levels c and d we
want the result that t2 = 3 so we add 2 to the baseline value of 1 if the original factor
level is either c (2*(treatment=="c")) or d (2*(treatment=="d")). You may need to read
this several times before the penny drops. Note that ‘logical equals’ is a double = sign
without a space between the two equals signs. You need to understand the distinction
between:
x <- y x is assigned the value of y ( x gets the values of y);
x = y in a function or a list x is set to y unless you specify otherwise;
x == y produces TRUE if x is exactly equal to y and FALSE otherwise.


x <- c(NA, FALSE, TRUE)
names(x) <- as.character(x)

Symbol Meaning
! logical NOT
& logical AND
| logical OR
< less than
<= less than or equal to
> greater than
>= greater than or equal to
== logical equals (double =)
!= not equal
&& AND with IF
|| OR with IF
xor(x,y) exclusive OR
isTRUE(x) an abbreviation of identical(TRUE,x)

To see the logical combinations of & (logical AND) we can use the outer function with x
to evaluate all nine combinations of NA, FALSE and TRUE like this:
outer(x, x, "&")
<NA> FALSE TRUE
<NA> NA FALSE NA
FALSE FALSE FALSE FALSE
TRUE NA FALSE TRUE
Only TRUE & TRUE evaluates to TRUE. Note the behaviour of NA & NA and NA &
TRUE. Where one of the two components is NA, the result will be NA if the outcome is
ambiguous. Thus, NA & TRUE evaluates to NA, but NA & FALSE evaluates to FALSE.
To see the logical combinations of  (logical OR) write
outer(x, x, "|")
<NA> FALSE TRUE
<NA> NA NA TRUE
FALSE NA FALSE TRUE
TRUE TRUE TRUE TRUE
Only FALSE | FALSE evaluates to FALSE. Note the behaviour of NA | NA and NA
| FALSE.

rep(9,5)
[1] 9 9 9 9 9
You can see the issues involved by a comparison of these three increasingly complicated
uses of the rep function:
rep(1:4, 2)
[1] 1 2 3 4 1 2 3 4
rep(1:4, each = 2)
[1] 1 1 2 2 3 3 4 4
rep(1:4, each = 2, times = 3)
[1] 1 1 2 2 3 3 4 4 1 1 2 2 3 3 4 4 1 1 2 2 3 3 4 4
In the simplest case, the entire first argument is repeated (i.e. the sequence 1 to 4 is repeated
twice). You often want each element of the sequence to be repeated, and this is accomplished
with the each argument. Finally, you might want each number repeated and the whole
series repeated a certain number of times (here 3 times).
When each element of the series is to be repeated a different number of times, then the
second argument must be a vector of the same length as the vector comprising the first
argument (length 4 in this example). So if we want one 1, two 2s, three 3s and four 4s we
would write:
rep(1:4,1:4)
[1] 1 2 2 3 3 3 4 4 4 4
In the most complex case, there is a different but irregular repeat of each of the elements
of the first argument. Suppose that we need four 1s, one 2, four 3s and two 4s. Then we
use the concatenation function c to create a vector of length 4 c(4,1,4,2)) which will act as
the second argument to the rep function:
rep(1:4,c(4,1,4,2))
[1] 1 1 1 1 2 3 3 3 3 4 4

Generate Factor Levels
The function gl (‘generate levels’) is useful when you want to encode long vectors of factor
levels: the syntax for the three arguments is this:
gl(‘up to’, ‘with repeats of’, ‘to total length’)
Here is the simplest case where we want factor levels up to 4 with repeats of 3 repeated
only once (i.e. to total length = 12):
gl(4,3)
[1] 1 1 1 2 2 2 3 3 3 4 4 4
Levels: 1 2 3 4
Here is the function when we want that whole pattern repeated twice:
gl(4,3,24)
[1] 1 1 1 2 2 2 3 3 3 4 4 4 1 1 1 2 2 2 3 3 3 4 4 4
Levels: 1 2 3 4

If the total length is not a multiple of the length of the pattern, the vector is truncated:
gl(4,3,20)
[1] 1 1 1 2 2 2 3 3 3 4 4 4 1 1 1 2 2 2 3 3
Levels: 1 2 3 4
If you want text for the factor levels, rather than numbers, use labels like this:
gl(3,2,24,labels=c("A","B","C"))
[1] A A B B C C A A B B C C A A B B C C A A B B C C
Levels: A B C
Generating Regular Sequences of Numbers
For regularly spaced sequences, often involving integers, it is simplest to use the colon
operator. This can produce ascending or descending sequences:
10:18
[1] 10 11 12 13 14 15 16 17 18
18:10
[1] 18 17 16 15 14 13 12 11 10
-0.5:8.5
[1] -0.5 0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5
When the interval is not 1.0 you need to use the seq function. In general, the three arguments
to seq are: initial value, final value, and increment (or decrement for a declining sequence).
Here we want to go from 0 up to 1.5 in steps of 0.2:
seq(0,1.5,0.2)
[1] 0.0 0.2 0.4 0.6 0.8 1.0 1.2 1.4
Note that seq stops before it gets to the second argument (1.5) if the increment does not
match exactly (our sequence stops at 1.4). If you want to seq downwards, the third argument
needs to be negative
seq(1.5,0,-0.2)
[1] 1.5 1.3 1.1 0.9 0.7 0.5 0.3 0.1
Again, zero did not match the decrement, so was excluded and the sequence stopped at 0.1.
Non-integer increments are particularly useful for generating x values for plotting smooth
curves. A curve will look reasonably smooth if it is drawn with 100 straight line segments,
so to generate 100 values of x between min(x) and max(x) you could write
x.values<-seq(min(x),max(x),(max(x)-min(x))/100)
If you want to create a sequence of the same length as an existing vector, then use along
like this. Suppose that our existing vector, x, contains 18 random numbers from a normal
distribution with a mean of 10.0 and a standard deviation of 2.0:

x<-rnorm(18,10,2)
and we want to generate a sequence of the same length as this (18) starting at 88 and
stepping down to exactly 50 for x[18]
seq(88,50,along=x)
[1] 88.00000 85.76471 83.52941 81.29412 79.05882 76.82353
74.58824 72.35294
[9] 70.11765 67.88235 65.64706 63.41176 61.17647 58.94118
56.70588 54.47059
[17] 52.23529 50.00000
This is useful when you do not want to go to the trouble of working out the size of the
increment but you do know the starting value (88 in this case) and the final value (50). If
the vector is of length 18 then the sequence will involve 17 decrements of size:
(50-88)/17
[1] -2.235294
The function sequence (spelled out in full) is slightly different, because it can produce
a vector consisting of sequences
sequence(5)
[1] 1 2 3 4 5
sequence(5:1)
[1] 1 2 3 4 5 1 2 3 4 1 2 3 1 2 1
sequence(c(5,2,4))
[1] 1 2 3 4 5 1 2 1 2 3 4
If the argument to sequence is itself a sequence (like 5:1) then several sequences are
concatenated (in this case a sequence of 1 to 5 is followed by a sequence of 1 to 4 followed
by a sequence of 1 to 3, another of 1 to 2 and a final sequence of 1 to 1 (= 1). The
successive sequences need not be regular; the last example shows sequences to 5, then to
2, then to 4.

houses<-read.table("c:\\temp \\houses.txt",header=T)
attach(houses)
names(houses)
[1] "Location" "Price"
Now we apply the three different functions to the vector called Price,
ranks<-rank(Price)
sorted<-sort(Price)
ordered<-order(Price)
and make a dataframe out of the four vectors like this:
view<-data.frame(Price,ranks,sorted,ordered)
view
Price ranks sorted ordered
1 325 12.0 95 9
2 201 10.0 101 6
3 157 5.0 117 10
4 162 6.0 121 12
5 164 7.0 157 3
6 101 2.0 162 4
7 211 11.0 164 5
8 188 8.5 188 8
9 95 1.0 188 11
10 117 3.0 201 2
11 188 8.5 211 7
12 121 4.0 325 1
Rank
The prices themselves are in no particular sequence. The ranks column contains the value
that is the rank of the particular data point (value of Price), where 1 is assigned to the
lowest data point and length(Price) – here 12 – is assigned to the highest data point. So the
first element, Price = 325, is the highest value in Price. You should check that there are 11
values smaller than 325 in the vector called Price. Fractional ranks indicate ties. There are
two 188s in Price and their ranks are 8 and 9. Because they are tied, each gets the average
of their two ranks 8 + 9/2 = 85.
Sort
The sorted vector is very straightforward. It contains the values of Price sorted into ascending
order. If you want to sort into descending order, use the reverse order function rev like
this: y<-rev(sort(x)). Note that sort is potentially very dangerous, because it uncouples
values that might need to be in the same row of the dataframe (e.g. because they are the
explanatory variables associated with a particular value of the response variable). It is bad
practice, therefore, to write x<-sort(x), not least because there is no ‘unsort’ function.
Order
This is the most important of the three functions, and much the hardest to understand on
first acquaintance. The order function returns an integer vector containing the permutation

that will sort the input into ascending order. You will need to think about this one. The
lowest value of Price is 95. Look at the dataframe and ask yourself what is the subscript in
the original vector called Price where 95 occurred. Scanning down the column, you find it
in row number 9. This is the first value in ordered, ordered[1]. Where is the next smallest
value (101) to be found within Price? It is in position 6, so this is ordered[2]. The third
smallest Price (117) is in position 10, so this is ordered[3]. And so on.
This function is particularly useful in sorting dataframes, as explained on p. 113. Using
order with subscripts is a much safer option than using sort, because with sort the values
of the response variable and the explanatory variables could be uncoupled with potentially
disastrous results if this is not realized at the time that modelling was carried out. The
beauty of order is that we can use order(Price) as a subscript for Location to obtain the
price-ranked list of locations:
Location[order(Price)]
[1] Reading Staines Winkfield Newbury
[5] Bracknell Camberley Bagshot Maidenhead
[9] Warfield Sunninghill Windsor Ascot
When you see it used like this, you can see exactly why the function is called order. If you
want to reverse the order, just use the rev function like this:
Location[rev(order(Price))]
[1] Ascot Windsor Sunninghill Warfield
[5] Maidenhead Bagshot Camberley Bracknell
[9] Newbury Winkfield Staines Reading
The sample Function
This function shuffles the contents of a vector into a random sequence while maintaining all
the numerical values intact. It is extremely useful for randomization in experimental design,
in simulation and in computationally intensive hypothesis testing. Here is the original y
vector again:
y
[1] 8 3 5 7 6 6 8 9 2 3 9 4 10 4 11
and here are two samples of y:
sample(y)
[1] 8 8 9 9 2 10 6 7 3 11 5 4 6 3 4
sample(y)
[1] 9 3 9 8 8 6 5 11 4 6 4 7 3 2 10
The order of the values is different each time that sample is invoked, but the same numbers
are shuffled in every case. This is called sampling without replacement. You can specify
the size of the sample you want as an optional second argument:
sample(y,5)
[1] 9 4 10 8 11
sample(y,5)
[1] 9 3 4 2 8
The option replace=T allows for sampling with replacement, which is the basis of boot
strapping (see p. 320). The vector produced by the sample function with replace=T is the
same length as the vector sampled, but some values are left out at random and other values,
again at random, appear two or more times. In this sample, 10 has been left out, and there
are now three 9s:
sample(y,replace=T)
[1] 9 6 11 2 9 4 6 8 8 4 4 4 3 9 3
In this next case, the are two 10s and only one 9:
sample(y,replace=T)
[1] 3 7 10 6 8 2 5 11 4 6 3 9 10 7 4
More advanced options in sample include specifying different probabilities with which
each element is to be sampled (prob=). For example, if we want to take four numbers at
random from the sequence 1:10 without replacement where the probability of selection (p)
is 5 times greater for the middle numbers (5 and 6) than for the first or last numbers, and
we want to do this five times, we could write
p <- c(1, 2, 3, 4, 5, 5, 4, 3, 2, 1)
x<-1:10
sapply(1:5,function(i) sample(x,4,prob=p))
[,1] [,2] [,3] [,4] [,5]
[ 1 , ] 8 7 4 1 0 8
[ 2 , ] 7 5 7 8 7
[ 3 , ] 4 4 3 4 5
[4,] 9 10 8 7 6
so the four random numbers in the first trial were 8, 7, 4 and 9 (i.e. column 1).
Matrices
There are several ways of making a matrix. You can create one directly like this:
X<-matrix(c(1,0,0,0,1,0,0,0,1),nrow=3)
X
[,1] [,2] [,3]
[1,] 1 0 0
[2,] 0 1 0
[3,] 0 0 1

where, by default, the numbers are entered columnwise. The class and attributes of X
indicate that it is a matrix of three rows and three columns (these are its dim attributes)
class(X)
[1] "matrix"
attributes(X)
$dim
[1] 3 3
In the next example, the data in the vector appear row-wise, so we indicate this with
byrow=T:
vector<-c(1,2,3,4,4,3,2,1)
V<-matrix(vector,byrow=T,nrow=2)
V
[,1] [,2] [,3] [,4]
[ 1 , ] 1 2 3 4
[ 2 , ] 4 3 2 1
Another way to convert a vector into a matrix is by providing the vector object with two
dimensions (rows and columns) using the dim function like this:
dim(vector)<-c(4,2)
We can check that vector has now become a matrix:
is.matrix(vector)
[1] TRUE
We need to be careful, however, because we have made no allowance at this stage for the
fact that the data were entered row-wise into vector:
vector
[,1] [,2]
[1,] 1 4
[2,] 2 3
[3,] 3 2
[4,] 4 1
The matrix we want is the transpose, t, of this matrix:
(vector<-t(vector))
[,1] [,2] [,3] [,4]
[ 1 , ] 1 2 3 4
[ 2 , ] 4 3 2 1
Naming the rows and columns of matrices
At first, matrices have numbers naming their rows and columns (see above). Here is a 4 × 5
matrix of random integers from a Poisson distribution with mean = 1.5:

X<-matrix(rpois(20,1.5),nrow=4)
X
[,1] [,2] [,3] [,4] [,5]
[ 1 , ] 1 0 2 5 3
[ 2 , ] 1 1 3 1 3
[ 3 , ] 3 1 0 2 2
[ 4 , ] 1 0 2 1 0
Suppose that the rows refer to four different trials and we want to label the rows ‘Trial.1’
etc. We employ the function rownames to do this. We could use the paste function (see
p. 44) but here we take advantage of the prefix option:
rownames(X)<-rownames(X,do.NULL=FALSE,prefix="Trial.")
X
[,1] [,2] [,3] [,4] [,5]
Trial. 1 1 0 2 5 3
Trial. 2 1 1 3 1 3
Trial. 3 3 1 0 2 2
Trial. 4 1 0 2 1 0
For the columns we want to supply a vector of different names for the five drugs involved
in the trial, and use this to specify the colnames(X):
drug.names<-c("aspirin", "paracetamol", "nurofen", "hedex", "placebo")
colnames(X)<-drug.names
X
aspirin paracetamol nurofen hedex placebo
Trial.1 1 0 2 5 3
Trial.2 1 1 3 1 3
Trial.3 3 1 0 2 2
Trial.4 1 0 2 1 0
Alternatively, you can use the dimnames function to give names to the rows and/or
columns of a matrix. In this example we want the rows to be unlabelled (NULL) and the
column names to be of the form ‘drug.1’, ‘drug.2’, etc. The argument to dimnames has to
be a list (rows first, columns second, as usual) with the elements of the list of exactly the
correct lengths (4 and 5 in this particular case):
dimnames(X)<-list(NULL,paste("drug.",1:5,sep=""))
X
drug.1 drug.2 drug.3 drug.4 drug.5
[1,] 1 0 2 5 3
[2,] 1 1 3 1 3
[3,] 3 1 0 2 2
[4,] 1 0 2 1 0
Calculations on rows or columns of the matrix
We could use subscripts to select parts of the matrix, with a blank meaning ‘all of the rows’
or ‘all of the columns’. Here is the mean of the rightmost column (number 5),

mean(X[,5])
[1] 2
calculated over all the rows (blank then comma), and the variance of the bottom row,
var(X[4,])
[1] 0.7
calculated over all of the columns (a blank in the second position). There are some special
functions for calculating summary statistics on matrices:
rowSums(X)
[1] 11 9 8 4
colSums(X)
[1] 6 2 7 9 8
rowMeans(X)
[1] 2.2 1.8 1.6 0.8
colMeans(X)
[1] 1.50 0.50 1.75 2.25 2.00
These functions are built for speed, and blur some of the subtleties of dealing with NA or
NaN. If such subtlety is an issue, then use apply instead (p. 68). Remember that columns
are margin no. 2 (rows are margin no. 1):
apply(X,2,mean)
[1] 1.50 0.50 1.75 2.25 2.00
You might want to sum groups of rows within columns, and rowsum (singular and all
lower case, in contrast to rowSums, above) is a very efficient function for this. In this case
we want to group together row 1 and row 4 (as group A) and row 2 and row 3 (group B).
Note that the grouping vector has to have length equal to the number of rows:
group=c("A","B","B","A")
rowsum(X, group)
[,1] [,2] [,3] [,4] [,5]
A 2 0 4 6 3
B 4 2 3 3 5
You could achieve the same ends (but more slowly) with tapply or aggregate:
tapply(X, list(group[row(X)], col(X)), sum)
1 2 3 4 5
A 2 0 4 6 3
B 4 2 3 3 5
Note the use of row(X) and col(X), with row(X) used as a subscript on group.
aggregate(X,list(group),sum)

Group.1 V1 V2 V3 V4 V5
1 A 2 0 4 6 3
2 B 4 2 3 3 5
Suppose that we want to shuffle the elements of each column of a matrix independently.
We apply the function sample to each column (margin no. 2) like this:
apply(X,2,sample)
[,1] [,2] [,3] [,4] [,5]
[ 1 , ] 1 1 2 1 3
[ 2 , ] 3 1 0 1 3
[ 3 , ] 1 0 3 2 0
[ 4 , ] 1 0 2 5 2
apply(X,2,sample)
[,1] [,2] [,3] [,4] [,5]
[ 1 , ] 1 1 0 5 2
[ 2 , ] 1 1 2 1 3
[ 3 , ] 3 0 2 2 3
[ 4 , ] 1 0 3 1 0
and so on, for as many shuffled samples as you need.
Adding rows and columns to the matrix
In this particular case we have been asked to add a row at the bottom showing the column
means, and a column at the right showing the row variances:
X<-rbind(X,apply(X,2,mean))
X<-cbind(X,apply(X,1,var))
X
[,1] [,2] [,3] [,4] [,5] [,6]
[1,] 1.0 0.0 2.00 5.00 3 3.70000
[2,] 1.0 1.0 3.00 1.00 3 1.20000
[3,] 3.0 1.0 0.00 2.00 2 1.30000
[4,] 1.0 0.0 2.00 1.00 0 0.70000
[5,] 1.5 0.5 1.75 2.25 2 0.45625
Note that the number of decimal places varies across columns, with one in columns 1 and
2, two in columns 3 and 4, none in column 5 (integers) and five in column 6. The default
in R is to print the minimum number of decimal places consistent with the contents of the
column as a whole.
Next, we need to label the sixth column as ‘variance’ and the fifth row as ‘mean’:
colnames(X)<-c(1:5,"variance")
rownames(X)<-c(1:4,"mean")
X
1 2 3 4 5 variance
1 1.0 0.0 2.00 5.00 3 3.70000
2 1.0 1.0 3.00 1.00 3 1.20000
3 3.0 1.0 0.00 2.00 2 1.30000
4 1.0 0.0 2.00 1.00 0 0.70000
mean 1.5 0.5 1.75 2.25 2 0.45625
When a matrix with a single row or column is created by a subscripting operation, for
example row <- mat[2,], it is by default turned into a vector. In a similar way, if an array
with dimension, say, 2 × 3 × 1 × 4 is created by subscripting it will be coerced into a
2 × 3 × 4 array, losing the unnecessary dimension. After much discussion this has been
determined to be a feature of R. To prevent this happening, add the option drop = FALSE
to the subscripting. For example,
rowmatrix <- mat[2, , drop = FALSE]
colmatrix <- mat[, 2, drop = FALSE]
a <- b[1, 1, 1, drop = FALSE]
The drop = FALSE option should be used defensively when programming. For example,
the statement
somerows <- mat[index,]
will return a vector rather than a matrix if index happens to have length 1, and this might
cause errors later in the code. It should be written as
somerows <- mat[index , , drop = FALSE]
The sweep function
The sweep function is used to ‘sweep out’ array summaries from vectors, matrices, arrays
or dataframes. In this example we want to express a matrix in terms of the departures of
each value from its column mean.
matdata<-read.table("c: \\temp \\sweepdata.txt")
First, you need to create a vector containing the parameters that you intend to sweep out of
the matrix. In this case we want to compute the four column means:
(cols<-apply(matdata,2,mean))
V1 V2 V3 V4
4.60 13.30 0.44 151.60
Now it is straightforward to express all of the data in matdata as departures from the relevant
column means:
sweep(matdata,2,cols)
V1 V2 V3 V4
1 -1.6 -1.3 -0.04 -26.6
2 0.4 -1.3 0.26 14.4
3 2.4 1.7 0.36 22.4
4 2.4 0.7 0.26 -23.6
5 0.4 4.7 -0.14 -15.6
6 4.4 -0.3 -0.24 3.4
7 2.4 1.7 0.06 -36.6
8 -2.6 -0.3 0.06 17.4
9 -3.6 -3.3 -0.34 30.4
10 -4.6 -2.3 -0.24 14.4

Note the use of margin = 2 as the second argument to indicate that we want the sweep to
be carried out on the columns (rather than on the rows). A related function, scale, is used
for centring and scaling data in terms of standard deviations (p. 191).
You can see what sweep has done by doing the calculation long-hand. The operation
of this particular sweep is simply one of subtraction. The only issue is that the subtracted
object has to have the same dimensions as the matrix to be swept (in this example, 10
rows of 4 columns). Thus, to sweep out the column means, the object to be subtracted from
matdata must have the each column mean repeated in each of the 10 rows of 4 columns:
(col.means<-matrix(rep(cols,rep(10,4)),nrow=10))
[,1] [,2] [,3] [,4]
[1,] 4.6 13.3 0.44 151.6
[2,] 4.6 13.3 0.44 151.6
[3,] 4.6 13.3 0.44 151.6
[4,] 4.6 13.3 0.44 151.6
[5,] 4.6 13.3 0.44 151.6
[6,] 4.6 13.3 0.44 151.6
[7,] 4.6 13.3 0.44 151.6
[8,] 4.6 13.3 0.44 151.6
[9,] 4.6 13.3 0.44 151.6
[10,] 4.6 13.3 0.44 151.6
Then the same result as we got from sweep is obtained simply by
matdata-col.means
Suppose that you want to obtain the subscripts for a columnwise or a row-wise sweep of
the data. Here are the row subscripts repeated in each column:
apply(matdata,2,function (x) 1:10)
V1 V2 V3 V4
[1,] 1 1 1 1
[2,] 2 2 2 2
[3,] 3 3 3 3
[4,] 4 4 4 4
[5,] 5 5 5 5
[6,] 6 6 6 6
[7,] 7 7 7 7
[8,] 8 8 8 8
[9,] 9 9 9 9
[10,] 10 10 10 10
Here are the column subscripts repeated in each row:
t(apply(matdata,1,function (x) 1:4))


rowmatrix <- mat[2, , drop = FALSE]
colmatrix <- mat[, 2, drop = FALSE]
a <- b[1, 1, 1, drop = FALSE]
The drop = FALSE option should be used defensively when programming. For example,
the statement
somerows <- mat[index,]
will return a vector rather than a matrix if index happens to have length 1, and this might
cause errors later in the code. It should be written as
somerows <- mat[index , , drop = FALSE]






/home/syrhades/NetBeansProjects/Java24/build/classes/ Saluton.class

java -cp /home/syrhades/NetBeansProjects/Java24/build/classes Saluton


http://www.oracle.com/technetwork/java.

www.javaworld.com.
www.jticker.com



lead(1:10, 1)
lead(1:10, 2)

lag(1:10, 1)
lead(1:10, 1)

x <- runif(5)
cbind(ahead = lead(x), x, behind = lag(x))

# Use order_by if data not already ordered
df <- data.frame(year = 2000:2005, value = (0:5) ^ 2)
scrambled <- df[sample(nrow(df)), ]

wrong <- mutate(scrambled, prev = lag(value))
arrange(wrong, year)

shift(x, n=1L, fill=NA, type=c("lag", "lead"), give.names=FALSE)

right <- mutate(scrambled, prev = lag(value, order_by = year))
arrange(right, year)

sample ###################################################
colwise {plyr}	R Documentation
Column-wise function.
Description

Turn a function that operates on a vector into a function that operates column-wise on a data.frame.
Usage

colwise(.fun, .cols = true, ...)

catcolwise(.fun, ...)

numcolwise(.fun, ...)

Arguments
.fun 	

function
.cols 	

either a function that tests columns for inclusion, or a quoted object giving which columns to process
... 	

other arguments passed on to .fun
Details

catcolwise and numcolwise provide version that only operate on discrete and numeric variables respectively.
Examples

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


#########################
sweep {base}	R Documentation
Sweep out Array Summaries
Description

Return an array obtained from an input array by sweeping out a summary statistic.
Usage

sweep(x, MARGIN, STATS, FUN = "-", check.margin = TRUE, ...)

Arguments
x 	

an array.
MARGIN 	

a vector of indices giving the extent(s) of x which correspond to STATS.
STATS 	

the summary statistic which is to be swept out.
FUN 	

the function to be used to carry out the sweep.
check.margin 	

logical. If TRUE (the default), warn if the length or dimensions of STATS do not match the specified dimensions of x. Set to FALSE for a small speed gain when you know that dimensions match.
... 	

optional arguments to FUN.
Details

FUN is found by a call to match.fun. As in the default, binary operators can be supplied if quoted or backquoted.

FUN should be a function of two arguments: it will be called with arguments x and an array of the same dimensions generated from STATS by aperm.

The consistency check among STATS, MARGIN and x is stricter if STATS is an array than if it is a vector. In the vector case, some kinds of recycling are allowed without a warning. Use sweep(x, MARGIN, as.array(STATS)) if STATS is a vector and you want to be warned if any recycling occurs.
Value

An array with the same shape as x, but with the summary statistics swept out.
References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
See Also

apply on which sweep used to be based; scale for centering and scaling.
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


cs<-c(2,1,2)
ts<-c(1,2,3)
To get the answer, use sapply to concatenate the columns from each table like this:
sapply (1:3, function(i) A[,cs[i],ts[i]])
[,1] [,2] [,3]
[1,] "e" "i" "u"
[2,] "f" "j" "v"
[3,] "g" "k" "w"
[4,] "h" "l" "x"



Character Strings
In R, character strings are defined by double quotation marks:
a<-"abc"
b<-"123"
Numbers can be characters (as in b, above), but characters cannot be numbers.
as.numeric(a)
[1] NA
Warning message:
NAs introduced by coercion
as.numeric(b)
[1] 123
One of the initially confusing things about character strings is the distinction between
the length of a character object (a vector) and the numbers of characters in the strings
comprising that object. An example should make the distinction clear:
pets<-c("cat","dog","gerbil","terrapin")
Here, pets is a vector comprising four character strings:

length(pets)
[1] 4
and the individual character strings have 3, 3, 6 and 7 characters, respectively:
nchar(pets)
[1] 3 3 6 7
When first defined, character strings are not factors:
class(pets)
[1] "character"
is.factor(pets)
[1] FALSE
However, if the vector of characters called pets was part of a dataframe, then R would
coerce all the character variables to act as factors:
df<-data.frame(pets)
is.factor(df$pets)
[1] TRUE
There are built-in vectors in R that contain the 26 letters of the alphabet in lower case
(letters) and in upper case (LETTERS):
letters
[1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p"
[17] "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
LETTERS
[1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P"
[17] "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
To discover which number in the alphabet the letter n is, you can use the which function
like this:
which(letters=="n")
[1] 14
For the purposes of printing you might want to suppress the quotes that appear around
character strings by default. The function to do this is called noquote:
noquote(letters)
[1] a b c d e f g h i j k l m n o p q r s t u v w x y z
You can amalgamate strings into vectors of character information:
c(a,b)
[1] "abc" "123"
This shows that the concatenation produces a vector of two strings. It does not convert two
3-character strings into one 6-charater string. The R function to do that is paste:

d<-c(a,b,"new")
e<-paste(d,"a longer phrase containing blanks")
e
[1] "abc a longer phrase containing blanks"
[2] "123 a longer phrase containing blanks"
[3] "new a longer phrase containing blanks"



Extracting parts of strings
We being by defining a phrase:
phrase<-"the quick brown fox jumps over the lazy dog"
The function called substr is used to extract substrings of a specified number of characters
from a character string. Here is the code to extract the first, the first and second, the first,
second and third,    (up to 20) characters from our phrase
q<-character(20)
for (i in 1:20) q[i]<- substr(phrase,1,i)
q
[1] "t" "th" "the"
[4] "the " "the q" "the qu"
[7] "the qui" "the quic" "the quick"
[10] "the quick " "the quick b" "the quick br"
[13] "the quick bro" "the quick brow" "the quick brown"
[16] "the quick brown " "the quick brown f" "the quick brown fo"
[19] "the quick brown fox " "the quick brown fox "
The second argument in substr is the number of the character at which extraction is to
begin (in this case always the first), and the third argument is the number of the character at
which extraction is to end (in this case, the ith). To split up a character string into individual
characters, we use strsplit like this


strsplit(phrase,split=character(0))
[[1]]
[1] "t" "h" "e" " " "q" "u" "i" "c" "k" " " "b" "r" "o" "w" "n" " "
[17] "f" "o" "x" " " "j" "u" "m" "p" "s" " " "o" "v" "e" "r"
[31] " " "t" "h" "e" " " "l" "a" "z" "y" " " "d" "o" "g"
The table function is useful for counting the number of occurrences of characters of
different kinds:
table(strsplit(phrase,split=character(0)))
a b c d e f g h i j k l m n o p q r s t u v w x y z
8 1 1 1 1 3 1 1 2 1 1 1 1 1 1 4 1 1 2 1 2 2 1 1 1 1 1
This demonstrates that all of the letters of the alphabet were used at least once within our
phrase, and that there were 8 blanks within phrase. This suggests a way of counting the
number of words in a phrase, given that this will always be one more than the number of
blanks:
words<-1+table(strsplit(phrase,split=character(0)))[1]
words
9
When we specify a particular string to form the basis of the split, we end up with a list
made up from the components of the string that do not contain the specified string. This is
hard to understand without an example. Suppose we split our phrase using ‘the’:
strsplit(phrase,"the")
[[1]]
[1] "" " quick brown fox jumps over " " lazy dog"
There are three elements in this list: the first one is the empty string "" because the first
three characters within phrase were exactly ‘the’ ; the second element contains the part of
the phrase between the two occurrences of the string ‘the’; and the third element is the end
of the phrase, following the second ‘the’. Suppose that we want to extract the characters
between the first and second occurrences of ‘the’. This is achieved very simply, using
subscripts to extract the second element of the list:
strsplit(phrase,"the")[[1]] [2]
[1] " quick brown fox jumps over "
Note that the first subscript in double square brackets refers to the number within the list
(there is only one list in this case) and the second subscript refers to the second element
within this list. So if we want to know how many characters there are between the first and
second occurrences of the word “the” within our phrase, we put:
nchar(strsplit(phrase,"the")[[1]] [2])
[1] 28
It is easy to switch between upper and lower cases using the toupper and tolower functions:
toupper(phrase)


arithmetic.mean<-function(x) sum(x)/length(x)

med<-function(x) {
odd.even<-length(x)%%2
if (odd.even == 0) (sort(x)[length(x)/2]+sort(x)[1+ length(x)/2])/2
else sort(x)[ceiling(length(x)/2)]
}


geometric<-function (x) exp(mean(log(x)))

harmonic<-function (x) 1/mean(1/x)
and testing it on our elephant data gives
harmonic(c(1,2,4,1))
[1] 1.454545

variance<-function(x) sum((x – mean(x))∧2)/(length(x)-1)
and use it like this:
variance(y)
[1] 10.25455

variance.ratio<-function(x,y) {
v1<-var(x)
v2<-var(y)
if (var(x) > var(y)) {
vr<-var(x)/var(y)
df1<-length(x)-1
df2<-length(y)-1}
else { vr<-var(y)/var(x)
df1<-length(y)-1
df2<-length(x)-1}
2*(1-pf(vr,df1,df2)) }



Loops and Repeats
The classic, Fortran-like loop is available in R. The syntax is a little different, but the idea
is identical; you request that an index, i, takes on a sequence of values, and that one or more
lines of commands are executed as many times as there are different values of i. Here is a
loop executed five times with the values of i from 1 to 5: we print the square of each value:
for (i in 1:5) print(i∧ 2)
[1] 1
[1] 4
[1] 9
[1] 16
[1] 25
For multiple lines of code, you use curly brackets {} to enclose material over which the
loop is to work. Note that the ‘hard return’ (the Enter key) at the end of each command line
is an essential part of the structure (you can replace the hard returns by semicolons if you
like, but clarity is improved if you put each command on a separate line):
j<-k<-0
for (i in 1:5) {
j<-j+1
k<-k+i*j
print(i+j+k) }
[1] 3
[1] 9

[1] 20
[1] 38
[1] 65
Here we use a for loop to write a function to calculate factorial x (written x!) which is
x! = x × x − 1 × x − 2 × x − 3    × 2 × 1
So 4! = 4 × 3 × 2 = 24. Here is the function:
fac1<-function(x) {
f <- 1
if (x<2) return (1)
for (i in 2:x) {
f <- f*i
f }}
That seems rather complicated for such a simple task, but we can try it out for the numbers
0 to 5:
sapply(0:5,fac1)
[1] 1 1 2 6 24 120
There are two other looping functions in R: repeat and while. We demonstrate their use
for the purpose of illustration, but we can do much better in terms of writing a compact
function for finding factorials (see below). First, the while function:
fac2<-function(x) {
f <- 1
t <- x
while(t>1) {
f <- f*t
t <- t-1 }
return(f) }
The key point is that if you want to use while, you need to set up an indicator variable (t
in this case) and change its value within each iteration (t<-t-1). We test the function on the
numbers 0 to 5:
sapply(0:5,fac2)
[1] 1 1 2 6 24 120
Finally, we demonstrate the use of the repeat function:
fac3<-function(x) {
f <- 1
t <- x
repeat {
if (t<2) break
f <- f*t
t <- t-1 }
return(f) }

Because the repeat function contains no explicit limit, you need to be careful not to program
an infinite loop. You must have a logical escape clause that leads to a break command:
sapply(0:5,fac3)
[1] 1 1 2 6 24 120
It is almost always better to use a built-in function that operates on the entire vector and
hence removes the need for loops or repeats of any sort. In this case, we can make use of
the cumulative product function, cumprod. Here it is in action:
cumprod(1:5)
[1] 1 2 6 24 120
This is already pretty close to what we need for our factorial function. It does not work for
0! of course, because the whole vector would end up full of zeros if the first element in the
vector was zero (try 0:5 and see). The factorial of x > 0 is the maximum value from the
vector produced by cumprod:
fac4<-function(x) max(cumprod(1:x))
This definition has the desirable side effect that it also gets 0! correct, because when x is 0
the function finds the maximum of 1 and 0 which is 1 which is 0!.
max(cumprod(1:0))
[1] 1
sapply(0:5,fac4)
[1] 1 1 2 6 24 120
Alternatively, you could adapt an existing built-in function to do the job. x! is the same
as x + 1, so
fac5<-function(x) gamma(x+1)
sapply(0:5,fac5)
[1] 1 1 2 6 24 120
Until recently there was no built-in factorial function in R, but now there is:
sapply(0:5,factorial)
[1] 1 1 2 6 24 120
Here is a function that uses the while function in converting a specified number to its
binary representation. The trick is that the smallest digit (0 for even or 1 for odd numbers)
is always at the right-hand side of the answer (in location 32 in this case):
binary<-function(x) {
i<-0
string<-numeric(32)
while(x>0) {
string[32-i]<-x %% 2
x<-x%/% 2
i<-i+1 }

first<-match(1,string)
string[first:32] }
The leading zeros (1 to first − 1) within the string are not printed. We run the function to
find the binary representation of the numbers 15 to 17:
sapply(15:17,binary)
[[1]]
[1] 1 1 1 1
[[2]]
[1] 1 0 0 0 0
[[3]]
[1] 1 0 0 0 1
The next function uses while to generate the Fibonacci series 1, 1, 2, 3, 5, 8,    in which
each term is the sum of its two predecessors. The key point about while loops is that the
logical variable controlling their operation is altered inside the loop. In this example, we
alter n, the number whose Fibonacci number we want, starting at n, reducing the value of
n by 1 each time around the loop, and ending when n gets down to 0. Here is the code:
fibonacci<-function(n) {
a<-1
b<-0
while(n>0)
{swap<-a
a<-a+b
b<-swap
n<-n-1 }
b }
An important general point about computing involves the use of the swap variable above.
When we replace a by a + b on line 6 we lose the original value of a. If we had not stored
this value in swap, we could not set the new value of b to the old value of a on line 7. Now
test the function by generating the Fibonacci numbers 1 to 10:
sapply(1:10,fibonacci)
[1] 1 1 2 3 5 8 13 21 34 55
Loop avoidance
It is good R programming practice to avoid using loops wherever possible. The use of vector
functions (p. 17) makes this particularly straightforward in many cases. Suppose that you
wanted to replace all of the negative values in an array by zeros. In the old days, you might
have written something like this:
for (i in 1:length(y)) { if(y[i] < 0) y[i] <- 0 }
Now, however, you would use logical subscripts (p. 21) like this:
y [y < 0] <- 0

The ifelse function
Sometimes you want to do one thing if a condition is true and a different thing if the
condition is false (rather than do nothing, as in the last example). The ifelse function allows
you to do this for entire vectors without using for loops. We might want to replace any
negative values of y by −1 and any positive values and zero by +1:
z <- ifelse (y < 0, -1, 1)
Here we use ifelse to convert the continuous variable called Area into a new, two-level
factor with values ‘big’ and ‘small’ defined by the median Area of the fields:
data<-read.table("c:\\temp\\worms.txt",header=T)
attach(data)
ifelse(Area>median(Area),"big","small")
[1] "big" "big" "small" "small" "big" "big" "big" "small" "small"
[10] "small" "small" "big" "big" "small" "big" "big" "small" "big"
[19] "small" "small"
You should use the much more powerful function called cut when you want to convert a
continuous variable like Area into many levels (p. 241).
Another use of ifelse is to override R’s natural inclinations. The log of zero in R is -Inf,
as you see in these 20 random numbers from a Poisson process with a mean count of 1.5:
y<-log(rpois(20,1.5))
y
[1] 0.0000000 1.0986123 1.0986123 0.6931472 0.0000000 0.6931472 0.6931472
[8] 0.0000000 0.0000000 0.0000000 0.0000000 -Inf -Inf -Inf
[15] 1.3862944 0.6931472 1.6094379 -Inf -Inf 0.0000000
However, we want the log of zero to be represented by NA in our particular application:
ifelse(y<0,NA,y)
[1] 0.0000000 1.0986123 1.0986123 0.6931472 0.0000000 0.6931472 0.6931472
[8] 0.0000000 0.0000000 0.0000000 0.0000000 NA NA NA
[15] 1.3862944 0.6931472 1.6094379 NA NA 0.0000000
The slowness of loops
To see how slow loops can be, we compare two ways of finding the maximum number in
a vector of 10 million random numbers from a uniform distribution:
x<-runif(10000000)
First, using the vector function max:
system.time(max(x))
[1] 0.13 0.00 0.12 NA NA
As you see, this operation took just over one-tenth of a second (0.12) to solve using the
vector function max to look at the 10 million numbers in x. Using a loop, however, took
more than 15 seconds:
pc<-proc.time()
cmax<-x[1]

for (i in 2:10000000) {
if(x[i]>cmax) cmax<-x[i] }
proc.time()-pc
[1] 15.52 0.00 15.89 NA NA
The functions system.time and proc.time produce a vector of five numbers, showing the
user, system and total elapsed times for the currently running R process, and the cumulative
sum of user (subproc1) and system times (subproc2) of any child processes spawned by it
(none in this case, so NA). It is the third number (elapsed time in seconds) that is typically
the most useful.
Do not ‘grow’ data sets in loops or recursive function calls
Here is an extreme example of what not to do. We want to generate a vector containing the
integers 1 to 1 000 000:
z<-NULL
for (i in 1:1000000){
z<-c(z,i) }
This took a ridiculous 4 hours 14 minutes to execute. The moral is clear: do not use
concatenation c(z,i) to generate iterative arrays. The simple way to do it,
z<-1:1000000
took 0.05 seconds to accomplish.
The switch Function
When you want a function to do different things in different circumstances, then the
switch function can be useful. Here we write a function that can calculate any one of four
different measures of central tendency: arithmetic mean, geometric mean, harmonic mean
or median (p. 51). The character variable called measure should take one value of Mean,
Geometric, Harmonic or Median; any other text will lead to the error message Measure
not included. Alternatively, you can specify the number of the switch (e.g. 1 for Mean,
4 for Median).
central<-function(y, measure) {
switch(measure,
Mean = mean(y),
Geometric = exp(mean(log(y))),
Harmonic = 1/mean(1/y),
Median = median(y),
stop("Measure not included")) }
Note that you have to include the character strings in quotes as arguments to the function,
but they must not be in quotes within the switch function itself.
central(rnorm(100,10,2),"Harmonic")
[1] 9.554712
central(rnorm(100,10,2),4)
[1] 10.46240
The Evaluation Environment of a Function
When a function is called or invoked a new evaluation frame is created. In this frame
the formal arguments are matched with the supplied arguments according to the rules of
argument matching (below). The statements in the body of the function are evaluated
sequentially in this environment frame.
The first thing that occurs in a function evaluation is the matching of the formal to the
actual or supplied arguments. This is done by a three-pass process:
• Exact matching on tags. For each named supplied argument the list of formal arguments
is searched for an item whose name matches exactly.
• Partial matching on tags. Each named supplied argument is compared to the remaining
formal arguments using partial matching. If the name of the supplied argument matches
exactly with the first part of a formal argument then the two arguments are considered
to be matched.
• Positional matching. Any unmatched formal arguments are bound to unnamed supplied
arguments, in order. If there is a    argument, it will take up the remaining arguments,
tagged or not.
• If any arguments remain unmatched an error is declared.
Supplied arguments and default arguments are treated differently. The supplied arguments
to a function are evaluated in the evaluation frame of the calling function. The default
arguments to a function are evaluated in the evaluation frame of the function. In general,
supplied arguments behave as if they are local variables initialized with the value supplied
and the name of the corresponding formal argument. Changing the value of a supplied
argument within a function will not affect the value of the variable in the calling frame.
Scope
The scoping rules are the set of rules used by the evaluator to find a value for a symbol.
A symbol can be either bound or unbound. All of the formal arguments to a function
provide bound symbols in the body of the function. Any other symbols in the body of
the function are either local variables or unbound variables. A local variable is one that is
defined within the function, typically by having it on the left-hand side of an assignment.
During the evaluation process if an unbound symbol is detected then R attempts to find a
value for it: the environment of the function is searched first, then its enclosure and so on
until the global environment is reached. The value of the first match is then used.
Optional Arguments
Here is a function called charplot that produces a scatterplot of x and y using solid red
circles as the plotting symbols: there are two essential arguments (x and y) and two optional
(pc and co) to control selection of the plotting symbol and its colour:
charplot<-function(x,y,pc=16,co="red"){
plot(y~x,pch=pc,col=co)}



z <- ifelse (y < 0, -1, 1)

The functions system.time and proc.time produce a vector of five numbers, showing the
user, system and total elapsed times for the currently running R process, and the cumulative
sum of user (subproc1) and system times (subproc2) of any child processes spawned by it
(none in this case, so NA). It is the third number (elapsed time in seconds) that is typically
the most useful.


central<-function(y, measure) {
switch(measure,
Mean = mean(y),
Geometric = exp(mean(log(y))),
Harmonic = 1/mean(1/y),
Median = median(y),
stop("Measure not included")) }
Note that you have to include the character strings in quotes as arguments to the function,
but they must not be in quotes within the switch function itself.
central(rnorm(100,10,2),"Harmonic")
[1] 9.554712
central(rnorm(100,10,2),4)
[1] 10.46240

Variable Numbers of Arguments     
Some applications are much more straightforward if the number of arguments does not need
to be specified in advance. There is a special formal name    (triple dot) which is used in
the argument list to specify that an arbitrary number of arguments are to be passed to the
function. Here is a function that takes any number of vectors and calculates their means and
variances:
many.means <- function (    ) {
data <- list(    )
n<- length(data)
means <- numeric(n)
vars <- numeric(n)
for (i in 1:n) {
means[i]<-mean(data[[i]])
vars[i]<-var(data[[i]])
}
print(means)
print(vars)
invisible(NULL)
}


Anonymous Functions
Here is an example of an anonymous function. It generates a vector of values but the
function is not allocated a name (although the answer could be).
(function(x,y){ z <- 2*x^2 + y^2; x+y+z })(0:7, 1)
[1] 2 5 12 23 38 57 80 107
The function first uses the supplied values of x and y to calculate z, then returns the value
of x + y + z evaluated for eight values of x (from 0 to 7) and one value of y (1). Anonymous
functions are used most frequently with apply, sapply and lapply (p. 68)

Flexible Handling of Arguments to Functions
Because of the lazy evaluation practised by R, it is very simple to deal with missing
arguments in function calls, giving the user the opportunity to specify the absolute minimum
number of arguments, but to override the default arguments if they want to. As a simple
example, take a function plotx2 that we want to work when provided with either one or
two arguments. In the one-argument case (only an integer x > 1 provided), we want it to
plot z2 against z for z = 1 to x in steps of 1. In the second case, when y is supplied, we
want it to plot y against z for z = 1 to x.
plotx2 <- function (x, y=z^2) {
z<-1:x
plot(z,y,type="l") }
In many other languages, the first line would fail because z is not defined at this point. But
R does not evaluate an expression until the body of the function actually calls for it to be
evaluated (i.e. never, in the case where y is supplied as a second argument). Thus for the
one-argument case we get a graph of z2 against z and in the two-argument case we get a
graph of y against z (in this example, the straight line 1:12 vs. 1:12)
par(mfrow=c(1,2))
plotx2(12)
plotx2(12,1:12)
2
You need to specify that the type of plot you want is a line (type="l" using lower-case
L, not upper-case I and not number 1) because the default is to produce a scatterplot with
open circles as the plotting symbol (type="p"). If you want your plot to consist of points
with lines joining the dots, then use type="b" (for ‘both’ lines and points). Other types of
plot that you might want to specify include vertical lines from the x axis up to the value of
the response variable (type="h"), creating an effect like very slim barplots or histograms,
and type="s" to produce a line drawn as steps between successive ranked values of x. To
plot the scaled axes, but no lines or points, use type="n" (see p. 137).
It is possible to access the actual (not default) expressions used as arguments inside the
function. The mechanism is implemented via promises. You can find an explanation of
promises by typing ?promise at the command prompt.

Evaluating Functions with apply, sapply and lapply
apply and sapply
The apply function is used for applying functions to the rows or columns of matrices or
dataframes. For example:
(X<-matrix(1:24,nrow=4))
[,1] [,2] [,3] [,4] [,5] [,6]
[1,] 1 5 9 13 17 21
[2,] 2 6 10 14 18 22
[3,] 3 7 11 15 19 23
[4,] 4 8 12 16 20 24
Note that placing the expression to be evaluated in parentheses (as above) causes the value
of the result to be printed on the screen. This saves an extra line of code, because to achieve
the same result without parentheses requires us to type

Pasting into an Excel Spreadsheet
Writing a vector from R to the Windows clipboard uses the function writeClipboard(x)
where x is a character vector, so you need to build up a spreadsheet in Excel one column
at a time. Remember that character strings in dataframes are converted to factors on input
unless you protect them by as.is(name) on input. For example
writeClipboard(as.character(factor.name))
Go into Excel and press Ctrl+V, and then back into R and type
writeClipboard(as.character(numeric.variable))
Then go into Excel and Ctrl+V in the second column, and so on.

Writing an Excel Readable File from R
Suppose you want to transfer the dataframe called data to Excel:
write.table(data,"clipboard",sep="\t",col.names=NA)
Then, in Excel, just type Ctrl+V or click on the Paste icon (the clipboard)

Sets: union, intersect and setdiff
There are three essential functions for manipulating sets. The principles are easy to see if
we work with an example of two sets:
setA<-c("a", "b", "c", "d", "e")
setB<-c("d", "e", "f", "g")
Make a mental note of what the two sets have in common, and what is unique to each.
The union of two sets is everything in the two sets taken together, but counting elements
only once that are common to both sets:
union(setA,setB)
[1] "a" "b" "c" "d" "e" "f" "g"
The intersection of two sets is the material that they have in common:
intersect(setA,setB)
[1] "d" "e"
Note, however, that the difference between two sets is order-dependent. It is the material
that is in the first named set, that is not in the second named set. Thus setdiff(A,B) gives a
different answer than setdiff(B,A). For our example,
setdiff(setA,setB)
[1] "a" "b" "c"
setdiff(setB,setA)
[1] "f" "g"
Thus, it should be the case that setdiff(setA,setB) plus intersect(setA,setB) plus set
diff(setB,setA) is the same as the union of the two sets. Let’s check:
all(c(setdiff(setA,setB),intersect(setA,setB),setdiff(setB,setA))==
union(setA,setB))
[1] TRUE
There is also a built-in function setequal for testing if two sets are equal
setequal(c(setdiff(setA,setB),intersect(setA,setB),setdiff(setB,setA)),
union(setA,setB))
[1] TRUE
You can use %in% for comparing sets. The result is a logical vector whose length matches
the vector on the left

setA %in% setB
[1] FALSE FALSE FALSE TRUE TRUE
setB %in% setA
[1] TRUE TRUE FALSE FALSE
Using these vectors of logical values as subscripts, we can demonstrate, for instance, that
setA[setA %in% setB] is the same as intersect(setA,setB):
setA[setA %in% setB]
[1] "d" "e"
intersect(setA,setB)
[1] "d" "e"
Pattern Matching
We need a dataframe with a serious amount of text in it to make these exercises relevant:
wf<-read.table("c:\\temp\\worldfloras.txt",header=T)
attach(wf)
names(wf)
[1] "Country" "Latitude" "Area" "Population" "Flora"
[6] "Endemism" "Continent"
Country
As you can see, there are 161 countries in this dataframe (strictly, 161 places, since some
of the entries, such as Sicily and Balearic Islands, are not countries). The idea is that we
want to be able to select subsets of countries on the basis of specified patterns within the
character strings that make up the country names (factor levels). The function to do this
is grep. This searches for matches to a pattern (specified in its first argument) within the
character vector which forms the second argument. It returns a vector of indices (subscripts)
within the vector appearing as the second argument, where the pattern was found in whole
or in part. The topic of pattern matching is very easy to master once the penny drops, but it
hard to grasp without simple, concrete examples. Perhaps the simplest task is to select all
the countries containing a particular letter – for instance, upper case R:
as.vector(Country[grep("R",as.character(Country))])
[1] "Central African Republic" "Costa Rica"
[3] "Dominican Republic" "Puerto Rico"
[5] "Reunion" "Romania"
[7] "Rwanda" "USSR"
To restrict the search to countries whose first name begins with R use the ∧ character
like this:
as.vector(Country[grep("^R",as.character(Country))])
[1] "Reunion" "Romania" "Rwanda"
To select those countries with multiple names with upper case R as the first letter of their
second or subsequent names, we specify the character string as ‘blank R’ like this:

as.vector(Country[grep(" R",as.character(Country)])
[1] "Central African Republic" "Costa Rica"
[3] "Dominican Republic" "Puerto Rico"
To find all the countries with two or more names, just search for a blank " "
as.vector(Country[grep(" ",as.character(Country))])
[1] "Balearic Islands" "Burkina Faso"
[3] "Central African Republic" "Costa Rica"
[5] "Dominican Republic" "El Salvador"
[7] "French Guiana" "Germany East"
[9] "Germany West" "Hong Kong"
[11] "Ivory Coast" "New Caledonia"
[13] "New Zealand" "Papua New Guinea"
[15] "Puerto Rico" "Saudi Arabia"
[17] "Sierra Leone" "Solomon Islands"
[19] "South Africa" "Sri Lanka"
[21] "Trinidad & Tobago" "Tristan da Cunha"
[23] "United Kingdom" "Viet Nam"
[25] "Yemen North" "Yemen South"
To find countries with names ending in ‘y’ use the $ (dollar) symbol like this:
as.vector(Country[grep("y$",as.character(Country))])
[1] "Hungary" "Italy" "Norway" "Paraguay" "Sicily" "Turkey"
[7] "Uruguay"
To recap: the start of the character string is denoted by ^ and the end of the character string
is denoted by $. For conditions that can be expressed as groups (say, series of numbers or
alphabetically grouped lists of letters), use square brackets inside the quotes to indicate the
range of values that is to be selected. For instance, to select countries with names containing
upper-case letters from C to E inclusive, write:
as.vector(Country[grep("[C-E]",as.character(Country))])
[1] "Cameroon" "Canada"
[3] "Central African Republic" "Chad"
[5] "Chile" "China"
[7] "Colombia" "Congo"
[9] "Corsica" "Costa Rica"
[11] "Crete" "Cuba"
[13] "Cyprus" "Czechoslovakia"
[15] "Denmark" "Dominican Republic"
[17] "Ecuador" "Egypt"
[19] "El Salvador" "Ethiopia"
[21] "Germany East" "Ivory Coast"
[23] "New Caledonia" "Tristan da Cunha"
Notice that this formulation picks out countries like Ivory Coast and Tristan da Cunha that
contain upper-case Cs in places other than as their first letters. To restrict the choice to first
letters use the ^ operator before the list of capital letters:
as.vector(Country[grep("^[C-E]",as.character(Country))])

[1] "Cameroon" "Canada"
[3] "Central African Republic" "Chad"
[5] "Chile" "China"
[7] "Colombia" "Congo"
[9] "Corsica" "Costa Rica"
[11] "Crete" "Cuba"
[13] "Cyprus" "Czechoslovakia"
[15] "Denmark" "Dominican Republic"
[17] "Ecuador" "Egypt"
[19] "El Salvador" "Ethiopia"
How about selecting the counties not ending with a specified patterns? The answer is
simply to use negative subscripts to drop the selected items from the vector. Here are the
countries that do not end with a letter between ‘a’ and ‘t’:
as.vector(Country[-grep("[a-t]$",as.character(Country))])
[1] "Hungary" "Italy" "Norway" "Paraguay" "Peru" "Sicily"
[7] "Turkey" "Uruguay" "USA" "USSR" "Vanuatu"
You see that USA and USSR are included in the list because we specified lower-case
letters as the endings to omit. To omit these other countries, put ranges for both upper- and
lower-case letters inside the square brackets, separated by a space:
as.vector(Country[-grep("[A-T a-t]$",as.character(Country))])
[1] "Hungary" "Italy" "Norway" "Paraguay" "Peru" "Sicily"
[7] "Turkey" "Uruguay" "Vanuatu"
Dot . as the ‘anything’ character
Countries with ‘y’ as their second letter are specified by ^.y The ^ shows ‘starting’, then a
single dot means one character of any kind, so y is the specified second character:
as.vector(Country[grep("^.y",as.character(Country))])
[1] "Cyprus" "Syria"
To search for countries with ‘y’ as third letter:
as.vector(Country[grep("^..y",as.character(Country))])
[1] "Egypt" "Guyana" "Seychelles"
If we want countries with ‘y’ as their sixth letter
as.vector(Country[grep("^. {5}y",as.character(Country))])
[1] "Norway" "Sicily" "Turkey"
(5 ‘anythings’ is shown by ‘.’ then curly brackets {5} then y). Which are the countries with
4 or fewer letters in their names?
as.vector(Country[grep("^. {,4}$",as.character(Country))])
[1] "Chad" "Cuba" "Iran" "Iraq" "Laos" "Mali" "Oman"
[8] "Peru" "Togo" "USA" "USSR"
The ‘.’ means ‘anything’ while the {,4} means ‘repeat up to four’ anythings (dots) before $ (the
end of the string). So to find all the countries with 15 or more characters in their name is just

as.vector(Country[grep("^. {15, }$",as.character(Country))])
[1] "Balearic Islands" "Central African Republic"
[3] "Dominican Republic" "Papua New Guinea"
[5] "Solomon Islands" "Trinidad & Tobago"
[7] "Tristan da Cunha"
Substituting text within character strings
Search-and-replace operations are carried out in R using the functions sub and gsub. The
two substitution functions differ only in that sub replaces only the first occurrence of a
pattern within a character string, whereas gsub replaces all occurrences. An example should
make this clear. Here is a vector comprising seven character strings, called text:
text <- c("arm","leg","head", "foot","hand", "hindleg", "elbow")
We want to replace all lower-case ‘h’ with upper-case ‘H’:
gsub("h","H",text)
[1] "arm" "leg" "Head" "foot" "Hand" "Hindleg" "elbow"
Now suppose we want to convert the first occurrence of a lower-case ‘o’ into an upper-case
‘O’. We use sub for this (not gsub):
sub("o","O",text)
[1] "arm" "leg" "head" "fOot" "hand" "hindleg" "elbOw"
You can see the difference between sub and gsub in the following, where both instances
of ‘o’ in foot are converted to upper case by gsub but not by sub:
gsub("o","O",text)
[1] "arm" "leg" "head" "fOOt" "hand" "hindleg" "elbOw"
More general patterns can be specified in the same way as we learned for grep (above).
For instance, to replace the first character of every string with upper-case ‘O’ we use the
dot notation (. stands for ‘anything’) coupled with ^ (the ‘start of string’ marker):
gsub("^.","O",text)
[1] "Orm" "Oeg" "Oead" "Ooot" "Oand" "Oindleg" "Olbow"
It is useful to be able to manipulate the cases of character strings. Here, we capitalize the
first character in each string:
gsub("(\\w)(\\w*)", "\\U\\1\\L\\2",text, perl=TRUE)
[1] "Arm" "Leg" "Head" "Foot" "Hand" "Hindleg" "Elbow"
while here we convert all the characters to upper case:
gsub("(\\w*)", "\\U\\1",text, perl=TRUE)
[1] "ARM" "LEG" "HEAD" "FOOT" "HAND" "HINDLEG" "ELBOW"

gsub("(\\w)(\\w*)", "\\U\\1\\L\\2",text, perl=TRUE)

Locations of the pattern within a vector of character strings using regexpr
Instead of substituting the pattern, we might want to know if it occurs in a string and,
if so, where it occurs within each string. The result of regexpr, therefore, is a numeric
vector (as with grep, above), but now indicating the position of the (first instance of the)
pattern within the string (rather than just whether the pattern was there). If the pattern does
not appear within the string, the default value returned by regexpr is −1. An example is
essential to get the point of this:
text
[1] "arm" "leg" "head" "foot" "hand" "hindleg" "elbow"
regexpr("o",text)
[1] -1 -1 -1 2 -1 -1 4
attr(,"match.length")
[1] -1 -1 -1 1 -1 -1 1
This indicates that there were lower-case ‘o’s in two of the elements of text, and that they
occurred in positions 2 and 4, respectively. Remember that if we wanted just the subscripts
showing which elements of text contained an ‘o’ we would use grep like this:
grep("o",text)
[1] 4 7
and we would extract the character strings like this:
text[grep("o",text)]
[1] "foot" "elbow"
Counting how many ‘o’s there are in each string is a different problem again, and this
involves the use of gregexpr:
freq<-as.vector(unlist (lapply(gregexpr("o",text),length)))
present<-ifelse(regexpr("o",text)<0,0,1)
freq*present
[1] 0 0 0 2 0 0 1
indicating that there are no ‘o’s in the first three character strings, two in the fourth and one
in the last string. You will need lots of practice with these functions to appreciate all of the
issues involved.
The function charmatch is for matching characters. If there are multiple matches (two
or more) then the function returns the value 0 (e.g. when all the elements contain ‘m’):
charmatch("m", c("mean", "median", "mode"))
[1] 0
If there is a unique match the function returns the index of the match within the vector of
character strings (here in location number 2):
charmatch("med", c("mean", "median", "mode"))
[1] 2

Using %in% and which
You want to know all of the matches between one character vector and another:
stock<-c(’car’,’van’)
requests<-c(’truck’,’suv’,’van’,’sports’,’car’,’waggon’,’car’)
Use which to find the locations in the first-named vector of any and all of the entries in the
second-named vector:
which(requests %in% stock)
[1] 3 5 7
If you want to know what the matches are as well as where they are,
requests [which(requests %in% stock)]
[1] "van" "car" "car"
You could use the match function to obtain the same result (p. 47):
stock[match(requests,stock)][!is.na(match(requests,stock))]
[1] "van" "car" "car"
but it’s more clumsy. A slightly more complicated way of doing it involves sapply
which(sapply(requests, "%in%", stock))
van car car
3 5 7
Note the use of quotes around the %in% function. Note that the match must be perfect for
this to work (‘car’ with ‘car’ is not the same as ‘car’ with ‘cars’).
More on pattern matching
For the purposes of specifying these patterns, certain characters are called metacharacters,
specifically \| () [{^ $ * + ? Any metacharacter with special meaning in your string may
be quoted by preceding it with a backslash: \\{$ or \* for instance. You might be used to
specifying one or more ‘wildcards’ by ∗ in DOS-like applications. In R, however, the regular
expressions used are those specified by POSIX 1003.2, either extended or basic, depending
on the value of the extended argument, unless perl = TRUE when they are those of PCRE
(see ?grep for details).
Note that the square brackets in these class names [ ] are part of the symbolic names,
and must be included in addition to the brackets delimiting the bracket list. For example,
[[:alnum:]] means [0-9A-Za-z], except the latter depends upon the locale and the character
encoding, whereas the former is independent of locale and character set. The interpretation
below is that of the POSIX locale.
[:alnum:] Alphanumeric characters: [:alpha:] and [:digit:].
[:alpha:] Alphabetic characters: [:lower:] and [:upper:].
[:blank:] Blank characters: space and tab.
[:cntrl:] Control characters in ASCII, octal codes 000 through 037, and 177 (DEL).
[:digit:] Digits: 0 1 2 3 4 5 6 7 8 9.
[:graph:] Graphical characters: [:alnum:] and [:punct:].
[:lower:] Lower-case letters in the current locale.
[:print:] Printable characters: [:alnum:], [:punct:] and space.

[:punct:] Punctuation characters:
! " # $ % & () ∗+, - ./: ; <=> ? @ [\] ∧ _ ‘ {  } ∼.
[:space:] Space characters: tab, newline, vertical tab, form feed, carriage return, space.
[:upper:] Upper-case letters in the current locale.
[:xdigit:] Hexadecimal digits: 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f.
Most metacharacters lose their special meaning inside lists. Thus, to include a literal ],
place it first in the list. Similarly, to include a literal ^, place it anywhere but first. Finally,
to include a literal -, place it first or last. Only these and \ remain special inside character
classes. To recap:
• Dot . matches any single character.
• Caret ^ matches the empty string at the beginning of a line.
• Dollar sign $ matches the empty string at the end of a line.
• Symbols \< and \> respectively match the empty string at the beginning and end of
a word.
• The symbol \b matches the empty string at the edge of a word, and \B matches the empty
string provided it is not at the edge of a word.
A regular expression may be followed by one of several repetition quantifiers:
? The preceding item is optional and will be matched at most once.
* The preceding item will be matched zero or more times.
+ The preceding item will be matched one or more times.
{n} The preceding item is matched exactly n times.
{n, } The preceding item is matched n or more times.
{,m} The preceding item is matched up to m times.
{n,m} The preceding item is matched at least n times, but not more than m times.
You can use the OR operator | so that "abba|cde" matches either the string "abba" or the
string "cde".
Here are some simple examples to illustrate the issues involved.
text <- c("arm","leg","head", "foot","hand", "hindleg", "elbow")
The following lines demonstrate the "consecutive characters" {n} in operation:
grep("o{1}",text,value=T)
[1] "foot" "elbow"
grep("o{2}",text,value=T)
[1] "foot"

grep("o{3}",text,value=T)
character(0)
The following lines demonstrate the use of {n, } "n or more" character counting in words:
grep("[[:alnum:]]{4, }",text,value=T)
[1] "head" "foot" "hand" "hindleg" "elbow"
grep("[[:alnum:]]{5, }",text,value=T)
[1] "hindleg" "elbow"
grep("[[:alnum:]]{6, }",text,value=T)
[1] "hindleg"
grep("[[:alnum:]]{7, }",text,value=T)
[1] "hindleg"
Perl regular expressions
The perl = TRUE argument switches to the PCRE library that implements regular expression
pattern matching using the same syntax and semantics as Perl 5.6 or later (with just a few
differences). For details (and there are many) see ?regexp.
Perl is good for altering the cases of letters. Here, we capitalize the first character in each
string:
gsub("(\\w)(\\w*)", "\\U\\1\\L\\2",text, perl=TRUE)
[1] "Arm" "Leg" "Head" "Foot" "Hand" "Hindleg" "Elbow"
while here we convert all the character to upper case:
gsub("(\\w*)", "\\U\\1",text, perl=TRUE)
[1] "ARM" "LEG" "HEAD" "FOOT" "HAND" "HINDLEG" "ELBOW"
Stripping patterned text out of complex strings
Suppose that we want to tease apart the information in these complicated strings:
(entries <-c ("Trial 1 58 cervicornis (52 match)", "Trial 2 60 terrestris (51 matched)",
"Trial 8 109 flavicollis (101 matches)"))
[1] "Trial 1 58 cervicornis (52 match)"
[2] "Trial 2 60 terrestris (51 matched)"
[3] "Trial 8 109 flavicollis (101 matches)"
The first task is to remove the material on numbers of matches including the brackets:
gsub(" *$", "", gsub("\\(.*\\)$", "", entries))
[1] "Trial 1 58 cervicornis" "Trial 2 60 terrestris"
[3] "Trial 8 109 flavicollis"

The first argument " *$", "", removes the "trailing blanks" while the second deletes every
thing .∗ between the left \\(and right \\) hand brackets "\\(.*\\)$" substituting this with nothing
"". The next job is to strip out the material in brackets and to extract that material, ignoring
the brackets themselves:
pos<- regexpr("\\(.*\\)$", entries)
substring(entries, first=pos+1, last=pos+attr(pos,"match.length")-2)
[1] "52 match" "51 matched" "101 matches"
To see how this has worked it is useful to inspect the values of pos that have emerged from
the regexpr function:
pos
[1] 25 23 25
attr(,"match.length")
[1] 10 12 13
The left-hand bracket appears in position 25 in the first and third elements (note that there
are two blanks before ‘cervicornis’) but in position 23 in the second element. Now the
lengths of the strings matching the pattern \\(.*\\)$ can be checked; it is the number of
‘anything’ characters between the two brackets, plus one for each bracket: 10, 12 and 13.
Thus, to extract the material in brackets, but to ignore the brackets themselves, we need
to locate the first character to be extracted (pos+1) and the last character to be extracted
pos+attr(pos,"match.length")-2, then use the substring function to do the extracting. Note
that first and last are vectors of length 3 (= length(entries)).
Testing and Coercing in R
Objects have a type, and you can test the type of an object using an is.type function
(Table 2.4). For instance, mathematical functions expect numeric input and text-processing
Table 2.4. Functions for testing (is) the attributes of different categories of
object (arrays, lists, etc.) and for coercing (as) the attributes of an object into
a specified form. Neither operation changes the attributes of the object.
Type Testing Coercing
Array is.array as.array
Character is.character as.character
Complex is.complex as.complex
Dataframe is.data.frame as.data.frame
Double is.double as.double
Factor is.factor as.factor
List is.list as.list
Logical is.logical as.logical
Matrix is.matrix as.matrix
Numeric is.numeric as.numeric
Raw is.raw as.raw
Time series (ts) is.ts as.ts
Vector is.vector as.vector

functions expect character input. Some types of objects can be coerced into other types. A
familiar type of coercion occurs when we interpret the TRUE and FALSE of logical variables
as numeric 1 and 0, respectively. Factor levels can be coerced to numbers. Numbers can be
coerced into characters, but non-numeric characters cannot be coerced into numbers.
as.numeric(factor(c("a","b","c")))
[1] 1 2 3
as.numeric(c("a","b","c"))
[1] NA NA NA
Warning message:
NAs introduced by coercion
as.numeric(c("a","4","c"))
[1] NA 4 NA
Warning message:
NAs introduced by coercion
If you try to coerce complex numbers to numeric the imaginary part will be discarded. Note
that is.complex and is.numeric are never both TRUE.
We often want to coerce tables into the form of vectors as a simple way of stripping off
their dimnames (using as.vector), and to turn matrixes into dataframes (as.data.frame).
A lot of testing involves the NOT operator ! in functions to return an error message if the
wrong type is supplied. For instance, if you were writing a function to calculate geometric
means you might want to test to ensure that the input was numeric using the !is.numeric
function
geometric<-function(x){
if(!is.numeric(x)) stop ("Input must be numeric")
exp(mean(log(x))) }
Here is what happens when you try to work out the geometric mean of character data
geometric(c("a","b","c"))
Error in geometric(c("a", "b", "c")) : Input must be numeric
You might also want to check that there are no zeros or negative numbers in the input,
because it would make no sense to try to calculate a geometric mean of such data:
geometric<-function(x){
if(!is.numeric(x)) stop ("Input must be numeric")
if(min(x)<=0) stop ("Input must be greater than zero")
exp(mean(log(x))) }
Testing this:
geometric(c(2,3,0,4))
Error in geometric(c(2, 3, 0, 4)) : Input must be greater than zero
But when the data are OK there will be no messages, just the numeric answer:
geometric(c(10,1000,10,1,1))
[1] 10

Dates and Times in R
The measurement of time is highly idiosyncratic. Successive years start on different days
of the week. There are months with different numbers of days. Leap years have an extra
day in February. Americans and Britons put the day and the month in different places:
3/4/2006 is March 4 for the former and April 3 for the latter. Occasional years have an
additional ‘leap second’ added to them because friction from the tides is slowing down the
rotation of the earth from when the standard time was set on the basis of the tropical year
in 1900. The cumulative effect of having set the atomic clock too slow accounts for the
continual need to insert leap seconds (32 of them since 1958). There is currently a debate
about abandoning leap seconds and introducing a ‘leap minute’ every century or so instead.
Calculations involving times are complicated by the operation of time zones and daylight
saving schemes in different countries. All these things mean that working with dates and
times is excruciatingly complicated. Fortunately, R has a robust system for dealing with this
complexity. To see how R handles dates and times, have a look at Sys.time():
Sys.time()
[1] "2005-10-23 10:17:42 GMT Daylight Time"
The answer is strictly hierarchical from left to right: the longest time scale (years) comes
first, then month then day separated by hyphens (minus signs), then there is a blank space
and the time, hours first (in the 24-hour clock) then minutes, then seconds separated by
colons. Finally there is a character string explaining the time zone. You can extract the date
from Sys.time() using substr like this:
substr(as.character(Sys.time()),1,10)
[1] "2005-10-23"
or the time
substr(as.character(Sys.time()),12,19)
[1] "10:17:42"
If you type
unclass(Sys.time())
[1] 1130679208
you get the number of seconds since 1 January 1970. There are two basic classes of
date/times. Class POSIXct represents the (signed) number of seconds since the beginning
of 1970 as a numeric vector: this is more convenient for including in dataframes. Class
POSIXlt is a named list of vectors closer to human-readable forms, representing seconds,
minutes, hours, days, months and years. R will tell you the date and time with the date
function:
date()
[1] "Fri Oct 21 06:37:04 2005"
The default order is day name, month name (both abbreviated), day of the month, hour
(24-hour clock), minute, second (separated by colons) then the year. You can convert
Sys.time to an object that inherits from class POSIXlt like this:
date<- as.POSIXlt(Sys.time())
You can use the element name operator $ to extract parts of the date and time from this
object using the following names: sec, min, hour, mday, mon, year, wday, yday and
isdst (with obvious meanings except for mday (=day number within the month), wday
(day of the week starting at 0 = Sunday), yday (day of the year after 1 January = 0) and
isdst which means ‘is daylight savings time in operation?’ with logical 1 for TRUE or 0
for FALSE). Here we extract the day of the week (date$wday = 0 meaning Sunday) and
the Julian date (day of the year after 1 January as date$yday)
date$wday
[1] 0
date$yday
[1] 295
for 23 October. Use unclass with unlist to view all of the components of date:
unlist(unclass(date))
sec
42
min
17
hour
10
mday
23
mon
9
year
105
wday
0
yday
295
isdst
1
Note that the month of October is 9 (not 10) because January is scored as month 0, and
years are scored as post-1900.
Calculations with dates and times
You can do the following calculations with dates and times:
• time + number
• time – number
• time1 – time2
• time1 ‘logical operation’ time2
where the logical operations are one of ==, !=, <, <=, '>' or >=. You can add or subtract
a number of seconds or a difftime object (see below) from a date-time object, but you
cannot add two date-time objects. Subtraction of two date-time objects is equivalent to using
difftime (see below). Unless a time zone has been specified, POSIXlt objects are interpreted
as being in the current time zone in calculations.
The thing you need to grasp is that you should convert your dates and times into
POSIXlt objects before starting to do any calculations. Once they are POSIXlt objects, it
is straightforward to calculate means, differences and so on. Here we want to calculate the
number of days between two dates, 22 October 2003 and 22 October 2005:
y2<-as.POSIXlt("2003-10-22")
y1<-as.POSIXlt("2005-10-22")
Now you can do calculations with the two dates:
y1-y2
Time difference of 731 days
Note that you cannot add two dates. It is easy to calculate differences between times using
this system. Note that the dates are separated by hyphens whereas the times are separated
by colons:
y3<-as.POSIXlt("2005-10-22 09:30:59")
y4<-as.POSIXlt("2005-10-22 12:45:06")
y4-y3
Time difference of 3.235278 hours
The difftime function
Working out the time difference between to dates and times involves the difftime function,
which takes two date-time objects as its arguments. The function returns an object of class
difftime with an attribute indicating the units. How many days elapsed between 15 August
2003 and 21 October 2005?
difftime("2005-10-21","2003-8-15")
Time difference of 798 days
If you want only the number of days, for instance to use in calculation, then write
as.numeric(difftime("2005-10-21","2003-8-15"))
[1] 798
For differences in hours include the times (colon-separated) and write
difftime("2005-10-21 5:12:32","2005-10-21 6:14:21")
Time difference of -1.030278 hours
The result is negative because the first time (on the left) is before the second time (on the
right). Alternatively, you can subtract one date-time object from another directly:
ISOdate(2005,10,21)-ISOdate(2003,8,15)
Time difference of 798 days
You can convert character stings into difftime objects using the as.difftime function:
as.difftime(c("0:3:20", "11:23:15"))
Time differences of 3.333333, 683.250000 mins
You can specify the format of your times. For instance, you may have no information on
seconds, and your times are specified just as hours (format %H) and minutes (%M). This
is what you do:
as.difftime(c("3:20", "23:15", "2:"), format= "%H:%M")
Time differences of 3.333333, 23.250000, NA hours
Because the last time in the sequence ‘2:’ had no minutes it is marked as NA.
The strptime function
You can ‘strip a date’ out of a character string using the strptime function. There are
functions to convert between character representations and objects of classes POSIXlt and
POSIXct representing calendar dates and times. The details of the formats are system-
specific, but the following are defined by the POSIX standard for strptime and are likely
to be widely available. Any character in the format string other than the % symbol is
interpreted literally.
%a
Abbreviated weekday name
%A Full weekday name
%b
Abbreviated month name
%B Full month name
%c Date and time, locale-specific
%d Day of the month as decimal number (01–31)
%H Hours as decimal number (00–23) on the 24-hour clock
%I Hours as decimal number (01–12) on the 12-hour clock
%j Day of year as decimal number (001–366)
%m Month as decimal number (01–12)
%M Minute as decimal number (00–59)
%p AM/PM indicator in the locale
%S Second as decimal number (00–61, allowing for two ‘leap seconds’)
%U Week of the year (00–53) using the first Sunday as day 1 of week 1
%w Weekday as decimal number (0–6, Sunday is 0)
%W Week of the year (00–53) using the first Monday as day 1 of week 1
%x
Date, locale-specific
%X Time, locale-specific
%Y Year with century
%Z
Time zone as a character string (output only)
Where leading zeros are shown they will be used on output but are optional on input.
Dates in Excel spreadsheets
The trick is to learn how to specify the format of your dates properly in strptime. If you
had dates (and no times) in a dataframe in Excel format (day/month/year)
excel.dates <- c("27/02/2004", "27/02/2005", "14/01/2003",
"28/06/2005", "01/01/1999")
then the appropriate format would be "%d/%m/%Y" showing the format names (from
the list above) and the ‘slash’ separators / (note the upper case for year %Y; this is the
unambiguous year including the century, 2005 rather than the potentially ambiguous 05 for
which the format is %y). To turn these into R dates, write
strptime(excel.dates,format="%d/%m/%Y")
[1] "2004-02-27" "2005-02-27" "2003-01-14" "2005-06-28" "1999-01-01"
Here is another example, but with years in two-digit form (%y), and the months as abbre-
viated names (%b) and no separators:
other.dates<- c("1jan99", "2jan05", "31mar04", "30jul05")
strptime(other.dates, "%d%b%y")
[1] "1999-01-01" "2005-01-02" "2004-03-31" "2005-07-30"
You will often want to create POSIXlt objects from components stored in vectors within
dataframes. For instance, here is a dataframe with the hours, minutes and seconds from an
experiment with two factor levels in separate columns:
times<-read.table("c:\\temp\\times.txt",header=T)
times
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
hrs
2
3
3
2
3
2
3
1
2
1
2
3
2
1
2
1
min
23
16
2
45
4
56
12
57
22
42
31
15
28
55
17
48
sec
6
17
56
0
42
25
28
12
22
7
17
16
4
34
7
48
experiment
A
A
A
A
A
A
A
A
B
B
B
B
B
B
B
B
attach(times)
Because the times are not in POSIXlt format, you need to paste together the hours, minutes
and seconds into a character string with colons as the separator:
paste(hrs,min,sec,sep=":")
[1] "2:23:6" "3:16:17" "3:2:56" "2:45:0" "3:4:42" "2:56:25" "3:12:28"
[8] "1:57:12" "2:22:22" "1:42:7" "2:31:17" "3:15:16" "2:28:4" "1:55:34"
[15] "2:17:7" "1:48:48"
Now save this object as a difftime vector called duration:
duration<-as.difftime (paste(hrs,min,sec,sep=":"))
Then you can carry out calculations like mean and variance using the tapply function:


\n
\r
\t
\b
\a
\f
\v
newline
carriage return
tab character
backspace
bell
form feed
vertical tab

setwd("c:\\temp")


read.table("daphnia.txt",header=T)
If you want to find out the name of the current working directory, use getwd():
getwd()
[1] "c:/temp"

It can be useful to check whether a given filename exists in the path where you think it
should be. The function is file.exists and is used like this:
file.exists("c:\\temp\\Decay.txt")
[1] TRUE

For more on file handling, see ?files.

Built-in Data Files
There are many built-in data sets within the base package of R. You can see their names
by typing
data()
You can read the documentation for a particular data set with the usual query:
?lynx
Many of the contributed packages contain data sets, and you can view their names using
the try function. This evaluates an expression and traps any errors that occur during the
evaluation. The try function establishes a handler for errors that uses the default error
handling protocol:
try(data(package="spatstat"));Sys.sleep(3)
try(data(package="spdep"));Sys.sleep(3)
try(data(package="MASS"))
Built-in data files can be attached in the normal way; then the variables within them accessed
by their names:
attach(OrchardSprays)
decrease
Reading Data from Files with Non-standard Formats Using scan
The scan function is very flexible, but as a consequence of this, it is much harder to use
than read.table. This example uses the US murder data. The filename comes first, in the
usual format (enclosed in double quotes and using paired backslashes to separate the drive
name from the folder name and the folder name from the file name). Then comes skip=1
because the first line of the file contains the variable names (as indicated by header=T in
a read.table function). Next comes what, which is a list of length the number of variables
(the number of columns to be read; 4 in this case) specifying their type (character “ ” in
this case):
murders<-scan("c:\\temp\\murders.txt", skip=1, what=list("","","",""))
Read 50 records
The object produced by scan is a list rather than a dataframe as you can see from

class(murders)
[1] "list"
It is simple to convert the list to a dataframe using the as.data.frame function
murder.frame<-as.data.frame(murders)
You are likely to want to use the variables names from the file as variable names in the
dataframe. To do this, read just the first line of the file using scan with nlines=1:
murder.names<-
scan("c:\\temp\\murders.txt",nlines=1,what="character",quiet=T)
murder.names
[1] "state" "population" "murder" "region"
Note the use of quiet=T to switch off the report of how many records were read. Now give
these names to the columns of the dataframe
names(murder.frame)<-murder.names
Finally, convert columns 2 and 3 of the dataframe from factors to numbers:
murder.frame[,2]<-as.numeric(murder.frame[,2])
murder.frame[,3]<-as.numeric(murder.frame[,3])
summary(murder.frame)
state
Alabama
Alaska
Arizona
Arkansas
California
Colorado
(Other)
: 1
: 1
: 1
: 1
: 1
: 1
:44
population
Min.
: 1.00
1st Qu. :13.25
Median :25.50
Mean
:25.50
3rd Qu. :37.75
Max.
:50.00
murder
Min.
: 1.00
1st Qu. :11.25
Median :22.50
Mean
:22.10
3rd Qu. :32.75
Max.
:44.00
region
North.Central
Northeast
South
West
:12
: 9
:16
:13
You can see why people prefer to use read.table for this sort of data file:
murders<-read.table("c:\\temp\\murders.txt",header=T)
summary(murders)
state
Alabama
Alaska
Arizona
Arkansas
California
Colorado
(Other)
: 1
: 1
: 1
: 1
: 1
: 1
:44
population
Min.
: 365
1st Qu. : 1080
Median : 2839
Mean
: 4246
3rd Qu. : 4969
Max.
:21198
murder
Min.
: 1.400
1st Qu. : 4.350
Median : 6.850
Mean
: 7.378
3rd Qu. :10.675
Max.
:15.100
region
North.Central
Northeast
South
West
:12
: 9
:16
:13
Note, however, that the scan function is quicker than read.table for input of large (numeric
only) matrices.

readLines("~/sdcard1/licenseRequest.xml",n=-1)


Learning how to handle your data, how to enter it into the computer, and how to read the

by(worms,Vegetation,mean)

This is a key feature of the R language, and one that causes problems for beginners. Note
that these two apparently similar commands create objects of different classes:
class(worms[3,])
[1] "data.frame"
class(worms[,3])
[1] "integer"


Selecting Rows from the Dataframe at Random
In bootstrapping or cross-validation we might want to select certain rows from the dataframe
at random. We use the sample function to do this: the default replace = FALSE performs
shuffling (each row is selected once and only once), while the option replace = TRUE
(sampling with replacement) allows for multiple copies of certain rows. Here we use
replace = F to select a unique 8 of the 20 rows at random:
worms[sample(1:20,8),]
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
7 Church.Field 3.5 3 Grassland 4.2 FALSE 3
17 Cheapside 2.2 8 Scrub 4.7 TRUE 4
19 Gravel.Pit 2.9 1 Grassland 3.5 FALSE 1
14 Observatory.Ridge 1.8 6 Grassland 3.8 FALSE 0
12 North.Gravel 3.3 1 Grassland 4.1 FALSE 1
9 The.Orchard 1.9 0 Orchard 5.7 FALSE 9
11 Garden.Wood 2.9 10 Scrub 5.2 FALSE 8
8 Ashurst 2.1 0 Arable 4.8 FALSE 4
Note that the row numbers are in random sequence (not sorted), so that if you want a sorted
random sample you will need to order the dataframe after the randomization.

Sorting Dataframes
It is common to want to sort a dataframe by rows, but rare to want to sort by columns.
Because we are sorting by rows (the first subscript) we specify the order of the row
subscripts before the comma. Thus, to sort the dataframe on the basis of values in one of
the columns (say, Slope), we write
worms[order(Slope),]
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
5 Gunness.Thicket 3.8 0 Scrub 4.2 FALSE 6
8 Ashurst 2.1 0 Arable 4.8 FALSE 4
9 The.Orchard 1.9 0 Orchard 5.7 FALSE 9
15 Pond.Field 4.1 0 Meadow 5.0 TRUE 6
16 Water.Meadow 3.9 0 Meadow 4.9 TRUE 8
12 North.Gravel 3.3 1 Grassland 4.1 FALSE 1
19 Gravel.Pit 2.9 1 Grassland 3.5 FALSE 1
2 Silwood.Bottom 5.1 2 Arable 5.2 FALSE 7
6 Oak.Mead 3.1 2 Grassland 3.9 FALSE 2
13 South.Gravel 3.7 2 Grassland 4.0 FALSE 2
18 Pound.Hill 4.4 2 Arable 4.5 FALSE 5
3 Nursery.Field 2.8 3 Grassland 4.3 FALSE 2
7 Church.Field 3.5 3 Grassland 4.2 FALSE 3
10 Rookery.Slope 1.5 4 Grassland 5.0 TRUE 7
4 Rush.Meadow 2.4 5 Meadow 4.9 TRUE 5
14 Observatory.Ridge 1.8 6 Grassland 3.8 FALSE 0
17 Cheapside 2.2 8 Scrub 4.7 TRUE 4
11 Garden.Wood 2.9 10 Scrub 5.2 FALSE 8
20 Farm.Wood 0.8 10 Scrub 5.1 TRUE 3
1 Nashs.Field 3.6 11 Grassland 4.1 FALSE 4

There are some points to notice here. Because we wanted the sorting to apply to all the
columns, the column subscript (after the comma) is blank: [order(Slope),]. The original row
numbers are retained in the leftmost column. Where there are ties for the sorting variable
(e.g. there are five ties for Slope = 0) then the rows are in their original order. If you want
the dataframe in reverse order (ascending order) then use the rev function outside the order
function like this:
worms[rev(order(Slope)),]
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
1 Nashs.Field 3.6 11 Grassland 4.1 FALSE 4
20 Farm.Wood 0.8 10 Scrub 5.1 TRUE 3
11 Garden.Wood 2.9 10 Scrub 5.2 FALSE 8
17 Cheapside 2.2 8 Scrub 4.7 TRUE 4
14 Observatory.Ridge 1.8 6 Grassland 3.8 FALSE 0
4 Rush.Meadow 2.4 5 Meadow 4.9 TRUE 5
10 Rookery.Slope 1.5 4 Grassland 5.0 TRUE 7
7 Church.Field 3.5 3 Grassland 4.2 FALSE 3
3 Nursery.Field 2.8 3 Grassland 4.3 FALSE 2
18 Pound.Hill 4.4 2 Arable 4.5 FALSE 5
13 South.Gravel 3.7 2 Grassland 4.0 FALSE 2
6 Oak.Mead 3.1 2 Grassland 3.9 FALSE 2
2 Silwood.Bottom 5.1 2 Arable 5.2 FALSE 7
19 Gravel.Pit 2.9 1 Grassland 3.5 FALSE 1
12 North.Gravel 3.3 1 Grassland 4.1 FALSE 1
16 Water.Meadow 3.9 0 Meadow 4.9 TRUE 8
15 Pond.Field 4.1 0 Meadow 5.0 TRUE 6
9 The.Orchard 1.9 0 Orchard 5.7 FALSE 9
8 Ashurst 2.1 0 Arable 4.8 FALSE 4
5 Gunness.Thicket 3.8 0 Scrub 4.2 FALSE 6
Notice, now, that when there are ties (e.g. Slope = 0), the original rows are also in
reverse order.
More complicated sorting operations might involve two or more variables. This is achieved
very simply by separating a series of variable names by commas within the order function.
R will sort on the basis of the left-hand variable, with ties being broken by the second
variable, and so on. Suppose that we want to order the rows of the database on worm density
within each vegetation type:
worms[order(Vegetation,Worm.density),]
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
8 Ashurst 2.1 0 Arable 4.8 FALSE 4
18 Pound.Hill 4.4 2 Arable 4.5 FALSE 5
2 Silwood.Bottom 5.1 2 Arable 5.2 FALSE 7
14 Observatory.Ridge 1.8 6 Grassland 3.8 FALSE 0
12 North.Gravel 3.3 1 Grassland 4.1 FALSE 1
19 Gravel.Pit 2.9 1 Grassland 3.5 FALSE 1
3 Nursery.Field 2.8 3 Grassland 4.3 FALSE 2
6 Oak.Mead 3.1 2 Grassland 3.9 FALSE 2
13 South.Gravel 3.7 2 Grassland 4.0 FALSE 2
7 Church.Field 3.5 3 Grassland 4.2 FALSE 3
1 Nashs.Field 3.6 11 Grassland 4.1 FALSE 4
10 Rookery.Slope 1.5 4 Grassland 5.0 TRUE 7
4 Rush.Meadow 2.4 5 Meadow 4.9 TRUE 5
15 Pond.Field 4.1 0 Meadow 5.0 TRUE 6
16 Water.Meadow 3.9 0 Meadow 4.9 TRUE 8

worms[order(Vegetation,Worm.density),]
worms[order(Vegetation,Worm.density,Soil.pH),]
worms[order(Vegetation,Worm.density),]
worms[rev(order(Slope)),]

worms[order(Vegetation,Worm.density),
c("Vegetation", "Worm.density", "Soil.pH", "Slope")]

worms[Damp == T,]

worms[Worm.density > median(Worm.density) & Soil.pH < 5.2,]

Suppose that we want to extract all the columns that contain numbers (rather than
characters or logical variables) from the dataframe. The function is.numeric can be applied
across all the columns of worms using sapply to create subscripts like this:
worms[,sapply(worms,is.numeric)]

We might want to extract the columns that were factors:
worms[,sapply(worms,is.factor)]

negative subscripts
worms[-(6:15),]

worms[!(Vegetation=="Grassland"),]

worms[-which(Damp==F),]

worms[!Damp==F,]
or even simpler,
worms[Damp==T,]

Omitting Rows Containing Missing Values, NA

na.omit(df_obj)
and you see that rows 2, 7 and 19 have been omitted in creating the new dataframe. Alter
natively, you can use the na.exclude function. This differs from na.omit only in the class
of the na.action attribute of the result, which gives different behaviour in functions making
use of naresid and napredict: when na.exclude is used the residuals and predictions are
padded to the correct length by inserting NAs for cases omitted by na.exclude (in this
example they would be of length 20, whereas na.omit would give residuals and predictions
of length 17).

complete.cases(data)
data[complete.cases(data),]

new.frame<-na.exclude(data)
apply(apply(data,2,is.na),2,sum)


It is well worth checking the individual variables separately, because it is possible that
one (or a few) variable(s) contributes most of the missing values, and it may be preferable
to remove these variables from the modelling rather than lose the valuable information
about the other explanatory variables associated with these cases. Use summary to count
the missing values for each variable in the dataframe, or use apply with the function is.na
to sum up the missing values in each variable:
apply(apply(data,2,is.na),2,sum)
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
0 1 1 0 1 1 1
You can see that in this case no single variable contributes more missing values than
any other.

In this rather more complicated example, you are asked to extract a single record for each
vegetation type, and that record is to be the case within that vegetation type that has the
greatest worm density. There are two steps to this: first order all of the rows of the dataframe
using rev(order(Worm.density)), then select the subset of these rows which is unique for
vegetation type:
worms[rev(order(Worm.density)),][unique(Vegetation),]
Field.Name Area Slope Vegetation Soil.pH Damp Worm.density
16 Water.Meadow 3.9 0 Meadow 4.9 TRUE 8
9 The.Orchard 1.9 0 Orchard 5.7 FALSE 9
11 Garden.Wood 2.9 10 Scrub 5.2 FALSE 8
2 Silwood.Bottom 5.1 2 Arable 5.2 FALSE 7
10 Rookery.Slope 1.5 4 Grassland 5.0 TRUE 7


worms[rev(order(Worm.density)),][unique(Vegetation),]

The trick here is to use order (rather
than rev(order())) but to put a minus sign in front of Worm.density like this:
worms[order(Vegetation,-Worm.density),]

Using the minus sign only works when sorting numerical variables. For factor levels you
can use the rank function to make the levels numeric like this:

worms[order(-rank(Vegetation),-Worm.density),]


names(worms)
[1] "Field.Name" "Area" "Slope" "Vegetation"
[5] "Soil.pH" "Damp" "Worm.density"
so we want our function grep to pick out variables numbers 3 and 5 because they are the
only ones containing upper-case S:
grep("S",names(worms))
[1] 3 5
Finally, we can use these numbers as subscripts [,c(3,5)] to select columns 3 and 5:
worms[,grep("S",names(worms))]
Slope Soil.pH
1 11 4.1
2 2 5.2
3 3 4.3
4 5 4.9
5 0 4.2
6 2 3.9
7 3 4.2
8 0 4.8
9 0 5.7

detach(worms)
worms<-read.table("c:\\temp\\worms.txt",header=T,row.names=1)
worms
Eliminating Duplicate Rows from a Dataframe

unique(dups)

dups[duplicated(dups),]

date<-"02/12/2003"
dates<-strptime(date,format="%d/%m/%Y")

strftime

> dates %>% class
[1] "POSIXlt" "POSIXt" 
> dates %>% strftime
[1] "2003-12-02"
> dates
[1] "2003-12-02 CST"
> dates %>% strftime %>% class
[1] "character"
> dates %>% strftime %>% class
nums<-cbind(nums,dates)

nums[order(as.character(dates)),1:4]
subset(nums,select=c("name","dates"))

Selecting Variables on the Basis of their Attributes
In this example, we want to extract all of the columns from nums (above) that are numeric.
Use sapply to obtain a vector of logical values:
sapply(nums,is.numeric)
name date response treatment dates
FALSE FALSE TRUE FALSE TRUE
Now use this object to form the column subscripts to extract the two numeric variables:
nums[,sapply(nums,is.numeric)]
response dates
1 0.05963704 2003-08-25
2 1.46555993 2003-05-21
3 1.59406539 2003-10-12
4 2.09505949 2003-12-02
Note that dates is numeric but date was not (it is a factor, having been converted from a
character string by the read.table function).

sapply(nums,is.numeric)
nums[,sapply(nums,is.numeric)]
Selecting Variables on the Basis of their Attributes
In this example, we want to extract all of the columns from nums (above) that are numeric.
Use sapply to obtain a vector of logical values:
sapply(nums,is.numeric)
name date response treatment dates
FALSE FALSE TRUE FALSE TRUE
Now use this object to form the column subscripts to extract the two numeric variables:
nums[,sapply(nums,is.numeric)]
response dates
1 0.05963704 2003-08-25
2 1.46555993 2003-05-21
3 1.59406539 2003-10-12
4 2.09505949 2003-12-02
Note that dates is numeric but date was not (it is a factor, having been converted from a
character string by the read.table function).


Using the match Function in Dataframes
The worms dataframe (above) contains fields of five different vegetation types:
unique(worms$Vegetation)
[1] Grassland Arable Meadow Scrub Orchard
and we want to know the appropriate herbicides to use in each of the 20 fields. The
herbicides are in a separate dataframe that contains the recommended herbicides for a much
larger set of plant community types:
herbicides<-read.table("c:\\temp\\herbicides.txt",header=T)
herbicides

match {base}	R Documentation
Value Matching
Description

match returns a vector of the positions of (first) matches of its first argument in its second.

%in% is a more intuitive interface as a binary operator, which returns a logical vector indicating if there is a match or not for its left operand.
Usage

match(x, table, nomatch = NA_integer_, incomparables = NULL)

x %in% table

Arguments
x 	

vector or NULL: the values to be matched. Long vectors are supported.
table 	

vector or NULL: the values to be matched against. Long vectors are not supported.
nomatch 	

the value to be returned in the case when no match is found. Note that it is coerced to integer.
incomparables 	

a vector of values that cannot be matched. Any value in x matching a value in this vector is assigned the nomatch value. For historical reasons, FALSE is equivalent to NULL.
Details

%in% is currently defined as
"%in%" <- function(x, table) match(x, table, nomatch = 0) > 0

Factors, raw vectors and lists are converted to character vectors, and then x and table are coerced to a common type (the later of the two types in R's ordering, logical < integer < numeric < complex < character) before matching. If incomparables has positive length it is coerced to the common type.

Matching for lists is potentially very slow and best avoided except in simple cases.

Exactly what matches what is to some extent a matter of definition. For all types, NA matches NA and no other value. For real and complex values, NaN values are regarded as matching any other NaN value, but not matching NA.

That %in% never returns NA makes it particularly useful in if conditions.

Character strings will be compared as byte sequences if any input is marked as "bytes" (see Encoding).
Value

A vector of the same length as x.

match: An integer vector giving the position in table of the first match if there is a match, otherwise nomatch.

If x[i] is found to equal table[j] then the value returned in the i-th position of the return value is j, for the smallest possible j. If no match is found, the value is nomatch.

%in%: A logical vector, indicating if a match was located for each element of x: thus the values are TRUE or FALSE and never NA.
References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
See Also

pmatch and charmatch for (partial) string matching, match.arg, etc for function argument matching. findInterval similarly returns a vector of positions, but finds numbers within intervals, rather than exact matches.

is.element for an S-compatible equivalent of %in%.
Examples

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


you want to include all the species, with missing values (NA) inserted when flowering
times or lifeforms are not known, then use the all=T option:
(both<-merge(flowering,lifeforms,all=T))
merge(both,seeds,by.x=c("Genus","species"),by.y=c("name1","name2"))

Adding Margins to a Dataframe

people<-rowMeans(frame[,2:5])
people<-people-mean(people)
people
(new.frame<-cbind(frame,people))
seasons<-colMeans(frame[,2:5])
seasons<-seasons-mean(seasons)
seasons
new.row<-new.frame[1,]
new.row[1]<-"seasonal effects"
new.row[2:5]<-seasons
new.row[6]<-0
(new.frame<-rbind(new.frame,new.row))
gm<-mean(unlist(new.frame[1:5,2:5]))
gm<-rep(gm,4)
new.frame[1:5,2:5]<-sweep(new.frame[1:5,2:5],2,gm)
new.frame
name spring summer autumn winter people
1 Jane.Smith 0.55 4.55 -2.45 -1.45 0.30
2 Robert.Jones 3.55 4.55 -3.45 -0.45 1.05
3 Dick.Rogers -1.45 2.55 -4.45 0.55 -0.70
4 William.Edwards 1.55 0.55 -2.45 -3.45 -0.95
5 Janet.Jones -2.45 3.55 -2.45 2.55 0.30
11 seasonal effects 0.35 3.15 -3.05 -0.45 0.00

• summary summarize all the contents of all the variables
• aggregate create a table after the fashion of tapply
• by perform functions for each level of specified factors
Use of summary and by with the worms database on p. 110.
The other useful function for summarizing a dataframe is aggregate. It is used like tapply
(see p. 18) to apply a function (mean in this case) to the levels of a specified categorical
variable (Vegetation in this case) for a specified range of variables (Area, Slope, Soil.pH and
Worm.density are defined using their subscripts as a column index in worms[,c(2,3,5,7)]):
aggregate(worms[,c(2,3,5,7)],by=list(veg=Vegetation),mean)
veg Area Slope Soil.pH Worm.density
1 Arable 3.866667 1.333333 4.833333 5.333333
2 Grassland 2.911111 3.666667 4.100000 2.444444
3 Meadow 3.466667 1.666667 4.933333 6.333333
4 Orchard 1.900000 0.000000 5.700000 9.000000
5 Scrub 2.425000 7.000000 4.800000 5.250000

aggregate(worms[,c(2,3,5,7)],by=list(veg=Vegetation,d=Damp),mean)

• plot(x,y) scatterplot of y against x
• plot(factor, y) box-and-whisker plot of y at levels of factor
• barplot(y) heights from a vector of y values

Plotting with two continuous explanatory variables: scatterplots

• Cartesian plot(x,y)
• formula plot(y~x)
The advantage of the formula-based plot is that the plot function and the model fit look
and feel the same (response variable, tilde, explanatory variable). If you use Cartesian plots
(eastings first, then northings, like the grid reference on a map) then the plot has ‘x then y’
while the model has ‘y then x’.
At its most basic, the plot function needs only two arguments: first the name of the
explanatory variable (x in this case), and second the name of the response variable (y in
this case): plot(x,y). The data we want to plot are read into R from a file:
data1<-read.table("c:\\temp\\scatter1.txt",header=T)
attach(data1)
names(data1)
[1] "xv" "ys"
Producing the scatterplot could not be simpler: just type
plot(xv,ys,col="red")
with the vector of x values first, then the vector of y values (changing the colour of the
points is optional). Notice that the axes are labelled with the variable names, unless you
chose to override these with xlab and ylab. It is often a good idea to have longer, more
explicit labels for the axes than are provided by the variable names that are used as default
options ( xv and ys in this case). Suppose we want to change the label ‘xv’ into the longer
label ‘Explanatory variable’ and the label on the y axis from ‘ys’ to ‘Response variable’.
Then we use xlab and ylab like this:
plot(xv,ys,col="red,xlab="Explanatory variable",ylab="Response variable")
The great thing about graphics in R is that it is extremely straightforward to add things to
your plots. In the present case, we might want to add a regression line through the cloud of
data points. The function for this is abline which can take as its argument the linear model
object lm(ys~xv) (as explained on p. 387):
abline(lm(ys~xv))
Just as it is easy to add lines to the plot, so it is straightforward to add more points. The
extra points are in another file:
data2<-read.table("c:\\temp\\scatter2.txt",header=T)
attach(data2)
names(data2)
[1] "xv2" "ys2"
The new points (xv2,ys2) are added using the points function like this:
points(xv2,ys2,col="blue")
and we can finish by adding a regression line to the extra points:
abline(lm(ys2~xv2))
This example shows a very important feature of the plot function. Notice that several of
the lower values from the second (blue) data set have not appeared on the graph. This is
because (unless we say otherwise at the outset) R chooses ‘pretty’ scaling for the axes based
on the data range in the first set of points to be drawn. If, as here, the range of subsequent
data sets lies outside the scale of the x and y axes, then points are simply left off without
any warning message.
One way to cure this problem is to plot all the data with type="n" so that the axes are
scaled to encompass all the points form all the data sets (using the concatenation function),
then to use points and lines to add the data to the blank axes, like this:
plot(c(xv,xv2),c(ys,ys2),xlab="x",ylab="y",type="n")
points(xv,ys,col="red")
points(xv2,ys2,col="blue")
abline(lm(ys~xv))
abline(lm(ys2~xv2))
Now all of the points from both data sets appear on the scattergraph. Another way to
ensure that all the data are within the plotted axes is to scale the axes yourself, rather than
rely on R’s choice of pretty scaling, using xlim and ylim. Each of these requires a vector
of length 2 to show the minimum and maximum values for each axis. These values are
automatically rounded to make them pretty for axis labelling. You will want to control
the scaling of the axes when you want two comparable graphs side by side, or when you
want to overlay several lines or sets of points on the same axes. Remember that the initial
plot function sets the axes scales: this can be a problem if subsequent lines or points are
off-scale.
A good way to find out the axis values is to use the range function applied to the data
sets in aggregate:
range(c(xv,xv2))
[1] 0.02849861 99.93262000
range(c(ys,ys2))
[1] 13.41794 62.59482
Here the x axis needs to go from 0.02 up to 99.93 (0 to 100 would be pretty) and the y
axis needs to go from 13.4 up to 62.6 (0 to 80 would be pretty). This is how the axes are
drawn; the points and lines are added exactly as before:
plot(c(xv,xv2),c(ys,ys2),xlim=c(0,100),ylim=c(0,80),xlab="x",ylab="y",type="n")
points(xv,ys,col="red")
points(xv2,ys2,col="blue")
abline(lm(ys~xv))
abline(lm(ys2~xv2))
Adding a legend to the plot to explain the difference between the two colours of points
would be useful. The thing to understand about the legend function is that the number of
lines of text inside the legend box is determined by the length of the vector containing the
labels (2 in this case: c("treatment","control") The other two vectors must be of the same
length as this: for the plotting symbols pch=c(1,1) and the colours col=c(2,4). The legend
function can be used with locator(1) to allow you to select exactly where on the plot surface
the legend box should be placed. Click the mouse button when the cursor is where you want
the top left of the box around the legend to be. It is useful to know the first six colours
(col=) used by the plot function:
• 1 black (the default)
• 2 red
• 3 green
• 4 blue
• 5 pale blue
• 6 purple
Here, the red circles (col = 2) are the treatment values and the blue circles (col = 4) are the
control values. Both are represented by open plotting symbols pch=c(1,1).
legend(locator(1),c("treatment","control"),pch=c(1,1),col=c(2,4))
This is about as complicated as you would want to make any figure. Adding more information
would begin to detract from the message.
Changing the plotting characters used in the points function and in scatterplots involves
the function pch: here is the full set of plotting characters:
plot(0:10,0:10,type="n",xlab="",ylab="")
k<- -1
for (i in c(2,5,8)) {
for (j in 0:9) {
k<-k+1
points(i,j,pch=k,cex=2)}}
Starting at y = 0 and proceeding vertically from x = 2, you see plotting symbols 0 (open
square), 1 (the default open circle), 2 (open triangle), 3 (plus) etc., up to 25 (by which point

plot(xv,ys,col="red,xlab="Explanatory variable",ylab="Response variable")

abline(lm(ys~xv))


data<-read.table("c:\\temp\\sleep.txt",header=T)
attach(data)
Subject<-factor(Subject)
plot(Days,Reaction,col=as.numeric(Subject),pch=as.numeric(Subject))

plot(hay,pH)
text(hay, pH, labels=round(FR, 2), pos=1, offset=0.5,cex=0.7)

plot(hay,pH,pch=16,col=ifelse(FR>median(FR),"red","black"))


for (i in 1:length(wanted)){
ii <- which(place == as.character(wanted[i]))
text(east[ii], nn[ii], as.character(place[ii]), cex = 0.6) }

Drawing mathematical functions
The curve function is used for this. Here is a plot of x3 − 3x between x = −2 and x = 2:
curve(x^3-3*x, -2, 2)
Here is the more cumbersome code to do the same thing using plot:
x<-seq(-2,2,0.01)
y<-x^3-3*x
plot(x,y,type="l")

Adding other shapes to a plot
Once you have produced a set of axes using plot it is straightforward to locate and insert
other kinds of things. Here are two unlabelled axes, without tick marks (xaxt="n"), both
scaled 0 to 10 but without any of the 11 points drawn on the axes (type="n"):
plot(0:10,0:10,xlab="",ylab="",xaxt="n",yaxt="n",type="n")
You can easily add extra graphical objects to plots:
• rect rectangles
• arrows arrows and bars
• polygon more complicated straight-sided shapes
For the purposes of demonstration we shall add a single-headed arrow, a double-headed
arrow, a rectangle and a six-sided polygon to this space.
We want to put a solid square object in the top right-hand corner, and we know the
precise coordinates to use. The syntax for the rect function is to provide four numbers:
rect(xleft, ybottom, xright, ytop)
so to plot the square from (6,6) to (9,9) involves
rect(6,6,9,9)

rectangle and you can use the locator() function for this. The rect function does not accept
locator as its arguments but you can easily write a function (here called corners) to do this:
corners<-function(){
coos<-c(unlist(locator(1)),unlist(locator(1)))
rect(coos[1],coos[2],coos[3],coos[4])
}
Run the function like this:
corners()
Then click in the bottom left-hand corner and again in the top right-hand corner, and a
rectangle will be drawn.
Drawing arrows as in the diagram above is straightforward. The syntax for the arrows
function to draw a line from the point (x0, y0) to the point (x1, y1) with the arrowhead, by
default, at the ‘second’ end (x1, y1) is:
arrows(x0, y0, x1, y1)
Thus, to draw an arrow from (1,1) to (3,8) with the head at (3,8) type
arrows(1,1,3,8)
A double-headed arrow from (1,9) to (5,9) is produced by adding code=3 like this:
arrows(1,9,5,9,code=3)
A vertical bar with two square ends (e.g. like an error bar) uses angle = 90 instead of the
default angle = 30)
arrows(4,1,4,6,code=3,angle=90)
Here is a function that draws an arrow from the cursor position of your first click to the
position of your second click:
click.arrows<-function(){
coos<-c(unlist(locator(1)),unlist(locator(1)))
arrows(coos[1],coos[2],coos[3],coos[4])
}
To run this, type
click.arrows()
We now wish to draw a polygon. To do this, it is often useful to save the values of a
series of locations. Here we intend to save the coordinates of six points in a vector called
locations to define a polygon for plotting
locations<-locator(6)
After you have clicked over the sixth location, control returns to the screen. What kind of
object has locator produced?
class(locations)
[1] "list"
Fitting non-linear parametric curves through a scatterplot
Here is a set of data showing a response variable, y (recruits to a fishery), as a function of
a continuous explanatory variable x (the size of the fish stock):
rm(x,y)
info<-read.table("c:\\temp\\plotfit.txt",header=T)
attach(info)
names(info)
[1] "x" "y"
plot(x,y,xlab="stock",ylab="recruits",pch=16)

We do not know the parameter values of the best-fit curve in advance, but we can estimate
them from the data using non-linear least squares nls. Note that you need to provide an
initial guesstimate for the two parameter values in what is called a ‘start list’ (p. 663 for
details):
model<-nls(y~a*x*exp(-b*x),start=list(a=500,b=0.05))
Formula: y ~ a * x * exp(-b * x)
Parameters:
Estimate Std. Error t value Pr(>t)
a 4.820e+02 1.593e+01 30.26 <2e-16 ***
b 4.461e-02 8.067e-04 55.29 <2e-16 ***
Residual standard error: 204.2 on 27 degrees of freedom
So the least-squares estimates of the two parameters are a = 4820 and b = 0044 61, and
their standard errors are 15.93 and 0.000 806 7 respectively. We already have a set of x
values, xv (above), so we can use predict to add this as a dashed line to the plot:
lines(xv,predict(model,list(x=xv)),lty=2)
Next, you want to compare this regression line with a theoretical model, which was
y = 480xe−0047x
We need to evaluate y across the xv values for the theoretical model:
yv<-480*xv*exp(-0.047*xv)
Now use the lines function to add this second curve to the plot as a solid line:

lines(xv,yv)
Notice that the regression model (dashed line) predicts the values of y for x > 30 much
better than the theoretical model (solid line), and that both models slightly underestimate
the values of y for x < 20. The plot is imperfect to the extent that the maximum of the
dashed regression curve does not fit within the limits of the y axis. You should correct this
as an exercise.
Fitting non-parametric curves through a scatterplot
It is common to want to fit a non-parametric smoothed curve through data, especially when
there is no obvious candidate for a parametric function. R offers a range of options:
• lowess (a non-parametric curve fitter);
• loess (a modelling tool);
• gam (fits generalized additive models; p. 611);
• lm for polynomial regression (fit a linear model involving powers of x).
We will illustrate these options using the jaws data. First, we load the data:
data<-read.table("c:\\temp\\jaws.txt",header=T)
attach(data)
names(data)
[1] "age" "bone"

Before we fit our curves to the data, we need to consider how best to display the results
together.
Without doubt, the graphical parameter you will change most often just happens to be the
least intuitive to use. This is the number of graphs per screen, called somewhat unhelpfully,
mfrow. The idea is simple, but the syntax is hard to remember. You need to specify the
number of rows of plots you want, and number of plots per row, in a vector of two numbers.
The first number is the number of rows and the second number is the number of graphs per
row. The vector is made using c in the normal way. The default single-plot screen is
par(mfrow=c(1,1))
Two plots side by side is
par(mfrow=c(1,2))
A panel of four plots in a 2 × 2 square is
par(mfrow=c(2,2))
To move from one plot to the next, you need to execute a new plot function. Control
stays within the same plot frame while you execute functions like points, lines or text.
Remember to return to the default single plot when you have finished your multiple plot by
executing par(mfrow=c(1,1)). If you have more than two graphs per row or per column,
the character expansion cex is set to 0.5 and you get half-size characters and labels.
Let us now plot our four graphs:
par(mfrow=c(2,2))
plot(age,bone,pch=16)
text(45,20,"lowess",pos=2)
lines(lowess(age,bone))
plot(age,bone,pch=16)
text(45,20,"loess",pos=2)
model<-loess(bone~age)
xv<-0:50
yv<-predict(model,data.frame(age=xv))
lines(xv,yv)
plot(age,bone,pch=16)
text(45,20,"gam",pos=2)
library(mgcv)
model<-gam(bone~s(age))
yv<-predict(model,list(age=xv))
lines(xv,yv)
plot(age,bone,pch=16)
text(45,20,"polynomial",pos=2)
model<-lm(bone~age+I(age^2)+I(age^3))
yv<-predict(model,list(age=xv))
lines(xv,yv)
The lowess function (top left) is a curve-smoothing function that returns x and y coordinates
that are drawn on the plot using the lines function. The modern loess function (top right) is
a modelling tool (y~x) from which the coordinates to be drawn by lines are extracted using

predict with a data.frame function containing the x values for plotting. Alternatively, you
can use a generalized additive model, gam (bottom left) to generate the smoothed curve
(y~s(x)) using predict. Finally, you might use a linear model with a polynomial function
of x (here a cubic, bottom right).
Joining the dots
Sometimes you want to join the points on a scatterplot by lines. The trick is to ensure that
the points on the x axis are ordered: if they are not ordered, the result is a mess.
smooth<-read.table("c:\\temp\\smoothing.txt",header=T)
attach(smooth)
names(smooth)
[1] "x" "y"
Begin by producing a vector of subscripts representing the ordered values of the explana
tory variable. Then draw lines with the vector as subscripts to both the x and y variables:
sequence<-order(x)
lines(x[sequence],y[sequence])
If you do not order the x values, and just use the lines function, this is what happens:
plot(x,y,pch=16)
lines(x,y)


par(mfrow=c(1,2))
boxplot(biomass~clipping)
boxplot(biomass~clipping,notch=T)

Rather than use plot to produce a boxplot, an alternative is to use a barplot to show
the heights of the five mean values from the different treatments. We need to calculate the
means using the function tapply like this:
means<-tapply(biomass,clipping,mean)
Then the barplot is produced very simply:
par(mfrow=c(1,1))
barplot(means,xlab="treatment",ylab="yield")

Because the genotypes (factor levels) are unordered, it is hard to judge from the plot
which levels might be significantly different from which others. We start, therefore, by
calculating an index which will rank the mean values of response across the different factor
levels:
index<-order(tapply(response,fact,mean))
ordered<-factor(rep(index,rep(20,8)))
boxplot(response~ordered,notch=T,names=as.character(index),
xlab="ranked treatments",ylab="response")
There are several points to clarify here. We plot the response as a function of the factor
called ordered (rather than fact) so that the boxes are ranked from lowest mean yield on the
left (cultivar 6) to greatest mean on the right (cultivar 5). We change the names of the boxes
to reflect the values of index (i.e. the original values of fact: otherwise they would read 1

Plots for Single Samples
When we have a just one variable, the choice of plots is more restricted:
• histograms to show a frequency distribution;
• index plots to show the values of y in sequence;
• time-series plots;
• compositional plots like pie diagrams

Histograms
The commonest plots for a single sample are histograms and index plots. Histograms are
excellent for showing the mode, the spread and the symmetry (skew) of a set of data. The
R function hist is deceptively simple. Here is a histogram of 1000 random points drawn
from a Poisson distribution with a mean of 1.7:
hist(rpois(1000,1.7),
main="",xlab="random numbers from a Poisson with mean 1.7")
0
0 100 200 300 400 500
2
random numbers from a Poisson with mean 1.7
Frequency
4 6 8
This illustrates perfectly one of the big problems with histograms: it is not clear what the
bar of height 500 is showing. Is it the frequency of zeros, or the frequency of zeros and
ones lumped together? What we really want in a case like this is a separate histogram bar
for each integer value from 0 to 8. We achieve this by specifying the breaks on the x axis
to be at −05, 0.5, 1.5,    , like this:
hist(rpois(1000,1.7),breaks=seq(-0.5,9.5,1),
main="",xlab="random numbers from a Poisson with mean 1.7")
That’s more like it. Now we can see that the mode is 1 (not 0), and that 2s are substantially
more frequent than 0s. The distribution is said to be ‘skew to the right’ (or ‘positively
skew’) because the long tail is on the right-hand side of the histogram.
Overlaying histograms with smooth density functions
If it is in any way important, then you should always specify the break points yourself.
Unless you do this, the hist function may not take your advice about the number of bars

or the width of bars. For small-integer data (less than 20, say), the best plan is to have one
bin for each value. You create the breaks by starting at −05 to accommodate the zeros and
going up to maxy + 05 to accommodate the biggest count. Here are 158 random integers
from a negative binomial distribution with  = 15 and k = 10:
y<-rnbinom(158,mu=1.5,size=1)
bks<- -0.5:(max(y)+0.5)
hist(y,bks,main="")
To get the best fit of a density function for this histogram we should estimate the
parameters of our particular sample of negative binomially distributed counts:
mean(y)
[1] 1.772152
var(y)
[1] 4.228009
mean(y)^2/(var(y)-mean(y))
[1] 1.278789
In R, the parameter k of the negative binomial distribution is known as size and the mean
is known as mu. We want to generate the probability density for each count between 0 and
11, for which the R function is dnbinom:
xs<-0:11
ys<-dnbinom(xs,size=1.2788,mu=1.772)
lines(xs,ys*158)

Not surprisingly, since we generated the data, the negative binomial distribution is a very
good description of the frequency distribution. The frequency of 1s is a bit low and of 2s
is a bit high, but the other frequencies are very well described.
Density estimation for continuous variables
The problems associated with drawing histograms of continuous variables are much more
challenging. The subject of density estimation is an important issue for statisticians, and
whole books have been written about it (Silverman 1986; Scott 1992). You can get a
feel for what is involved by browsing the ?density help window. The algorithm used in
density.default disperses the mass of the empirical distribution function over a regular grid
of at least 512 points, uses the fast Fourier transform to convolve this approximation with a
discretized version of the kernel, and then uses linear approximation to evaluate the density
at the specified points. The choice of bandwidth is a compromise between smoothing enough
to rub out insignificant bumps and smoothing too much so that real peaks are eliminated.
The rule of thumb for bandwidth is
b =
maxx − minx
21 + log2 n
(where n is the number of data points). For details see Venables and Ripley (2002). We can
compare hist with Venables and Ripley’s truehist for the Old Faithful eruptions data. The
rule of thumb for bandwidth gives:
library(MASS)
attach(faithful)
(max(eruptions)-min(eruptions))/(2*(1+log(length(eruptions),base=2)))

data(UKLungDeaths)
ts.plot(ldeaths, mdeaths, fdeaths, xlab="year", ylab="deaths", lty=c(1:3))

pie(data$amounts,labels=as.character(data$names))


pie(data$amounts,labels=as.character(data$names))


data(OrchardSprays)
with(OrchardSprays,
stripchart(decrease ~ treatment,
ylab = "decrease", vertical = TRUE, log = "y"))

pairs(ozonedata,panel=panel.smooth)

The coplot function
A real difficulty with multivariate data is that the relationship between two variables may
be obscured by the effects of other processes. When you draw a two-dimensional plot of y
against x, then all of the effects of the other explanatory variables are squashed flat onto the
plane of the paper. In the simplest case, we have one response variable (ozone) and just two
explanatory variables (wind speed and air temperature). The function is written like this:
coplot(ozone~wind temp,panel = panel.smooth)
With the response (ozone) on the left of the tilde and the explanatory variable on the x axis
(wind) on the right, with the conditioning variable after the conditioning operator  (here
read as ‘given temp’). An option employed here is to fit a non-parametric smoother through
the scatterplot in each of the panels.
The coplot panels are ordered from lower-left to upper right, associated with the values
of the conditioning variable in the upper panel (temp) from left to right. Thus, the lower-left
plot is for the lowest temperatures (56–72 degrees F) and the upper right plot is for the
highest temperatures (82–96 degrees F). This coplot highlights an interesting interaction.
At the two lowest levels of the conditioning variable, temp, there is little or no relationship

coplot {graphics}	R Documentation
Conditioning Plots
Description

This function produces two variants of the conditioning plots discussed in the reference below.
Usage

coplot(formula, data, given.values, panel = points, rows, columns,
       show.given = TRUE, col = par("fg"), pch = par("pch"),
       bar.bg = c(num = gray(0.8), fac = gray(0.95)),
       xlab = c(x.name, paste("Given :", a.name)),
       ylab = c(y.name, paste("Given :", b.name)),
       subscripts = FALSE,
       axlabels = function(f) abbreviate(levels(f)),
       number = 6, overlap = 0.5, xlim, ylim, ...)
co.intervals(x, number = 6, overlap = 0.5)

Arguments
formula 	

a formula describing the form of conditioning plot. A formula of the form y ~ x | a indicates that plots of y versus x should be produced conditional on the variable a. A formula of the form y ~ x| a * b indicates that plots of y versus x should be produced conditional on the two variables a and b.

All three or four variables may be either numeric or factors. When x or y are factors, the result is almost as if as.numeric() was applied, whereas for factor a or b, the conditioning (and its graphics if show.given is true) are adapted.
data 	

a data frame containing values for any variables in the formula. By default the environment where coplot was called from is used.
given.values 	

a value or list of two values which determine how the conditioning on a and b is to take place.

When there is no b (i.e., conditioning only on a), usually this is a matrix with two columns each row of which gives an interval, to be conditioned on, but is can also be a single vector of numbers or a set of factor levels (if the variable being conditioned on is a factor). In this case (no b), the result of co.intervals can be used directly as given.values argument.
panel 	

a function(x, y, col, pch, ...) which gives the action to be carried out in each panel of the display. The default is points.
rows 	

the panels of the plot are laid out in a rows by columns array. rows gives the number of rows in the array.
columns 	

the number of columns in the panel layout array.
show.given 	

logical (possibly of length 2 for 2 conditioning variables): should conditioning plots be shown for the corresponding conditioning variables (default TRUE).
col 	

a vector of colors to be used to plot the points. If too short, the values are recycled.
pch 	

a vector of plotting symbols or characters. If too short, the values are recycled.
bar.bg 	

a named vector with components "num" and "fac" giving the background colors for the (shingle) bars, for numeric and factor conditioning variables respectively.
xlab 	

character; labels to use for the x axis and the first conditioning variable. If only one label is given, it is used for the x axis and the default label is used for the conditioning variable.
ylab 	

character; labels to use for the y axis and any second conditioning variable.
subscripts 	

logical: if true the panel function is given an additional (third) argument subscripts giving the subscripts of the data passed to that panel.
axlabels 	

function for creating axis (tick) labels when x or y are factors.
number 	

integer; the number of conditioning intervals, for a and b, possibly of length 2. It is only used if the corresponding conditioning variable is not a factor.
overlap 	

numeric < 1; the fraction of overlap of the conditioning variables, possibly of length 2 for x and y direction. When overlap < 0, there will be gaps between the data slices.
xlim 	

the range for the x axis.
ylim 	

the range for the y axis.
... 	

additional arguments to the panel function.
x 	

a numeric vector.
Details

In the case of a single conditioning variable a, when both rows and columns are unspecified, a ‘close to square’ layout is chosen with columns >= rows.

In the case of multiple rows, the order of the panel plots is from the bottom and from the left (corresponding to increasing a, typically).

A panel function should not attempt to start a new plot, but just plot within a given coordinate system: thus plot and boxplot are not panel functions.

The rendering of arguments xlab and ylab is not controlled by par arguments cex.lab and font.lab even though they are plotted by mtext rather than title.
Value

co.intervals(., number, .) returns a (number x 2) matrix, say ci, where ci[k,] is the range of x values for the k-th interval.
References

Chambers, J. M. (1992) Data for models. Chapter 3 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.

Cleveland, W. S. (1993) Visualizing Data. New Jersey: Summit Press.
See Also

pairs, panel.smooth, points.
Examples

## Tonga Trench Earthquakes
coplot(lat ~ long | depth, data = quakes)
given.depth <- co.intervals(quakes$depth, number = 4, overlap = .1)
coplot(lat ~ long | depth, data = quakes, given.v = given.depth, rows = 1)

## Conditioning on 2 variables:
ll.dm <- lat ~ long | depth * mag
coplot(ll.dm, data = quakes)
coplot(ll.dm, data = quakes, number = c(4, 7), show.given = c(TRUE, FALSE))
coplot(ll.dm, data = quakes, number = c(3, 7),
       overlap = c(-.5, .1)) # negative overlap DROPS values

## given two factors
Index <- seq(length = nrow(warpbreaks)) # to get nicer default labels
coplot(breaks ~ Index | wool * tension, data = warpbreaks,
       show.given = 0:1)
coplot(breaks ~ Index | wool * tension, data = warpbreaks,
       col = "red", bg = "pink", pch = 21,
       bar.bg = c(fac = "light blue"))

## Example with empty panels:
with(data.frame(state.x77), {
coplot(Life.Exp ~ Income | Illiteracy * state.region, number = 3,
       panel = function(x, y, ...) panel.smooth(x, y, span = .8, ...))
## y ~ factor -- not really sensible, but 'show off':
coplot(Life.Exp ~ state.region | Income * state.division,
       panel = panel.smooth)
})


interaction.plot(fertilizer,irrigation, yield)

require(graphics)

with(ToothGrowth, {
interaction.plot(dose, supp, len, fixed = TRUE)
dose <- ordered(dose)
interaction.plot(dose, supp, len, fixed = TRUE, col = 2:3, leg.bty = "o")
interaction.plot(dose, supp, len, fixed = TRUE, col = 2:3, type = "p")
})

with(OrchardSprays, {
  interaction.plot(treatment, rowpos, decrease)
  interaction.plot(rowpos, treatment, decrease, cex.axis = 0.8)
  ## order the rows by their mean effect
  rowpos <- factor(rowpos,
                   levels = sort.list(tapply(decrease, rowpos, mean)))
  interaction.plot(rowpos, treatment, decrease, col = 2:9, lty = 1)
})

with(esoph, {
  interaction.plot(agegp, alcgp, ncases/ncontrols, main = "'esoph' Data")
  interaction.plot(agegp, tobgp, ncases/ncontrols, trace.label = "tobacco",
                   fixed = TRUE, xaxt = "n")
})
## deal with NAs:
esoph[66,] # second to last age group: 65-74
esophNA <- esoph; esophNA$ncases[66] <- NA
with(esophNA, {
  interaction.plot(agegp, alcgp, ncases/ncontrols, col = 2:5)
                                # doesn't show *last* group either
  interaction.plot(agegp, alcgp, ncases/ncontrols, col = 2:5, type = "b")
  ## alternative take non-NA's  {"cheating"}
  interaction.plot(agegp, alcgp, ncases/ncontrols, col = 2:5,
                   fun = function(x) mean(x, na.rm = TRUE),
                   sub = "function(x) mean(x, na.rm=TRUE)")
})
rm(esophNA) # to clear up

library(lattice)
The panel plots are created by the xyplot function, using a formula to indicate the grouping
structure: weight ~ age  gender. This is read as ‘weight is plotted as a function of age,
given gender’ (the vertical bar  is the ‘given’ symbol).
xyplot(weight ~ age  gender)

• barchart for barplots;
• bwplot for box-and-whisker plots;
• densityplot for kernel density plots;
• dotplot for dot plots;
• histogram for panels of histograms;
• qqmath for quantile plots against mathematical distributions;
• stripplot for a one-dimensional scatterplot;
• qq for a QQ plot for comparing two distributions;
• xyplot for a scatterplot;
• levelplot for creating level plots (similar to image plots);
• contourplot for contour plots;
• cloud for three-dimensional scatterplots;
• wireframe for 3D surfaces (similar to persp plots);
• splom for a scatterplot matrix;
• parallel for creating parallel coordinate plots;
• rfs to produce a residual and fitted value plot (see also oneway);
• tmd for a Tukey mean–difference plot.
The lattice package has been developed by Deepayan Sarkar, and the plots created by
lattice are rendered by the Grid Graphics engine for R (developed by Paul Murrell). Lattice
plots are highly customizable via user-modifiable settings, but these are completely unrelated
to base graphics settings. In particular, changing par() settings usually has no effect on
lattice plots. To read more about the background and capabilities of the lattice package,
type
help(package = lattice)
Here is an example trellis plot for the interpretation of a designed experiment where
all the explanatory variables are categorical. It uses bwplot to illustrate the results of a
three-way analysis of variance (p. 479).
data<-read.table("c:\\temp\\daphnia.txt",header=T)
attach(data)
names(data)
[1] "Growth.rate" "Water" "Detergent" "Daphnia"

help(package = lattice)

help(package = lattice)
library(lattice)
trellis.par.set(col.whitebg())
bwplot(Growth.rate~Water+Daphnia Detergent)


Design plots
An effective way of visualizing effect sizes in designed experiments is the plot.design
function which is used just like a model formula:
plot.design(Growth.rate~Water*Detergent*Daphnia)
This shows the main effects of the three factors, drawing attention to the major differences
between the daphnia clones and the small differences between the detergent brands A, B
and C. The default (as here) is to plot means, but other functions can be specified such as
median, var or sd. Here are the standard deviations for the different factor levels
plot.design(Growth.rate~Water*Detergent*Daphnia,fun="sd")



tapply(Growth.rate,Detergent,mean)
BrandA BrandB BrandC BrandD
3.884832 4.010044 3.954512 3.558231
or for the two rivers,
tapply(Growth.rate,Water,mean)
Tyne Wear
3.685862 4.017948

or for the three daphnia clones,
tapply(Growth.rate,Daphnia,mean)
Clone1 Clone2 Clone3
2.839875 4.577121 4.138719
Two-dimension summary tables are created by replacing the single explanatory variable
(the second argument in the function call) by a list indicating which variable is to be used
for the rows of the summary table and which variable is to be used for creating the columns
of the summary table. To get the daphnia clones as the rows and detergents as the columns,
we write list(Daphnia,Detergent) – rows first then columns – and use tapply to create the
summary table as follows:
tapply(Growth.rate,list(Daphnia,Detergent),mean)
BrandA BrandB BrandC BrandD
Clone1 2.732227 2.929140 3.071335 2.626797
Clone2 3.919002 4.402931 4.772805 5.213745
Clone3 5.003268 4.698062 4.019397 2.834151
If we wanted the median values (rather than the means), then we would just alter the third
argument of the tapply function like this:
tapply(Growth.rate,list(Daphnia,Detergent),median)
BrandA BrandB BrandC BrandD
Clone1 2.705995 3.012495 3.073964 2.503468
Clone2 3.924411 4.282181 4.612801 5.416785
Clone3 5.057594 4.627812 4.040108 2.573003
To obtain a table of the standard errors of the means (where each mean is based
on 6 numbers −2 replicates and 3 rivers) the function we want to apply is s2/n.
There is no built-in function for the standard error of a mean, so we create what is
known as an anonymous function inside the tapply function with function(x)sqrt(var(x)/
length(x)):
tapply(Growth.rate,list(Daphnia,Detergent), function(x)sqrt(var(x)/length(x)))
BrandA BrandB BrandC BrandD
Clone1 0.2163448 0.2319320 0.3055929 0.1905771
Clone2 0.4702855 0.3639819 0.5773096 0.5520220
Clone3 0.2688604 0.2683660 0.5395750 0.4260212
When tapply is asked to produce a three-dimensional table, it produces a stack of two
dimensional tables, the number of stacked tables being determined by the number of levels
of the categorical variable that comes third in the list (Water in this case):
tapply(Growth.rate,list(Daphnia,Detergent,Water),mean)
, ,Tyne
BrandA BrandB BrandC BrandD
Clone1 2.811265 2.775903 3.287529 2.597192
Clone2 3.307634 4.191188 3.620532 4.105651
Clone3 4.866524 4.766258 4.534902 3.365766

, ,Wear
BrandA BrandB BrandC BrandD
Clone1 2.653189 3.082377 2.855142 2.656403
Clone2 4.530371 4.614673 5.925078 6.321838
Clone3 5.140011 4.629867 3.503892 2.302537
In cases like this, the function ftable (which stands for ‘flat table’) often produces more
pleasing output:
ftable(tapply(Growth.rate,list(Daphnia,Detergent,Water),mean))
Tyne Wear
Clone1 BrandA 2.811265 2.653189
BrandB 2.775903 3.082377
BrandC 3.287529 2.855142
BrandD 2.597192 2.656403
Clone2 BrandA 3.307634 4.530371
BrandB 4.191188 4.614673
BrandC 3.620532 5.925078
BrandD 4.105651 6.321838
Clone3 BrandA 4.866524 5.140011
BrandB 4.766258 4.629867
BrandC 4.534902 3.503892
BrandD 3.365766 2.302537
Notice that the order of the rows, columns or tables is determined by the alphabetical
sequence of the factor levels (e.g. Tyne comes before Wear in the alphabet). If you want to
override this, you must specify that the factor is.ordered in a non-standard way:
water<-factor(Water,levels=c("Wear","Tyne"),ordered=is.ordered(Water))
Now the summary statistics for the Wear appear in the left-hand column of output:
ftable(tapply(Growth.rate,list(Daphnia,Detergent,water),mean))
Wear Tyne
Clone1 BrandA 2.653189 2.811265
BrandB 3.082377 2.775903
BrandC 2.855142 3.287529
BrandD 2.656403 2.597192
Clone2 BrandA 4.530371 3.307634
BrandB 4.614673 4.191188
BrandC 5.925078 3.620532
BrandD 6.321838 4.105651
Clone3 BrandA 5.140011 4.866524
BrandB 4.629867 4.766258
BrandC 3.503892 4.534902
BrandD 2.302537 3.365766
The function to be applied in generating the table can be supplied with extra arguments:
tapply(Growth.rate,Detergent,mean,trim=0.1)
BrandA BrandB BrandC BrandD
3.874869 4.019206 3.890448 3.482322
An extra argument is essential if you want means when there are missing values:
tapply(Growth.rate,Detergent,mean,na.rm=T)
You can use tapply to create new, abbreviated dataframes comprising summary parame
ters estimated from larger dataframe. Here, for instance, is a dataframe of mean growth rate
classified by detergent and daphina clone (i.e. averaged over river water and replicates).
The trick is to convert the factors to numbers before using tapply, then using these numbers
to extract the relevant levels from the original factors:
dets<-as.vector(tapply(as.numeric(Detergent),list(Detergent,Daphnia),mean))
levels(Detergent)[dets]
[1] "BrandA" "BrandB" "BrandC" "BrandD" "BrandA" "BrandB"
"BrandC" "BrandD"
[9] "BrandA" "BrandB" "BrandC" "BrandD"
clones<-as.vector(tapply(as.numeric(Daphnia),list(Detergent,Daphnia),mean))
levels(Daphnia)[clones]
[1] "Clone1" "Clone1" "Clone1" "Clone1" "Clone2" "Clone2"
"Clone2" "Clone2"
[9] "Clone3" "Clone3" "Clone3" "Clone3"
You will see that these vectors of factor levels are the correct length for the new reduced
dataframe (12, rather than the original length 72). The 12 mean values
tapply(Growth.rate,list(Detergent,Daphnia),mean)
Clone1 Clone2 Clone3
BrandA 2.732227 3.919002 5.003268
BrandB 2.929140 4.402931 4.698062
BrandC 3.071335 4.772805 4.019397
BrandD 2.626797 5.213745 2.834151
can now be converted into a vector called means, and the three new vectors combined into
a dataframe:
means<-as.vector(tapply(Growth.rate,list(Detergent,Daphnia),mean))
detergent<-levels(Detergent)[dets]
daphnia<-levels(Daphnia)[clones]
data.frame(means,detergent,daphnia)
means detergent daphnia
1 2.732227 BrandA Clone1
2 2.929140 BrandB Clone1
3 3.071335 BrandC Clone1
4 2.626797 BrandD Clone1
5 3.919002 BrandA Clone2
6 4.402931 BrandB Clone2
7 4.772805 BrandC Clone2
8 5.213745 BrandD Clone2
9 5.003268 BrandA Clone3
10 4.698062 BrandB Clone3
11 4.019397 BrandC Clone3
12 2.834151 BrandD Clone3
The same result can be obtained using the as.data.frame.table function
as.data.frame.table(tapply(Growth.rate,list(Detergent,Daphnia),mean))
Var1 Var2 Freq
1 BrandA Clone1 2.732227
2 BrandB Clone1 2.929140
3 BrandC Clone1 3.071335
4 BrandD Clone1 2.626797
5 BrandA Clone2 3.919002
6 BrandB Clone2 4.402931
7 BrandC Clone2 4.772805
8 BrandD Clone2 5.213745
9 BrandA Clone3 5.003268
10 BrandB Clone3 4.698062
11 BrandC Clone3 4.019397
12 BrandD Clone3 2.834151
but you would need to edit the names like this:
new<-as.data.frame.table(tapply(Growth.rate,list(Detergent,Daphnia),mean))
names(new)<-c("detergents","daphina","means")
Tables of Counts
Here are simulated data from a trial in which red blood cells were counted on 10 000 slides.
The mean number of cells per slide  was 1.2 and the distribution had an aggregation
parameter k = 063 (known in R as size). The probability for a negative binomial distribution
(prob in R) is given by k/ + k = 063/183 so
cells<-rnbinom(10000,size=0.63,prob=0.63/1.83)
We want to count how many times we got no red blood cells on the slide, and how often
we got 1 2 3    cells. The R function for this is table:
table(cells)
cells
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
5149 2103 1136 629 364 226 158 81 52 33 22 11 11 6 9 5
16 17 24
3 1 1
That’s all there is to it. You will get slightly different values because of the randomization.
We found 5149 slides with no red blood cells and one slide with a massive 24 red blood
cells.
We often want to count separately for each level of a factor. Here we know that the first
5000 samples came from male patients and the second 5000 from females:
gender<-rep(c("male","female"),c(5000,5000))
To tabulate the counts separately for the two sexes we just write
table(cells,gender)

tapply(Growth.rate,list(Daphnia,Detergent,Water),mean)
ftable(tapply(Growth.rate,list(Daphnia,Detergent,Water),mean))


> with(mtcars, tapply(disp,list(cyl,am)))
 [1] 5 5 4 2 3 2 3 1 1 2 2 3 3 3 3 3 3 4 4 4 1 3 3 3 3 4 4 4 6 5 6 4
> with(mtcars, tapply(disp,list(cyl,am),mean))
         0        1
4 135.8667  93.6125
6 204.5500 155.0000
8 357.6167 326.0000


> diamonds %>% str
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':       53940 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...


with(diamonds, tapply(price,list(cut,color,clarity),mean)) %>% ftable
tapply(Growth.rate,Detergent,mean,trim=0.1)
tapply(Growth.rate,Detergent,mean,na.rm=T)
dets<-as.vector(tapply(as.numeric(Detergent),list(Detergent,Daphnia),mean))
levels(Detergent)[dets]
Calculating tables of proportions
The margins of a table (the row totals or the column totals) are often useful for calculating
proportions instead of counts. Here is a data matrix called counts:
counts<-matrix(c(2,2,4,3,1,4,2,0,1,5,3,3),nrow=4)
counts
[,1] [,2] [,3]
[1,] 2 1 1
[2,] 2 4 5
[3,] 4 2 3
[4,] 3 0 3
The proportions will be different when they are expressed as a fraction of the row totals or
as a fraction of the column totals. You need to remember that the row subscripts come first,
which is why margin number 1 refers to the row totals:

prop.table(counts,1)
[,1] [,2] [,3]
[1,] 0.5000000 0.2500000 0.2500000
[2,] 0.1818182 0.3636364 0.4545455
[3,] 0.4444444 0.2222222 0.3333333
[4,] 0.5000000 0.0000000 0.5000000
The column totals are the second margin, so to express the counts as proportions of the
relevant column total use:
prop.table(counts,2)
[,1] [,2] [,3]
[1,] 0.1818182 0.1428571 0.08333333
[2,] 0.1818182 0.5714286 0.41666667
[3,] 0.3636364 0.2857143 0.25000000
[4,] 0.2727273 0.0000000 0.25000000
To check that the column proportions sum to one, use colSums like this:
colSums(prop.table(counts,2))
[1] 1 1 1
If you want the proportions expressed as a fraction of the grand total sum(counts), then
simply omit the margin number:
prop.table(counts)
[,1] [,2] [,3]
[1,] 0.06666667 0.03333333 0.03333333
[2,] 0.06666667 0.13333333 0.16666667
[3,] 0.13333333 0.06666667 0.10000000
[4,] 0.10000000 0.00000000 0.10000000
sum(prop.table(counts))
[1] 1
In any particular case, you need to choose carefully whether it makes sense to express your
counts as proportions of the row totals, column totals or grand total.


The scale function
For a numeric matrix, you might want to scale the values within a column so that they have
a mean of 0. You might also want to know the standard deviation of the values within each
column. These two actions are carried out simultaneously with the scale function:
scale(counts)
[,1] [,2] [,3]
[1,] -0.7833495 -0.439155 -1.224745
[2,] -0.7833495 1.317465 1.224745
[3,] 1.3055824 0.146385 0.000000
[4,] 0.2611165 -1.024695 0.000000
attr(,"scaled:center")
[1] 2.75 1.75 3.00

attr(,"scaled:scale")
[1] 0.9574271 1.7078251 1.6329932
The values in the table are the counts minus the column means of the counts. The means of
the columns – attr(,"scaled:center") – are 2.75, 1.75 and 3.0, while the standard
deviations of the columns – attr(,"scaled:scale") – are 0.96, 1.71 and 1.63. To
check that the scales are the standard deviations (sd) of the counts within a column, you
could use apply to the columns (margin = 2) like this:
apply(counts,2,sd)
[1] 0.9574271 1.7078251 1.6329932
The expand.grid function
This is a useful function for generating tables of combinations of factor levels. Suppose we
have three variables: height with five levels between 60 and 80 in steps of 5, weight with
five levels between 100 and 300 in steps of 50, and two sexes.
expand.grid(height = seq(60, 80, 5), weight = seq(100, 300, 50),
sex = c("Male","Female"))
height weight sex
1 60 100 Male
2 65 100 Male
3 70 100 Male
4 75 100 Male
5 80 100 Male
6 60 150 Male
7 65 150 Male
8 70 150 Male
9 75 150 Male
10 80 150 Male
11 60 200 Male
  
47 65 300 Female
48 70 300 Female
49 75 300 Female
50 80 300 Female
The model.matrix function
Creating tables of dummy variables for use in statistical modelling is extremely easy with
the model.matrix function. You will see what the function does with a simple example.
Suppose that our dataframe contains a factor called parasite indicating the identity of a gut
parasite. The variable called parasite has five levels: vulgaris, kochii, splendens, viridis and
knowlesii. Note that there was no header row in the data file, so the variable name parasite
had to be added subsequently, using names:
data<-read.table("c:\\temp \\parasites.txt")
names(data)<-"parasite"
attach(data)
