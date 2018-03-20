
> as.matrix
standardGeneric for "as.matrix" defined from package "base"

function (x, ...)
standardGeneric("as.matrix")
<environment: 0x0000000006485390>
Methods may be defined for arguments: x
Use  showMethods("as.matrix")  for currently available ones.
> showMethods("as.matrix")
Function: as.matrix (package base)
x="ANY"
x="data.frame"
    (inherited from: x="ANY")
x="Matrix"
x="numeric"
    (inherited from: x="ANY")
x="timeSeries"
showMethods("summary")
Function: summary (package base)
object="ANY"
object="DBIObject"
object="diagonalMatrix"
object="J48"
    (inherited from: object="ANY")
object="quantmod"
object="sparseMatrix"


methods("summary")
methods("quantile")
 [1] summary,ANY-method             summary.aov                   
 [3] summary.aovlist*               summary.aspell*               
 [5] summary.bit*                   summary.bitwhich*             
 [7] summary.check_packages_in_dir* summary.connection            
 [9] summary.data.frame             summary.Date                  
[11] summary,DBIObject-method       summary.default               
[13] summary.Duration*              summary.ecdf*                 
[15] summary.factor                 summary.glm                   
[17] summary.infl*                  summary.integer64*            
[19] summary.Interval*              summary.List*                 
[21] summary.lm                     summary.loess*                
[23] summary.manova                 summary.matrix                
[25] summary.mlm*                   summary.nls*                  
[27] summary.packageStatus*         summary.PDF_Dictionary*       
[29] summary.PDF_Stream*            summary.Period*               
[31] summary.POSIXct                summary.POSIXlt               
[33] summary.ppr*                   summary.prcomp*               
[35] summary.princomp*              summary.proc_time             
[37] summary,quantmod-method        summary.ri*                   
[39] summary.shingle*               summary.srcfile               
[41] summary.srcref                 summary.stepfun               
[43] summary.stl*                   summary.table                 
[45] summary.trellis*               summary.tukeysmooth*          
[47] summary.yearmon*               summary.yearqtr*              
[49] summary.zoo*                  
see '?methods' for accessing help and source code

methods("plot")
 [1] plot.acf*               plot.chobTA*            plot.clustCombi        
 [4] plot.data.frame*        plot.decomposed.ts*     plot.default           
 [7] plot.dendrogram*        plot.density*           plot.densityMclust     
[10] plot.ecdf               plot.factor*            plot.formula*          
[13] plot.function           plot.gmmhd              plot.hclust*           
[16] plot.histogram*         plot.HoltWinters*       plot.isoreg*           
[19] plot.lm*                plot.Mclust             plot.mclustBIC         
[22] plot.MclustBootstrap    plot.mclustBootstrapLRT plot.MclustDA          
[25] plot.MclustDR           plot.mclustICL          plot.medpolish*        
[28] plot.mlm*               plot.ppr*               plot.prcomp*           
[31] plot.princomp*          plot.profile.nls*       plot.quantmod*         
[34] plot.quantmodResults*   plot.R6*                plot.raster*           
[37] plot.replot*            plot.replot_xts*        plot.shingle*          
[40] plot.spec*              plot.stepfun            plot.stl*              
[43] plot.table*             plot.trellis*           plot.ts                
[46] plot.tskernel*          plot.TukeyHSD*          plot.xts*              
[49] plot.zoo*              


frm_method_inspect <- function(method_str){
    # lst_S3S4<- frm_method_inspect("hist")
    df_methods <- methods(method_str) %>%attr("info")
    df_methods$method <- rownames(df_methods)
    df_s4 <- df_methods %>% dplyr::filter(isS4 == T)
    df_s3 <- df_methods %>% dplyr::filter(isS4 == F)
    df_s3 <- df_s3 %>%tidyr::separate(method,c("methods","class"),"\\.")
    # df_s3 <- df_s3 %>% transform(method_code =getS3method(methods,class) )
    # df_s3code <- mapply(getS3method,df_s3$methods,df_s3$class)

    list(s4=df_s4,s3=df_s3)
}

lst_S3S4<- frm_method_inspect("hist")
lst_S3S4$s3
# foreach (item = lst_S3S4$s3) %do%{
#     # methods_name <- item[c("methods")]
#     methods_name <- item[1]
#     # class_name <- item[c("class")]
#     class_name <- item[2]
#     print(methods_name)
#     print(class_name)
#     # getS3method(methods_name,class_name)
#     # item[1] %>% print
#     # item[2] %>% print
# }
# codelist<-s3code_list[[1]] %>%toJSON(pretty=T) %>% as.character %>% stringr::str_split('", "') #%>% write("e:/eee.log")
# codelist %>% l_ply(function(line)write(line,file="e:/eee.log",append=T))
frm_show_function_code <- function(fun_obj){
    # s3code_list[[1]] %>%frm_show_function_code %>% write(file="e:/eee.log",append=F)
    # fun_obj %>%toJSON(pretty=T) %>% as.character %>% stringr::str_split('", "')
    fun_obj %>%toJSON(pretty=T) %>% as.character %>% stringr::str_replace_all('", "',"\n")
}

frm_s3_code_df <- function(lst_S3_obj){
    # frm_s3_code_df(lst_S3S4$s3) %>%str
    s3code_list <- mapply( 
                    getS3method,
                    lst_S3_obj$methods,
                    lst_S3_obj$class
                    )
    s3code_df <- s3code_list %>% ldply(frm_show_function_code)
    names(s3code_df) <- c("methods","code")
    s3code_df$class <- lst_S3S4$s3$class
    s3code_df #%>% str
}

frm_s3_code_df(lst_S3S4$s3) %>%
    frm_write_db("R_code.db","function")
frm_write_code_file <- function(classname,methodsname,codebody){
    write(
                codebody,
                file=paste(classname,methodsname,sep="_") %>%frm_modify_path#,
                # append=FALSE
                )
}
frm_save_code2file <- function(df_obj){
    mapply( 
                    frm_write_code_file,
                    
                    df_obj$class,
                    df_obj$methods,
                    df_obj$code
                    )

}
frm_s3_code_df(lst_S3S4$s3) %>%
    frm_save_code2file

frm_s3_code_df(lst_S3S4$s3) %>%str
# s3code_list[[1]] %>%frm_show_function_code %>% write(file="e:/eee.log",append=F)





s3code_list[[1]] %>%toJSON(pretty=T) %>%split(",") %>% llply(writeLines(con="e:/eee.log"))
s3code_list[[1]] %>%toJSON(pretty=T)  %>% toHTML

 

 %>% writeLines(con="e:/eee.log")


getS3method("ggplot","data.frame")

frm_method_inspect("summary")
df_methods <- methods("summary") %>%attr("info")
df_methods$method <- rownames(df_methods)
df_s4 <- df_methods %>% dplyr::filter(isS4 == T)
df_s3 <- df_methods %>% dplyr::filter(isS4 == F)
getS3method("summary","aovlist")
getS3method("summary","aovlist")
getS3method("A2Rplot","hclust")
getS3method("describe","data.frame")
getS3method("ggplot","data.frame")
getS3method("plot","data.frame")
showMethods(data.frame:::plot)
> methods("hist")
[1] hist.Date*   hist.default hist.POSIXt* hist.times*
see '?methods' for accessing help and source code
showMethods(Date:::hist)
getS3method("hist","default")


> getS3method("plot","data.frame")
function (x, ...)
{
    plot2 <- function(x, xlab = names(x)[1L], ylab = names(x)[2L],
        ...) plot(x[[1L]], x[[2L]], xlab = xlab, ylab = ylab,
        ...)
    if (!is.data.frame(x))
        stop("'plot.data.frame' applied to non data frame")
    if (ncol(x) == 1) {
        x1 <- x[[1L]]
        cl <- class(x1)
        if (cl %in% c("integer", "numeric"))
            stripchart(x1, ...)
        else plot(x1, ...)
    }
    else if (ncol(x) == 2) {
        plot2(x, ...)
    }
    else {
        pairs(data.matrix(x), ...)
    }
}
plot.data.frame*        plot.decomposed.ts*     plot.default           
 [7] plot.dendrogram*


getS3method("ggplot","data.frame")
getS3method("rollapply","xts")
[1] rollapply.default* rollapply.ts*      rollapply.xts*     rollapply.zoo*
see '?methods' for accessing help and source code


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


function (x, y, ...)
{
    aes <- structure(as.list(match.call()[-1]), class = "uneval")
    rename_aes(aes)
}
<environment: namespace:ggplot2>


# <environment: namespace:ggplot2>


methods("A2Rplot")
[1] A2Rplot.default A2Rplot.hclust 
methods("ggplot")
#S4
showMethods("summary")
selectMethod("summary","DBI")
getMethod("summary","DBI")
getMethod("summary","quantmod")
getMethod("summary","diagonalMatrix")


hasMethod("summary", "DBI") # TRUE
existsMethod("summary", "DBI") # TRUE
existsMethod("summary", "quantmod") # TRUE

hasMethod("testFun", "integer") #TRUE, inherited

existsMethod("testFun", "integer")


#   visible     from generic isS4                   method
# 1    TRUE     base summary TRUE       summary,ANY-method
# 2    TRUE      DBI summary TRUE summary,DBIObject-method
# 3    TRUE quantmod summary TRUE  summary,quantmod-method

showMethods(DBI:::summary)
showMethods(class = "DBI")
showMethods(class = "DBI")
showMethods("summary",class = "DBI")


require("Matrix")
showMethods("%*%")# many!
    methods(class = "Matrix")# nothing
showMethods(class = "Matrix")# everything
showMethods(Matrix:::isDiagonal) # a non-exported generic

> showMethods("summary")
Function: summary (package base)
object="ANY"
object="DBIObject"
object="diagonalMatrix"
object="quantmod"
object="sparseMatrix"



selectMethod("summary","DBI")
Method Definition (Class "derivedDefaultMethod"):

function (object, ...) 
UseMethod("summary")
<bytecode: 0x9ae08f0>
<environment: namespace:base>

Signatures:
        object
target  "DBI" 
defined "ANY" 
getMethod("summary","DBI")


getMethod("summary","quantmod")
getMethod("summary","diagonalMatrix")
Method Definition:

function (object, ...) 
{
    .local <- function (object) 
    {
        cat("\\nquantmod object:  ", object@model.id, "\\tBuild date: ", 
            paste(object@build.date), "\\n")
        cat("\\nModel Specified: \\n    ", gsub("[ ]+", " ", deparse(object@model.spec)), 
            "\\n")
        cat("\\nModel Target: ", object@model.target, "\\t\\t", 
            "Product: ", object@product, "\\n")
        cat("Model Inputs: ", paste(object@model.inputs, collapse = ", "), 
            "\\n\\n")
        cat("Fitted Model: \\n\\n")
        if (class(object@fitted.model)[1] == "NULL") {
            cat("\\tNone Fitted\\n")
        }
        else {
            cat("\\tModelling procedure: ", class(object@fitted.model), 
                "\\n")
            cat("\\tTraining window: ", length(object@training.data), 
                " observations from ", paste(object@training.data[c(1, 
                  length(object@training.data))], collapse = " to "))
            cat("\\n")
            summary(object@fitted.model)
        }
    }
    .local(object, ...)
}
<environment: namespace:quantmod>

Signatures:
        object    
target  "quantmod"
defined "quantmod"
testFun <-  function(x)x
setGeneric("testFun")
setMethod("testFun", "numeric", function(x)x+1)

hasMethod("testFun", "numeric") # TRUE

hasMethod("testFun", "integer") #TRUE, inherited

existsMethod("testFun", "integer") #FALSE

hasMethod("testFun") # TRUE, default method

hasMethod("testFun", "ANY")

setClass("A", slots = c(a="numeric"))
setMethod("plot", "A", function(x,y,...){ cat("A meth\n") })
dumpMethod("plot","A", file="")
## Not run: 
setMethod("plot", "A",
function (x, y, ...)
{
    cat("AAAAA\n")
}
)

> pmin(5:1, pi)
[1] 3.141593 3.141593 3.000000 2.000000 1.000000



pic <- function(x){
    par(mfrow=c(2,2))
    hist(x)
    dotchart(x)
    boxplot(x)
    qqnorm(x);qqline(x)
    par(mfrow=c(1,1))

}
pic(mtcars$mpg)
p50



> getS3method("quantile","default")
function (x, probs = seq(0, 1, 0.25), na.rm = FALSE, names = TRUE, 
    type = 7, ...) 
{
    if (is.factor(x)) {
        if (is.ordered(x)) {
            if (!any(type == c(1L, 3L))) 
                stop("'type' must be 1 or 3 for ordered factors")
        }
        else stop("factors are not allowed")
        lx <- levels(x)
    }
    else lx <- NULL
    if (na.rm) 
        x <- x[!is.na(x)]
    else if (anyNA(x)) 
        stop("missing values and NaN's not allowed if 'na.rm' is FALSE")
    eps <- 100 * .Machine$double.eps
    if (any((p.ok <- !is.na(probs)) & (probs < -eps | probs > 
        1 + eps))) 
        stop("'probs' outside [0,1]")
    n <- length(x)
    if (na.p <- any(!p.ok)) {
        o.pr <- probs
        probs <- probs[p.ok]
        probs <- pmax(0, pmin(1, probs))
    }
    np <- length(probs)
    if (n > 0 && np > 0) {
        if (type == 7) {
            index <- 1 + (n - 1) * probs
            lo <- floor(index)
            hi <- ceiling(index)
            x <- sort(x, partial = unique(c(lo, hi)))
            qs <- x[lo]
            i <- which(index > lo & x[hi] != qs)
            h <- (index - lo)[i]
            qs[i] <- (1 - h) * qs[i] + h * x[hi[i]]
        }
        else {
            if (type <= 3) {
                nppm <- if (type == 3) 
                  n * probs - 0.5
                else n * probs
                j <- floor(nppm)
                h <- switch(type, (nppm > j), ((nppm > j) + 1)/2, 
                  (nppm != j) | ((j%%2L) == 1L))
            }
            else {
                switch(type - 3, {
                  a <- 0
                  b <- 1
                }, a <- b <- 0.5, a <- b <- 0, a <- b <- 1, a <- b <- 1/3, 
                  a <- b <- 3/8)
                fuzz <- 4 * .Machine$double.eps
                nppm <- a + probs * (n + 1 - a - b)
                j <- floor(nppm + fuzz)
                h <- nppm - j
                if (any(sml <- abs(h) < fuzz)) 
                  h[sml] <- 0
            }
            x <- sort(x, partial = unique(c(1, j[j > 0L & j <= 
                n], (j + 1)[j > 0L & j < n], n)))
            x <- c(x[1L], x[1L], x, x[n], x[n])
            qs <- x[j + 2L]
            qs[h == 1] <- x[j + 3L][h == 1]
            other <- (0 < h) & (h < 1) & (x[j + 2L] != x[j + 
                3L])
            if (any(other)) 
                qs[other] <- ((1 - h) * x[j + 2L] + h * x[j + 
                  3L])[other]
        }
    }
    else {
        qs <- rep(NA_real_, np)
    }
    if (is.character(lx)) 
        qs <- factor(qs, levels = seq_along(lx), labels = lx, 
            ordered = TRUE)
    if (names && np > 0L) {
        names(qs) <- format_perc(probs)
    }
    if (na.p) {
        o.pr[p.ok] <- qs
        names(o.pr) <- rep("", length(o.pr))
        names(o.pr)[p.ok] <- names(qs)
        o.pr
    }
    else qs
}
<bytecode: 0x53f7cd8>
<environment: namespace:stats>


> fivenum
function (x, na.rm = TRUE) 
{
    xna <- is.na(x)
    if (any(xna)) {
        if (na.rm) 
            x <- x[!xna]
        else return(rep.int(NA, 5))
    }
    x <- sort(x)
    n <- length(x)
    if (n == 0) 
        rep.int(NA, 5)
    else {
        n4 <- floor((n + 3)/2)/2
        d <- c(1, n4, (n + 1)/2, n + 1 - n4, n)
        0.5 * (x[floor(d)] + x[ceiling(d)])
    }
}
<bytecode: 0x57d2e60>
<environment: namespace:stats>

众数 离散型 : x %>% table %>% which.max

> var
function (x, y = NULL, na.rm = FALSE, use) 
{
    if (missing(use)) 
        use <- if (na.rm) 
            "na.or.complete"
        else "everything"
    na.method <- pmatch(use, c("all.obs", "complete.obs", "pairwise.complete.obs", 
        "everything", "na.or.complete"))
    if (is.na(na.method)) 
        stop("invalid 'use' argument")
    if (is.data.frame(x)) 
        x <- as.matrix(x)
    else stopifnot(is.atomic(x))
    if (is.data.frame(y)) 
        y <- as.matrix(y)
    else stopifnot(is.atomic(y))
    .Call(C_cov, x, y, na.method, FALSE)
}
<bytecode: 0x3a49a10>
<environment: namespace:stats>


function (x, na.rm = FALSE) 
sqrt(var(if (is.vector(x) || is.factor(x)) x else as.double(x), 
    na.rm = na.rm))
<bytecode: 0x3a468f0>
<environment: namespace:stats>

> mad
function (x, center = median(x), constant = 1.4826, na.rm = FALSE, 
    low = FALSE, high = FALSE) 
{
    if (na.rm) 
        x <- x[!is.na(x)]
    n <- length(x)
    constant * if ((low || high) && n%%2 == 0) {
        if (low && high) 
            stop("'low' and 'high' cannot be both TRUE")
        n2 <- n%/%2 + as.integer(high)
        sort(abs(x - center), partial = n2)[n2]
    }
    else median(abs(x - center))
}

tttt <- function(FUN){
    substitute(FUN) %>% deparse
}

tttt(ls)




> var
function (x, y = NULL, na.rm = FALSE, use) 
{
    if (missing(use)) 
        use <- if (na.rm) 
            "na.or.complete"
        else "everything"
    na.method <- pmatch(use, c("all.obs", "complete.obs", "pairwise.complete.obs", 
        "everything", "na.or.complete"))
    if (is.na(na.method)) 
        stop("invalid 'use' argument")
    if (is.data.frame(x)) 
        x <- as.matrix(x)
    else stopifnot(is.atomic(x))
    if (is.data.frame(y)) 
        y <- as.matrix(y)
    else stopifnot(is.atomic(y))
    .Call(C_cov, x, y, na.method, FALSE)
}
<bytecode: 0x2157ca0>
<environment: namespace:stats>
> cor
function (x, y = NULL, use = "everything", method = c("pearson", 
    "kendall", "spearman")) 
{
    na.method <- pmatch(use, c("all.obs", "complete.obs", "pairwise.complete.obs", 
        "everything", "na.or.complete"))
    if (is.na(na.method)) 
        stop("invalid 'use' argument")
    method <- match.arg(method)
    if (is.data.frame(y)) 
        y <- as.matrix(y)
    if (is.data.frame(x)) 
        x <- as.matrix(x)
    if (!is.matrix(x) && is.null(y)) 
        stop("supply both 'x' and 'y' or a matrix-like 'x'")
    if (!(is.numeric(x) || is.logical(x))) 
        stop("'x' must be numeric")
    stopifnot(is.atomic(x))
    if (!is.null(y)) {
        if (!(is.numeric(y) || is.logical(y))) 
            stop("'y' must be numeric")
        stopifnot(is.atomic(y))
    }
    Rank <- function(u) {
        if (length(u) == 0L) 
            u
        else if (is.matrix(u)) {
            if (nrow(u) > 1L) 
                apply(u, 2L, rank, na.last = "keep")
            else row(u)
        }
        else rank(u, na.last = "keep")
    }
    if (method == "pearson") 
        .Call(C_cor, x, y, na.method, FALSE)
    else if (na.method %in% c(2L, 5L)) {
        if (is.null(y)) {
            .Call(C_cor, Rank(na.omit(x)), NULL, na.method, method == 
                "kendall")
        }
        else {
            nas <- attr(na.omit(cbind(x, y)), "na.action")
            dropNA <- function(x, nas) {
                if (length(nas)) {
                  if (is.matrix(x)) 
                    x[-nas, , drop = FALSE]
                  else x[-nas]
                }
                else x
            }
            .Call(C_cor, Rank(dropNA(x, nas)), Rank(dropNA(y, 
                nas)), na.method, method == "kendall")
        }
    }
    else if (na.method != 3L) {
        x <- Rank(x)
        if (!is.null(y)) 
            y <- Rank(y)
        .Call(C_cor, x, y, na.method, method == "kendall")
    }
    else {
        if (is.null(y)) {
            ncy <- ncx <- ncol(x)
            if (ncx == 0) 
                stop("'x' is empty")
            r <- matrix(0, nrow = ncx, ncol = ncy)
            for (i in seq_len(ncx)) {
                for (j in seq_len(i)) {
                  x2 <- x[, i]
                  y2 <- x[, j]
                  ok <- complete.cases(x2, y2)
                  x2 <- rank(x2[ok])
                  y2 <- rank(y2[ok])
                  r[i, j] <- if (any(ok)) 
                    .Call(C_cor, x2, y2, 1L, method == "kendall")
                  else NA
                }
            }
            r <- r + t(r) - diag(diag(r))
            rownames(r) <- colnames(x)
            colnames(r) <- colnames(x)
            r
        }
        else {
            if (length(x) == 0L || length(y) == 0L) 
                stop("both 'x' and 'y' must be non-empty")
            matrix_result <- is.matrix(x) || is.matrix(y)
            if (!is.matrix(x)) 
                x <- matrix(x, ncol = 1L)
            if (!is.matrix(y)) 
                y <- matrix(y, ncol = 1L)
            ncx <- ncol(x)
            ncy <- ncol(y)
            r <- matrix(0, nrow = ncx, ncol = ncy)
            for (i in seq_len(ncx)) {
                for (j in seq_len(ncy)) {
                  x2 <- x[, i]
                  y2 <- y[, j]
                  ok <- complete.cases(x2, y2)
                  x2 <- rank(x2[ok])
                  y2 <- rank(y2[ok])
                  r[i, j] <- if (any(ok)) 
                    .Call(C_cor, x2, y2, 1L, method == "kendall")
                  else NA
                }
            }
            rownames(r) <- colnames(x)
            colnames(r) <- colnames(y)
            if (matrix_result) 
                r
            else drop(r)
        }
    }
}
<bytecode: 0x21506e8>
<environment: namespace:stats>



> system
function (command, intern = FALSE, ignore.stdout = FALSE, ignore.stderr = FALSE, 
    wait = TRUE, input = NULL, show.output.on.console = TRUE, 
    minimized = FALSE, invisible = TRUE) 
{
    if (!missing(show.output.on.console) || !missing(minimized) || 
        !missing(invisible)) 
        message("arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only")
    if (!is.logical(intern) || is.na(intern)) 
        stop("'intern' must be TRUE or FALSE")
    if (!is.logical(ignore.stdout) || is.na(ignore.stdout)) 
        stop("'ignore.stdout' must be TRUE or FALSE")
    if (!is.logical(ignore.stderr) || is.na(ignore.stderr)) 
        stop("'ignore.stderr' must be TRUE or FALSE")
    if (!is.logical(wait) || is.na(wait)) 
        stop("'wait' must be TRUE or FALSE")
    if (ignore.stdout) 
        command <- paste(command, ">/dev/null")
    if (ignore.stderr) 
        command <- paste(command, "2>/dev/null")
    if (!is.null(input)) {
        if (!is.character(input)) 
            stop("'input' must be a character vector or 'NULL'")
        f <- tempfile()
        on.exit(unlink(f))
        writeLines(input, f)
        command <- paste("<", shQuote(f), command)
    }
    if (!wait && !intern) 
        command <- paste(command, "&")
    .Internal(system(command, intern))
}



######################## 
# output package contents
########################
l_package<-.packages(T)
cmd_bsh<-l_package %>% laply(function(x)sprintf("Rscript -e 'help(package=%s)' >> /tmp/package.txt",x))
cmd_bsh %>% writeLines("/tmp/bsh.log")



l_package<-.packages(T)
cmd_bsh2<-l_package %>% laply(function(x)sprintf("Rscript -e 'help(package=%s)$info[[2]]' >> /tmp/package_fun.txt",x))
cmd_bsh2 %>% writeLines("/tmp/bsh2.sh")

system("sudo sh /tmp/bsh2.sh")
