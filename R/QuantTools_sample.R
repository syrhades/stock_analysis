data( ticks )

# bw is very usefull to filter time series data:
# select single year
ticks[ time %bw% '2016' ]

# select single month
ticks[ time %bw% '2016-05' ]

# select single date
ticks[ time %bw% '2016-05-11' ]
# also works with Date class
ticks[ time %bw% as.Date( '2016-05-11' ) ]

# select single hour
ticks[ time %bw% '2016-05-11 10' ]

# select single minute
ticks[ time %bw% '2016-05-11 10:20' ]

# select single second
ticks[ time %bw% '2016-05-11 10:20:53' ]

# select between two months inclusive
ticks[ time %bw% '2016-05/2016-08' ]

# select from month begin and date
ticks[ time %bw% '2016-05/2016-06-23' ]

# select between two timestamps
ticks[ time %bw% '2016-05-02 09:30/2016-05-02 11:00' ]
# also works with incomplete timestamps
ticks[ time %bw% '2016-05-02 09:30/2016-05-02 11' ]

# select all dates but with time between 09:30 and 16:00
ticks[ time %bw% '09:30/16:00' ]

# also bw can be used as a shortcut for 'a <= x & x <= b' for non-'POSIXct' classes:
# numeric
15:25 %bw% c( 10, 20 )

# character
letters %bw% c( 'a', 'f' )

# dates
Sys.Date() %bw% ( Sys.Date() + c( -10, 10 ) )


dofc
function (x, fun, ...)
{
    x = copy(x)
    if (is.character(fun))
        fun = eval(parse(text = paste("function( x ) {", fun,
            "}")))
    if (inherits(x[[1]], c("Date", "POSIXct"))) {
        for (j in seq_along(x)[-1]) set(x, j = j, value = fun(x[[j]],
            ...))
    }
    else {
        for (j in seq_along(x)) set(x, j = j, value = fun(x[[j]],
            ...))
    }
    return(x)
}



char_fun <- function (fun,...){
	# char_fun(seq,5)
	# char_fun("seq",5)

    if (is.character(fun))
        fun = eval(parse(text = paste("function( ...) {", fun,
            "(...)}")))
    # if (inherits(x[[1]], c("Date", "POSIXct"))) {
    #     data.table(x[, 1], fun(x[, -1], ...))
    # }
    # else {
    #     fun(x, ...)
    # }
    fun(...)
}
names(pryr::find_uses("package:base", "sum"))

envs <- c("package:base", "package:utils", "package:QuantTools")
funs <- c("lapply_named")
find_uses(envs, funs)

envs <- c("package:base", "package:utils", "package:stats")
funs <- c("match.call", "sys.call")
find_uses(envs, funs)

bbands(xts_2017$close, 20, 2)

> get_google_data
function (symbol, from, to = from)
{
    curr_date = format(Sys.Date())
    if (from > curr_date)
        from = to = curr_date
    if (to > curr_date)
        to = curr_date
    from = as.Date(from)
    to = as.Date(to)
    url = paste0("https://finance.google.com/finance/historical?",
        "q=", symbol, "&startdate=", format(from, "%b"), "+",
        format(from, "%d"), ",+", format(from, "%Y"), "&enddate=",
        format(to, "%b"), "+", format(to, "%d"), ",+", format(to,
            "%Y"), "&output=csv")
    suppressWarnings({
        x = fread(url, showProgress = FALSE)
    })
    setnames(x, c("date", "open", "high", "low", "close", "volume"))
    if (x[, .N == 0])
        return(NULL)
    x[, `:=`(date, as.Date(date, "%d-%b-%y"))][.N:1][]
}

hist_dt(bbands(xts_2017$close, 20, 2))


library( QuantTools )
# load ticks data set
data( ticks )
# convert them to hourly candles
timeframe = 60 * 60 
candles = to_candles( ticks, timeframe )
candles


symbols = c( 'AAPL', 'MSFT' )
prices = lapply_named( symbols, get_yahoo_data, from = '2010-01-01', to = '2016-01-01' )
prices = lmerge( prices, 'date', 'close' )

roll_lm = roll_lm( prices$AAPL, prices$MSFT, 50 )

layout( matrix( 1:5, ncol = 1 ) )
par( mar = c( 0, 4.1, 0, 2.1 ), xaxt = 'n' )
plot_ts( prices )
plot_ts( prices[ , .( date, alpha     = roll_lm$alpha     ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, beta      = roll_lm$beta      ) ], col = 'firebrick' )
plot_ts( prices[ , .( date, r         = roll_lm$r         ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 0, 2.1 ), xaxt = 's' )
plot_ts( prices[ , .( date, r.squared = roll_lm$r.squared ) ], col = 'firebrick' )
par( mar = c( 5.1, 4.1, 4.1, 2.1 ) )

sma_short = sma( candles$'close', 50 )
sma_long  = sma( candles$'close', 100 )
crossover = crossover( sma_short, sma_long )

plot_ts( candles )

candles[ crossover == 'UP', abline( v = t_to_x( time ), col = 'blue' ) ]
candles[ crossover == 'DN', abline( v = t_to_x( time ), col = 'red' ) ]
plot_ts( candles[ , .( time, sma_short, sma_long ) ], col = c( 'firebrick', 'goldenrod' ), add = T )




Rolling Volume Profile
This indicator is not common. Volume profile is the distribution of volume over price. It is formed tick by tick and partially forgets past values over time interval. When volume on any bar is lower than specified critical value the bar is cut.

timeframe = 60   # time interval
step      = 0.01 # bar step
alpha     = 0.98 # decay coefficient
cut       = 100  # cut threshold
vp = roll_volume_profile( ticks[ time %bw% '2016-05-09' ], timeframe, step, alpha, cut )

profiles = rbindlist( vp$profile )
# normalize profiles volume
profiles[, volume_norm := volume / max( volume ), by = time ]

# plot indicator values as heat vector
candles = to_candles( ticks, timeframe )[ time %bw% '2016-05-09' ]
plot_ts( candles )
profiles[, rect( 
  xleft   = t_to_x( time - timeframe ),
  xright  = t_to_x( time ),
  ybottom = price - step / 2,
  ytop    = price + step / 2,
  col     = rgb( 0.70, 0.13, 0.13, volume_norm ),
  border = NA
) ]



> fun_calls
function (f)
{
    if (is.function(f)) {
        fun_calls(body(f))
    }
    else if (is.call(f)) {
        fname <- as.character(f[[1]])
        if (identical(fname, ".Internal"))
            return(fname)
        unique(c(fname, unlist(lapply(f[-1], fun_calls), use.names = FALSE)))
    }
}

cl <- call("round", 10.5)
cl %>% llply(function(x) x)

cl %>% eval

cl <- call("round")
cl <- call(round)

frm_get_fun_name <- function(FUN){
 f <- substitute(FUN) %>% as.character
 call <- make_call(f)
 call[[1]] %>% as.character
	# g <- as.call(list(FUN,quote(A)))
	# g %>% llply(function(x) x)
}


frm_get_fun_name2 <-  function (call, env = parent.frame())
{
    call <- standardise_call(substitute(call), env)
    generic <- as.character(call[[1]])
    generic
}
frm_get_fun_name2(ls)
# frm_get_fun_name(ee)


frm_get_fun_name3 <-  function (call)
{
	delayedAssign("x", call)
	uneval(call)%>% as.character
}
frm_get_fun_name3(ls)


# debugonce(frm_get_fun_name)
frm_get_fun_name4<-function(fun){
	# ee <- frm_get_fun_name3(fun)
	# delayedAssign("x", fun)
	# frm_get_fun_name3()
	subs(fun) 
}
frm_get_fun_name4(gsub)

cl <- call("ls", 10.5)
cl %>% llply(function(x) x)


g <- as.call(list(ls,quote(A)))


find_funs("package:base", fun_calls, "match.fun", fixed = TRUE)
find_funs("package:stats", fun_args, "^[A-Z]+$")

fun_calls(match.call)
fun_calls(write.csv)

fun_body(write.csv)
find_funs("package:utils", fun_body, "write", fixed = TRUE)


> find_funs
function (env = parent.frame(), extract, pattern, ...)
{
    env <- to_env(env)
    if (length(pattern) > 1)
        pattern <- str_c(pattern, collapse = "|")
    test <- function(x) {
        f <- get(x, env)
        if (!is.function(f))
            return(FALSE)
        any(grepl(pattern, extract(f), ...))
    }
    fs <- ls(env)
    Filter(test, fs)
}
<environment: namespace:pryr>


> match.fun
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

debugonce(match.fun)
match.fun("ls")


debugonce(do_call)
do_call(quote(ls))


getLoadedDLLs()

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

getFromNamespace("findGeneric", "utils")

fixInNamespace("predict.ppr", "stats")
stats:::predict.ppr
getS3method("predict", "ppr")

fixInNamespace("predict.ppr", pos = 3)
fixInNamespace("predict.ppr", pos = "package:stats")

getAnywhere("format.dist")
getAnywhere("simpleLoess") # not exported from stats
argsAnywhere(format.dist)

frmtest <- function(...){
	substitute(expression(a + b), list(...))
}
frmtest(a=3)
frmtest(a=3,b=5) %>% eval
frmtest(a=3,b=5) %>% eval %>%eval


myplot <- function(x, y)
    plot(x, y, xlab = deparse(substitute(x)),
         ylab = deparse(substitute(y)))


find_funs("package:base", fun_calls, "substitute", fixed = TRUE)
 [1] "::"                         ":::"
 [3] "as.data.frame.array"        "as.data.frame.AsIs"
 [5] "as.data.frame.character"    "as.data.frame.model.matrix"
 [7] "as.data.frame.POSIXlt"      "as.Date.date"
 [9] "as.Date.dates"              "as.Date.default"
[11] "as.POSIXct.date"            "as.POSIXct.dates"
[13] "as.POSIXct.default"         "as.POSIXlt.default"
[15] "bquote"                     "by.data.frame"
[17] "by.default"                 "data.frame"
[19] "detach"                     "library"
[21] "local"                      "ls"
[23] "match.arg"                  "match.fun"
[25] "objects"                    "replicate"
[27] "require"                    "save"
[29] "source"                     "subset.data.frame"
[31] "subset.matrix"              "table"
[33] "textConnection"             "transform.data.frame"
[35] "with.default"               "within.data.frame"
[37] "within.list"


> find_funs("package:base", fun_calls, "deparse", fixed = TRUE)
Using environment package:base
 [1] "all.equal.formula"          "all.equal.language"
 [3] "as.character.condition"     "as.character.error"
 [5] "as.data.frame.array"        "as.data.frame.AsIs"
 [7] "as.data.frame.character"    "as.data.frame.default"
 [9] "as.data.frame.model.matrix" "as.data.frame.POSIXlt"
[11] "as.Date.date"               "as.Date.dates"
[13] "as.Date.default"            "as.POSIXct.date"
[15] "as.POSIXct.dates"           "as.POSIXct.default"
[17] "as.POSIXlt.default"         "attachNamespace"
[19] "by.data.frame"              "by.default"
[21] "chkDots"                    "data.frame"
[23] "detach"                     "dput"
[25] "dump"                       "format.default"
[27] "loadNamespace"              "ls"
[29] "match.fun"                  "mode"
[31] "objects"                    "parseNamespaceFile"
[33] "print.condition"            "print.warnings"
[35] "source"                     "split.default"
[37] "stopifnot"                  "table"
[39] "textConnection"             "try"
[41] "unloadNamespace"