#######################################

 library(foreach)
 x <- foreach(i=1:3) %do% sqrt(i)
x
 foreach(a=1:3, b=rep(10, 3)) %do% (a + b)
 foreach(a=1:3, b=rep(10, 3)) %do% {
 a + b
 }
 foreach(a=1:1000, b=rep(10, 2)) %do% {
 a + b
 }

 foreach(i=1:3, .combine='c') %do% exp(i)


foreach(i=1:4, .combine='cbind') %do% rnorm(4)
foreach(i=1:4, .combine='c') %do% rnorm(4)
foreach(i=1:4, .combine='+') %do% rnorm(4)
cfun <- function(...) NULL
x <- foreach(i=1:4, .combine='cfun', .multicombine=TRUE) %do% rnorm(4)

foreach(i=4:1, .combine='c') %dopar% {
 Sys.sleep(3 * i)
 i
 }
library(iterators)
foreach(a=irnorm(4, count=4), .combine='cbind') %do% a

set.seed(123)
x <- foreach(a=irnorm(4, count=1000), .combine='+') %do% a

set.seed(123)
x <- foreach(icount(1000), .combine='+') %do% rnorm(4)
 x <- matrix(runif(500), 100)
 y <- gl(2, 50)


 applyKernel <- function(newX, FUN, d2, d.call, dn.call=NULL, ...) {
 ans <- vector("list", d2)
 for(i in 1:d2) {
 tmp <- FUN(array(newX[,i], d.call, dn.call), ...)
 if(!is.null(tmp)) ans[[i]] <- tmp
 }
 ans
 }
 applyKernel(matrix(1:16, 4), mean, 4, 4)

> applyKernel <- function(newX, FUN, d2, d.call, dn.call=NULL, ...) {
+ foreach(i=1:d2) %dopar%
+ FUN(array(newX[,i], d.call, dn.call), ...)
+ }
> applyKernel(matrix(1:16, 4), mean, 4, 4)
> applyKernel <- function(newX, FUN, d2, d.call, dn.call=NULL, ...) {
+ foreach(x=iter(newX, by='col')) %dopar%
+ FUN(array(x, d.call, dn.call), ...)
+ }
> applyKernel(matrix(1:16, 4), mean, 4, 4)

> applyKernel <- function(newX, FUN, d2, d.call, dn.call=NULL, ...) {
+ foreach(x=iblkcol(newX, 3), .combine='c', .packages='foreach') %dopar% {
+ foreach(i=1:ncol(x)) %do% FUN(array(x[,i], d.call, dn.call), ...)
+ }
+ }
> applyKernel(matrix(1:16, 4), mean, 4, 4)


foreach(a=irnorm(1, count=10), .combine='c') %:% when(a >= 0) %do% sqrt(a)
> qsort <- function(x) {
+ n <- length(x)
+ if (n == 0) {
+ x
+ } else {
+ p <- sample(n, 1)
+ smaller <- foreach(y=x[-p], .combine=c) %:% when(y <= x[p]) %do% y
+ larger <- foreach(y=x[-p], .combine=c) %:% when(y > x[p]) %do% y
+ c(qsort(smaller), x[p], qsort(larger))
+ }
+ }
> qsort(runif(12))


foreach(b=bvec, .combine='cbind') %:%
 foreach(a=avec, .combine='c') %do% {
 sim(a, b)
 }

foreach(b=bvec, .combine='cbind') %:%
+ foreach(a=avec, .combine='c') %dopar% {
+ sim(a, b)
+ }

foreach(b=bvec, .combine='cbind', .options.nws=opts) %:%
+ foreach(a=avec, .combine='c') %dopar% {
+ sim(a, b)
+ }


# equivalent to rnorm(3)
times(3) %do% rnorm(1)

# equivalent to lapply(1:3, sqrt)
foreach(i=1:3) %do%
  sqrt(i)

# equivalent to colMeans(m)
m <- matrix(rnorm(9), 3, 3)
foreach(i=1:ncol(m), .combine=c) %do%
  mean(m[,i])

# normalize the rows of a matrix in parallel, with parenthesis used to
# force proper operator precedence
# Need to register a parallel backend before this example will run
# in parallel
foreach(i=1:nrow(m), .combine=rbind) %dopar%
  (m[i,] / mean(m[i,]))

foreach(i=1:nrow(m), .combine=rbind) %do%
  (m[i,] / mean(m[i,]))
# simple (and inefficient) parallel matrix multiply
library(iterators)
a <- matrix(1:16, 4, 4)
b <- t(a)
foreach(b=iter(b, by='col'), .combine=cbind) %dopar%
  (a %*% b)

# split a data frame by row, and put them back together again without
# changing anything
d <- data.frame(x=1:10, y=rnorm(10))
s <- foreach(d=iter(d, by='row'), .combine=rbind) %dopar% d
identical(s, d)

# a quick sort function
qsort <- function(x) {
  n <- length(x)
  if (n == 0) {
    x
  } else {
    p <- sample(n, 1)
    smaller <- foreach(y=x[-p], .combine=c) %:% when(y <= x[p]) %do% y
    larger  <- foreach(y=x[-p], .combine=c) %:% when(y >  x[p]) %do% y
    c(qsort(smaller), x[p], qsort(larger))
  }
}
qsort(runif(12))