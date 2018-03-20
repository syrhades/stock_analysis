##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai.db"   

#Args <- commandArgs()
#`R` ±íÊ¾R interpreter£¬`CMD` ±íÊ¾Ò»¸ö R ¹¤¾ß»á±»Ê¹ÓÃ¡£Ò»°ãµÄÓï·¨ÊÇ`R CMD ÃüÁî ²ÎÊý`¡£`BATCH`Ö§³Ö·Ç½»»¥Ê½µØÖ´ÐÐ½Å±¾ÃüÁî£¬
#¼´³ÌÐòÖ´#ÐÐÊ±²»ÓÃÓëÎÒÃÇ¹µÍ¨£¬²»ÓÃÔËÐÐµ½°ëÂ·»¹ÐèÒªÎÒÃÇ¸ø¸ö²ÎÊýÉ¶µÄ¡£

#dbfile<-Args[6]
library('devtools')
setwd('e:/syrhadestock')
setwd('~/sdcard1/syrhadestock')
load_all()


frm_R_PLATFORM_execute<-function(linux_part,windows_part){
  # frm_R_PLATFORM_execute(source("~/sdcard/syrhadestock/R/cl_part_function.R"),source("e:/syrhadestock/R/cl_part_function.R")) 
  R_PLATFORM <- Sys.getenv(c("R_PLATFORM"))
  if(stringr::str_detect(R_PLATFORM, "linux")) linux_part
  else windows_part
}

frm_R_PLATFORM_execute(source("~/sdcard/syrhadestock/R/cl_part_function.R")
  ,source("e:/syrhadestock/R/cl_part_function.R"))  

frm_R_PLATFORM_execute(source("~/sdcard/syrhadestock/R/stock_reparir.R")
  ,source("e:/syrhadestock/R/stock_reparir.R"))  

bis_bsh<-read.csv("D:/help_line/bsh/log20161024_26/bis-BSHCN_EDI.lgw.13",header = F,sep = "\t",stringsAsFactors = F)
# /media/syrhades/DAA4BB34A4BB11CD1/stock_data

ta<-cl_db_oprate$new("e:/tb_finance.db")
ta<-cl_db_oprate$new("~/sdcard/stock_shanghai.db")
###########################################
## stock price db 
###########################################
ta<-cl_db_oprate$new("/media/syrhades/新加卷/stock_price.db")
# ta<-cl_db_oprate$new("e:/test.db")
ta$show_db_dbi()
df_spec_stock<-ta$query_db_dbi("select * from stock_price where st_code = '000001' ")
# as.Date(df_spec_stock$date)
# date format from int to Date 
df_spec_stock$date<-df_spec_stock$date%>%as.character%>%as.Date("%Y%m%d")
df_spec_stock<-transform(df_spec_stock,avg=(open+close+high+low)/4)
df_spec_stock_xts<- df_spec_stock[,1:7]
df_spec_stock_xts<- frm_repair_to_xts(df_spec_stock[,1:7])
df_spec_stock_xts %>% tail(n=500) %>% chartSeries()
addMACD()
addBBands()
zooom()
########################################### GS sample
#    GS sample
########################################### GS sample
GS<-df_spec_stock_xts
to.weekly(GS) %>% chartSeries()   # week
to.monthly(GS) %>% chartSeries()  # month
apply.weekly(GS,FUN=function(x) { max(Cl(x)) } ) 
apply.yearly(GS,FUN=function(x) { c(min(Cl(x)),max(Cl(x))) }) %>%plot 
apply.yearly(GS,FUN=function(x) { c(min(Cl(x)),max(Cl(x)),mean(Cl(x)))}) %>%plot 
apply.monthly(GS,FUN=function(x) { c(min(Cl(x)),max(Cl(x)),mean(Cl(x)))}) %>%plot 
period.apply(GS,endpoints(GS,on='weeks'), FUN=function(x) { max(Cl(x)) } ) %>%plot 
as.numeric(period.max(Cl(GS),endpoints(GS,on='weeks'))) %>%plot 
monthlyReturn(GS) 
allReturns(GS) %>% plot
barChart(GS,theme='white.mono',bar.type='hlc') 
barChart(GS) 
candleChart(GS,multi.col=TRUE,theme='white') 
lineChart(GS,line.type='h',TA=NULL) 
candleChart(GS,subset='2007-12::2008') 
candleChart(GS,theme='white', type='candles')
reChart(major.ticks='months',subset='first 16 weeks') 
chartSeries(GS, theme="white", TA="addVo();addBBands();addCCI()")
chartSeries(GS, theme="white")  #draw the chart
addVo() #add volume
addBBands() #add Bollinger Bands
addCCI() #add Commodity Channel Index 
addTA(OpCl(GS),col='blue', type='h') 
addOpCl <- newTA(OpCl,col='green',type='h') 
addOpCl() 
# chartSeries()
# http://www.quantmod.com/examples/data/
df_spec_stock_xts %>% head

http://quote.eastmoney.com/center/GlodList.html#shhjxh_7


###########################################
# tdx stock done_510160.txt
###########################################
df_spec_stock<-frm_stock_from_tdx_file(000001)
# using frm_stock_from_tdx_file to extract stock data
df_spec_stock_xts <- frm_gen_xts_step1(1)
df_spec_stock_xts %>% tail(n=500) %>% chartSeries()
df_spec_stock_xts  %>% chartSeries()

# show dygraph
# step 1 compute indicator
  s<-df_spec_stock_xts %>% Cl %>% frm_syr_bpctB
  l<-s$pctB
# step 2 get date line list for dyEvent 
  eventline <- l < 0
  buy_line<-eventline[eventline] %>% index

  eventline <- l > 100
  sell_line<-eventline[eventline] %>% index
# step 3 draw dygraph
  # eventline<-c("2015-6-30","2014-6-30","2013-01-01") %>% as.as.POSIXct
  df_xts<- df_spec_stock_xts[,1:4]
  dyplot<-dygraph(df_xts, main = "dygraph candlestick") %>%
  dyCandlestick() %>%
  dyRangeSelector()
  # dyEvent(dyplot,eventline,label=rep("buypoint",length(eventline)), labelLoc = "bottom",color="green",strokePattern = "dashed")
    dyplot %>% 
    dyEvent(buy_line,label=rep("buypoint",length(buy_line)), labelLoc = "bottom",color="green",strokePattern = "dashed") %>%
    dyEvent(sell_line,label=rep("sell_line",length(sell_line)), labelLoc = "top",color="red",strokePattern = "dashed")

    
  dyplot %>%
  dyLimit(list(0.64), 
    strokePattern = "dotted", color = "red",labelLoc="right")
  

  d_ply(shading_set,"from",function(x){print(x$from)})
  d_ply(shading_set,"from",function(x){dyShading(dyplot,from=x$from,to=x$to)})


 
#######################################################
# batch shading plot from datefram to shading graph
#######################################################
dyShading_multi <- function (from, to, color = "#EFEFEF", axis = "x") 
  {
    shading <- list()
    shading$from <- from
    shading$to <- to
    shading$color <- color
    shading$axis <- axis
    shading
    # dygraph$x$shadings[[length(dygraph$x$shadings) + 1]] <- shading
    # dygraph
  }

shading_set_x<-data.frame(from=c("2015-1-1","2016-1-1")%>% as.POSIXct,to=c("2015-1-15","2016-1-15")%>% as.POSIXct)
shading_set_y<-data.frame(from=c(0.7,0.3),to=c(0.75,0.4))
frm_shading_df<-function(dygraph,shading_df,...){
  # frm_shading_df(dygraph,shading_set)
  shade_list<-dlply(shading_df,"from",function(x) dyShading_multi(x$from,x$to,...))
  names(shade_list)<-NULL  
  dygraph$x$shadings <- shade_list
  dygraph
}
  
dyplot %>% frm_shading_df(shading_set_x,color="grey")
dyplot %>% frm_shading_df(shading_set_y,color="blue",axis="y")
#######################################################

df_spec_stock<-frm_stock_from_tdx_file(600033)
df_spec_stock<-frm_stock_from_tdx_file(601006)
df_spec_stock<-frm_stock_from_tdx_file(789)
df_spec_stock<-frm_stock_from_tdx_file(300170)
# date format from int to Date 
df_spec_stock<-frm_change_date_format(df_spec_stock,"%Y-%m-%d")
# transform df to xts
df_spec_stock_xts<- df_spec_stock[,1:7]
df_spec_stock_xts<- frm_repair_to_xts(df_spec_stock[,1:7])
names(df_spec_stock_xts)<-c("Open",     "High",     "Low",      "Close",    "Volume", "Amount",  "Adjusted")



max_xts<-rollapply(df_spec_stock_xts[,4],180,max,fill = 0, align = "right")
mean_xts<-rollapply(df_spec_stock_xts[,4],180,mean,fill = 0, align = "right")
min_xts<-rollapply(df_spec_stock_xts[,4],180,min,fill = 0, align = "right")
band_xts<-max_xts-min_xts
pos_xts <- df_spec_stock_xts[,4] - min_xts
i_pos_xts <- pos_xts/band_xts*100
# pos_xts,band_xts,
show_xts<-cbind(max_xts,mean_xts,min_xts,df_spec_stock_xts[,4])
show_xts[1:6,]
dyplot<-dygraph(show_xts, main = "dygraph candlestick")%>%
  # dyCandlestick() %>%
  dyRangeSelector()
dyplot

buy_line<-i_pos_xts[i_pos_xts == 0] %>% index

# eventline <- l > 100
sell_line<-i_pos_xts[i_pos_xts == 100] %>% index
dyplot %>% 
    dyEvent(buy_line,label=rep("b",length(buy_line)), labelLoc = "bottom",color="green",strokePattern = "dashed")
    # dyEvent(sell_line,label=rep("s",length(sell_line)), labelLoc = "top",color="red",strokePattern = "dashed")
dyplot



  # eventline<-c("2015-6-30","2014-6-30","2013-01-01") %>% as.as.POSIXct
  df_xts<- df_spec_stock_xts[,1:4]
  dyplot<-dygraph(df_xts, main = "dygraph candlestick") %>%
  dyCandlestick() %>%
  dyRangeSelector()
  # dyEvent(dyplot,eventline,label=rep("buypoint",length(eventline)), labelLoc = "bottom",color="green",strokePattern = "dashed")
    dyplot %>% 
    dyEvent(buy_line,label=rep("buypoint",length(buy_line)), labelLoc = "bottom",color="green",strokePattern = "dashed") %>%
    dyEvent(sell_line,label=rep("sell_line",length(sell_line)), labelLoc = "top",color="red",strokePattern = "dashed")



> i_pos_xts[i_pos_xts > 80] %>% length
[1] 568
> 
[1] 4
> i_pos_xts[i_pos_xts > 90] %>% length
[1] 494
> i_pos_xts[i_pos_xts < 30] %>% length
[1] 589



dyttt(shading_set[1,])
  dyplot %>%
  dyplot<-dyShading(dyplot,from = "2015-1-1", to = "2015-1-15", color = "#FF5FF5")
   dyplot$x$shadings
  [[1]]
  [[1]]$from
  [1] "2015-01-01T00:00:00.000Z"

  [[1]]$to
  [1] "2015-01-15T00:00:00.000Z"

  [[1]]$color
  [1] "#FF5FF5"

  [[1]]$axis
  [1] "x"
  dyplot<-dyShading(dyplot,from = "2016-1-1", to = "2016-1-15", color = "#FF5FF5")

dyplot$x$shadings

eee
[[1]]
[[1]]$from
[1] "2015-01-01 CST"

[[1]]$to
[1] "2016-01-01 CST"

[[1]]$color
[1] "#EFEFEF"

[[1]]$axis
[1] "x"


[[2]]
[[2]]$from
[1] "2015-01-15 CST"

[[2]]$to
[1] "2016-01-15 CST"

[[2]]$color
[1] "#EFEFEF"

[[2]]$axis
[1] "x"


[[1]]
[[1]]$from
[1] "2015-01-01T00:00:00.000Z"

[[1]]$to
[1] "2015-01-15T00:00:00.000Z"

[[1]]$color
[1] "#FF5FF5"

[[1]]$axis
[1] "x"


[[2]]
[[2]]$from
[1] "2016-01-01T00:00:00.000Z"

[[2]]$to
[1] "2016-01-15T00:00:00.000Z"

[[2]]$color
[1] "#FF5FF5"

[[2]]$axis
[1] "x"


for (i in shading_set) {dyttt(i)}
shading_set %>% l_ply(dyttt)

  dyplot %>%
  dyShading(from = c("2015-1-1","2016-1-1"), to = c("2015-1-15","2016-1-15"), color = "#FF5FF5")

> shading_set[1,] %>% (function(x) print(x[1]))
        from
1 2015-01-01
> shading_set[1,] %>% (function(x) print(x[2]))



# for (x in eventline) {frm_run_char_cmd("dyEvent(dyplot,x,'carlosset')")}
# # dyEvent("2015-6-30", "carlos", labelLoc = "bottom")
# llply(eventline,function(x) {frm_run_char_cmd(paste("dyEvent(dyplot,",x,")",sep=","))
# # dyEvent(dyplot,eventline[1], "carlos", labelLoc = "bottom")


# show dotchart
df_spec_stock_xts  %>% dotchart
# show plot density
ggplot(df_spec_stock_xts,aes(x=Close))+
geom_density(alpha=0.3,fill="red")

ggplot(df_spec_stock_xts,aes(x=Close))+
geom_histogram(binwidth = 0.01,alpha=0.3,fill="red")
# show density
density(df_spec_stock_xts$Close)
density(df_spec_stock_xts%>%Cl) %>% plot
density(df_spec_stock_xts%>%Cl) 

# +scale_y_continuous(labels = scales::percent)
# display histgram according price 
ggplot(df_spec_stock_xts,aes(x=Close))+
geom_histogram(binwidth = 0.001,alpha=0.3,fill="red")
# 等高线
frm_display_level<-function(df_spec_stock_xts){
  #frm_display_level(df_spec_stock_xts%>%tail(n=1000))
  ggplot(df_spec_stock_xts,aes(x=Close,y=Volume))+scale_y_log10()+
  geom_point()+
  stat_density2d(aes(colour = ..level..))
}

frm_display_level(df_spec_stock_xts%>%tail(n=1000))
###########################################
ggplot(df_spec_stock_xts,aes(x=Close,y=Volume))+scale_y_log10()+
geom_point()+
stat_density2d(aes(fill = ..density..),geom = "raster",contour = FALSE)

ggplot(df_spec_stock_xts,aes(x=Close,y=Volume))+scale_y_log10()+
labs(title = "close - Volume density")+
geom_point()+
stat_density2d(aes(alpha = ..density..),geom = "raster",contour = FALSE)
###########################################
# multi subplot
###########################################
subplot1 <- ggplot(df_spec_stock_xts,aes(x=Close,y=Volume))+scale_y_log10()+
  labs(title = "close - Volume density")+
  geom_point()+
  stat_density2d(aes(alpha = ..density..),geom = "raster",contour = FALSE)
subplot2 <- ggplot(df_spec_stock_xts,aes(x=Close))+
  geom_histogram(binwidth = 0.001,alpha=0.3,fill="red")
frm_combine_part <- function(subplot1,subplot2){
  # frm_combine_part(subplot1,subplot2)
  ########新建画图页面###########
  grid.newpage()  ##新建页面
  pushViewport(viewport(layout = grid.layout(2,1))) ####将页面分成2*2矩阵
  vplayout <- function(x,y){
    viewport(layout.pos.row = x, layout.pos.col = y)
  }
  print(subplot1, vp = vplayout(1,1))   ###将（1,1)和(1,2)的位置画图c
  print(subplot2, vp = vplayout(2,1))   ###将(2,1)的位置画图b
}
frm_combine_part(subplot1,subplot2)

###########################################
# show price vol xts
###########################################
frm_show_price_vol_xts <- function(df_plot){
  # close - Volume density
  # frm_show_price_vol_xts(df_spec_stock_xts)
  subplot1<-ggplot(df_plot,aes(x=Close,y=Volume))+scale_y_log10()+
  labs(title = "close - Volume density")+
  geom_point()+
  stat_density2d(aes(alpha = ..density..),geom = "raster",contour = FALSE)

  subplot2 <- ggplot(df_plot,aes(x=Close))+
  geom_histogram(binwidth = 0.001,alpha=0.3,fill="red")
  frm_combine_part(subplot1,subplot2)
}
frm_show_price_vol_xts(df_spec_stock_xts)


###########################################
# hist some data 
###########################################
hist_df <-function(series_list,bw=0.01,expand_per=5){
  # hist_df(df_spec_stock_xts %>% Cl,0.001) %>% barplot
  range_v <- range(series_list)
  # split data and generate table structure 
  ret_table<-table(cut(series_list,seq(range_v[1]*(1-expand_per/100),range_v[2]*(1+expand_per/100) ,by=bw)))
  # modify names for table
  namelist <- ret_table %>% names
  namelist <- gsub("\\(|\\]","",namelist)
  nsep <- namelist %>% str_split(",")%>% laply (as.double)
  names(ret_table) <- (nsep[,1]+nsep[,2])/2
  return(ret_table)
}
# sample hist_df
hist_df(df_spec_stock_xts %>% Cl,0.001) %>% barplot
hist_df(df_spec_stock_xts %>% Cl) %>% names
hist_df(df_spec_stock_xts %>% Cl) %>% names %>% str

hist_table<-hist_df(df_spec_stock_xts %>% Cl,0.001) 
# hist_table[hist_table==hist_table %>% quantile(0.9)]
# show > 80 percent and sort decreasing
ret_sort<-hist_table[hist_table >= (hist_table %>% quantile(c(0.8)))] %>% sort(decreasing = TRUE)
ret_sort %>% barplot()
ggplot(df_plot,aes(x=Close))+
  geom_histogram(binwidth = 0.001,alpha=0.3,fill="red")

hist_table[hist_table>=hist_table %>% quantile(c(1))]  # display max value scope
hist_table[hist_table<=hist_table %>% quantile(0.1)]  # display less some value 
#####################################################
# show Vol distribute
#####################################################
# display histgram according Vol 
ggplot(df_spec_stock_xts,aes(x=Volume))+scale_x_log10()+
  geom_density(alpha=0.3,fill="red")
# or
ggplot(df_spec_stock_xts,aes(x=Volume))+scale_x_log10()+
  geom_histogram(binwidth = 1,alpha=0.3,fill="red")

#####################################################
# show fortify method sample
#####################################################
# fortify method sample
# http://www.open-open.com/lib/view/open1448369109907.html
df_fortify<-fortify(df_spec_stock_xts[,1:4],melt=TRUE)
ggplot(df_fortify,aes(x=Value,fill=Series))+
  geom_density(alpha=0.3)
# Density
# geom_histogram(position = "identity",alpha=0.2)
fortify(df_spec_stock_xts,melt=TRUE) %>% head

faithful
ggplot(faithful,aes(x=waiting))+
# geom_histogram(binwidth=5,fill="lightblue",colour="black",alpha=0.2)+
geom_density(alpha=0.3,fill="red")

birthwt$smoke = factor(birthwt$smoke)
ggplot(birthwt,aes(x=bwt,fill=smoke))+
geom_histogram(position="identity",alpha=0.4)

#####################################################
# bband strategy sample 1
#####################################################
# all day
# sample methods
frm_syr_b1<- function(price_list){
  ret_list<-price_list
  bbands.close_day <- BBands( price_list )
  ret_list[bbands.close_day$pctB < 0,]<- -10
  ret_list[bbands.close_day$pctB >= 0,]<- 0
  ret_list[bbands.close_day$pctB > 1,]<- 10
  return(ret_list)
}
frm_syr_bpctB<- function(price_list){
  ret_list<-price_list
  bbands.close_day <- BBands( price_list )
  bbands.close_day$pctB <- bbands.close_day$pctB*100
  bbands.close_day$bandwidth <- bbands.close_day$up -bbands.close_day$dn
  return(cbind(bbands.close_day$pctB,bbands.close_day$bandwidth))
}

dotchart
#######################################################
# customer TA for quant mod chart series
#######################################################
lineChart(GS,line.type='h',TA=NULL) 
dotchart
#######################################################
s<-df_spec_stock_xts%>%Cl %>% BBands

s<-cbind(s,s[,"up"]-s[,"dn"])[100,]

frm_syr_b1

#########################################################
# TA operate
#########################################################
df_spec_stock_xts %>% chartSeries()
addEMV()
listTA()
dropTA("EMV")
dropTA("Vo")
dropTA(listTA())

# https://rdrr.io/rforge/fPortfolioBacktest/man/00fBacktest-package.html

# as.timeSeries(df_spec_stock_xts$Close) %>% histPlot
#########################################################
# show timeseries as histPlot densityPlot logDensityPlot
#########################################################
df_spec_stock_xts %>% Cl %>% as.timeSeries %>%  histPlot
df_spec_stock_xts %>% Cl %>% as.timeSeries %>%  densityPlot
df_spec_stock_xts %>% Cl %>% as.timeSeries %>%  logDensityPlot

# addTA(df_spec_stock_xts[,"Close"] %>% frm_syr_b1
# ,on=NA,col=6)
addTA((df_spec_stock_xts[,"Close"] %>% frm_syr_bpctB)$pctB
,on=NA,col=5)
addMACD()
#########################################################
# addTA
#########################################################
df_month<-df_spec_stock_xts%>%to.monthly
df_month%>% chartSeries()
addTA(df_month[,"..Close"] %>% frm_syr_bpctB,on=NA,col=5,type='h')  # histgram
addTA(df_month%>%Cl %>% frm_syr_bpctB,on=NA,col=5,type='h')  # histgram
addTA(df_month[,"..Close"] %>% frm_syr_bpctB,on=NA,col=5,type='l')
addTA(df_month[,"..Close"] %>% frm_syr_bpctB,on=NA,type='p', col='darkred', pch="_", cex = 2.5)
text(9, 112.00, "text cmd SOME TEXT", adj=0,col=5);
segments(9, 111.5, 12, 111.5,col=6)

#########################################################
s<-df_month[,"..Close"] %>% frm_syr_bpctB
s<-df_spec_stock_xts[,"Close"] %>% frm_syr_bpctB
l<- s<0     #method 1
l_h<-s$pctB>100  #method 2

#########################################################
# two condition fit then draw vline |
#########################################################
l_3<-s$pctB > quantile(s$pctB,probs=0.95,na.rm = T) #percent bband > scope*0.95
c<-df_month[,"..Close"]
l_close<-c >= quantile(c,probs=0.95,na.rm = T) #percent close > scope*0.95
df_month%>% chartSeries()
# addTA(l_3,on=-1,col='green',border='grey')
addTA(l_3&l_close,on=-1,col='green',border='grey') #two condition combine
# addTA(l$pctB,on=-1,col='red',border='grey')
# addTA(l_h$pctB,on=-1,col='blue',border='grey')
#########################################################
# sample test
#########################################################

df_month%>% chartSeries()
segments(11, 0, 11, 100,col=6)

# addTA(addLines(v=df_month[10]))
# chartSeries(s,TA="addLines(v=s[100])")
# addTA(addLines(v=s[10]))

# chartSeries(s,TA="addLines(v=s[100])")
###sample   draw line
library(quantmod)

chartSeries(s,TA="addLines(v=s[100])")

##draw v line
# data(sample_matrix)
# s <- as.xts(sample_matrix)
# l <- xts(!as.logical(s[,1]),index(s))
# l[100] <- TRUE
# chart_Series(s,TA="add_TA(l,on=1)")
# chart_Series(s,TA="add_TA(l,on=-1,col='grey',border='grey')")

s<-df_spec_stock_xts[,"Close"] %>% frm_syr_bpctB
# l<-s > quantile(s,probs=0.95,na.rm = T)
l<- s>115

# l<- s > quantile(s,probs=0.95,na.rm = T)
# quantile(x,probs=0.4)表示求序列X的40%百分位数 
chart_Series(df_spec_stock_xts)



# barplot(table(cut(iris$Sepal.Length,m)))
# barplot(table(cut(iris$Sepal.Length,seq(4,8,by=0.1))))

# quantile(s,probs=0.4)
addTA(l,on=-1,col='red',border='grey')


chart_Series(df_spec_stock_xts,TA="addTA(l,on=-1,col='red',border='grey')")

# quantile(s,probs=0.4)


# addTA(OpCl(df_spec_stock_xts), col=5, type='b', lwd=2)
addTA(OpCl(df_spec_stock_xts), col=5, type='h', lwd=2)


addTA(df_month[,"..Volume"] %>% frm_syr_bpctB
,on=NA,col=5)
addMACD()

df_week<-df_spec_stock_xts%>%to.weekly
df_week%>% chartSeries()


install.packages("quantstrat", repos="http://R-Forge.R-project.org") 
addTA(df_week[,"..Close"] %>% frm_syr_bpctB
,on=NA,col=5)
addMACD()


syrb1_ta<-
newTA(frm_syr_b1,
      Cl,
      on = 1)
df_spec_stock_xts %>% chartSeries()
syrb1_ta()


# sample for line type


getSymbols("SPY")

lines.SPY <- (Hi(SPY) + Lo(SPY))/2
names(lines.SPY) <- c("lines")
lines.SPY$BuySell <- ifelse(lag(lines.SPY$lines) > lines.SPY$lines, 1, -1)

chartSeries(SPY, subset="2011-08::", theme=chartTheme('white',
up.col='blue', dn.col='red'))
addTA(lines.SPY$lines[lines.SPY$BuySell == -1,], type='p', col='darkred', pch="_", on=1, cex = 2.5)
addTA(lines.SPY$lines[lines.SPY$BuySell == 1,], type='p', col='green4', pch="_", on=1, cex = 2.5)

getSymbols("SPY")

subset = "2011-03::"

dev.new()
chartSeries(SPY, subset=subset, theme="white")
test <- xts(rep(coredata(last(Cl(SPY))), 20), order.by=index(last(SPY, n=20)))
addTA(test, on=1, col="red", legend=NULL, lwd=3)

args(addLines) 


# newEMA <- newTA(EMA, Cl, on=1, col=7)
# newEMA()
# newEMA(on=NA, col=5)

# # create new EMA TA function
# newEMA <- newTA(EMA, Cl, on=1, col=7)
# newEMA()
# newEMA(on=NA, col=5)



#df_spec_stock_xts %>% plot( events = list(time = c("2007-03-15","2007-05-01"), label = "bad days"), blocks = list(start.time = c("2007-03-05", "2007-04-15"), end.time = c("2007-03-20","2007-05-30"), col = c("lightblue1", "lightgreen")))
#abline(v=100)

names(formals(plot.xts))

# plot(df_spec_stock_xts[,1:2]) 


# 6). events配置

# 基本事件分割线


# > plot(sample_xts[,1], events = list(time = c("2007-03-15","2007-05-01"), label = "bad days"), blocks = list(start.time = c("2007-03-05", "2007-04-15"), end.time = c("2007-03-20","2007-05-30"), col = c("lightblue1", "lightgreen")))


x <- stats::runif(12); y <- stats::rnorm(12)
i <- order(x, y); x <- x[i]; y <- y[i]
plot(x, y, main = "arrows(.) and segments(.)")
## draw arrows from point to point :
s <- seq(length(x)-1)  # one shorter than data
arrows(x[s], y[s], x[s+1], y[s+1], col= 1:3)
s <- s[-length(s)]
segments(x[s], y[s], x[s+2], y[s+2], col= 'pink')

###############draw part#############
p = ggplot(df_spec_stock)
p = p + geom_line( aes(date, close,colour=vol)) + 
     scale_colour_gradient(low="green", high="red")
p + geom_vline(xintercept = df_spec_stock$date[100])
p + geom_hline(yintercept = 20)
     df_spec_stock_xts %>% index

addMACD()
addBBands()
zooom()
df_spec_stock_xts %>% chartSeries()
 names(df_month)<-c("Open",     "High",     "Low",      "Close",    "Volume",   "Adjusted")
df_month<-df_spec_stock_xts%>%to.monthly
df_month%>% chartSeries()
# addBBands()
# BBands(df_month)
# addTA(BBands(Cl(df_month)),on=1)
addTA(EMA(Cl(df_month)),on=1,col=5)

bbands.close <- BBands( df_month[,"Close"]) 

#all day
df_spec_stock_xts %>% chartSeries()
# sample methods
bbands.close_day <- BBands( df_spec_stock_xts[,"Close"] )

df_spec_stock_xts[,"Close"][bbands.close_day$pctB < 0,]<- -10
df_spec_stock_xts[,"Close"][bbands.close_day$pctB > 1,]<- 10

addTA(df_spec_stock_xts[,"Close"]
,col=6)


addBBands()

BBands(Cl(df_month)) %>% class
[1] "xts" "zoo"

# function (HLC, n = 20, maType, sd = 2, ...) 
# {
#     HLC <- try.xts(HLC, error = as.matrix)
#     if (NCOL(HLC) == 3) {
#         if (is.xts(HLC)) {
#             xa <- xcoredata(HLC)
#             HLC <- xts(apply(HLC, 1, mean), index(HLC))
#             xcoredata(HLC) <- xa
#         }
#         else {
#             HLC <- apply(HLC, 1, mean)
#         }
#     }
#     else if (NCOL(HLC) != 1) {
#         stop("Price series must be either High-Low-Close, or Close/univariate.")
#     }
#     maArgs <- list(n = n, ...)
#     if (missing(maType)) {
#         maType <- "SMA"
#     }
#     mavg <- do.call(maType, c(list(HLC), maArgs))
#     sdev <- runSD(HLC, n, sample = FALSE)
#     up <- mavg + sd * sdev
#     dn <- mavg - sd * sdev
#     pctB <- (HLC - dn)/(up - dn)
#     res <- cbind(dn, mavg, up, pctB)
#     colnames(res) <- c("dn", "mavg", "up", "pctB")
#     reclass(res, HLC)
# }
# <environment: namespace:TTR>



bbands.HLC <- BBands( df_month[,c("High","Low","Close")] )
bbands.close <- BBands( df_month[,"Close"] 


bbands.HLC_day <- BBands( df_spec_stock_xts[,c("High","Low","Close")] )
bbands.close_day <- BBands( df_spec_stock_xts[,"Close"] )

bbands.close_day[bbands.close_day$pctB < 0]


bbands.HLC <- BBands( df_month[,c("High","Low","Close")] )
bbands.HLC %>% as.data.frame(stringsAsFactors = FALSE) %>% arrange(desc(pctB))



getSymbols('SBUX')
barChart(SBUX)
addTA(EMA(Cl(SBUX)), on=1, col=6)
addTA(OpCl(SBUX), col=4, type='b', lwd=2)


frm_xts_stock_price<-function(stockid,date_format="%Y-%m-%d"){
  df_spec_stock<-frm_stock_from_tdx_file(stockid)
  # date format from int to Date 
  df_spec_stock<-frm_change_date_format(df_spec_stock,date_format)
  # transform df to xts
  df_spec_stock_xts<- df_spec_stock[,1:7]
  df_spec_stock_xts<- frm_repair_to_xts(df_spec_stock[,1:7])
  return(df_spec_stock_xts)
}
xts1<-frm_xts_stock_price(1)
xts2<-frm_xts_stock_price(2)
df_600305$date %>%range 
ots<-ts(df_600305$close,start = c(2001,2,6))
ots%>% decompose %>% plot

price<-df_600305$close
price %>% hist
d1=density(price)
range(price)
x=seq(0.7,19.6,.001)
y1=dnorm(x,mean(price),stdev(price))
plot(d1$x,d1$y,type='l')
lines(x,y1,lty=2)


format(turnover_data[1:5, 1:6],digits = 3)

###########################################3
## plot 
###########################################3
# filter date
df_plot<-subset(df_600305,date>"20100101" %>% as.Date("%Y%m%d"))
p = ggplot(df_plot)
# p+  geom_point( aes(date, close))
#  show vol with close
p + geom_point( aes(date, vol,size=close,colour=close)) + 
     scale_colour_gradient(low="green", high="red")

#  show close with vol
p + geom_point( aes(date, close,size=vol,colour=vol)) + 
     scale_colour_gradient(low="green", high="red")
p + geom_point( aes(date, close,size=vol,colour=vol)) + 
    scale_colour_gradient2(low=muted("red"), mid="white", high=muted("blue"))

p + geom_point( aes(date, close,size=vol,colour=vol)) + scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))    


#  show vol  
p + geom_point( aes(date, vol,size=close,colour=close))   

require(grid)
# plot 
#####现将图画好，并且赋值变量，储存#####
options(digits=3) to set the number of digits to 4 in the computer output
that appears in the book.


frm_show_price_vol <- function(df_plot){
  # show 2 subplot about price ~ vol
  p = ggplot(df_plot)
  subplot1 <- p + geom_point( aes(date, vol,colour=close)) + 
                    scale_colour_gradient(low="green", high="red")
  subplot2 <- p + geom_point( aes(date, close,colour=vol)) + 
                    scale_colour_gradient(low="green", high="red")
  ########新建画图页面###########
  grid.newpage()  ##新建页面
  pushViewport(viewport(layout = grid.layout(2,1))) ####将页面分成2*2矩阵
  vplayout <- function(x,y){
    viewport(layout.pos.row = x, layout.pos.col = y)
  }
  # par(mfrow=c(2,1))
  p_plot<-ggplot(df_plot)
  print(subplot1, vp = vplayout(1,1))   ###将（1,1)和(1,2)的位置画图c
  print(subplot2, vp = vplayout(2,1))   ###将(2,1)的位置画图b
}
df_plot<-subset(df_600305,date>"20100101" %>% as.Date("%Y%m%d"))
df_plot %>% frm_show_price_vol
df_600305%>% frm_show_price_vol

###########################################3
## plot 
###########################################3
# filter date
df_plot<-subset(df_spec_stock,date>"20150101" %>% as.Date("%Y%m%d"))
p = ggplot(df_plot)
# p+  geom_point( aes(date, close))
#  show close with vol
p + geom_point( aes(date, close,size=vol,colour=vol)) + 
     scale_colour_gradient(low="green", high="red")
p + geom_point( aes(date, close,size=vol,colour=vol)) + 
    scale_colour_gradient2(low=muted("red"), mid="white", high=muted("blue"))

p + geom_point( aes(date, close,size=vol,colour=vol)) + scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))    


#  show vol  
p + geom_point( aes(date, vol,size=close,colour=close))   




###########################################3
## stock finance report analysis
###########################################3
# stock_shanghai.db
source("~/sdcard1/syrhadestock/R/cl_part_function.R")
fi_report<-cl_db_oprate$new("~/sdcard1/stock_shanghai.db")

# fi_report<-cl_db_oprate$new("e:/stock_shanghai.db")

fi_report$show_db_dbi()
df_zcfz_stock  <- fi_report$query_db_dbi("select * from zcfz_600000 ")
df_xjll_stock   <- fi_report$query_db_dbi("select * from xjll_600000 ")
df_lr_stock     <- fi_report$query_db_dbi("select * from lr_600000 ")
# df_zcfz_stock %>% frm_show_html_v2
# df_zcfz_test <- df_zcfz_stock %>% head %>% t %>% as.data.frame(stringsAsFactors = FALSE)
df_zcfz_test <- df_zcfz_stock %>%  t %>% as.data.frame(stringsAsFactors = FALSE)
# df_zcfz_test %>% str
colnames(df_zcfz_test)<- paste0("V",colnames(df_zcfz_test))
# set NA value to ""
df_zcfz_test[is.na(df_zcfz_test)] <- ""
colnames(df_zcfz_test)[1]<-"item"
df_zcfz_test <- frm_syr_transform_batch_args(df_zcfz_test,gsub,prefix_str="",field_scope=-1,list("--","0"))
df_zcfz_test <- frm_syr_transform_batch_args(df_zcfz_test,gsub,prefix_str="",field_scope=-1,list(",",""))
df_zcfz_test <- frm_syr_transform_batch_args(df_zcfz_test,as.double,prefix_str="",field_scope=-1)


df_zc_all<-df_zcfz_test
# set NA value to ""
df_zc_all[is.na(df_zc_all)] <- 0
# index(df_zc_all) 1 && index(df_zc_all)  < 43

df_zc <- frm_extract_area(df_zc_all,1,44)

######################################0
## show struct plot
######################################

######################################
##transfrom bl value  
######################################
call_bl<-function(idx,V2){
    V2/V2[idx]*100
}
idx<-nrow(df_zc)
df_zc <- frm_syr_transform_batch_args(df_zc,call_bl,prefix_str="bl_",field_scope=-1,list(idx))
df_zc <- subset(df_zc,bl_VV2 != 0)
subset(df_zc,select=grep("[bl_|item]", df_zc%>%colnames, value = TRUE) )
df_zc2 <-subset(df_zc,select=grep("[bl_|item]", df_zc%>%colnames, value = TRUE) )

df_zc2<-df_zc2[,seq(5)]
df_zc2 <-df_zc2[-nrow(df_zc2),]
#  show bar plot 
year_num <- ncol(df_zc2)
# seq(2016,by = -1,length.out= year_num)
colnames(df_zc2)[-1] <-seq(2016,by = -1,length.out= year_num)
show_df <- melt(df_zc2,id="item")
# ggplot(show_df,  aes(variable,  value,  fill = item)) +
# geom_bar(stat = "identity" ,  position = "dodge" ) +
# coord_flip()

ggplot(show_df,  aes(item,  value,  fill = variable)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
# facet_wrap(~ item)+
coord_flip()

ggplot(show_df,  aes(variable,  value,  fill = variable)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
facet_wrap(~ item)


#pie plot
ggplot(show_df,  aes(x=item,  y=value,  fill = item)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
coord_polar("y")+
facet_wrap(~ variable)

#pie plot 2
df_pie<-subset(show_df,variable==2016)
#                  item variable       value
# 1  现金及存放同业款项     2016  2.54656674
blank_theme <- theme_minimal()+
  theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.border = element_blank(),
  panel.grid=element_blank(),
  axis.ticks = element_blank(),
  plot.title=element_text(size=14, face="bold")
  )

library(scales)
ggplot(df_pie, aes(x="",y=value, fill=item))+
  geom_bar(stat = "identity",width = 1)+
  coord_polar("y")  +  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
            label = paste(item,percent(value/100))), size=4)


  ggplot(df_pie, aes(x="",y=value, fill=item))+
  geom_bar(stat = "identity",width = 1)+
  coord_polar("y")  +  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
            label = percent(value/100)), size=5)
####################################################



ggplot(df_zc3,  aes(item,  bl_VV2,  fill = item)) +
geom_bar(stat = "identity" ,  position = "dodge" ) +
coord_flip()

ggplot(df_zc3,  aes(item,  bl_VV2,  fill = item)) +
 geom_bar(stat = "identity" ) +
 coord_flip()


ggplot(df_zc3,  aes(item,  bl_VV2,  fill = item)) +
geom_bar(stat = "identity" ,  position = "fill" ) +
coord_flip()

######################################0
## one indictor delta plot 
######################################
frm_show_one_item_plot <- function(df_obj,idx) {
    df_obj <- df_obj[idx,] %>% t %>%as.data.frame(stringsAsFactors=FALSE)
    df_obj <- mutate(df_obj, prev = lead(V2,0))
    df_obj <- df_obj[-1,]
    df_obj$date<-seq(2016,by=-1,length.out=nrow(df_obj))
    # df_obj <- df_obj[-nrow,]
    return(df_obj)
}
# df_zc%>%frm_show_one_item_plot(1)
df_zc_indictor <- frm_show_one_item_plot(df_zc,1) 
df_zc_indictor<- frm_syr_transform_batch_args(df_zc_indictor,as.double,prefix_str="")
df_zc_indictor <- mutate(df_zc_indictor, delta = V2-lead(V2,0))
df_zc_indictor <- mutate(df_zc_indictor, delta_percent = delta/prev*100)

df_zc_indictor <- mutate(df_zc_indictor, date = as.character(date))
df_zc_indictor <- mutate(df_zc_indictor, date = paste(date,"01","01",sep="-")%>%as.Date)
df_zc_indictor <- df_zc_indictor[-nrow(df_zc_indictor),]
df_zc_indictor <- mutate(df_zc_indictor, 
                                        delta_percent_m5 = rollapply(delta_percent,10,
                                                                         mean,fill = 0, align = "right"))
df_zc_indictor <- mutate(df_zc_indictor, 
                                        delta_m5 = rollapply(delta,10,
                                                                         mean,fill = 0, align = "right"))


df_zc_indictor <- df_zc_indictor[-nrow(df_zc_indictor),]

require(grid)
# plot 
#####现将图画好，并且赋值变量，储存#####
subplot1 <- p_plot+geom_line(aes(date,  delta_percent,color=I("green"))) +
            geom_line(aes(date,  delta_percent_m5,color=I("red"))) 
subplot2 <- p_plot+geom_line(aes(date,  delta,color=I("green"))) +
           geom_line(aes(date,  delta_m5,color=I("red"))) 

########新建画图页面###########
grid.newpage()  ##新建页面
pushViewport(viewport(layout = grid.layout(2,1))) ####将页面分成2*2矩阵
vplayout <- function(x,y){
  viewport(layout.pos.row = x, layout.pos.col = y)
}
# par(mfrow=c(2,1))
p_plot<-ggplot(df_zc_indictor)
print(subplot1, vp = vplayout(1,1))   ###将（1,1)和(1,2)的位置画图c
print(subplot2, vp = vplayout(2,1))   ###将(2,1)的位置画图b


##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>##


rollmean(x, k, fill = if (na.pad) NA, na.pad = FALSE, 
  align = c("center", "left", "right"), ...)

plot(df_zc_indictor$delta_percent ,type="l")
plot(df_zc_indictor$delta ,type="l")



arrange(right, year)
df_zc_indictor <- df_zc[1,]%>%as.list
lag


df_zc[2,2:20] %>%as.matrix %>% barplot

######################################0
##test end 
######################################

######################################
##  java -jar pdfbox-app-2.0.3.jar ExtractText  600031_2015_n.pdf 600031.txt
######################################
######################################
## process txt from pdf 
######################################
source("~/sdcard1/syrhadestock/R/cl_part_function.R")
tb111<-read.csv("~/sdcard1/600031.txt",header = F,sep = " ")


source("e:/syrhadestock/R/cl_part_function.R")
tb111<-read.csv("e:/600031.txt",header = F,sep = " ")


tb111[is.na(tb111)] <- ""
print(nrow(tb111))
filter_index<-apply(tb111,1,function(x) all(x==""))
tb111_filter<-tb111[!filter_index,] 




bindtextdomain("R")  # non-null if and only if NLS is enabled

for(n in 0:3)
    print(sprintf(ngettext(n, "%d \t variable has missing values",
                              "%d variables have missing values"),
                  n))

to_convert <-  list(
first = sapply(letters[1: 5],  charToRaw),
second = polyroot(c(1, 0, 0, 0, 1)),
third = list(x = 1: 2,  y = 3: 5)
)

result <-  try(lapply(to_convert,  as.data.frame))

tryCatch(
lapply(to_convert,  as.data.frame),
error = function(e)
{
message("An error was thrown: " ,  e$message)
data.frame()
}
)


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

Since this is a common piece of code, the plyr package contains a function, tryapply,
that deals with exactly this case in a cleaner fashion:
tryapply(to_convert,  as.data.frame)

inner_fn <- function(x)
{
browser() #execution pauses here
exp(x)
}

ls.str ()

############################3    
# transform(df_zc,blV2=V2/V2[nrow(df_zc)]*100)

subset(df_zc,select=grep("item", df_zc%>%colnames, value = TRUE) )


df_zc %>% frm_show_percent

df_zc_all %>% frm_show_html_v2


df_fz <- frm_extract_area(df_zc_all,43,79)
df_fz %>% frm_show_percent

df_qy <- frm_extract_area(df_zc_all,78,91)
df_qy %>% frm_show_percent

# convert percents order
totall_value<-df_zc$fx1[nrow(df_zc)]
df_zc$bl<-df_zc$fx1/totall_value*100
df_zc <- arrange(df_zc,desc(bl))
pie(df_zc[-1,]$bl, labels=df_zc[-1,]$item)


df_zc
df_zc <- df_zc_all %>% frm_extract_area(1,43)
df_zc<-cbind(df_zcfz_test$fx1[1:42]/df_zcfz_test$fx1[43]*100,df_zcfz_test$item[1:42]%>%as.character)
df_zc<-df_zc %>% as.data.frame(stringsAsFactors = FALSE)
df_zc<-transform(df_zc,V1=as.double(V1))


df_zc[sort(df_zc[,1])]
# check balance
df_zc[-1,1]%>%as.double%>%sum


df_zcfz_test[,"2"] <-gsub("--","0",df_zcfz_test[,"2"])
df_zcfz_test[,"2"] <-gsub(",","",df_zcfz_test[,"2"])
# df_zcfz_test[,"2"] %>% as.double
df_zcfz_test <- as.data.frame(df_zcfz_test)
df_zcfz_test$fx1<-df_zcfz_test[,"2"] %>% as.double
#  set item account type 
df_zcfz_test$type<-"zc"
df_zcfz_test$type[index(df_zcfz_test) 43]<-"fz"
df_zcfz_test$type[index(df_zcfz_test) 78]<-"qy"

# check sum account
df_zcfz_test$fx1[2:42] %>% sum == df_zcfz_test$fx1[43]
df_zc<-cbind(df_zcfz_test$fx1[1:42]/df_zcfz_test$fx1[43]*100,df_zcfz_test$"1"[1:42]%>%as.character)
df_zcfz_test$fx1[1:42]/df_zcfz_test$fx1[43]

as.character(directions.factor)



###############################################################
#
#
#
###############################################################
###############################################################
###############################################################
# df_zcfz_test[,"2"] <-df_zcfz_test[,"2"] %>% as.integer


# transform(df_zcfz_test,df_zcfz_test[,"2"] = gsub("--","0",df_zcfz_test[,"2"]))
V42



ta$query_db_dbi("select * from cwbl_000059")
n_col <- ncol(ta$query_df)
frm_show_html_v2<-function(query_df){
	query_df%>%htmlTable(    col.columns = c("none", "#FF00FF"),
	                                                    caption="syrhades test caption",
	                                                    col.rgroup = c("none", "#00FFFF"),
	                                                    align=paste(rep('c',n_col),collapse='|'))
}
frm_show_html_v2(ta$query_df[,c("V1","V99","V101","V97")])
frm_show_html_v2(ta$query_df)
frm_show_html_v2(ta$query_df[,c("V1","V97","V98","V99","V100","V101","V102","V103")])

frm_run_char_cmd<-function(char_str){
    eval(parse(text=char_str))
}


#dftest<-ta$query_df[,c("V1","V99")]
test_df<-ta$query_df[,c("V1","V97","V98","V99","V100","V101","V102","V103")]


#######sample 1 fx pair  Ã¿¹ÉÊÕÒæ ¾»×Ê²úÊÕÒæÂÊ############################
fx_pair<-(c("V26","V99"))
test_df<-ta$query_df[,fx_pair]
# get label name
xlabel_name= test_df[1,1]
ylabel_name= test_df[1,2]
dftest<-test_df[-1,]
p = ggplot(dftest)
p+  geom_point( aes(V26, V99))+
xlab(xlabel_name)+ylab(ylabel_name)+
 theme(axis.title.x=element_text(face="italic", colour="darkred", size=14))

+ stat_smooth()
p+  geom_point( aes(V26, V99))+ geom_rug(position="jitter" ,  size=.2)

###########################################
dftest<-test_df[-1,]
dftest["srsy_zb"]<-as.numeric(dftest$V100)/as.numeric(dftest$V101)
p = ggplot(dftest)
p+geom_point( aes(V1, srsy_zb))+
	geom_line( aes(x = V1, y = srsy_zb)
#frm_show_html_v2(dftest)
yearlist_zb<-dftest[grep("12.31",dftest$V1),]
frm_show_delta_df(yearlist_zb,9)
frm_show_delta_df(yearlist_zb,2)

frm_convert_df_data_type<-function(position_idx,df_obj){
	#df_obj[,position_idx]<-as.numeric(df_obj[,position_idx])
	evalq(x<-"aaaa")
	do.call("transform", list(df_obj,V97=as.numeric(V97))) 
	transform(df_obj,V97=as.numeric(V97))
	return(df_obj)
}
fx_pair(c("V26","V99"))


eval({ xx <- pi; xx^2}) ; xx

frm_run_char_cmd("yearlist_zb<-transform(yearlist_zb,V98=as.numeric(V98),V97=as.numeric(V97))")
colnames(yearlist_zb)
lapply(colnames(yearlist_zb),function(x) print(paste(x,"=as.numeric(",x,")",sep="")))
"x","=as.numeric(",x,")",sep=""
trans_detail<-llply(colnames(yearlist_zb)[-1],function(x) print(paste(x,"=as.numeric(",x,")",sep="")))%>%paste(collapse=",")
paste("transform(","yearlist_zb",",",trans_detail,")")%>%frm_run_char_cmd

frm_syr_transform_batch<-function(df_obj,func,field_scope){
    #batch retype data type 
    # frm_syr_transform_batch(yearlist_zb,as.numeric,c(-1,-3))  field_scope
    dbf_name    <-substitute(df_obj)
    func_name   <-substitute(func)
    print(dbf_name)
    print(func_name)
    trans_detail<-llply(colnames(df_obj)[field_scope],function(x) print(paste(x,"=",func_name,"(",x,")",sep="")))%>%paste(collapse=",")
	#return (paste("transform(",dbf_name,",",trans_detail,")"))
    return(paste("transform(",dbf_name,",",trans_detail,")")%>%frm_run_char_cmd)
}
frm_syr_transform_batch(yearlist_zb,as.numeric,-1)

substitute(expr, env)
quote(yearlist_zb)
enquote(yearlist_zb)


# frm_run_char_cmd
# ptext<-parse(text="V98=as.numeric(V98)")
# do.call("transform", list(yearlist_zb,ptext)) 

do.call("transform", list(yearlist_zb,V97=as.numeric(V97))) 
# substring
# nchar

## if we already have a list (e.g., a data frame)
## we need c() to add further arguments
tmp <- expand.grid(letters[1:2], 1:3, c("+", "-"))
do.call("paste", c(tmp, sep = ""))

do.call(paste, list(as.name("A"), as.name("B")), quote = TRUE)
do.call(transform, list(yearlist_zb, as.name("V98=as.numeric(V98)")), quote = TRUE)

do.call(print, list(as.name("yearlist_zb$V98")), quote = T)

testaaaa<-as.name("yearlist_zb$V98")
yearlist_zb$V98
eval(yearlist_zb$V98) # eval a string the same as yearlist_zb$V98 

#do.call(transform, list(yearlist_zb,expression(V98=as.numeric(V98))))
frm_convert_df_data_type(2,yearlist_zb)[,2]
ldpl	y(seq(2,ncol(yearlist_zb)),frm_convert_df_data_type,yearlist_zb)

###ÅúÁ¿convert char to numeric in dataframe


tbl_year<-tbl_df(yearlist_zb)



frm_show_zb<-function(df_obj,position_idx){
	df_obj[,position_idx]<-as.numeric(df_obj[,position_idx])
	
	df_indicator<-df_obj[order(df_obj[,1]),] 
	
	p = ggplot(df_indicator, aes(x = V1, y = df_indicator[,position_idx]))
	p +geom_point()
	# p +geom_line()
}
frm_show_zb(yearlist_zb,2)

#V97	V98	V99	V100	V101	V102	V103
tseq2 <- frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99","V101","V97"),colum_name_vec=c("Date","mgsy"))
#set col name 
colnames(tseq2)<-c("v1","v2","v3")
#convert xts to dataframe
df_xtsseq <- as.data.frame(tseq2)
df_xtsseq$Date <- as.Date(row.names(df_xtsseq))
frm_convert_factor2_num <- function (factor_obj){
	## using the function to convert factor to numeric
	as.numeric(as.character(factor_obj))
	}


## get BS_table from csv file
df_BS_table2<-cl_stock_data_tool$new(000001)$frm_generate_BS_table()
df_all<-merge(df_BS_table2, df_xtsseq,all = F)

# compute PE PB
df_all["pe"] <- df_all$close/frm_convert_factor2_num(df_all$v1)   ##Price to Earning Ratio£¬¼´ÊÐÓ¯ÂÊ£¬¼ò³ÆPE»òP/E Ratio
df_all["PB"] <- df_all$close/frm_convert_factor2_num(df_all$v3)  ##ÊÐ¾»ÂÊ

#df_all$pe[500:510,]
###draw plot
pt <- ggplot(df_all)+
	geom_point(aes(Date, PB,colour = I("blue")))
pt + geom_line(aes(Date ,close,colour = I("red"))) + 
	labs(x="date",y="PB",title = "stock 000001") +
	geom_point(aes(Date ,pe,colour = I("#CC6666")))
##################################################################

df_all$v1
range(na.omit(df_all$pe))
#tseq2['1995/1996']
#axTicksByTime(test_xts1, ticks.on='months')
#plot(test_xts1,major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)



#frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99","V101"),colum_name_vec=c("Date","mgsy"))
#frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99"),colum_name_vec=c("Date","mgsy"))


df_xtsseq[df_xtsseq[,1]!= "--"]
#################################
#draw function
##################################
 pt<-ggplot(df_xtsseq, aes(Date, ..1))+
 geom_line()

 pt
 pt<-ggplot(BS_table2, aes(Date, avg))+
 geom_point(aes(colour = vol))




df_all[1:10,]

df_all[500:510,]$close/df_all[500:510,]$v1



pt<-ggplot(df_all)+
 geom_point(aes(Date, v1,colour = I("blue")))
pt+geom_point(aes(Date ,v2,colour = I("red")))+
geom_point(aes(Date ,avg,colour = I("red")))

pt<-ggplot(df_all, aes(Date, avg))+ geom_point(aes(colour = vol))
pt+geom_point(aes(Date ,v2,colour = I("red")))
#xts_BS_table2<-as.xts(df_BS_table2)
#xts_all<-merge(xts_BS_table2, tseq2,all = F)


, by.x = "Date", by.y = "Date",all = F)
as.xts(BS_table2)

BS<-merge(BS_table2, tseq2F)
BS[1000:1010,]
## Then plot price and finance indictor 
BS$..1<-as.numeric(BS$..1)
BS$pe<-BS$close / BS$..1


frm_test<- function(){
#strptime("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01 CST"
#as.Date("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01"
#


}
##############################





#year list
yearlist_zb<-dftest[grep("12.31",dftest$V1),]
yearlist_zb
frm_show_delta_df(yearlist_zb,2)

grep("12.31",df_indicator$V1)

# library(ggplot2)
# library(ggthemes)
# dt = data.frame(obj = c('A','D','B','E','C'), val = c(2,15,6,9,7))
# p = ggplot(dt, aes(x = obj, y = val, fill = obj, group = factor(1))) + 
#     geom_bar(stat = "identity") +
#     theme_economist()
# p


#########################################################
cl_syrhades_tool <- R6Class("tool",    # ¶¨ÒåÒ»¸öR6Àà
	lock_objects = FALSE,
	public=list(
            initialize = function(){
                },
            frm_get_url_xpath = function(url,xpath_exp){
                url_html <- htmlParse(url) 
                ans <- getNodeSet(url_html , xpath_exp)
                #sapply(ans, xmlValue)
                #return(ans)
                },
            frm_grex_str = function(strobj,grep_expr){
                greg_result<-gregexpr(grep_expr,strobj)[[1]]
                startpos<-greg_result
                length_pos<-attr(greg_result,"match.length")
                lapply(startpos,function(x) substr(strobj,x,x+length_pos-1))
                }
                
            )
    )
#da<-cl_Stock_report_process$new(19,dbfile,"sz")$frm_1()
#da%>%htmlTable
frm_set_path<-function(){
    ## check OS R_PLATFORM
    R_PLATFORM<-Sys.getenv(c("R_PLATFORM"))
    if(str_detect(R_PLATFORM, "linux")) path<-"~/sdcard1"
    else path<-"e:"
    return (path)
}

frm_batch_stock_report<-function(stockfile,dbf_name){
    ## reading stock list file to save report information to dbfile 
    filename<-paste(frm_set_path(),stockfile,sep="/")
    stockdf<-read.csv(filename,sep =".",head = F)
    dbfile<-paste(frm_set_path(),dbf_name,sep="/")

    lapply(seq(1,nrow(stockdf)),
                        function(idx) d_ply(stockdf[idx,],"V2",
                                                            function(x) cl_Stock_report_process$new(x$V1,dbfile,str_to_lower(x$V2))$frm_all()))
}

system.time(frm_batch_stock_report(stockfile="stocklist.log",dbf_name=dbfile))

#library(profvis)

#p <-profvis({
#  frm_batch_stock_report(stockfile="stocklist.log",dbf_name="tb_finance_test2.db")
#})

library(reshape2)
melt(anthoming,  id.vars="angle" ,  variable.name="condition" ,  value.name="count" )
plum_wide
length time dead alive
long at_once 84 156
long in_spring 156 84
short at_once 133 107
short in_spring 209 31
melt(plum_wide,  id.vars=c("length" , "time" ),  variable.name="survival" ,
value.name="count" )



stack {utils}   R Documentation
Stack or Unstack Vectors from a Data Frame or List

Description

Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated. Unstacking reverses this operation.

Usage

stack(x, ...)
## Default S3 method:
stack(x, ...)
## S3 method for class 'data.frame'
stack(x, select, ...)

unstack(x, ...)
## Default S3 method:
unstack(x, form, ...)
## S3 method for class 'data.frame'
unstack(x, form, ...)
Arguments

x   
a list or data frame to be stacked or unstacked.

select  
an expression, indicating which variable(s) to select from a data frame.

form    
a two-sided formula whose left side evaluates to the vector to be unstacked and whose right side evaluates to the indicator of the groups to create. Defaults to formula(x) in the data frame method for unstack.

... 
further arguments passed to or from other methods.

Details

The stack function is used to transform data available as separate columns in a data frame or list into a single column that can be used in an analysis of variance model or other linear model. The unstack function reverses this operation.

Note that stack applies to vectors (as determined by is.vector): non-vector columns (e.g., factors) will be ignored (with a warning as from R 2.15.0). Where vectors of different types are selected they are concatenated by unlist whose help page explains how the type of the result is chosen.

These functions are generic: the supplied methods handle data frames and objects coercible to lists by as.list.

Value

unstack produces a list of columns according to the formula form. If all the columns have the same length, the resulting list is coerced to a data frame.

stack produces a data frame with two columns:

values  
the result of concatenating the selected vectors in x.

ind 
a factor indicating from which vector in x the observation originated.

Author(s)

Douglas Bates

See Also

lm, reshape

Examples

require(stats)
formula(PlantGrowth)         # check the default formula
pg <- unstack(PlantGrowth)   # unstack according to this formula
pg
stack(pg)                    # now put it back together
stack(pg, select = -ctrl)    # omitting one vector
[Package utils version 3.3.1 Index]

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
example, we can ¡°move¡± values in the survival column to the top and fill them with
values from count:
library(reshape2)
dcast(plum,  length + time ~ survival,  value.var="count" )
length time dead alive
long at_once 84 156
long in_spring 156 84
short at_once 133 107
short in_spring 209 31

# grep("\\d", df_zcfz_test%>%colnames, value = TRUE) [-1]%>% sapply(print)

# preprocess_list<-grep("\\d", df_zcfz_test%>%colnames, value = TRUE) 
# preprocess_list %>% sapply(function(x) frm_stock_col_format(df_zcfz_test,as.integer(x))
# preprocess_list[-1] %>% sapply(function(x) df_zcfz_test[,as.integer(x)])
# tb <- preprocess_list[2] %>% sapply(function(x) frm_stock_col_format(df_zcfz_test,as.integer(x)))

    # %>% sapply(print)
# mapply(frm_stock_col_format,df_zcfz_test,preprocess_list)

# frm_stock_col_format<-function(df_object,col_index){
#     col_str <- col_index %>% as.character
#     df_object[,col_str] <-gsub("--","0",df_object[,col_str])
#     df_object[,col_str] <-gsub(",","",df_object[,col_str])
#     df_object <- as.data.frame(df_object,stringsAsFactors = FALSE)
#     # df_object$fx1<-df_object[,col_str] %>% as.double
#     df_object[,col_str]<-df_object[,col_str] %>% as.double
#     colnames(df_object)[1]<-"item"
#     df_object
# }


# frm_stock_col_tidy <- function(df_obj){
#     # print(df_obj)
#     df_obj <- frm_syr_transform_batch_args(df_obj,gsub,field_scope=-1,list("--","0"))
#     df_obj <- frm_syr_transform_batch_args(df_obj,gsub,field_scope=-1,list(",",""))
#     df_obj <- frm_syr_transform_batch_args(df_obj,as.double,field_scope=-1)
#     colnames(df_obj)[1]<-"item"
#     df_obj
# }
# as.numeric
# df_zcfz_test<- frm_stock_col_tidy(df_zcfz_test)
# laply(preprocess_list[2],function(x) frm_stock_col_format(df_zcfz_test,as.integer(x)))
# df_zcfz_test <- frm_stock_col_format(df_zcfz_test,3)
# df_zcfz_test$fx1
# zc classify  zhichan fenlei
# df_zc_all<-df_zcfz_test[,c("item","fx1")]



quantmod
Quantitative Financial Modelling & Trading Framework for R

    quantmod

    news

    what's next

    documentation

    examples

    gallery

    download

    license

    feeds

    R/quant links

    add to del.icio.us

{ examples :: charting }

If there was one area of R that was a bit lacking, it was the ability to visualize financial data with standard financial charting tools. By virtue of no other package implementing this, quantmod took up the call and took a shot at providing a solution.

What started with a single OHLC charting solution has grown into a highly configurable and dynamic charting facility as of version 0.3-4, with more coolness slated for 0.4-0 and beyond.

For now, let's take a look at what its currently in place:
Financial Charts in quantmod:

    The workhorse: chartSeries
    Meet the friends: barChart, candleChart, and lineChart
    Chart Arguments: what can you do?
    Voodoo: Technical Analysis with TTR and addTA

Most of the charting functionality is designed to be used interactively. The following examples should be very easy to replicate from the command line or your personal GUI choice. Running from a script requires a bit of extra care, but is now possible as well.

Let's get charting!
Introducing chartSeries
chartSeries is the main function doing all the work in quantmod. Courtesy of as.xts it can handle any object that is time-series like, meaning R objects of class xts, zoo, timeSeries, its, ts, irts, and more!

By default any series that is.OHLC is charted as an OHLC series. There is a type argument which allows the user to decide on the style to be rendered: traditional bar-charts, candle-charts, and matchstick-charts -- thin candles ... get it :) -- as well as line charts.

The default choice ['auto'] lets the software decide, candles where they'd be visible clearly, matchsticks if many points are being charted, and lines if the series isn't of an OHLC nature. If you don't like to always specify the type to override this behavior you are free to use the wrapper functions in the next section, or make use of setDefaults from the wickedly cool and useful Defaults package (available on CRAN). The fact that I wrote it has nothing to do with my endorsement :) > getSymbols("GS") #Goldman OHLC from yahoo
[1] "GS"
> chartSeries(GS)

GS matchstick chart

> # notice the automatic matchstick style 
> # we'll change this in the next section
> # but for now it is fine.
> The basic charting functionality tries to not stray too far from the standard usage patterns in R, though you will not be able to use any of the standard graphics tools for displaying charts. quantmod's oh-so-wise author has tried to anticipate that need with special functions to make up for this shortcoming.

A quick step back, to explain just what is happening behind the scenes within chartSeries may be in order though.

The charting is managed through a two step process. First, the data is examined and basic decisions on how to best draw the series is calculated. The result of this is an internal object - referred to as a chob (chart object).

This object is then passed to the main drawing function (not to be called directly) to be drawn to the screen. The purpose of the separation is to allow for more impressive dynamic-style chart additions, as well as modifications, to be as natural to accomplish as possible. When changes are made to the current chart - be it adding technical indicators, or changing original parameters, such as the style of chart - the stored chob object is simply altered and then redrawn without a lot of tedious user manipulation. The goal was to make it work without extra user effort - and to then end it just does.
Charting shortcuts - barChart, lineChart, and candleChart.

While chartSeries is the primary function called when drawing a chart in quantmod - it is by no means the only way to get something done. There are wrapper functions for each of the main types of charts presently available in quantmod.

Wrapper functions exist to make life a little easier. Bar style charts, both hlc and ohlc varieties are directly available with barChart, candlestick charting comes naturally through the candleChart wrapper function, and lines via the cryptically named - you guessed it - lineChart. There isn't much special about these functions beyond the obvious. In fact they are one liners that simply call chartSeries with suitably changed default args. But they make a nice addition to the stable.

> # first some high-low-close style bars, monochromatic theme
> barChart(GS,theme='white.mono',bar.type='hlc') 

GS hlc barchart chart

> # how about some candles, this time with color
> candleChart(GS,multi.col=TRUE,theme='white')

GS candle chart
> 
> # and now a line, with the default color scheme
> lineChart(GS,line.type='h',TA=NULL)

GS line chart

As you can see, there is quite a bit of flexibility as to the display of your information. What you may have also noticed is the different arguments to each of the calls. We'll now take a look at what some of them do.
Formal Arguments: Colors, subsetting, tick-marks.

The best place for complete information on what arguments the functions take is in the documentation. But for now we'll take a look at some of the common options you might change.

Probably the most important from a usability standpoint is the argument subset. This takes an xts/ISO8601 style time-based string and restricts the plot to the date/time range specified. This doesn't restrict the data available to the techinical analysis functions, only restricts the content drawn to the screen. For this reason it is most advantageous to use as much data as you have available, and then provide the chartSeries function with the subset which you would like to view. This subsetting is also avialable via a call to zoomChart.

An example, or three, should help clarify its usage.

> # the whole series
> chartSeries(GS)

Click on the chart to see it full size: GS chart without subset

> # now - a little but of subsetting
> # (December '07 to the last observation in '08)
> candleChart(GS,subset='2007-12::2008')

Click on the chart to see it full size: GS chart without subset

> # slightly different syntax - after the fact.
> # also changing the x-axis labeling
> candleChart(GS,theme='white', type='candles')
> reChart(major.ticks='months',subset='first 16 weeks')

Click on the chart to see it full size: GS chart with subset

Three things of note on the last chart. First was the use of reChart to modify the original chart. This takes most arguments of the original charting calls, and allows for quick modifications to your charts. Be it changing color themes or subsetting - it comes in quite handy.

The second notable item is the use of the 'first' syntax inside of subset. This allows for a slightly more natural expression of what you may be after, and doesn't require you to know anything about the series dates or times.

The final item of note in that last image is the tick.marks argument. This is part of the original chartSeries function formals list, and it is used to modify the placement of labels within the chart. Often the automatically chosen spacing - driven by the xts function axTicksByTime does a good enough job - you may find it desirable to customize the output further. In this case we marked the major ticks with the months beginnings.
Technical Analysis and chartSeries

Updated and ready to go are some fantastic tools from the TTR package by Josh Ulrich, available on CRAN. It is now possible to simply add dozens of technical analysis tools to chart with nothing more than a simple command.

The current indicators from the TTR package, as well as a few originating in the quantmod package are:
Indicator   TTR Name  quantmod Name
Welles Wilder's Directional Movement Indicator  ADX   addADX
Average True Range  ATR   addATR
Bollinger Bands   BBands  addBBands
Bollinger Band Width  N/A   addBBands
Bollinger %b  N/A   addBBands
Commodity Channel Index   CCI   addCCI
Chaiken Money Flow  CMF   addCMF
Chande Momentum Oscillator  CMO   addCMO
Double Exponential Moving Average   DEMA  addDEMA
Detrended Price Oscillator  DPO   addDPO
Exponential Moving Average  EMA   addEMA
Price Envelope  N/A   addEnvelope
Exponential Volume Weigthed Moving Average  EVWMA   addEVWMA
Options and Futures Expiration  N/A   addExpiry
Moving Average Convergence Divergence   MACD  addMACD
Momentum  momentum  addMomentum
Rate of Change  ROC   addROC
Relative Strength Indicator   RSI   addRSI
Parabolic Stop and Reverse  SAR   addSAR
Simple Moving Average   SMA   addSMA
Stocastic Momentum Index  SMI   addSMI
Triple Smoothed Exponential Oscillator  TRIX  addTRIX
Volume  N/A   addVo
Weighted Moving Average   WMA   addWMA
Williams %R   WPR   addWPR
ZLEMA   ZLEMA   addZLEMA

All of the above work much like the TTR base functions on which they call. The primary difference is that the add family of calls do not include the data argument, as this is derived from the current chart.

A few examples will highlight how to build charts with the built-in indicators.
> getSymbols("GS") #Goldman OHLC from yahoo
[1] "GS"

> # The TA argument to chartSeries is one way to specify the
> # indicator calls to be applied to the chart.
> # NULL mean don't draw any.
> 
> chartSeries(GS, TA=NULL)

GS chart

> # Now with some indicators applied
> 
> chartSeries(GS, theme="white", 
+     TA="addVo();addBBands();addCCI()")

GS with TAs

> # The same result could be accomplished a
> # bit more interactively:
> # 
> chartSeries(GS, theme="white")  #draw the chart
> addVo() #add volume
> addBBands() #add Bollinger Bands
> addCCI() #add Commodity Channel Index

One of the newest and most exciting additions to the recent quantmod release includes two new charting tools designed to make adding custom indicators far quicker than previously possible.

The first of these is addTA. This is a major extension to the previous addTA function, in that it now allows for arbitrary data to be drawn on the charts. Acting as essentially a wrapper to your data, the only requirement is that the data have the same number of observations as the original, or be of class xts and the dates are within the original data's time range and scale. It is possible to have this new data plotted in its own TA subchart (the default), or overlayed on the main series.

The second and potentially more interesting function is newTA. This is the long-awaited skeleton function to create custom TA indicators to be appended to any chart. It takes the skeleton concept one step further, and dynamically creates the function code needed for a new indicator, based on the function you passed to it. Essentially a bit of self-aware programming makes adding new indicators quite intuitive and practically painless. Given it's rather cutting edge abilities, it is on the cusp of experimental. Luckily if all else fails, and what you get is not what you expected, you can always modify the code created to better suit your needs.

A quick look at adding custom indicator data and creating a new indicator from scratch.
> getSymbols("YHOO") #Yahoo! OHLC from yahoo
[1] "YHOO"

> # addTA allows you to add basic indicators
> # to your charts - even if they aren't part
> # of quantmod.
> 
> chartSeries(YHOO, TA=NULL)

> #Then add the Open to Close price change 
> #using the quantmod OpCl function
> 
> addTA(OpCl(YHOO),col='blue', type='h')

addTA(OpCl(YHOO))

> # Using newTA it is possible to create your own
> # generic TA function --- let's call it addOpCl
> # 
> addOpCl <- newTA(OpCl,col='green',type='h')
> 
> addOpCl()

addOpCl <- newTA(OpCl)
More to come...

There is much more to say about chartSeries and quantmod's current and future visualization tools, but for now it is time to call it a day (or 30) and conclude this introduction to charting in quantmod.

Future additions to this site and the documentation will include more details about interacting with the charts - now and in upcoming releases, new layout options, and a possible foray into entirely new visualization tools and techniques.

But for now that is all I've got...
This software is written and maintained by Jeffrey A. Ryan. See license for details on copying and use. Copyright 2008.

##########################################

ggplot(diamonds, aes(carat)) +
  geom_histogram()
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.01)
ggplot(diamonds, aes(carat)) +
  geom_histogram(bins = 200)

# Rather than stacking histograms, it's easier to compare frequency
# polygons
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)
ggplot(diamonds, aes(price, colour = cut)) +
  geom_freqpoly(binwidth = 500)

# To make it easier to compare distributions with very different counts,
# put density on the y axis instead of the default count
ggplot(diamonds, aes(price, ..density.., colour = cut)) +
  geom_freqpoly(binwidth = 500)

if (require("ggplot2movies")) {
# Often we don't want the height of the bar to represent the
# count of observations, but the sum of some other variable.
# For example, the following plot shows the number of movies
# in each rating.
m <- ggplot(movies, aes(rating))
m + geom_histogram(binwidth = 0.1)

# If, however, we want to see the number of votes cast in each
# category, we need to weight by the votes variable
m + geom_histogram(aes(weight = votes), binwidth = 0.1) + ylab("votes")

# For transformed scales, binwidth applies to the transformed data.
# The bins have constant width on the transformed scale.
m + geom_histogram() + scale_x_log10()
m + geom_histogram(binwidth = 0.05) + scale_x_log10()

# For transformed coordinate systems, the binwidth applies to the
# raw data. The bins have constant width on the original scale.

# Using log scales does not work here, because the first
# bar is anchored at zero, and so when transformed becomes negative
# infinity. This is not a problem when transforming the scales, because
# no observations have 0 ratings.
m + geom_histogram(origin = 0) + coord_trans(x = "log10")
# Use origin = 0, to make sure we don't take sqrt of negative values
m + geom_histogram(origin = 0) + coord_trans(x = "sqrt")

# You can also transform the y axis.  Remember that the base of the bars
# has value 0, so log transformations are not appropriate
m <- ggplot(movies, aes(x = rating))
m + geom_histogram(binwidth = 0.5) + scale_y_sqrt()
}
rm(movies)

