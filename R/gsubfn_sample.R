
require(gsubfn)
 s <-'abc 10:20 def 30:40 50'
gsubfn('([0-9]+):([0-9]+)', ~ as.numeric(x) + as.numeric(y), s)


dat <- c(
'
3.5G
'
,
'
88P
'
,
'
19
'
) # test data
>    gsubfn(
'
[MGP]$
'
, list(M =
'
e6
'
, G =
'
e9
'
, P =
'
e12
'
), dat)


 s <- c('123abc','12cd34','1e23') 
 strapply(s,'^([[:digit:]]+)(.*)', c, simplify = rbind)

 fn$lapply(list(1:4, 1:5), ~ LETTERS[x])
 fn$mapply(~ seq_len(x) + y * z, 1:3, 4:6,2)

 fn$by(CO2[4:5], CO2[2], x ~ coef(lm(uptake ~ ., x)), simplify = rbind)


 > library(lattice)
> library(grid)
> print(fn$xyplot(uptake ~ conc | Plant, CO2,
+       panel = ~~ { panel.xyplot(...); grid.text(panel.number(), .1, .85)}))


fn$aggregate(iris[-5], iris[5], ~ mean(range(x)))


