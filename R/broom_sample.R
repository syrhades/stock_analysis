library(ggplot2)
data(mtcars)
ggplot(mtcars, aes(mpg, wt)) + geom_point()
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))
summary(nlsfit)
ggplot(mtcars, aes(wt, mpg)) + geom_point() + geom_line(aes(y=predict(nlsfit)))



set.seed(2014)
centers <- data.frame(cluster=factor(1:3), size=c(100, 150, 50), x1=c(5, 0, -3), x2=c(-1, 1, -2))
points <- centers %>% group_by(cluster) %>%
    do(data.frame(x1=rnorm(.$size[1], .$x1[1]),
                  x2=rnorm(.$size[1], .$x2[1])))


library(ggplot2)
ggplot(points, aes(x1, x2, color=cluster)) + geom_point()


points.matrix <- cbind(x1 = points$x1, x2 = points$x2)
kclust <- kmeans(points.matrix, 3)
kclust

ggplot(faithful,aes(x=eruptions,y=waiting))+
geom_point()+
stat_density2d(aes(alpha = ..density..),geom = "raster",contour = FALSE)


p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
p + labs(title = "New plot title")
p + labs(x = "New x label")
p + xlab("New x label")
p + ylab("New y label")
p + ggtitle("New plot title")

