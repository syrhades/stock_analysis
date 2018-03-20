data_miner

aggregate(Sepal.Length~Species,summary,data=iris)

iris %>%ddply (.(Species),summarize,summary(Sepal.Length))

require(scatterplot3d)
scatterplot3d(iris$Petal.Width,iris$Sepal.Length,iris$Sepal.Width)
require(rgl)
plot3d(iris$Petal.Width,iris$Sepal.Length,iris$Sepal.Width)


heatmap 

disMatrix <- as.matrix(dist(iris[,1:4]))
heatmap(disMatrix)



fxx<- as_mapper(list(1, "a", 2))
fxx<- as_mapper(list(1))
# fxx(list(mtcars))
list(mtcars$mpg) %>%fxx

> fxx<- as_mapper(list(1))
> # fxx(list(mtcars))
> list(mtcars$mpg) %>%fxx
 [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
[16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
[31] 15.0 21.4
> fxx
function (x, ...)
pluck(x, list(1), .default = NULL)
<environment: 0x00000000172d88d8>


> as_vector
function (.x, .type = NULL)
{
    if (can_simplify(.x, .type)) {
        unlist(.x)
    }
    else {
        stop("Cannot coerce .x to a vector", call. = FALSE)
    }
}
<environment: namespace:purrr>

# We create an array with 3 dimensions
x <- array(1:12, c(2, 2, 3))

# A full margin for such an array would be the vector 1:3. This is
# the default if you don't specify a margin

# Creating a branch along the full margin is equivalent to
# as.list(array) and produces a list of size length(x):
array_branch(x) %>% str()

# A branch along the first dimension yields a list of length 2
# with each element containing a 2x3 array:
array_branch(x, 1) %>% str()

# A branch along the first and third dimensions yields a list of
# length 2x3 whose elements contain a vector of length 2:
array_branch(x, c(1, 3)) %>% str()

# Creating a tree from the full margin creates a list of lists of
# lists:
array_tree(x) %>% str()

# The ordering and the depth of the tree are controlled by the
# margin argument:
array_tree(x, c(3, 1)) %>% str()


modify {purrr}  R Documentation
Modify elements selectively
Description

modify() is a short-cut for x[] <- map(x, .f); return(x). modify_if() only modifies the elements of x that satisfy a predicate and leaves the others unchanged. modify_at() only modifies elements given by names or positions. modify_depth() only modifies elements at a given level of a nested data structure.
Usage

modify(.x, .f, ...)

## Default S3 method:
modify(.x, .f, ...)

modify_if(.x, .p, .f, ...)

## Default S3 method:
modify_if(.x, .p, .f, ...)

modify_at(.x, .at, .f, ...)

## Default S3 method:
modify_at(.x, .at, .f, ...)

modify_depth(.x, .depth, .f, ..., .ragged = .depth < 0)

## Default S3 method:
modify_depth(.x, .depth, .f, ..., .ragged = .depth < 0)

Arguments
.x  

A list or atomic vector.
.f  

A function, formula, or atomic vector.

If a function, it is used as is.

If a formula, e.g. ~ .x + 2, it is converted to a function. There are three ways to refer to the arguments:

    For a single argument function, use .

    For a two argument function, use .x and .y

    For more arguments, use ..1, ..2, ..3 etc

This syntax allows you to create very compact anonymous functions.

If character vector, numeric vector, or list, it is converted to an extractor function. Character vectors index by name and numeric vectors index by position; use a list to index by position and name at different levels. Within a list, wrap strings in get_attr() to extract named attributes. If a component is not present, the value of .default will be returned.
...   

Additional arguments passed on to .f.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
.at   

A character vector of names or a numeric vector of positions. Only those elements corresponding to .at will be modified.
.depth  

Level of .x to map on. Use a negative value to count up from the lowest level of the list.

    modify_depth(x, 0, fun) is equivalent to x[] <- fun(x)

    modify_depth(x, 1, fun) is equivalent to x[] <- map(x, fun)

    modify_depth(x, 2, fun) is equivalent to x[] <- map(x, ~ map(., fun))

.ragged   

If TRUE, will apply to leaves, even if they're not at depth .depth. If FALSE, will throw an error if there are no elements at depth .depth.
Details

Since the transformation can alter the structure of the input; it's your responsibility to ensure that the transformation produces a valid output. For example, if you're modifying a data frame, .f must preserve the length of the input.
Value

An object the same class as .x
Genericity

All these functions are S3 generic. However, the default method is sufficient in many cases. It should be suitable for any data type that implements the subset-assignment method [<-.

In some cases it may make sense to provide a custom implementation with a method suited to your S3 class. For example, a grouped_df method might take into account the grouped nature of a data frame.
See Also

Other map variants: imap, invoke, lmap, map2, map
Examples

# Convert factors to characters
iris %>%
  modify_if(is.factor, as.character) %>%
  str()

# Specify which columns to map with a numeric vector of positions:
mtcars %>% modify_at(c(1, 4, 5), as.character) %>% str()

# Or with a vector of names:
mtcars %>% modify_at(c("cyl", "am"), as.character) %>% str()

list(x = rbernoulli(100), y = 1:100) %>%
  transpose() %>%
  modify_if("x", ~ update_list(., y = ~ y * 100)) %>%
  transpose() %>%
  simplify_all()

# Modify at specified depth ---------------------------
l1 <- list(
  obj1 = list(
    prop1 = list(param1 = 1:2, param2 = 3:4),
    prop2 = list(param1 = 5:6, param2 = 7:8)
  ),
  obj2 = list(
    prop1 = list(param1 = 9:10, param2 = 11:12),
    prop2 = list(param1 = 12:14, param2 = 15:17)
  )
)

# In the above list, "obj" is level 1, "prop" is level 2 and "param"
# is level 3. To apply sum() on all params, we map it at depth 3:
l1 %>% modify_depth(3, sum) %>% str()

# modify() lets us pluck the elements prop1/param2 in obj1 and obj2:
l1 %>% modify(c("prop1", "param2")) %>% str()

# But what if we want to pluck all param2 elements? Then we need to
# act at a lower level:
l1 %>% modify_depth(2, "param2") %>% str()

# modify_depth() can be with other purrr functions to make them operate at
# a lower level. Here we ask pmap() to map paste() simultaneously over all
# elements of the objects at the second level. paste() is effectively
# mapped at level 3.
l1 %>% modify_depth(2, ~ pmap(., paste, sep = " / ")) %>% str()

[Package purrr version 0.2.3 Index]

keep {purrr}  R Documentation
Keep or discard elements using a predicate function.
Description

keep and discard are opposites. compact is a handy wrapper that removes all elements that are NULL.
Usage

keep(.x, .p, ...)

discard(.x, .p, ...)

compact(.x, .p = identity)

Arguments
.x  

A list or vector.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
...   

Additional arguments passed on to .p.
Details

These are usually called select or filter and reject or drop, but those names are already taken. keep is similar to Filter() but the argument order is more convenient, and the evaluation of .f is stricter.
Examples

rep(10, 10) %>%
  map(sample, 5) %>%
  keep(function(x) mean(x) > 6)

# Or use a formula
rep(10, 10) %>%
  map(sample, 5) %>%
  keep(~ mean(.x) > 6)

# Using a string instead of a function will select all list elements
# where that subelement is TRUE
x <- rerun(5, a = rbernoulli(1), b = sample(10))
x
x %>% keep("a")
x %>% discard("a")

[Package purrr version 0.2.3 Index]
> keep
function (.x, .p, ...)
{
    sel <- probe(.x, .p, ...)
    .x[!is.na(sel) & sel]
}
as_vector {purrr} R Documentation
Coerce a list to a vector
Description

as_vector() collapses a list of vectors into one vector. It checks that the type of each vector is consistent with .type. If the list can not be simplified, it throws an error. simplify will simplify a vector if possible; simplify_all will apply simplify to every element of a list.
Usage

as_vector(.x, .type = NULL)

simplify(.x, .type = NULL)

simplify_all(.x, .type = NULL)

Arguments
.x  

A list of vectors
.type   

A vector mold or a string describing the type of the input vectors. The latter can be any of the types returned by typeof(), or "numeric" as a shorthand for either "double" or "integer".
Details

.type can be a vector mold specifying both the type and the length of the vectors to be concatenated, such as numeric(1) or integer(4). Alternatively, it can be a string describing the type, one of: "logical", "integer", "double", "complex", "character" or "raw".
Examples

# Supply the type either with a string:
as.list(letters) %>% as_vector("character")

# Or with a vector mold:
as.list(letters) %>% as_vector(character(1))

# Vector molds are more flexible because they also specify the
# length of the concatenated vectors:
list(1:2, 3:4, 5:6) %>% as_vector(integer(2))

# Note that unlike vapply(), as_vector() never adds dimension
# attributes. So when you specify a vector mold of size > 1, you
# always get a vector and not a matrix



compose {purrr} R Documentation
Compose multiple functions
Description

Compose multiple functions
Usage

compose(...)

Arguments
...   

n functions to apply in order from right to left.
Value

A function
Examples

not_null <- compose(`!`, is.null)
not_null(4)
not_null(NULL)

cross {purrr} R Documentation
Produce all combinations of list elements
Description

cross2() returns the product set of the elements of .x and .y. cross3() takes an additional .z argument. cross() takes a list .l and returns the cartesian product of all its elements in a list, with one combination by element. cross_df() is like cross() but returns a data frame, with one combination by row.
Usage

cross(.l, .filter = NULL)

cross2(.x, .y, .filter = NULL)

cross3(.x, .y, .z, .filter = NULL)

cross_df(.l, .filter = NULL)

Arguments
.l  

A list of lists or atomic vectors. Alternatively, a data frame. cross_df() requires all elements to be named.
.filter   

A predicate function that takes the same number of arguments as the number of variables to be combined.
.x, .y, .z  

Lists or atomic vectors.
Details

cross(), cross2() and cross3() return the cartesian product is returned in wide format. This makes it more amenable to mapping operations. cross_df() returns the output in long format just as expand.grid() does. This is adapted to rowwise operations.

When the number of combinations is large and the individual elements are heavy memory-wise, it is often useful to filter unwanted combinations on the fly with .filter. It must be a predicate function that takes the same number of arguments as the number of crossed objects (2 for cross2(), 3 for cross3(), length(.l) for cross()) and returns TRUE or FALSE. The combinations where the predicate function returns TRUE will be removed from the result.
Value

cross2(), cross3() and cross() always return a list. cross_df() always returns a data frame. cross() returns a list where each element is one combination so that the list can be directly mapped over. cross_df() returns a data frame where each row is one combination.
See Also

expand.grid()
Examples

# We build all combinations of names, greetings and separators from our
# list of data and pass each one to paste()
data <- list(
  id = c("John", "Jane"),
  greeting = c("Hello.", "Bonjour."),
  sep = c("! ", "... ")
)

data %>%
  cross() %>%
  map(lift(paste))

# cross() returns the combinations in long format: many elements,
# each representing one combination. With cross_df() we'll get a
# data frame in long format: crossing three objects produces a data
# frame of three columns with each row being a particular
# combination. This is the same format that expand.grid() returns.
args <- data %>% cross_df()

# In case you need a list in long format (and not a data frame)
# just run as.list() after cross_df()
args %>% as.list()

# This format is often less pratical for functional programming
# because applying a function to the combinations requires a loop
out <- vector("list", length = nrow(args))
for (i in seq_along(out))
  out[[i]] <- map(args, i) %>% invoke(paste, .)
out

# It's easier to transpose and then use invoke_map()
args %>% transpose() %>% map_chr(~ invoke(paste, .))

# Unwanted combinations can be filtered out with a predicate function
filter <- function(x, y) x >= y
cross2(1:5, 1:5, .filter = filter) %>% str()

# To give names to the components of the combinations, we map
# setNames() on the product:
seq_len(3) %>%
  cross2(., ., .filter = `==`) %>%
  map(setNames, c("x", "y"))

# Alternatively we can encapsulate the arguments in a named list
# before crossing to get named components:
seq_len(3) %>%
  list(x = ., y = .) %>%
  cross(.filter = `==`)


  > lift
function (..f, ..., .unnamed = FALSE)
{
    force(..f)
    defaults <- list(...)
    function(.x = list(), ...) {
        if (.unnamed) {
            .x <- unname(.x)
        }
        do.call("..f", c(.x, defaults, list(...)))
    }
}
<environment: namespace:purrr>
> force
function (x)
x
<bytecode: 0x000000000aa65ce0>
<environment: namespace:base>
> lift(paste)
function (.x = list(), ...)
{
    if (.unnamed) {
        .x <- unname(.x)
    }
    do.call("..f", c(.x, defaults, list(...)))
}
<environment: 0x000000001af720e8>

args <- data %>% cross_df()

# In case you need a list in long format (and not a data frame)
# just run as.list() after cross_df()
args %>% as.list()

add1 <- function(x) x + 1
compose(add1, add1)(8)

[Package purrr version 0.2.3 Index]
> compose
function (...)
{
    fs <- lapply(list(...), match.fun)
    n <- length(fs)
    last <- fs[[n]]
    rest <- fs[-n]
    function(...) {
        out <- last(...)
        for (f in rev(rest)) {
            out <- f(out)
        }
        out
    }
}
<environment: namespace:purrr>

seq_len(3) %>%
  list(x = ., y = .) %>%
  cross(.filter = `==`)

seq_len(3) %>%
  list(x = ., y = .) %>%
  cross_df(.filter = `==`)

seq_len(3) %>%
  list(x = ., y = .) %>%
  cross_df()


> detect
function (.x, .f, ..., .right = FALSE, .p)
{
    if (!missing(.p)) {
        warn("`.p` has been renamed to `.f`", "purrr_2.2.3")
        .f <- .p
    }
    .f <- as_mapper(.f, ...)
    for (i in index(.x, .right)) {
        if (is_true(.f(.x[[i]], ...)))
            return(.x[[i]])
    }
    NULL
}
<environment: namespace:purrr>

> invoke
function (.f, .x = NULL, ..., .env = NULL)
{
    .env <- .env %||% parent.frame()
    args <- c(as.list(.x), list(...))
    do.call(.f, args, envir = .env)
}
<environment: namespace:purrr>
>

# Since `.f` is passed to as_mapper(), you can supply a
# lambda-formula or a pluck object:
x <- list(
  list(1, foo = FALSE),
  list(2, foo = TRUE),
  list(3, foo = TRUE)
)

detect(x, "foo")
detect_index(x, "foo")



every {purrr} R Documentation
Do every or some elements of a list satisfy a predicate?
Description

Do every or some elements of a list satisfy a predicate?
Usage

every(.x, .p, ...)

some(.x, .p, ...)

Arguments
.x  

A list or atomic vector.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
...   

Additional arguments passed on to .f.
Value

A logical vector of length 1.
Examples

x <- list(0, 1, TRUE)
x %>% every(identity)
x %>% some(identity)



flatten {purrr} R Documentation
Flatten a list of lists into a simple vector.
Description

These functions remove a level hierarchy from a list. They are similar to unlist(), only ever remove a single layer of hierarchy, and are type-stable so you always know what the type of the output is.
Usage

flatten(.x)

flatten_lgl(.x)

flatten_int(.x)

flatten_dbl(.x)

flatten_chr(.x)

flatten_dfr(.x, .id = NULL)

flatten_dfc(.x)

Arguments
.x  

A list of flatten. The contents of the list can be anything for flatten (as a list is returned), but the contents must match the type for the other functions.
.id   

If not NULL a variable with this name will be created giving either the name or the index of the data frame.
Value

flatten() returns a list, flatten_lgl() a logical vector, flatten_int() an integer vector, flatten_dbl() a double vector, and flatten_chr() a character vector.

flatten_dfr() and flatten_dfc() return data frames created by row-binding and column-binding respectively. They require dplyr to be installed.
Examples

x <- rerun(2, sample(4))
x
x %>% flatten()
x %>% flatten_int()

# You can use flatten in conjunction with map
x %>% map(1L) %>% flatten_int()
# But it's more efficient to use the typed map instead.
x %>% map_int(1L)

[Package purrr version 0.2.3 Index]

y <- list(0:10, 5.5)
y %>% every(is.numeric)
y %>% every(is.integer)


get-attr {purrr}  R Documentation
Infix attribute accessor
Description

Infix attribute accessor
Usage

x %@% name

Arguments
x   

Object
name  

Attribute name
Examples

factor(1:3) %@% "levels"
mtcars %@% "class"
> `%@%`
function (x, name)
attr(x, name, exact = TRUE)
<environment: namespace:purrr>


has_element
has_element {purrr} R Documentation
Does a list contain an object?
Description

Does a list contain an object?
Usage

has_element(.x, .y)

Arguments
.x  

A list or atomic vector.
.y  

Object to test for
Examples

x <- list(1:10, 5, 9.9)
x %>% has_element(1:10)
x %>% has_element(3)
head_while {purrr}  R Documentation
Find head/tail that all satisfies a predicate.
Description

Find head/tail that all satisfies a predicate.
Usage

head_while(.x, .p, ...)

tail_while(.x, .p, ...)

Arguments
.x  

A list or atomic vector.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
...   

Additional arguments passed on to .f.
Value

A vector the same type as .x.
Examples

pos <- function(x) x >= 0
head_while(5:-5, pos)
tail_while(5:-5, negate(pos))

big <- function(x) x > 100
head_while(0:10, big)
tail_while(0:10, big)


> head_while
function (.x, .p, ...)
{
    loc <- detect_index(.x, negate(.p), ...)
    if (loc == 0)
        return(.x)
    .x[seq_len(loc - 1)]
}


imap {purrr}  R Documentation
Apply a function to each element of a vector, and its index
Description

imap_xxx(x, ...), an indexed map, is short hand for map2(x, names(x), ...) if x has names, or map2(x, seq_along(x), ...) if it does not. This is useful if you need to compute on both the value and the position of an element.
Usage

imap(.x, .f, ...)

imap_lgl(.x, .f, ...)

imap_chr(.x, .f, ...)

imap_int(.x, .f, ...)

imap_dbl(.x, .f, ...)

imap_dfr(.x, .f, ..., .id = NULL)

imap_dfc(.x, .f, ..., .id = NULL)

iwalk(.x, .f, ...)

Arguments
.x  

A list or atomic vector.
.f  

A function, formula, or atomic vector.

If a function, it is used as is.

If a formula, e.g. ~ .x + 2, it is converted to a function. There are three ways to refer to the arguments:

    For a single argument function, use .

    For a two argument function, use .x and .y

    For more arguments, use ..1, ..2, ..3 etc

This syntax allows you to create very compact anonymous functions.

If character vector, numeric vector, or list, it is converted to an extractor function. Character vectors index by name and numeric vectors index by position; use a list to index by position and name at different levels. Within a list, wrap strings in get_attr() to extract named attributes. If a component is not present, the value of .default will be returned.
...   

Additional arguments passed on to .f.
.id   

If not NULL a variable with this name will be created giving either the name or the index of the data frame.
Value

A vector the same length as .x.
See Also

Other map variants: invoke, lmap, map2, map, modify
Examples

# Note that when using the formula shortcut, the first argument
# is the value, and the second is the position
imap_chr(sample(10), ~ paste0(.y, ": ", .x))
iwalk(mtcars, ~ cat(.y, ": ", median(.x), "\n", sep = ""))


invoke {purrr}  R Documentation
Invoke functions.
Description

This pair of functions make it easier to combine a function and list of parameters to get a result. invoke is a wrapper around do.call that makes it easy to use in a pipe. invoke_map makes it easier to call lists of functions with lists of parameters.
Usage

invoke(.f, .x = NULL, ..., .env = NULL)

invoke_map(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_lgl(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_int(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_dbl(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_chr(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_dfr(.f, .x = list(NULL), ..., .env = NULL)

invoke_map_dfc(.f, .x = list(NULL), ..., .env = NULL)

Arguments
.f  

For invoke, a function; for invoke_map a list of functions.
.x  

For invoke, an argument-list; for invoke_map a list of argument-lists the same length as .f (or length 1). The default argument, list(NULL), will be recycled to the same length as .f, and will call each function with no arguments (apart from any supplied in ....
...   

Additional arguments passed to each function.
.env  

Environment in which do.call() should evaluate a constructed expression. This only matters if you pass as .f the name of a function rather than its value, or as .x symbols of objects rather than their values.
See Also

Other map variants: imap, lmap, map2, map, modify
Examples

# Invoke a function with a list of arguments
invoke(runif, list(n = 10))
# Invoke a function with named arguments
invoke(runif, n = 10)

# Combine the two:
invoke(paste, list("01a", "01b"), sep = "-")
# That's more natural as part of a pipeline:
list("01a", "01b") %>%
  invoke(paste, ., sep = "-")

# Invoke a list of functions, each with different arguments
invoke_map(list(runif, rnorm), list(list(n = 10), list(n = 5)))
# Or with the same inputs:
invoke_map(list(runif, rnorm), list(list(n = 5)))
invoke_map(list(runif, rnorm), n = 5)
# Or the same function with different inputs:
invoke_map("runif", list(list(n = 5), list(n = 10)))

# Or as a pipeline
list(m1 = mean, m2 = median) %>% invoke_map(x = rcauchy(100))
list(m1 = mean, m2 = median) %>% invoke_map_dbl(x = rcauchy(100))

# Note that you can also match by position by explicitly omitting `.x`.
# This can be useful when the argument names of the functions are not
# identical
list(m1 = mean, m2 = median) %>%
  invoke_map(, rcauchy(100))

# If you have pairs of function name and arguments, it's natural
# to store them in a data frame. Here we use a tibble because
# it has better support for list-columns
df <- tibble::tibble(
  f = c("runif", "rpois", "rnorm"),
  params = list(
    list(n = 10),
    list(n = 5, lambda = 10),
    list(n = 10, mean = -3, sd = 10)
  )
)
df
invoke_map(df$f, df$params)
invoke(paste, list("01a", "01b"), sep = "-")

invoke(paste, letters, sep = "-")
> invoke
function (.f, .x = NULL, ..., .env = NULL)
{
    .env <- .env %||% parent.frame()
    args <- c(as.list(.x), list(...))
    do.call(.f, args, envir = .env)
}
<environment: namespace:purrr>
invoke_map(list(runif, rnorm), list(list(n = 10), list(n = 5)))


lift {purrr}  R Documentation
Lift the domain of a function
Description

lift_xy() is a composition helper. It helps you compose functions by lifting their domain from a kind of input to another kind. The domain can be changed from and to a list (l), a vector (v) and dots (d). For example, lift_ld(fun) transforms a function taking a list to a function taking dots.
Usage

lift(..f, ..., .unnamed = FALSE)

lift_dl(..f, ..., .unnamed = FALSE)

lift_dv(..f, ..., .unnamed = FALSE)

lift_vl(..f, ..., .type)

lift_vd(..f, ..., .type)

lift_ld(..f, ...)

lift_lv(..f, ...)

Arguments
..f   

A function to lift.
...   

Default arguments for ..f. These will be evaluated only once, when the lifting factory is called.
.unnamed  

If TRUE, ld or lv will not name the parameters in the lifted function signature. This prevents matching of arguments by name and match by position instead.
.type   

A vector mold or a string describing the type of the input vectors. The latter can be any of the types returned by typeof(), or "numeric" as a shorthand for either "double" or "integer".
Details

The most important of those helpers is probably lift_dl() because it allows you to transform a regular function to one that takes a list. This is often essential for composition with purrr functional tools. Since this is such a common function, lift() is provided as an alias for that operation.
Value

A function.
from ... to list(...) or c(...)

Here dots should be taken here in a figurative way. The lifted functions does not need to take dots per se. The function is simply wrapped a function in do.call(), so instead of taking multiple arguments, it takes a single named list or vector which will be interpreted as its arguments. This is particularly useful when you want to pass a row of a data frame or a list to a function and don't want to manually pull it apart in your function.
from c(...) to list(...) or ...

These factories allow a function taking a vector to take a list or dots instead. The lifted function internally transforms its inputs back to an atomic vector. purrr does not obey the usual R casting rules (e.g., c(1, "2") produces a character vector) and will produce an error if the types are not compatible. Additionally, you can enforce a particular vector type by supplying .type.
from list(...) to c(...) or ...

lift_ld() turns a function that takes a list into a function that takes dots. lift_vd() does the same with a function that takes an atomic vector. These factory functions are the inverse operations of lift_dl() and lift_dv().

lift_vd() internally coerces the inputs of ..f to an atomic vector. The details of this coercion can be controlled with .type.
See Also

invoke()
Examples

### Lifting from ... to list(...) or c(...)

x <- list(x = c(1:100, NA, 1000), na.rm = TRUE, trim = 0.9)
lift_dl(mean)(x)

# Or in a pipe:
mean %>% lift_dl() %>% invoke(x)

# You can also use the lift() alias for this common operation:
lift(mean)(x)

# Default arguments can also be specified directly in lift_dl()
list(c(1:100, NA, 1000)) %>% lift_dl(mean, na.rm = TRUE)()

# lift_dl() and lift_ld() are inverse of each other.
# Here we transform sum() so that it takes a list
fun <- sum %>% lift_dl()
fun(list(3, NA, 4, na.rm = TRUE))

# Now we transform it back to a variadic function
fun2 <- fun %>% lift_ld()
fun2(3, NA, 4, na.rm = TRUE)

# It can sometimes be useful to make sure the lifted function's
# signature has no named parameters, as would be the case for a
# function taking only dots. The lifted function will take a list
# or vector but will not match its arguments to the names of the
# input. For instance, if you give a data frame as input to your
# lifted function, the names of the columns are probably not
# related to the function signature and should be discarded.
lifted_identical <- lift_dl(identical, .unnamed = TRUE)
mtcars[c(1, 1)] %>% lifted_identical()
mtcars[c(1, 2)] %>% lifted_identical()
#


### Lifting from c(...) to list(...) or ...

# In other situations we need the vector-valued function to take a
# variable number of arguments as with pmap(). This is a job for
# lift_vd():
pmap(mtcars, lift_vd(mean))

# lift_vd() will collect the arguments and concatenate them to a
# vector before passing them to ..f. You can add a check to assert
# the type of vector you expect:
lift_vd(tolower, .type = character(1))("this", "is", "ok")
#


### Lifting from list(...) to c(...) or ...

# cross() normally takes a list of elements and returns their
# cartesian product. By lifting it you can supply the arguments as
# if it was a function taking dots:
cross_dots <- lift_ld(cross)
out1 <- cross(list(a = 1:2, b = c("a", "b", "c")))
out2 <- cross_dots(a = 1:2, b = c("a", "b", "c"))
identical(out1, out2)

# This kind of lifting is sometimes needed for function
# composition. An example would be to use pmap() with a function
# that takes a list. In the following, we use some() on each row of
# a data frame to check they each contain at least one element
# satisfying a condition:
mtcars %>% pmap(lift_ld(some, partial(`<`, 200)))

# Default arguments for ..f can be specified in the call to
# lift_ld()
lift_ld(cross, .filter = `==`)(1:3, 1:3) %>% str()


# Here is another function taking a list and that we can update to
# take a vector:
glue <- function(l) {
  if (!is.list(l)) stop("not a list")
  l %>% invoke(paste, .)
}

## Not run: 
letters %>% glue()           # fails because glue() expects a list
## End(Not run)

letters %>% lift_lv(glue)()  # succeeds


x <- list(x = c(1:100, NA, 1000), na.rm = TRUE, trim = 0.9)
lift_dl(mean)(x)

# Or in a pipe:
mean %>% lift_dl() %>% invoke(x)


list_modify {purrr} R Documentation
Modify a list
Description

list_modify() and list_merge() recursively combine two lists, matching elements either by name or position. If an sub-element is present in both lists list_modify() takes the value from y, and list_merge() concatenates the values together.

update_list() handles formulas and quosures that can refer to values existing within the input list. Note that this function might be deprecated in the future in favour of a dplyr::mutate() method for lists.
Usage

list_modify(.x, ...)

list_merge(.x, ...)

Arguments
.x  

List to modify.
...   

New values of a list. Use NULL to remove values. Use a formula to evaluate in the context of the list values. These dots have splicing semantics.
Examples

x <- list(x = 1:10, y = 4, z = list(a = 1, b = 2))
str(x)

# Update values
str(list_modify(x, a = 1))
# Replace values
str(list_modify(x, z = 5))
str(list_modify(x, z = list(a = 1:5)))
# Remove values
str(list_modify(x, z = NULL))

# Combine values
str(list_merge(x, x = 11, z = list(a = 2:5, c = 3)))


# All these functions take dots with splicing. Use !!! or UQS() to
# splice a list of arguments:
l <- list(new = 1, y = NULL, z = 5)
str(list_modify(x, !!! l))

# In update_list() you can also use quosures and formulas to
# compute new values. This function is likely to be deprecated in
# the future
update_list(x, z1 = ~z[[1]])
update_list(x, z = rlang::quo(x + y))

[Package purrr version 0.2.3 Index]


lmap {purrr}  R Documentation
Apply a function to list-elements of a list
Description

lmap(), lmap_at() and lmap_if() are similar to map(), map_at() and map_if(), with the difference that they operate exclusively on functions that take and return a list (or data frame). Thus, instead of mapping the elements of a list (as in .x[[i]]), they apply a function .f to each subset of size 1 of that list (as in .x[i]). We call those those elements ‘list-elements’).
Usage

lmap(.x, .f, ...)

lmap_if(.x, .p, .f, ...)

lmap_at(.x, .at, .f, ...)

Arguments
.x  

A list or data frame.
.f  

A function that takes and returns a list or data frame.
...   

Additional arguments passed on to .f.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
.at   

A character vector of names or a numeric vector of positions. Only those elements corresponding to .at will be modified.
Details

Mapping the list-elements .x[i] has several advantages. It makes it possible to work with functions that exclusively take a list or data frame. It enables .f to access the attributes of the encapsulating list, like the name of the components it receives. It also enables .f to return a larger list than the list-element of size 1 it got as input. Conversely, .f can also return empty lists. In these cases, the output list is reshaped with a different size than the input list .x.
Value

If .x is a list, a list. If .x is a data frame, a data frame.
See Also

Other map variants: imap, invoke, map2, map, modify
Examples

# Let's write a function that returns a larger list or an empty list
# depending on some condition. This function also uses the names
# metadata available in the attributes of the list-element
maybe_rep <- function(x) {
  n <- rpois(1, 2)
  out <- rep_len(x, n)
  if (length(out) > 0) {
    names(out) <- paste0(names(x), seq_len(n))
  }
  out
}

# The output size varies each time we map f()
x <- list(a = 1:4, b = letters[5:7], c = 8:9, d = letters[10])
x %>% lmap(maybe_rep)

# We can apply f() on a selected subset of x
x %>% lmap_at(c("a", "d"), maybe_rep)

# Or only where a condition is satisfied
x %>% lmap_if(is.character, maybe_rep)


# A more realistic example would be a function that takes discrete
# variables in a dataset and turns them into disjunctive tables, a
# form that is amenable to fitting some types of models.

# A disjunctive table contains only 0 and 1 but has as many columns
# as unique values in the original variable. Ideally, we want to
# combine the names of each level with the name of the discrete
# variable in order to identify them. Given these requirements, it
# makes sense to have a function that takes a data frame of size 1
# and returns a data frame of variable size.
disjoin <- function(x, sep = "_") {
  name <- names(x)
  x <- as.factor(x[[1]])

  out <- lapply(levels(x), function(level) {
    as.numeric(x == level)
  })

  names(out) <- paste(name, levels(x), sep = sep)
  tibble::as_tibble(out)
}

# Now, we are ready to map disjoin() on each categorical variable of a
# data frame:
iris %>% lmap_if(is.factor, disjoin)
mtcars %>% lmap_at(c("cyl", "vs", "am"), disjoin)

[Package purrr version 0.2.3 Index]

map {purrr} R Documentation
Apply a function to each element of a vector
Description

The map functions transform their input by applying a function to each element and returning a vector the same length as the input.

    map(), map_if() and map_at() always return a list. See the modify() family for versions that return an object of the same type as the input.

    The _if and _at variants take a predicate function .p that determines which elements of .x are transformed with .f. transform.

    map_lgl(), map_int(), map_dbl() and map_chr() return vectors of the corresponding type (or die trying).

    map_dfr() and map_dfc() return data frames created by row-binding and column-binding respectively. They require dplyr to be installed.

    walk() calls .f for its side-effect and returns the input .x.

Usage

map(.x, .f, ...)

map_if(.x, .p, .f, ...)

map_at(.x, .at, .f, ...)

map_lgl(.x, .f, ...)

map_chr(.x, .f, ...)

map_int(.x, .f, ...)

map_dbl(.x, .f, ...)

map_dfr(.x, .f, ..., .id = NULL)

map_dfc(.x, .f, ...)

walk(.x, .f, ...)

Arguments
.x  

A list or atomic vector.
.f  

A function, formula, or atomic vector.

If a function, it is used as is.

If a formula, e.g. ~ .x + 2, it is converted to a function. There are three ways to refer to the arguments:

    For a single argument function, use .

    For a two argument function, use .x and .y

    For more arguments, use ..1, ..2, ..3 etc

This syntax allows you to create very compact anonymous functions.

If character vector, numeric vector, or list, it is converted to an extractor function. Character vectors index by name and numeric vectors index by position; use a list to index by position and name at different levels. Within a list, wrap strings in get_attr() to extract named attributes. If a component is not present, the value of .default will be returned.
...   

Additional arguments passed on to .f.
.p  

A single predicate function, a formula describing such a predicate function, or a logical vector of the same length as .x. Alternatively, if the elements of .x are themselves lists of objects, a string indicating the name of a logical element in the inner lists. Only those elements where .p evaluates to TRUE will be modified.
.at   

A character vector of names or a numeric vector of positions. Only those elements corresponding to .at will be modified.
.id   

If not NULL a variable with this name will be created giving either the name or the index of the data frame.
Value

All functions return a vector the same length as .x.

map() returns a list, map_lgl() a logical vector, map_int() an integer vector, map_dbl() a double vector, and map_chr() a character vector. The output of .f will be automatically typed upwards, e.g. logical -> integer -> double -> character.

walk() returns the input .x (invisibly). This makes it easy to use in pipe.
See Also

Other map variants: imap, invoke, lmap, map2, modify
Examples

1:10 %>%
  map(rnorm, n = 10) %>%
  map_dbl(mean)

# Or use an anonymous function
1:10 %>%
  map(function(x) rnorm(10, x))

# Or a formula
1:10 %>%
  map(~ rnorm(10, .x))

# Extract by name or position
# .default specifies value for elements that are missing or NULL
l1 <- list(list(a = 1L), list(a = NULL, b = 2L), list(b = 3L))
l1 %>% map("a", .default = "???")
l1 %>% map_int("b", .default = NA)
l1 %>% map_int(2, .default = NA)

# Supply multiple values to index deeply into a list
l2 <- list(
  list(num = 1:3,     letters[1:3]),
  list(num = 101:103, letters[4:6]),
  list()
)
l2 %>% map(c(2, 2))

# Use a list to build an extractor that mixes numeric indices and names,
# and .default to provide a default value if the element does not exist
l2 %>% map(list("num", 3))
l2 %>% map_int(list("num", 3), .default = NA)

# A more realistic example: split a data frame into pieces, fit a
# model to each piece, summarise and extract R^2
mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .x)) %>%
  map(summary) %>%
  map_dbl("r.squared")

# Use map_lgl(), map_dbl(), etc to reduce to a vector.
# * list
mtcars %>% map(sum)
# * vector
mtcars %>% map_dbl(sum)

# If each element of the output is a data frame, use
# map_df to row-bind them together:
mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .x)) %>%
  map_df(~ as.data.frame(t(as.matrix(coef(.)))))
# (if you also want to preserve the variable names see
# the broom package)

[Package purrr version 0.2.3 Index]
mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .x)) %>%
  map(summary) %>%
  map_dbl("r.squared")


mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .x)) %>%
  map_df(~ as.data.frame(t(as.matrix(coef(.)))))



map2 {purrr}  R Documentation
Map over multiple inputs simultaneously.
Description

These functions are variants of map() iterate over multiple arguments in parallel. map2() and walk2() are specialised for the two argument case; pmap() and pwalk() allow you to provide any number of arguments in a list.
Usage

map2(.x, .y, .f, ...)

map2_lgl(.x, .y, .f, ...)

map2_int(.x, .y, .f, ...)

map2_dbl(.x, .y, .f, ...)

map2_chr(.x, .y, .f, ...)

map2_dfr(.x, .y, .f, ..., .id = NULL)

map2_dfc(.x, .y, .f, ...)

walk2(.x, .y, .f, ...)

pmap(.l, .f, ...)

pmap_lgl(.l, .f, ...)

pmap_int(.l, .f, ...)

pmap_dbl(.l, .f, ...)

pmap_chr(.l, .f, ...)

pmap_dfr(.l, .f, ..., .id = NULL)

pmap_dfc(.l, .f, ...)

pwalk(.l, .f, ...)

Arguments
.x, .y  

Vectors of the same length. A vector of length 1 will be recycled.
.f  

A function, formula, or atomic vector.

If a function, it is used as is.

If a formula, e.g. ~ .x + 2, it is converted to a function. There are three ways to refer to the arguments:

    For a single argument function, use .

    For a two argument function, use .x and .y

    For more arguments, use ..1, ..2, ..3 etc

This syntax allows you to create very compact anonymous functions.

If character vector, numeric vector, or list, it is converted to an extractor function. Character vectors index by name and numeric vectors index by position; use a list to index by position and name at different levels. Within a list, wrap strings in get_attr() to extract named attributes. If a component is not present, the value of .default will be returned.
...   

Additional arguments passed on to .f.
.id   

If not NULL a variable with this name will be created giving either the name or the index of the data frame.
.l  

A list of lists. The length of .l determines the number of arguments that .f will be called with. List names will be used if present.
Details

Note that arguments to be vectorised over come before the .f, and arguments that are supplied to every call come after .f.
Value

An atomic vector, list, or data frame, depending on the suffix. Atomic vectors and lists will be named if .x or the first element of .l is named.

If all input is length 0, the output will be length 0. If any input is length 1, it will be recycled to the length of the longest.
See Also

Other map variants: imap, invoke, lmap, map, modify
Examples

x <- list(1, 10, 100)
y <- list(1, 2, 3)
z <- list(5, 50, 500)

map2(x, y, ~ .x + .y)
# Or just
map2(x, y, `+`)

# Split into pieces, fit model to each piece, then predict
by_cyl <- mtcars %>% split(.$cyl)
mods <- by_cyl %>% map(~ lm(mpg ~ wt, data = .))
map2(mods, by_cyl, predict)

pmap(list(x, y, z), sum)

# Matching arguments by position
pmap(list(x, y, z), function(a, b ,c) a / (b + c))

# Matching arguments by name
l <- list(a = x, b = y, c = z)
pmap(l, function(c, b, a) a / (b + c))

# Vectorizing a function over multiple arguments
df <- data.frame(
  x = c("apple", "banana", "cherry"),
  pattern = c("p", "n", "h"),
  replacement = c("x", "f", "q"),
  stringsAsFactors = FALSE
  )
pmap(df, gsub)
pmap_chr(df, gsub)

## Use `...` to absorb unused components of input list .l
df <- data.frame(
  x = 1:3 + 0.1,
  y = 3:1 - 0.1,
  z = letters[1:3]
)
plus <- function(x, y) x + y
## Not run: 
## this won't work
pmap(df, plus)

## End(Not run)
## but this will
plus2 <- function(x, y, ...) x + y
pmap_dbl(df, plus2)

[Package purrr version 0.2.3 Index]



partial {purrr} R Documentation
Partial apply a function, filling in some arguments.
Description

Partial function application allows you to modify a function by pre-filling some of the arguments. It is particularly useful in conjunction with functionals and other function operators.
Usage

partial(...f, ..., .env = parent.frame(), .lazy = TRUE, .first = TRUE)

Arguments
...f  

a function. For the output source to read well, this should be a named function.
...   

named arguments to ...f that should be partially applied.
.env  

the environment of the created function. Defaults to parent.frame() and you should rarely need to modify this.
.lazy   

If TRUE arguments evaluated lazily, if FALSE, evaluated when partial is called.
.first  

If TRUE, the partialized arguments are placed to the front of the function signature. If FALSE, they are moved to the back. Only useful to control position matching of arguments when the partialized arguments are not named.
Design choices

There are many ways to implement partial function application in R. (see e.g. dots in https://github.com/crowding/ptools for another approach.) This implementation is based on creating functions that are as similar as possible to the anonymous functions that you'd create by hand, if you weren't using partial.
Examples

# Partial is designed to replace the use of anonymous functions for
# filling in function arguments. Instead of:
compact1 <- function(x) discard(x, is.null)

# we can write:
compact2 <- partial(discard, .p = is.null)

# and the generated source code is very similar to what we made by hand
compact1
compact2

# Note that the evaluation occurs "lazily" so that arguments will be
# repeatedly evaluated
f <- partial(runif, n = rpois(1, 5))
f
f()
f()

# You can override this by saying .lazy = FALSE
f <- partial(runif, n = rpois(1, 5), .lazy = FALSE)
f
f()
f()

# This also means that partial works fine with functions that do
# non-standard evaluation
my_long_variable <- 1:10
plot2 <- partial(plot, my_long_variable)
plot2()
plot2(runif(10), type = "l")


