df_xts <- as.xts(as.data.frame(sample_matrix),
important='very important info!')


> df_xts %>% attributes
$dim
[1] 180   4

$dimnames
$dimnames[[1]]
NULL

$dimnames[[2]]
[1] "Open"  "High"  "Low"   "Close"


$index
  [1] 1167667200 1167753600 1167840000 1167926400 1168012800 1168
  [7] 1168185600 1168272000 1168358400 1168444800 1168531200 1168
 [13] 1168704000 1168790400 1168876800 1168963200 1169049600 1169
 [19] 1169222400 1169308800 1169395200 1169481600 1169568000 1169
 [25] 1169740800 1169827200 1169913600 1170000000 1170086400 1170
 [31] 1170259200 1170345600 1170432000 1170518400 1170604800 1170
 [37] 1170777600 1170864000 1170950400 1171036800 1171123200 1171
 [43] 1171296000 1171382400 1171468800 1171555200 1171641600 1171
 [49] 1171814400 1171900800 1171987200 1172073600 1172160000 1172
 [55] 1172332800 1172419200 1172505600 1172592000 1172678400 1172
 [61] 1172851200 1172937600 1173024000 1173110400 1173196800 1173
 [67] 1173369600 1173456000 1173542400 1173628800 1173715200 1173
 [73] 1173888000 1173974400 1174060800 1174147200 1174233600 1174
 [79] 1174406400 1174492800 1174579200 1174665600 1174752000 1174
 [85] 1174924800 1175011200 1175097600 1175184000 1175270400 1175
 [91] 1175443200 1175529600 1175616000 1175702400 1175788800 1175
 [97] 1175961600 1176048000 1176134400 1176220800 1176307200 1176
[103] 1176480000 1176566400 1176652800 1176739200 1176825600 1176
[109] 1176998400 1177084800 1177171200 1177257600 1177344000 1177
[115] 1177516800 1177603200 1177689600 1177776000 1177862400 1177
[121] 1178035200 1178121600 1178208000 1178294400 1178380800 1178
[127] 1178553600 1178640000 1178726400 1178812800 1178899200 1178
[133] 1179072000 1179158400 1179244800 1179331200 1179417600 1179
[139] 1179590400 1179676800 1179763200 1179849600 1179936000 1180
[145] 1180108800 1180195200 1180281600 1180368000 1180454400 1180
[151] 1180627200 1180713600 1180800000 1180886400 1180972800 1181
[157] 1181145600 1181232000 1181318400 1181404800 1181491200 1181
[163] 1181664000 1181750400 1181836800 1181923200 1182009600 1182
[169] 1182182400 1182268800 1182355200 1182441600 1182528000 1182
[175] 1182700800 1182787200 1182873600 1182960000 1183046400 1183
attr(,"tzone")
[1] ""
attr(,"tclass")
[1] "POSIXct" "POSIXt"

$.indexCLASS
[1] "POSIXct" "POSIXt"

$tclass
[1] "POSIXct" "POSIXt"

$.indexTZ
[1] ""

$tzone
[1] ""

$important
[1] "very important info!"

$class
[1] "xts" "zoo"

> df_xts %>% attr("import")
[1] "very important info!"
> df_xts %>% attr(tclass)
Error in attr(., tclass) : 'which' must be of mode character
> df_xts %>% attr("tclass")
[1] "POSIXct" "POSIXt"
>

xts(1:10, Sys.Date()+1:10)

Here is the first 1 week of the data
> first(matrix_xts,'1 week')
...and here is the first 3 days of the last week of the data.
> first(last(matrix_xts,'1 week'),'3 days')


> indexClass(matrix_xts)
[1] "Date"
> indexClass(convertIndex(matrix_xts,'POSIXct'))
[1] "POSIXct" "POSIXt"

df_xts %>% indexClass
df_xts %>% convertIndex('Date')

axTicksByTime(df_xts, ticks.on='months')

> axTicksByTime(matrix_xts, ticks.on='months')
Jan 02\n2007 Feb 01\n2007 Mar 01\n2007 Apr 01\n2007 May 01\n2007 Jun 01\n2007
1 31 59 90 120 151
Jun 30\n2007
180
A simple example of the plotting functionality offered by this labelling can be
seen here:
> plot(matrix_xts[,1],major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)


Simply wrapping the function that meets these criteria in Reclass will result
in an attempt to coerce the returned output of the function
> z <- zoo(1:10,Sys.Date()+1:10)
> # filter converts to a ts object - and loses the zoo class
> (zf <- filter(z, 0.2))
Time Series:
Start = 15946
End = 15955
Frequency = 1
[1] 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0
> class(zf)
[1] "ts"
> # using Reclass, the zoo class is preserved
> (zf <- Reclass(filter(z, 0.2)))
2013-08-29 2013-08-30 2013-08-31 2013-09-01 2013-09-02 2013-09-03 2013-09-04
0.2 0.4 0.6 0.8 1.0 1.2 1.4
2013-09-05 2013-09-06 2013-09-07
1.6 1.8 2.0
> class(zf)
[1] "zoo"
The Reclass function is still a bit experimental, and will certainly improve
in time, but for now provides at least an alternative option to maintain your
object’s class and attributes when the function you require can’t on its own.

> periodicity(matrix_xts)
Daily periodicity from 2007-01-02 to 2007-06-30

> endpoints(matrix_xts,on='months')
[1] 0 30 58 89 119 150 180
> endpoints(matrix_xts,on='weeks')

Change periodicity
One of the most ubiquitous type of data in finance is OHLC data (Open-High
Low-Close). Often is is necessary to change the periodicity of this data to
something coarser - e.g. take daily data and aggregate to weekly or monthly.
With to.period and related wrapper functions it is a simple proposition.
> to.period(matrix_xts,'months')
matrix_xts.Open matrix_xts.High matrix_xts.Low matrix_xts.Close
2007-01-31 50.03978 50.77336 49.76308 50.22578
2007-02-28 50.22448 51.32342 50.19101 50.77091
2007-03-31 50.81620 50.81620 48.23648 48.97490
2007-04-30 48.94407 50.33781 48.80962 49.33974
2007-05-31 49.34572 49.69097 47.51796 47.73780
2007-06-30 47.74432 47.94127 47.09144 47.76719
> periodicity(to.period(matrix_xts,'months'))
Monthly periodicity from 2007-01-31 to 2007-06-30
to.monthly(matrix_xts)



period.apply(df_xts[,4],INDEX=endpoints(df_xts),FUN=max)


Periodically apply a function
Often it is desirable to be able to calculate a particular statistic, or evaluate a
function, over a set of non-overlapping time periods. With the period.apply
family of functions it is quite simple.
The following examples illustrate a simple application of the max function to
our example data.
> # the general function, internally calls sapply
> period.apply(matrix_xts[,4],INDEX=endpoints(matrix_xts),FUN=max)

> # the general function, internally calls sapply
> period.apply(matrix_xts[,4],INDEX=endpoints(matrix_xts),FUN=max)
Close
2007-01-31 50.67835
2007-02-28 51.17899
2007-03-31 50.61559
2007-04-30 50.32556
2007-05-31 49.58677
2007-06-30 47.76719
> # same result as above, just a monthly interface
> apply.monthly(matrix_xts[,4],FUN=max)
Close
2007-01-31 50.67835
2007-02-28 51.17899
2007-03-31 50.61559
2007-04-30 50.32556
2007-05-31 49.58677
2007-06-30 47.76719
> # using one of the optimized functions - about 4x faster
> period.max(matrix_xts[,4], endpoints(matrix_xts))

