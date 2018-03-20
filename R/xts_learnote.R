require(xts)
data(sample_matrix)
class(sample_matrix)
str(sample_matrix)

matrix_xts <- as.xts(sample_matrix,dateFormat='Date')
str(matrix_xts)

as.Date(32768, origin = "1900-01-01")


Examples

## first days of years
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "years")
## by month
seq(as.Date("2000/1/1"), by = "month", length.out = 12)
## quarters
seq(as.Date("2000/1/1"), as.Date("2003/1/1"), by = "quarter")

## find all 7th of the month between two dates, the last being a 7th.
st <- as.Date("1998-12-17")
en <- as.Date("2000-1-7")
ll <- seq(en, st, by = "-1 month")
rev(ll[ll > st & ll < en])

xts(1:10, Sys.Date()+1:10)



per_jz<-c(1,3,5,7)
## quarters
test_date2000<-seq(as.Date("2000/1/1"), as.Date("2001/1/1"), by = "quarter")

test_func<-function(year,per_jz){
	date_quarter<-seq(as.Date(paste(year,"/1/1",sep="")), as.Date(paste(year,"/12/31",sep="")), by = "quarter")
	date_quarter[5]<-as.Date(paste(year,"/12/31",sep=""))
	nday<-diff(date_quarter)
	#ret_df<-data.frame(date_quarter[1:4],diff)
	#return(ret_df)
	return(data.frame(nday,date_quarter[1:4]))
	
	result_xts<-xts(rep(per_jz[1],nday[1]),date_quarter[1]+1:nday[1]-1)
	return(ret_df)
}

tseq2<-test_func(2016,per_jz)
tseq2$per_jz<-per_jz
tseq2
xts_quarter<-function(per_jz,nday,day_begin){
	result<-xts(rep(per_jz,nday),day_begin+1:nday-1)
	return(result)
}


xxx<-mapply(xts_quarter,tseq2$per_jz,tseq2$nday,tseq2[,2])



