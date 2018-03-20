require(ggplot2)
require(grid)
#####现将图画好，并且赋值变量，储存#####
a <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) + geom_point()
b <- ggplot(diamonds, aes(carat, depth, colour = color)) + geom_point()
c <- ggplot(diamonds, aes(carat, depth, colour = color)) + geom_point() + 
  facet_grid(.~color,scale = "free") 

########新建画图页面###########
grid.newpage()  ##新建页面
pushViewport(viewport(layout = grid.layout(2,2))) ####将页面分成2*2矩阵
vplayout <- function(x,y){
  viewport(layout.pos.row = x, layout.pos.col = y)
}
print(c, vp = vplayout(1,1:2))   ###将（1,1)和(1,2)的位置画图c
print(b, vp = vplayout(2,1))   ###将(2,1)的位置画图b
print(a, vp = vplayout(2,2))  ###将（2,2)的位置画图a
#dev.off() ##画下一幅图，记得关闭窗口