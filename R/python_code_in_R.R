require(PythonInR)
autodetectPython("f:\\Python27\\python.exe")
pyConnect()

autodetectPython("f:\\Python32\\python.exe")
pyConnect()
pyConnect("f:\\Python32\\python.exe")
pyVersion()

# code <-BEGIN.Python()
#   import os
#   os.getcwd()
# dir(os)
# x = 3**3
# for i in xrange(10):
#   if (i > 5):
#     print(i)
# END.Python

# cat(code, sep="\n")
# pyGet0("x")

pyCall("sum", args=list(1:3))
pyExec('
def fun(**kwargs):
  return([(key, value) for key, value in kwargs.items()])
')
pyCall("fun", kwargs=list(a=1, f=2, x=4))



if ( pyIsConnected() ){
pyExec("import os")
## attach to global
## ----------------
## attach the function getcwd from the module os to R.
pyAttach("os.getcwd", .GlobalEnv)
os.getcwd
os.getcwd()
## attach the string object os.name to R
pyAttach("os.name", .GlobalEnv)
pyExecp("os.name")
os.name
## Since os.name is attached to the globalenv it can be set without using
## the global assignment operator
os.name = "Hello Python from R!"
pyExecp("os.name")
os.name
## Please note if you don't pyAttach to globalenv you have to use
## the global assignment operator to set the values of the Python objects
## attach to a new environment
## ---------------------------
os <- new.env()
attach(os, name="python:os")
pyAttach(paste("os", pyDir("os"), sep="."), as.environment("python:os"))
os.sep
os.sep = "new sep" ## this doesn't changes the value in Python but only
## assigns the new variable os.sep to globalenv
os.sep
.GlobalEnv$`os.sep`
as.environment("python:os")$`os.sep`
pyExecp("os.sep")
ls()
ls("python:os")
os.sep <<- "this changes the value in Python"
.GlobalEnv$`os.sep`
as.environment("python:os")$`os.sep`
pyExecp("os.sep")
}


if ( pyIsConnected() ){
pyExec('myPyDict = {"a":1, "b":2, "c":3}')
## create a virtual Python dictionary for an existing dictionary
myDict <- pyDict("myPyDict")
myDict["a"]
myDict["a"] <- "set the key"
myDict
## allowed keys are
myDict['string'] <- 1
myDict[3L] <- "long"
myDict[5] <- "float"
myDict[c("t", "u", "p", "l", "e")] <- "tuple"
myDict
## NOTE: Python does not make a difference between a float key 3 and a long key 3L
myDict[3] <- "float"
myDict
## create a new Python dict and virtual dict
myNewDict <- pyDict('myNewDict', list(p=2, y=9, r=1))
myNewDict
}


# > myDict %>% str
# Classes 'PythonInR_Dict', 'PythonInR_Object', 'R6' <PythonInR_Dict>
#   Inherits from: <PythonInR_Object>
#   Public:
#     clear: function () 
#     clone: function (deep = FALSE) 
#     copy: function () 
#     fromkeys: function (seq, value) 
#     get: function (key, default) 
#     has_key: function (key) 
#     initialize: function (variableName, objectName, type) 
#     items: function () 
#     keys: function (key) 
#     pop: function (key, default) 
#     popitem: function () 
#     portable: TRUE
#     print: function () 
#     py.del: function () 
#     py.objectName: NULL
#     py.type: dict
#     py.variableName: myPyDict
#     setdefault: function (key, default) 
#     update: function (dict) 
#     values: function () 
#     viewitems: function () 
#     viewkeys: function () 
#     viewvalues: function ()  
# > myDict$
# myDict$.__enclos_env__  myDict$viewitems        myDict$has_key
# myDict$py.type          myDict$values           myDict$get
# myDict$py.objectName    myDict$update           myDict$fromkeys
# myDict$py.variableName  myDict$setdefault       myDict$copy
# myDict$portable         myDict$popitem          myDict$clear
# myDict$clone            myDict$pop              myDict$print
# myDict$viewvalues       myDict$keys             myDict$initialize
# myDict$viewkeys         myDict$items            myDict$py.del
# > myDict$viewkeys
# function () 
# {
#     cable <- sprintf("%s.viewkeys", self$py.variableName)
#     pyCall(cable)
# }
# <environment: 0x4025260>
# > myDict$viewkeys()
# dict_keys(['a', 'c', 'b'])
# > 
# pyDir()
# pyDir("sys")


pyExec('
print("The following line will not appear in the R terminal!")
"Hello" + " " + "R!"
print("NOTE: pyExecp would also show the line above!")
print("The following line will appear in the R terminal!")
print("Hello" + " " + "R!")
')


## Not run:
pyExecfile("myPythonScript.py")
## End(Not run)


py_result<-pyExecg("
y=[i for i in range(1,4)]
x=[i for i in range(3,9)]
z=[i**2 for i in range(1,9)]
", returnValues=c("x", "z"), simplify=TRUE)


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
#
took place in the temp namespace
pyPrint("x")
# 7. note y has never been assigned to the main namespace
"y" %in% pyDir()
# 8. since mergeNamespaces is TRUE PythonInR will try
#
to assign x to the main namespace but since override is
#
by default FALSE and x already exists in the main namespace
#
x will not be changed
pyExecg("x=10", simplify=TRUE, mergeNamespaces=TRUE)
# 9. there is no y in the main namespace therefore it can be assigned
pyExecg("y=10", simplify=TRUE, mergeNamespaces=TRUE)
pyPrint("x") # NOTE: x is still unchanged!
pyPrint("y") # NOTE: a value has been assigned to y!
# 10. since override is now TRUE the value of x will be changed in the
#
main namespace
pyExecg("x=10", simplify=TRUE, mergeNamespaces=TRUE, override=TRUE)
pyPrint("x") # NOTE: x is changed now!
# 11. get an object which can't be typecast to an R object
#
pyExecg does not transform these objects automatically

pyExec("import os")
z <- pyExecg("x = os")
os <- PythonInR:::pyTransformReturn(z[[1]])
os$getcwd()
}

pyExec("import os")
z <- pyExecg("x = os")
os <- PythonInR:::pyTransformReturn(z[[1]])
os$getcwd()

pyExecp('"Hello" + " " + "R!"')

pySum <- pyFunction("sum")
pySum(1:3)
pyPow <- pyFunction("pow")
pyPow(2,3)


pyGet("sys.path")


## get a character of length 1
pyGet("__name__")
## get a character of length 1 > 1
pyGet("sys.path")
## get a list
pyGet("sys.path", simplify = FALSE)
## get a PythonInR_List
x <- pyGet("sys.path", autoTypecast = FALSE)
x
class(x)
## get an object where no specific transformation to R is defined
## this example also shows the differnces between pyGet and pyGet0
pyExec("import datetime")
## pyGet creates a new Python variable where the return value of pyGet is
## stored the name of the new reference is stored in x$py.variableName.
x <- pyGet("datetime.datetime.now().time()")
x
class(x)
x$py.variableName
## pyGet0 never creates a new Python object, objects which can be transformed
## to R objects are transformed. For all other objects an PythonInR_Object is created.
y <- pyGet0("datetime.datetime.now().time()")

pyExec("import numpy")
pyExec("import os")
os <- pyGet0("os")
os$getcwd()
os$sep
os$sep <- "Hello Python!"
pyExecp("os.sep")

pyHelp("abs")

pyImport(import, from = NULL, as = NULL, env = parent.frame())
pyImport("os")
## Not run:
#NOTE: The following does not only import numpy but also register the
#
alias in the options under the name "numpyAlias".
#
The same is done for pandas, the default alias for pandas and numpy
#
are respectively "pandas" and "numpy". The numpyAlias is used
#
when calling pySet with the pyOption useNumpy set to TRUE.
pyOptions("numpyAlias")
pyImport("numpy", as="np")
pyOptions("numpyAlias")
pyImport("pandas", as="pd")
pyImport(c("getcwd", "sep"), from="os")
getcwd()
sep
sep = "Hello R!"
pyExecp("sep")


pyExec("import os")
os <- pyObject("os", regFinalizer = FALSE)
ls(os)
## To show again the difference between pyGet and pyGet0.
os1 <- pyGet0("os") ## has no finalizer
os2 <- pyGet("os") ## has a finalizer
os$py.variableName
os1$py.variableName
os2$py.variableName

pyExec("import pandas as pd")


pyPrint("'Hello ' + 'R!'")
pyPrint("sys.version")



pySet("x", 3)
pySet("M", diag(1,3))
pyImport("os")
pySet("name", "Hello os!", namespace="os")
## In some situations it can be beneficial to convert R lists or vectors
## to Python tuple instead of lists. One way to accomplish this is to change
## the class of the vector to "tuple".
y <- c(1, 2, 3)
class(y) <- "tuple"
pySet("y", y)
## pySet can also be used to change values of objects or dictionaries.
asTuple <- function(x) {
class(x) <- "tuple"
return(x)
}
pyExec("d = dict()")
pySet("myTuple", asTuple(1:10), namespace="d")
pySet("myList", as.list(1:5), namespace="d")

pyExec("x = {'a':1,'b':3}")
pyType("x")
[1] "dict"
pyPrint("x")
{'a': 1, 'b': 3}


require(rJython)
rJython <- rJython()
a <- 1:4
jython.assign( rJython, "a", a )
jython.exec( rJython, "b = len( a )" )
jython.get( rJython, "b" )
rJython$exec( "import math" )
jython.get( rJython, "math.pi" )

rJython <- rJython()
a <- 1:4
b <- 5:8
jython.exec( rJython, c( "def concat(a,b):", "\treturn a+b" ) )
jython.call( rJython, "concat", a, b)


rJython <- rJython()
rJython$exec( 'a = "hola hola"' )
jython.method.call( rJython, "a", "split", " " )

rJython

XRPython
ev <- RPython()
pythonAddToPath("/Users/me/myPython/", package = "",
evaluator = ev)

pythonImport("os","path", evaluator = ev)
pythonGet("path")

require(XRPython)
ev <- RPython()
xx <- ev$Eval("[1, %s, 5]", pi)
xx
xx$append(4.5)
ev$Command("print %s", xx)


pythonCommand("print('*'*10)")

xx <- ev$Eval("[1, %s, 5]", pi)
xx <- ev$Send(c(1, pi, 5))
ev$Command("print %s", xx)

as.numeric(ev$Get(xx))

ev$Call("vectorR",xx, "numeric",.get = TRUE)


For the $Define() method this is equivalent to a character vector with the lines
of the definition as elements:
> text <- c("def repx(x):", "
> repxP <- ev$Define(text)
return [x, x]")
This creates the R proxy function, assigned as repxP:
> twice <- repxP(1:3)
> unlist(pythonGet(twice))
[1] 1 2 3 1 2 3

repxP <- ev$Define(file = "./repx.py")
pythonShell()


XRPython package:
PythonFunction(name, module)
This returns a proxy function object given the name and, optionally, the module
from which the function should be imported. A call to this function object in R
evaluates a corresponding call to the named Python function, returning (usually) a
proxy object for the result of that call. PythonFunction() is actually the generator
function for the "PythonFunction" class, a subclass of "function" with extra
information describing the Python function.
An example: The "xml" module in standard Python has a function parse()
down a few levels, in module "xml.etree.ElementTree". To create a proxy func-
tion for parse():
> parseXML <- PythonFunction("parse", "xml.etree.ElementTree")

parseXML <- PythonFunction("parse", "xml.etree.ElementTree")
parse2 <- PythonFunction("xml.etree.ElementTree.parse")
parseXML@pyArgs

the parseXML() is of Python class "ElementTree", defined in the Python module
"xml.etree.ElementTree". A proxy R class is created by:
ElementTree <- setPythonClass("ElementTree",
module = "xml.etree.ElementTree")

  > hamlet$findtext("TITLE")
[1] "The Tragedy of Hamlet, Prince of Denmark"

"ElementTree". A computation to define the "Element" proxy class could be:
> hamlet <- parse("./plays/hamlet.xml")
> Element <- setPythonClass("Element",
+
module = "xml.etree.ElementTree",
+
example = hamlet$getroot())
The output of
Element$fields()
proxy class for "Element" has been defined the fields are available:
> hamlet$getroot()$tag
[1] "PLAY"


