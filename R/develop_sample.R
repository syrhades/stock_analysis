##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai.db"   

#Args <- commandArgs()
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。

#dbfile<-Args[6]
library('devtools')
setwd('e:/syrhadestock')
setwd('~/sdcard1/syrhadestock')
load_all()

# /media/syrhades/DAA4BB34A4BB11CD1/stock_data

ta<-cl_db_oprate$new("e:/tb_finance.db")
ta<-cl_db_oprate$new("~/sdcard1/stock_shanghai.db")
# ta<-cl_db_oprate$new("e:/test.db")
ta$show_db_dbi()

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


#######sample 1 fx pair  每股收益 净资产收益率############################
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
    #批量 数据类型整理 batch retype data type 
    # frm_syr_transform_batch(yearlist_zb,as.numeric,c(-1,-3))  field_scope
    dbf_name    <-substitute(df_obj)
    func_name   <-substitute(func)
    print(dbf_name)
    print(func_name)
    trans_detail<-llply(colnames(df_obj)[field_scope],function(x) print(paste(x,"=",func_name,"(",x,")",sep="")))%>%paste(collapse=",")
    return(paste("transform(","yearlist_zb",",",trans_detail,")")%>%frm_run_char_cmd)
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

###批量convert char to numeric in dataframe


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
df_all["pe"] <- df_all$close/frm_convert_factor2_num(df_all$v1)   ##Price to Earning Ratio，即市盈率，简称PE或P/E Ratio
df_all["PB"] <- df_all$close/frm_convert_factor2_num(df_all$v3)  ##市净率

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
#> strptime("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01 CST"
#> as.Date("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01"
#> 


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
cl_syrhades_tool <- R6Class("tool",    # 定义一个R6类
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
example, we can “move” values in the survival column to the top and fill them with
values from count:
library(reshape2)
dcast(plum,  length + time ~ survival,  value.var="count" )
length time dead alive
long at_once 84 156
long in_spring 156 84
short at_once 133 107
short in_spring 209 31