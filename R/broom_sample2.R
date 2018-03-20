lmfit <- lm(mpg ~ wt, mtcars)
lmfit
library(broom)
tidy(lmfit)

head(augment(lmfit))


glance(lmfit)



library(broom)
library(dplyr)
data(Orange)

dim(Orange)


# Orange 
Orange %>% group_by(Tree) %>% dplyr::summarize(correlation = cor(age, circumference))
Orange %>% dplyr::group_by(Tree) %>% summarize(correlation = cor(age, circumference))


if (require("nycflights13")) {
carriers <- dplyr::group_by(flights, carrier)
dplyr::summarise(carriers, n())
dplyr::mutate(carriers, n = n())
dplyr::filter(carriers, n() < 100)
}

Orange %>% group_by(Tree) %>% do(tidy(cor.test(.$age, .$circumference)))



Orange %>% group_by(Tree) %>% do(tidy(cor.test(.$age, .$circumference)))

Orange %>% group_by(Tree) %>% do(tidy(lm(age ~ circumference, data=.)))

mtcars %>% group_by(am) %>% do(tidy(lm(wt ~ mpg + qsec + gear, .)))

regressions <- mtcars %>% group_by(cyl) %>%
    do(fit = lm(wt ~ mpg + qsec + gear, .))
regressions

regressions %>% tidy(fit)
regressions %>% augment(fit)
regressions %>% glance(fit)


Orange %>% group_by(Tree) %>% do(head(.,3))
Orange %>% group_by(Tree) %>% do(output = dplyr::n)



by_cyl <- group_by(mtcars, cyl)
do(by_cyl, head(., 2))

models <- by_cyl %>% do(mod = lm(mpg ~ disp, data = .))
models

summarise(models, rsq = summary(mod)$r.squared)
models %>% do(data.frame(coef = coef(.$mod)))
models %>% do(data.frame(
  var = names(coef(.$mod)),
  coef(summary(.$mod)))
)

models <- by_cyl %>% do(
  mod_linear = lm(mpg ~ disp, data = .),
  mod_quad = lm(mpg ~ poly(disp, 2), data = .)
)
models
compare <- models %>% do(aov = anova(.$mod_linear, .$mod_quad))
# compare %>% summarise(p.value = aov$`Pr(>F)`)

if (require("nycflights13")) {
# You can use it to do any arbitrary computation, like fitting a linear
# model. Let's explore how carrier departure delays vary over the time
carriers <- group_by(flights, carrier)
group_size(carriers)
dplyr::summarise(carriers, n())


x <- rnorm(1e2)
x[between(x, -1, 1)]

split(mtcars, mtcars$cyl)



x <- 1:50
case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  TRUE ~ as.character(x)
)

# Like an if statement, the arguments are evaluated in order, so you must
# proceed from the most specific to the most general. This won't work:
case_when(
  TRUE ~ as.character(x),
  x %%  5 == 0 ~ "fizz",
  x %%  7 == 0 ~ "buzz",
  x %% 35 == 0 ~ "fizz buzz"
)

# case_when is particularly useful inside mutate when you want to
# create a new variable that relies on a complex combination of existing
# variables
starwars %>%
  select(name:mass, gender, species) %>%
  mutate(
    type = case_when(
      height > 200 | mass > 200 ~ "large",
      species == "Droid"        ~ "robot",
      TRUE                      ~  "other"
    )
  )

x <- c(5, 1, 3, 2, 2, NA)
row_number(x)
min_rank(x)
dense_rank(x)
percent_rank(x)
cume_dist(x)

ntile(x, 2)
ntile(runif(100), 10)

# row_number can be used with single table verbs without specifying x
# (for data frames and databases that support windowing)
mutate(mtcars, row_number() == 1L)
mtcars %>% filter(between(row_number(), 1, 10))


df <- tibble(
  x = sample(10, 100, rep = TRUE),
  y = sample(10, 100, rep = TRUE)
)
nrow(df)
nrow(distinct(df))
nrow(distinct(df, x, y))

distinct(df, x)
distinct(df, y)

# Can choose to keep all other variables as well
distinct(df, x, .keep_all = TRUE)
distinct(df, y, .keep_all = TRUE)

# You can also use distinct on computed variables
distinct(df, diff = abs(x - y))

# The same behaviour applies for grouped data frames
# except that the grouping variables are always included
df <- tibble(
  g = c(1, 1, 2, 2),
  x = c(1, 1, 2, 1)
) %>% group_by(g)
df %>% distinct()
df %>% distinct(x)

x <- 1:10
y <- 10:1

first(x)
last(y)

nth(x, 1)
nth(x, 5)
nth(x, -2)
nth(x, 11)

df <- expand.grid(x = 1:3, y = 3:1)
df %>% rowwise() %>% do(i = seq(.$x, .$y))
.Last.value %>% summarise(n = length(i))


requireNamespace("dbplyr", quietly = TRUE)
  mtcars %>% count(cyl)
by_day <- flights %>% group_by(year, month, day)
n_groups(by_day)
  starwars %>%
  add_count(species) %>%
  filter(n == 1)
mods <- do(carriers, mod = lm(arr_delay ~ dep_time, data = .))
mods %>% do(as.data.frame(coef(.$mod)))
mods %>% summarise(rsq = summary(mod)$r.squared)

## Not run: 
# This longer example shows the progress bar in action
by_dest <- flights %>% group_by(dest) %>% filter(n() > 100)
library(mgcv)
by_dest %>% do(smooth = gam(arr_delay ~ s(dep_time) + month, data = .))

## End(Not run)
}

