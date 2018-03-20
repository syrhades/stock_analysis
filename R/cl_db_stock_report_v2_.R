##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai3.db"   
# step1
# Rscript e:/R/cl_db_backup_r_scriptv1.R  "E:\\R\\all_stock_sz_bak.log" "d:\\stock_sh.db" "d:/modify_sz_allstock.log"
# step2
# Rscript cl_stock_class_fin_report_v5_for_d2_no_rev.R  "modify_sz_allstock.log" "stock_sh.db"  
Args <- commandArgs()
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。
stockfile<-Args[6]
dbfile<-Args[7]
lack_file<-Args[8]
source("e:/R/cl_db_stock_report_fun_toolbox.R")
# step1 
dbfile="F:\\stock_sz.db"
stockid="000001"
reports_stock <-frm_get_all_finance_report(dbfile,stockid)



# extract all finance report 

# http://www.unicode.org/cgi-bin/GetUnihanData.pl?codepoint=6BCF

# l_reports[[1]][1,1]  %>%print
# l_reports[[1]][1,1]  %>% stringr::str_detect("会计2")

# vol_title <- l_reports[[1]][1,]


# frm_filter_vol_name2("债务")(vol_title)(table)
# frm_filter_vol_name("债务")(vol_title)
# frm_filter_vol_name("债务")(vol_title)(return)
 # %>% table

vol_title<-reports_stock[[1]][1,] #%>%inconv
<-frm_filter_vol_name("资产|债务")(vol_title)  %>% table
# frm_filter_vol_name("资产")(vol_title)  %>% table
# frm_filter_vol_name("债务")(vol_title)  %>% table
col_ix <- frm_filter_vol_name("资产|债务")(vol_title)
names(reports_stock[[1]])[col_ix] %>% as.list
reports_stock[[1]][-1,col_ix]




vol_index <- frm_filter_vol_name("资产")(vol_title)
vol_title[vol_index] %>% lapply(print)
l_reports[[1]][,vol_index] %>% htmlTable::htmlTable()

vol_title[vol_title  %>% stringr::str_detect("债务")] %>% lapply(print)
rrr<-vol_title[vol_title  %>% stringr::str_detect("债务")] 
write_file(x=rrr,file="d:/tetttt.log")
###############################################
#  整理数据
###############################################
l_reports_compute <- l_reports %>% llply(pryr::f(x[-1,]))
l_tidy_reports <- l_reports_compute %>% lapply( function(vol) frm_replace(vol,"--",0)) 
# frm_sub_lapply(l_reports_compute)(pryr::f(frm_replace(vol,"--",0)), function(vol) frm_apply_fun(vol,as.numeric))
frm_sub_lapply(l_reports_compute)(pryr::f(frm_replace(vol,"--",0)), head)

report1<- l_reports[[1]][-1,]
report1 %>% head

frm_replace<-function(vol,src_str,dest_str){
	vol[vol == src_str] <- dest_str
	vol
}

frm_apply_fun<-function(vol,FUN,...){
	vol<-FUN(vol,...)
	vol
}


batch_funclist<- list(frm_replace,frm_apply_fun)
 #batch modify df column replace 
report1[] <- lapply(report1, function(vol) frm_replace(vol,"--",0)) 
report1[] <- lapply(report1, pryr::f(frm_replace(vol,"--",0))) 

# batch change vol data type
report1[,c(-1,-ncol(report1))] <- lapply(report1[,c(-1,-ncol(report1))] , function(vol) frm_apply_fun(vol,as.numeric)#批量modify df column


#####################################################################
# report column value 分析
#####################################################################

# frm_get_all_finance_report<-function(dbfile,stockid){
# 	stock_id <- str_pad(stockid,6,side="left","0")
# 	ta <- cl_db_oprate$new(dbfile)
# 	db_tb_wanted <- ta$show_db_dbi()
# 	reports <- frm_filter_stockid(db_tb_wanted,stock_id)
# 	# print(Args)
# 	l_reports <- reports %>% llply(function(report) ta$query_db_dbi(sprintf("select * from %s",reports)))
# 	# reports_names <- reports %>% laply(pryr::f(gsub(sprintf("_%s",stockid),"",x))
# 	reports_names <- reports %>% laply(function(x) gsub(sprintf("_%s",stock_id),"",x))
# 	names(l_reports)<-reports_names
# 	# Changing to Chinese utf-8 format
# 	l_reports <- l_reports %>% llply(frm_show_report_reprocess)
# 	return(l_reports)
# }
dbfile="e:\\stock_sh.db"
# stockid="000001"


dbfile="e:\\stock_sh.db"
ta <- cl_db_oprate$new(dbfile)
db_tb_wanted <- ta$show_db_dbi()
report_type <- list("cwbl","lr",     "xjll",   "zcfz",   "zxcwzb")
reports <- frm_filter_stockid(db_tb_wanted,"cwbl")
ret_list<-llply(report_type, function(i) {frm_filter_stockid(db_tb_wanted,i)})
names(ret_list)<-report_type
reports <- ret_list$cwbl

l_reports <- reports %>% llply(function(report) ta$query_db_dbi(sprintf("select  * from %s limit 1",reports)))
# reports <- frm_filter_stockid(db_tb_wanted,"000001")

# > reports %>% laply(function(x) str_split(x,"_")[[1]])
#      1        2       
# [1,] "cwbl"   "000001"
# [2,] "lr"     "000001"
# [3,] "xjll"   "000001"
# [4,] "zcfz"   "000001"
# [5,] "zxcwzb" "000001"
# > reports %>% laply(function(x) str_split(x,"_")[[1]][1])
# [1] "cwbl"   "lr"     "xjll"   "zcfz"   "zxcwzb"

###############################################
# lapply(mtcars, pryr::f(length(unique(x))))
# Filter(pryr::f(! is.numeric(x)), mtcars)
# integrate(pryr::f(sin(x) ^ 2), 0, pi)
# check_loss_code_db(dbfile=dbfile,log_file=stockfile,result_file=lack_file)




# ## A list of all functions in the base environment:
# funs <- Filter(is.function, sapply(ls(baseenv()), get, baseenv()))
# ## Functions in base with more than 10 arguments:
# names(Filter(function(f) length(formals(args(f))) > 10, funs))
# ## Number of functions in base with a '...' argument:
# length(Filter(function(f)
#               any(names(formals(args(f))) %in% "..."),
#               funs))

# ## Find all objects in the base environment which are *not* functions:
# Filter(Negate(is.function),  sapply(ls(baseenv()), get, baseenv()))

# #首先对集合A,B,C赋值
# > A<-1:10
# > B<-seq(5,15,2)
# > C<-1:5
# > #求A和B的并集
# > union(A,B)
#  [1]  1  2  3  4  5  6  7  8  9 10 11 13 15
# > #求A和B的交集
# > intersect(A,B)
# [1] 5 7 9
# > #求A-B
# > setdiff(A,B)
# [1]  1  2  3  4  6  8 10
# > #求B-A
# > setdiff(B,A)
# [1] 11 13 15
# > #检验集合A,B是否相同
# > setequal(A,B)
# [1] FALSE
# > #检验元素12是否属于集合C
# > is.element(12,C)
# [1] FALSE
# > #检验集合A是否包含C
# > all(C%in%A)
# [1] TRUE
# > all(C%in%B)
# [1] FALSE


