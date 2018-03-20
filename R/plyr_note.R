library(help="methods")
library(help="plyr")

file_name<-"E:\\plyr-tutorial\\examples\\bnames.csv"
bnames<-read.csv(file_name,head=TRUE)

one <- subset(bnames, sex == "boy" & year == 2008)
one$rank <- rank(-one$percent,
 ties.method = "first")
 
 
 bnames2 <- ddply(bnames, c("sex", "year"), transform,
 rank = rank(-percent, ties.method = "first"))
 
 
 Variable specification
syntax
• Character: c("sex", "year")
• Numeric: 1:3
• Formula: ~ sex + year
• Special:
• .(sex, year)
• .(first = letter(name, 1))

fl <- ddply(bnames, c("year", "sex", "first"),
 summarise, tot = sum(percent))
library(ggplot2)
qplot(year, tot, data = fl, geom = "line",
 colour = sex, facets = ~ first)
 
 
 ################R in nutshell###################
getOption("defaultPackages")
(.packages())

library(rpart)
(.packages(all.available=TRUE))
 [1] "KernSmooth" "MASS" "base" "bitops" "boot"
 [6] "class" "cluster" "codetools" "datasets" "foreign"
[11] "grDevices" "graphics" "grid" "hexbin" "lattice"
[16] "maps" "methods" "mgcv" "nlme" "nnet"
[21] "rpart" "spatial" "splines" "stats" "stats4"
[26] "survival" "tcltk" "tools" "utils"

install.packages(c("tree","maptree"))

remove.packages(c("tree", "maptree"),.Library)
Command Description
installed.packages Returns a matrix with information about all currently installed packages.
available.packages Returns a matrix of all packages available on the repository.
old.packages Returns a matrix of all currently installed packages for which newer versions are available.
new.packages Returns a matrix showing all currently uninstalled packages available from the package
repositories.
download.packages Downloads a set of packages to a local directory.
install.packages Installs a set of packages from the repository.
remove.packages Removes a set of installed packages.
update.packages Updates installed packages to the latest versions.
setRepositories Sets the current list of package repositories.

R CMD INSTALL aplpack_1.1.1.tgz
> # if you haven't installed devtools, start with this command:
> install.packages("devtools")
> # otherwise just type this
> library(devtools)
> install_github("ggplot2")
install_github("rPython-win")


To build a package, you need to place all the package files (code, data, documentation, etc.) inside a single directory. You can create an appropriate directory structure
using the R function package.skeleton:
package.skeleton(name = "anRpackage", list,
 environment = .GlobalEnv,
 path = ".", force = FALSE, namespace = FALSE,
 code_files = character())
This function can also copy a set of R objects into that directory. Here’s a description
of the arguments to package.skeleton.

Building the Package
After you’ve added all the materials to the package, you can build it from the com
mand line on your computer (not the R shell). To make sure that the package com
plies with CRAN rules and builds correctly, use the check command. For the previ
ous example, we would use the following command:
$ R CMD check nutshell
You can get more information about the CMD check command by entering R CMD
CHECK --help on the command line. To build the package, you would use the fol
lowing command:
$ R CMD build nutshell
As above, help is available through the --help option. If you’re really interested in
how to build R packages, see the manual Writing R Extensions, available at http://
cran.r-project.org/doc/manuals/R-exts.pdf.

Suppose that you wanted to change the fourth element to the word “duck.” Nor
mally, you would use a statement like this:
> animals[4] <- "duck"
This statement is parsed into a call to the [<- function. So you could actually use
this equivalent expression:1
> `[<-`(animals,4,"duck")

> # pretty assignment
> apples <- 3
> # functional form of assignment
> `<-`(apples,3)
> apples
[1] 3
> # another assignment statement, so that we can compare apples and oranges
> `<-`(oranges,4)
> oranges
[1] 4
> # pretty arithmetic expression
> apples + oranges
[1] 7
> # functional form of arithmetic expression
> `+`(apples,oranges)
[1] 7
> # pretty form of if-then statement
> if (apples > oranges) "apples are better" else "oranges are better"
[1] "oranges are better"
> # functional form of if-then statement
> `if`(apples > oranges,"apples are better","oranges are better")
[1] "oranges are better"
> x <- c("apple","orange","banana","pear")
> # pretty form of vector reference
> x[2]
[1] "orange"

> # pretty assignment
> apples <- 3
> # functional form of assignment
> `<-`(apples,3)
> apples
[1] 3
> # another assignment statement, so that we can compare apples and oranges
> `<-`(oranges,4)
> oranges
[1] 4
> # pretty arithmetic expression
> apples + oranges
[1] 7
> # functional form of arithmetic expression
> `+`(apples,oranges)
[1] 7
> # pretty form of if-then statement
> if (apples > oranges) "apples are better" else "oranges are better"
[1] "oranges are better"
> # functional form of if-then statement
> `if`(apples > oranges,"apples are better","oranges are better")
[1] "oranges are better"
> x <- c("apple","orange","banana","pear")
> # pretty form of vector reference
> x[2]
[1] "orange"

> # functional form or vector reference
> `[`(x,2)
[1] "orange"

> u <- list(1)
> v <- u
> u[[1]] <- "hat"
> u
[[1]]
[1] "hat"
> v
[[1]]
[1] 1

Inf and -Inf
If a computation results in a number that is too big, R will return Inf for a positive
number and -Inf for a negative number (meaning positive and negative infinity,
respectively):
> 2 ^ 1024
[1] Inf
> - 2 ^ 1024
[1] -Inf
This is also the value returned when you divide by 0:
> 1 / 0
[1] Inf

NA
In R, the NA values are used to represent missing values. (NA stands for “not
available.”) You may encounter NA values in text loaded into R (to represent missing
values) or in data loaded from databases (to replace NULL values).

Inf and -Inf
If a computation results in a number that is too big, R will return Inf for a positive
number and -Inf for a negative number (meaning positive and negative infinity,
respectively):
> 2 ^ 1024
[1] Inf
> - 2 ^ 1024
[1] -Inf
This is also the value returned when you divide by 0:
> 1 / 0
[1] Inf
NaN
Sometimes, a computation will produce a result that makes little sense. In these
cases, R will often return NaN (meaning “not a number”):
> Inf - Inf
[1] NaN
> 0 / 0
[1] NaN
NULL
Additionally, there is a null object in R, represented by the symbol NULL. (The symbol
NULL always points to the same object.) NULL is often used as an argument in functions
to mean that no value was assigned to the argument. Additionally, some functions
may return NULL. Note that NULL is not the same as NA, Inf, -Inf, or NaN.

> x <- c(1, 2, 3, 4, 5)
> x
[1] 1 2 3 4 5
> typeof(x)
[1] "double"
> class(x)
[1] "numeric"

Here is an overview of the coercion rules:
• Logical values are converted to numbers: TRUE is converted to 1 and FALSE to 0.
• Values are converted to the simplest type required to represent all information.
• The ordering is roughly logical < integer < numeric < complex < character < list.
• Objects of type raw are not converted to other types.
• Object attributes are dropped when an object is coerced from one type to
another.

if (x > 1) "orange" else "apple"
[1] "apple"

> if (x > 1) "orange" else "apple"
[1] "apple"
To show how this expression is parsed, we can use the quote() function. This func
tion will parse its argument but not evaluate it. By calling quote, an R expression
returns a “language” object:
> typeof(quote(if (x > 1) "orange" else "apple"))
[1] "language"
Unfortunately, the print function for language objects is not very informative:
> quote(if (x > 1) "orange" else "apple")
if (x > 1) "orange" else "apple"
However, it is possible to convert a language object into a list. By displaying the
language object as a list, it is possible to see how R evaluates an expression. This is
the parse tree for the expression:
> as(quote(if (x > 1) "orange" else "apple"),"list")
[[1]]
`if`
[[2]]
x > 1
the R

[[3]]
[1] "orange"
[[4]]
[1] "apple"
We can also apply the typeof function to every element in the list to see the type of
each object in the parse tree:4
> lapply(as(quote(if (x > 1) "orange" else "apple"), "list"),typeof)
[[1]]
[1] "symbol"
[[2]]
[1] "language"
[[3]]
[1] "character"
[[4]]
[1] "character"
lapply(quote(if (x > 1) "orange" else "apple"),typeof)
as.list(quote(`[`(x,2)))

As you can see, R interprets both of these expressions identically. Clearly, the op
eration is not reversible (because both expressions are translated into the same parse
tree). The deparse function can take the parse tree and turn it back into properly
formatted R code. (The deparse function will use proper R syntax when translating
a language object back into the original code.) Here’s how it acts on these two bits
of code:
> deparse(quote(x[2]))
[1] "x[2]"
> deparse(quote(`[`(x,2)))
[1] "x[2]"
As you read through this book, you might want to try using quote, substitute,
typeof, class, and methods to see how the R interpreter parses expressions.

do.call(substitute,list(syrhadesy2 <- x + 1, list(x = 1)))

do.call(substitute,list(syrhadesy2 <- x + 1)) # ===>python eval(syrhadesy2 <- x + 1)


You may specify values in hexadecimal notation by prefixing them with 0x:
> 0x1
[1] 1
> 0xFFFF
[1] 65535

> typeof(1:1)
[1] "integer"
> typeof(as(1, "integer"))
[1] "integer"

as(1, "Date")

> # limits of precision
> (2^1023 + 1) == 2^1023
[1] TRUE
> # limits of size
> 2^1024
[1] Inf
In practice, this is rarely a problem. Most R users will load data from other sources
on a computer (like a database) that also can’t represent very large numbers.
R also supports complex numbers. Complex values are written as real_part
+imaginary_parti. For example:
> 0+1i ^ 2
[1] -1+0i
> sqrt(-1+0i)
[1] 0+1i
> exp(0+1i * pi)
[1] -1+0i

> sqrt(-1)
[1] NaN
Warning message:
In sqrt(-1) : NaNs produced


This can be convenient if the enclosed text contains double quotes (or vice versa).
Equivalently, you may also escape the quotes by placing a backslash in front of each
quote:
> identical("\"hello\"", '"hello"')
[1] TRUE
> identical('\'hello\'', "'hello'")
[1] TRUE
These examples are all vectors with only one element. To stitch together longer
vectors, use the c function:
> numbers <- c("one", "two", "three", "four", "five")
> numbers
[1] "one" "two" "three" "four" "five"


Not all words are valid as symbols; some words are reserved in R. Specifically, you
can’t use if, else, repeat, while, function, for, in, next, break, TRUE, FALSE, NULL,
Inf, NaN, NA, NA_integer_, NA_real_, NA_complex_, NA_character_, ... , ..1, ..2, ..
3, ..4, ..5, ..6, ..7, ..8, or ..9.

You can define your own binary operators. User-defined binary operators consist of
a string of characters between two % characters. To do this, create a function of two
variables and assign it to an appropriate symbol. For example, let’s define an operator %myop% that doubles each operand and then adds them together:
> `%myop%` <- function(a, b) {2*a + 2*b}
> 1 %myop% 1
[1] 4
> 1 %myop% 2
[1] 6

> # assignment is a binary operator
> # the left side is a symbol, the right is a value
> x <- c(1, 2, 3, 4, 5)
> # indexing is a binary operator too
> # the left side is a symbol, the right is an index
> x[3]
[1] 3
> # a function call is also a binary operator
> # the left side is a symbol pointing to the function argument
> # the right side are the arguments
> max(1, 2)
[1] 2

There are also unary operators that take only one variable. Here are two familiar
examples:
> # negation is a unary operator
> -7
[1] -7
> # ? (for help) is also a unary operator
> ?`?`

-(2,3,4,5)


In order to resolve ambiguity, operators in R are always interpreted in the same order.
Here is a summary of the precedence rules:
• Function calls and grouping expressions
• Index and lookup operators
• Arithmetic
• Comparison
• Formulas
• Assignment
• Help



Table 6-1. Operator precedence, from the help(syntax) file
Operators (in order of priority) Description
( { Function calls and grouping expressions (respectively)
[ [[ Indexing
:: ::: Access variables in a namespace
$ @ Component / slot extraction
^ Exponentiation (right to left)
- + Unary operators for minus and plus
: Sequence operator
%any% Special operators
* / Multiply, divide
+ - Binary operators for add, subtract
< > <= >= == != Ordering and comparison
! Negation
& && And
| || Or
~ As in formulas
-> ->> Rightward assignment
= Assignment (right to left)
<- <<- Assignment (right to left)
? Help (unary and binary)

There is an alternative type of assignment statement in R that acts differently: as
signments with a function on the left-hand side of the assignment operator. These
statements replace an object with a new object that has slightly different properties.
Here are a few examples:
> dim(v) <- c(2, 4)
> v[2, 2] <- 10
> formals(z) <- alist(a=1, b=2, c=3)


There is a little bit of magic going on behind the scenes. An assignment statement
of the form:
fun(sym) <- val
is really syntactic sugar for a function of the form:
`fun<-`(sym, val)
Each of these functions replaces the object associated with sym in the current environment. By convention, fun refers to a property of the object represented by sym. If
you write a method with the name method_name<-, then R will allow you to place
method_name on the left-hand side of an assignment statement.
Conditional statements take the form:
if (condition) true_expression else false_expression
or, alternatively:
if (condition) expression

Because the expressions expression, true_expression, and false_expression are not
always evaluated, the function if has the type special:
> typeof(`if`)
[1] "special"
typeof(`for`)

> a <- c("a", "a", "a", "a", "a")
> b <- c("b", "b", "b", "b", "b")
> ifelse(c(TRUE, FALSE, TRUE, FALSE, TRUE), a, b)
[1] "a" "b" "a" "b" "a"
> switcheroo.if.then <- function(x) {
+ if (x == "a")
+ "camel"
+ else if (x == "b")
+ "bear"
+ else if (x == "c")
+ "camel"
+ else
+ "moose"
+ }

> switcheroo.switch <- function(x) {
+ switch(x,
+ a="alligator",
+ b="bear",
+ c="camel",
+ "moose")
+ }

> i <- 5
> repeat {if (i > 25) break else {print(i); i <- i + 5;}}


while (condition) expression
As a simple example, let’s rewrite the example above using a while loop:
> i <- 5
> while (i <= 25) {print(i); i <- i + 5}
[1] 5
[1] 10
[1] 15
[1] 20
[1] 25
You can also use break and next inside while loops. The break statement is used to
stop iterating through a loop. The next statement skips to the next loop iteration
without evaluating the remaining expressions in the loop body.
Finally, R provides for loops, which iterate through each item in a vector (or a list):
for (var in list) expression
Let’s use the same example for a for loop:
> for (i in seq(from=5, to=25, by=5)) print(i)
[1] 5
[1] 10
[1] 15
[1] 20
[1] 25
You can also use break and next inside for loops.
There are two important properties of looping statements to remember. First, results
are not printed inside a loop unless you explicitly call the print function. For
example:
> for (i in seq(from=5, to=25, by=5)) i
Second, the variable var that is set in a for loop is changed in the calling environment:
> i <- 1
> for (i in seq(from=5, to=25, by=5)) i
> i
[1] 25
Like conditional statements, the looping functions `repeat` , `while` , and `for`  have
type special, because expression is not necessarily evaluated.

To create an iterator in R, you would
use the iter function:
iter(obj, checkFunc=function(...) TRUE, recycle=FALSE,...)
The argument obj specifies the object, recycle specifies whether the iterator
should reset when it runs out of elements, and checkFunc specifies a function that
filters values returned by the iterator.
You fetch the next item with the function nextElem. This function will implicitly
call checkFunc. If the next value matches checkFunc, it will be returned. If it doesn’t
match, then the function will try another value. nextElem will continue checking
values until it finds one that matches checkFunc, or it runs out of values. When
there are no elements left, the iterator calls stop with the message “StopIteration.”
For example, let’s create an iterator that returns values between 1 and 5:
> library(iterators)
> onetofive <- iter(1:5)
> nextElem(onetofive)
[1] 1
> nextElem(onetofive)
[1] 2
> nextElem(onetofive)
[1] 3
> nextElem(onetofive)
[1] 4
> nextElem(onetofive)
[1] 5
> nextElem(onetofive)
Error: StopIteration
A second extension is the foreach loop, available through the foreach package.
Foreach provides an elegant way to loop through multiple elements of another
object (such as a vector, matrix, data frame, or iterator), evaluate an expression
for each element, and return the results. Within the foreach function, you assign
elements to a temporary value, just like in a for loop.
Here is the prototype for the foreach function:
foreach(..., .combine, .init, .final=NULL, .inorder=TRUE,
 .multicombine=FALSE,
 .maxcombine=if (.multicombine) 100 else 2,
 .errorhandling=c('stop', 'remove', 'pass'),
 .packages=NULL, .export=NULL, .noexport=NULL,
 .verbose=FALSE)
Technically, the foreach function returns a foreach object. To actually evaluate
the loop, you need to apply the foreach loop to an R expression using the %do% or
%dopar% operators. That sounds weird, but it’s actually pretty easy to use in practice. For example, you can use a foreach loop to calculate the square roots of
numbers between 1 and 5:
> sqrts.1to5 <- foreach(i=1:5) %do% sqrt(i)
> sqrts.1to5
[[1]]
[1] 1
[[2]]
[1] 1.414214
[[3]]
[1] 1.732051
[[4]]
[1] 2
[[5]]
[1] 2.236068
The %do% operator evaluates the expression in serial, while the %dopar% can be used
to evaluate expressions in parallel. For more about parallel computing with R, see
Chapter 26.


Data Structure Operators
Table 6-2 shows the operators in R used for accessing objects in a data structure.
Table 6-2. Data structure access notation
Syntax Objects Description
x[ i] Vectors,
lists
Returns objects from object x, described by i . i  may be an integer vector, character vector (of
object names), or logical vector. Does not allow partial matches. When used with lists, returns
a list. When used with vectors, returns a vector.
x[[ i]] Vectors,
lists
Returns a single element ofx, matching i . i  may be an integer or character vector of length
1. Allows partial matches (with exact=FALSE option).
x$n Lists Returns object with name n from object x.
x@n S4 objects Returns element stored in object x in slot named n.

> # exclude elements 1:15 (by specifying indexes -1 to -15)
> v[-15:-1]
[1] 115 116 117 118 119

> l <- list(a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10)
> l[1:3]

> m <- matrix(data=c(101:112), nrow=3, ncol=4)
> m
[,1] [,2] [,3] [,4]
[1,] 101 104 107 110
[2,] 102 105 108 111
[3,] 103 106 109 112
> m[3]
[1] 103
> m[3,4]
[1] 112
> m[1:2,1:2]
[,1] [,2]
[1,] 101 104
[2,] 102 105
> m[1:2, ]
[,1] [,2] [,3] [,4]
[1,] 101 104 107 110
[2,] 102 105 108 111
> m[3:4]
[1] 103 104
> m[, 3:4]
[,1] [,2]
[1,] 107 110
[2,] 108 111
[3,] 109 112

> a <- array(data=c(101:124), dim=c(2, 3, 4))
> class(a[1, 1, ])
[1] "integer"
> class(a[1, , ])
[1] "matrix"
> class(a[1:2, 1:2, 1:2])
[1] "array"
> class(a[1, 1, 1, drop=FALSE])
[1] "array"

Indexing by Logical Vector
As an alternative to indexing by an integer vector, you can also index through a
logical vector. As a simple example, let’s construct a vector of alternating true and
false elements to apply to v:
> rep(c(TRUE, FALSE), 10)
[1] TRUE FALSE TRUE FALSE TRUE FALSE TRUE FALSE TRUE FALSE TRUE
[12] FALSE TRUE FALSE TRUE FALSE TRUE FALSE TRUE FALSE
> v[rep(c(TRUE, FALSE), 10)]
[1] 100 102 104 106 108 110 112 114 116 118
Often, it is useful to calculate a logical vector from the vector itself:
> # trivial example: return element that is equal to 103
> v[(v==103)]
> # more interesting example: multiples of three
> v[(v %% 3 == 0)]
[1] 102 105 108 111 114 117


Indexing by Name
With lists, each element may be assigned a name. You can index an element by name
using the $ notation:
> l <- list(a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10)
> l$j
[1] 10
You can also use the single-bracket notation to index a set of elements by name:
> l[c("a", "b", "c")]
$a
[1] 1
$b
[1] 2
$c
[1] 3

> dairy <- list(milk="1 gallon", butter="1 pound", eggs=12)
> dairy$milk
[1] "1 gallon"
> dairy[["milk"]]
[1] "1 gallon"
> dairy[["mil"]]
NULL
> dairy[["mil",exact=FALSE]]
[1] "1 gallon"

> fruit <- list(apples=6, oranges=3, bananas=10)
> shopping.list <- list (dairy=dairy, fruit=fruit)
> shopping.list
$dairy

$dairy$milk
[1] "1 gallon"
$dairy$butter
[1] "1 pound"
$dairy$eggs
[1] 12
$fruit
$fruit$apples
[1] 6
$fruit$oranges
[1] 3
$fruit$bananas
[1] 10
> shopping.list[[c("dairy", "milk")]]
[1] "1 gallon"
> shopping.list[[c(1,2)]]
[1] "1 pound"

Basic vectors
These are vectors containing a single type of value: integers, floating-point
numbers, complex numbers, text, logical values, or raw data.
Compound objects
These objects are containers for the basic vectors: lists, pairlists, S4 objects, and
environments. Each of these objects has unique properties (described below),
but each of them contains a number of named objects.
Special objects
These objects serve a special purpose in R programming: any, NULL, and ... .
Each of these means something important in a specific context, but you would
never create an object of these types.
R language
These are objects that represent R code; they can be evaluated to return other
objects.Functions
Functions are the workhorses of R; they take arguments as inputs and return
objects as outputs. Sometimes, they may modify objects in the environment or
cause side effects outside the R environment like plotting graphics, saving files,
or sending data over the network.
Internal
These are object types that are formally defined by R but which aren’t normally
accessible within the R language. In normal R programming, you will probably
never encounter any of the objects.
Bytecode Objects
If you use the bytecode compiler, R will generate bytecode objects that run on
the R virtual machine.

Category Object type Description Example
Vectors integer Naturally produced from sequences. Can be
coerced with the integer()  function.
5:5 integer(5)
double Used to represent floating-point numbers
(numbers with decimals and large numbers).
On most modern platforms, this will be 8 bytes,
or 64 bits. By default, most numerical values
are represented as doubles. Can be coerced
with the double()  function.
1 -1 2 ** 50 double(5)
complex Complex numbers. To use, you must include
both the real and the imaginary parts (even if
the real part is 0).
2+3i 0+1i exp(0+1i * pi)
character A string of characters (just called a string in
many other languages).
"Hello world."
logical Represents Boolean values. TRUE FALSE
raw A vector containing raw bytes. Useful for en
coding objects from outside the R
environment.
raw(8) char
ToRaw("Hello")
Compound list A (possibly heterogeneous) collection of other
objects. Elements of a list may be named. Many
other object types in R (such as data frames)
are implemented as lists.
list(1, 2, "hat")
pairlist A data structure used to represent a set of
name-value pairs. Pairlists are primarily used
internally but can be created at the user level.
Their use is deprecated in user-level programs,
because standard list objects are just as effi
cient and more flexible.
.Options pair
list(apple=1, pear=2,
banana=3)
S4 An R object supporting modern object
oriented paradigms (inheritance, methods,
etc.). See Chapter 10 for a full explanation.

environment An R environment describes the set of
symbols available in a specific context. An en
vironment contains a set of symbol-value pairs
and a pointer to an enclosing environment. (For
example, you could use any in the signature of
a default generic function.)
.GlobalEnv new.env(par
ent = baseenv())
Special any An object used to mean that “any” type is OK.
Used to prevent coercion from one type to an
other. Useful in defining slots in S4 objects or
signatures for generic functions.
setClass("Something",
representa
tion( data="ANY" ) )
NULL An object that means “there is no object.” Re
turned by functions and expressions whose
value is not defined. The NULL object can have
no attributes.
NULL
... Used in functions to implement variable
length argument lists, particularly arguments
passed to other functions.
N/A
R language symbol A symbol is a language object that refers to
other objects. Usually encountered when pars
ing R statements.
as.name(x) as.symbol(x)
quote(x)
promise Promises are objects that are not evaluated
when they are created but are instead evalu
ated when they are first used. They are used to
implement delayed loading of objects in pack
ages.
> x <- 1;
> y <- 2;
> z <- 3
> delayedAssign("v",
c(x, y, z))
> # v is a promise
language R language objects are used when processing
the R language itself.
quote(function(x) { x +
1})
expression An unevaluated R expression. Expression ob
jects can be created with the expression
function and later evaluated with the eval
function.
expression(1 + 2)
Functions closure An R function not implemented inside the R
system. Most functions fall into this category.
Includes user-defined functions, most func
tions included with R, and most functions in R
packages.
f <- function(x) { x + 1}
print
special An internal function whose arguments are not
necessarily evaluated on call.
if [
builtin An internal function that evaluates its
arguments.
+ ^
bytecode Compiled R functions generated by the
compiler package
cmpfun(function(x) {x^2}
Internal char A scalar “string” object. A character vector is
composed of char objects. (Users can’t
N/A


> # a vector of five numbers
> v <- c(.295, .300, .250, .287, .215)
> v
[1] 0.295 0.300 0.250 0.287 0.215
> # creating a vector from four numbers and a char
> v <- c(.295, .300, .250, .287, "zilch")
> v
[1] "0.295" "0.3" "0.25" "0.287" "zilch"

> # creating a vector from four numbers and a list of
> # three more
> v <- c(.295, .300, .250, .287, list(.102, .200, .303), recursive=TRUE)
> v
[1] 0.295 0.300 0.250 0.287 0.102 0.200 0.303

But beware of using a list as an argument, as you will get back a list:
> v <- c(.295, .300, .250, .287, list(.102, .200, .303), recursive=TRUE)
> v
[1] 0.295 0.300 0.250 0.287 0.102 0.200 0.303
> typeof(v)
[1] "double"
> v <- c(.295, .300, .250, .287, list(1, 2, 3))
> typeof(v)
[1] "list"
> class(v)
[1] "list"
> v
[[1]]
[1] 0.295
[[2]]
[1] 0.3

> seq(from=5, to=25, by=5)
[1] 5 10 15 20 25

1:10
> l <- list(1, 2, 3, 4, 5)
> l[1]
[[1]]
[1] 1
> l[[1]]
[1] 1

> parcel <- list(destination="New York", dimensions=c(2, 6, 9), price=12.95)
It is then possible to refer to each component individually using the $ notation. For
example, if we wanted to get the price, we would use the following expression:
> parcel$price
[1] 12.95

Matrices
A matrix is an extension of a vector to two dimensions. A matrix is used to represent
two-dimensional data of a single type. A clean way to generate a new matrix is with
the matrix function. As an example, let’s create a matrix object with three columns
and four rows. We’ll give the rows the names “r1,” “r2,” “r3,” and “r4,” and the
columns the names “c1,” “c2,” and “c3.”
m <- matrix(data=1:12, nrow=4, ncol=3,
dimnames=list(c("r1", "r2", "r3", "r4"),
c("c1", "c2", "c3")))
m
as.matrix

array(data=1:24, dim=c(3, 4, 2))
Factors
When analyzing data, it’s quite common to encounter categorical values. For ex
ample, suppose you have a set of observations about people that includes eye color.
You could represent the eye colors as a character array:
eye.colors <- c("brown", "blue", "blue", "green",
"brown", "brown", "brown")
Let’s recode the eye colors as a factor:
> eye.colors <- factor(c("brown", "blue", "blue", "green",
+  "brown", "brown", "brown"))
The levels function shows all the levels from a factor:
> levels(eye.colors)
[1] "blue" "brown" "green"

> survey.results <- factor(
+  c("Disagree", "Neutral", "Strongly Disagree",
+  "Neutral", "Agree", "Strongly Agree",
+  "Disagree", "Strongly Agree", "Neutral",
+  "Strongly Disagree", "Neutral", "Agree"),
+  levels=c("Strongly Disagree", "Disagree",
+  "Neutral", "Agree", "Strongly Agree"),
+  ordered=TRUE)
> survey.results
[1] Disagree Neutral Strongly Disagree
[4] Neutral Agree Strongly Agree
[7] Disagree Strongly Agree Neutral
[10] Strongly Disagree Neutral Agree
5 Levels: Strongly Disagree < Disagree < Neutral < ... < Strongly Agree

> # use the eye colors vector we used above
> eye.colors
[1] brown blue blue green brown brown brown
Levels: blue brown green
> class(eye.colors)
[1] "factor"
> # now create a vector by removing the class:
> eye.colors.integer.vector <- unclass(eye.colors)
> eye.colors.integer.vector

[1] 2 1 1 3 2 2 2
attr(,"levels")
[1] "blue" "brown" "green"
> class(eye.colors.integer.vector)
[1] "integer"

It’s possible to change this back to a factor by setting the class attribute:
################################key process############### 改变数据类型###
> class(eye.colors.integer.vector) <- "factor"
> eye.colors.integer.vector
[1] brown blue blue green brown brown brown
Levels: blue brown green
> class(eye.colors.integer.vector)
[1] "factor"


top.bacon.searching.cities <- data.frame(
city = c("Seattle", "Washington", "Chicago",
"New York", "Portland", "St Louis",
"Denver", "Boston","Minneapolis", "Austin",
"Philadelphia", "San Francisco", "Atlanta",
"Los Angeles", "Richardson"),
rank = c(100, 96, 94, 93, 93, 92, 90, 90, 89, 87,
85, 84, 82, 80, 80)
)

Data frames are implemented as lists with class data.frame:
> typeof(top.bacon.searching.cities)
[1] "list"
> class(top.bacon.searching.cities)
[1] "data.frame"

Formulas
Very often, you need to express a relationship between variables. Sometimes, you
want to plot a chart showing the relationship between the two variables. Other times,
you want to develop a mathematical model. R provides a formula class that lets you
describe the relationship for both purposes.
Let’s create a formula as an example:
> sample.formula <- as.formula(y~x1+x2+x3)
> class(sample.formula)
[1] "formula"
> typeof(sample.formula)
[1] "language"

This formula means “y is a function of x1, x2, and x3.” Some R functions use more
complicated formulas. For example, in “Charts and Graphics” on page 30, we plotted a formula of the form Amount~Year|Food, which means “Amount is a function of
Year, conditioned on Food.” Here is an explanation of the meaning of different items
in formulas:

Variable names
Represent variable names.
Tilde (~)
Used to show the relationship between the response variables (to the left) and
the stimulus variables (to the right).
Plus sign (+)
Used to express a linear relationship between variables.
Zero (0)
When added to a formula, indicates that no intercept term should be included.
For example:
y~u+w+v+0
Vertical bar (|)
Used to specify conditioning variables (in lattice formulas; see “Customizing
Lattice Graphics” on page 312).
Identity function (I())
Used to indicate that the enclosed expression should be interpreted by its arith
metic meaning. For example:
a+b
means that both a and b should be included in the formula. The formula:
I(a+b)
means that “a plus b” should be included in the formula.
Asterisk (*)
Used to indicate interactions between variables. For example:
y~(u+v)*w
is equivalent to:
y~u+v+w+I(u*w)+I(v*w)
Caret (^)
Used to indicate crossing to a specific degree. For example:
y~(u+w)^2
is equivalent to:
y~(u+w)*(u+w)
Function of variables
Indicates that the function of the specified variables should be interpreted as a
variable. For example:
y~log(u)+sin(v)+w
Some additional items have special meaning in formulas, for example s() for
smoothing splines in formulas passed to gam. We’ll revisit formulas in Chapter 14
and Chapter 20.


Time Series
Many important problems look at how a variable changes over time, and R includes
a class to represent this data: time series objects. Regression functions for time series
(like ar or arima) use time series objects. Additionally, many plotting functions in R
have special methods for time series.
To create a time series object (of class "ts"), use the ts function:
ts(data = NA, start = 1, end = numeric(0), frequency = 1,
 deltat = 1, ts.eps = getOption("ts.eps"), class = , names = )
The data argument specifies the series of observations; the other arguments specify
when the observations were taken. Here is a description of the arguments to ts.

Argument Description Default
data A vector or matrix representing a set of observations over time
(usually numeric).
NA
start A numeric vector with one or two elements representing the
start of the time series. If one element is used, then it represents
a “natural time unit.” If two elements are used, then it represents a “natural time unit” and an offset.
1
end A numeric vector with one or two elements representing the
end of the time series. (Represented the same way as start.)
numeric(0)
frequency The number of observations per unit of time. 1
deltat The fraction of the sampling period between observations;
frequency=1/deltat.
1
ts.eps Time series comparison tolerance. The frequency of two time
series objects is considered equal if the difference is less than
this amount.
getOption("ts.eps")
class The class to be assigned to the result. "ts" for a single series, c("mts",
"ts")  for multiple series
names A character vector specifying the name of each series in a multiple series object.
colnames(data)  when not null,
otherwise "Series1" ,
"Series2" , ...

> library(nutshell)
> data(turkey.price.ts)
> turkey.price.ts
Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
2001 1.58 1.75 1.63 1.45 1.56 2.07 1.81 1.74 1.54 1.45 0.57 1.15
2002 1.50 1.66 1.34 1.67 1.81 1.60 1.70 1.87 1.47 1.59 0.74 0.82
2003 1.43 1.77 1.47 1.38 1.66 1.66 1.61 1.74 1.62 1.39 0.70 1.07
2004 1.48 1.48 1.50 1.27 1.56 1.61 1.55 1.69 1.49 1.32 0.53 1.03
2005 1.62 1.63 1.40 1.73 1.73 1.80 1.92 1.77 1.71 1.53 0.67 1.09
2006 1.71 1.90 1.68 1.46 1.86 1.85 1.88 1.86 1.62 1.45 0.67 1.18
2007 1.68 1.74 1.70 1.49 1.81 1.96 1.97 1.91 1.89 1.65 0.70 1.17
2008 1.76 1.78 1.53 1.90
R includes a variety of utility functions for looking at time series objects:
> start(turkey.price.ts)
[1] 2001 1
> end(turkey.price.ts)
[1] 2008 4
> frequency(turkey.price.ts)
[1] 12
> deltat(turkey.price.ts)
[1] 0.08333333

Dates and Times
R includes a set of classes for representing dates and times:
Date
Represents dates but not times.
POSIXct
Stores dates and times as seconds since January 1, 1970, 12:00 A.M.
POSIXlt
Stores dates and times in separate vectors. The list includes sec (0–61) 2, min
(0–59), hour (0–23), mday (day of month, 1–31), mon (month, 0–11), year

(years since 1900), wday (day of week, 0–6), yday (day of year, 0–365), and
isdst (flag for “is daylight savings time”).
> date.I.started.writing <- as.Date("2/13/2009","%m/%d/%Y")
> date.I.started.writing
[1] "2009-02-13"
> today <- Sys.Date()
> today
[1] "2009-08-03"
> today - date.I.started.writing
Time difference of 171 days

R includes a special object type for receiving data from (or sending data to) applications or files outside the R environment. (Connections are like file pointers in C
or filehandles in Perl.) You can create connections to files, URLs, zip-compressed
files, gzip-compressed files, bzip-compressed files, Unix pipes, network sockets, and
FIFO (first in, first out) objects. You can even read from the system Clipboard (to
paste data into R).
To use connections, you create the connection, open the connection, use the connection, and close the connection. For example, suppose you had saved some data
objects into a file called consumption.RData and wanted to load the data. R saves
files in a compressed format, so you would create a connection with the gzfile
command. Here is how to load the file using a connection:
> consumption.connection <- gzfile(description="consumption.RData",open="r")
> load(consumption.connection)
> close(consumption.connection)

Attributes
Objects in R can have many properties associated with them, called attributes. These
properties explain what an object represents and how it should be interpreted by R.
Quite often, the only difference between two similar objects is that they have
different attributes. 3 Some important attributes are shown in Table 7-2. Many ob
jects in R are used to represent numerical data—in particular, arrays, matrices, and
data frames. So many common attributes refer to properties of these objects.
Table 7-2. Common attributes
Attribute Description
class The class of the object.
comment A comment on the object; often a description of what the object means.
dim Dimensions of the object.
dimnames Names associated with each dimension of the object.
names Returns the names attribute of an object. Results depend on object type; for example, it returns the name
of each data column in a data frame or each named object in an array.
row.names The name of each row in an object (related to dimnames).
tsp Start time for an object. Useful for time series data.
levels Levels of a factor.
There is a standard way to query object attributes in R. For an object x and attribute
a, you refer to the attribute through a(x). In most cases, there is a method to get the
current value of the attribute and a method to set a new value of the attribute.
(Changing attributes with these methods will alter the attributes in the current en
vironment but will not affect the attributes in an enclosing environment.)
You can get a list of all attributes of an object using the attributes function. As an
example, let’s consider the matrix that we created in “Matrices” on page 88:
> m <- matrix(data=1:12, nrow=4, ncol=3,
+ dimnames=list(c("r1", "r2", "r3", "r4"),
+ c("c1", "c2", "c3")))
Now, let’s take a look at the attributes of this object:
> attributes(m)
$dim
[1] 4 3
$dimnames
$dimnames[[1]]
[1] "r1" "r2" "r3" "r4"
$dimnames[[2]]
[1] "c1" "c2" "c3"
The dim attribute shows the dimensions of the object, in this case four rows by three
columns. The dimnames attribute is a two-element list, consisting of the names for
3. You might wonder why attributes exist; the same functionality could be implemented with
lists or S4 objects. The reason is historical: Attributes predate most of R’s modern object
mechanisms. See Chapter 10 for a full discussion of formal objects in R.
each respective dimension of the object (rows then columns). It is possible to access
each of these attributes directly, using the dim and dimnames functions, respectively:
> dim(m)
[1] 4 3
> dimnames(m)
[[1]]
[1] "r1" "r2" "r3" "r4"
[[2]]
[1] "c1" "c2" "c3"
There are convenience functions for accessing the row and column names:
> colnames(m)
[1] "c1" "c2" "c3"
> rownames(m)
[1] "r1" "r2" "r3" "r4"
It is possible to transform this matrix into another object class simply by changing
the attributes. Specifically, we can remove the dimension attribute (by setting it to
NULL), and the object will be transformed into a vector:
> dim(m) <- NULL
> m
[1] 1 2 3 4 5 6 7 8 9 10 11 12
> class(m)
[1] "integer"
> typeof(m)
[1] "integer"
Let’s go back to an example that we used in “Introduction to Data Struc
tures” on page 24. We’ll construct an array a:
> a <- array(1:12,dim=c(3,4))
> a
[,1] [,2] [,3] [,4]
[1,] 1 4 7 10
[2,] 2 5 8 11
[3,] 3 6 9 12
Now let’s define a vector with the same contents:
> b <- 1:12
> b
[1] 1 2 3 4 5 6 7 8 9 10 11 12
You can use R’s bracket notation to refer to elements in a as a two-dimensional array,
but you can’t refer to elements in b as a two-dimensional array, because b doesn’t
have any dimensions assigned:
> a[2,2]
[1] 5
> b[2,2]
Error in b[2, 2] : incorrect number of dimensions
At this point, you might wonder if R considers the two objects to be the same. Here’s
what happens when you compare them with the == operator:
> a == b
[,1] [,2] [,3] [,4]
[1,] TRUE TRUE TRUE TRUE
[2,] TRUE TRUE TRUE TRUE
[3,] TRUE TRUE TRUE TRUE
Notice what is returned: an array with the dimensions of a, where each cell shows
the results of the comparison. There is a function in R called all.equal that compares
the data and attributes of two objects to show if they’re “nearly” equal, and if they
are not explains why:
> all.equal(a,b)
[1] "Attributes: < Modes: list, NULL >"
[2] "Attributes: < names for target but not for current >"
[3] "Attributes: < Length mismatch: comparison on first 0 components >"
[4] "target is matrix, current is numeric"
If you just want to check whether two objects are exactly the same, but don’t care
why, use the function identical:
> identical(a,b)
[1] FALSE
By assigning a dimension attribute to b, b is transformed into an array and the two
dimensional data access tools will work. The all.equal function will also show that
the two objects are equivalent:
> dim(b) <- c(3,4)
> b[2,2]
[1] 5
> all.equal(a,b)
[1] TRUE
> identical(a,b)
[1] TRUE
Class
An object’s class is implemented as an attribute. For simple objects, the class and
type are often closely related. For compound objects, however, the two can be
different.
Sometimes, the class of an object is listed with attributes. However, for certain
classes (such as matrices and arrays), the class is implicit. To determine the class of
an object, you can use the class function. You can determine the underlying type
of object using the typeof function.
For example, here is the type and class for a simple numeric vector:
> x <- c(1, 2, 3)
> typeof(x)
[1] "double"
> class(x)
[1] "numeric"
It is possible to change the class of an object in R, just like changing any other
attribute. For example, factors are implemented internally using integers and a mapof the integers to the factor levels. (Integers take up a small, fixed amount of storage
space, so they can be much more efficient than character vectors.) It’s possible to
take a factor and turn it into an integer array:
> eye.colors.integer.vector
[1] 2 1 1 3 2 2 2
attr(,"levels")
[1] "blue" "brown" "green"
It is possible to create an integer array and turn it into a factor:
> v <- as.integer(c(1, 1, 1, 2, 1, 2, 2, 3, 1))
> levels(v) <- c("what", "who", "why")
> class(v) <- "factor"
> v
[1] what what what who what who who why what
Levels: what who why
Note that there is no guarantee that the implementation of factors won’t change, so
be careful using this trick in practice.
For some objects, you need to quote them to prevent them from being evaluated
when the class or type function is called. For example, suppose that you wanted to
determine the type of the symbol x and not the object to which it refers. You could
do that like this:
> class(quote(x))
[1] "name"
> typeof(quote(x))
[1] "symbol"
Unfortunately, you can’t actually use these functions on every type of object. Specif
ically, there is no way to isolate an any, ... , char, or promise object in R. (Checking
the type of a promise object requires evaluating the promise object, converting it to
an ordinary object.)


It is possible to delay evaluation of an expression so that symbols are not evaluated
immediately:
> x <- 1
> y <- 2
> z <- 3
> v <- quote(c(x, y, z))
> eval(v)
[1] 1 2 3
> x <- 5
> eval(v)
[1] 5 2 3

eval 要配合quote去使用
It is also possible to create a promise object in R to delay evaluation of a variable
until it is (first) needed. You can create a promise object through the
delayedAssign function:
> x <- 1
> y <- 2
> z <- 3
> delayedAssign("v", c(x, y, z))
> x <- 5
> v
[1] 5 2 3

Working with Environments
Like everything else in R, environments are objects. Internally, R stores symbol
mappings in hash tables. In Chapter 24, I’ll show how some tricks for using envi
ronment objects to write efficient R code.
Table 8-1 shows the functions in R for manipulating environment objects.
Table 8-1. Manipulating environment objects
Function Description
assign Assigns the name x to the object value in the environment envir.
get Gets the object associated with the name x in the environment envir.
exists Checks that the name x is defined in the environment envir.
objects Returns a vector of all names defined in the environment envir.
remove Removes the list of objects in the argument list from the environmentenvir. (List is an unfortunate
argument name, especially as the argument needs to be a vector.)
search Returns a vector containing the names of attached packages. You can think of this as the search
path in which R tries to resolve names. More precisely, it shows the list of chained parent envi
ronments.
searchpaths Returns a vector containing the paths of attached packages.

Function Description
attach Adds the objects in the list, data frame, or data file what to the current search path.
detach Removes the objects in the list, data frame, or data file what from the current search path.
emptyenv Returns the empty environment object. All environments chain back to this object.
parent.env Returns the parent of environment env.
baseenv The environment of the base package.
globalenv
or .GlobalEnv
Returns the environment for the user’s workspace (called the “global environment”). See “The
Global Environment” for an explanation of what this means.
environment Returns the environment for function fun. When evaluated with no arguments (or fun=NULL),
returns the current environment.
new.env Returns a new environment object.
To show the set of objects available in the current environment (or, more precisely,
the set of symbols in the current environment associated with objects), use the
objects function:
> x <- 1
> y <- 2
> z <- 3
> objects()
[1] "x" "y" "z"
You can remove an object from the current environment with the rm function:
> rm(x)
> objects()
[1] "y" "z"
The Global Environment
When a user starts a new session in R, the R system creates a new environment for
objects created during that session. This environment is called the global environ
ment. The global environment is not actually the root of the tree of environments.
It’s actually the last environment in the chain of environments in the search path.
Here’s the list of parent environments for the global environment in my R
installation:
> x <- .GlobalEnv
> while (environmentName(x) != environmentName(emptyenv())) {
+  print(environmentName(parent.env(x))); x <- parent.env(x)}
[1] "tools:RGUI"
[1] "package:stats"
[1] "package:graphics"
[1] "package:grDevices"
[1] "package:utils"
[1] "package:datasets"
[1] "package:methods"
[1] "Autoloads"
[1] "base"
[1] "R_EmptyEnv"
Every environment has a parent environment except for one: the empty environ
ment. All environments chain back to the empty environment.
Environments and Functions
When a function is called in R, a new environment is created within the body of the
function, and the arguments of the function are assigned to symbols in the local
environment.1
As an example, let’s create a function that takes four arguments and does nothing
except print out the objects in the current environment:
> env.demo <- function(a, b, c, d) {print(objects())}
> env.demo(1, "truck", c(1,2,3,4,5), pi)
[1] "a" "b" "c" "d"
Notice that the objects function returns only the objects from the current environ
ment, so the function env.demo only prints the arguments defined in that environ
ment. All other objects exist in the parent environment, not in the local environment.
The parent environment of a function is the environment in which the function was
created. If a function was created in the execution environment (for example, in the
global environment), then the environment in which the function was called will be
the same as the environment in which the function was created. However, if the
function was created in another environment (such as a package), then the parent
environment will not be the same as the calling environment.
Working with the Call Stack
Although the parent environment for a function is not always the environment in
which the function was called, it is possible to access the environment in which a
function was called.2 Like many other languages, R maintains a stack of calling
environments. (A stack is a data structure in which objects can be added or sub
tracted from only one end. Think about a stack of trays in a cafeteria; you can only
add a tray to the top or take a tray off the top. Adding an object to a stack is called
“pushing” the object onto the stack. Taking an object off of the stack is called “pop
ping” the object off the stack.) Each time a new function is called, a new environment
is pushed onto the call stack. When R is done evaluating a function, the environment
is popped off the call stack.
Table 8-2 shows the functions for manipulating the call stack.


Table 8-2. Manipulating the call stack
Function Description
sys.call Returns a language object containing the current function call (including arguments).
sys.frame Returns the calling environment.
sys.nframe Returns the number of the current frame (the position on the call stack). Returns 0 if called on the
R console.
sys.function Returns the function currently being evaluated.
sys.parent Returns the number of the parent frame.
sys.calls Returns the calls for all frames on the stack.
sys.frames Returns all environments on the stack.
sys.parents Returns the parent for each frame on the stack.
sys.on.exit Returns the expression used for on.exit for the current frame.
sys.status Returns a list with the results of calls to sys.calls, sys.parents, and sys.frames.
parent.frame Returns sys.frame(sys.parent(n)) . In other words, returns the parent frame.
If you are writing a package in which a function needs to know the meaning of a
symbol in the calling context (and not in the context within the package), you can
do so with these functions. Some common R functions, like modeling functions, use
this trick to determine the meaning of symbols in the calling context. In specifying
a model, you pass a formula object to a modeling function. The formula object is a
language object; the symbol names are included in the formula but not in the data.
You can specify a data object like a data frame, but you don’t have to. When you
don’t specify the objects containing the variables, the model function will try to
search through the calling environment to find the data.

You can evaluate an expression within an arbitrary environment using the eval
function:
eval(expr, envir = parent.frame(),
enclos = if(is.list(envir) || is.pairlist(envir))
parent.frame() else baseenv())
The argument expr is the expression to be evaluated, and envir is an environment,
data frame, or pairlist in which to evaluate expr. When envir is a data frame or
pairlist, enclos is the enclosure in which to look for object definitions. As an example
of how to use eval, let’s create a function to time the execution of another expression.
We’d like the function to record the starting time, evaluate its arguments (an arbi
trary expression) in the parent environment, record the end time, and print the
difference:
timethis <- function(...) {
start.time <- Sys.time();
eval(..., sys.frame(sys.parent(sys.parent())));
end.time <- Sys.time();
print(end.time - start.time);
}
create.vector.of.ones <- function(n) {
return.vector <- NA;
for (i in 1:n) {
return.vector[i] <- 1;
}
return.vector;
}

returned.vector


> # note that returned.vector is not defined
> returned.vector
Error: object 'returned.vector' not found
> # measure time to run function above with n=10000
> timethis(returned.vector <- create.vector.of.ones(10000))
Time difference of 1.485959 secs
> # notice that the function took about 1.5 seconds to run
> # also notice that returned.vector is now defined
> length(returned.vector)
[1] 10000

> create.vector.of.ones.b <- function(n) {
+ return.vector <- NA;
+ length(return.vector) <- n;
+ for (i in 1:n) {
+  return.vector[i] <- 1;
+ }
+  return.vector;
+ }
> timethis(returned.vector <- create.vector.of.ones.b(10000))


Three useful shorthands are the functions evalq, eval.parent, and local. When
you want to quote the expression, use evalq, which is equivalent to
eval(quote(expr), ...). When you want to evaluate an expression within the parent
environment, you can use the function eval.parent, which is equivalent to
eval(expr, parent.frame(n)). When you want to evaluate an expression in a new
environment, you can use the function local, which is equivalent to
eval(quote(expr), envir=new.env()).

evalq(x<-"aaaa")
eval
> local(x<-"eeee")
> x
timethis.b <- function(...) {
start.time <- Sys.time();
eval.parent(...);
end.time <- Sys.time();
print(end.time - start.time);
}


Sometimes, it is convenient to treat a data frame or a list as an environment. This
lets you refer to each item in the data frame or list by name as if you were using
symbols. You can do this in R with the functions with and within:
with(data, expr, ...)
within(data, expr, ...)
The argument data is the data frame or list to treat as an environment, expr is the
expression, and additional arguments in ...  are passed to other methods. The func
tion with evaluates the expression and then returns the result, while the function
within makes changes in the object data and then returns data.
Here are some examples of using with and within:
> example.list <- list(a=1, b=2, c=3)
> a+b+c
Error: object 'b' not found
> with(example.list, a+b+c)
[1] 6
> within(example.list, d<-a+b+c)
$a
[1] 1
$b
[1] 2
$c
[1] 3
$d
[1] 6

attach(what, pos = 2, name = deparse(substitute(what)),
warn.conflicts = TRUE)
detach(name, pos = 2, unload = FALSE)

> doWork <- function(filename) {
+ if(file.exists(filename)) {
+  read.delim(filename)
+ } else {
+  stop("Could not open the file: ", filename)
+ }
+ }
> doWork("file that doesn't exist")
Error in doWork("file that doesn't exist") :
#Could not open the file: file that doesn't exist

> doNoWork <- function(filename) {
+  if(file.exists(filename)) {
+  "la la la"
+  } else {
+  warning("File does not exist: ", filename)
+  }
+ }
> doNoWork("another file that doesn't exist")
Warning message:
In doNoWork("another file that doesn't exist") :
#File does not exist: another file that doesn't exists
If you just want to tell the user something, then you can use the message function:
> doNothing <- function(x) {
+  message("This function does nothing.")
+ }
> doNothing("another input value")
This function does nothing.

Catching Errors
Suppose that you are writing a function in R called foo that calls another function
called bar. Furthermore, suppose that bar sometimes generates an error, but you
don’t want foo to stop if the error is generated. For example, maybe bar tries to open
a file but signals an error when it can’t open the file. If bar can’t open the file, maybe
you want foo to try doing something else instead.
A simple way to do this is to use the try function. This function hides some of the
complexity of R’s exception handling. Here’s an example of how to use try:
> res <- try({x <- 1}, silent=TRUE)
> res
[1] 1
> res <- try({open("file that doesn't exist")}, silent=TRUE)
> res

[1] "Error in UseMethod(\"open\") : \n no applicable method for 'open'
applied to an object of class \"character\"\n"
attr(,"class")
[1] "try-error"
The try function takes two arguments, expr and silent. The first argument, expr,
is the R expression to be tried (often a function call). The second argument specifies
whether the error message should be printed to the R console (or stderr); the default
is to print errors. If the expression results in an error, then try returns an object of
class "try-error".
A more capable function is tryCatch. The tryCatch function takes three sets of ar
guments: an expression to try, a set of handlers for different conditions, and a final
expression to evaluate. For example, suppose that the following call was made to
tryCatch:
tryCatch(expression, handler1, handler2, ..., finally=finalexpr)
The R interpreter would first evaluate expression. If a condition occurs (an error or
warning), R will pick the appropriate handler for the condition (matching the class
of the condition to the arguments for the handler). After the expression has been
evaluated, finalexpr will be evaluated. (The handlers will not be active when this
expression is evaluated.)

function(arguments) body
f <- function(x,y) x + y
f <- function(x,y) {x + y}

> f <- function(x, y) {x + y}
> f(1,2)
[1] 3
> g <- function(x, y=10) {x + y}
> g(1)

In R, it is often convenient to specify a variable-length argument list. You might want
to pass extra arguments to another function, or you may want to write a function
that accepts a variable number of arguments. To do this in R, you specify an ellipsis
(... ) in the arguments to the function.2
As an example, let’s create a function that prints the first argument and then passes
all the other arguments to the summary function. To do this, we will create a function
that takes one argument: x. The arguments specification also includes an ellipsis to
indicate that the function takes other arguments. We can then call the summary func
tion with the ellipsis as its argument:
> v <- c(sqrt(1:100))
> f <- function(x,...) {print(x); summary(...)}
> f("Here is the summary for v.", v, digits=2)
[1] "Here is the summary for v."
Min. 1st Qu. Median Mean 3rd Qu. Max.
1.0 5.1 7.1 6.7 8.7 10.0
Notice that all of the arguments after x were passed to summary.


It is also possible to read the arguments from the variable-length argument list. To
do this, you can convert the object ...  to a list within the body of the function. As
an example, let’s create a function that simply sums all its arguments:
> addemup <- function(x,...) {
+ args <- list(...)
+ for (a in args) x <- x + a
+ x
+ }
> addemup(1, 1)
[1] 2
> addemup(1, 2, 3, 4, 5)
[1] 15

You can also directly refer to items within the list ...  through the variables ..1, ..
2, to ..9. Use ..1 for the first item, ..2 for the second, and so on. Named arguments
are valid symbols within the body of the function. For more information about the
scope within which variables are defined, see Chapter 8.

Return Values
In an R function, you may use the return function to specify the value returned by
the function. For example:
> f <- function(x) {return(x^2 + 3)}
> f(3)
[1] 12
However, R will simply return the last evaluated expression as the result of a func
tion. So it is common to omit the return statement:
> f <- function(x) {x^2 + 3}
> f(3)
[1] 12

Functions as Arguments
Many functions in R can take other functions as arguments. For example, many
modeling functions accept an optional argument that specifies how to handle miss
ing values; this argument is usually a function for processing the input data.
As an example of a function that takes another function as an argument, let’s look
at sapply. The sapply function iterates through each element in a vector, applying
another function to each element in the vector and returning the results. Here is a
simple example:
> a <- 1:7
> sapply(a, sqrt)
[1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751
This is a toy example; you could have calculated the same quantity with the expres
sion sqrt(1:7). However, there are many useful functions that don’t work properly
on a vector with more than one element; sapply provides a simple way to extend
such a function to work on a vector. Related functions allow you to summarize every
element in a data structure or to perform more complicated calculations. See “Sum
marizing Functions” on page 190 for information on related functions.

We will define a function that takes another function as its argument and then applies that function to the number 3. Let’s call the function apply.to.three, and we
will call the argument f:
> apply.to.three <- function(f) {f(3)}
Now let’s call apply.to.three with an anonymous function assigned to argument
f. As an example, let’s create a simple function that takes one argument and multi
plies that argument by 7:
> apply.to.three(function(x) {x * 7})
[1] 21
Here’s how this works. When the R interpreter evaluates the expression
apply.to.three(function(x) {x * 7}), it assigns the argument f to the anonymous
function function(x) {x * 7}. The interpreter then begins evaluating the expression
f(3). The interpreter assigns 3 to the argument x for the anonymous function. Fi
nally, the interpreter evaluates the expression 3 * 7 and returns the result.
Anonymous functions are a very powerful tool used in many places in R. Above, we
used the sapply function to apply a named function to every element in an array.
You can also pass an anonymous function as an argument to sapply:
> a <- c(1, 2, 3, 4, 5)
> sapply(a, function(x) {x + 1})
[1] 2 3 4 5 6
This family of functions is a good alternative to control structures. Control struc
tures are language features like if-then statements, loops, and go-to statements. For
example, suppose that you had a vector of numerical values and wanted to calculate
the square of each element. You could do this using a loop:
> v <- 1:20
> w <- NULL
> for (i in 1:length(v)) {w[i] <- v[i]^2}
> w
[1] 1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400
However, you can do the same thing using an “apply” statement like this:
> v <- 1:20
> w <- sapply(v, function(i) {i^2})
> w

I think it’s more clear what the second code snippet does: it applies the function to
each element in v. (Additionally, the apply function will be faster. See “Lookup
Performance in R” on page 509 for more information.
By the way, it is possible to define an anonymous function and apply it directly to
an argument. Here’s an example:
> (function(x) {x+1})(1)
[1] 2
Notice that the function object needs to be enclosed in parentheses. This is because
function calls, expressions of the form f(arguments), have very high precedence
in R.

R includes a set of functions for getting more information about function objects.
To see the set of arguments accepted by a function, use the args function. The
args function returns a function object with NULL as the body. Here are a few
examples:
> args(sin)
function (x)
NULL
> args(`?`)
function (e1, e2)
NULL
> args(args)
function (name)
NULL
> args(lm)
function (formula, data, subset, weights, na.action, method = "qr",
model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE,
contrasts = NULL, offset, ...)
NULL
3. If you omit the parentheses in this example, you will not initially get an error:
> function(x) {x+1}(1)
function(x) {x+1}(1)
This is because you will have created an object that is a function taking one argument (x) with
the body {x+1}(1). There is no error generated because the body is not evaluated. If you were
to assign this object to a symbol (so that you can easily apply it to an argument and see what
it does), you will find that this function attempts to call a function returned by evaluating the
expression {x + 1}. In order not to get an error or an input of class c, you would need to register
a generic function that took as input an object of class c (x in this expression) and a numerical
value (1 in this expression) and returned a function object. So omitting the parentheses is not
wrong; it is a valid R expression. However, this is almost certainly not what you meant to write.
If you would like to manipulate the list of arguments with R code, then you may find
the formals function more useful. The formals function will return a pairlist object,
with a pair for every argument. The name of each pair will correspond to each ar
gument name in the function. When a default value is defined, the corresponding
value in the pairlist will be set to that value. When no default is defined, the value
will be NULL. The formals function is available only for functions written in R (objects
of type closure) and not for built-in functions.
Here is a simple example of using formals to extract information about the argu
ments to a function:
> f <- function(x, y=1, z=2) {x + y + z}
> f.formals <- formals(f)
> f.formals
$x
$y
[1] 1
$z
[1] 2
> f.formals$x
> f.formals$y
[1] 1
> f.formals$z
[1] 2
You may also use formals on the left-hand side of an assignment statement to change
the formal argument for a function. For example:
> f.formals$y <- 3
> formals(f) <- f.formals
> args(f)
function (x, y = 3, z = 2)
NULL
R provides a convenience function called alist to construct an argument list. You
simply specify the argument list as if you were defining a function. (Note that for an
argument with no default, you do not need to include a value but still need to include
the equals sign.)
> f <- function(x, y=1, z=2) {x + y + z}
> formals(f) <- alist(x=, y=100, z=200)
> f
function (x, y = 100, z = 200)
{
x + y + z
}
R provides a similar function called body that can be used to return the body of a
function:

> args(sin)
function (x)
NULL
> args(`?`)
function (e1, e2)
NULL
> args(args)
function (name)
NULL
> args(lm)
function (formula, data, subset, weights, na.action, method = "qr",
model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE,
contrasts = NULL, offset, ...)
NULL

> body(f)
{
x + y + z
}
Like the formals function, the body function may be used on the left-hand side of an
assignment statement:
> f
function (x, y = 3, z = 2)
{
x + y + z
}
> body(f) <- expression({x * y * z})
> f
function (x, y = 3, z = 2)
{
x * y * z
}
Note that the body of a function has type expression, so when you assign a new
value it must have the type expression.


Argument Order and Named Arguments
When you specify a function in R, you assign a name to each argument in the func
tion. Inside the body of the function, you can access the arguments by name. For
example, consider the following function definition:
> addTheLog <- function(first, second) {first + log(second)}
This function takes two arguments, called first and second. Inside the body of the
function, you can refer to the arguments by these names.
When you call a function in R, you can specify the arguments in three different ways
(in order of priority):
1. Exact names. The arguments will be assigned to full names explicitly given in
the argument list. Full argument names are matched first:
> addTheLog(second=exp(4), first=1)
[1] 5
2. Partially matching names. The arguments will be assigned to partial names ex
plicitly given in the arguments list:
> addTheLog(s=exp(4), f=1)
[1] 5
3. Argument order. The arguments will be assigned to names in the order in which
they were given:
> addTheLog(1, exp(4))
[1] 5


> f <- function(arg1=10, arg2=20) {
+  print(paste("arg1:", arg1))
+  print(paste("arg2:", arg2))
+ }
When you call this function with one ambiguous argument, it will cause an error:
> f(arg=1)
Error in f(arg = 1) : argument 1 matches multiple formal arguments
However, when you specify two arguments, the ambiguous argument could refer to
either of the other arguments:
> f(arg=1, arg2=2)
[1] "arg1: 1"
[1] "arg2: 2"
> f(arg=1, arg1=2)
[1] "arg1: 2"
[1] "arg2: 1"


In particular, you define a class with a call
to a function (setClass) and define a method with a call to another function
(setMethod). Before we describe R’s implementation of object-oriented programming
in depth, let’s look at a quick example.


Let’s implement a class representing a time series. We’ll want to define a new object
that contains the following information:
• A set of data values, sampled at periodic intervals over time
• A start time
• An end time
• The period of the time series
Clearly, some of this information is redundant; given many of the attributes of a time
series, we can calculate the remaining attributes. Let’s start by defining a new class
called “TimeSeries.” We’ll represent a time series by a numeric vector containing
the data, a start time, and an end time. We can calculate units, frequency, and period
from the start time, end time, and the length of the data vector. As a user of the class,
it shouldn’t matter how we represent this information, but it does matter to the
implementer.
In R, the places where information is stored in an object are called slots. We’ll name
the slots data, start, and end. To create a class, we’ll use the setClass function:
> setClass("TimeSeries",
+  representation(
+  data="numeric",
+  start="POSIXct",
+  end="POSIXct"
+  )
+ )
The representation explains the class of the object contained in each slot. To create
a new TimeSeries object, we will use the new function. (The new function is a generic
constructor method for S4 objects.) The first argument specifies the class name; other
arguments specify values for slots:
> my.TimeSeries <- new("TimeSeries",
+  data=c(1, 2, 3, 4, 5, 6),
+ start=as.POSIXct("07/01/2009 0:00:00", tz="GMT",
+  format="%m/%d/%Y %H:%M:%S"),
+ end=as.POSIXct("07/01/2009 0:05:00", tz="GMT",
+  format="%m/%d/%Y %H:%M:%S")
+ )
Overview of Object-Oriented Progr

We can specify this with the setValidity
function:
> setValidity("TimeSeries",
+  function(object) {
+  object@start <= object@end &&
+  length(object@start) == 1 &&
+  length(object@end) == 1
+  }
+  )
Class "TimeSeries" [in ".GlobalEnv"]
Slots:
Name: data start end
Class: numeric POSIXct POSIXct
You can now check that a TimeSeries object is valid with the validObject function:
> validObject(my.TimeSeries)
[1] TRUE
When we try to create a new TimeSeries object, R will check the validity of the new
object and reject bad objects:
> good.TimeSeries <- new("TimeSeries",
+ data=c(7, 8, 9, 10 ,11, 12),
+ start=as.POSIXct("07/01/2009 0:06:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S"),
+ end=as.POSIXct("07/01/2009 0:11:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S")
+ )
> bad.TimeSeries <- new("TimeSeries",
+ data=c(7, 8, 9, 10, 11, 12),
+ start=as.POSIXct("07/01/2009 0:06:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S"),
+ end=as.POSIXct("07/01/1999 0:11:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S")
+ )
Error in validObject(.Object) : invalid class "TimeSeries" object: FALSE

(You can also specify the validity method at the time you are creating a class; see the
full definition of setClass for more information.)
Now that we have defined the class, let’s create some methods that use the class.
One property of a time series is its period. We can create a method for extracting
the period from the time series. This method will calculate the duration between
observations based on the length of the vector in the data slot, the start time, and
the end time:
> period.TimeSeries <- function(object) {
+  if (length(object@data) > 1) {
+  (object@end - object@start) / (length(object@data) - 1)
+  } else {
+ Inf
+ }
+ }
Suppose that you wanted to create a set of functions to derive the data series from
Programming
other objects (when appropriate), regardless of the type of object (i.e., polymorphism). R provides a mechanism called generic functions for doing this.2 You can
define a generic name for a set of functions (like “series”). When you call “series”
on an object, R will find the correct method to execute based on the class of the
object. Let’s create a function for extracting the data series from a generic object:
> series <- function(object) {object@data}
> setGeneric("series")
[1] "series"
> series(my.TimeSeries)
[1] 1 2 3 4 5 6
The call to setGeneric redefined series as a generic function whose default method
is the old body for series:
> series
standardGeneric for "series" defined from package ".GlobalEnv"
function (object)
standardGeneric("series")
<environment: 0x19ac4f4>
Methods may be defined for arguments: object
Use showMethods("series") for currently available ones.
> showMethods("series")
Function: series (package .GlobalEnv)
object="ANY"
object="TimeSeries"
 (inherited from: object="ANY")
As a further example, suppose we wanted to create a new generic function called
“period” for extracting a period from an object and wanted to specify that the function period.TimeSeries should be used for TimeSeries objects, but the generic
method should be used for other objects. We could do this with the following
commands:
2. In object-oriented programming terms, this is called overloading a function.
> period <- function(object) {object@period}
> setGeneric("period")
[1] "period"
> setMethod(period, signature=c("TimeSeries"), definition=period.TimeSeries)
[1] "period"
attr(period,"package")
[1] ".GlobalEnv"
> showMethods("period")
Function: period (package .GlobalEnv)
object="ANY"
object="TimeSeries"
Now we can calculate the period of a TimeSeries object by just calling the generic
function period:
> period(my.TimeSeries)
Time difference of 1 mins
It is also possible to define your own methods for existing generic functions, such
as summary. Let’s define a summary method for our new class:
> setMethod("summary",
+ signature="TimeSeries",
+ definition=function(object) {
+ print(paste(object@start,
+  " to ",
+  object@end,
+ sep="", collapse=""))
+ print(paste(object@data, sep="", collapse=","))
+ }
+ )
Creating a new generic function for "summary" in ".GlobalEnv"
[1] "summary"
> summary(my.TimeSeries)
[1] "2009-07-01 to 2009-07-01 00:05:00"
[1] "1,2,3,4,5,6"
You can even define a new method for an existing operator:
> setMethod("[",
+  signature=c("TimeSeries"),
+  definition=function(x, i, j, ...,drop) {
+  x@data[i]
+  }
+ )
[1] "["
> my.TimeSeries[3]
[1] 3
(As a quick side note, this works for only some built-in functions. For example, you
can’t define a new print method this way. See the help file for S4groupGeneric for a
list of generic functions that you can redefine this way, and “Old-School OOP in R:
S3” on page 135 for an explanation on why this doesn’t always work.)

Now let’s show how to implement a WeightHistory class based on the TimeSeries
class. One way to do this is to create a WeightHistory class that inherits from the
TimeSeries class but adds extra fields to represent a person’s name and height. We
can do this with the setClass command by stating that the new class inherits from
the TimeSeries class and specifying the extra slots in the WeightHistory class:
> setClass(
+  "WeightHistory",
+  representation(
+  height = "numeric",
+  name = "character"
+  ),
+  contains = "TimeSeries"
+ )
Now we can create a WeightHistory object, populating slots named in TimeSeries
and the new slots for WeightHistory:
> john.doe <- new("WeightHistory",
+  data=c(170, 169, 171, 168, 170, 169),
+  start=as.POSIXct("02/14/2009 0:00:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S"),
+ end=as.POSIXct("03/28/2009 0:00:00",tz="GMT",
+  format="%m/%d/%Y %H:%M:%S"),
+ height=72,
+ name="John Doe")
> john.doe
An object of class “WeightHistory”
Slot "height":
[1] 72
Slot "name":
[1] "John Doe"
Slot "data":
numeric(0)
Slot "start":
[1] "2009-02-14 GMT"
Slot "end":
[1] "2009-03-28 GMT"
R will validate that the new TimeSeries object contained within WeightHistory is
valid. (You can test this yourself.)
Let’s consider an alternative way to construct a weight history. Suppose that we had
created a Person class containing a person’s name and height:
> setClass(
+  "Person",
+  representation(
+  height = "numeric",
+  name = "character"
+  )
+ )
Programming
Now we can create an alternative weight history that inherits from both a
TimeSeries object and a Person object:
> setClass(
+  "AltWeightHistory",
+  contains = c("TimeSeries", "Person")
+ )
This alternative implementation works identically to the original implementation,
but the new implementation is slightly cleaner. This implementation inherits meth
ods from both the TimeSeries and the Person classes.
Suppose that we also had created a class to represent cats:
> setClass(
+  "Cat",
+  representation(
+  breed = "character",
+  name = "character"
+  )
+ )
Notice that both Person and Cat objects contain a name attribute. Suppose that we
wanted to create a method for both classes that checked if the name was “Fluffy.”
An efficient way to do this in R is to create a virtual class that is a superclass of both
the Person and the Cat classes and then write an is.fluffy method for the superclass.
(You can write methods for a virtual class but can’t create objects from that class
because the representation of those objects is ambiguous.)
> setClassUnion(
+  "NamedThing",
+  c("Person", "Cat")
+ )
We could then create an is.fluffy method for the NamedThing class that would apply
to both Person and Cat objects. (Note that if we were to define a method of
is.fluffy for the Person class, this would override the method from the parent class.)
An added benefit is that we could now check to see if an object was a NamedThing:
> jane.doe <- new("AltWeightHistory",
+  data=c(130, 129, 131, 128, 130, 129),
+  start=as.POSIXct("02/14/2009 0:00:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S"),
+ end=as.POSIXct("03/28/2009 0:00:00", tz="GMT",
+ format="%m/%d/%Y %H:%M:%S"),
+ height=67,
+ name="Jane Doe")
> is(jane.doe,"NamedThing")
[1] TRUE
> is(john.doe,"TimeSeries")
[1] TRUE



#####################################
Object-Oriented Programming in R: S4 Classes
Now that we’ve seen a quick introduction to object-oriented programming in R, let’s
talk about the functions for building classes in more depth.
Defining Classes
To create a new class in R, you use the setClass function:
setClass(Class, representation, prototype, contains=character(),
validity, access, where, version, sealed, package,
S3methods = FALSE)
Here is a description of the arguments to setClass.
Argument Description Default
Class A character value specifying the name for the new class. (This
is the only required argument.)
representation A named list of the different slots in the class and the object
name associated with each one. (You can specify “ANY” if you
want to allow arbitrary objects to be stored in the slot.)
prototype An object containing the default object for slots in the class.
contains A character vector containing the names of the classes that
this class extends (usually called superclasses).
character()
validity A function that checks the validity of an object of this class.
(Default is no validity check.) May be changed later with
setValidity.
access Not used; included for compatibility with S-PLUS.
where The environment in which to store the object definition. Default is the environment in which
setClass was called.
version Not used; included for compatibility with S-PLUS.
sealed A logical value to indicate if this class can be redefined by calling
setClass again with the same class name.
package A character value specifying the package name for this class. Default is the name of the package
in which setClass was called.
S3methods A logical value specifying whether S3 methods may be written
for this class.
FALSE
To simplify the creation of new classes, the methods package includes two functions
for creating the representation and prototype arguments, called representation and
prototype. These functions are very helpful when defining classes that extend other
classes as a data part, have multiple superclasses, or combine extending a class and
slots.
Some slot names are prohibited in R because they are reserved for attributes. (By the
way, objects can have both slots and attributes.) Forbidden names include "class",
"comment", "dim", "dimnames", "names", "row.names" and "tsp".

Working with Objects
To test whether an object o is a member of a class c, you can use the function
is(o, c). To test whether a class c1 extends a second class c2, you can use the
function extends(c1, c2).
To get a list of the slots associated with an object o, you can use the function slot
Names(o). To get the classes associated with those slots, use getSlots(o). To determine
the names of the slots in a class c, you can use the function slotNames(c). Somewhat
nonintuitively, getSlots(c) returns the set of classes associated with each slot.

Creating Coercion Methods
It is possible to convert an object o to class c by calling as(o, c).
To enable coercion for a class that you define, make sure to register coercion methods
with the setAs function:
setAs(from, to, def, replace, where = topenv(parent.frame()))
This function takes the following arguments.
Argument Description Default
from A character value specifying the class name of the input object.
to A character value specifying the class name of the output object.
def A function that takes an argument of type from and returns a value of type
to. In other words, a function that performs the conversion.
replace A second function that may be used in a replacement method (that is, the
method to use if the as function is used as the destination in an assignment
statement). This is a function of two arguments: from and value.
where The environment in which to store the definition. topenv(parent.frame())

Methods
In Chapter 9, we showed how to use functions in R. An important part of a function
definition in R is the set of arguments for a function. As you may recall, a function
accepts only one set of arguments. When you assign a function directly to a symbol,
you can only call that function with a single set of arguments.
Generic functions are a system for allowing the same name to be used for many
different functions, with many different sets of arguments, from many different
classes.
Suppose that you define a class called meat and a class called dairy and a method
called serve. In R, you could assign one function to serve a meat object and another
function to serve a dairy object. You could even assign a third function that took
both a meat object and a dairy object as arguments and allowed you to serve both
of them together. This would not be kosher in some other languages, but it’s OK
in R.3
The first step in assigning methods is to create an appropriate generic function (if
the function doesn’t already exist). To do this, you use the setGeneric function to
create a generic method:
setGeneric(name, def= , group=list(), valueClass=character(),
where= , package= , signature= , useAsDefault= ,
genericFunction= , simpleInheritanceOnly = )
This function takes the following arguments.
Argument Description
name A character value specifying the name of the generic function.
def An optional function defining the generic function.
group An optional character value specifying the group generic to which this function belongs. See
the help file for S4groupGeneric for more information.
valueClass An optional character value specifying the name of the class (or classes) to which objects
returned by this function must belong.
where The environment in which to store the new generic function.
package A character value specifying the package name with which the generic function is associated.
signature An optional character vector specifying the names of the formal arguments (as labels) and
classes for the arguments to the function (as values). The class name “ANY” can be used to
mean that arguments of any type are allowed.
useAsDefault A logical value or function specifying the function to use as the default method. See the help
file for more information.
genericFunction Not currently used.
simpleInheritanceOnly A logical value specifying whether to require that methods be inherited through simple in
heritance only.
3. In technical terms, R’s implementation is called parametric polymorphism.
To associate a method with a class (or, more specifically, a signature with a generic
function), you use the setMethod function:
setMethod(f, signature=character(), definition,
where = topenv(parent.frame()),
valueClass = NULL, sealed = FALSE)
Here is a description of the arguments for setMethod.
Argument Description Default
f A generic function or the name of a generic function.
signature A vector containing the names of the formal arguments (as
labels) and classes for the arguments to the function (as
values). The class name “ANY” can be used to mean that
arguments of any type are allowed.
character()
definition The function to be called when the method is evaluated.
where The environment in which the method was defined. topenv(parent.frame())
valueClass Not used; included for backward compatibility. NULL
sealed Used to indicate if this class can be redefined by calling
setClass again with the same class name.
FALSE
Managing Methods
The methods package includes a number of functions for managing generic methods.
Function Description
isGeneric Checks if there is a generic function with the given name.
isGroup Checks if there is a group generic function with the given name.
removeGeneric Removes all the methods for a generic function and the generic function itself.
dumpMethod Dumps the method for this generic function and signature.
findFunction Returns a list of either the positions on the search list or the current top-level environment
on which a function object for a given name exists.
dumpMethods Dumps all the methods for a generic function.
signature Returns the names of the generic functions that have methods defined on a specific path.
removeMethods Removes all the methods for a generic function.
setGeneric Creates a new generic function of the given name.
The methods package also includes functions for managing methods.
Function Description
getMethod,
selectMethod
Returns the method for a particular function and signature.
existsMethod,
hasMethod
Tests if a method (specified by a specific name and signature) exists.
Function Description
findMethod Returns the package(s) that contain a method for this function and signature.
showMethods Shows the set of methods associated with an S4 generic.
For more information on these functions, see the corresponding help files.
Basic Classes
Classes for built-in types are shown in Table 10-1; these are often called basic
classes. All classes are built on top of these classes. Additionally, it is possible to write
new methods for these classes that override the defaults.
Table 10-1. Classes of built-in types
Category Object Type Class
Vectors integer integer
double numeric
complex complex
character character
logical logical
raw raw
Compound list list
pairlist pairlist
S4
environment environment
Special any
NULL NULL
...
R language symbol name
promise
language call
expression expression
externalptr externalptr
Functions closure function
special function
builtin function
The vector classes (integer, numeric, complex, character, logical, and raw) all extend
the vector class. The vector class is a virtual class.

More Help
Many tools for working with classes are included in the methods package, so you can
find additional help on classes with the command library(help="methods").
Old-School OOP in R: S3
If you want to implement a complex project in R, you should use S4 objects and
classes. As we saw above, S4 classes implement many features of modern object
oriented programming languages: formal class definitions, simple and multiple in
heritance, parameteric polymorphism, and encapsulation. Unfortunately, S3 classes
are implemented and used differently from S4 objects and don’t implement many
features that enable good software engineering practices.
Unfortunately, it’s very hard to avoid S3 objects in R because many important and
commonly used R functions were written before S4 objects were implemented. For
example, most of the modeling tools in the statistics package were written with S3
objects. In order to understand, modify, or extend this software, you have to know
how S3 classes are implemented.
S3 Classes
S3 classes are implemented through object attributes. An S3 object is simply a prim
itive R object with additional attributes, including a class name. There is no formal
definition for an S3 object; you can manually change the attributes, including the
class. (S3 objects are very similar to objects in prototype-based languages such as
JavaScript.)
Above, we used time series as an example of an S4 class. There is an existing S3 class
for representing time series, called “ts” objects. Let’s create a sample time series
object and look at how it is implemented. Specifically, we’ll look at the attributes of
the object and then use typeof and unclass to examine the underlying object:
> my.ts <- ts(data=c(1, 2, 3, 4, 5), start=c(2009, 2), frequency=12)
> my.ts
Feb Mar Apr May Jun
2009 1 2 3 4 5
> attributes(my.ts)
$tsp
[1] 2009.083 2009.417 12.000
$class
[1] "ts"
> typeof(my.ts)
[1] "double"
> unclass(my.ts)
[1] 1 2 3 4 5
attr(,"tsp")
[1] 2009.083 2009.417 12.000
As you can see, a ts object is just a numeric vector (of doubles), with two attributes:
class and tsp. The class attribute is just the name “ts,” and the tsp attribute is just
a vector with a start time, end time, and frequency. You can’t access attributes in an
S3 object using the same operator that you use to access slots in an S4 object:
> my.ts@tsp
Error: trying to get slot "tsp" from an object (class "ts")
that is not an S4 object
S3 classes lack the structure of S3 objects. Inheritance is implemented informally,
and encapsulation is not enforced by the language.4 S3 classes also don’t allow
parametric polymorphism. S3 classes do, however, allow simple polymorphism. It
is possible to define S3 generic functions and to dispatch by object type.
S3 Methods
S3 generic functions work by naming convention, not by explicitly registering meth
ods for different classes. Here is how to create a generic function using S3 classes:
1. Pick a name for the generic function. We’ll call this gname.
2. Create a function named gname. In the body for gname, call UseMethod("gname").
3. For each class that you want to use with gname, create a function called
gname.classname whose first argument is an object of class classname.
Rather than fabricating an example, let’s look at an S3 generic function in R: plot:
> plot
function (x, y, ...)
UseMethod("plot")
<bytecode: 0x106c21140>
<environment: namespace:graphics>
When you call plot on a function, plot calls UseMethod("plot"). UseMethod looks at
the class of the object x. It then looks for a function named plot. class and calls
plot. class(x, y, ...).
For example, we defined a new TimeSeries class above. To add a plot method for
TimeSeries objects, we simply create a function named plot.TimeSeries:
> plot.TimeSeries <- function(object, ...) {
+  plot(object@data, ...)
+ }
So we could now call:
> plot(my.TimeSeries)
and R would, in turn, call plot.TimeSeries(my.TimeSeries).
The function UseMethod dispatches to the appropriate method, depending on the
class of the first argument’s calling function. UseMethod iterates through each class
4. If the attribute class is a vector with more than one element, then the first element is interpreted
as the class of the object, and other elements name classes that the object “inherits” from. That
makes inheritance a property of objects, not classes.
in the object’s class vector, until it finds a suitable method. If it finds no suitable
method, UseMethod looks for a function for the class “default.” (A closely related
function, NextMethod, is used in a method called by UseMethod; it calls the next avail
able method for an object. See the help file for more information.)
Using S3 Classes in S4 Classes
You can’t specify an S3 class for a slot in an S4 class. To use an S3 class as a slot in
an S4 class, you need to create an S4 class based on the S3 class. A simple way to do
this is through the function setOldClass:
setOldClass(Classes, prototype, where, test = FALSE, S4Class)
This function takes the following arguments.
Argument Description Default
Classes A character vector specifying the names of the old-style classes.
prototype An object to use as a prototype; this will be used as the default object for
the S4 class.
where An environment specifying where to store the class definition. The top-level environment
test A logical value specifying whether to explicitly test inheritance for the
object. Specify test=TRUE if there can be multiple inheritance.
FALSE
S4Class A class definition for an S4 class or a class name for an S4 class. This will be
used to define the new class.
Finding Hidden S3 Methods
Sometimes, you may encounter cases where individual methods are hidden. The
author of a package may choose to hide individual methods in order to encapsulate
details of the implementation within the package; hiding methods encourages you
to use the generic functions. For example, individual methods for the generic method
histogram (in the lattice package) are hidden:
> library(lattice)
> methods(histogram)
[1] histogram.factor* histogram.formula* histogram.numeric*
Nonvisible functions are asterisked > histogram.factor()
Error: could not find function "histogram.factor"
Sometimes, you might want to retrieve the hidden methods (for example, to view
the R code). To retrieve the hidden method, use the function getS3method. For ex
ample, to fetch the code for histogram.formula, try the following command:
> getS3method(f="histogram", class="formula")
Alternatively, you can use the function getAnywhere:
> getAnywhere(histogram.formula)


## create a new generic function, with a default method
setGeneric("props", function(object) attributes(object))

## A new generic function with no default method
setGeneric("increment",
  function(object, step, ...)
    standardGeneric("increment")
)


###   A non-standard generic function.  It insists that the methods
###   return a non-empty character vector (a stronger requirement than
###    valueClass = "character" in the call to setGeneric)

setGeneric("authorNames",
    function(text) {
      value <- standardGeneric("authorNames")
      if(!(is(value, "character") && any(nchar(value)>0)))
        stop("authorNames methods must return non-empty strings")
      value
      })



## An example of group generic methods, using the class
## "track"; see the documentation of 'setClass' for its definition

## define a method for the Arith group

setMethod("Arith", c("track", "numeric"),
 function(e1, e2) {
  e1@y <- callGeneric(e1@y , e2)
  e1
})

setMethod("Arith", c("numeric", "track"),
 function(e1, e2) {
  e2@y <- callGeneric(e1, e2@y)
  e2
})

## now arithmetic operators  will dispatch methods:

t1 <- new("track", x=1:10, y=sort(stats::rnorm(10)))

t1 - 100
1/t1

library(help="methods")



sp500 <- read.csv(paste("http://ichart.finance.yahoo.com/table.csv?",
"s=%5EGSPC&a=03&b=1&c=1999&d=03&e=1&f=2009&g=m&ignore=.csv", sep=""))

As an alternative, I’d suggest using a scripting language like Perl, Python, or Ruby
to preprocess large, complex text files and turn them into a digestible form. (As a
side note, I usually write out lists of field names and lengths in Excel and then use
Excel formulas to create the R or Perl code to load them. That’s how I generated
all the code shown in this example.) Here’s the Perl script I used to preprocess the
raw mortality data file, filtering out fields I didn’t need and writing the results to
a CSV file:
#!/usr/bin/perl
# file to preprocess (and filter) mortality data
print "ResidentStatus,Education1989,Education2003,EducationFlag," .
 "MonthOfDeath,Sex,AgeDetail,AgeSubstitution,AgeRecode52," .
 "AgeRecode27,AgeRecode12,AgeRecodeInfant22,PlaceOfDeath," .
 "MaritalStatus,DayOfWeekofDeath,CurrentDataYear,InjuryAtWork," .
 "MannerOfDeath,MethodOfDisposition,Autopsy,ActivityCode," .
"PlaceOfInjury,ICDCode,CauseRecode358,CauseRecode113," .
"CauseRecode130,CauseRecord39,Race,BridgeRaceFlag," .
"RaceImputationFlag,RaceRecode3,RaceRecord5,HispanicOrigin," .
"HispanicOriginRecode\n";
while(<>) {
my ($X0,$ResidentStatus,$X1,$Education1989,$Education2003,
$EducationFlag,$MonthOfDeath,$X5,$Sex,$AgeDetail,
$AgeSubstitution,$AgeRecode52,$AgeRecode27,$AgeRecode12,
$AgeRecodeInfant22,$PlaceOfDeath,$MaritalStatus,
$DayOfWeekofDeath,$X15,$CurrentDataYear,$InjuryAtWork,
$MannerOfDeath,$MethodOfDisposition,$Autopsy,$X20,$ActivityCode,
$PlaceOfInjury,$ICDCode,$CauseRecode358,$X24,$CauseRecode113,
$CauseRecode130,$CauseRecord39,$X27,$Race,$BridgeRaceFlag,
$RaceImputationFlag,$RaceRecode3,$RaceRecord5,$X32,
$HispanicOrigin,$X33,$HispanicOriginRecode,$X34)
= unpack("a19a1a40a2a1a1a2a2a1a4a1a2a2a2a2a1a1a1a16a4a1" .
"a1a1a1a34a1a1a4a3a1a3a3a2a283a2a1a1a1a1a33a3a1a1",
$_);
print "$ResidentStatus,$Education1989,$Education2003,".
"$EducationFlag,$MonthOfDeath,$Sex,$AgeDetail,".
"$AgeSubstitution,$AgeRecode52,$AgeRecode27,".
"$AgeRecode12,$AgeRecodeInfant22,$PlaceOfDeath," .
"$MaritalStatus,$DayOfWeekofDeath,$CurrentDataYear,".
"$InjuryAtWork,$MannerOfDeath,$MethodOfDisposition,".
"$Autopsy,$ActivityCode,$PlaceOfInjury,$ICDCode,".
"$CauseRecode358,$CauseRecode113,$CauseRecode130,".
"$CauseRecord39,$Race,$BridgeRaceFlag,$RaceImputationFlag,".
"$RaceRecode3,$RaceRecord5,$HispanicOrigin," .
"$HispanicOriginRecode\n";
}
I executed this script with the following command (in an OS shell):
$ perl mortalities.pl < MORT06.DUSMCPUB > MORT06.csv
You can now load the data into R with a line like this:
> mort06 <- read.csv(file="~/Documents/book/data/MORT06.csv")
We’ll come back to this data set in the chapters on statistical tests and statistical
models.

readLines(con = stdin(), n = -1L, ok = TRUE, warn = TRUE,
encoding = "unknown")

The readLines function will return a character vector, with one value corresponding
to each row in the file. Here is a description of the arguments to readLines.
Argument Description Default
con A character string (specifying a file or URL) or a connection containing the data to read. stdin()
n An integer value specifying the number of lines to read. (Negative values mean “read
until the end of the file.”)
-1L
ok A logical value specifying whether to trigger an error if the number of lines in the file is
less than n.
TRUE
warn A logical value specifying whether to warn the user if the file does not end with an EOL. TRUE
encoding A character value specifying the encoding of the input file. "unknown"

scan(file = "", what = double(0), nmax = -1, n = -1, sep = "",
quote = if(identical(sep, "\n")) "" else "'\"", dec = ".",
skip = 0, nlines = 0, na.strings = "NA",
flush = FALSE, fill = FALSE, strip.white = FALSE,
quiet = FALSE, blank.lines.skip = TRUE, multi.line = TRUE,
comment.char = "", allowEscapes = FALSE,
encoding = "unknown")
The scan function allows you to read the contents of a file into R. Unlike readLines,
scan allows you to read data into a specifically defined data structure using the ar
gument what.
Here is a description of the arguments to scan.
Argument Description Default
file A character string (specifying a file or URL) or a connection
containing the data to read.
""
what The type of data to be read. If all fields are the same type,
you can specify logical, integer, numeric, complex, charac
ter, or raw. Otherwise, specify a list of types to read values
into a list. (You can specify the type of each element in the
list individually.)
double(0)
nmax An integer value specifying the number of values to read
or the number of records to read (if what is a list).
(Negative values mean “read until the end of the file.”)
-1
n An integer value specifying the number of values to read.
(Negative values mean “read until the end of the file.”)
-1
sep Character value specifying the separator between values.
sep=""  means that any white space character is inter
preted as a separator.
“”
quote Character value used to quote strings. if(identical(sep,
"\n")) "" else
"'\""
Argument Description Default
dec Character value used for decimal place in numbers. "."
skip Number of lines to skip at the top of the file. 0
nlines Number of lines of data to read. Nonpositive values mean
that there is no limit.
0
na.strings Character values specifying how NA values are encoded. "NA"
flush A logical value specifying whether to “flush” any remaining
text on a line after the last requested item on a line is read
into what. (Commonly used to allow comments at the end
of lines or to ignore unneeded fields.)
FALSE
fill Specifies whether to add empty fields to lines with fewer
fields than specified by what.
FALSE
strip.white Specifies whether to strip leading and trailing white space
from character fields. Applies only when sep is specified.
FALSE
quiet Ifquiet=FALSE, scan will print a message showing how
many lines were read. Ifquiet=TRUE, then this message
is suppressed.
FALSE
blank.lines.skip Specifies whether to ignore blank lines. TRUE
multi.line If what is a list, allows records to span multiple lines. TRUE
comment.char Notes a character to be used to specify comment lines. ""
allowEscapes Specifies whether C-style escapes (such as \t for Tab char
acter or \n for newlines) should be interpreted by scan or
read verbatim. IfallowEscapes=FALSE, then they are
interpreted as special characters; if allowE
scapes=TRUE, then they are read literally.
FALSE
encoding A character value specifying the encoding of the input file. "unknown"

File format Reading Writing
ARFF read.arff write.arff
DBF read.dbf write.dbf
Stata read.dta write.dta
Epi Info read.epi
info
Minitab read.mtp
Octave read.octa
ve
S3 binary files, data.dump files read.S
SPSS read.spss
SAS Permanent Dataset read.ssd
Systat read.sys
stat
SAS XPORT File read.xpor
t

Exporting Data
R can also export R data objects (usually data frames and matrices) as text files. To
export data to a text file, use the write.table function:
write.table(x, file = "", append = FALSE, quote = TRUE, sep = " ",
eol = "\n", na = "NA", dec = ".", row.names = TRUE,
col.names = TRUE, qmethod = c("escape", "double"))
There are wrapper functions for write.table that call write.table with different
defaults. These are useful if you want to create a file of comma-separated values, for
example, to import into Microsoft Excel:
write.csv(...)
write.csv2(...)
Here is a description of the arguments to write.table.
Argument Description Default
x Object to export.
file Character value specifying a filename or a connection object to which you would like to
write the output.
""
append A logical value indicating whether to append the output to the end of an existing file
(append=TRUE) or replace the file (append=FALSE).
FALSE
quote A logical value specifying whether to surround any character or factor values with quotes,
or a numeric vector specifying which columns to surround with quotes.
TRUE
sep A character value specifying the value that separates values within a row. ""
Argument Description Default
eol A character value specifying the value to append on the end of each line. "\n"
na A character value specifying how to represent NA values. "NA"
dec A character value specifying the decimal separator in numeric values. "."
row.names A logical value indicating whether to include row names in the output or a numeric vector
specifying the rows from which row names should be included.
TRUE
col.names A logical value specifying whether to include column names or a character vector specifying
alternate names to include.
TRUE
qmethod Specifies how to deal with quotes inside quoted character and factor fields. Specify
qmethod="escape"  to escape quotes with a backslash (as in C) or
qmethod="double"  to escape quotes as double quotes (i.e., “ is transformed to “”).
"escape"
Importing Data From Databases
It is very common for large companies, healthcare providers, and academic institu
tions to keep data in relational databases. This section explains how to move data
from databases into R.
Export Then Import
One of the best approaches for working with data from a database is to export the
data to a text file and then import the text file into R. In my experience dealing with
very large data sets (1 GB or more), I’ve found that you can import data into R at a
much faster rate from text files than you can from database connections.
For directions on how to import these files into R, see “Text Files” on page 146.
If you plan to extract a large amount of data once and then analyze the data, this is
often the best approach. However, if you are using R to produce regular reports or
to repeat an analysis many times, then it might be better to import data into R directly
through a database connection.
Database Connection Packages
In order to connect directly to a database from R, you will need to install some
optional packages. The packages you need depend on the database(s) to which you
want to connect and the connection method you want to use.
There are two sets of database interfaces available in R:
• RODBC. The RODBC package allows R to fetch data from ODBC (Open
DataBase Connectivity) connections. ODBC provides a standard interface for
different programs to connect to databases.
• DBI. The DBI package allows R to connect to databases using native database
drivers or JDBC drivers. This package provides a common database abstraction
for R software. You must install additional packages to use the native drivers
for each database.
To use this free driver, you’ll need to compile and
install the driver yourself. Luckily, this process works flawlessly on Mac OS X
10.5.6.1 Here is how to install the drivers on Mac OS X:
1. Download the latest sources from http://www.ch-werner.de/sqliteodbc/. (Do not
download the precompiled version.) I used sqliteodbc-0.80.tar.gz. You can do
this with this command:
% wget http://www.ch-werner.de/sqliteodbc/sqliteodbc-0.80.tar.gz
2. Unpack and unzip the archive. You can do this with this command:
% tar xvfz sqliteodbc-0.80.tar.gz
3. Change to the directory of sources files:
% cd sqliteodbc-0.80
4. Configure the driver for your platform, compile the driver, and then install it.
You can do this with these commands:
% ./configure
% make
% sudo make install
Now you need to configure your Mac to use this driver.
1. Open the ODBC Administrator program (usually in /Applications/Utilities).
2. Select the Drivers tab and click Add.
3. Enter a name for the driver (like “SQLite ODBC Driver”) in the Description
field. Enter “/usr/local/lib/libsqlite3odbc.dylib” in the Driver File and Setup
File fields, as shown in Figure 11-4. Click the OK button.
4. Now select the User DSN tab or System DSN tab (if you want this database to
be available for all users). Click the Add button to specify the new database.
Example: SQLite ODBC on Mac OS X.
Data

The ODBC connection is now configured. You can test this with a couple of simple
commands in R (we’ll explain what these mean below):
> bbdb <- odbcConnect("bbdb")
> odbcGetInfo(bbdb)
DBMS_Name
"SQLite"
DBMS_Ver
"3.4.0"
Driver_ODBC_Ver
"03.00"
Data_Source_Name
"bbdb"
Driver_Name
"sqlite3odbc.so"
Driver_Ver
"0.80"
ODBC_Ver
"03.52.0000"
Server_Name
"/Library/Frameworks/R.framework/Resources/library/nutshell/bb.db"

odbcConnect(dsn, uid = "", pwd = "", ...)
> library(RODBC)
> bbdb <- odbcConnect("bbdb")
> sqlTables(bbdb)
TABLE_CAT TABLE_SCHEM TABLE_NAME TABLE_TYPE REMARKS
1 <NA> <NA> Allstar TABLE <NA>
2 <NA> <NA> AllstarFull TABLE <NA>
3 <NA> <NA> Appearances TABLE <NA>
4 <NA> <NA> AwardsManagers TABLE <NA>
5 <NA> <NA> AwardsPlayers TABLE <NA>
6 <NA> <NA> AwardsShareManagers TABLE <NA>
7 <NA> <NA> AwardsSharePlayers TABLE <NA>
8 <NA> <NA> Batting TABLE <NA>
9 <NA> <NA> BattingPost TABLE <NA>
10 <NA> <NA> Fielding TABLE <NA>
11 <NA> <NA> FieldingOF TABLE <NA>
12 <NA> <NA> FieldingPost TABLE <NA>
13 <NA> <NA> HOFold TABLE <NA>
14 <NA> <NA> HallOfFame TABLE <NA>
15 <NA> <NA> Managers TABLE <NA>
16 <NA> <NA> ManagersHalf TABLE <NA>
17 <NA> <NA> Master TABLE <NA>
18 <NA> <NA> Pitching TABLE <NA>
19 <NA> <NA> PitchingPost TABLE <NA>
20 <NA> <NA> Salaries TABLE <NA>
21 <NA> <NA> Schools TABLE <NA>
22 <NA> <NA> SchoolsPlayers TABLE <NA>
23 <NA> <NA> SeriesPost TABLE <NA>
24 <NA> <NA> Teams TABLE <NA>
25 <NA> <NA> TeamsFranchises TABLE <NA>
26 <NA> <NA> TeamsHalf TABLE <NA>
27 <NA> <NA> xref_stats TABLE <NA>
To get detailed information about the columns in a specific table, use the
sqlColumns function:
> sqlColumns(bbdb,"Allstar")
TABLE_CAT TABLE_SCHEM TABLE_NAME COLUMN_NAME DATA_TYPE TYPE_NAME
1 Allstar playerID 12 varchar(9)
2 Allstar yearID 5 smallint(4)
3 Allstar lgID 12 char(2)
COLUMN_SIZE BUFFER_LENGTH DECIMAL_DIGITS NUM_PREC_RADIX NULLABLE
1 9 9 10 0 0
2 4 4 10 0 0
3 2 2 10 0 0
REMARKS COLUMN_DEF SQL_DATA_TYPE SQL_DATETIME_SUB CHAR_OCTET_LENGTH
1 <NA> 12 NA 16384
2 <NA> 0 5 NA 16384
3 <NA> 12 NA 16384
ORDINAL_POSITION IS_NULLABLE
1 1 NO
2 2 NO
3 3 NO
You can also discover the primary keys for a table using the sqlPrimaryKeys function.
To fetch a table (or view) from the underlying database, you can use the sqlFetch
function. This function returns a data frame containing the contents of the table:
sqlFetch(channel, sqtable, ..., colnames = , rownames = )

You need to specify the ODBC channel with the channel argument and the table
name with the sqtable argument. You can specify whether the column names and
row names from the underlying table should be used in the data frame with the
colnames and rownames arguments. The column names from the table will be used in
the returned data frame (this is enabled by default). If you choose to use row names,
the first column in the returned data is used for column names in the data frame
(this is disabled by default). You may pass additional arguments to this function,
which are, in turn, passed to sqlQuery and sqlGetResults (described below).
As an example, let’s load the content of the Teams table into a data frame called “t”:
> teams <- sqlFetch(bbdb,"Teams")
> names(teams)
 [1] "yearID" "lgID" "teamID" "franchID"
 [5] "divID" "Rank" "G" "Ghome"
 [9] "W" "L" "DivWin" "WCWin"
[13] "LgWin" "WSWin" "R" "AB"
[17] "H" "2B" "3B" "HR"
[21] "BB" "SO" "SB" "CS"
[25] "HBP" "SF" "RA" "ER"
[29] "ERA" "CG" "SHO" "SV"
[33] "IPouts" "HA" "HRA" "BBA"
[37] "SOA" "E" "DP" "FP"
[41] "name" "park" "attendance" "BPF"
[45] "PPF" "teamIDBR" "teamIDlahman45" "teamIDretro"
> dim(teams)
[1] 2595 4

After loading the table into R, you can easily manipulate the data using R commands:
> # show wins and losses for American League teams in 2008
> subset(teams,
+  subset=(teams$yearID==2008 & teams$lgID=="AL"),
+ select=c("teamID", "W", "L"))
teamID W L
2567 LAA 100 62
2568 KCA 75 87
2571 DET 74 88
2573 CLE 81 81
2576 CHA 89 74
2577 BOS 95 67
2578 BAL 68 93
2582 MIN 88 75
2583 NYA 89 73
2585 OAK 75 86
2589 SEA 61 101
2592 TBA 97 65
2593 TEX 79 83
2594 TOR 86 76
There are related functions for writing a data frame to a database (sqlSave) or for
updating a table in a database (sqlUpdate); see the help files for these functions for
more information.
You can also execute an arbitrary SQL query in the underlying database. SQL is a
very powerful language; you can use SQL to fetch data from multiple tables, to fetch
a summary of the data in one (or more) tables, or to fetch specific rows or columns
from the database. You can do this with the sqlQuery function:
sqlQuery(channel, query, errors = , max =, ..., rows_at_time = )
This function returns a data frame containing the rows returned by the query. As an
example, we could use an SQL query to select only the data shown above (wins and
losses by team in the American League in 2008):
> sqlQuery(bbdb,
+ "SELECT teamID, W, L FROM Teams where yearID=2008 and lgID='AL'")
teamID W L
1 BAL 68 93
2 BOS 95 67
3 CHA 89 74
4 CLE 81 81
5 DET 74 88
6 KCA 75 87
7 LAA 100 62
8 MIN 88 75
9 NYA 89 73
10 OAK 75 86
11 SEA 61 101
12 TBA 97 65
13 TEX 79 83
14 TOR 86 76

If you want to fetch data from a very large table, or from a very complicated query,
you might not want to fetch all the data at one time. The RODBC library provides
a mechanism for fetching results piecewise. To do this, you begin by calling
sqlQuery (or sqlFetch), but specify a value for max, telling the function the maximum
number of rows that you want to retrieve at one time. You can fetch the remaining
rows with the sqlGetResults function:
sqlGetResults(channel, as.is = , errors = , max = , buffsize = ,
nullstring = , na.strings = , believeNRows = , dec = ,
stringsAsFactors = )
The sqlQuery function actually calls the sqlGetResults function to fetch the results
of the query. Here is a list of the arguments for these two functions. (If you are using
sqlFetch, the corresponding function to fetch additional rows is sqlFetchMore.)
Argument Description Default
channel Specifies the channel for the underlying database.
query A character value specifying the SQL query to execute.
errors A logical value specifying what to do when an error is
encountered. When errors=TRUE, the function will
stop and display the error if an error is encountered. When
errors=FALSE, a value of -1 is returned.
TRUE
max An integer specifying the maximum number of rows to
return. Specify 0 for no maximum.
0 (meaning no maximum)
rows_at_time An integer specifying the number of rows to fetch from
the ODBC connection on each call to the underlying driver;
not all drivers allow values greater than 1. (Note that this
is a performance optimization; it doesn’t mean the same
thing as themax argument. For modern drivers, the pack
age documentation suggests a value of 1,024.)
1
as.is A logical vector specifying which columns should be con
verted to factors.
FALSE
buffsize An integer used to specify the buffer size for the driver. (If
you know the approximate number of rows that a query
will return, you can specify that value to optimize perfor
mance.)
1000
nullstring Character values to be used for null values. NA
na.strings Character values to be mapped to NA values. "NA"
believeNRows A logical value that tells this function whether the row
counts returned by the ODBC driver are correct. (This is a
performance optimization.)
TRUE
dec The character used as the decimal point in decimal values. getOption("dec")
stringsAsFactors A logical value that specifies whether character value col
umns not explicitly included in as.is should be con
verted to factors.
default.stringsAsFactors()
There are related functions for writing a data frame to a database (sqlSave) or for
updating a table in a database (sqlUpdate); see the help files for these functions for
more information.

sqlQuery(channel, query, errors = , max =, ..., rows_at_time = )

sqlQuery(bbdb,
"SELECT teamID, W, L FROM Teams where yearID=2008 and lgID='AL'")

If you want to fetch data from a very large table, or from a very complicated query,
you might not want to fetch all the data at one time. The RODBC library provides
a mechanism for fetching results piecewise. To do this, you begin by calling
sqlQuery (or sqlFetch), but specify a value for max, telling the function the maximum
number of rows that you want to retrieve at one time. You can fetch the remaining
rows with the sqlGetResults function:
sqlGetResults(channel, as.is = , errors = , max = , buffsize = ,
nullstring = , na.strings = , believeNRows = , dec = ,
stringsAsFactors = )
The sqlQuery function actually calls the sqlGetResults function to fetch the results
of the query. Here is a list of the arguments for these two functions. (If you are using
sqlFetch, the corresponding function to fetch additional rows is sqlFetchMore.)
Argument Description Default
channel Specifies the channel for the underlying database.
query A character value specifying the SQL query to execute.
errors A logical value specifying what to do when an error is
encountered. When errors=TRUE, the function will
stop and display the error if an error is encountered. When
errors=FALSE, a value of -1 is returned.
TRUE
max An integer specifying the maximum number of rows to
return. Specify 0 for no maximum.
0 (meaning no maximum)
rows_at_time An integer specifying the number of rows to fetch from
the ODBC connection on each call to the underlying driver;
not all drivers allow values greater than 1. (Note that this
is a performance optimization; it doesn’t mean the same
thing as themax argument. For modern drivers, the pack
age documentation suggests a value of 1,024.)
1
as.is A logical vector specifying which columns should be con
verted to factors.
FALSE
buffsize An integer used to specify the buffer size for the driver. (If
you know the approximate number of rows that a query
will return, you can specify that value to optimize perfor
mance.)
1000
nullstring Character values to be used for null values. NA
na.strings Character values to be mapped to NA values. "NA"
believeNRows A logical value that tells this function whether the row
counts returned by the ODBC driver are correct. (This is a
performance optimization.)
TRUE
dec The character used as the decimal point in decimal values. getOption("dec")
stringsAsFactors A logical value that specifies whether character value col
umns not explicitly included in as.is should be con
verted to factors.
default.stringsAsFactors()
By the way, notice that the sqlQuery function can be used to execute any valid que
in the underlying database. It is most commonly used to just query results (usin
SELECT queries), but you can enter any valid data manipulation language que
(including SELECT, INSERT, DELETE, and UPDATE queries) and data definitio
language query (including CREATE, DROP, and ALTER queries).
Underlying Functions
There is a second set of functions in the RODBC package. The functions odbcQuery,
odbcTables, odbcColumns, and odbcPrimaryKeys are used to execute queries in the
database but not to fetch results. A second function, odbcFetchResults, is used to
get the results. The first four functions return status codes as integers, which is
not very R-like. (It’s more like C.) The odbcFetchResults function returns its results
in list form, which can also be somewhat cumbersome. If there is an error, you
can retrieve the message by calling odbcGetErrMsg.
Sometimes, it might be convenient to use these functions because they give you
greater control over how data is fetched from the database. However, the higher
level functions described in this section are usually much more convenient.

When you are done using an RODBC channel, you can close it with
the odbcClose function. This function takes the connection name as its only
argument:
> odbcClose(bbdb)
Conveniently, you can also close all open channels using the odbcCloseAll function.
It is generally a good practice to close connections when you are done, because this
frees resources locally and in the underlying database.
DBI
As described above, there is a second set of packages for accessing databases in R:
DBI. DBI is not a single package, but instead is a framework and set of packages for
accessing databases. Table 11-3 shows the set of database drivers available through
this interface. One important difference between the DBI packages and the RODBC
package is in the objects they use: DBI uses S4 objects to represent drivers, connec
tions, and other objects.
Table 11-3. DBI packages
Database Package
MySQL RMySQL
SQLite RSQLite
Oracle ROracle
PostgreSQL RPostgreSQL
Any database with a JDBC driver RJDBC
Closing a channel.

Opening a connection
To open a connection with DBI, use the dbConnect function:
dbConnect(drv, ...)
The argument drv can be a DBIDriver object or a character value describing the driver
to use. You can generate a DBIDriver object with a call to the DBI driver. The
dbConnect function can take additional options, depending on the type of database
you are using. For SQLite databases, the most important argument is dbname (which
specifies the database file). Check the help files for the database you are using for
more options. Even arguments for parameters like usernames are not the same
between databases.
For example, to create a driver for SQLite, you can use a command like this:
> drv <- dbDriver("SQLite")
To open a connection to the example database, we could use the following
command:
> con <- dbConnect(drv,
+  dbname=system.file("extdata", "bb.db", package="nutshell"))
Alternatively, we could skip creating the driver object and simply create the
connection:
> con <- dbConnect("SQLite,
+  dbname=system.file("extdata", "bb.db", package="nutshell"))
There are several reasons why it can be better to explicitly create a driver object.
First, you can get information about open connections if you can identify the driver.
Additionally, if you are concerned with resource consumption, it may be wise to
explicitly create a driver object, because you can free the object later. (See “Cleaning
up” on page 171 for more details.)
Getting DB information
There are several ways to get information about an open database connection object.
As noted above, DBI objects are S4 objects, so they have meaningful classes:
> class(drv)
[1] "SQLiteDriver"
attr(,"package")
[1] "RSQLite"
> class(con)
[1] "SQLiteConnection"
attr(,"package")
[1] "RSQLite"
To get the list of connection objects associated with a driver object, use the dbList
Connections function:
> dbListConnections(drv)
[[1]]
<SQLiteConnection:(4580,0)>
You can get some basic information about a connection object, such as the database
name and username, through the dbGetInfo function:
> dbGetInfo(con)
$host
[1] "localhost"
$user
[1] "NA"
$dbname
[1] "/Library/Frameworks/R.framework/Resources/library/nutshell/data/bb.db"
$conType
[1] "direct"
$serverVersion
[1] "3.6.4"
$threadId
[1] -1
$rsId
integer(0)
$loadableExtensions
[1] "off"
To find the set of tables that you can access from a database connection, use the
dbListTables function. This function returns a character vector of table names:
> dbListTables(con)
[1] "Allstar" "AllstarFull" "Appearances"
[4] "AwardsManagers" "AwardsPlayers" "AwardsShareManagers"
[7] "AwardsSharePlayers" "Batting" "BattingPost"
[10] "Fielding" "FieldingOF" "FieldingPost"
[13] "HOFold" "HallOfFame" "Managers"
[16] "ManagersHalf" "Master" "Pitching"
[19] "PitchingPost" "Salaries" "Schools"
[22] "SchoolsPlayers" "SeriesPost" "Teams"
[25] "TeamsFranchises" "TeamsHalf" "xref_stats"

To find the list of columns, use the List dbListFields function. This function takes
a connection object and a table name as arguments and returns a character vector
of column names:
> dbListFields(con,"Allstar")
[1] "playerID" "yearID" "lgID"
Querying the database
To query a database using DBI and return a data frame with the results, use the
dbGetQuery function. This function requires a connection object and SQL statement
as arguments. Check the help files for your database for additional arguments.
For example, to fetch a list of the wins and losses for teams in the American League
in 2008, you could use the following query:
> wlrecords.2008 <- dbGetQuery(con,
+ "SELECT teamID, W, L FROM Teams where yearID=2008 and lgID='AL'")
To get information on all batters in 2008, you might use a query like this:
> batting.2008 <- dbGetQuery(con,
+  paste("SELECT m.nameLast, m.nameFirst, m.weight, m.height, ",
+  "m.bats, m.throws, m.debut, m.birthYear, b.* ",
+  "from Master m inner join Batting b ",
+  "on m.playerID=b.playerID where b.yearID=2008"))
> names(batting.2008)
[1] "nameLast" "nameFirst" "weight" "height" "bats"
[6] "throws" "debut" "birthYear" "playerID" "yearID"
[11] "stint" "teamID" "lgID" "G" "G_batting"
[16] "AB" "R" "H" "2B" "3B"
[21] "HR" "RBI" "SB" "CS" "BB"
[26] "SO" "IBB" "HBP" "SH" "SF"
[31] "GIDP" "G_old"
> dim(batting.2008)
[1] 1384 31
This data set is used in other sections of this book as an example. For convenience,
it is included in the nutshell package.
You might find it more convenient to separately submit an SQL query and fetch the
results. To do this, you would use the dbSendQuery function to send a query and then
use fetch to get the results. The dbSendQuery function returns a DBIResult object
(actually, it returns an object from a class that inherits from DBIResult). You then
use the fetch function to extract data from the results object.
The dbSendQuery function takes the same arguments as dbGetQuery. The fetch func
tion takes a result object res as an argument, an integer value n representing the
maximum number of rows to return, and additional arguments passed to the meth
ods for a specific database driver. To fetch all records, you can omit n, or use n=-1.
For example, the following R statements are equivalent to the dbGetQuery statements
shown above:
> res <- dbSendQuery(con,
+  "SELECT teamID, W, L FROM Teams where yearID=2008 and lgID='AL'")
> wlrecords.2008 <- fetch(res)
You can clear pending results using the dbClearResult function:
> # query to fetch a lot of results
> res <- dbSendQuery(con,"SELECT * from Master")
> # function to clear the results
> dbClearResult(res)
[1] TRUE
If an error occurred, you can get information about the error with the
dbGetException function:
> # SQL statement that will generate an error.
> # Notice that an error message is printed.
> res <- dbSendQuery(con,"SELECT * from non_existent_table")
Error in sqliteExecStatement(conn, statement, ...) :
RS-DBI driver: (error in statement: no such table: non_existent_table)
> # now, manually get the error message
> dbGetException(con)
$errorNum
[1] 1
$errorMsg
[1] "error in statement: no such table: non_existent_table"
Finally, DBI provides some functions for reading whole tables from a database
or writing whole data frames to a database. To read a whole table, use the
dbReadTable function:
> batters <- dbReadTable(con, "Batting")
> dim(batters)
[1] 91457 24
To write a data frame to a table, you can use the dbWriteTable function. You can
check if a table exists with the dbExistsTable function, and you can delete a table
with the dbRemoveTable function.
Cleaning up
To close a database connection, use the dbDisconnect function:
> dbDisconnect(con)
[1] TRUE
You can also explicitly unload the database driver, freeing system resources, by using
the dbUnloadDriver function. With some databases, you can pass additional argu
ments to this driver; see the help files for the database you are using for more
information.
> dbUnloadDriver(drv)
TSDBI
There is one last database interface in R that you might find useful: TSDBI. TSDBI
is an interface specifically designed for time series data. There are TSDBI packages
for many popular databases, as shown in Table 11-4.
Table 11-4. TSDBI packages
Database Package
MySQL TSMySQL
SQLite TSSQLite
Fame TSFame
PostgreSQL TSPostgreSQL
Any database with an ODBC driver TSODBC
Getting Data from Hadoop
Today, one of the most important sources for data is Hadoop. To learn more about
Hadoop, including instructions on how to install R packages for working with Ha
doop data on HDFS or in HBase, see “R and Hadoop” on page 549.


> x <- c("a", "b", "c", "d", "e")
> y <- c("A", "B", "C", "D", "E")
> paste(x,y)
[1] "a A" "b B" "c C" "d D" "e E"

none at all) with the sep argument:
> paste(x, y, sep="-")
[1] "a-A" "b-B" "c-C" "d-D" "e-E"
If you would like all of values in the returned vector to be concatenated with one
another (to return just a single value), then specify a value for the collapse argument.
The value of collapse will be used as the separator in this value:
> paste(x, y, sep="-", collapse="#")
[1] "a-A#b-B#c-C#d-D#e-E"
rbind and cbind
Sometimes, you would like to bind together multiple data frames or matrices. You
can do this with the rbind and cbind functions. The cbind function will combine
objects by adding columns. You can picture this as combining two tables horizon
tally. As an example, let’s start with the data frame for the top five salaries in the
NFL in 2008:1
> top.5.salaries
name.last name.first team position salary
1 Manning Peyton Colts QB 18700000
2 Brady Tom Patriots QB 14626720
3 Pepper Julius Panthers DE 14137500
4 Palmer Carson Bengals QB 13980000
5 Manning Eli Giants QB 12916666
Now let’s create a new data frame with two more columns (a year and a rank):
> year <- c(2008, 2008, 2008, 2008, 2008)
> rank <- c(1, 2, 3, 4, 5)

> more.cols <- data.frame(year, rank)
> more.cols
year rank
1 2008 1
2 2008 2
3 2008 3
4 2008 4
5 2008 5
Finally, let’s put together these two data frames:
> cbind(top.5.salaries, more.cols)
name.last name.first team position salary year rank
1 Manning Peyton Colts QB 18700000 2008 1
2 Brady Tom Patriots QB 14626720 2008 2
3 Pepper Julius Panthers DE 14137500 2008 3
4 Palmer Carson Bengals QB 13980000 2008 4
5 Manning Eli Giants QB 12916666 2008 5

> top.5.salaries
name.last name.first team position salary
1 Manning Peyton Colts QB 18700000
2 Brady Tom Patriots QB 14626720
3 Pepper Julius Panthers DE 14137500
4 Palmer Carson Bengals QB 13980000
5 Manning Eli Giants QB 12916666
> next.three
name.last name.first team position salary
6 Favre Brett Packers QB 12800000
7 Bailey Champ Broncos CB 12690050
8 Harrison Marvin Colts WR 12000000
You could combine these into a single data frame using the rbind function:
> rbind(top.5.salaries, next.three)
name.last name.first team position salary
1 Manning Peyton Colts QB 18700000
2 Brady Tom Patriots QB 14626720
3 Pepper Julius Panthers DE 14137500
4 Palmer Carson Bengals QB 13980000
5 Manning Eli Giants QB 12916666
6 Favre Brett Packers QB 12800000
7 Bailey Champ Broncos CB 12690050
8 Harrison Marvin Colts WR 12000000

get.quotes <- function(ticker,
from=(Sys.Date()-365),
to=(Sys.Date()),
interval="d") {
# define parts of the URL
base <- "http://ichart.finance.yahoo.com/table.csv?";
symbol <- paste("s=", ticker, sep="");
# months are numbered from 00 to 11, so format the month correctly
from.month <- paste("&a=",
formatC(as.integer(format(from,"%m"))-1,width=2,flag="0"),
sep="");
from.day <- paste("&b=", format(from,"%d"), sep="");
from.year <- paste("&c=", format(from,"%Y"), sep="");
to.month <- paste("&d=",
formatC(as.integer(format(to,"%m"))-1,width=2,flag="0"),
sep="");
to.day <- paste("&e=", format(to,"%d"), sep="");
to.year <- paste("&f=", format(to,"%Y"), sep="");
inter <- paste("&g=", interval, sep="");
last <- "&ignore=.csv";
# put together the url
url <- paste(base, symbol, from.month, from.day, from.year,
to.month, to.day, to.year, inter, last, sep="");
# get the file
tmp <- read.csv(url);
# add a new column with ticker symbol labels
cbind(symbol=ticker,tmp);
}

Now let’s write a function that returns a data frame with quotes from multiple se
curities. This function will simply call get.quotes once for every ticker in a vector of
tickers and bind together the results using rbind:
get.multiple.quotes <- function(tkrs,
from=(Sys.Date()-365),
to=(Sys.Date()),
interval="d") {
tmp <- NULL;
for (tkr in tkrs) {
if (is.null(tmp))
tmp <- get.quotes(tkr,from,to,interval)
else tmp <- rbind(tmp,get.quotes(tkr,from,to,interval))
}
tmp
}
Finally, let’s define a vector with the set of ticker symbols in the Dow Jones Industrial
Average and then build a data frame with data from all 30 tickers:
> dow.tickers <- c("MMM", "AA", "AXP", "T", "BAC", "BA", "CAT", "CVX",
+  "CSCO", "KO", "DD", "XOM", "GE", "HPQ", "HD", "INTC",
+  "IBM", "JNJ", "JPM", "KFT", "MCD", "MRK", "MSFT", "PFE",
+  "PG", "TRV", "UTX", "VZ", "WMT", "DIS")
> # date on which I ran this code
> Sys.Date()
[1] "2012-01-08"
> dow30 <- get.multiple.quotes(dow30.tickers)
We’ll return to this data set below.data

Merging Data by Common Fields
As an example, let’s return to the Baseball Databank database that we used in
“Importing Data From Databases” on page 156. In this database, player information
is stored in the Master table. Players are uniquely identified by the column playerID:
> dbListFields(con,"Master")
 [1] "lahmanID" "playerID" "managerID" "hofID"
 [5] "birthYear" "birthMonth" "birthDay" "birthCountry"
 [9] "birthState" "birthCity" "deathYear" "deathMonth"
[13] "deathDay" "deathCountry" "deathState" "deathCity"
[17] "nameFirst" "nameLast" "nameNote" "nameGiven"
[21] "nameNick" "weight" "height" "bats"
[25] "throws" "debut" "finalGame" "college"
[29] "lahman40ID" "lahman45ID" "retroID" "holtzID"
[33] "bbrefID"
Batting information is stored in the Batting table. Players are uniquely identified by
playerID in this table as well:
> dbListFields(con, "Batting")
 [1] "playerID" "yearID" "stint" "teamID" "lgID"
 [6] "G" "G_batting" "AB" "R" "H"
[11] "2B" "3B" "HR" "RBI" "SB"
[16] "CS" "BB" "SO" "IBB" "HBP"
[21] "SH" "SF" "GIDP" "G_old"

Suppose that you wanted to show batting statistics for each player along with his
name and age. To do this, you would need to merge data from the two tables. In R,
you can do this with the merge function:
> batting <- dbGetQuery(con, "SELECT * FROM Batting")
> master <- dbGetQuery(con, "SELECT * FROM Master")
> batting.w.names <- merge(batting, master)
In this case, there was only one common variable between the two tables: playerID:
> intersect(names(batting), names(master))
[1] "playerID"
By default, merge uses common variables between the two data frames as the merge
keys. So, in this case, we did not have to specify any more arguments to merge. Let’s
take a closer look at the arguments to merge (for data frames):
merge(x, y, by = , by.x = , by.y = , all = , all.x = , all.y = ,
sort = , suffixes = , incomparables = , ...)
Here is a description of the arguments to merge.
Argument Description Default
x One of the two data frames to combine.
y One of the two data frames to combine.
by A vector of character values corresponding to column
names.
intersect(names(x), names(y))
by.x A vector of character values corresponding to column
names in x. Overrides the list given in by.
by
by.y A vector of character values corresponding to column
names in y. Overrides the list given in by.
by
all A logical value specifying whether rows from each data
frame should be included even if there is no match in
the other data frame. This is equivalent to an OUTER
JOIN in a database. (Equivalent to all.x=TRUE and
all.y=TRUE.)
FALSE
all.x A logical value specifying whether rows from data
frame x should be included even if there is no match
in the other data frame. This is equivalent to x LEFT
OUTER JOIN y in a database.
all
all.y A logical value specifying whether rows from data
frame x should be included even if there is no match
in the other data frame. This is equivalent to x RIGHT
OUTER JOIN y in a database.
all
sort A logical value that specifies whether the results should
be sorted by the by columns.
TRUE
suffixes A character vector with two values. If there are columns
in x and y with the same name that are not used in the
by list, they will be renamed with the suffixes given
by this argument.
suffixes = c(“.x”, “.y”)
Argument Description Default
incomparables A list of variables that cannot be matched. NULL
By default, merge is equivalent to a NATURAL JOIN in SQL. You can specify other
columns to make it use merge like an INNER JOIN. You can specify values of ALL
to get the same results as OUTER or FULL joins. If there are no matching field names,
or if by is of length 0 (or by.x and by.y are of length 0), then merge will return the
full Cartesian product of x and y.

By default, merge uses common variables between the two data frames as the merge
keys. So, in this case, we did not have to specify any more arguments to merge. Let’s
take a closer look at the arguments to merge (for data frames):
merge(x, y, by = , by.x = , by.y = , all = , all.x = , all.y = ,
sort = , suffixes = , incomparables = , ...)
Here is a description of the arguments to merge.
Argument Description Default
x One of the two data frames to combine.
y One of the two data frames to combine.
by A vector of character values corresponding to column
names.
intersect(names(x), names(y))
by.x A vector of character values corresponding to column
names in x. Overrides the list given in by.
by
by.y A vector of character values corresponding to column
names in y. Overrides the list given in by.
by
all A logical value specifying whether rows from each data
frame should be included even if there is no match in
the other data frame. This is equivalent to an OUTER
JOIN in a database. (Equivalent to all.x=TRUE and
all.y=TRUE.)
FALSE
all.x A logical value specifying whether rows from data
frame x should be included even if there is no match
in the other data frame. This is equivalent to x LEFT
OUTER JOIN y in a database.
all
all.y A logical value specifying whether rows from data
frame x should be included even if there is no match
in the other data frame. This is equivalent to x RIGHT
OUTER JOIN y in a database.
all
sort A logical value that specifies whether the results should
be sorted by the by columns.
TRUE
suffixes A character vector with two values. If there are columns
in x and y with the same name that are not used in the
by list, they will be renamed with the suffixes given
by this argument.
suffixes = c(“.x”, “.y”)

For example, suppose that we wanted to perform the two transformations listed
above: changing the Date column to a Date format, and adding a new midpoint
variable. We could do this with transform using the following expression:
> dow30.transformed <- transform(dow30, Date=as.Date(Date),
+ mid = (High + Low) / 2)
> names(dow30.transformed)
[1] "symbol" "Date" "Open" "High" "Low"
[6] "Close" "Volume" "Adj.Close" "mid"
> class(dow30.transformed$Date)
[1] "Date"

Applying a Function to Each Element of an Object
When transforming data, one common operation is to apply a function to a set of
objects (or each part of a composite object) and return a new set of objects (or a new
composite object). The base R library includes a set of different functions for doing
this.
Applying a function to an array
To apply a function to parts of an array (or matrix), use the apply function:
apply(X, MARGIN, FUN, ...)
Apply accepts three arguments: X is the array to which a function is applied, FUN is
the function, and MARGIN specifies the dimensions to which you would like to apply
a function. Optionally, you can specify arguments to FUN as addition arguments to
apply arguments to FUN.) To show how this works, here’s a simple example. Let’s
create a matrix with five rows of four elements, corresponding to the numbers between 1 and 20:
> x <- 1:20
> dim(x) <- c(5, 4)
> x
 [,1] [,2] [,3] [,4]
[1,] 1 6 11 16
[2,] 2 7 12 17
[3,] 3 8 13 18
[4,] 4 9 14 19
[5,] 5 10 15 20
Now let’s show how apply works. We’ll use the function max because it’s easy to
look at the matrix above and see where the results came from.
First, let’s select the maximum element of each row. (These are the values in the
rightmost column: 16, 17, 18, 19, and 20.) To do this, we will specify X=x,
MARGIN=1 (rows are the first dimension), and FUN=max:

> apply(X=x, MARGIN=1, FUN=max)
[1] 16 17 18 19 20
To do the same thing for columns, we simply have to change the value of MARGIN:
> apply(X=x, MARGIN=2, FUN=max)
[1] 5 10 15 20
As a slightly more complex example, we can also use MARGIN to apply a function over
multiple dimensions. (We’ll switch to the function paste to show which elements
were included.) Consider the following three-dimensional array:
> x <- 1:27
> dim(x) <- c(3, 3, 3)
> x
, , 1
[,1] [,2] [,3]
[1,] 1 4 7
[2,] 2 5 8
[3,] 3 6 9
, , 2
[,1] [,2] [,3]
[1,] 10 13 16
[2,] 11 14 17
[3,] 12 15 18
, , 3
[,1] [,2] [,3]
[1,] 19 22 25
[2,] 20 23 26
[3,] 21 24 27
Let’s start by looking at which values are grouped for each value of MARGIN:
> apply(X=x, MARGIN=1, FUN=paste, collapse=",")
[1] "1,4,7,10,13,16,19,22,25" "2,5,8,11,14,17,20,23,26"
[3] "3,6,9,12,15,18,21,24,27"
> apply(X=x, MARGIN=2, FUN=paste, collapse=",")
[1] "1,2,3,10,11,12,19,20,21" "4,5,6,13,14,15,22,23,24"
[3] "7,8,9,16,17,18,25,26,27"
> apply(X=x, MARGIN=3, FUN=paste, collapse=",")
[1] "1,2,3,4,5,6,7,8,9" "10,11,12,13,14,15,16,17,18"
[3] "19,20,21,22,23,24,25,26,27"
Let’s do something more complicated. Let’s select MARGIN=c(1, 2)  to see which el
ements are selected:
> apply(X=x, MARGIN=c(1,2), FUN=paste, collapse=",")
[,1] [,2] [,3]
[1,] "1,10,19" "4,13,22" "7,16,25"
[2,] "2,11,20" "5,14,23" "8,17,26"
[3,] "3,12,21" "6,15,24" "9,18,27"
This is the equivalent of doing the following: for each value of i between 1 and 3 and
each value of j between 1 and 3, calculate FUN of x[i][j][1] , x[i][j][2] , x[i][j][3] .
Applying a function to a list or vector
To apply a function to each element in a vector or a list and return a list, you can
use the function lapply. The function lapply requires two arguments: an object X
and a function FUNC. (You may specify additional arguments that will be passed to
FUNC.) Let’s look at a simple example of how to use lapply:
> x <- as.list(1:5)
> lapply(x,function(x) 2^x)
[[1]]
[1] 2
[[2]]
[1] 4
[[3]]
[1] 8
[[4]]
[1] 16
[[5]]
[1] 32
You can apply a function to a data frame, and the function will be applied to each
vector in the data frame. For example:
> d <- data.frame(x=1:5, y=6:10)
> d
x y
1 1 6
2 2 7
3 3 8
4 4 9
5 5 10
> lapply(d,function(x) 2^x)
$x
[1] 2 4 8 16 32
$y
[1] 64 128 256 512 1024
> lapply(d,FUN=max)
$x
[1] 5
$y
[1] 10
Sometimes, you might prefer to get a vector, matrix, or array instead of a list. To do
this, use the sapply function. This function works exactly the same way as apply,
except that it returns a vector or matrix (when appropriate):

> sapply(d, FUN=function(x) 2^x)
x y
[1,] 2 64
[2,] 4 128
[3,] 8 256
[4,] 16 512
[5,] 32 1024
Another related function is mapply, the “multivariate” version of sapply:
mapply(FUN, ..., MoreArgs = , SIMPLIFY = , USE.NAMES = )
Here is a description of the arguments to mapply.
Argument Description Default
FUN The function to apply.
... A set of vectors over which FUN should be applied.
MoreArgs A list of additional arguments to pass to FUN.
SIMPLIFY A logical value indicating whether to simplify the returned array. TRUE
USE.NAMES A logical value indicating whether to use names for returned values. Names are taken from
the values in the first vector (if it is a character vector) or from the names of elements in that
vector.
TRUE
This function will apply FUN to the first element of each vector, then to the second,
and so on, until it reaches the last element.
Here is a simple example of mapply:
> mapply(paste,
+  c(1, 2, 3, 4, 5),
+  c("a", "b", "c", "d", "e"),
+ c("A", "B", "C", "D", "E"),
+ MoreArgs=list(sep="-"))
[1] "1-a-A" "2-b-B" "3-c-C" "4-d-D" "5-e-E"
the plyr library
At this point, you’re probably confused by all the different apply functions. They all
accept different arguments, they’re named inconsistently, and they work differently.
Luckily, you don’t have to remember any of the details of these function if you use
the plyr package.
The plyr package contains a set of 12 logically named functions for applying another
function to an R data object and returning the results. Each of these functions takes
an array, data frame, or list as input and returns an array, data frame, list, or nothing
as output. (You can choose to discard the results.) Here’s a table of the most useful
functions:
Input Array Output Data Frame Output List Output Discard Output
Array aaply adply alply a_ply
Data Frame daply ddply dlply d_ply
List laply ldply llply l_ply
All of these functions accept the following arguments:
Argument Description Default
.data The input data object
.fun The function to apply to the data NULL
.progress The type of progress bar (created with create_progress); choices include "none" ,
"text" , "tk" , and "win"
"none"
.expand If .data is a dataframe, controls how output is expanded; choose .expand=TRUE for 1d
output, .expand=FALSE for nd.
TRUE
.parallel Specifies whether to apply the function in parallel (through foreach) FALSE
... Other arguments passed to .fun
Other arguments depend on the input and output. If the input is an array, then these
arguments are available:
Argument Description Default
.margins A vector describing the subscripts to split up data by
If the input is a data frame, then these arguments are available:
Argument Description Default
.drop (or .drop_i for daply) Specifies whether to drop combinations of variables that do not appear in the
data input
TRUE
.variables Specifies a set of variables by which to split the data frame
.drop_o (for daply only) Specifies whether to drop extra dimensions in the output for dimensions of
length 1
TRUE
If the output is dropped, then this argument is available:
Argument Description Default
.print Specifies whether to print each output value FALSE
Let’s try to re-create some of our examples from above using plyr:
> # (1) input list, output list
> lapply(d, function(x) 2^x)
$x
[1] 2 4 8 16 32
$y
[1] 64 128 256 512 1024
> # equivalent is llply
> llply(.data=d, .fun=function(x) 2^x)
$x
[1] 2 4 8 16 32
$y
[1] 64 128 256 512 1024
> # (2) input is an array, output is a vector
> apply(X=x,MARGIN=1, FUN=paste, collapse=",")
[1] "1,4,7,10,13,16,19,22,25" "2,5,8,11,14,17,20,23,26"
[3] "3,6,9,12,15,18,21,24,27"
> # equivalent (but note labels)
> aaply(.data=x,.margins=1, .fun=paste, collapse=",")
1 2
"1,4,7,10,13,16,19,22,25" "2,5,8,11,14,17,20,23,26"
3
"3,6,9,12,15,18,21,24,27"
> # (3) Data frame in, matrix out
> t(sapply(d, FUN=function(x) 2^x))
[,1] [,2] [,3] [,4] [,5]
x 2 4 8 16 32
y 64 128 256 512 1024
> # equivalent (but note the additional labels)
> aaply(.data=d, .fun=function(x) 2^x, .margins=2)
X1 1 2 3 4 5
x 2 4 8 16 32
y 64 128 256 512 1024
Another related function is mapply, the “multivariate” version of sapply:
mapply(FUN, ..., MoreArgs = , SIMPLIFY = , USE.NAMES = )
Here is a description of the arguments to mapply.
Argument Description Default
FUN The function to apply.
... A set of vectors over which FUN should be applied.
MoreArgs A list of additional arguments to pass to FUN.
SIMPLIFY A logical value indicating whether to simplify the returned array. TRUE
USE.NAMES A logical value indicating whether to use names for returned values. Names are taken from
the values in the first vector (if it is a character vector) or from the names of elements in that
vector.
TRUE

mapply(paste,
+  c(1, 2, 3, 4, 5),
+  c("a", "b", "c", "d", "e"),
+ c("A", "B", "C", "D", "E"),
+ MoreArgs=list(sep="-"))
[1] "1-a-A" "2-b-B" "3-c-C" "4-d-D" "5-e-E"



Shingles
We briefly mentioned shingles in “Shingles” on page 95. Shingles are a way to rep
resent intervals in R. They can be overlapping, like roof shingles (hence the name).
They are used extensively in the lattice package, when you want to use a numeric
value as a conditioning value.
To create shingles in R, use the shingle function:
shingle(x, intervals=sort(unique(x)))
To specify where to separate the bins, use the intervals argument. You can use a
numeric vector to indicate the breaks or a two-column matrix, where each row rep
resents a specific interval.

Cut
The function cut is useful for taking a continuous variable and splitting it into dis
crete pieces. Here is the default form of cut for use with numeric vectors:
# numeric form
cut(x, breaks, labels = NULL,
include.lowest = FALSE, right = TRUE, dig.lab = 3,
ordered_result = FALSE, ...)
There is also a version of cut for manipulating Date objects:
# Date form
cut(x, breaks, labels = NULL, start.on.monday = TRUE,
right = FALSE, ...)
The cut function takes a numeric vector as input and returns a factor. Each level in
the factor corresponds to an interval of values in the input vector. Here is a descrip
tion of the arguments to cut.
Argument Description Default
x A numeric vector (to convert to a factor).
breaks Either a single integer value specifying the number of break points or a numeric vector
specifying the set of break points.
labels Labels for the levels in the output factor. NULL
include.lowest A logical value indicating if a value equal to the lowest point in the range (if
right=TRUE) in a range should be included in a given bucket. If right=FALSE
indicates whether a value equal to the highest point in the range should be included.
FALSE
right A logical value that specifies whether intervals should be closed on the right and open
on the left. (Forright=FALSE, intervals will be open on the right and closed on the left.)
TRUE
dig.lab Number of digits used when generating labels (if labels are not explicitly specified). 3
ordered_results A logical value indicating whether the result should be an ordered factor. FALSE
For example, suppose that you wanted to count the number of players with batting
averages in certain ranges. To do this, you could use the cut function and the
table function:
> # load in the example data
> library(nutshell)
> data(batting.2008)
> # first, add batting average to the data frame:
> batting.2008.AB <- transform(batting.2008, AVG = H/AB)
> # now, select a subset of players with over 100 AB (for some
> # statistical significance):
> batting.2008.over100AB <- subset(batting.2008.AB, subset=(AB > 100))
> # finally, split the results into 10 bins:
> battingavg.2008.bins <- cut(batting.2008.over100AB$AVG,breaks=10)

> table(battingavg.2008.bins)
battingavg.2008.bins
(0.137,0.163] (0.163,0.189] (0.189,0.215] (0.215,0.24] (0.24,0.266]
4 6 24 67 121
(0.266,0.292] (0.292,0.318] (0.318,0.344] (0.344,0.37] (0.37,0.396]
132 70 11 5 2
Combining Objects with a Grouping Variable
Sometimes you would like to combine a set of similar objects (either vectors or data
frames) into a single data frame, with a column labeling the source. You can do this
with the make.groups function in the lattice package:
library(lattice)
make.groups(...)
For example, let’s combine three different vectors into a data frame:
> hat.sizes <- seq(from=6.25, to=7.75, by=.25)
> pants.sizes <- c(30, 31, 32, 33, 34, 36, 38, 40)
> shoe.sizes <- seq(from=7, to=12)
> make.groups(hat.sizes, pants.sizes, shoe.sizes)
data which
hat.sizes1 6.25 hat.sizes
hat.sizes2 6.50 hat.sizes
hat.sizes3 6.75 hat.sizes
hat.sizes4 7.00 hat.sizes
hat.sizes5 7.25 hat.sizes
hat.sizes6 7.50 hat.sizes
hat.sizes7 7.75 hat.sizes
pants.sizes1 30.00 pants.sizes
pants.sizes2 31.00 pants.sizes
pants.sizes3 32.00 pants.sizes
pants.sizes4 33.00 pants.sizes
pants.sizes5 34.00 pants.sizes
pants.sizes6 36.00 pants.sizes
pants.sizes7 38.00 pants.sizes
pants.sizes8 40.00 pants.sizes
shoe.sizes1 7.00 shoe.sizes
shoe.sizes2 8.00 shoe.sizes
shoe.sizes3 9.00 shoe.sizes
shoe.sizes4 10.00 shoe.sizes
shoe.sizes5 11.00 shoe.sizes
shoe.sizes6 12.00 shoe.sizes
Subsets
Often, you’ll be provided with too much data. For example, suppose that you were
working with patient records at a hospital. You might want to analyze healthcare
records for patients between 5 and 13 years of age who were treated for asthma
during the past 3 years. To do this, you need to take a subset of the data and not
examine the whole database.
Other times, you might have too much relevant data. For example, suppose that you
were looking at a logistics operation that fills billions of orders every year. R cannot

hold only a certain number of records in memory and might not be able to hold the
entire database. In most cases, you can get statistically significant results with a tiny
fraction of the data; even millions of orders might be too many.
Bracket Notation
One way to take a subset of a data set is to use the bracket notation. As you may
recall, you can select rows in a data frame by providing a vector of logical values. If
you can write a simple expression describing the set of rows to select from a data
frame, you can provide this as an index.
For example, suppose that we wanted to select only batting data from 2008. The
column batting.w.names$yearID contains the year associated with each row, so we
could calculate a vector of logical values describing which rows to keep with the
expression batting.w.names$yearID==2008. Now we just have to index the data frame
batting.w.names with this vector to select only rows for the year 2008:
> batting.w.names.2008 <- batting.w.names[batting.w.names$yearID==2008,]
> summary(batting.w.names.2008$yearID)
Min. 1st Qu. Median Mean 3rd Qu. Max.
2008 2008 2008 2008 2008 2008
Similarly, we can use the same notation to select only certain columns. Suppose that
we wanted to keep only the variables nameFirst, nameLast, AB, H, and BB. We could
provide these in the brackets as well:
> batting.w.names.2008.short <-
+  batting.w.names[batting.w.names$yearID==2008,
+  c("nameFirst", "nameLast", "AB", "H", "BB")]
subset Function
As an alternative, you can use the subset function to select a subset of rows and
columns from a data frame (or matrix):
subset(x, subset, select, drop = FALSE, ...)
There isn’t anything you can do with subset that you can’t do with the bracket
notation, but using subset can lead to more readable code. Subset allows you to use
variable names from the data frame when selecting subsets, saving some typing. Here
is a description of the arguments to subset.
Argument Description Default
x The object from which to calculate a subset.
subset A logical expression that describes the set of rows to return.
select An expression indicating which columns to return.
drop Passed to `[` . FALSE
As an example, let’s recreate the same data sets we created above using subset:
> batting.w.names.2008 <- subset(batting.w.names, yearID==2008)
> batting.w.names.2008.short <- subset(batting.w.names, yearID==2008,
+ c("nameFirst","nameLast","AB","H","BB"))
Random Sampling
Often, it is desirable to take a random sample of a data set. Sometimes, you might
have too much data (for statistical reasons or for performance reasons). Other times,
you simply want to split your data into different parts for modeling (usually into
training, testing, and validation subsets).
One of the simplest ways to extract a random sample is with the sample function.
The sample function returns a random sample of the elements of a vector:
sample(x, size, replace = FALSE, prob = NULL)
Argument Description Default
x The object from which the sample is taken
size An integer value specifying the sample size
replace A logical value indicating whether to sample with, or without, replacement FALSE
prob A vector of probabilities for selecting each item NULL
Somewhat nonintuitively, when applied to a data frame, sample will return a random
sample of the columns. (Remember that a data frame is implemented as a list of
vectors, so sample is just taking a random sample of the elements of the list.) So you
need to be a little more clever when you use sample with a data frame.
To take a random sample of the observations in a data set, you can use sample to
create a random sample of row numbers and then select these row numbers using
an index operator. For example, let’s take a random sample of five elements from
the batting.2008 data set:
> batting.2008[sample(1:nrow(batting.2008), 5), ]
playerID yearID stint teamID lgID G G_batting AB R H 2B 3B
90648 izturma01 2008 1 LAA AL 79 79 290 44 78 14 2
90280 benoijo01 2008 1 TEX AL 44 3 0 0 0 0 0
90055 percitr01 2008 1 TBA AL 50 4 0 0 0 0 0
91085 getzch01 2008 1 CHA AL 10 10 7 2 2 0 0
90503 willijo03 2008 1 FLO NL 102 102 351 54 89 21 5
HR RBI SB CS BB SO IBB HBP SH SF GIDP G_old
90648 3 37 11 2 26 27 0 1 2 2 9 79
90280 0 0 0 0 0 0 0 0 0 0 0 3
90055 0 0 0 0 0 0 0 0 0 0 0 4
91085 0 1 1 1 0 1 0 0 0 0 0 10
90503 15 51 3 2 48 82 2 14 1 2 7 102
You can also use this technique to select a more complicated random subset. For
example, suppose that you wanted to randomly select statistics for three teams. You
could do this as follows:
> batting.2008$teamID <- as.factor(batting.2008$teamID)
> levels(batting.2008$teamID)
[1] "ARI" "ATL" "BAL" "BOS" "CHA" "CHN" "CIN" "CLE" "COL" "DET" "FLO"
[12] "HOU" "KCA" "LAA" "LAN" "MIL" "MIN" "NYA" "NYN" "OAK" "PHI" "PIT"
[23] "SDN" "SEA" "SFN" "SLN" "TBA" "TEX" "TOR" "WAS"
> # example of sample
> sample(levels(batting.2008$teamID), 3)
[1] "ATL" "TEX" "DET"
> # usage example (note that it's a different random sample of teams)
> batting.2008.3teams <- batting.2008[is.element(batting.2008$teamID,
+  sample(levels(batting.2008$teamID), 3)), ]
> # check to see that sample only has three teams
> summary(batting.2008.3teams$teamID)
ARI ATL BAL BOS CHA CHN CIN CLE COL DET FLO HOU KCA LAA LAN MIL MIN
0 0 0 0 0 0 48 0 0 0 0 0 0 41 0 44 0
NYA NYN OAK PHI PIT SDN SEA SFN SLN TBA TEX TOR WAS
0 0 0 0 0 0 0 0 0 0 0 0 0
This function is good for data sources where you simply want to take a random
sample of all the observations, but often you might want to do something more
complicated, like stratified sampling, cluster sampling, maximum entropy sampling,
or other more sophisticated methods. You can find many of these methods in the
sampling package. For an example using this package to do stratified sampling, see
“Machine Learning Algorithms for Classification” on page 477.
Summarizing Functions
Often, you are provided with data that is too fine grained for your analysis. For
example, you might be analyzing data about a website. Suppose that you wanted to
know the average number of pages delivered to each user. To find the answer, you
might need to look at every HTTP transaction (every request for content), grouping
together requests into sessions and counting the number of requests. R provides a
number of different functions for summarizing data, aggregating records together
to build a smaller data set.
tapply, aggregate
The tapply function is a very flexible function for summarizing a vector X. You can
specify which subsets of X to summarize, as well as the function used for
summarization:
tapply(X, INDEX, FUN = , ..., simplify = )
Here are the arguments to tapply.
Argument Description Default
X The object on which to apply the function (usually a vector).
INDEX A list of factors that specify different sets of values ofX over which to calculate FUN, each the
same length as X.
FUN The function applied to elements of X. NULL
... Optional arguments are passed to FUN.
Argument Description Default
simplify If simplify=TRUE, then if FUN returns a scalar, then tapply returns an array with the
mode of the scalar. If simplify=FALSE, then tapply returns a list.
TRUE
For example, we can use tapply to sum the number of home runs by team:
> tapply(X=batting.2008$HR, INDEX=list(batting.2008$teamID), FUN=sum)
ARI ATL BAL BOS CHA CHN CIN CLE COL DET FLO HOU KCA LAA LAN MIL MIN
159 130 172 173 235 184 187 171 160 200 208 167 120 159 137 198 111
NYA NYN OAK PHI PIT SDN SEA SFN SLN TBA TEX TOR WAS
180 172 125 214 153 154 124 94 174 180 194 126 117
You can also apply a function that returns multiple items, such as fivenum (which
returns a vector containing the minimum, lower-hinge, median, upper-hinge, and
maximum values) to the data. For example, here is the result of applying fivenum to
the batting averages of each player, aggregated by league:
> tapply(X=(batting.2008$H/batting.2008$AB),
+ INDEX=list(batting.2008$lgID),FUN=fivenum)
$AL
[1] 0.0000000 0.1758242 0.2487923 0.2825485 1.0000000
$NL
[1] 0.0000000 0.0952381 0.2172524 0.2679739 1.0000000
You can also use tapply to calculate summaries over multiple dimensions. For ex
ample, we can calculate the mean number of home runs per player by league and
batting hand:
> tapply(X=(batting.2008$HR),
+ INDEX=list(batting.w.names.2008$lgID,
+ batting.w.names.2008$bats),
+ FUN=mean)
B L R
AL 3.058824 3.478495 3.910891
NL 3.313433 3.400000 3.344902
(As a side note, there is no equivalent to tapply in the plyr package.)
A function closely related to tapply is by. The by function works the same way as
tapply, except that it works on data frames. The INDEX argument is replaced by an
INDICES argument. Here is an example:
> by(batting.2008[, c("H", "2B", "3B", "HR")],
+ INDICES=list(batting.w.names.2008$lgID,
+  batting.w.names.2008$bats), FUN=mean)
: AL
: B
H 2B 3B HR
29.0980392 5.4901961 0.8431373 3.0588235
-----------------------------------------------------
: NL
: B
H 2B 3B HR
29.2238806 6.4776119 0.6865672 3.3134328
-----------------------------------------------------
: AL
: L
H 2B 3B HR
32.4301075 6.7258065 0.5967742 3.4784946
-----------------------------------------------------
: NL
: L
H 2B 3B HR
31.888372 6.283721 0.627907 3.400000
-----------------------------------------------------
: AL
: R
H 2B 3B HR
34.2549505 7.0495050 0.6460396 3.9108911
-----------------------------------------------------
: NL
: R
H 2B 3B HR
29.9414317 6.1822126 0.6290672 3.3449024
Another option for summarization is the function aggregate. Here is the form of
aggregate when applied to data frames:
aggregate(x, by, FUN, ...)
Aggregate can also be applied to time series and takes slightly different arguments:
aggregate(x, nfrequency = 1, FUN = sum, ndeltat = 1,
ts.eps = getOption("ts.eps"), ...)
Here is a description of the arguments to aggregate.
Argument Description Default
x The object to aggregate
by A list of grouping elements, each as long as x
FUN A scalar function used to compute the summary statistic no default for data frames; for time
series, FUN=SUM
nfrequency Number of observations per unit of time 1
ndeltat Fraction of the sampling period between successive observations 1
ts.eps Tolerance used to decide if nfrequency is a submultiple
of the original frequency
getOption("ts.eps")
... Further arguments passed to FUN
For example, we can use aggregate to summarize batting statistics by team:
> aggregate(x=batting.2008[, c("AB", "H", "BB", "2B", "3B", "HR")],
+ by=list(batting.2008$teamID), FUN=sum)
Group.1 AB H BB 2B 3B HR
1 ARI 5409 1355 587 318 47 159
2 ATL 5604 1514 618 316 33 130
3 BAL 5559 1486 533 322 30 172
4 BOS 5596 1565 646 353 33 173
5 CHA 5553 1458 540 296 13 235
6 CHN 5588 1552 636 329 21 184
7 CIN 5465 1351 560 269 24 187
8 CLE 5543 1455 560 339 22 171
9 COL 5557 1462 570 310 28 160
10 DET 5641 1529 572 293 41 200
11 FLO 5499 1397 543 302 28 208
12 HOU 5451 1432 449 284 22 167
13 KCA 5608 1507 392 303 28 120
14 LAA 5540 1486 481 274 25 159
15 LAN 5506 1455 543 271 29 137
16 MIL 5535 1398 550 324 35 198
17 MIN 5641 1572 529 298 49 111
18 NYA 5572 1512 535 289 20 180
19 NYN 5606 1491 619 274 38 172
20 OAK 5451 1318 574 270 23 125
21 PHI 5509 1407 586 291 36 214
22 PIT 5628 1454 474 314 21 153
23 SDN 5568 1390 518 264 27 154
24 SEA 5643 1498 417 285 20 124
25 SFN 5543 1452 452 311 37 94
26 SLN 5636 1585 577 283 26 174
27 TBA 5541 1443 626 284 37 180
28 TEX 5728 1619 595 376 35 194
29 TOR 5503 1453 521 303 32 126
30 WAS 5491 1376 534 269 26 117
Aggregating Tables with rowsum
Sometimes, you would simply like to calculate the sum of certain variables in an
object, grouped together by a grouping variable. To do this in R, use the rowsum
function:
rowsum(x, group, reorder = TRUE, ...)
For example, we can use rowsum to summarize batting statistics by team:
> rowsum(batting.2008[,c("AB", "H", "BB", "2B", "3B", "HR")],
+ group=batting.2008$teamID)
AB H BB X2B X3B HR
ARI 5409 1355 587 318 47 159
ATL 5604 1514 618 316 33 130
BAL 5559 1486 533 322 30 172
BOS 5596 1565 646 353 33 173
CHA 5553 1458 540 296 13 235
CHN 5588 1552 636 329 21 184
CIN 5465 1351 560 269 24 187
CLE 5543 1455 560 339 22 171
COL 5557 1462 570 310 28 160
DET 5641 1529 572 293 41 200
FLO 5499 1397 543 302 28 208
HOU 5451 1432 449 284 22 167
KCA 5608 1507 392 303 28 120
LAA 5540 1486 481 274 25 159
LAN 5506 1455 543 271 29 137
MIL 5535 1398 550 324 35 198
MIN 5641 1572 529 298 49 111
NYA 5572 1512 535 289 20 180
NYN 5606 1491 619 274 38 172
OAK 5451 1318 574 270 23 125
PHI 5509 1407 586 291 36 214
PIT 5628 1454 474 314 21 153
SDN 5568 1390 518 264 27 154
SEA 5643 1498 417 285 20 124
SFN 5543 1452 452 311 37 94
SLN 5636 1585 577 283 26 174
TBA 5541 1443 626 284 37 180
TEX 5728 1619 595 376 35 194
TOR 5503 1453 521 303 32 126
WAS 5491 1376 534 269 26 117
Counting Values
Often, it can be useful to count the number of observations that take on each possible
value of a variable. R provides several functions for doing this.
The simplest function for counting the number of observations that take on a value
is the tabulate function. This function counts the number of elements in a vector
that take on each integer value and returns a vector with the counts.
As an example, suppose that you wanted to count the number of players who hit
0 HR, 1 HR, 2 HR, 3 HR, and so on. You could do this with the tabulate function:
> HR.cnts <- tabulate(batting.w.names.2008$HR)
> # tabulate doesn't label results, so let's add names:
> names(HR.cnts) <- 0:(length(HR.cnts) - 1)
> HR.cnts
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
92 63 45 20 15 26 23 21 22 15 15 18 12 10 12 4 9 3 3 13 9 7 10
23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
4 8 2 5 2 4 0 1 6 6 3 1 2 4 1 0 0 0 0 0 0 0 0
46 47
0 1
A related function (for categorical values) is table. Suppose that you are presented
with some data that includes a few categorical values (encoded as factors in R) and
wanted to count how many observations in the data had each categorical value. To
do this, you can use the table function:
table(..., exclude = if (useNA == "no") c(NA, NaN), useNA = c("no",
"ifany", "always"), dnn = list.names(...), deparse.level = 1)
The table function returns a table object showing the number of observations that
have each possible categorical value.2 Here are the arguments to table.
2. If you are familiar with SAS, you can think of table as the equivalent to PROC FREQ.
Argument Description Default
... A set of factors (or objects that can be coerced into factors).
exclude Levels to remove from factors. if (useNA == "no") c(NA,
NaN)
useNA Indicates whether to include NA values in the table. c("no", "ifany",
"always")
dnn Names to be given to dimensions in the result. list.names(...)
deparse.level As noted in the help file: “If the argument dnn is not supplied,
the internal function list.names is called to compute the ‘dim
name names’. If the arguments in ... are named, those names
are used. For the remaining arguments, deparse.level = 0
gives an empty name, deparse.level = 1 uses the supplied
argument if it is a symbol, and deparse.level = 2 will deparse
the argument.”
1
For example, suppose that we wanted to count the number of left-handed batters,
right-handed batters, and switch hitters in 2008. We could use the data frame
batting.w.names.2008 defined above to provide the data and table to tabulate the
results:
> table(batting.w.names.2008$bats)
B L R
118 401 865
To make this a little more interesting, we could make this a two-dimensional table
showing the number of players who batted and threw with each hand:
> table(batting.2008[,c("bats", "throws")])
throws
bats L R
B 10 108
L 240 161
R 25 840
We could extend the results to another dimension, adding league ID:
, , lgID = AL
throws
bats L R
B 4 47
L 109 77
R 11 393
, , lgID = NL
throws
bats L R
B 6 61
L 131 84
R 14 447
Another useful function is xtabs, which creates contingency tables from factors using
formulas:
xtabs(formula = ~., data = parent.frame(), subset, na.action,
exclude = c(NA, NaN), drop.unused.levels = FALSE)
The xtabs function works the same as table, but it allows you to specify the group
ings by specifying a formula and a data frame. In many cases, this can save you some
typing. For example, here is how to use xtabs to tabulate batting statistics by batting
arm and league:
> xtabs(~bats+lgID, batting.2008)
lgID
bats AL NL
B 51 67
L 186 215
R 404 461
The table function only works on factors, but sometimes you might like to calculate
tables with numeric values as well. For example, suppose you wanted to count the
number of players with batting averages in certain ranges. To do this, you could use
the cut function and the table function:
> # first, add batting average to the data frame:
> batting.w.names.2008 <- transform(batting.w.names.2008, AVG = H/AB)
> # now, select a subset of players with over 100 AB (for some
> # statistical significance):
> batting.2008.over100AB <- subset(batting.2008, subset=(AB > 100))
> # finally, split the results into 10 bins:
> battingavg.2008.bins <- cut(batting.2008.over100AB$AVG,breaks=10)
> table(battingavg.2008.bins)
battingavg.2008.bins
(0.137,0.163] (0.163,0.189] (0.189,0.215] (0.215,0.24] (0.24,0.266]
4 6 24 67 121
(0.266,0.292] (0.292,0.318] (0.318,0.344] (0.344,0.37] (0.37,0.396]
132 70 11 5 2
Reshaping Data
Very often, you are presented with data that is in the wrong “shape.” Sometimes,
you might find that a single observation is stored across multiple lines in a data
frame. This happens very often in data warehouses. In these systems, a single table
might be used to represent many different “facts.” Each fact might be associated
with a unique identifier, a timestamp, a concept, and an observed value. To build a
statistical model or to plot results, you might need to create a version of the data in
which each line contains a unique identifier, a timestamp, and a column for each
concept. So you might want to transform this “narrow” data set to a “wide” format.
Other times, you might be presented with a sparsely populated data frame that has
a large number of columns. Although this format might make analysis straightfor
ward, the data set might also be large and difficult to store. So you might want to
transform this wide data set into a narrow one.




Similarly, we can use the same notation to select only certain columns. Suppose that
we wanted to keep only the variables nameFirst, nameLast, AB, H, and BB. We could
provide these in the brackets as well:
> batting.w.names.2008.short <-
+  batting.w.names[batting.w.names$yearID==2008,
+  c("nameFirst", "nameLast", "AB", "H", "BB")]

library(nutshell)
data(toxins.and.cancer)
plot(air_on_site/Surface_Area, deaths_lung/Population,
xlab="Air Release Rate of Toxic Chemicals",
ylab="Lung Cancer Death Rate")

text(air_on_site/Surface_Area, deaths_lung/Population,
labels=State_Abbrev,
cex=0.5,
adj=c(0,-1))


library(nutshell)
data(turkey.price.ts)
plot(turkey.price.ts)
acf(turkey.price.ts)
library(nutshell)
data(doctorates)

> # make this into a matrix:
> doctorates.m <- as.matrix(doctorates[2:7])
> rownames(doctorates.m) <- doctorates[, 1]
> doctorates.m
engineering science education health humanities other
2001 5323 20643 6436 1591 5213 2159
2002 5511 20017 6349 1541 5178 2141
2003 5079 19529 6503 1654 5051 2209
2004 5280 20001 6643 1633 5020 2180
2005 5777 20498 6635 1720 5013 2480
2006 6425 21564 6226 1785 4949 2436

barplot(doctorates.m[1, ])
barplot(doctorates.m, beside=TRUE, horiz=TRUE, legend=TRUE, cex.names=.75)

