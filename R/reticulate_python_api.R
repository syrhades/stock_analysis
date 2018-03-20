R 	Python 	Examples
Single-element vector 	Scalar 	1, 1L, TRUE, "foo"
Multi-element vector 	List 	c(1.0, 2.0, 3.0), c(1L, 2L, 3L)
List of multiple types 	Tuple 	list(1L, TRUE, "foo")
Named list 	Dict 	list(a = 1L, b = 2.0), dict(x = x_data)
Matrix/Array 	NumPy ndarray 	matrix(c(1,2,3,4), nrow = 2, ncol = 2)
Function 	Python function 	function(x) x + 1
NULL, TRUE, FALSE 	None, True, False 	NULL, TRUE, FALSE

library(reticulate)
os <- import("os")
os$chdir("tests")
os$getcwd()
difflib <- import("difflib")
difflib$ndiff(foo, bar)

filecmp <- import("filecmp")
filecmp$cmp(dir1, dir2)

main <- import_main()
py <- import_builtins()
py$print('foo')

# import numpy and specify no automatic Python to R conversion
np <- import("numpy", convert = FALSE)

# do some array manipulations with NumPy
a <- np$array(c(1:4))
sum <- a$cumsum()

# convert to R explicitly at the end
py_to_r(sum)


Executing Code

You can execute Python code within the main module using the py_run_file and py_run_string functions. These functions both return a reference to the main Python module so you can access the results of their execution. For example:

py_run_file("script.py")

main <- py_run_string("x = 10")
main$x

os <- import("os")
py_help(os$chdir)

py_help_v2 <-function (object)
{
    help <- py_capture_output(import_builtins()$help(object),
        type = "stdout")
    # tmp <- tempfile("py_help", fileext = ".txt")
    output <- help %>%stringr::str_split("\n") %>%unlist
    output_show <- output %>%laply(function(x) nchar(x) > 0)
    output[output_show]

    # writeLines(help, con = tmp)
    # file.show(tmp, title = paste("Python Help:", object$`__name__`),
    #     delete.file = TRUE)
}
debugonce(py_help_v2)
py_help_v2(os$chdir)




Lists, Tuples, and Dictionaries

The automatic conversion of R types to Python types works well in most cases, but occasionally you will need to be more explicit on the R side to provide Python the type it expects.

For example, if a Python API requires a list and you pass a single element R vector it will be converted to a Python scalar. To overcome this simply use the R list function explicitly:

foo$bar(indexes = list(42L))

Similarly, a Python API might require a tuple rather than a list. In that case you can use the tuple() function:

tuple("a", "b", "c")

R named lists are converted to Python dictionaries however you can also explicitly create a Python dictionary using the dict() function:

dict(foo = "bar", index = 42L)

This might be useful if you need to pass a dictionary that uses a more complex object (as opposed to a string) as it’s key.


py <- import_builtins()
with(py$open("output.txt", "w") %as% file, {
  file$write("Hello, there!")
})
If a Python API returns an iterator or generator you can interact with it using the iterate() function. The iterate() function can be used to apply an R function to each item yielded by the iterator:

iterate(iter, print)

If you don’t pass a function to iterate the results will be collected into an R vector:

results <- iterate(iter)

Note that the Iterators will be drained of their values by iterate():

a <- iterate(iter) # results are not empty
b <- iterate(iter) # results are empty since items have already been drained


Element Level Iteration

You can also iterate on an element-by-element basis using the iter_next() function. For example:

while (TRUE) {
  item <- iter_next(iter)
  if (is.na(item))
    break
}

By default iter_next() will return NA when the iteration is complete but you can provide a custom value and it will be returned instead. For example:

while (TRUE) {
  item <- iter_next(iter, completed = NULL)
  if (is.null(item))
    break
}

Note that some iterators/genrators in Python are infinite. In that case the caller will need custom logic to determine when to terminate the loop.
Function 	Description
py_has_attr() 	Check if an object has a specified attribute.
py_get_attr() 	Get an attribute of a Python object.
py_set_attr() 	Set an attribute of a Python object.
py_list_attributes() 	List all attributes of a Python object.
py_call() 	Call a Python callable object with the specified arguments.
py_to_r() 	Convert a Python object to it’s R equivalent
r_to_py() 	Convert an R object to it’s Python equivalent


py_config()

py_available() 	Check whether a Python interface is available on this system.
py_numpy_available() 	Check whether the R interface to NumPy is available (requires NumPy >= 1.6)
py_module_available() 	Check whether a Python module is available on this system.
py_config() 	Get information on the location and version of Python in use.

Output Control

These functions enable you to capture or suppress output from Python:
Function 	Description
py_capture_output() 	Capture Python output for the specified expression and return it as an R character vector.
py_suppress_warnings() 	Execute the specified expression, suppressing the display Python warnings.

Function 	Description
use_python() 	Specify the path a specific Python binary.
use_virtualenv() 	Specify the directory containing a Python virtualenv.
use_condaenv() 	Specify the name of a Conda environment.

For example:

library(reticulate)
use_python("/usr/local/bin/python")
use_virtualenv("~/myenv")
use_condaenv("myenv")

The use_condaenv function will use whatever conda binary is found on the system PATH. If you want to use a specific alternate version you can use the conda paramter. For example:

use_condaenv(condaenv = "r-nlp", conda = "/opt/anaconda3/bin/conda")

use_virtualenv("~/myenv", required = TRUE)


Configuration Info

You can use the py_config() function to query for information about the specific version of Python in use as well as a list of other Python versions discovered on the system:

py_config()

You can also use the py_discover_config() function to see what version of Python will be used without actually loading Python:

py_discover_config()


 py_function_docs("os$close")
 py_function_wrapper("os$close")

 >  py_function_wrapper("os$close")
#' close(fd)
#'
#' Close a file descriptor (for low level IO).
#'
#'
#' @export
close <- function() {
  os$close(
)
>  py_function_docs("os$close")
$name
[1] "close"

$qualified_name
[1] "os$close"

$description
[1] "close(fd)"

$details
[1] "Close a file descriptor (for low level IO)."

$signature
[1] "close()"

$parameters
NULL

$sections
list()

$returns
NULL

py_list_attributes(x)
> os$path %>%py_list_attributes
 [1] "__all__"                    "__builtins__"
 [3] "__doc__"                    "__file__"
 [5] "__name__"                   "__package__"
 [7] "_abspath_split"             "_getfullpathname"
 [9] "_unicode"                   "abspath"
[11] "altsep"                     "basename"
[13] "commonprefix"               "curdir"
[15] "defpath"                    "devnull"
[17] "dirname"                    "exists"
[19] "expanduser"                 "expandvars"
[21] "extsep"                     "genericpath"
[23] "getatime"                   "getctime"
[25] "getmtime"                   "getsize"
[27] "isabs"                      "isdir"
[29] "isfile"                     "islink"
[31] "ismount"                    "join"
[33] "lexists"                    "normcase"
[35] "normpath"                   "os"
[37] "pardir"                     "pathsep"
[39] "realpath"                   "relpath"
[41] "sep"                        "split"
[43] "splitdrive"                 "splitext"
[45] "splitunc"                   "stat"
[47] "supports_unicode_filenames" "sys"
[49] "walk"                       "warnings"

os$path %>%py_get_attr("__doc__")
> py_list_attributes
function (x)
{
    ensure_python_initialized()
    py_list_attributes_impl(x)
}

> getFromNamespace("py_list_attributes_impl", "reticulate")
function (x)
{
    .Call(reticulate_py_list_attributes_impl, x)
}
<environment: namespace:reticulate>




getFromNamespace("py_list_attributes_impl", "reticulate")

py_to_r(x)

r_to_py(x, convert = FALSE)



py_run_file("script.py")

main <- py_run_string("x = 10")
main$x

main <- py_run_string("x = range(10)")
main$x
1] 0 1 2 3 4 5 6 7 8 9

> tuple("a", "b", "c") %>%class
[1] "python.builtin.tuple"  "python.builtin.object"

> dict(foo = "bar", index = 42L)
{'index': 42, 'foo': 'bar'}
> dict(foo = "bar", index = 42L) %>%class
[1] "python.builtin.dict"   "python.builtin.object"
>

> dict(foo = "bar", index = 42L)%>% py_str
[1] "{'index': 42, 'foo': 'bar'}"
> dict(foo = "bar", index = 42L)%>% py_str %>%class
[1] "character"
>
> dict(foo = "bar", index = 42L)%>% py_to_r
$index
[1] 42

mtcars %>% r_to_py

$foo
[1] "bar"
> dict(foo = "bar", index = 42L)%>% py_to_r %>%r_to_py
{'index': 42, 'foo': 'bar'}
> dict(foo = "bar", index = 42L)%>% py_to_r %>%r_to_py %>%class
[1] "python.builtin.dict"   "python.builtin.object"
> dict(foo = "bar", index = 42L)%>% py_to_r %>%class
[1] "list"
> dict(foo = "bar", index = 42L)%>% py_to_r

main$fun <- py_run_string("def filename_from_url(url):
    fname = os.path.basename(urlparse.urlparse(url).path)
    return fname
    ")
main$x

fixInNamespace("predict.ppr", "stats")
stats:::predict.ppr
getS3method("predict", "ppr")
## alternatively
fixInNamespace("predict.ppr", pos = 3)
fixInNamespace("predict.ppr", pos = "package:stats")


fixInNamespace_v2 <-
function (x, ns, pos = -1, envir = as.environment(pos), ...)
{
    subx <- substitute(x)
    if (is.name(subx))
        subx <- deparse(subx)
    if (!is.character(subx) || length(subx) != 1L)
        stop("'fixInNamespace' requires a name")
    if (missing(ns)) {
        nm <- attr(envir, "name", exact = TRUE)
        if (is.null(nm) || substr(nm, 1L, 8L) != "package:")
            stop("environment specified is not a package")
        ns <- asNamespace(substring(nm, 9L))
    }
    else ns <- asNamespace(ns)
    get(subx, envir = ns, inherits = FALSE)
    # assignInNamespace(subx, x, ns)
}
fixInNamespace_v2("predict.ppr", pos = "package:stats")