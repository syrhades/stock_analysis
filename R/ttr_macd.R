function (x, nFast = 12, nSlow = 26, nSig = 9, maType, percent = TRUE, 
    ...) 
{
    if (missing(maType)) {
        maType <- "EMA"
    }
    if (is.list(maType)) {
        maTypeInfo <- sapply(maType, is.list)
        if (!(all(maTypeInfo) && length(maTypeInfo) == 3)) {
            stop("If 'maType' is a list, you must specify\n ", 
                "*three* MAs (see Examples section of ?MACD)")
        }
        if (!is.null(formals(maType[[1]][[1]])$n) && is.null(maType[[1]]$n)) {
            maType[[1]]$n <- nFast
        }
        if (!is.null(formals(maType[[2]][[1]])$n) && is.null(maType[[2]]$n)) {
            maType[[2]]$n <- nSlow
        }
        if (!is.null(formals(maType[[3]][[1]])$n) && is.null(maType[[3]]$n)) {
            maType[[3]]$n <- nSig
        }
        mavg.fast <- do.call(maType[[1]][[1]], c(list(x), maType[[1]][-1]))
        mavg.slow <- do.call(maType[[2]][[1]], c(list(x), maType[[2]][-1]))
    }
    else {
        mavg.fast <- do.call(maType, c(list(x), list(n = nFast, 
            ...)))
        mavg.slow <- do.call(maType, c(list(x), list(n = nSlow, 
            ...)))
    }
    if (percent) {
        macd <- 100 * (mavg.fast/mavg.slow - 1)
    }
    else {
        macd <- mavg.fast - mavg.slow
    }
    if (is.list(maType)) {
        signal <- do.call(maType[[3]][[1]], c(list(macd), maType[[3]][-1]))
    }
    else signal <- do.call(maType, c(list(macd), list(n = nSig, 
        ...)))
    result <- cbind(macd, signal)
    colnames(result) <- c("macd", "signal")
    return(result)
}
<environment: namespace:TTR>

