function (code, returnValues = character(), autoTypecast = TRUE, 
    returnToR = TRUE, mergeNamespaces = FALSE, override = FALSE, 
    simplify = TRUE) 
{
    if (pyConnectionCheck()) 
        return(invisible(NULL))
    if (!is.character(returnValues)) {
        stop("argument returnValue must be a character vector")
    }
    if (length(returnValues) > 0) {
        rv <- sprintf("(%s)", paste(shQuote(returnValues), collapse = ", "))
        del <- sprintf("\nfor __d00d__ in dir():\n  if (__d00d__ not in %s):\n    try:\n      del(locals()[__d00d__])\n    except: \n      pass\n\ntry:\n  del(__d00d__)\nexcept:\n  pass\n", 
            rv)
        code <- sprintf("%s\n%s", code, del)
    }
    returnToR <- if (returnToR) 
        2L
    else 0L
    if (pyOptions("winPython364")) {
        ret_val <- try(.Call("PythonInR_Run_String", code, 257L, 
            autoTypecast, mergeNamespaces, override, returnToR, 
            simplify), silent = TRUE)
        cat(pyGetSimple("__getStdout()"))
        msg <- makeErrorMsg()
        if (!is.null(msg)) 
            stop(msg)
    }
    else {
        ret_val <- .Call("PythonInR_Run_String", code, 257L, 
            autoTypecast, mergeNamespaces, override, returnToR, 
            simplify)
    }
    if (returnToR) 
        return(ret_val)
    invisible(ret_val)
}
<environment: namespace:PythonInR>


> pyExecp
function (code) 
{
    ret <- -1
    check_string(code)
    if (nchar(code) > 0) {
        if (pyConnectionCheck()) 
            return(invisible(NULL))
        if (pyOptions("winPython364")) {
            ret <- try(.Call("py_run_string_single_input", code), 
                silent = TRUE)
            cat(pyGetSimple("__getStdout()"))
            if (ret == -1) {
                msg <- makeErrorMsg()
                if (!is.null(msg)) 
                  stop(msg)
            }
        }
        else {
            ret <- .Call("py_run_string_single_input", code)
            if (ret == -1) 
                stop("An error has occured while executing Python code.", 
                  " See traceback above.")
        }
    }
    return(invisible(ret))
}
<environment: namespace:PythonInR>


> pyHelp
function (topic) 
{
    if (pyConnectionCheck()) 
        return(invisible(NULL))
    check_string(topic)
    pyExecp(sprintf("help('%s')", topic))
}

pyExecg(sprintf("help('%s')", "os"))


function (code) 
{
    ret <- -1
    check_string(code)
    if (nchar(code) > 0) {
        if (pyConnectionCheck()) 
            return(invisible(NULL))
        if (pyOptions("winPython364")) {
            ret <- try(.Call("py_run_simple_string", code), silent = TRUE)
            cat(pyGetSimple("__getStdout()"))
            if (ret == -1) {
                msg <- makeErrorMsg()
                if (!is.null(msg)) 
                  stop(msg)
            }
        }
        else {
            ret <- .Call("py_run_simple_string", code)
            if (ret == -1) 
                stop("An error has occured while executing Python code.", 
                  " See traceback above.")
        }
    }
    return(invisible(ret))
}
<environment: namespace:PythonInR>


> pyCall
function (callableObj, args = NULL, kwargs = NULL, autoTypecast = TRUE, 
    simplify = TRUE) 
{
    if (pyConnectionCheck()) 
        return(invisible(NULL))
    check_string(callableObj)
    if (pyOptions("winPython364")) {
        returnValue <- try(.Call("py_call_obj", callableObj, 
            args, kwargs, simplify, autoTypecast), silent = TRUE)
        msg <- makeErrorMsg()
        if (!is.null(msg)) 
            stop(msg)
    }
    else {
        returnValue <- .Call("py_call_obj", callableObj, args, 
            kwargs, simplify, autoTypecast)
    }
    return(pyTransformReturn(returnValue))
}
<environment: namespace:PythonInR>



PythonInR:::.Call
