example(lowess)
require(graphics)

plot(cars, main = "lowess(cars)")
lines(lowess(cars), col = 2)
lines(lowess(cars, f = .2), col = 3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty = 1, col = 2:3)

library(MASS)
attach(geyser)
plot(duration, waiting, xlim = c(0.5,6), ylim = c(40,100))
f1 <- kde2d(duration, waiting, n = 50, lims = c(0.5, 6, 40, 100))
image(f1, zlim = c(0, 0.05))
f2 <- kde2d(duration, waiting, n = 50, lims = c(0.5, 6, 40, 100),
         h = c(width.SJ(duration), width.SJ(waiting)) )
image(f2, zlim = c(0, 0.05))
persp(f2, phi = 30, theta = 20, d = 5)

plot(duration[-272], duration[-1], xlim = c(0.5, 6),
  ylim = c(1, 6),xlab = "previous duration", ylab = "duration")
f1 <- kde2d(duration[-272], duration[-1],
         h = rep(1.5, 2), n = 50, lims = c(0.5, 6, 0.5, 6))
contour(f1, xlab = "previous duration",
     ylab = "duration", levels  =  c(0.05, 0.1, 0.2, 0.4) )
f1 <- kde2d(duration[-272], duration[-1],
         h = rep(0.6, 2), n = 50, lims = c(0.5, 6, 0.5, 6))
contour(f1, xlab = "previous duration",
     ylab = "duration", levels  =  c(0.05, 0.1, 0.2, 0.4) )
f1 <- kde2d(duration[-272], duration[-1],
         h = rep(0.4, 2), n = 50, lims = c(0.5, 6, 0.5, 6))
contour(f1, xlab = "previous duration",
     ylab = "duration", levels  =  c(0.05, 0.1, 0.2, 0.4) )
detach("geyser")



require(grDevices) # for colours
x <- -6:16
op <- par(mfrow = c(2, 2))
contour(outer(x, x), method = "edge", vfont = c("sans serif", "plain"))
z <- outer(x, sqrt(abs(x)), FUN = "/")
image(x, x, z)
contour(x, x, z, col = "pink", add = TRUE, method = "edge",
     vfont = c("sans serif", "plain"))
contour(x, x, z, ylim = c(1, 6), method = "simple", labcex = 1,
     xlab = quote(x[1]), ylab = quote(x[2]))
contour(x, x, z, ylim = c(-6, 6), nlev = 20, lty = 2, method = "simple",
     main = "20 levels; \"simple\" labelling method")
par(op)

## Persian Rug Art:
x <- y <- seq(-4*pi, 4*pi, len = 27)
r <- sqrt(outer(x^2, y^2, "+"))
opar <- par(mfrow = c(2, 2), mar = rep(0, 4))
for(f in pi^(0:3))
contour(cos(r^2)*exp(-r/f),
       drawlabels = FALSE, axes = FALSE, frame = TRUE)
rx <- range(x <- 10*1:nrow(volcano))
ry <- range(y <- 10*1:ncol(volcano))
ry <- ry + c(-1, 1) * (diff(rx) - diff(ry))/2
tcol <- terrain.colors(12)
par(opar); opar <- par(pty = "s", bg = "lightcyan")
plot(x = 0, y = 0, type = "n", xlim = rx, ylim = ry, xlab = "", ylab = "")
u <- par("usr")
rect(u[1], u[3], u[2], u[4], col = tcol[8], border = "red")
contour(x, y, volcano, col = tcol[2], lty = "solid", add = TRUE,
       vfont = c("sans serif", "plain"))
title("A Topographic Map of Maunga Whau", font = 4)
abline(h = 200*0:4, v = 200*0:4, col = "lightgray", lty = 2, lwd = 0.1)

## contourLines produces the same contour lines as contour
plot(x = 0, y = 0, type = "n", xlim = rx, ylim = ry, xlab = "", ylab = "")
u <- par("usr")
rect(u[1], u[3], u[2], u[4], col = tcol[8], border = "red")
contour(x, y, volcano, col = tcol[1], lty = "solid", add = TRUE,
       vfont = c("sans serif", "plain"))
line.list <- contourLines(x, y, volcano)
invisible(lapply(line.list, lines, lwd=3, col=adjustcolor(2, .3)))
par(opar)



#####################################
 require(grDevices)
     matplot((-4:5)^2, main = "Quadratic") # almost identical to plot(*)
     sines <- outer(1:20, 1:4, function(x, y) sin(x / 20 * pi * y))
     matplot(sines, pch = 1:4, 	, col = rainbow(ncol(sines)))
     matplot(sines, type = "b", pch = 21:23, col = 2:5, bg = 2:5,
             main = "matplot(...., pch = 21:23, bg = 2:5)")
     
     x <- 0:50/50
     matplot(x, outer(x, 1:8, function(x, k) sin(k*pi * x)),
             ylim = c(-2,2), type = "plobcsSh",
             main= "matplot(,type = \"plobcsSh\" )")
     ## pch & type =  vector of 1-chars :
     matplot(x, outer(x, 1:4, function(x, k) sin(k*pi * x)),
             pch = letters[1:4], type = c("b","p","o"))
     
     lends <- c("round","butt","square")
     matplot(matrix(1:12, 4), type="c", lty=1, lwd=10, lend=lends)
     text(cbind(2.5, 2*c(1,3,5)-.4), lends, col= 1:3, cex = 1.5)
     
     table(iris$Species) # is data.frame with 'Species' factor
     iS <- iris$Species == "setosa"
     iV <- iris$Species == "versicolor"
     op <- par(bg = "bisque")
     matplot(c(1, 8), c(0, 4.5), type =  "n", xlab = "Length", ylab = "Width",
             main = "Petal and Sepal Dimensions in Iris Blossoms")
     matpoints(iris[iS,c(1,3)], iris[iS,c(2,4)], pch = "sS", col = c(2,4))
     matpoints(iris[iV,c(1,3)], iris[iV,c(2,4)], pch = "vV", col = c(2,4))
     legend(1, 4, c("    Setosa Petals", "    Setosa Sepals",
                    "Versicolor Petals", "Versicolor Sepals"),
            pch = "sSvV", col = rep(c(2,4), 2))

     nam.var <- colnames(iris)[-5]
        nam.spec <- as.character(iris[1+50*0:2, "Species"])
        iris.S <- array(NA, dim = c(50,4,3),
                        dimnames = list(NULL, nam.var, nam.spec))
        for(i in 1:3) iris.S[,,i] <- data.matrix(iris[1:50+50*(i-1), -5])
        
        matplot(iris.S[, "Petal.Length",], iris.S[, "Petal.Width",], pch = "SCV",
                col = rainbow(3, start = 0.8, end = 0.1),
                sub = paste(c("S", "C", "V"), dimnames(iris.S)[[3]],
                            sep = "=", collapse= ",  "),
                main = "Fisher's Iris Data")
        par(op)

page125
rep(0:5,c(108,3,4,5,66,33))
Data Visualisation
Data Visualisation 微盘


lm(df157$close~seq(nrow(df157))) 
lm(df157$close~seq(nrow(df157)),weights = df157$vol)


export(plot_ly(economics, x = ~date, y = ~pce))
export(plot_ly(economics, x = ~date, y = ~pce), "plot.pdf")
