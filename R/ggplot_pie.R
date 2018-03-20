#数据

values=c(888672, 130436, 243200, 3680578, 263503,162848,61548,123663,14241)

#对应标签

labels=c("A","C","B","D","E","F","G","H","I")

#自定义对应颜色显示，这里我自己选用的是circos set3-9配色方案，没有使用ggplot配置的

colours=c("#8dd3c7", "#ffffb3", "#bebada", "#80b1d3", "#fb8072", "#fdb462", "#b3de69", "#d9d9d9", "#fccde5")

#每个数据折算为百分比后的数值（已经带上%号）

percent_str <- paste(round(values/sum(values) * 100,1), "%", sep="")

#建立名为values的matrix

values <- data.frame(Percentage = round(values/sum(values) * 100,1), Type = labels,percent=percent_str )

#绘图第一步，得figure2

pie <- ggplot(values, aes(x = "" ,y = Percentage, fill = Type)) +  geom_bar(width = 3) 

#可以理解为图形扭曲为圆形，从而完成终产品figure1

pie = pie + coord_polar("y")

#清空坐标名优化，并给图注填上题目为“Types”。

pie = pie + xlab('') + ylab('') + labs(fill="Types")

#按指定顺序添加图注并按照你设定的颜色上色

#pie + scale_fill_manual(values = colours) 

#只会得到figure， 图注里是按照字母表顺序排序而非事先指定顺序，这样明显图注与实际情况有严重出入，如figure3

#应该如下行添加labels这列参数

pie + scale_fill_manual(values = colours,labels = labels)




################################

df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)
  )
head(df)

##    group value
## 1   Male    25
## 2 Female    25
## 3  Child    50

# Use a barplot to visualize the data :

library(ggplot2)
# Barplot
bp<- ggplot(df, aes(x="", y=value, fill=group))+
geom_bar(width = 1, stat = "identity")
bp

# ggplot2 pie chart for data visualization in R software

# Create a pie chart :

pie <- bp + coord_polar("y", start=0)
pie

# ggplot2 pie chart for data visualization in R software

pie + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

# use brewer color palettes
pie + scale_fill_brewer(palette="Dark2")
# Use grey scale
pie + scale_fill_grey() + theme_minimal()

ggplot(PlantGrowth, aes(x=factor(1), fill=group))+
  geom_bar(width = 1)+
  coord_polar("y")



  blank_theme <- theme_minimal()+
  theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.border = element_blank(),
  panel.grid=element_blank(),
  axis.ticks = element_blank(),
  plot.title=element_text(size=14, face="bold")
  )

  # Apply blank theme
library(scales)
pie + scale_fill_grey() +  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
            label = percent(value/100)), size=5)

  # Use brewer palette
pie + scale_fill_brewer("Blues") + blank_theme +
  theme(axis.text.x=element_blank())+
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)