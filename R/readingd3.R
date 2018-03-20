
R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R是自由软件，不带任何担保。
在某些条件下你可以将其自由散布。
用'license()'或'licence()'来看散布的详细条件。

R是个合作计划，有许多人为之做出了贡献.
用'contributors()'来看合作者的详细情况
用'citation()'会告诉你如何在出版物中正确地引用R或R程序包。

用'demo()'来看一些示范程序，用'help()'来阅读在线帮助文件，或
用'help.start()'通过HTML浏览器来看帮助文件。
用'q()'退出R.

Error attempting to read history from ~/.Rhistory: permission denied (is the .Rhistory file owned by root?)

Package PerformanceAnalytics (1.4.3541) loaded.
Copyright (c) 2004-2014 Peter Carl and Brian G. Peterson, GPL-2 | GPL-3
http://r-forge.r-project.org/projects/returnanalytics/

[Workspace loaded from ~/.RData]

> library(scatterD3)
> library(scatterD3)
> scatterD3(x = mtcars$wt, y = mtcars$mpg)
> ?scatterD3
> scatterD3
function (x, y, data = NULL, lab = NULL, x_log = FALSE, y_log = FALSE, 
    point_size = 64, labels_size = 10, labels_positions = NULL, 
    point_opacity = 1, hover_size = 1, hover_opacity = NULL, 
    fixed = FALSE, col_var = NULL, col_continuous = NULL, colors = NULL, 
    ellipses = FALSE, ellipses_level = 0.95, symbol_var = NULL, 
    size_var = NULL, size_range = c(10, 300), col_lab = NULL, 
    symbol_lab = NULL, size_lab = NULL, key_var = NULL, type_var = NULL, 
    opacity_var = NULL, unit_circle = FALSE, url_var = NULL, 
    tooltips = TRUE, tooltip_text = NULL, xlab = NULL, ylab = NULL, 
    html_id = NULL, width = NULL, height = NULL, legend_width = 150, 
    left_margin = 30, xlim = NULL, ylim = NULL, dom_id_reset_zoom = "scatterD3-reset-zoom", 
    dom_id_svg_export = "scatterD3-svg-export", dom_id_lasso_toggle = "scatterD3-lasso-toggle", 
    transitions = FALSE, menu = TRUE, lasso = FALSE, lasso_callback = NULL, 
    click_callback = NULL, zoom_callback = NULL, lines = data.frame(slope = c(0, 
        Inf), intercept = c(0, 0), stroke_dasharray = c(5, 5)), 
    axes_font_size = "100%", legend_font_size = "100%", caption = NULL) 
{
    if (is.null(xlab)) 
        xlab <- deparse(substitute(x))
    if (is.null(ylab)) 
        ylab <- deparse(substitute(y))
    if (is.null(col_lab)) 
        col_lab <- deparse(substitute(col_var))
    if (is.null(symbol_lab)) 
        symbol_lab <- deparse(substitute(symbol_var))
    if (is.null(size_lab)) 
        size_lab <- deparse(substitute(size_var))
    opacity_lab <- deparse(substitute(opacity_var))
    if (is.null(html_id)) 
        html_id <- paste0("scatterD3-", paste0(sample(LETTERS, 
            8, replace = TRUE), collapse = ""))
    if (!is.null(data)) {
        null_or_name <- function(x) {
            if (x != "NULL") 
                return(data[, x])
            else return(NULL)
        }
        x <- data[, deparse(substitute(x))]
        y <- data[, deparse(substitute(y))]
        lab <- deparse(substitute(lab))
        col_var <- deparse(substitute(col_var))
        size_var <- deparse(substitute(size_var))
        symbol_var <- deparse(substitute(symbol_var))
        opacity_var <- deparse(substitute(opacity_var))
        url_var <- deparse(substitute(url_var))
        key_var <- deparse(substitute(key_var))
        lab <- null_or_name(lab)
        col_var <- null_or_name(col_var)
        size_var <- null_or_name(size_var)
        symbol_var <- null_or_name(symbol_var)
        opacity_var <- null_or_name(opacity_var)
        url_var <- null_or_name(url_var)
        key_var <- null_or_name(key_var)
    }
    x_categorical <- is.factor(x) || !is.numeric(x)
    y_categorical <- is.factor(y) || !is.numeric(y)
    if (x_log) {
        if (any(x <= 0)) 
            stop("Logarithmic scale and negative values in x")
        lines <- lines[!(lines$slope == 0 & lines$intercept == 
            0), ]
    }
    if (y_log) {
        if (any(y <= 0)) 
            stop("Logarithmic scale and negative values in y")
        lines <- lines[!(lines$slope == Inf & lines$intercept == 
            0), ]
    }
    if (!is.null(colors) && !is.null(names(colors))) {
        colors <- as.list(colors)
        if (!setequal(names(colors), unique(col_var))) 
            warning("Set of colors and col_var values do not match")
    }
    if (is.null(col_continuous)) {
        col_continuous <- FALSE
        if (!is.factor(col_var) && is.numeric(col_var) && length(unique(col_var)) > 
            6) {
            col_continuous <- TRUE
        }
    }
    if (is.character(caption)) {
        caption <- list(text = caption)
    }
    data <- data.frame(x = x, y = y)
    if (!is.null(lab)) 
        data <- cbind(data, lab = lab)
    if (!is.null(col_var) && !col_continuous) {
        col_var <- as.character(col_var)
        col_var[is.na(col_var)] <- "NA"
        data <- cbind(data, col_var = col_var)
    }
    if (!is.null(col_var) && col_continuous) {
        if (any(is.na(col_var))) 
            warning("NA values in continuous col_var. Values set to min(0, col_var)")
        col_var[is.na(col_var)] <- min(0, col_var, na.rm = TRUE)
        data <- cbind(data, col_var = col_var)
    }
    if (!is.null(symbol_var)) {
        symbol_var <- as.character(symbol_var)
        symbol_var[is.na(symbol_var)] <- "NA"
        data <- cbind(data, symbol_var = symbol_var)
    }
    if (!is.null(size_var)) {
        if (any(is.na(size_var))) 
            warning("NA values in size_var. Values set to min(0, size_var)")
        size_var[is.na(size_var)] <- min(0, size_var, na.rm = TRUE)
        data <- cbind(data, size_var = size_var)
    }
    if (!is.null(type_var)) 
        data <- cbind(data, type_var = type_var)
    if (!is.null(url_var)) {
        url_var[is.na(url_var)] <- ""
        data <- cbind(data, url_var = url_var)
        if (!is.null(click_callback)) {
            click_callback <- NULL
            warning("Both url_var and click_callback defined, click_callback set to NULL")
        }
    }
    if (!is.null(opacity_var)) 
        data <- cbind(data, opacity_var = opacity_var)
    if (!is.null(key_var)) {
        data <- cbind(data, key_var = key_var)
    }
    else {
        data <- cbind(data, key_var = seq_along(x))
    }
    if (!is.null(tooltip_text)) 
        data <- cbind(data, tooltip_text = tooltip_text)
    compute_ellipse <- function(x, y, level = ellipses_level, 
        npoints = 50) {
        cx <- mean(x)
        cy <- mean(y)
        data.frame(ellipse::ellipse(stats::cov(cbind(x, y)), 
            centre = c(cx, cy), level = level, npoints = npoints))
    }
    ellipses_data <- list()
    if (ellipses && !col_continuous && !x_categorical && !y_categorical) {
        if (is.null(col_var)) {
            ell <- compute_ellipse(x, y)
            ellipses_data <- append(ellipses_data, list(list(level = "_scatterD3_all", 
                data = ell)))
        }
        else {
            for (l in unique(col_var)) {
                sel <- col_var == l & !is.na(col_var)
                if (sum(sel) > 2) {
                  tmpx <- x[sel]
                  tmpy <- y[sel]
                  ell <- compute_ellipse(tmpx, tmpy)
                  ellipses_data <- append(ellipses_data, list(list(level = l, 
                    data = ell)))
                }
            }
        }
    }
    else {
        ellipses <- FALSE
    }
    hashes <- list()
    if (transitions) {
        for (var in c("x", "y", "lab", "key_var", "col_var", 
            "symbol_var", "size_var", "ellipses_data", "opacity_var", 
            "lines")) {
            hashes[[var]] <- digest::digest(get(var), algo = "sha256")
        }
    }
    settings <- list(x_log = x_log, y_log = y_log, labels_size = labels_size, 
        labels_positions = labels_positions, point_size = point_size, 
        point_opacity = point_opacity, hover_size = hover_size, 
        hover_opacity = hover_opacity, xlab = xlab, ylab = ylab, 
        has_labels = !is.null(lab), col_lab = col_lab, col_continuous = col_continuous, 
        colors = colors, ellipses = ellipses, ellipses_data = ellipses_data, 
        symbol_lab = symbol_lab, size_range = size_range, size_lab = size_lab, 
        opacity_lab = opacity_lab, unit_circle = unit_circle, 
        has_color_var = !is.null(col_var), has_symbol_var = !is.null(symbol_var), 
        has_size_var = !is.null(size_var), has_opacity_var = !is.null(opacity_var), 
        has_url_var = !is.null(url_var), has_legend = !is.null(col_var) || 
            !is.null(symbol_var) || !is.null(size_var), has_tooltips = tooltips, 
        tooltip_text = tooltip_text, has_custom_tooltips = !is.null(tooltip_text), 
        click_callback = htmlwidgets::JS(click_callback), zoom_callback = htmlwidgets::JS(zoom_callback), 
        fixed = fixed, legend_width = legend_width, left_margin = left_margin, 
        html_id = html_id, xlim = xlim, ylim = ylim, x_categorical = x_categorical, 
        y_categorical = y_categorical, menu = menu, lasso = lasso, 
        lasso_callback = htmlwidgets::JS(lasso_callback), dom_id_reset_zoom = dom_id_reset_zoom, 
        dom_id_svg_export = dom_id_svg_export, dom_id_lasso_toggle = dom_id_lasso_toggle, 
        transitions = transitions, axes_font_size = axes_font_size, 
        legend_font_size = legend_font_size, caption = caption, 
        lines = lines, hashes = hashes)
    x <- list(data = data, settings = settings)
    htmlwidgets::createWidget(name = "scatterD3", x, width = width, 
        height = height, package = "scatterD3", sizingPolicy = htmlwidgets::sizingPolicy(browser.fill = TRUE, 
            viewer.fill = TRUE))
}
<environment: namespace:scatterD3>
