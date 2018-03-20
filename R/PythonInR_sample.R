http://www.rforge.net/rJava/

require(PythonInR)
source("e:/syrhadestock/R/cl_part_function.R")
pyConnect("f:\\Python35\\python.exe")
pyConnect("/usr/bin/python3")
pyVersion()


pyConnect(pythonExePath ="/usr/bin/python3")
function (pythonExePath = NULL, dllDir = NULL, pythonHome = NULL) 
PythonInR :::guessPythonExePathWhere()
PythonInR:::pyConnect("/usr/bin/python3")


Sys.setenv(PYTHON_EXE="/usr/bin/python3")

PythonInR:::pyIsConnected()
PythonInR:::autodetectPython(pythonExePath="/usr/bin/python3")

pyExec("import os")
pyAttach("os.getcwd", .GlobalEnv)
os.getcwd
os.getcwd()

pyExecp("os.sep")
pyExecp("os.getcwd()")

Usage
pyCall(callableObj, args = NULL, kwargs = NULL, autoTypecast = TRUE,
simplify = TRUE)
Arguments
callableObj a character string giving the name of the desired callable Python object.
args an optional list of arguments passed to the callable.
kwargs an optional list of named arguments passed to the callable.
autoTypecast an optional logical value, default is TRUE, specifying if the return values should
be automatically typecasted if possible.
simplify an optional logical value, if TRUE, R converts Python lists into R vectors when
ever possible, else it translates Python lists always to R lists.

pyCall("sum", args=list(1:3))
## define a new function with the name fun
pyExec('def fun(**kwargs):
	return([(key, value) for key, value in kwargs.items()])' )

pyExec('def fun(**kwargs):return([(key, value) for key, value in kwargs.items()])')
pyAttach("fun", .GlobalEnv)
fun(kwargs=list(a=1, f=2, x=4))
pyCall("fun", kwargs=list(a=1, f=2, x=4))



myNewDict <- pyDict( 'myNewDict' , list(p=2, y=9, r=1))

myNewDict2 <- pyDict( 'myNewDict' , list(p=2, y=9, r=1))


pyDir()
pyDir("sys")


pyExec( '
print("The following line will not appear in the R terminal!")
"Hello" + " " + "R!"
print("NOTE: pyExecp would also show the line above!")
print("The following line will appear in the R terminal!")
print("Hello" + " " + "R!")
' )


pyExecfile("e:/myPythonScript.py")



pyExecg Executes multiple lines of python code and gets the output
Description
The function pyExecg is designed to execute multiple lines of Python code and returns the thereby
generated variables to R.
Usage
pyExecg(code, returnValues = character(), autoTypecast = TRUE,
returnToR = TRUE, mergeNamespaces = FALSE, override = FALSE,
simplify = TRUE)
Arguments
code a string of Python code to be executed in Python.
returnValues a character vector containing the names of the variables, which should be re
turned to R.
autoTypecast a an optional logical value, default is TRUE, specifying if the return values
should be automatically typecasted if possible.
returnToR an optional logical, default is TRUE, specifying if the generated variables should
be returned to R.
mergeNamespaces
an optional logical, default is FALSE, specifying if the internally generated tem
porary namespace should be merged with the name space __main__. See De
tails.
override an optional logical value, default is FALSE, specifying how to merge the tem
porary namespace with the __main__ namespace.
simplify an optional logical, if TRUE (default) R converts Python lists into R vectors
whenever possible, else it translates Python lists always to R lists.

############################################

pyExecg 11
Details
The function pyExecg executes the code in a temporary namespace, after the execution every vari
able from the namespace is returned to R. If the mergeNamespaces is set to TRUE the temporary
namespace gets merged with the (global) namespace __main__. The logical variable override is
used to control, if already existing variables in the namespace __main__ should be overridden,
when a variable with the same name get’s assigned to the temporary namespace. If a python object
can’t be converted to an R object it is assigned to the Python dictionary __R__.namespace and the
type, id and an indicator if the object is a callable are returned.
Value
Returns a list containing all the variables of the __main__ namespace.
Examples
if ( pyIsConnected() ){
# 1. assigns x to the global namespace
pyExec("x=4")
# 2. assigns y to the temp namespace
pyExecg("y=4", simplify=TRUE)
# 3. assign again to the temp namespace
pyExecg("
y=[i for i in range(1,4)]
x=[i for i in range(3,9)]
z=[i**2 for i in range(1,9)]
", returnValues=c("x", "z"), simplify=TRUE)
# 4. assign x to the temp namespace, x gets returned as vector
pyExecg("x=[i for i in range(0,5)]", simplify=TRUE)
# 5. assign x to the temp namespace, x gets returned as list
pyExecg("x=[i for i in range(0,5)]", simplify=FALSE)
# 6. x is still 4 since except assignment 1 all other assignments
# took place in the temp namespace
pyPrint("x")
# 7. note y has never been assigned to the main namespace
"y" %in% pyDir()
# 8. since mergeNamespaces is TRUE PythonInR will try
# to assign x to the main namespace but since override is
# by default FALSE and x already exists in the main namespace
# x will not be changed
pyExecg("x=10", simplify=TRUE, mergeNamespaces=TRUE)
# 9. there is no y in the main namespace therefore it can be assigned
pyExecg("y=10", simplify=TRUE, mergeNamespaces=TRUE)
pyPrint("x") # NOTE: x is still unchanged!
pyPrint("y") # NOTE: a value has been assigned to y!
# 10. since override is now TRUE the value of x will be changed in the
# main namespace
pyExecg("x=10", simplify=TRUE, mergeNamespaces=TRUE, override=TRUE)
pyPrint("x") # NOTE: x is changed now!
# 11. get an object which can ' t be typecast to an R object
# pyExecg does not transform these objects automatically

pyExec("import os")
z <- pyExecg("x = os")
os <- PythonInR:::pyTransformReturn(z[[1]])
os$getcwd()
}

result_py <- 
pyExecg("
y=[i for i in range(1,4)]
x=[i for i in range(3,9)]
z=[i**2 for i in range(1,9)]
", returnValues=c("x", "z"), simplify=TRUE)


pyExecg("x=os", simplify=TRUE, mergeNamespaces=TRUE, override=TRUE)

pyExec("import os")
z <- pyExecg("x = os")
os <- PythonInR:::pyTransformReturn(z[[1]])
os$getcwd()

pySum <- pyFunction("sum")
pySum(1:3)


z <- pyExecg("f = lambda x,y,z:x+y+z")
lambda_f <- PythonInR:::pyTransformReturn(z[[1]])


> pyGet("sys.path", autoTypecast = FALSE) %>% class
[1] "PythonInR_List"   "PythonInR_Object" "R6"              
> pyGet("sys.path", autoTypecast = T) %>% class
[1] "character"
> pyGet("sys.path", autoTypecast = T)
[1] ""                                       
[2] "f:\\Python35\\python35.zip"             
[3] "f:\\Python35\\DLLs"                     
[4] "f:\\Python35\\lib"                      
[5] "C:\\Program Files\\R\\R-3.3.1\\bin\\x64"
[6] "f:\\Python35"                           
[7] "f:\\Python35\\lib\\site-packages"       
[8] "."                                      
> 
> pyGet("sys.path", simplify = FALSE)
[[1]]
[1] ""

[[2]]
[1] "f:\\Python35\\python35.zip"

[[3]]
[1] "f:\\Python35\\DLLs"

[[4]]
[1] "f:\\Python35\\lib"

[[5]]
[1] "C:\\Program Files\\R\\R-3.3.1\\bin\\x64"

[[6]]
[1] "f:\\Python35"

[[7]]
[1] "f:\\Python35\\lib\\site-packages"

[[8]]
[1] "."
pyGet always returns a new object, if you want to create a R representation of an existing Python
object use pyGet0 instead.

x <- pyGet("datetime.datetime.now().time()")
x

itertools_py <- frm_get_import_obj_v2("itertools")
itertools_py$accumulate([1,2,3,4,5])
pyHelp("abs")

pyImport(c("getcwd", "sep"), from="os")

pyImport("pandas", as="pd")
accumulate([1,2,3,4,5]) --> 1 3 6 10 15



myNewList <- pyList( 'myNewList' , list(1:3, ' Hello Python' ))

myNewList %>% ls

pyPrint(" ' Hello ' + ' R! ' ")
pyPrint("sys.version")


pySet("x", 3)
pySet("M", diag(1,3))
> pyPrint("M")
prMatrix:
        3 columns
        3 rows
[[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
> pyPrint("x")
3.0
> 


## pySet can also be used to change values of objects or dictionaries.
asTuple <- function(x) {
class(x) <- "tuple"
return(x)
}
pyExec("d = dict()")
pyPrint("d")
pySet("myTuple", asTuple(1:10), namespace="d")
pySet("myList", as.list(1:5), namespace="d")

> pySet("myTuple", asTuple(1:10), namespace="d")
> pyPrint("d")
{'myTuple': (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)}
> pySet("myList", as.list(1:5), namespace="d")
> pyPrint("d")
{'myTuple': (1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 'myList': [1, 2, 3, 4, 5]}


newTuple <- pyTuple( ' myNewTuple ' , list(1:3, ' Hello Python' ))
pySet("newTuple", newTuple)
pyPrint("newTuple")

html_format<-kable(head(iris), format = "html")


html_format<-kable(head(iris), format = "html")
html_format %>% write(file="e:/tetss.html")
kable(mtcars, "html", table.attr = "id=\"mtcars_table\"")%>% write(file="e:/tetss.html")



pyCall("sum", args=list(1:3))
## define a new function with the name fun
pyExec( '
def fun(**kwargs):
# \tprint (kwargs)
\treturn([(key, value) for key, value in kwargs.items()])
' )
pyAttach("fun")
pyCall("fun", kwargs=list(a=1, f=2, x=4))
fun(kwargs=list(a=1, f=2, x=4))
fun(kwargs=list(a=1, f=2, x=4))[[1]][[2]]



pyExec( '
def funp(strxx):
# \tprint (kwargs)
\tprint(strxx)
\treturn([(key, value) for key, value in kwargs.items()])
' )
pyAttach("funp")
pyCall("funp", args=list(a=1))

pyCall("sum", args=list(1:4))
pyCall("print", args=list(1:4))

funp(args=list("*",8))
fun(kwargs=list(a=1, f=2, x=4))[[1]][[2]]

pyExec( 'print("*"*10)' )

不规范：
其他流动负债 89,832,982.75 58,255,681.14 54.20% 主要系期末计提的销售促销费用等费用
增加所致

资产减值损失 454,010.90 18,955,473.55 -97.60% 主要系上期计提开发产品减值准备所致

营业外收入 13,789,763.33 7,692,247.07 79.27% 主要系本期政府补助增加所致
营业外支出 1,867,199.84 3,996,513.76 -53.28% 主要系上期固定资产处置所致
收到的税费返还 2,059,272.92 671,834.10 206.52% 主要系本期收到的退税增加所致
