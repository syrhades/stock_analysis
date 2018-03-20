#========================
txt <- c("arm","foot","lefroo", "bafoobar")
txt[grepl("foo",txt)]
txt[grep("foo",txt)]

str <- "Now is the time      "
sub(" +$", "", str)  ## spaces only
## what is considered 'white space' depends on the locale.
sub("[[:space:]]+$", "", str) ## white space, POSIX-style
## what PCRE considered white space changed in version 8.34: see ?regex
sub("\\s+$", "", str, perl = TRUE) ## PCRE-style white space


## capitalizing
txt <- "a test of capitalizing"
gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", txt, perl=TRUE)
gsub("\\b(\\w)",    "\\U\\1",       txt, perl=TRUE)
txt2 <- "useRs may fly into JFK or laGuardia"
gsub("(\\w)(\\w*)(\\w)", "\\U\\1\\E\\2\\U\\3", txt2, perl=TRUE)
 sub("(\\w)(\\w*)(\\w)", "\\U\\1\\E\\2\\U\\3", txt2, perl=TRUE)

## Decompose a URL into its components.
## Example by LT (http://www.cs.uiowa.edu/~luke/R/regexp.html).
x <- "http://stat.umn.edu:80/xyz"
m <- regexec("^(([^:]+)://)?([^:/]+)(:([0-9]+))?(/.*)", x)
m
regmatches(x, m)
## Element 3 is the protocol, 4 is the host, 6 is the port, and 7
## is the path.  We can use this to make a function for extracting the
## parts of a URL:
URL_parts <- function(x) {
    m <- regexec("^(([^:]+)://)?([^:/]+)(:([0-9]+))?(/.*)", x)
    parts <- do.call(rbind,
                     lapply(regmatches(x, m), `[`, c(3L, 4L, 6L, 7L)))
    colnames(parts) <- c("protocol","host","port","path")
    parts
}
URL_parts(x)

## There is no gregexec() yet, but one can emulate it by running
## regexec() on the regmatches obtained via gregexpr().  E.g.:
pattern <- "([[:alpha:]]+)([[:digit:]]+)"
s <- "Test: A1 BC23 DEF456"
lapply(regmatches(s, gregexpr(pattern, s)), 
       function(e) regmatches(e, regexec(pattern, e)))

################################

do.call {base} R Documentation 

Execute a Function Call

Description

do.call constructs and executes a function call from a name or a function and a list of arguments to be passed to it. 

Usage
do.call(what, args, quote = FALSE, envir = parent.frame())


Arguments

what 
either a function or a non-empty character string naming the function to be called.
 
args 
a list of arguments to the function call. The names attribute of args gives the argument names.
 
quote 
a logical value indicating whether to quote the arguments.
 
envir 
an environment within which to evaluate the call. This will be most useful if what is a character string and the arguments are symbols or quoted expressions.
 

Details

If quote is FALSE, the default, then the arguments are evaluated (in the calling environment, not in envir). If quote is TRUE then each argument is quoted (see quote) so that the effect of argument evaluation is to remove the quotes – leaving the original arguments unevaluated when the call is constructed. 

The behavior of some functions, such as substitute, will not be the same for functions evaluated using do.call as if they were evaluated from the interpreter. The precise semantics are currently undefined and subject to change. 

Value

The result of the (evaluated) function call. 

Warning

This should not be used to attempt to evade restrictions on the use of .Internal and other non-API calls. 

References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole. 

See Also

call which creates an unevaluated call. 

Examples
do.call("complex", list(imag = 1:3))

## if we already have a list (e.g., a data frame)
## we need c() to add further arguments
tmp <- expand.grid(letters[1:2], 1:3, c("+", "-"))
do.call("paste", c(tmp, sep = ""))

do.call(paste, list(as.name("A"), as.name("B")), quote = TRUE)

## examples of where objects will be found.
A <- 2
f <- function(x) print(x^2)
env <- new.env()
assign("A", 10, envir = env)
assign("f", f, envir = env)
f <- function(x) print(x)
f(A)                                      # 2
do.call("f", list(A))                     # 2
do.call("f", list(A), envir = env)        # 4
do.call(f, list(A), envir = env)          # 2
do.call("f", list(quote(A)), envir = env) # 100
do.call(f, list(quote(A)), envir = env)   # 10
do.call("f", list(as.name("A")), envir = env) # 100

eval(call("f", A))                      # 2
eval(call("f", quote(A)))               # 2
eval(call("f", A), envir = env)         # 4
eval(call("f", quote(A)), envir = env)  # 100

is.call(call) #-> FALSE: Functions are NOT calls

## set up a function call to round with argument 10.5
cl <- call("round", 10.5)
is.call(cl) # TRUE
cl
## such a call can also be evaluated.
eval(cl) # [1] 10

A <- 10.5
call("round", A)        # round(10.5)
call("round", quote(A)) # round(A)
f <- "round"
call(f, quote(A))       # round(A)
## if we want to supply a function we need to use as.call or similar
f <- round
## Not run: call(f, quote(A))  # error: first arg must be character
(g <- as.call(list(f, quote(A))))
eval(g)
## alternatively but less transparently
g <- list(f, quote(A))
mode(g) <- "call"
g
eval(g)
## see also the examples in the help for do.call
#####################################
eval {base} R Documentation 

Evaluate an (Unevaluated) Expression

Description

Evaluate an R expression in a specified environment. 

Usage
eval(expr, envir = parent.frame(),
           enclos = if(is.list(envir) || is.pairlist(envir))
                       parent.frame() else baseenv())
evalq(expr, envir, enclos)
eval.parent(expr, n = 1)
local(expr, envir = new.env())


Arguments

expr 
an object to be evaluated. See ‘Details’.
 
envir 
the environment in which expr is to be evaluated. May also be NULL, a list, a data frame, a pairlist or an integer as specified to sys.call.
 
enclos 
Relevant when envir is a (pair)list or a data frame. Specifies the enclosure, i.e., where R looks for objects not found in envir. This can be NULL (interpreted as the base package environment, baseenv()) or an environment.
 
n 
number of parent generations to go back
 

Details

eval evaluates the expr argument in the environment specified by envir and returns the computed value. If envir is not specified, then the default is parent.frame() (the environment where the call to eval was made). 

Objects to be evaluated can be of types call or expression or name (when the name is looked up in the current scope and its binding is evaluated), a promise or any of the basic types such as vectors, functions and environments (which are returned unchanged). 

The evalq form is equivalent to eval(quote(expr), ...). eval evaluates its first argument in the current scope before passing it to the evaluator: evalq avoids this. 

eval.parent(expr, n) is a shorthand for eval(expr, parent.frame(n)). 

If envir is a list (such as a data frame) or pairlist, it is copied into a temporary environment (with enclosure enclos), and the temporary environment is used for evaluation. So if expr changes any of the components named in the (pair)list, the changes are lost. 

If envir is NULL it is interpreted as an empty list so no values could be found in envir and look-up goes directly to enclos. 

local evaluates an expression in a local environment. It is equivalent to evalq except that its default argument creates a new, empty environment. This is useful to create anonymous recursive functions and as a kind of limited namespace feature since variables defined in the environment are not visible from the outside. 

Value

The result of evaluating the object: for an expression vector this is the result of evaluating the last element. 

Note

Due to the difference in scoping rules, there are some differences between R and S in this area. In particular, the default enclosure in S is the global environment. 

When evaluating expressions in a data frame that has been passed as an argument to a function, the relevant enclosure is often the caller's environment, i.e., one needs eval(x, data, parent.frame()). 

References

Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole. (eval only.) 

See Also

expression, quote, sys.frame, parent.frame, environment. 

Further, force to force evaluation, typically of function arguments. 

Examples
eval(2 ^ 2 ^ 3)
mEx <- expression(2^2^3); mEx; 1 + eval(mEx)
eval({ xx <- pi; xx^2}) ; xx

a <- 3 ; aa <- 4 ; evalq(evalq(a+b+aa, list(a = 1)), list(b = 5)) # == 10
a <- 3 ; aa <- 4 ; evalq(evalq(a+b+aa, -1), list(b = 5))        # == 12

ev <- function() {
   e1 <- parent.frame()
   ## Evaluate a in e1
   aa <- eval(expression(a), e1)
   ## evaluate the expression bound to a in e1
   a <- expression(x+y)
   list(aa = aa, eval = eval(a, e1))
}
tst.ev <- function(a = 7) { x <- pi; y <- 1; ev() }
tst.ev()  #-> aa : 7,  eval : 4.14

a <- list(a = 3, b = 4)
with(a, a <- 5) # alters the copy of a from the list, discarded.

##
## Example of evalq()
##

N <- 3
env <- new.env()
assign("N", 27, envir = env)
## this version changes the visible copy of N only, since the argument
## passed to eval is '4'.
eval(N <- 4, env)
N
get("N", envir = env)
## this version does the assignment in env, and changes N only there.
evalq(N <- 5, env)
N
get("N", envir = env)


##
## Uses of local()
##

# Mutually recursive.
# gg gets value of last assignment, an anonymous version of f.

gg <- local({
    k <- function(y)f(y)
    f <- function(x) if(x) x*k(x-1) else 1
})
gg(10)
sapply(1:5, gg)

# Nesting locals: a is private storage accessible to k
gg <- local({
    k <- local({
        a <- 1
        function(y){print(a <<- a+1);f(y)}
    })
    f <- function(x) if(x) x*k(x-1) else 1
})
sapply(1:5, gg)

ls(envir = environment(gg))
ls(envir = environment(get("k", envir = environment(gg))))
################
看class 支持的method

> methods(summary)
 [1] summary.aov                    summary.aovlist*
 [3] summary.aspell*                summary.check_packages_in_dir*
 [5] summary.connection             summary.data.frame
 [7] summary.Date                   summary.default
 [9] summary.ecdf*                  summary.factor
[11] summary.glm                    summary.infl*
[13] summary.lm                     summary.loess*
[15] summary.manova                 summary.matrix
[17] summary.mlm*                   summary.nls*
[19] summary.packageStatus*         summary.PDF_Dictionary*
[21] summary.PDF_Stream*            summary.POSIXct
[23] summary.POSIXlt                summary.ppr*
[25] summary.prcomp*                summary.princomp*
[27] summary.proc_time              summary.shingle*
[29] summary.srcfile                summary.srcref
[31] summary.stepfun                summary.stl*
[33] summary.table                  summary.trellis*
[35] summary.tukeysmooth*           summary.yearmon*
[37] summary.yearqtr*               summary.zoo*
see '?methods' for accessing help and source code
> method(data.frame)
Error: could not find function "method"
> methods(data.frame)
no methods found
> methods(class = "aov")
 [1] coef         coerce       extractAIC   initialize   model.tables
 [6] print        proj         se.contrast  show         slotsFromS3
[11] summary      TukeyHSD
see '?methods' for accessing help and source code
> methods(class = "data.frame")
 [1] $             $<-           [             [[            [[<-
 [6] [<-           aggregate     anyDuplicated as.data.frame as.list
[11] as.matrix     by            cbind         coerce        dim
[16] dimnames      dimnames<-    droplevels    duplicated    edit
[21] format        formula       head          initialize    is.na
[26] Math          merge         na.contiguous na.exclude    na.omit
[31] Ops           plot          print         prompt        rbind
[36] row.names     row.names<-   rowsum        show          slotsFromS3
[41] split         split<-       stack         str           subset
[46] summary       Summary       t             tail          transform
[51] unique        unstack       within
see '?methods' for accessing help and source code
>

m <- methods("dim")       # S3 and S4 methods
print(m)
print(attr(m, "info"))    # more extensive information



require(graphics)

## Assuming the methods for plot
## are set up as in the example of help(setMethod),
## print (without definitions) the methods that involve class "track":
showMethods("plot", classes = "track")
## Not run: 
# Function "plot":
# x = ANY, y = track
# x = track, y = missing
# x = track, y = ANY

require("Matrix")
showMethods("%*%")# many!
    methods(class = "Matrix")# nothing
showMethods(class = "Matrix")# everything
showMethods(Matrix:::isDiagonal) # a non-exported generic

## End(Not run)



if(no4 <- is.na(match("stats4", loadedNamespaces())))
   loadNamespace("stats4")
showMethods(classes = "mle") # -> a method for show()
if(no4) unloadNamespace("stats4")


Usage
showMethods(f = character(), where = topenv(parent.frame()),
            classes = NULL, includeDefs = FALSE,
            inherited = !includeDefs,
            showEmpty, printTo = stdout(), fdef)
.S4methods(generic.function, class)


Arguments

f 
one or more function names. If omitted, all functions will be shown that match the other arguments. 

The argument can also be an expression that evaluates to a single generic function, in which case argument fdef is ignored. Providing an expression for the function allows examination of hidden or anonymous functions; see the example for isDiagonal().
 
where 
Where to find the generic function, if not supplied as an argument. When f is missing, or length 0, this also determines which generic functions to examine. If where is supplied, only the generic functions returned by getGenerics(where) are eligible for printing. If where is also missing, all the cached generic functions are considered.
 
classes 
If argument classes is supplied, it is a vector of class names that restricts the displayed results to those methods whose signatures include one or more of those classes.
 
includeDefs 
If includeDefs is TRUE, include the definitions of the individual methods in the printout.
 
inherited 
logical indicating if methods that have been found by inheritance, so far in the session, will be included and marked as inherited. Note that an inherited method will not usually appear until it has been used in this session. See selectMethod if you want to know what method would be dispatched for particular classes of arguments.
 
showEmpty 
logical indicating whether methods with no defined methods matching the other criteria should be shown at all. By default, TRUE if and only if argument f is not missing.
 
printTo 
The connection on which the information will be shown; by default, on standard output.
 
fdef 
Optionally, the generic function definition to use; if missing, one is found, looking in where if that is specified. See also comment in ‘Details’.
 
generic.function, class 
See methods.
 

Details

See methods for a description of .S4methods. 

The name and package of the generic are followed by the list of signatures for which methods are currently defined, according to the criteria determined by the various arguments. Note that the package refers to the source of the generic function. Individual methods for that generic can come from other packages as well. 

When more than one generic function is involved, either as specified or because f was missing, the functions are found and showMethods is recalled for each, including the generic as the argument fdef. In complicated situations, this can avoid some anomalous results. 

Value

If printTo is FALSE, the character vector that would have been printed is returned; otherwise the value is the connection or filename, via invisible. 


GenericFunctions {methods} R Documentation 

Tools for Managing Generic Functions

Description

The functions documented here manage collections of methods associated with a generic function, as well as providing information about the generic functions themselves. 

Usage
isGeneric(f, where, fdef, getName = FALSE)
isGroup(f, where, fdef)
removeGeneric(f, where)

dumpMethod(f, signature, file, where, def)
findFunction(f, generic = TRUE, where = topenv(parent.frame()))
dumpMethods(f, file, signature, methods, where)
signature(...)

removeMethods(f, where = topenv(parent.frame()), all = missing(where))

setReplaceMethod(f, ..., where = topenv(parent.frame()))

getGenerics(where, searchForm = FALSE)


Arguments

f 
The character string naming the function. 
 
where 
The environment, namespace, or search-list position from which to search for objects. By default, start at the top-level environment of the calling function, typically the global environment (i.e., use the search list), or the namespace of a package from which the call came. It is important to supply this argument when calling any of these functions indirectly. With package namespaces, the default is likely to be wrong in such calls.
 
signature 
The class signature of the relevant method. A signature is a named or unnamed vector of character strings. If named, the names must be formal argument names for the generic function. Signatures are matched to the arguments specified in the signature slot of the generic function (see the Details section of the setMethod documentation). 

The signature argument to dumpMethods is ignored (it was used internally in previous implementations).
 
file 
The file or connection on which to dump method definitions. 
 
def 
The function object defining the method; if omitted, the current method definition corresponding to the signature. 
 
... 
Named or unnamed arguments to form a signature.
 
generic 
In testing or finding functions, should generic functions be included. Supply as FALSE to get only non-generic functions.
 
fdef 
Optional, the generic function definition. 

Usually omitted in calls to isGeneric
 
getName 
If TRUE, isGeneric returns the name of
 the generic. By default, it returns TRUE.  
methods 
The methods object containing the methods to be dumped. By default, the methods defined for this generic (optionally on the specified where location). 
 
all 
in removeMethods, logical indicating if all (default) or only the first method found should be removed.
 
searchForm 
In getGenerics, if TRUE, the package slot of the returned result is in the form used by search(), otherwise as the simple package name (e.g, "package:base" vs "base"). 
 

Summary of Functions
isGeneric:
Is there a function named f, and if so, is it a generic? 

The getName argument allows a function to find the name from a function definition. If it is TRUE then the name of the generic is returned, or FALSE if this is not a generic function definition. 

The behavior of isGeneric and getGeneric for primitive functions is slightly different. These functions don't exist as formal function objects (for efficiency and historical reasons), regardless of whether methods have been defined for them. A call to isGeneric tells you whether methods have been defined for this primitive function, anywhere in the current search list, or in the specified position where. In contrast, a call to getGeneric will return what the generic for that function would be, even if no methods have been currently defined for it. 
removeGeneric, removeMethods:
Remove all the methods for the generic function of this name. In addition, removeGeneric removes the function itself; removeMethods restores the non-generic function which was the default method. If there was no default method, removeMethods leaves a generic function with no methods. 
standardGeneric:
Dispatches a method from the current function call for the generic function f. It is an error to call standardGeneric anywhere except in the body of the corresponding generic function. 

Note that standardGeneric is a primitive function in the base package for efficiency reasons, but rather documented here where it belongs naturally. 
dumpMethod:
Dump the method for this generic function and signature. 
findFunction:
return a list of either the positions on the search list, or the current top-level environment, on which a function object for name exists. The returned value is always a list, use the first element to access the first visible version of the function. See the example. 

NOTE: Use this rather than find with mode="function", which is not as meaningful, and has a few subtle bugs from its use of regular expressions. Also, findFunction works correctly in the code for a package when attaching the package via a call to library. 
dumpMethods:
Dump all the methods for this generic. 
signature:
Returns a named list of classes to be matched to arguments of a generic function. 
getGenerics:
returns the names of the generic functions that have methods defined on where; this argument can be an environment or an index into the search list. By default, the whole search list is used. 

The methods definitions are stored with package qualifiers; for example, methods for function "initialize" might refer to two different functions of that name, on different packages. The package names corresponding to the method list object are contained in the slot package of the returned object. The form of the returned name can be plain (e.g., "base"), or in the form used in the search list ("package:base") according to the value of searchForm

Details
setGeneric:
If there is already a non-generic function of this name, it will be used to define the generic unless def is supplied, and the current function will become the default method for the generic. 

If def is supplied, this defines the generic function, and no default method will exist (often a good feature, if the function should only be available for a meaningful subset of all objects). 

Arguments group and valueClass are retained for consistency with S-Plus, but are currently not used. 
isGeneric:
If the fdef argument is supplied, take this as the definition of the generic, and test whether it is really a generic, with f as the name of the generic. (This argument is not available in S-Plus.) 
removeGeneric:
If where supplied, just remove the version on this element of the search list; otherwise, removes the first version encountered. 
standardGeneric:
Generic functions should usually have a call to standardGeneric as their entire body. They can, however, do any other computations as well. 

The usual setGeneric (directly or through calling setMethod) creates a function with a call to standardGeneric. 
dumpMethod:
The resulting source file will recreate the method. 
findFunction:
If generic is FALSE, ignore generic functions. 
dumpMethods:
If signature is supplied only the methods matching this initial signature are dumped. (This feature is not found in S-Plus: don't use it if you want compatibility.) 
signature:
The advantage of using signature is to provide a check on which arguments you meant, as well as clearer documentation in your method specification. In addition, signature checks that each of the elements is a single character string. 
removeMethods:
Returns TRUE if f was a generic function, FALSE (silently) otherwise. 

If there is a default method, the function will be re-assigned as a simple function with this definition. Otherwise, the generic function remains but with no methods (so any call to it will generate an error). In either case, a following call to setMethod will consistently re-establish the same generic function as before. 

References

Chambers, John M. (2008) Software for Data Analysis: Programming with R Springer. (For the R version.) 

Chambers, John M. (1998) Programming with Data Springer (For the original S4 version.) 

See Also

getMethod (also for selectMethod), setGeneric, setClass, showMethods 

Examples
require(stats) # for lm

## get the function "myFun" -- throw an error if 0 or > 1 versions visible:
findFuncStrict <- function(fName) {
  allF <- findFunction(fName)
  if(length(allF) == 0)
    stop("No versions of ",fName," visible")
  else if(length(allF) > 1)
    stop(fName," is ambiguous: ", length(allF), " versions")
  else
    get(fName, allF[[1]])
}

try(findFuncStrict("myFun"))# Error: no version
lm <- function(x) x+1
try(findFuncStrict("lm"))#    Error: 2 versions
findFuncStrict("findFuncStrict")# just 1 version
rm(lm)



## method dumping ------------------------------------

setClass("A", representation(a="numeric"))
setMethod("plot", "A", function(x,y,...){ cat("A meth\n") })
dumpMethod("plot","A", file="")
## Not run: 
setMethod("plot", "A",
function (x, y, ...)
{
    cat("AAAAA\n")
}
)

## End(Not run)
tmp <- tempfile()
dumpMethod("plot","A", file=tmp)
## now remove, and see if we can parse the dump
stopifnot(removeMethod("plot", "A"))
source(tmp)
stopifnot(is(getMethod("plot", "A"), "MethodDefinition"))

## same with dumpMethods() :
setClass("B", contains="A")
setMethod("plot", "B", function(x,y,...){ cat("B ...\n") })
dumpMethods("plot", file=tmp)
stopifnot(removeMethod("plot", "A"),
          removeMethod("plot", "B"))
source(tmp)
stopifnot(is(getMethod("plot", "A"), "MethodDefinition"),
          is(getMethod("plot", "B"), "MethodDefinition"))

apropos {utils} R Documentation 

Find Objects by (Partial) Name

Description

apropos() returns a character vector giving the names of all objects in the search list matching what. 

find() is a different user interface to the same task. 

Usage
apropos(what, where = FALSE, ignore.case = TRUE, mode = "any")

find(what, mode = "any", numeric = FALSE, simple.words = TRUE)


Arguments

what 
character string with name of an object, or more generally a regular expression to match against.
 
where, numeric 
a logical indicating whether positions in the search list should also be returned
 
ignore.case 
logical indicating if the search should be case-insensitive, TRUE by default. Note that in R versions prior to 2.5.0, the default was implicitly ignore.case = FALSE.
 
mode 
character; if not "any", only objects whose mode equals mode are searched.
 
simple.words 
logical; if TRUE, the what argument is only searched as whole word.
 

Details

If mode != "any" only those objects which are of mode mode are considered. If where is TRUE, the positions in the search list are returned as the names attribute. 

find is a different user interface for the same task as apropos. However, by default (simple.words == TRUE), only full words are searched with grep(fixed = TRUE). 

Value

For apropos character vector, sorted by name, possibly with names giving the (numerical) positions on the search path. 

For find, either a character vector of environment names, or for numeric = TRUE, a numerical vector of positions on the search path, with names giving the names of the corresponding environments. 

Author(s)

Kurt Hornik and Martin Maechler (May 1997).

See Also

glob2rx to convert wildcard patterns to regular expressions. 

objects for listing objects from one place, help.search for searching the help system, search for the search path. 

Examples
require(stats)


## Not run: apropos("lm")
apropos("GLM")                      # more than a dozen
## that may include internal objects starting '.__C__' if
## methods is attached
apropos("GLM", ignore.case = FALSE) # not one
apropos("lq")

cor <- 1:pi
find("cor")                         #> ".GlobalEnv"   "package:stats"
find("cor", numeric = TRUE)                     # numbers with these names
find("cor", numeric = TRUE, mode = "function")  # only the second one
rm(cor)

## Not run: apropos(".", mode="list")  # a long list

# need a DOUBLE backslash '\\' (in case you don't see it anymore)
apropos("\\[")

# everything % not diff-able
length(apropos("."))

# those starting with 'pr'
apropos("^pr")

# the 1-letter things
apropos("^.$")
# the 1-2-letter things
apropos("^..?$")
# the 2-to-4 letter things
apropos("^.{2,4}$")

# the 8-and-more letter things
apropos("^.{8,}$")
table(nchar(apropos("^.{8,}$")))

#############
## this example will not work correctly in example(try), but
## it does work correctly if pasted in
options(show.error.messages = FALSE)
try(log("a"))
print(.Last.value)
options(show.error.messages = TRUE)

## alternatively,
print(try(log("a"), TRUE))

## run a simulation, keep only the results that worked.
set.seed(123)
x <- stats::rnorm(50)
doit <- function(x)
{
    x <- sample(x, replace = TRUE)
    if(length(unique(x)) > 30) mean(x)
    else stop("too few unique points")
}
## alternative 1
res <- lapply(1:100, function(i) try(doit(x), TRUE))
## alternative 2
## Not run: res <- vector("list", 100)
for(i in 1:100) res[[i]] <- try(doit(x), TRUE)
## End(Not run)
unlist(res[sapply(res, function(x) !inherits(x, "try-error"))])

mm <-  findMethods("Ops")
findMethodSignatures(methods = mm)
############################

packageDescription("stats")
x <- read.dcf(file = system.file("DESCRIPTION", package = "splines"),
              fields = c("Package", "Version", "Title"))
#################
regex {base} R Documentation 

Regular Expressions as used in R

Description

This help page documents the regular expression patterns supported by grep and related functions grepl, regexpr, gregexpr, sub and gsub, as well as by strsplit. 

Details

A ‘regular expression’ is a pattern that describes a set of strings. Two types of regular expressions are used in R, extended regular expressions (the default) and Perl-like regular expressions used by perl = TRUE. There is a also fixed = TRUE which can be considered to use a literal regular expression. 

Other functions which use regular expressions (often via the use of grep) include apropos, browseEnv, help.search, list.files and ls. These will all use extended regular expressions. 

Patterns are described here as they would be printed by cat: (do remember that backslashes need to be doubled when entering R character strings, e.g. from the keyboard). 

Long regular expressions may or may not be accepted: the POSIX standard only requires up to 256 bytes. 

Extended Regular Expressions

This section covers the regular expressions allowed in the default mode of grep, regexpr, gregexpr, sub, gsub and strsplit. They use an implementation of the POSIX 1003.2 standard: that allows some scope for interpretation and the interpretations here are those currently used by R. The implementation supports some extensions to the standard. 

Regular expressions are constructed analogously to arithmetic expressions, by using various operators to combine smaller expressions. The whole expression matches zero or more characters (read ‘character’ as ‘byte’ if useBytes = TRUE). 

The fundamental building blocks are the regular expressions that match a single character. Most characters, including all letters and digits, are regular expressions that match themselves. Any metacharacter with special meaning may be quoted by preceding it with a backslash. The metacharacters in extended regular expressions are . \ | ( ) [ { ^ $ * + ?, but note that whether these have a special meaning depends on the context. 

Escaping non-metacharacters with a backslash is implementation-dependent. The current implementation interprets \a as BEL, \e as ESC, \f as FF, \n as LF, \r as CR and \t as TAB. (Note that these will be interpreted by R's parser in literal character strings.) 

A character class is a list of characters enclosed between [ and ] which matches any single character in that list; unless the first character of the list is the caret ^, when it matches any character not in the list. For example, the regular expression [0123456789] matches any single digit, and [^abc] matches anything except the characters a, b or c. A range of characters may be specified by giving the first and last characters, separated by a hyphen. (Because their interpretation is locale- and implementation-dependent, character ranges are best avoided.) The only portable way to specify all ASCII letters is to list them all as the character class
[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz].
 (The current implementation uses numerical order of the encoding.) 

Certain named classes of characters are predefined. Their interpretation depends on the locale (see locales); the interpretation below is that of the POSIX locale. 
[:alnum:]
Alphanumeric characters: [:alpha:] and [:digit:].
[:alpha:]
Alphabetic characters: [:lower:] and [:upper:].
[:blank:]
Blank characters: space and tab, and possibly other locale-dependent characters such as non-breaking space.
[:cntrl:]
Control characters. In ASCII, these characters have octal codes 000 through 037, and 177 (DEL). In another character set, these are the equivalent characters, if any.
[:digit:]
Digits: 0 1 2 3 4 5 6 7 8 9.
[:graph:]
Graphical characters: [:alnum:] and [:punct:].
[:lower:]
Lower-case letters in the current locale.
[:print:]
Printable characters: [:alnum:], [:punct:] and space.
[:punct:]
Punctuation characters:
! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.
[:space:]
Space characters: tab, newline, vertical tab, form feed, carriage return, space and possibly other locale-dependent characters.
[:upper:]
Upper-case letters in the current locale.
[:xdigit:]
Hexadecimal digits:
0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f.

For example, [[:alnum:]] means [0-9A-Za-z], except the latter depends upon the locale and the character encoding, whereas the former is independent of locale and character set. (Note that the brackets in these class names are part of the symbolic names, and must be included in addition to the brackets delimiting the bracket list.) Most metacharacters lose their special meaning inside a character class. To include a literal ], place it first in the list. Similarly, to include a literal ^, place it anywhere but first. Finally, to include a literal -, place it first or last (or, for perl = TRUE only, precede it by a backslash). (Only ^ - \ ] are special inside character classes.) 

The period . matches any single character. The symbol \w matches a ‘word’ character (a synonym for [[:alnum:]_], an extension) and \W is its negation ([^[:alnum:]_]). Symbols \d, \s, \D and \S denote the digit and space classes and their negations (these are all extensions). 

The caret ^ and the dollar sign $ are metacharacters that respectively match the empty string at the beginning and end of a line. The symbols \< and \> match the empty string at the beginning and end of a word. The symbol \b matches the empty string at either edge of a word, and \B matches the empty string provided it is not at an edge of a word. (The interpretation of ‘word’ depends on the locale and implementation: these are all extensions.) 

A regular expression may be followed by one of several repetition quantifiers: 
?
The preceding item is optional and will be matched at most once.
*
The preceding item will be matched zero or more times.
+
The preceding item will be matched one or more times.
{n}
The preceding item is matched exactly n times.
{n,}
The preceding item is matched n or more times.
{n,m}
The preceding item is matched at least n times, but not more than m times.

By default repetition is greedy, so the maximal possible number of repeats is used. This can be changed to ‘minimal’ by appending ? to the quantifier. (There are further quantifiers that allow approximate matching: see the TRE documentation.) 

Regular expressions may be concatenated; the resulting regular expression matches any string formed by concatenating the substrings that match the concatenated subexpressions. 

Two regular expressions may be joined by the infix operator |; the resulting regular expression matches any string matching either subexpression. For example, abba|cde matches either the string abba or the string cde. Note that alternation does not work inside character classes, where | has its literal meaning. 

Repetition takes precedence over concatenation, which in turn takes precedence over alternation. A whole subexpression may be enclosed in parentheses to override these precedence rules. 

The backreference \N, where N = 1 ... 9, matches the substring previously matched by the Nth parenthesized subexpression of the regular expression. (This is an extension for extended regular expressions: POSIX defines them only for basic ones.) 

Perl-like Regular Expressions

The perl = TRUE argument to grep, regexpr, gregexpr, sub, gsub and strsplit switches to the PCRE library that implements regular expression pattern matching using the same syntax and semantics as Perl 5.x, with just a few differences. 

For complete details please consult the man pages for PCRE (and not PCRE2), especially man pcrepattern and man pcreapi), on your system or from the sources at http://www.pcre.org. If PCRE support was compiled from the sources within R (the default), the PCRE version is 8.37 as described here. (The version in use can be found by calling extSoftVersion.) 

Perl regular expressions can be computed byte-by-byte or (UTF-8) character-by-character: the latter is used in all multibyte locales and if any of the inputs are marked as UTF-8 (see Encoding). 

All the regular expressions described for extended regular expressions are accepted except \< and \>: in Perl all backslashed metacharacters are alphanumeric and backslashed symbols always are interpreted as a literal character. { is not special if it would be the start of an invalid interval specification. There can be more than 9 backreferences (but the replacement in sub can only refer to the first 9). 

Character ranges are interpreted in the numerical order of the characters, either as bytes in a single-byte locale or as Unicode code points in UTF-8 mode. So in either case [A-Za-z] specifies the set of ASCII letters. 

In UTF-8 mode the named character classes only match ASCII characters: see \p below for an alternative. 

The construct (?...) is used for Perl extensions in a variety of ways depending on what immediately follows the ?. 

Perl-like matching can work in several modes, set by the options (?i) (caseless, equivalent to Perl's /i), (?m) (multiline, equivalent to Perl's /m), (?s) (single line, so a dot matches all characters, even new lines: equivalent to Perl's /s) and (?x) (extended, whitespace data characters are ignored unless escaped and comments are allowed: equivalent to Perl's /x). These can be concatenated, so for example, (?im) sets caseless multiline matching. It is also possible to unset these options by preceding the letter with a hyphen, and to combine setting and unsetting such as (?im-sx). These settings can be applied within patterns, and then apply to the remainder of the pattern. Additional options not in Perl include (?U) to set ‘ungreedy’ mode (so matching is minimal unless ? is used as part of the repetition quantifier, when it is greedy). Initially none of these options are set. 

If you want to remove the special meaning from a sequence of characters, you can do so by putting them between \Q and \E. This is different from Perl in that $ and @ are handled as literals in \Q...\E sequences in PCRE, whereas in Perl, $ and @ cause variable interpolation. 

The escape sequences \d, \s and \w represent any decimal digit, space character and ‘word’ character (letter, digit or underscore in the current locale: in UTF-8 mode only ASCII letters and digits are considered) respectively, and their upper-case versions represent their negation. Vertical tab was not regarded as a space character in a C locale before PCRE 8.34 (included in R 3.0.3). Sequences \h, \v, \H and \V match horizontal and vertical space or the negation. (In UTF-8 mode, these do match non-ASCII Unicode code points.) 

There are additional escape sequences: \cx is cntrl-x for any x, \ddd is the octal character (for up to three digits unless interpretable as a backreference, as \1 to \7 always are), and \xhh specifies a character by two hex digits. In a UTF-8 locale, \x{h...} specifies a Unicode code point by one or more hex digits. (Note that some of these will be interpreted by R's parser in literal character strings.) 

Outside a character class, \A matches at the start of a subject (even in multiline mode, unlike ^), \Z matches at the end of a subject or before a newline at the end, \z matches only at end of a subject. and \G matches at first matching position in a subject (which is subtly different from Perl's end of the previous match). \C matches a single byte, including a newline, but its use is warned against. In UTF-8 mode, \R matches any Unicode newline character (not just CR), and \X matches any number of Unicode characters that form an extended Unicode sequence. 

In UTF-8 mode, some Unicode properties may be supported via \p{xx} and \P{xx} which match characters with and without property xx respectively. For a list of supported properties see the PCRE documentation, but for example Lu is ‘upper case letter’ and Sc is ‘currency symbol’. (This support depends on the PCRE library being compiled with ‘Unicode property support’: an external library might not be. It can be checked via pcre_config.) 

The sequence (?# marks the start of a comment which continues up to the next closing parenthesis. Nested parentheses are not permitted. The characters that make up a comment play no part at all in the pattern matching. 

If the extended option is set, an unescaped # character outside a character class introduces a comment that continues up to the next newline character in the pattern. 

The pattern (?:...) groups characters just as parentheses do but does not make a backreference. 

Patterns (?=...) and (?!...) are zero-width positive and negative lookahead assertions: they match if an attempt to match the ... forward from the current position would succeed (or not), but use up no characters in the string being processed. Patterns (?<=...) and (?<!...) are the lookbehind equivalents: they do not allow repetition quantifiers nor \C in .... 

regexpr and gregexpr support ‘named capture’. If groups are named, e.g., "(?<first>[A-Z][a-z]+)" then the positions of the matches are also returned by name. (Named backreferences are not supported by sub.) 

Atomic grouping, possessive qualifiers and conditional and recursive patterns are not covered here. 

Author(s)

This help page is based on the TRE documentation and the POSIX standard, and the pcrepattern man page from PCRE 8.36. 

See Also

grep, apropos, browseEnv, glob2rx, help.search, list.files, ls and strsplit. 

The TRE documentation at http://laurikari.net/tre/documentation/regex-syntax/). 

The POSIX 1003.2 standard at http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html 

The pcrepattern man page (found as part of http://www.pcre.org/original/pcre.txt), and details of Perl's own implementation at http://perldoc.perl.org/perlre.html. 


[Package base version 3.2.3 Index]

