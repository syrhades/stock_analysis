library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-chord-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    circularArc=360,
    circularRotate=0,
    circularType="chord",
    colors=list("#000000", "#FFDD89", "#957244", "#F26223"),
    graphType="Circular",
    higlightGreyOut=TRUE,
    rAxisTickFormat=list("%sK", "val / 1000"),
    showTransition=TRUE,
    title="Simple Chord Graph",
    transitionStep=50,
    transitionTime=1500
  )



xlib-backend.c:34:74: fatal error: X11/Intrinsic.h

A very handy tool to help you through situations like these is apt-file. It catalogs individual files in packages and thus helps you discover which packages will offer files that you might require. To install the tool:
Code:

sudo apt-get install --no-install-recommends apt-file

Next, update the catalog:
Code:

sudo apt-file update

Finally, search for the file(s) in question. I checked for the first file missing in your post:
Code:

steve@x1:~$ apt-file find Intrinsic.h
libxt-dev: /usr/include/X11/Intrinsic.h

It appears, then, that you need to install the package libxt-dev.


apt-cache show libxt-dev tendra
apt-get install libxt-dev




library("ggplot2")
library("grid")
library("showtext")
library("circularRotate")
font.add("myfont","msyh.ttc")


mydata<-data.frame(
id=1:13,
class=rep_len(1:4, length=13),
Label=c("Events","Lead List","Partner","Markeiting & Advertising","Tradeshows","Paid Search","Webinar","Emial Campaign","Sales generated","Website","Other","Facebook/Twitter/\nOther Social","Employee & Customer\nReferrals"),
Value=c(7.6,15.5,17.9,21.8,29.6,29.7,32.7,43.0,57.5,61.4,67.4,68.6,68.7)
)

ggplot(mydata)+
geom_col(aes(x=id,y=Value/2+150,fill=factor(class)),colour=NA,width=1)+
geom_col(aes(x=id,y=150-Value/2),fill="white",colour="white",width=1)+
scale_x_continuous(limits=c(0,26),expand=c(0,0))



ggplot(mydata)+
geom_col(aes(x=id,y=Value/2+150,fill=factor(class)),colour=NA,width=1)+
geom_col(aes(x=id,y=150-Value/2),fill="white",colour="white",width=1)+
scale_x_continuous(limits=c(0,26),expand=c(0,0))+
coord_polar(theta = "x",start=-14.275, direction = 1)


ggplot(mydata)+
geom_col(aes(x=id,y=Value/2+150,fill=factor(class)),colour=NA,width=1)+
geom_col(aes(x=id,y=150-Value/2),fill="white",colour="white",width=1)+
scale_x_continuous(limits=c(0,26),expand=c(0,0))+
coord_polar(theta = "x",start=-14.275, direction = 1)+
scale_fill_manual(values=c("#31A2CE","#DDB925","#3F9765","#C84F44"),guide=FALSE)+
theme_void()



p<-ggplot()+
geom_col(data=mydata,aes(x=id,y=Value/2+150,fill=factor(class)),colour=NA,width=1)+
geom_col(data=mydata,aes(x=id,y=150-Value/2),fill="white",colour="white",width=1)+
geom_line(data=NULL,aes(x=rep(c(.5,13.5),2),y=rep(c(126,174),each=2),group=factor(rep(1:2,each=2))),linetype=2,size=.25)+
geom_text(data=mydata,aes(x=id,y=ifelse(id<11,160,125),label=Label),size=3.5,hjust=0.5)+
geom_text(data=mydata,aes(x=id,y=ifelse(id<11,185,150),label=paste0(Value,"%")),hjust=.5,size=4.5)+
scale_x_continuous(limits=c(0,26),expand=c(0,0))+
coord_polar(theta = "x",start=-14.275, direction = 1)+
scale_fill_manual(values=c("#31A2CE","#DDB925","#3F9765","#C84F44"),guide=FALSE)+
theme_void();p


#图表标题、副标题
title="Events,Lead Lists and partners-\nmore likely be colosed-lost"
content="Marketing events may by fun, but they create\nlousy sales opprunities.When analyzing share\nof closed-won vs.closed-lost opportunities,\nevents,leads lists and partners seem to provide the\nworst performance,while refreals and social\nprovide the best performance."

#图形输出：setwd("E:/数据可视化/R/R语言学习笔记/数据可视化/ggplot2/优秀R语言案例")
CairoPNG(file="/tmp/polar_bar.png",width=1200,height=900)
showtext.begin()
grid.newpage()
pushViewport(viewport(layout=grid.layout(6,8)))
vplayout<-function(x,y){viewport(layout.pos.row =x,layout.pos.col=y)}
print(p,vp=vplayout(1:6,1:8))
grid.text(label=title,x=.50,y=.6525,gp=gpar(col="black",fontsize=15,fontfamily="myfont",draw=TRUE,fontface="bold",just="left"))
grid.text(label=content,x=.50,y=.56,gp=gpar(col="black",fontsize=12,fontfamily="myfont",draw=TRUE,just="left"))
showtext.end()
dev.off()