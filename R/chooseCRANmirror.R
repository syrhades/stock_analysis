chooseCRANmirror
function (graphics = getOption("menu.graphics"), ind = NULL,
    useHTTPS = getOption("useHTTPS", TRUE), local.only = FALSE)
{
    m <- getCRANmirrors(all = FALSE, local.only = local.only)
    url <- .chooseMirror(m, "CRAN", graphics, ind, useHTTPS)
    if (length(url)) {
        repos <- getOption("repos")
        repos["CRAN"] <- url
        options(repos = repos)
    }
    invisible()
}
# <bytecode: 0x000000005f1c5df0>
# <environment: namespace:utils>
# >

getCRANmirrors(all = FALSE, local.only = F)

update.packages("e1071")

help(package ="e1071")
help(svm, e1071)
?e1071::svm

help.search("svm")

example(lm)

demo(graphics)
demo()

get_func_name <- function(FUN){
        topic <- substitute(FUN)
        if (!is.character(topic))
            topic <- deparse(topic)[1L]
            topic
}
main <- function(fun){
	deparse(substitute(fun))
	# get_func_name(fun) %>%print
}
main(help)

gettextf("no help found for %s", "eee")
find.package
tools::Rd2ex
file.exists
on.exit
unlink


example <-
function (topic, package = NULL, lib.loc = NULL, character.only = FALSE,
    give.lines = FALSE, local = FALSE, echo = TRUE, verbose = getOption("verbose"),
    setRNG = FALSE, ask = getOption("example.ask"), prompt.prefix = abbreviate(topic,
        6), run.dontrun = FALSE, run.donttest = interactive())
{
    if (!character.only) {
        topic <- substitute(topic)
        if (!is.character(topic))
            topic <- deparse(topic)[1L]
    }
    pkgpaths <- find.package(package, lib.loc, verbose = verbose)
    file <- index.search(topic, pkgpaths, TRUE)
    if (!length(file)) {
        warning(gettextf("no help found for %s", sQuote(topic)),
            domain = NA)
        return(invisible())
    }
    packagePath <- dirname(dirname(file))
    pkgname <- basename(packagePath)
    lib <- dirname(packagePath)
    tf <- tempfile("Rex")
    tools::Rd2ex(.getHelpFile(file), tf, commentDontrun = !run.dontrun,
        commentDonttest = !run.donttest)
    if (!file.exists(tf)) {
        if (give.lines)
            return(character())
        warning(gettextf("%s has a help file but no examples",
            sQuote(topic)), domain = NA)
        return(invisible())
    }
    on.exit(unlink(tf))
    if (give.lines)
        return(readLines(tf))
    if (pkgname != "base")
        library(pkgname, lib.loc = lib, character.only = TRUE)
    if (!is.logical(setRNG) || setRNG) {
        if ((exists(".Random.seed", envir = .GlobalEnv))) {
            oldSeed <- get(".Random.seed", envir = .GlobalEnv)
            on.exit(assign(".Random.seed", oldSeed, envir = .GlobalEnv),
                add = TRUE)
        }
        else {
            oldRNG <- RNGkind()
            on.exit(RNGkind(oldRNG[1L], oldRNG[2L]), add = TRUE)
        }
        if (is.logical(setRNG)) {
            RNGkind("default", "default")
            set.seed(1)
        }
        else eval(setRNG)
    }
    zz <- readLines(tf, n = 1L)
    skips <- 0L
    if (echo) {
        zcon <- file(tf, open = "rt")
        while (length(zz) && !length(grep("^### \\*\\*", zz))) {
            skips <- skips + 1L
            zz <- readLines(zcon, n = 1L)
        }
        close(zcon)
    }
    if (ask == "default")
        ask <- echo && grDevices::dev.interactive(orNone = TRUE)
    if (ask) {
        if (.Device != "null device") {
            oldask <- grDevices::devAskNewPage(ask = TRUE)
            if (!oldask)
                on.exit(grDevices::devAskNewPage(oldask), add = TRUE)
        }
        op <- options(device.ask.default = TRUE)
        on.exit(options(op), add = TRUE)
    }
    source(tf, local, echo = echo, prompt.echo = paste0(prompt.prefix,
        getOption("prompt")), continue.echo = paste0(prompt.prefix,
        getOption("continue")), verbose = verbose, max.deparse.length = Inf,
        encoding = "UTF-8", skip.echo = skips, keep.source = TRUE)