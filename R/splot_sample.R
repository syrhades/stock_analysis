#simulating data
n=2000
dat=data.frame(sapply(c('by','bet1','bet2'),function(c)sample(0:1,n,TRUE)))
dat$x=eval(quote(
rnorm(n)+by*-.4+by*bet1*-.3+by*bet2*.3+bet1*bet2*.9-.8+rnorm(n,0,by)
),envir=dat)
dat$y=eval(quote(
x*.2+by*.3+bet2*-.6+bet1*bet2*.8+x*by*bet1*-.5+x*by*bet1*bet2*-.5
+rnorm(n,5)+rnorm(n,-1,.1*x^2)
),envir=dat)
#looking at the distribution of y between bets split by by
splot(y, by=by, between=c(bet1, bet2), data=dat)
#looking at quantile splits of y in y by x
splot(y~x*y, split='quantile', data=dat)
#looking at y by x between bets
splot(y~x, between=c(bet1, bet2), data=dat)
#sequentially adding levels of split
splot(y~x*by, data=dat)
splot(y~x*by*bet1, data=dat)
splot(y~x*by*bet1*bet2, data=dat)
#same as the last but entered differently
splot(y, x, by, c(bet1, bet2), data=dat)
#zooming in on one of the windows
splot(y~x*by, data=dat, su=bet1==1&bet2==0)
#compairing an adjusted lm prediction line with a loess line
#this could also be entered as y ~ poly(x,3)
splot(y~x+x^2+x^3, data=dat, su=bet1==1&bet2==0&by==1, add={
lines(x[order(x)], loess(y~x)$fitted[order(x)], lty=2)
legend('topright', c('lm', 'loess'), lty=c(1, 2), lwd=c(2, 1), bty='n')
})

#looking at different versions of x added to y
splot(cbind(
Raw=y+x,
Sine=y+sin(x),
Cosine=y+cos(x),
Tangent=y+tan(x)
)~x, data=dat, myl=c(-10,15), lines='loess', laby='y + versions of x')


require(RJSplot)


# Prepare data
x <- 1-cor(t(mtcars))

source <- rep(rownames(x),nrow(x))
target <- rep(rownames(x),rep(ncol(x),nrow(x)))
links <- data.frame(source=source,target=target,value=as.vector(x))
# Create a network graph
network_rjs(links[links[,3]>0.1,], mtcars, group = "cyl", size = "hp", color = "mpg")


# Create a symetric heatmap
symheatmap_rjs(links, mtcars, group = "cyl")
# Create a hive plot
hiveplot_rjs(links, mtcars, group = "cyl", size = "wt", color = "carb")

# Generation of metadata test
metadata <- data.frame(phenotype1 = sample(c("yes","no"),ncol(mtcars),TRUE), phenotype2 = sample(1:5,ncol(mtcars),TRUE))

# Create a heatmap
heatmap_rjs(data.matrix(mtcars), metadata, scale="column")

# Format test data
words <- data.frame(word = rownames(USArrests), freq = USArrests[,4])

# Create WordCloud
wordcloud_rjs(words)

# Create test data
chr <- character()
pos <- numeric()

for(i in 1:nrow(GRCh38)){
  chr <- c(chr,as.character(rep(GRCh38[i,"chr"],100)))
  pos <- c(pos,sample(GRCh38[i,"start"]:GRCh38[i,"end"],100))
}

value <- round(rexp(length(pos)),2)
# Create a manhattan plot
data <- data.frame(paste0("ProbeSet_",seq_along(pos)),chr,pos,value)
manhattan_rjs(data, GRCh38, 0, 1, 0, TRUE, "log2Ratio")


# Create a genome map
track <- data.frame(chr,pos,pos+1,NA,value)
genomemap_rjs(GRCh38.bands, track)

# Create a scatter plot
scatterplot_rjs(iris[["Sepal.Width"]], iris[["Sepal.Length"]], abline.x = c(3.4,3.8), abline.y = c(5.8,7), col = iris[["Species"]], pch = as.numeric(iris[["Species"]]), id = iris[["Species"]], xlab = "Sepal Width (cm)", ylab = "Sepal Length (cm)")

# Create a pie chart
piechart_rjs(VADeaths)

# Create a 3D scatter plot
scatter3d_rjs(iris[["Sepal.Width"]], iris[["Sepal.Length"]], iris[["Petal.Width"]], color = iris[["Species"]], xlab = "Sepal Width (cm)", ylab = "Sepal Length (cm)", zlab = "Petal Width (cm)")
# Create a bubble plot
bubbles_rjs(scale(mtcars[,c("mpg","hp")],FALSE), mtcars[["wt"]])
# Create a 3D surface
surface3d_rjs(volcano,color=c("red","green"))
# Create a dendrogram
dendrogram_rjs(dist(USArrests),USArrests)
# Create a data table
tables_rjs(swiss)


# Generate test input data
data <- data.frame(Uni05 = (1:100)/21, Norm = rnorm(100), `5T` = rt(100, df = 5), Gam2 = rgamma(100, shape = 2))

# Create a density plot
densityplot_rjs(data, "x", "y")

# Create a barplot
barplot_rjs(USArrests, "states", "arrests")

# Create a boxplot
boxplot_rjs(attitude, "attitude", "favourable responses")



#######################3


require(diagram)


## Flowchart examples
par(ask=TRUE)

## MODELLING DIAGRAM
mar <- par(mar=c(1,1,1,1))
openplotmat(main="from Soetaert and herman, book in prep",cex.main=1)
elpos<-coordinates (c(1,1,1,1,1,1,1,1),mx=-0.1)
segmentarrow(elpos[7,],elpos[2,],arr.pos=0.15,dd=0.3,arr.side=3,endhead=TRUE)
segmentarrow(elpos[7,],elpos[3,],arr.pos=0.15,dd=0.3,arr.side=3,endhead=TRUE)
segmentarrow(elpos[7,],elpos[4,],arr.pos=0.15,dd=0.3,arr.side=3,endhead=TRUE)

pin   <- par ("pin")        # size of plotting region, inches
xx  <- 0.2
yy  <- xx*pin[1]/pin[2]*0.15  # used to make circles round

sx    <- rep(xx,8)
sx[7] <- 0.05

sy    <- rep(yy,8)
sy[6] <-yy*1.5
sy[7] <- sx[7]*pin[1]/pin[2]

for (i in c(1:7)) straightarrow (to=elpos[i+1,],from=elpos[i,],lwd=2,arr.pos=0.6,endhead=TRUE)
lab <- c("Problem","Conceptual model","Mathematical model","Parameterisation",
         "Mathematical solution","","OK?","Prediction, Analysis")

for (i in c(1:5,8)) textround(elpos[i,],sx[i],sy[i],lab=lab[i])

textround(elpos[6,],xx,yy*1.5,lab=c("Calibration,sensitivity","Verification,validation"))
textdiamond(elpos[7,],sx[7],sy[7],lab=lab[7])

textplain(c(0.7,elpos[2,2]),yy*2,lab=c("main components","relationships"),font=3,adj=c(0,0.5))
textplain(c(0.7,elpos[3,2]),yy ,"general theory",adj=c(0,0.5),font=3)
textplain(c(0.7,elpos[4,2]),yy*2,lab=c("literature","measurements"),font=3,adj=c(0,0.5))
textplain(c(0.7,elpos[6,2]),yy*2,lab=c("field data","lab measurements"),font=3,adj=c(0,0.5))

#####
##  DIAGRAM

par(mar=c(1,1,1,1))
openplotmat()
elpos<-coordinates (c(1,1,2,4))
fromto <- matrix(ncol=2,byrow=TRUE,data=c(1,2,2,3,2,4,4,7,4,8))
nr     <-nrow(fromto)
arrpos <- matrix(ncol=2,nrow=nr)
for (i in 1:nr) 
    arrpos[i,]<- straightarrow (to=elpos[fromto[i,2],],from=elpos[fromto[i,1],]
        ,lwd=2,arr.pos=0.6,arr.length=0.5)
textellipse(elpos[1,],0.1,lab="start",box.col="green",shadow.col="darkgreen",shadow.size=0.005,cex=1.5)
textrect   (elpos[2,],0.15,0.05,lab="found term?",box.col="blue",shadow.col="darkblue",shadow.size=0.005,cex=1.5)
textrect   (elpos[4,],0.15,0.05,lab="related?",box.col="blue",shadow.col="darkblue",shadow.size=0.005,cex=1.5)
textellipse(elpos[3,],0.1,0.1,lab=c("other","term"),box.col="orange",shadow.col="red",shadow.size=0.005,cex=1.5)
textellipse(elpos[3,],0.1,0.1,lab=c("other","term"),box.col="orange",shadow.col="red",shadow.size=0.005,cex=1.5)
textellipse(elpos[7,],0.1,0.1,lab=c("make","a link"),box.col="orange",shadow.col="red",shadow.size=0.005,cex=1.5)
textellipse(elpos[8,],0.1,0.1,lab=c("new","article"),box.col="orange",shadow.col="red",shadow.size=0.005,cex=1.5)

dd <- c(0.0,0.025)
text(arrpos[2,1]+0.05,arrpos[2,2],"yes")
text(arrpos[3,1]-0.05,arrpos[3,2],"no")
text(arrpos[4,1]+0.05,arrpos[4,2]+0.05,"yes")
text(arrpos[5,1]-0.05,arrpos[5,2]+0.05,"no")


#####
par(mfrow=c(2,2))
par(mar=c(0,0,0,0))
openplotmat()
elpos<-coordinates (c(2,3))
treearrow(from=elpos[1:2,],to=elpos[3:5,],arr.side=2,path="H")
for ( i in 1:5) textrect (elpos[i,],0.15,0.05,lab=i,cex=1.5)

openplotmat()
elpos<-coordinates (c(3,2),hor=FALSE)
treearrow(from=elpos[1:3,],to=elpos[4:5,],arr.side=2,arr.pos=0.2,path="V")
for ( i in 1:5) textrect (elpos[i,],0.15,0.05,lab=i,cex=1.5)

openplotmat()
elpos<-coordinates (c(1,4))
treearrow(from=elpos[1,],to=elpos[2:5,],arr.side=2,arr.pos=0.7,path="H")
for ( i in 1:5) textrect (elpos[i,],0.05,0.05,lab=i,cex=1.5)

openplotmat()
elpos<-coordinates (c(2,1,2,3))
elpos[1,1]<-0.3;elpos[2,1]<-0.7
treearrow(from=elpos[1:3,],to=elpos[4:8,],arr.side=2,path="H")
for ( i in 1:8) bentarrow(from=elpos[i,],to=elpos[i,]+c(0.1,-0.05),
                arr.pos=1,arr.type="circle",arr.col="white",arr.length=0.2)
for ( i in 1:8) textrect (elpos[i,],0.05,0.05,lab=i,cex=1.5)
mtext(side=3,outer=TRUE,line=-2,"treearrow",cex=1.5)



par(mfrow=c(1,1))

par(mar=c(0,0,0,0))
openplotmat()
elpos<-coordinates (c(1,1,2,1))
straightarrow (to=elpos[2,],from=elpos[1,])
treearrow(from=elpos[2,],to=elpos[3:4,],arr.side=2,path="H")
treearrow(from=elpos[3:4,],to=elpos[5,],arr.side=2,path="H")
segmentarrow(from=elpos[5,],to=elpos[2,],dd=0.4)
curvedarrow(from= elpos[5,],to=elpos[2,],curve=0.8)
col <- femmecol(5)
texthexa (mid=elpos[1,],radx=0.1,angle=20,shadow.size=0.01,rady=0.05,lab=1,box.col=col[1])
textrect (mid=elpos[2,],radx=0.1,shadow.size=0.01,rady=0.05,lab=2,box.col=col[2])
textround (mid=elpos[3,],radx=0.05,shadow.size=0.01,rady=0.05,lab=3,box.col=col[3])
textellipse (mid=elpos[4,],radx=0.05,shadow.size=0.01,rady=0.05,lab=4,box.col=col[4])
textellipse (mid=elpos[5,],radx=0.05,shadow.size=0.01,rady=0.08,angle=45,lab=5,box.col=col[5])



par(mar=c(1,1,1,1))
openplotmat(main="Arrowtypes")
elpos<-coordinates (c(1,2,1),mx=0.1,my=-0.1)
curvedarrow(from=elpos[1,],to=elpos[2,],curve=-0.5,lty=2,lcol=2)
straightarrow(from=elpos[1,],to=elpos[2,],lty=3,lcol=3)
segmentarrow(from=elpos[1,],to=elpos[2,],lty=1,lcol=1)
treearrow(from=elpos[2:3,],to=elpos[4,],lty=4,lcol=4)
bentarrow(from=elpos[3,],to=elpos[3,]-c(0.1,0.1),arr.pos=1,lty=5,lcol=5)
bentarrow(from=elpos[1,],to=elpos[3,],lty=5,lcol=5)
selfarrow(pos=elpos[3,],path="R",lty=6,curve=0.075,lcol=6)
splitarrow(from=elpos[1,],to=elpos[2:3,],lty=1,lwd=1,dd=0.7,arr.side=1:2,lcol=7)

for ( i in 1:4) textrect (elpos[i,],0.05,0.05,lab=i,cex=1.5)

legend("topright",lty=1:7,legend=c("segmentarrow","curvedarrow","straightarrow",
"treearrow","bentarrow","selfarrow","splitarrow"),lwd=c(rep(2,6),1),col=1:7)

openplotmat(main="textbox shapes")
rx <- 0.1
ry <- 0.05
pos <- coordinates(c(1,1,1,1,1,1,1),mx=-0.2)
textdiamond(mid=pos[1,],radx=rx,rady=ry,lab=LETTERS[1],cex=2,shadow.col="lightblue")
textellipse(mid=pos[2,],radx=rx,rady=ry,lab=LETTERS[2],cex=2,shadow.col="blue")
texthexa(mid=pos[3,],radx=rx,rady=ry,lab=LETTERS[3],cex=2,shadow.col="darkblue")
textmulti(mid=pos[4,],nr=7,radx=rx,rady=ry,lab=LETTERS[4],cex=2,shadow.col="red")
textrect(mid=pos[5,],radx=rx,rady=ry,lab=LETTERS[5],cex=2,shadow.col="darkred")
textround(mid=pos[6,],radx=rx,rady=ry,lab=LETTERS[6],cex=2,shadow.col="black")
textempty(mid=pos[7,],lab=LETTERS[7],cex=2,box.col="yellow")
pos[,1] <- pos[,1] + 0.5
text(pos[,1],pos[,2],c("textdiamond","textellipse","texthexa","textmulti","textrect","textround","textempty"))


mf<-par(mfrow=c(2,2))
example(bentarrow)
example(coordinates)
par(mfrow=c(2,2))
example(curvedarrow)
example(segmentarrow)
example(selfarrow)
example(straightarrow)
par(mfrow=c(2,2))
example(treearrow)
par(mfrow=c(2,2))
example(splitarrow)
par(mfrow=c(2,2))
example(textdiamond)
example(textellipse)
example(textempty)
example(texthexa)
example(textmulti)
example(textplain)
example(textrect)
example(textround)


par(mfrow=mf)

### DEMONSTRATION FOR PLOTMAT
## plots diagram based on a matrix


## SIMPLE PLOTMAT example
par(ask=TRUE)
par(mar=c(1,1,1,1),mfrow=c(2,2))

names <- c("A","B","C","D")
M <- matrix(nrow=4,ncol=4,byrow=TRUE,data=0)
pp<-plotmat(M,pos=c(1,2,1),name=names,lwd=1,box.lwd=2,cex.txt=0.8,
            box.size=0.1,box.type="square",box.prop=0.5)


M[2,1]<-M[3,1]<-M[4,2]<-M[4,3] <- "flow"
pp<-plotmat(M,pos=c(1,2,1),curve=0,name=names,lwd=1,box.lwd=2,cex.txt=0.8,
            box.type="circle",box.prop=1.0)

diag(M) <- "self"
pp<-plotmat(M,pos=c(2,2),curve=0,name=names,lwd=1,box.lwd=2,cex.txt=0.8,
            self.cex=0.5,self.shiftx=c(-0.1,0.1,-0.1,0.1),
            box.type="diamond",box.prop=0.5)

M <- matrix(nrow=4,ncol=4,data=0)
M[2,1]<-1  ;M[4,2]<-2;M[3,4]<-3;M[1,3]<-4
pp<-plotmat(M,pos=c(1,2,1),curve=0.2,name=names,lwd=1,box.lwd=2,cex.txt=0.8,
            arr.type="triangle",box.size=0.1,box.type="hexa",box.prop=0.5)
mtext(outer=TRUE,side=3,line=-1.5,cex=1.5,"plotmat")

##PLOTMAT example 2
names <- c("A","B","C","D")
M <- matrix(nrow=4,ncol=4,byrow=TRUE,data=0)
M[2,1]<-M[3,2]<-M[4,3]<-1

par(mfrow=c(1,2))
pp<-plotmat(M,pos=c(1,1,1,1),curve=0,name=names,lwd=1,box.lwd=2,cex.txt=0.,
            box.size=0.2,box.type="square",box.prop=0.5,arr.type="triangle",
            arr.pos=0.6)
p2 <-plotmat(M[1:2,1:2],pos=pp$comp[c(1,4),],curve=0,name=names[c(1,4)],lwd=1,box.lwd=2,
            cex.txt=0.,box.size=0.2,box.type="square",box.prop=0.5,
            arr.type="triangle",arr.pos=0.6)
text(p2$arr$ArrowX+0.1,p2$arr$ArrowY,font=3,adj=0,"one flow")
par(mfrow=c(1,1))
mtext(outer=TRUE,side=3,line=-1.5,cex=1.5,"plotmat")

# Plotmat example NPZZDD model
names <- c("PHYTO","NH3","ZOO","DETRITUS","BotDET","FISH")
M <- matrix(nrow=6,ncol=6,byrow=TRUE,data=c(
#   p n z  d  b  f
    0,1,0, 0, 0, 0, #p
    0,0,4, 10,11,0, #n
    2,0,0, 0, 0, 0, #z
    8,0,13,0, 0, 12,#d
    9,0,0, 7, 0, 0, #b
    0,0,5, 0, 0, 0  #f
    ))

pp<-plotmat(M,pos=c(1,2,1,2),curve=0,name=names,lwd=1,box.lwd=2,cex.txt=0.8,
            box.type="square",box.prop=0.5,arr.type="triangle",
            arr.pos=0.4,shadow.size=0.01,prefix="f",
            main="NPZZDD model, from Soetaert and herman, 2009, Springer")

# extra arrows: flow 5 to Detritus and flow 2 to detritus
phyto   <-pp$comp[names=="PHYTO"]
zoo     <-pp$comp[names=="ZOO"]
nh3     <-pp$comp[names=="NH3"]
detritus<-pp$comp[names=="DETRITUS"]
fish    <-pp$comp[names=="FISH"]

# flow5->detritus
m2 <- 0.5*(zoo+fish)
m1 <- detritus
m1[1]<-m1[1]+ pp$radii[4,1]
mid<-straightarrow (to=m1,from=m2,arr.type="triangle",arr.pos=0.4,lwd=1)
text(mid[1],mid[2]+0.03,"f6",cex=0.8)

# flow2->detritus
m2 <- 0.5*(zoo+phyto)
m1 <- detritus
m1[1] <-m1[1]+ pp$radii[3,1]*0.2
m1[2]<-m1[2] + pp$radii[3,2]
mid<-straightarrow (to=m1,from=m2,arr.type="triangle",arr.pos=0.3,lwd=1)
text(mid[1]-0.01,mid[2]+0.03,"f3",cex=0.8)



# TRANSITION MATRIX

par(mfrow=c(2,1))

#labels as formulae
Numgenerations   <- 6

# Original Population matrix 
DiffMat  <- matrix(data=0,nrow=Numgenerations,ncol=Numgenerations)   # declare it
AA <- as.data.frame(DiffMat)
AA[[1,4]]<- "f[3]"
AA[[1,5]]<- "f[4]"
AA[[1,6]]<- "f[5]"

AA[[2,1]]<- "s[list(0,1)]"
AA[[3,2]]<- "s[list(1,2)]"
AA[[4,3]]<- "s[list(2,3)]"
AA[[5,4]]<- "s[list(3,4)]"
AA[[6,5]]<- "s[list(4,5)]"

name  <- c("Age0","Age1","Age2","Age3","Age4","Age5")

PP <- plotmat(A=AA,pos=6,curve=0.7,name=name,lwd=2,arr.len=0.6,arr.width=0.25,my=-0.2,
              box.size=0.05,arr.type="triangle",dtext= 0.95,cex.txt=0,
              main="Age-structured population model 1")

for (i in 1:nrow(PP$arr))
  text(as.double(PP$arr[i,"TextX"]),as.double(PP$arr[i,"TextY"]),
  parse(text=as.character(PP$arr[i,"Value"])))

# reduced population matrix
Numgenerations   <- Numgenerations-1
DiffMat          <- DiffMat[-1,-1]
AA <- as.data.frame(DiffMat)
AA[[1,3]]<- "f[3]*s[list(0,1)]"
AA[[1,4]]<- "f[4]*s[list(0,1)]"
AA[[1,5]]<- "f[5]*s[list(0,1)]"

AA[[2,1]]<- "s[list(0,2)]"
AA[[3,2]]<- "s[list(2,3)]"
AA[[4,3]]<- "s[list(3,4)]"
AA[[5,4]]<- "s[list(4,5)]"

name  <- c("Age0","Age2","Age3","Age4","Age5")

pos <- PP$comp[-1,]
PP <- plotmat(AA,pos=pos,curve=0.7,name=name,lwd=2,arr.len=0.6,arr.width=0.25,my=-0.1,
              box.size=0.05,arr.type="triangle",dtext= 0.95,cex.txt=0,main="Age-structured population model 2")
for (i in 1:nrow(PP$arr))
  text(as.double(PP$arr[i,"TextX"]),as.double(PP$arr[i,"TextY"]),
  parse(text=as.character(PP$arr[i,"Value"])))

par(mfrow=c(1,1),mar=c(2,2,2,2))


#################3
par(mfrow=c(1,1))
par(mar=c(4,4,4,4))
par(xaxs="r",yaxs="r")
# Fecundity and Survival for each generation
NumClass    <- 10
Fecundity   <- c(0,      0.00102,0.08515,0.30574,0.40002,
                 0.28061,0.1526 ,0.0642 ,0.01483,0.00089)
Survival    <- c(0.9967 ,0.99837,0.9978 ,0.99672,0.99607,
                 0.99472,0.99240,0.98867,0.98274,NA)            # survival from i to i+1

cbind(Fecundity,Survival)

# Population matrix M
DiffMatrix       <- matrix(data=0,nrow=NumClass,ncol=NumClass)     # declare it
DiffMatrix[1,]   <- Fecundity                                      # first row: fecundity
for (i in 1:(NumClass-1))  DiffMatrix[i+1,i] <- Survival[i]

DiffMatrix                                                         # print the matrix to screen
names <- c("0-5yr","5-10yr","10-15yr","15-20yr","20-25yr","25-30yr","30-35yr","35-40yr","40-45yr","45-50yr")
# first generation will be positioned in middle; other generations on a circle
pos <- coordinates(NULL,N=NumClass-1)
pos <- rbind(c(0.5,0.5),pos)
curves <- DiffMatrix
curves[]   <- -0.4
curves[1, ] <- 0
curves[2,1] <- -0.125
curves[1,2] <- -0.125
plotmat(main="US population, life cycle, 1966",DiffMatrix,pos=pos,name=names,curve=curves,lcol="darkblue",arr.col="lightblue",
        box.size=0.07,arr.type="triangle",cex.txt=0.8,box.col="lightyellow",box.prop =1)

#####

A        <- matrix(nrow=7,ncol=7,NA)
A[,1]    <- 1 ; A[1,1]<-0
pos <- coordinates(NULL,N=6,relsize=0.8)       # 6 boxes in circle
pos <- rbind(c(0.5,0.5),pos)       # one in middle

plotmat(A,pos=pos,lwd=1,curve=0,box.lwd=2,cex.txt=0.8,box.col=2:8, 
        box.cex=0.8,box.size=0.125,arr.length=0.5,box.type=c("multi","rect","ellipse"),
        shadow.size = 0.01,nr=5,main="plotmat")


# TRANSITION MATRIX EXAMPLE
# dataset Teasel

curves <- matrix(nrow=ncol(Teasel),ncol=ncol(Teasel),0)
curves[3,1]<- curves[1,6]<- -0.35             
curves[4,6]<-curves[6,4]<-curves[5,6]<-curves[6,5]<-0.08
curves[3,6]<-  0.35

plotmat(Teasel,pos=c(3,2,1),curve=curves,name=colnames(Teasel),lwd=1,box.lwd=2,cex.txt=0.8, 
        box.cex=0.8,box.size=0.08,arr.length=0.5,box.type="circle",box.prop=1,
        shadow.size = 0.01,self.cex=0.6,my=-0.075, mx=-0.01,relsize=0.9,
        self.shiftx=c(0,0,0.125,-0.12,0.125,0),self.shifty=0,main="Teasel population model")




# PLOTWEB examples
par(ask=TRUE)
# plotweb examples
feed <- matrix(nrow=20,ncol=20,1)
plotweb(feed,legend=FALSE,length=0,main="plotweb")

feed <- matrix(nrow=20,ncol=20,1)
diag(feed)<-0
plotweb(feed,legend=FALSE,main="plotweb")

feed <- diag(nrow=20,ncol=20,1)
plotweb(feed,legend=FALSE,main="plotweb")

plotweb(Rigaweb,main="Gulf of Riga food web",sub="mgC/m3/d",val=TRUE)
plotweb(Takapotoweb,main="Takapoto atoll planktonic food web",leg.title="mgC/m2/day",lab.size=1)
plotweb(Takapotoweb,main="Takapoto atoll planktonic food web",sub="mgC/m2/day",lab.size=1,log=TRUE)

https://ggobi.github.io/ggally/#ggally
require(GGally)
reg <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris)
ggcoef(reg)

data(psychademic)
str(psychademic)

(psych_variables <- attr(psychademic, "psychology"))
(academic_variables <- attr(psychademic, "academic"))
ggpairs(psychademic, psych_variables, title = "Within Psychological Variables")

https://ggobi.github.io/ggally/#multiple_time_series_analysis

graphjs(LeMis, vertex.size = 1)
make_ring(10) %>% graphjs

g <- make_full_graph(2, directed=TRUE, loops=TRUE)
make_line_graph(g)%>% graphjs

make_tree(10, 2)



sma_short = sma( candles$'close', 50 )
sma_long  = sma( candles$'close', 100 )
crossover = crossover( sma_short, sma_long )

plot_ts( candles )

candles[ crossover == 'UP', abline( v = t_to_x( time ), col = 'blue' ) ]
candles[ crossover == 'DN', abline( v = t_to_x( time ), col = 'red' ) ]
plot_ts( candles[ , .( time, sma_short, sma_long ) ], col = c( 'firebrick', 'goldenrod' ), add = T )




library(Rcpp)

sourceCpp(file='e:/hello.cpp')
hello('R')


sourceCpp(code='
  #include >Rcpp.h<
  #include >string<
  
  using namespace std;
  using namespace Rcpp;
  
  //[[Rcpp::export]]
  string hello(string name) {
    cout << "xxxx " << name << endl;  
    return name;
  }
')
hello('R2')


install.packages("FastRWeb")

install.packages("Rserve")