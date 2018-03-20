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
