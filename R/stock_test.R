##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_test.R
##R --slave --args test1 test2=no < /media/syrhades/DAA4BB34A4BB11CD1/stock_test.R
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。
## R CMD BATCH --slave "--args test1 test2=no" /media/syrhades/DAA4BB34A4BB11CD1/stock_test.R
## Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_test.R AAA BBB
#将我们的脚本文件改为：
library(dplyr)
library(plyr)
Args <- commandArgs()
Args_len<-seq(length(Args))

l_ply(Args_len,function (x) cat(paste(x,"Args="),Args[x],"\n"))

