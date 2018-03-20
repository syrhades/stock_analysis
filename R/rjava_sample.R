f <- .jnew("java/awt/Frame", "Hello")
b <- .jnew("java/awt/Button", "OK")
.jcall(f, "Ljava/awt/Component;", "add", .jcast(b, "java/awt/Component"))
.jcall(f,, "pack")
.jcall(f,, "setVisible", TRUE)

require(rJava)
###################################

Double <- J("java.lang.Double")
d <- new( Double, "10.2" )
# character
d %instanceof% "java.lang.Double"
d %instanceof% "java.lang.Number"
# jclassName
d %instanceof% Double
# instance of Class
Double.class <- Double@jobj
d %instanceof% Double.class
# other object
other.double <- new( Double, 10.2 )
d %instanceof% other.double


# lapplying over a java array
a <- .jarray( list(
.jnew( "java/awt/Point", 10L, 10L ),
.jnew( "java/awt/Point", 30L, 30L )
) )
lapply( a, function(point){
with(point, {
(x + y ) ^ 2
} )
} )
# lapply over a Vector (implements Iterable)
v <- .jnew("java/util/Vector")
v$add( "foo" )
v$add( .jnew("java/lang/Double", 10.2 ) )
sapply( v, function(item) item$getClass()$getName() )

Integer <- J("java.lang.Integer")
tryCatch( Integer$parseInt( "10.." ), NumberFormatException = function(e){
e$jobj$printStackTrace()
} )
# the dollar method is also implemented for Throwable conditions,
# so that syntactic sugar can be used on condition objects
# however, in the example below e is __not__ a jobjRef object reference
tryCatch( Integer$parseInt( "10.." ), NumberFormatException = function(e){
e$printStackTrace()
} )

if (!nzchar(Sys.getenv("NOAWT"))) {
f <- new(J("java.awt.Frame"), "Hello")
f$setVisible(TRUE)
}
J("java.lang.Double", "parseDouble", "10.2" )

J("java.lang.Double")$parseDouble("10.2")

ttt<-J("java.lang.Double")
ttt%>%str
ttt%>%class
ttt%>% ls
ttt$toString()
ttt$toString(10)

# String[] strings = new String[]{ "string", "array" } ;
strings <- .jarray( c("string", "array") )
# this uses the JList( Object[] ) constructor
# even though the "strings" parameter is a String[]
l <- new( J("javax.swing.JList"), strings)


a <- .jarray(1:10)
print(a)
.jevalArray(a)
b <- .jarray(c("hello","world"))
print(b)
c <- .jarray(list(a,b))
print(c)
# simple .jevalArray will return a list of references
print(l <- .jevalArray(c))
# to convert it back, use lapply
lapply(l, .jevalArray)
# two-dimensional array resulting in int[2][10]
d <- .jarray(list(a,a),"[I")
print(d)
# use dispatch to convert a matrix to [[D
e <- .jarray(matrix(1:12/2, 3), dispatch=TRUE)
print(e)
# simplify it back to a matrix
.jevalArray(e, simplify=TRUE)

lapply(l, .jevalArray) %>%lapply(class)




v <- new(J("java.lang.String"), "Hello World!")
v$length()
v$indexOf("World")
names(v)
J("java.lang.String")$valueOf(10)
Double <- J("java.lang.Double")
# the class pseudo field - instance of Class for the associated class
# similar to java Double.class
Double$class

javaImport(packages = "java.lang")


## Not run:
attach( javaImport( "java.util" ), pos = 2 , name = "java:java.util" )
# now we can just do something like this
v <- new( Vector )
v$add( "foobar" )
ls( pos = 2 )
# or this
m <- new( HashMap )
m$put( "foo", "bar" )
ls( pos = 2 )
# or even this :
Collections$EMPTY_MAP
## End(Not run)




.jcall("java/lang/System","S","getProperty","os.name")
if (!nzchar(Sys.getenv("NOAWT"))) {
f <- .jnew("java/awt/Frame","Hello")
.jcall(f,,"setVisible",TRUE)
}


 
fname<-f%>%names
fname%>% l_ply(function(x) grep("setV",x,value =T)%>%cat)
fname%>% llply(function(x) grep("setV",x,value =T))

.jinit()
# requires JRI and REngine classes
.jengine(TRUE)
f <- function() { cat("Hello!\n"); 1 }
fref <- toJava(f)
# to use this in Java you would use something like:
# public static REXP call(REXPReference fn) throws REngineException, REXPMismatchException {
# return fn.getEngine().eval(new REXPLanguage(new RList(new REXP[] { fn })), null, false);
# }
# .jcall("Call","Lorg/rosuda/REngine/REXP;","call", fref)














http://www.sse.com.cn/disclosure/listedinfo/announcement/c/2016-03-12/600009_2015_nzy.pdf
http://www.sse.com.cn/disclosure/listedinfo/announcement/c/2016-03-12/600009_2015_n.pdf
http://www.sse.com.cn/disclosure/listedinfo/announcement/c/2015-03-11/600009_2014_nzy.pdf

拟以 2015 年末公司总股本 1,926,958,448 股为基数，每 10 股派发现金红利 4.3 元（含税），
共计派发现金红利 828,592,132.64 元（含税） ， 占合并报表中归属于上市公司股东的净利润的
比率为 32.73%。公司 2015 年不进行资本公积金转增股本
上市公司 股票代码 
西飞国际 sz000768 
力源液压 sh600765 
中航精机 sz002013 
贵航股份 sh600523 
中航光电 sz002179 
成飞集成 sz002190 
深天马 sz000050 
飞亚达 sz000026 
飞亚达B sz200026 
中航地产 sz000043 
哈飞股份 sh600038 
东安动力 sh600178 
洪都航空 sh600316 
南方宇航 sz000738 
昌河股份 sh600372 
三鑫股份 sz002163 
航空动力 sh600893 
东安黑豹 sh600760 
成发科技 sh600391 
深圳中航集团股份有限公司（H股） HK0161 
中国航空技术国际控股有限公司（红筹股） HK0232 
中国航空科技工业股份有限公司（H股） HK2357 
