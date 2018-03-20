function (data, main = NULL, xlab = NULL, ylab = NULL, periodicity = NULL, 
    group = NULL, elementId = NULL, width = NULL, height = NULL) 
{
    if (xts::xtsible(data)) {
        if (!xts::is.xts(data)) 
            data <- xts::as.xts(data)
        format <- "date"
    }
    else if (is.list(data) && is.numeric(data[[1]])) {
        if (is.null(names(data))) 
            stop("For numeric values, 'data' must be a named list or data frame")
        format <- "numeric"
    }
    else {
        stop("Unsupported type passed to argument 'data'.")
    }
    if (format == "date") {
        if (is.null(periodicity)) {
            if (nrow(data) < 2) {
                periodicity <- defaultPeriodicity(data)
            }
            else {
                periodicity <- xts::periodicity(data)
            }
        }
        time <- time(data)
        data <- zoo::coredata(data)
        data <- unclass(as.data.frame(data))
        timeColumn <- list()
        timeColumn[[periodicity$label]] <- asISO8601Time(time)
        data <- append(timeColumn, data)
    }
    else {
        data <- as.list(data)
    }
    attrs <- list()
    attrs$title <- main
    attrs$xlabel <- xlab
    attrs$ylabel <- ylab
    attrs$labels <- names(data)
    attrs$legend <- "auto"
    attrs$retainDateWindow <- FALSE
    attrs$axes$x <- list()
    attrs$axes$x$pixelsPerLabel <- 60
    x <- list()
    x$attrs <- attrs
    x$scale <- if (format == "date") 
        periodicity$scale
    else NULL
    x$group <- group
    x$annotations <- list()
    x$shadings <- list()
    x$events <- list()
    x$format <- format
    attr(x, "time") <- if (format == "date") 
        time
    else NULL
    attr(x, "data") <- data
    attr(x, "autoSeries") <- 2
    names(data) <- NULL
    x$data <- data
    htmlwidgets::createWidget(name = "dygraphs", x = x, width = width, 
        height = height, htmlwidgets::sizingPolicy(viewer.padding = 10, 
            browser.fill = TRUE), elementId = elementId)
}
