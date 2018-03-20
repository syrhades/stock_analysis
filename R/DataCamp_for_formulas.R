Starting with formulas
100xp
Formulas such as wage ~ age + exper are used to describe the form of relationships among variables. In this exercise, you are going to use formulas and functions to summarize data on the cost of life insurance policies. The data are in the AARP data frame, which has been preloaded from the statisticalModeling package.

The mosaic package augments simple statistical functions such as mean(), sd(), median(), etc. so that they can be used with formulas. For instance, mosaic::mean(wage ~ sex, data = CPS85) will calculate the mean wage for each sex. In contrast, the "built-in" mean() function (part of the base package) doesn't accept formulas, making it unnecessarily hard to do things like calculate groupwise means.

Note that we explicitly reference the mean() function from the mosaic package using double-colon notation (i.e. package::function()) to make it clear that we're not using the base R version of mean(). If you'd like, you can watch a supplemental video here to learn more about formulas and functions in R.

Instructions
Find the variable names in the AARP data frame, which has been preloaded in your workspace from the statisticalModeling package. AARP contains life insurance prices for the two sexes at different ages.
Construct a formula using the variable names from the AARP data frame with an eye toward calculating the insurance cost broken down by sex. Use that formula as the first argument to mosaic::mean() to find the mean cost by sex.
Take Hint (-30xp)


require(statisticalModeling)

# Find the variable names in AARP
names(AARP)

# Find the mean cost broken down by sex
mosaic::mean(Cost~Sex, data = AARP)



Graphics with formulas
100xp
Formulas can be used to describe graphics in each of the three popular graphics systems: base graphics, lattice graphics, and in ggplot2 with the statisticalModeling package. Most people choose to work in one of the graphics systems. I recommend ggplot2 with the formula interface provided by statisticalModeling.

Instructions
Make a boxplot of insurance cost broken down by sex in one of the three graphics systems. All can use the same syntax: function(formula, data = AARP).
In base graphics, the appropriate function is boxplot().
In lattice graphics, use bwplot() to make the boxplot. As always, you will have to load the lattice package.
In the formula interface to ggplot2, use gf_boxplot(). The statisticalModeling package (which communicates with ggplot2), has been loaded for you.
Make a scatterplot of Cost versus Age in one of the graphics packages.
In base graphics: plot().
In lattice graphics: xyplot().
For ggplot graphics: gf_point().
Take Hint (-30xp)


For each of the graphics systems, the command will have the same format:
The name of the graphics function, i.e. boxplot() or bwplot() or gf_boxplot().
Argument 1: a formula like yname ~ xname describing which variable goes on the y-axis and which on the x-axis.
Argument 2: a named argument data giving the name of the dataset to use in constructing the plot.




####################################################################
The models fit by, e.g., the lm and glm functions are specified in a compact symbolic form. The ~ operator is basic in the formation of such models. An expression of the form y ~ model is interpreted as a specification that the response y is modelled by a linear predictor specified symbolically by model. Such a model consists of a series of terms separated by + operators. The terms themselves consist of variable and factor names separated by : operators. Such a term is interpreted as the interaction of all the variables and factors appearing in the term.

In addition to + and :, a number of other operators are useful in model formulae. The * operator denotes factor crossing: 
. The ^ operator indicates crossing to the specified degree. For example (a+b+c)^2 is identical to (a+b+c)*(a+b+c) which in turn expands to a formula containing the main effects for a, b and c together with their second-order interactions. The %in% operator indicates that the terms on its left are nested within those on the right. For example a + b %in% a expands to the formula a + a:b. The - operator removes the specified terms, so that (a+b+c)^2 - a:b is identical to a + b + c + b:c + a:c. It can also used to remove the intercept term: when fitting a linear model y ~ x - 1 specifies a line through the origin. A model with no intercept can be also specified as y ~ x + 0 or y ~ 0 + x.

While formulae usually involve just variable and factor names, they can also involve arithmetic expressions. The formula log(y) ~ a + log(x) is quite legal. When such arithmetic expressions involve operators which are also used symbolically in model formulae, there can be confusion between arithmetic and symbolic operator use.

To avoid this confusion, the function I() can be used to bracket those portions of a model formula where the operators are used in their arithmetic sense. For example, in the formula y ~ a + I(b+c), the term b+c is to be interpreted as the sum of b and c.

Variable names can be quoted by backticks `like this` in formulae, although there is no guarantee that all code using formulae will accept such non-syntactic names.

Most model-fitting functions accept formulae with right-hand-side including the function offset to indicate terms with a fixed coefficient of one. Some functions accept other ‘specials’ such as strata or cluster (see the specials argument of terms.formula).

There are two special interpretations of . in a formula. The usual one is in the context of a data argument of model fitting functions and means ‘all columns not otherwise in the formula’: see terms.formula. In the context of update.formula, only, it means ‘what was previously in this part of the formula’.

When formula is called on a fitted model object, either a specific method is used (such as that for class "nls") or the default method. The default first looks for a "formula" component of the object (and evaluates it), then a "terms" component, then a formula parameter of the call (and evaluates its value) and finally a "formula" attribute.

There is a formula method for data frames. If there is only one column this forms the RHS with an empty LHS. For more columns, the first column is the LHS of the formula and the remaining columns separated by + form the RHS.
Value

All the functions above produce an object of class "formula" which contains a symbolic model formula.
Environments

A formula object has an associated environment, and this environment (rather than the parent environment) is used by model.frame to evaluate variables that are not found in the supplied data argument.

Formulas created with the ~ operator use the environment in which they were created. Formulas created with as.formula will use the env argument for their environment. 


map2 {purrr}	R Documentation
Map over multiple inputs simultaneously.

Description

These functions are variants of map() iterate over multiple arguments in parallel. map2 is specialised for the two argument case; pmap allows you to provide any number of arguments in a list.

Usage

map2(.x, .y, .f, ...)

map2_lgl(.x, .y, .f, ...)

map2_int(.x, .y, .f, ...)

map2_dbl(.x, .y, .f, ...)

map2_chr(.x, .y, .f, ...)

map2_df(.x, .y, .f, ..., .id = NULL)

pmap(.l, .f, ...)

pmap_lgl(.l, .f, ...)

pmap_int(.l, .f, ...)

pmap_dbl(.l, .f, ...)

pmap_chr(.l, .f, ...)

pmap_df(.l, .f, ..., .id = NULL)

walk2(.x, .y, .f, ...)

pwalk(.l, .f, ...)
Arguments

.x, .y	
Vectors of the same length. A vector of length 1 will be recycled.
.f	
A function, formula, or atomic vector.
If a function, it is used as is.
If a formula, e.g. ~ .x + 2, it is converted to a function with two arguments, .x or . and .y. This allows you to create very compact anonymous functions with up to two inputs.
If character or integer vector, e.g. "y", it is converted to an extractor function, function(x) x[["y"]]. To index deeply into a nested list, use multiple values; c("x", "y") is equivalent to z[["x"]][["y"]]. You can also set .null to set a default to use instead of NULL for absent components.
...	
Additional arguments passed on to .f.
.id	
If not NULL a variable with this name will be created giving either the name or the index of the data frame.
.l	
A list of lists. The length of .l determines the number of arguments that .f will be called with. List names will be used if present.
Details

Note that arguments to be vectorised over come before the .f, and arguments that are supplied to every call come after .f.

pmap() and pwalk() take a single list .l and map over all its elements in parallel.

Value

An atomic vector, list, or data frame, depending on the suffix. Atomic vectors and lists will be named if .x or the first element of .l is named.

Examples

x <- list(1, 10, 100)
y <- list(1, 2, 3)
map2(x, y, ~ .x + .y)
# Or just
map2(x, y, `+`)

# Split into pieces, fit model to each piece, then predict
by_cyl <- mtcars %>% split(.$cyl)
mods <- by_cyl %>% map(~ lm(mpg ~ wt, data = .))
map2(mods, by_cyl, predict)

