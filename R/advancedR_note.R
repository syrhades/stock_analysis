
x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
#> List of 2
#> $ :List of 2
#> ..$ : num 1
#> ..$ : num 2
#> $ : num [1:2] 3 4
str(y)
#> List of 4
#> $ : num 1
#> $ : num 2
#> $ : num 3
#> $ : num 4

• During creation: x <- c(a = 1, b = 2, c = 3)
• By modifying a vector in place: x <- 1:3; names(x) <- c("a", "b",
"c")
• By creating a modified vector: x <- setNames(1:3, c("a", "b", "c"))


x <- factor(c("a", "b", "b", "a"))
x
#> [1] a b b a
#> Levels: a b
class(x)
#> [1] "factor"
levels(x)
#> [1] "a" "b"

gsub
grepl
nchar


z <- factor(c(12, 1, 9))
# Oops, that's not right
as.numeric(z)
#> [1] 3 1 2
# Perfect :)
as.numeric(as.character(z))
#> [1] 12 1 9
z<- factor(c("a","b","c"))
as.character(z)

options(stringsAsFactors = FALSE)

length(a)
#> [1] 6
nrow(a)
#> [1] 2
ncol(a)
#> [1] 3
rownames(a) <- c("A", "B")
colnames(a) <- c("a", "b", "c")
a
#> a b c
#> A 1 3 5
#> B 2 4 6
length(b)
#> [1] 12
dim(b)
#> [1] 2 3 2
dimnames(b) <- list(c("one", "two"), c("a", "b", "c"), c("A", "B"))
b
typeof(df)
#> [1] "list"
class(df)
#> [1] "data.frame"
is.data.frame(df)
#> [1] TRUE
plyr::rbind.fill()

dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))
str(dfl)


dfm <- data.frame(x = 1:3, y = I(matrix(1:9, nrow = 3)))
dfm <- data.frame(x = I(1:3), y = I(matrix(1:9, nrow = 3)))
str(dfm)
#> 'data.frame': 3 obs. of 2 variables:
#> $ x: int 1 2 3
#> $ y: 'AsIs' int [1:3, 1:3] 1 2 3 4 5 6 7 8 9
dfm[2, "y"]
#> [,1] [,2] [,3]
#> [1,] 2 5 8

(y <- setNames(x, letters[1:4]))
(vals <- outer(1:5, 1:5, FUN = "paste", sep = ","))

function (FUN, descend = TRUE)
{
    if (is.function(FUN))
        return(FUN)
    if (!(is.character(FUN) && length(FUN) == 1L || is.symbol(FUN))) {
        FUN <- eval.parent(substitute(substitute(FUN)))
        if (!is.symbol(FUN))
            stop(gettextf("'%s' is not a function, character or symbol",
                deparse(FUN)), domain = NA)
    }
    envir <- parent.frame(2)
    if (descend)
        FUN <- get(as.character(FUN), mode = "function", envir = envir)
    else {
        FUN <- get(as.character(FUN), mode = "any", envir = envir)
        if (!is.function(FUN))
            stop(gettextf("found non-function '%s'", FUN), domain = NA)
    }
    return(FUN)
}

mtcars[[1]], mtcars[["cyl"]]


Simplifying Preserving
Vector x[[1]] x[1]
List x[[1]] x[1]
Factor x[1:4, drop = T] x[1:4]
Array x[1, ], x[, 1] x[1, , drop = F], x[, 1, drop = F]
Data frame x[, 1], x[[1]] x[, 1, drop = F], x[1]


env1<-new.env()
ls('env1')

parent.env('env1')
emptyenv
1. Empty environment – ultimate ancestor of
all environments
• Parent: none
• Access with: emptyenv()
2. Base environment - environment of the
base package
• Parent: empty environment
• Access with: baseenv()
3. Global environment – the interactive
workspace that you normally work in
• Parent: environment of last attached
package
• Access with: globalenv()
4. Current environment – environment that
R is currently working in (may be any of the
above and others)
• Parent: empty environment
• Access with: environment()

search()
 search()
[1] ".GlobalEnv"          "package:DBI"         "package:rCharts"
[4] "package:bindrcpp"    "package:grid"        "package:Quandl"
[7] "package:fBasics"     "package:timeSeries"  "package:timeDate"
10] "package:hwriter"     "package:stringi"     "package:devtools"
13] "package:htmlTable"   "package:data.table"  "package:scales"
16] "package:quantmod"    "package:TTR"         "package:htmlwidgets"
19] "package:rlist"       "package:recharts"    "package:magrittr"
22] "package:DiagrammeR"  "package:stringr"     "package:formattable"
25] "package:lattice"     "package:dygraphs"    "package:jsonlite"
28] "package:pryr"        "package:functional"  "package:foreach"
31] "package:DT"          "package:highcharter" "package:xlsx"
34] "package:xlsxjars"    "package:rJava"       "package:purrr"
37] "package:readr"       "package:tidyr"       "package:tibble"
40] "package:ggplot2"     "package:tidyverse"   "package:sqldf"
43] "package:RSQLite"     "package:gsubfn"      "package:proto"
46] "package:XML"         "package:xts"         "package:zoo"
49] "package:R6"          "package:lubridate"   "package:htmltools"
52] "package:plyr"        "package:dplyr"       "package:RCurl"
55] "package:bitops"      "package:stats"       "package:graphics"
58] "package:grDevices"   "package:utils"       "package:datasets"
61] "package:methods"     "Autoloads"           "package:base"


<<- (Deep assignment arrow) - modifies an existing variable
found by walking up the parent environments
Warning: If <<- doesn’t find an existing variable, it will create
one in the global environment.


environment(‘func1’)

y <- 1
e <- new.env()
e$g <- function(x) x + y

 pryr::where(g)

 x <- 1
where("x")
where("t.test")
where("mean")
where("where")

stringAsFactors = False
3. Useful ‘Generic’ Operations
• Get all methods that belong to the ‘mean’
generic:
- Methods(‘mean’)
• List all generics that have a method for the
‘Date’ class :
- methods(class = ‘Date’)

4. S3 objects are usually built on top of lists, or
atomic vectors with attributes.
• Factor and data frame are S3 class
• Useful operations:
Check if object is
an S3 object
is.object(x) & !isS4(x) or
pryr::otype()
Check if object
inherits from a
specific class
inherits(x, 'classname')
Determine class of
any object class(x)


Functions – objects in their own right
All R functions have three parts:
Every operation is a function call
• +, for, if, [, $, { …
• x + y is the same as `+`(x, y)
body() code inside the function
formals()
list of arguments which
controls how you can
call the function
environment()
“map” of the location of
the function’s variables
(see “Enclosing
Environment”)
Note: the backtick (`), lets you refer to
functions or variables that have
otherwise reserved or illegal names.

What is Lexical Scoping?
• Looks up value of a symbol. (see
"Enclosing Environment")
• findGlobals() - lists all the external
dependencies of a function
f <- function() x + 1
codetools::findGlobals(f)
> '+' 'x'
environment(f) <- emptyenv()
f()
# error in f(): could not find function “+”
 R relies on lexical scoping to find
everything, even the + operator.


Check if an argument was supplied : missing()
3. Lazy evaluation – since x is not used stop("This is an error!")
never get evaluated.
4. Force evaluation
5. Default arguments evaluation
body() code inside the function
formals()
list of arguments which
controls how you can
call the function
environment()
“map” of the location of
the function’s variables
(see “Enclosing
Environment”)
Lexical Scoping
f <- function() x + 1
codetools::findGlobals(f)
> '+' 'x'
environment(f) <- emptyenv()
f()
# error in f(): could not find function “+”
f <- function(x = ls()) {
a <- 1
x
}
f() -> 'a' 'x' ls() evaluated inside f
f(ls()) ls() evaluated in global environment

call_fun <- function(f, ...) f(...)
f <- list(sum, mean, median, sd)
lapply(f, call_fun, x = runif(1e3))


fapply <- function(fs, ...) {
out <- vector("list", length(fs))
for (i in seq_along(fs)) {
out[[i]] <- fs[[i]](...)
}
out
}
fapply(f, x = runif(1e3))

str(Filter(is.factor, iris))
where(iris, is.factor)
str(Find(is.factor, iris))
Position(is.factor, iris)

compact <- function(x) Filter(function(y) !is.null(y), x)
Sys.delay(1)

Sys.sleep(delay)

ignore <- function(...) NULL
tee <- function(f, on_input = ignore, on_output = ignore) {
function(...) {
input <- if (nargs() == 1) c(...) else list(...)
on_input(input)
output <- f(...)
on_output(output)
output
}
}


plyr::failwith() turns a function that throws an error into a function that
returns a default value when there’s an error. Again, the essence of failwith()
is simple, it’s just a wrapper around try(), which captures errors and continues
execution. (if you haven’t seen try() before, it’s discussed in more detail in the
exceptions and debugging 5 chapter):
failwith <- function(default = NULL, f, quiet = FALSE) {
function(...) {
out <- default
try(out <- f(...), silent = quiet)
out
}
}


capture.output(sd)

base::Vectorize converts a scalar function to a vector function.

splat converts a function that takes multiple arguments to a function
that takes a single list of arguments.
splat <- function (f) {
function(args) {
do.call(f, args)
}
}


x <- c(NA, runif(100), 1000)
args <- list(
list(x),
list(x, na.rm = TRUE),
list(x, na.rm = TRUE, trim = 0.1)
)
lapply(args, splat(mean))
#> [[1]]
#> [1] NA
#>
#> [[2]]
#> [1] 10.38
#>
#> [[3]]
#> [1] 0.4897

summaries <- plyr::each(mean, sd, median)
summaries(1:10)
#>
mean
sd median
#> 5.500 3.028 5.500

• plyr::colwise() converts a vector function to one that works with data
frames:
median(mtcars)
#> Error: need numeric data
median(mtcars$mpg)
#> [1] 19.2
plyr::colwise(median)(mtcars)
#>
mpg cyl disp hp drat
wt qsec vs am gear carb
#> 1 19.2
6 196.3 123 3.695 3.325 17.71 0 0
4
2



x_call <- quote(1:10)
mean_call <- as.call(list(quote(mean), x_call))
identical(mean_call, quote(mean(1:10)))
#> [1] TRUE


frm_get_function_name<-function(...){
  # enquote(eval(substitute(fn)))%>% as.character
  # enquote(fn)%>% as.character
  # assign("x",fn)

  # pryr::subs(a,list(a=substitute(fn))) %>% as.character
  # deparse(substitute(fn))
  sys.call() #%>% as.character
  # substitute(fn) %>% as.character
  # quote() %>% as.character
}
frm_get_function_name(sd,mean)
# vrep <- Vectorize(frm_get_function_name)
# vrep(c(mean,sd) )
c(mean,sd) %>% llply(frm_get_function_name)

frm_get_function_name(mean,sd)
pryr::subs(a+b,list=(a="y"))


a <- call("print", Sys.time())
b <- call("print", quote(Sys.time()))
eval(a); Sys.sleep(1); eval(a)
#> [1] "2013-12-22 20:23:12 CST"
#> [1] "2013-12-22 20:23:12 CST"
eval(b); Sys.sleep(1); eval(b)
#> [1] "2013-12-22 20:23:13 CST"
#> [1] "2013-12-22 20:23:14 CST"


`mode2<-` <- function (x, value) {
mde <- paste0("as.", value)
eval(call(mde, x), parent.frame())
}
x <- 1:10
mode2(x) <- "character"
x
#> [1] "1" "2" "3" "4" "5" "6"
"7"
"8"
"9"
"10"

`mode3<-` <- function(x, value) {
mde <- match.fun(paste0("as.", value))
mde(x)
}
x <- 1:10
mode3(x) <- "character"
x
#> [1] "1" "2" "3" "4" "5" "6" "7"
"8"
"9"
"10"

  msg <- "old"
     delayedAssign("x", msg)
     substitute(x) # shows only 'x', as it is in the global env.
     msg <- "new!"
     x # new!
dots <- function(...) {
eval(substitute(alist(...)))
}


x <- quote(read.csv("important.csv", row.names = FALSE))
y <- match.call(read.csv, x)
match.call(eval(x[[1]]), x) %>%names

deparse(z)
z <- quote(y <- x * 10)
deparse(z)
#> [1] "y <- x * 10"
parse(text = deparse(z))


f <- function(fn) {
list(sys = sys.call()[[2]], match = match.call())
}
f(sd)$sys