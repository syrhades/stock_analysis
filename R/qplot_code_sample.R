qplot(pressure$temperature, pressure$pressure, geom="line")
debugging in: qplot(pressure$temperature, pressure$pressure, geom = "line")
debug: {
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




> plot_ly
function (data = data.frame(), ..., type = NULL, color, colors = NULL, 
    alpha = 1, symbol, symbols = NULL, size, sizes = c(10, 100), 
    linetype, linetypes = NULL, split, frame, width = NULL, height = NULL, 
    source = "A") 
{
    if (!is.data.frame(data) && !crosstalk::is.SharedData(data)) {
        stop("First argument, `data`, must be a data frame or shared data.", 
            call. = FALSE)
    }
    attrs <- list(...)
    for (i in c("filename", "fileopt", "world_readable")) {
        if (is.null(attrs[[i]])) 
            next
        warning("Ignoring ", i, ". Use `plotly_POST()` if you want to post figures to plotly.")
        attrs[[i]] <- NULL
    }
    if (!is.null(attrs[["group"]])) {
        warning("The group argument has been deprecated. Use `group_by()` or split instead.\\n", 
            "See `help('plotly_data')` for examples")
        attrs[["group"]] <- NULL
    }
    if (!is.null(attrs[["inherit"]])) {
        warning("The inherit argument has been deprecated.")
        attrs[["inherit"]] <- NULL
    }
    attrs$color <- if (!missing(color)) 
        color
    attrs$symbol <- if (!missing(symbol)) 
        symbol
    attrs$linetype <- if (!missing(linetype)) 
        linetype
    attrs$size <- if (!missing(size)) 
        size
    attrs$split <- if (!missing(split)) 
        split
    attrs$frame <- if (!missing(frame)) 
        frame
    attrs$colors <- colors
    attrs$alpha <- alpha
    attrs$symbols <- symbols
    attrs$linetypes <- linetypes
    attrs$sizes <- sizes
    attrs$type <- type
    id <- new_id()
    plotlyVisDat <- data
    p <- list(visdat = setNames(list(function() plotlyVisDat), 
        id), cur_data = id, attrs = setNames(list(attrs), id), 
        layout = list(width = width, height = height, margin = list(b = 40, 
            l = 60, t = 25, r = 10)), source = source)
    config(as_widget(p))
}
<environment: namespace:plotly>



aes(x=temperature, y=pressure)
debugging in: aes(x = temperature, y = pressure)
debug: {
    aes <- structure(as.list(match.call()[-1]), class = "uneval")
    rename_aes(aes)
}

frm_test <- function(...){
    match.call() %>%print
    match.call()[-1] %>%print
    as.list(match.call()[-1])%>%class %>% print
}

frm_test(x=eee,y=ttt)


> getS3method("ggplot","data.frame")
function (data, mapping = aes(), ..., environment = parent.frame()) 
{
    if (!missing(mapping) && !inherits(mapping, "uneval")) {
        stop("Mapping should be created with `aes() or `aes_()`.", 
            call. = FALSE)
    }
    p <- structure(list(data = data, layers = list(), scales = scales_list(), 
        mapping = mapping, theme = list(), coordinates = coord_cartesian(), 
        facet = facet_null(), plot_env = environment), class = c("gg", 
        "ggplot"))
    p$labels <- make_labels(mapping)
    set_last_plot(p)
    p
}
<environment: namespace:ggplot2>
