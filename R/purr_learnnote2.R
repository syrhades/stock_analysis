1:10 %>%
  map(rnorm, n = 10) %>%
  map_dbl(mean)

# Or use an anonymous function
1:10 %>%
  map(function(x) rnorm(10, x))

# Or a formula
1:10 %>%
  map(~ rnorm(10, .x))

mtcars %>%
  split(.$cyl) %>%
  map(summary) %>%
  map_dbl("r.squared")

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