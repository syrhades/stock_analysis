inspect R object
# library(XML)
library('devtools')
setwd('e:/syrhadestock')
load_all()
library(dplyr)
library(methods)
library(plyr)
library(tidyr)
library(ggplot2) 


objects(grep("htmlTable",search()))

SCB                     Average age in Sweden
htmlTable               Outputting HTML tables
interactiveTable        An interactive table that allows you to limit
                        the size of boxes
prConvertDfFactors      Convert all factors to characters to print them
                        as they expected
tblNoLast               Gets the last table number
tblNoNext               Gets the next table number
txtInt                  SI or English formatting of an integer
txtMergeLines           A merges lines while preserving the line break
                        for html/LaTeX
txtPval                 Formats the p-values
txtRound                A convenient rounding function



search()
searchpaths()
(.packages())               # maybe just "base"
.packages(all.available = TRUE)

.libPaths() 
.Ob <- 1
ls(pattern = "O")
ls(pattern= "O", all.names = TRUE)    # also shows ".[foo]"





require(stats)
showMethods("plot", classes = "track")
methods(class = "track")    # S3 class

require("Matrix")
showMethods("%*%")# many!
    methods(class = "Matrix")# nothing
showMethods(class = "Matrix")# everything
showMethods(Matrix:::isDiagonal) # a non-exported generic
showMethods(class = "htmlTable")

methods(summary)
methods(class = "aov")    # S3 class
## The same, with more details and more difficult to read:
print(methods(class = "aov"), byclass=FALSE)
methods("[[")             # uses C-internal dispatching
methods("$")
methods("$<-")            # replacement function
methods("+")              # binary operator
methods("Math")           # group generic
require(graphics)
methods("axis")           # looks like a generic, but is not

if(require(Matrix)) {
print(methods(class = "Matrix"))  # S4 class
m <- methods("dim")       # S3 and S4 methods
print(m)
print(attr(m, "info"))    # more extensive information

## --> help(showMethods) for related examples
}




frm_inspect<-function(r_obj){
	try(system("echo '>>>>\t names INFO'", intern = FALSE))
	
	print(names(r_obj))
	try(system("echo '>>>>\t attributes INFO'", intern = FALSE))
	attributes(r_obj)%>%print
	print("str output ==============================")
	print(str(r_obj))
	# print("class info==============================")
	try(system("echo '>>>>\t CLASS INFO'", intern = FALSE))
	print(class(r_obj))
	# system('echo')
	# try(system("echo 'test'", intern = TRUE))
	class_str<-class(r_obj)
	print("relative function ==============================")
	paste('.*\\.',class_str,'$',sep="")%>%apropos%>%print#%>%sapply(getAnywhere)%>%print
	print("relative function ==============================")
	# print(apropos(paste('.*\\.',class_str,'$')))
	try(system("echo '>>>>\t mode INFO'", intern = FALSE))
	print(mode(r_obj))
	try(system("echo '>>>>\t names  function INFO'", intern = FALSE))
	r_obj%>%names%>%print
	try(system("echo '>>>>\t show summary info'", intern = FALSE))
	print("show summary info ==============================")
	if (isS4(r_obj)) {
		print("S4 object ==============================")
		showMethods(class=class(r_obj))
		print("S4 object  get class=======================")
		print("you call like ")
		print("r_obj@methodnames")
		print("The same: slot(r_obj,methodnames)")
		
                getClass(class(r_obj))%>%print
                print(class(getClass(class(r_obj))))
		}
	
}

# getAnywhere("format.dist")
# getAnywhere("simpleLoess") # not exported from stats
# argsAnywhere(format.dist)
	# frm_inspect(data.frame(a=c(1,2,3)))
library(stats4)
set.seed(19)
gamdata = rgamma(100,shape=1.5,rate=5)
loglik = function(shape=1.5,rate=5)
-sum(dgamma(gamdata,shape=shape,rate=rate,log=TRUE))
mgam = mle(loglik)


frm_inspect(mgam)
perlcmd<- 'print "Hello World\n";'
system(paste("perl -e", shQuote(perlcmd, type = "sh")))
system2("ls")
system2("ls","|grep db")
# shQuote("ls|grep db", type = "sh")%>%system2
system2("ls","-l|grep db")
system("ls -l|grep db")

sprintf(paste('%-',6,'s',sep=''),'abc')
sprintf(paste('%+',6,'s',sep=''),'abc')

 strsplit("string dfds carlos rweq",' ')
[[1]]
[1] "string" "dfds"   "carlos" "rweq"  




# > system2
# test333<-function (command, args = character(), stdout = "", stderr = "", 
#     stdin = "", input = NULL, env = character(), wait = TRUE, 
#     minimized = FALSE, invisible = TRUE) 
# {
#     if (!missing(minimized) || !missing(invisible)) 
#         message("arguments 'minimized' and 'invisible' are for Windows only")
#     if (!is.logical(wait) || is.na(wait)) 
#         stop("'wait' must be TRUE or FALSE")
#     intern <- FALSE
#     command <- paste(c(env, shQuote(command), args), collapse = " ")
#     if (is.null(stdout)) 
#         stdout <- FALSE
#     if (is.null(stderr)) 
#         stderr <- FALSE
#     if (isTRUE(stderr)) {
#         if (!isTRUE(stdout)) 
#             warning("setting stdout = TRUE")
#         stdout <- TRUE
#     }
#     if (identical(stdout, FALSE)) 
#         command <- paste(command, ">/dev/null")
#     else if (isTRUE(stdout)) 
#         intern <- TRUE
#     else if (is.character(stdout)) {
#         if (length(stdout) != 1L) 
#             stop("'stdout' must be of length 1")
#         if (nzchar(stdout)) {
#             command <- if (identical(stdout, stderr)) 
#                 paste(command, ">", shQuote(stdout), "2>&1")
#             else command <- paste(command, ">", shQuote(stdout))
#         }
#     }
#     if (identical(stderr, FALSE)) 
#         command <- paste(command, "2>/dev/null")
#     else if (isTRUE(stderr)) {
#         command <- paste(command, "2>&1")
#     }
#     else if (is.character(stderr)) {
#         if (length(stderr) != 1L) 
#             stop("'stderr' must be of length 1")
#         if (nzchar(stderr) && !identical(stdout, stderr)) 
#             command <- paste(command, "2>", shQuote(stderr))
#     }
#     if (!is.null(input)) {
#         if (!is.character(input)) 
#             stop("'input' must be a character vector or 'NULL'")
#         f <- tempfile()
#         on.exit(unlink(f))
#         writeLines(input, f)
#         command <- paste(command, "<", shQuote(f))
#     }
#     else if (nzchar(stdin)) 
#         command <- paste(command, "<", stdin)
#     if (!wait && !intern) 
#         command <- paste(command, "&")
#      cat(command)
#      cat("\n")
#     .Internal(system(command, intern))
# }
# test333("ls","-l|grep db")
# <bytecode: 0x5930410>
# <environment: namespace:base>

# system2 {base}	R Documentation
# Invoke a System Command
# Description

# system2 invokes the OS command specified by command.
# Usage

# system2(command, args = character(),
#         stdout = "", stderr = "", stdin = "", input = NULL,
#         env = character(), wait = TRUE,
#         minimized = FALSE, invisible = TRUE)

# Arguments
# command 	

# the system command to be invoked, as a character string.
# args 	

# a character vector of arguments to command.
# stdout, stderr 	

# where output to ‘stdout' or ‘stderr' should be sent. Possible values are "", to the R console (the default), NULL or FALSE (discard output), TRUE (capture the output in a character vector) or a character string naming a file.
# stdin 	

# should input be diverted? "" means the default, alternatively a character string naming a file. Ignored if input is supplied.
# input 	

# if a character vector is supplied, this is copied one string per line to a temporary file, and the standard input of command is redirected to the file.
# env 	

# character vector of name=value strings to set environment variables.
# wait 	

# a logical (not NA) indicating whether the R interpreter should wait for the command to finish, or run it asynchronously. This will be ignored (and the interpreter will always wait) if stdout = TRUE.
# minimized, invisible 	

# arguments that are accepted on Windows but ignored on this platform, with a warning.
# Details

# Unlike system, command is always quoted by shQuote, so it must be a single command without arguments.

# For details of how command is found see system.

# On Windows, env is only supported for commands such as R and make which accept environment variables on their command line.

# Some Unix commands (such as some implementations of ls) change their output if they consider it to be piped or redirected: stdout = TRUE uses a pipe whereas stdout = "some_file_name" uses redirection.

# Because of the way it is implemented, on a Unix-alike stderr = TRUE implies stdout = TRUE: a warning is given if this is not what was specified.
# Value

# If stdout = TRUE or stderr = TRUE, a character vector giving the output of the command, one line per character string. (Output lines of more than 8095 bytes will be split.) If the command could not be run an R error is generated. If command runs but gives a non-zero exit status this will be reported with a warning and in the attribute "status" of the result: an attribute "errmsg" may also be available.

# In other cases, the return value is an error code (0 for success), given the invisible attribute (so needs to be printed explicitly). If the command could not be run for any reason, the value is 127. Otherwise if wait = TRUE the value is the exit status returned by the command, and if wait = FALSE it is 0 (the conventional success value).
# Note

# system2 is a more portable and flexible interface than system, introduced in R 2.12.0. It allows redirection of output without needing to invoke a shell on Windows, a portable way to set environment variables for the execution of command, and finer control over the redirection of stdout and stderr. Conversely, system (and shell on Windows) allows the invocation of arbitrary command lines.

# There is no guarantee that if stdout and stderr are both TRUE or the same file that the two streams will be interleaved in order. This depends on both the buffering used by the command and the OS.
# See Also

# system.
# [Package base version 3.2.2 Index]
