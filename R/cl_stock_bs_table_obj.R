require(XRPython)
require(R6)               # 加载R6包
require(pryr)             # 加载pryr包
require(stringr) 

require(dplyr)
require(plyr)
require(quantmod)
require(TTR)
require(ggplot2)
require(scales)
require(data.table)
require(sqldf)
require(XML)
require(htmlTable)
###################################
## repare data
#####################################
frm_output_html<-function(idx,result_data){
	print_data<-result_data[[idx]]
	if (!is.na(print_data) && (length(print_data)>0))  htmlTable(print_data)
}

cl_fi_compute <- R6Class("jin_rong_js",    # 定义一个R6类
	lock_objects = FALSE,
	public=list( type =NA,
        initialize = function(stock_id){
            self$stock_id = sprintf("%06d", stock_id)
            self$datafile = paste("stock_data/done_",stock_id,".txt",sep="")
            },
        frm_lof = function(in_p,out_p,amount){
            ## compute fund LOF 
            if (in_p>out_p) {
                tl_type<-"inout_yj" # 溢價 buy out sold in
                delta_p<-(in_p-out_p)
                loss_percent<-delta_p/out_p*100
                buy_percent<-1.5/100
                sold_percent<-0.3/100
                buy_amount<-amount*out_p*(1+buy_percent)
                sold_amount<-amount*in_p*(1-sold_percent)
                }
            else{
                tl_type<-"outin_zj" # 折價 buy in sold out
                delta_p<-(out_p-in_p)
                loss_percent<-delta_p/in_p*100
                buy_percent<-0.3/100
                sold_percent<-0.5/100
                buy_amount<-amount*in_p*(1+buy_percent)
                sold_amount<-amount*out_p*(1-sold_percent)
                }
                result_amount<-sold_amount-buy_amount
                result_percent<-result_amount/buy_amount*100
                print("===========================")
                print(tl_type)
                cat("buy_amount:\t",buy_amount,"\n")
                cat("result_amount:\t",result_amount,"\n")
                cat("result_percent:\t",result_percent,"\n")
                print("===========================")
        },
        frm_test = function(){
            frm_lof(    1.0613,
                            1.0710,
                            100000)
            }
        )
    )

cl_sample <- R6Class("sample",    # 定义一个R6类
	lock_objects = FALSE,
	public=list( stock_id =NA,
        initialize = function(stock_id){
		self$stock_id = sprintf("%06d", stock_id)
		self$datafile = paste("stock_data/done_",stock_id,".txt",sep="")
		}
             )
    )


cl_stock_data_tool <- R6Class("stock_data",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
            stock_id 	= NA,
            initialize = function(stock_id){
		self$stock_id = sprintf("%06d", stock_id)
		self$datafile = paste("stock_data/done_",self$stock_id,".txt",sep="")
		},
            frm_modify_path = function(filename){
		## check OS R_PLATFORM
		R_PLATFORM<-Sys.getenv(c("R_PLATFORM"))
		if(str_detect(R_PLATFORM, "linux")) path<-"~/sdcard1"
		else path<-"e:"
		return (paste(path,filename,sep="/") )
		},
            frm_datagen = function(datastr){
                    year=substr(datastr,0,4)
                    month=substr(datastr,5,6)
                    #cat(month)
                    day=substr(datastr,7,8)
                    #cat(day)
                    paste(year,"-",month,"-",day)
                    return(paste(year,"-",month,"-",day, sep = ""))
            },
            func_set_type = function(c1,c2){
                if (c1>c2) return("UP")
                if (c1<c2) return("DOWN")
                if (c1==c2) return("EQUAL")
            },
            roll_indicator = function(BS_table2,windows_period,fieldname){
                #cmdstr=paste("BS_table2$avg_max_roll_",windows_period,"<-rollmax(BS_table2$avg,3,fill = NA,align='right')",sep="")
                BS_table2[paste(fieldname,"_max_roll_",windows_period,sep="")]<-rollmax(BS_table2[paste(fieldname)],windows_period,fill = NA,align='right')
                BS_table2[paste(fieldname,"_min_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) min(x),fill = NA,align='right')
                BS_table2[paste(fieldname,"_mean_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) mean(x),fill = NA,align='right')
                return (BS_table2)
            },
            func_up_down = function(x, c1, c2) {
                if (x[c1]>x[c2]) return("UP")
                if (x[c1]<x[c2]) return("DOWN")
                if (x[c1]==x[c2]) return("EQUAL")
            },
            frm_generate_BS_table = function(){
		self$datafile <- self$frm_modify_path(self$datafile)
                df1<-read.table(self$datafile,header=TRUE,sep=",")
                df1<-mutate(df1,date=self$frm_datagen(date))
                olch=df1[2:6]
                xtsobject=xts(olch, as.Date(df1$date))     #包xts
                xtsobject<-cbind(xtsobject,close1=Lag(xtsobject$close))
                colnames(xtsobject)[[6]]<-"close1"
                head(is.na(xtsobject$close1))
                xts_non_na<-xtsobject[!is.na(xtsobject$close1)]
                #######优化处理#######
                typepoint2<-mapply(self$func_set_type,xts_non_na$close,xts_non_na$close1)
                BS_table2<-as.data.frame(xts_non_na)
                BS_table2$type<-typepoint2
                BS_table2$avg<-rowSums(BS_table2[,1:4])/4
                BS_table2$Date<-as.Date(row.names(BS_table2))
                #generate roll indicator
                #BS_table2[paste(windows_period)]<-2
                BS_table2<-self$roll_indicator(BS_table2,50,"close")
                #BS_table2[1:10,]
                return(BS_table2)
                }
            )
    )

BS_table2<-cl_stock_data_tool$new(000157)$frm_generate_BS_table()
