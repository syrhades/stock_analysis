qplot
function (x, y = NULL, ..., data, facets = NULL, margins = FALSE, 
    geom = "auto", xlim = c(NA, NA), ylim = c(NA, NA), log = "", 
    main = NULL, xlab = deparse(substitute(x)), ylab = deparse(substitute(y)), 
    asp = NA, stat = NULL, position = NULL) 
{
    if (!missing(stat)) 
        warning("`stat` is deprecated", call. = FALSE)
    if (!missing(position)) 
        warning("`position` is deprecated", call. = FALSE)
    if (!is.character(geom)) 
        stop("`geom` must be a character vector", call. = FALSE)
    argnames <- names(as.list(match.call(expand.dots = FALSE)[-1]))
    arguments <- as.list(match.call()[-1])
    env <- parent.frame()
    aesthetics <- compact(arguments[.all_aesthetics])
    aesthetics <- aesthetics[!is.constant(aesthetics)]
    aes_names <- names(aesthetics)
    aesthetics <- rename_aes(aesthetics)
    class(aesthetics) <- "uneval"
    if (missing(data)) {
        data <- data.frame()
        facetvars <- all.vars(facets)
        facetvars <- facetvars[facetvars != "."]
        names(facetvars) <- facetvars
        facetsdf <- as.data.frame(mget(facetvars, envir = env))
        if (nrow(facetsdf)) 
            data <- facetsdf
    }
    if ("auto" %in% geom) {
        if ("sample" %in% aes_names) {
            geom[geom == "auto"] <- "qq"
        }
        else if (missing(y)) {
            x <- eval(aesthetics$x, data, env)
            if (is.discrete(x)) {
                geom[geom == "auto"] <- "bar"
            }
            else {
                geom[geom == "auto"] <- "histogram"
            }
            if (missing(ylab)) 
                ylab <- "count"
        }
        else {
            if (missing(x)) {
                aesthetics$x <- bquote(seq_along(.(y)), aesthetics)
            }
            geom[geom == "auto"] <- "point"
        }
    }
    p <- ggplot(data, aesthetics, environment = env)
    if (is.null(facets)) {
        p <- p + facet_null()
    }
    else if (is.formula(facets) && length(facets) == 2) {
        p <- p + facet_wrap(facets)
    }
    else {
        p <- p + facet_grid(facets = deparse(facets), margins = margins)
    }
    if (!is.null(main)) 
        p <- p + ggtitle(main)
    for (g in geom) {
        params <- arguments[setdiff(names(arguments), c(aes_names, 
            argnames))]
        params <- lapply(params, eval, parent.frame())
        p <- p + do.call(paste0("geom_", g), params)
    }
    logv <- function(var) var %in% strsplit(log, "")[[1]]
    if (logv("x")) 
        p <- p + scale_x_log10()
    if (logv("y")) 
        p <- p + scale_y_log10()
    if (!is.na(asp)) 
        p <- p + theme(aspect.ratio = asp)
    if (!missing(xlab)) 
        p <- p + xlab(xlab)
    if (!missing(ylab)) 
        p <- p + ylab(ylab)
    if (!missing(xlim)) 
        p <- p + xlim(xlim)
    if (!missing(ylim)) 
        p <- p + ylim(ylim)
    p
}

