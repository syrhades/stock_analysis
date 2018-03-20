    
library(pryr)

# define in a style like C++  
    setClass("Shape",slots=list(name="character",shape="character"),prototype=list(name=character(0)))  
      
    setClass("Eclipse",contains="Shape",slots=list(radius="numeric"),  
             prototype=list(radius=c(1,1),shape="Eclipse"))  
      
    setClass("Circle",contains="Eclipse",slots=list(radius="numeric"), # overwrite "radius" in Eclipse  
             prototype=list(radius=1,shape="Circle"))  
      
      
    # 验证radius参数  
    setValidity("Eclipse",  
                function(obj)  
                {  
                  if(length(obj@radius)!=2) stop("not valid radius for Ellipse");  
                  if(any(obj@radius<0)) stop("Radius is negative");    
                }  
               )  
      
    # 面积泛函接口  
    setGeneric("Area",  
               function(obj,...) standardGeneric("Area"))  
      
    # 面积泛函实现  
    setMethod("Area","Eclipse",  
              function(obj,radius)  
              {  
                cat("Ellipse Area :\n");  
                return(pi*prod(obj@radius));  
              }  
             )  
    setMethod("Area","Circle",  
              function(obj,radius)  
              {  
                cat("Circle Area：\n");  
                return(pi*obj@radius^2);  
              }  
             )  



    登录 | 注册

九茶
强者自强，厚积薄发

    目录视图
    摘要视图
    订阅

一键管理你的代码     攒课--我的学习我做主     【hot】直播技术精选    
R语言面向对象指南
标签： R语言面向对象S3S4RC
2015-09-21 21:53 1288人阅读 评论(0) 收藏 举报
分类：
R（16）

目录(?)[+]

原文链接：OO field guide 。


面向对象指南：

这一章主要介绍怎样识别和使用 R 语言的面向对象系统（以下简称 OO）。R 语言主要有三种 OO 系统（加上基本类型）。本指南的目的不是让你精通 R 语言的 OO，而是让你熟悉各种系统，并且能够准确地区分和使用它们。
OO 最核心的就是类和方法的思想，类在定义对象的行为时主要是通过对象的属性以及它和其它类之间的关系。根据类的输入不同，类对方法、函数的选择也会不同。类的建造是有层次结构的：如果一个方法在子类中不存在，则使用父类中的方法；如果存在则继承父类中方法。

三种 OO 系统在定义类和方法的时候有以下不同：

    S3 实现的是泛型函数式 OO ，这与大部分的编程语言不同，像 Java、C++ 和 C# 它们实现的是消息传递式的 OO 。如果是消息传递，消息（方法）是传给一个对象，再由对象去决定调用哪个方法的。通常调用方法的形式是“对象名.方法名”，例如：canvas.drawRect(“blue”) 。而 S3 不同，S3 调用哪个方法是由泛型函数决定的，例如：drawRect(canvas, “blue”)。S3 是一种非正式的 OO 模式，它甚至都没有正式定义类这个概念。
    S4 与 S3 很相似，但是比 S3 正规。S4 与 S3 的不同主要有两点：S4 对类有更加正式的定义（描述了每个类的表现形式和继承情况，并且对泛型和方法的定义添加了特殊的辅助函数）；S4 支持多调度（这意味着泛型函数在调用方法的时候可以选择多个参数）。
    Reference classes （引用类），简称 RC ，和 S3、S4有很大区别。RC 实现的是消息传递式 OO ，所以方法是属于类的，而不是函数。对象和方法之间用”$”隔开，所以调用方法的形式如：canvas$drawRect(“blue”) 。RC 对象也总是可变的，它用的不是 R 平常的 copy-on-modify 语义，而是做了部分修改。从而可以解决 S3、S4 难以解决的问题。

还有另外一种系统，虽然不是完全的面向对象，但还是有必要提一下：

    base types（基本类型），主要使用C语言代码来操作。它之所以重要是因为它能为其它 OO 系统提供构建块。

以下内容从基本类型开始，逐个介绍每种 OO 系统。你将学习到怎样识别一个对象是属于哪种 OO 系统、方法的调用和使用，以及在该 OO 系统下如何创建新的对象、类、泛型和方法。本章节的结尾也有讲述哪种情况应该使用哪种系统。
前提：

你首先需要安装 pryr 包来获取某些函数：install.packages(“pryr”) 。
问题：

你是否已经了解本文要讲述的内容？如果你能准确地回答出以下问题，则可以跳过本章节了。答案请见本文末尾的问题答案 。

    你怎样区分一个对象属于哪种 OO 系统？
    如何确定基本类型（如整型或者列表）的对象？
    什么是类的函数？
    S3 和 S4 之间的主要差异是什么？ S4 和 RC 之间最主要的差异又是什么？

文章梗概：

    基本类型
    S3
    S4
    RC
    模式的选择


基本类型：

基本上每个 R 对象都类似于描述内存存储的 C 语言结构体，这个结构体包含了对象的所有内容（包括内存管理需要的信息，还有对象的基本类型）。基本类型并不是真的对象系统，因为只有 R 语言的核心团队才能创建新的类型。但结果新的基本类型竟然也很少见地被添加了：最近是在2011年，添加了两个你从来没在 R 里面见过的奇异类型（NEWSXP 和 FREESXP），它们能够有效地诊断出内存上的问题。在此之前，2005年为 S4 对象添加了一个特殊的基本类型（S4SXP）。

Data structures 章节讲述了大部分普通的基本类型（原子向量和列表），但基本类型还包括 functions、environments，以及其它更加奇异的对象，如 names、calls、promises，之后你将会在本书中学到。你可以使用 typeof() 来了解对象的基本类型。但基本类型的名字在 R 中并不总是有效的，并且类型和 “is” 函数可能会使用不同的名字：

# The type of a function is "closure"
f <- function() {}
typeof(f)
#> [1] "closure"
is.function(f)
#> [1] TRUE

# The type of a primitive function is "builtin"
typeof(sum)
#> [1] "builtin"
is.primitive(sum)
#> [1] TRUE

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

你可能听过 mode() 和 storage.mode()，我建议不要使用这两个函数，因为它们只是 typeof() 返回值的别名，而且只使用与 S 语言。如果你想了解它们具体如何实现，可以去看一下它们的源代码。

不同基本类型的函数一般都是用 C 语言编写的，在调度时使用switch语句(例如：switch(TYPEOF(x)))。尽管你可能没有写过 C 语言，但理解基本类型仍然很有必要，因为其他系统都是在此基础上的：S3 对象可以建立在所有基本类型上，S4 使用一个特殊的基本类型，而 RC 对象是 S4 和 environments（一个特殊的基本类型）的结合体。查看对象是否是一个单纯基本类型（即它不同时含 S3、S4、RC 的行为），使用 is.object(x) ，返回TRUE/FALSSE。


S3:

S3 是 R 语言的第一种也是最简单的一种 OO 系统。它还是唯一一种在基础包和统计包使用的 OO 系统，CRAN包中最平常使用的 OO 系统。
识别对象、泛型函数、方法：

你遇到的大部分对象都是 S3 对象。但不幸的是在 R 中并没有可以简单检测一个方法是否是 S3 的方法。最接近的方法就是 is.object(x) & !isS4(x)，即它是一个对象，但不是 S4 对象。一个更简单的方法就是使用 pryr::otype() ：

library(pryr)

df <- data.frame(x = 1:10, y = letters[1:10])
otype(df)    # A data frame is an S3 class
#> [1] "S3"
otype(df$x)  # A numeric vector isn't
#> [1] "base"
otype(df$y)  # A factor is
#> [1] "S3"

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

在 S3，方法是属于函数的，这些函数叫做泛型函数，或简称泛型。S3 的方法不属于对象或者类。这和大部分的编程语言都不同，但它确实是一种合法的 OO 方式。

你可以调用 UseMethod() 方法来查看某个函数的源代码，从而确定它是否是 S3 泛型。和 otype() 类似，prpy 也提供了 ftype() 来联系着一个函数（如果有的话）描述对象系统。

mean
#> function (x, ...) 
#> UseMethod("mean")
#> <bytecode: 0x24bfa50>
#> <environment: namespace:base>
ftype(mean)
#> [1] "s3"      "generic"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

有些 S3 泛型，例如 [ 、sum()、cbind()，不能调用 UseMethod()，因为它们是用 C 语言来执行的。不过它们可以调用 C 语言的函数 DispatchGroup() 和 DispatchOrEval()。利用 C 代码进行方法调用的函数叫作内部泛型。可以使用 ?”internal generic” 查看。

给定一个类，S3 泛型的工作是调用正确的 S3 方法。你可以通过 S3 方法的名字来识别（形如 generic.class()）。例如，泛型 mean() 的 Date 方法为 mean.Date()，泛型print() 的向量方法为 print.factor() 。
这也就是为什么现代风格不鼓励在函数名字里使用 “.” 的原因了。类的名字也不使用 “.” 。pryr::ftype() 可以发现这些异常，所以你可以用它来识别一个函数是 S3 方法还是泛型：

ftype(t.data.frame) # data frame method for t()
#> [1] "s3"     "method"
ftype(t.test)       # generic function for t tests
#> [1] "s3"      "generic"

    1
    2
    3
    4

    1
    2
    3
    4

你可以调用 methods() 来查看属于某个泛型的所有方法：

methods("mean")
#> [1] mean.Date     mean.default  mean.difftime mean.POSIXct  mean.POSIXlt 
#> see '?methods' for accessing help and source code
methods("t.test")
#> [1] t.test.default* t.test.formula*
#> see '?methods' for accessing help and source code

    1
    2
    3
    4
    5
    6

    1
    2
    3
    4
    5
    6

（除了在基础包里面定义的一些方法，大多数 S3 的方法都是不可见的使用 getS3method() 来阅读它们的源码。）

你也可以列出一个给出类中包含某个方法的所有泛型：

methods(class = "ts")
#>  [1] aggregate     as.data.frame cbind         coerce        cycle        
#>  [6] diffinv       diff          initialize    kernapply     lines        
#> [11] Math2         Math          monthplot     na.omit       Ops          
#> [16] plot          print         show          slotsFromS3   time         
#> [21] [<-           [             t             window<-      window       
#> see '?methods' for accessing help and source code

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

你也可以从接下来的部分知道，要列出所有的 S3 类是不可能的。
定义类和创建对象：

S3 是一个简单而特殊的系统，它对类没有正式的定义。要实例化一个类，你只能拿一个已有的基础对象，再设置类的属性。你可以在创建类的时候使用 structure()，或者事后用 class<-()：

# Create and assign class in one step
foo <- structure(list(), class = "foo")

# Create, then set class
foo <- list()
class(foo) <- "foo"

    1
    2
    3
    4
    5
    6

    1
    2
    3
    4
    5
    6

S3 对象的属性通常建立在列表或者原子向量之上（你可以用这个属性去刷新你的内存属性），你也能把函数转成 S3 对象，其他基本类型要么在 R 中很少见，要么就是该语义不能很好地在属性下运行。
你可以通过 class() 把类看作任意的对象，也可以通过 inherits(x, “classname”) 来查看某个对象是否继承自某个具体的类。

class(foo)
#> [1] "foo"
inherits(foo, "foo")
#> [1] TRUE

    1
    2
    3
    4

    1
    2
    3
    4

S3 对象所属于的类可以被看成是一个向量，一个通过最重要的特性来描述对象行为的向量。例如对象 glm() 的类是 c(“glm”, “lm”)，它表明着广义线性模型的行为继承自线性模型。类名通常是小写的，并且应该避免使用 “.” 。否则该类名将会混淆为下划线形式的 my_class，或者 CamelCase 写法的 MyClass。

大多数的 S3 类都提供了构造函数：

foo <- function(x) {
  if (!is.numeric(x)) stop("X must be numeric")
  structure(list(x), class = "foo")
}

    1
    2
    3
    4

    1
    2
    3
    4

如果它是可用的，则你应该使用它（例如 factor() 和 data.frame()）。这能确保你在创造类的时候使用正确的组件。构造函数的名字一般是和类名是相同的。

开发者提供了构造函数之后，S3 并没有对它的正确性做检查。这意味着你可以改变现有对象所属于的类：

# Create a linear model
mod <- lm(log(mpg) ~ log(disp), data = mtcars)
class(mod)
#> [1] "lm"
print(mod)
#> 
#> Call:
#> lm(formula = log(mpg) ~ log(disp), data = mtcars)
#> 
#> Coefficients:
#> (Intercept)    log(disp)  
#>      5.3810      -0.4586

# Turn it into a data frame (?!)
class(mod) <- "data.frame"
# But unsurprisingly this doesn't work very well
print(mod)
#>  [1] coefficients  residuals     effects       rank          fitted.values
#>  [6] assign        qr            df.residual   xlevels       call         
#> [11] terms         model        
#> <0 rows> (or 0-length row.names)
# However, the data is still there
mod$coefficients
#> (Intercept)   log(disp) 
#>   5.3809725  -0.4585683

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

如果你在之前使用过其他的 OO 语言，S3 可能会让你觉得很恶心。但令人惊讶的是，这种灵活性带来的问题很少：虽然你能改变对象的类型，但你并不会这么做。R 并不用提防自己：你可以很容易射自己的脚，只要你不把抢瞄在你的脚上并扣动扳机，你就不会有问题。
创建新的方法和泛型：

如果要添加一个新的泛型，你只要创建一个叫做 UseMethod() 的函数。UseMethod() 有两个参数：泛型函数的名字和用来调度方法的参数。如果第二个参数省略了，则根据第一个参数来调度方法。但是没有必要去省略 UseMethod() 的参数，你也不应该这么做。

f <- function(x) UseMethod("f")

    1

    1

没有方法的泛型是没有用的。如果要添加方法，你只需要用 generic.class 创建一个合法的函数：

f.a <- function(x) "Class a"

a <- structure(list(), class = "a")
class(a)
#> [1] "a"
f(a)
#> [1] "Class a"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

用同样的方法可以对已有的泛型添加方法：

mean.a <- function(x) "a"
mean(a)
#> [1] "a"

    1
    2
    3

    1
    2
    3

如你所看到的，它并没有确保类和泛型兼容的检查机制，它主要是靠编程者自己来确定自己的方法不会违反现有代码的期望。
方法调度：

S3 的方法调度比较简单。UseMethod() 创建一个向量或者一个函数名字（例如：paste0(“generic”, “.”, c(class(x), “default”))），并逐个查找。default 类作为回落的方法，以防其他未知类的情况。

f <- function(x) UseMethod("f")
f.a <- function(x) "Class a"
f.default <- function(x) "Unknown class"

f(structure(list(), class = "a"))
#> [1] "Class a"
# No method for b class, so uses method for a class
f(structure(list(), class = c("b", "a")))
#> [1] "Class a"
# No method for c class, so falls back to default
f(structure(list(), class = "c"))
#> [1] "Unknown class"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

组泛型方法增加了一些复杂性，组泛型为一个函数实现复合泛型的多个方法提供了可能性。它们包含的四组泛型和函数如下：

    Math: abs, sign, sqrt, floor, cos, sin, log, exp, …
    Ops: +, -, *, /, ^, %%, %/%, &, |, !, ==, !=, <, <=, >=, >
    Summary: all, any, sum, prod, min, max, range
    Complex: Arg, Conj, Im, Mod, Re

组泛型是相对比较先进的技术，超出了本章的范围。但是你可以通过 ?groupGeneric 查看更多相关信息。区分组泛型最关键的是要意识到 Math、Ops、Summary 和 Complex 并不是真正的函数，而是代表着函数。注意在组泛型中有特殊的变量 .Generic 提供实际的泛型函数调用。

如果你有复数类模板的层次结构，那么调用“父”方法是有用的。要准确定义它的意义的话有点难度，但如果当前方法不存在的话它基本上都会被调用。同样的，你可以使用 ?NextMethod 查看相关信息。

因为方法是正规的 R 函数，所以你可以直接调用它：

c <- structure(list(), class = "c")
# Call the correct method:
f.default(c)
#> [1] "Unknown class"
# Force R to call the wrong method:
f.a(c)
#> [1] "Class a"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

不过这种调用的方法和改变对象的类属性一样危险，所以一般都不这样做。不要把上膛了的枪瞄在自己的脚上。使用上述方法的唯一原因是它可以通过跳过方法调用达到很大的性能改进，你可以查看性能章节查看详情。

非 S3 对象也可以调用 S3 泛型，非内部的泛型会调用基本类型的隐式类。（因为性能上的原因，内部的泛型并不会这样做。）确定基本类型的隐式类有点难，如下面的函数所示：

iclass <- function(x) {
  if (is.object(x)) {
    stop("x is not a primitive type", call. = FALSE)
  }

  c(
    if (is.matrix(x)) "matrix",
    if (is.array(x) && !is.matrix(x)) "array",
    if (is.double(x)) "double",
    if (is.integer(x)) "integer",
    mode(x)
  )
}
iclass(matrix(1:5))
#> [1] "matrix"  "integer" "numeric"
iclass(array(1.5))
#> [1] "array"   "double"  "numeric"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17

练习：

    查阅 t() 和 t.test() 的源代码，并证明 t.test() 是一个 S3 泛型而不是 S3 方法。如果你用 test 类创建一个对象并用它调用 t() 会发生什么？
    在 R 语言的基本类型中什么类有 Math 组泛型？查阅源代码，该方法是如何工作的？
    R 语言在日期时间上有两种类，POSIXct 和 POSIXlt（两者都继承自 POSIXt）。哪些泛型对于这两个类是有不同行为的？哪个泛型共享相同的行为？
    哪个基本泛型定义的方法最多？
    UseMethod() 通过特殊的方式调用方法。请预测下列代码将会返回什么，然后运行一下，并且查看 UseMethod() 的帮助文档，推测一下发生了什么。用最简单的方式记下这些规则。

y <-1
g <-function(x) {
  y <-2UseMethod("g")
}
g.numeric <-function(x) y
g(10)

h <-function(x) {
  x <-10UseMethod("h")
}
h.character <-function(x) paste("char", x)
h.numeric <-function(x) paste("num", x)

h("a")

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14

    内部泛型不分配在基类类型的隐式类。仔细查阅 ?”internal generic”，为什么下面例子中的 f 和 g 的长度不一样？哪个函数可以区分 f 和 g 的行为？

f <- function() 1
g <- function() 2
class(g) <- "function"

class(f)
class(g)

length.function <- function(x) "function"
length(f)
length(g)

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10


S4：

S4 工作的方式和 S3 比较相似，但它更加正式和严谨。方法还是属于函数，而不是类。但是：

    类在描述字段和继承结构（父类）上有更加正式的定义。
    方法调用可以传递多个参数，而不仅仅是一个。
    出现了一个特殊的运算符——@，从 S4 对象中提取 slots（又名字段）。

所以 S4 的相关代码都存储在 methods 包里面。当你交互运行 R 程序的时候这个包都是可用的，但在批处理的模式下则可能不可用。所以，我们在使用 S4 的时候一般直接使用 library(methods) 。
S4 是一种丰富、复杂的系统，并不是一两页纸能解释完的。所以在此我把重点放在 S4 背后的面向对象思想，这样大家就可以比较好地使用 S4 对象了。如果想要了解更多，可以参考以下文献：

    S4 系统在 Bioconductor 中的发展历程
    John Chambers 写的《Software for Data Analysis》
    Martin Morgan 在 stackoverflow 上关于 S4 问题的回答

识别对象、泛型函数和方法：

要识别 S4 对象 、泛型、方法还是很简单的。对于 S4 对象：str() 将它描述成一个正式的类，isS4() 会返回 TRUE，prpy::otype() 会返回 “S4” 。对于 S4 泛型函数：它们是带有很好类定义的 S4 对象。
常用的基础包里面是没有 S4 对象的（stats, graphics, utils, datasets, 和 base），所以我们要从内建的 stats4 包新建一个 S4 对象开始，它提供了一些 S4 类和方法与最大似然估计：

library(stats4)

# From example(mle)
y <- c(26, 17, 13, 12, 20, 5, 9, 8, 5, 4, 8)
nLL <- function(lambda) - sum(dpois(y, lambda, log = TRUE))
fit <- mle(nLL, start = list(lambda = 5), nobs = length(y))

# An S4 object
isS4(fit)
#> [1] TRUE
otype(fit)
#> [1] "S4"

# An S4 generic
isS4(nobs)
#> [1] TRUE
ftype(nobs)
#> [1] "s4"      "generic"

# Retrieve an S4 method, described later
mle_nobs <- method_from_call(nobs(fit))
isS4(mle_nobs)
#> [1] TRUE
ftype(mle_nobs)
#> [1] "s4"     "method"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

用带有一个参数的 is() 来列出对象继承的所有父类。用带有两个参数的 is() 来验证一个对象是否继承自该类：

is(fit)
#> [1] "mle"
is(fit, "mle")
#> [1] TRUE

    1
    2
    3
    4

    1
    2
    3
    4

你可以使用 getGenerics() 来获取 S4 的所有泛型函数，或者使用 getClasses() 来获取 S4 的所有类。这些类包括 S3 对 shim classes 和基本类型。另外你可以使用 showMethods() 来获取 S4 的所有方法。
定义类和新建对象

在 S3，你可以通过更改类的属性就可以改变任意一个对象，但是在 S4 要求比较严格：你必须使用 setClass() 定义类的声明，并且用 new() 新建一个对象。你可以用特殊的语法 class?className（例如：class?mle）找到该类的相关文档。
S4 类有三个主要的特性：

    名字：一个字母-数字的类标识符。按照惯例，S4 类名称使用 UpperCamelCase 。
    已命名的 slots（字段），它用来定义字段名称和允许类。例如，一个 person 类可能由字符型的名称和数字型的年龄所表征：list(name = "character", age = "numeric")。
    父类。你可以给出多重继承的多个类，但这项先进的技能增加了它的复杂性。

在slots和contains，你可以使用setOldClass()来注册新的 S3 或 S4 类，或者基本类型的隐式类。在slots，你可以使用特殊的ANY类，它不限制输入。
S4 类有像 validity 方法的可选属性，validity 方法可以检验一个对象是否是有效的，是否是定义了默认字段值的 prototype 对象。使用?setClass查看更多细节。
下面的例子新建了一个具有 name 字段和 age 字段的 Person 类，还有继承自 Person 类的 Employee 类。Employee 类从 Person 类继承字段和方法，并且增加了字段 boss 。我们调用 new() 方法和类的名字，还有name-values这样成对的参数值来新建一个对象。

setClass("Person",
  slots = list(name = "character", age = "numeric"))
setClass("Employee",
  slots = list(boss = "Person"),
  contains = "Person")

alice <- new("Person", name = "Alice", age = 40)
john <- new("Employee", name = "John", age = 20, boss = alice)

    1
    2
    3
    4
    5
    6
    7
    8

    1
    2
    3
    4
    5
    6
    7
    8

大部分 S4 类都有一个和类名相同名字的构造函数：如果有，可以直接用它来取代 new() 。
要访问 S4 对象的字段，可以用 @ 或者 slot() ：

alice@age
#> [1] 40
slot(john, "boss")
#> An object of class "Person"
#> Slot "name":
#> [1] "Alice"
#> 
#> Slot "age":
#> [1] 40

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

（@ 和 $ 等价，slot() 和 [] 等价）
如果一个 S4 对象继承自 S3 类或者基本类型，它会有特殊的属性 .Data：

setClass("RangedNumeric",
  contains = "numeric",
  slots = list(min = "numeric", max = "numeric"))
rn <- new("RangedNumeric", 1:10, min = 1, max = 10)
rn@min
#> [1] 1
rn@.Data
#>  [1]  1  2  3  4  5  6  7  8  9 10

    1
    2
    3
    4
    5
    6
    7
    8

    1
    2
    3
    4
    5
    6
    7
    8

因为 R 是响应式编程的语言，所以它可以随时创建新的类或者重新定义现有类。这将会造成一个问题：当你在响应式地调试 S4 的时候，如果你更改了一个类，你要知道你已经把该类的所有对象都更改了。
新建方法和泛型函数

S4 提供了特殊的函数来新建方法和泛型。setGeneric() 将产生一个新的泛型，或者把已有函数转成泛型。

setGeneric("union")
#> [1] "union"
setMethod("union",
  c(x = "data.frame", y = "data.frame"),
  function(x, y) {
    unique(rbind(x, y))
  }
)
#> [1] "union"

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

如果你要重新创建了一个泛型，你需要调用 standardGeneric() :

setGeneric("myGeneric", function(x) {
  standardGeneric("myGeneric")
})
#> [1] "myGeneric"

    1
    2
    3
    4

    1
    2
    3
    4

S4 中的 standardGeneric() 相当于 UseMethod() 。


测试的答案

    要确定一个对象属于哪种面向对象系统，你可以用排除法，如果 !is.object(x) 返回 TRUE，那么它是一个基本对象。如果 !isS4(x) 返回 TRUE，那么它是一个 S3 。如果 !is(x, "refClass") 返回 TRUE， 那么它是一个 S4 ，否则它是 RC 。
    用 typeof() 来确定基本类型的对象。
    泛型函数调用特殊方法的时候主要是通过它的参数输入来确定的，在 S3 和 S4 系统，方法属于泛型函数，不像其他编程语言那样属于类。
    S4 比 S3 更加正式，并且支持多重继承和多重调度，RC 对象的语义和方法是属于类的，而不属于函数。

顶
    0

踩
    0

 
 

    上一篇
    R::shiny 点击事件-Demo
    下一篇
    傅里叶分析之掐死教程（完整版）

我的同类文章
R（16）

    •R语言零碎知识集合2015-09-22阅读663
    •R语言——哈希表2015-08-21阅读1261
    •ggplot2——玫瑰图2015-08-13阅读723
    •ggplot2——坐标系篇2015-08-13阅读3915
    •R语言的各种报错及其解决方法2015-08-06阅读1143

    •R::shiny 点击事件-Demo2015-09-09阅读692
    •免安装Oracle连接数据库（odbc驱动）2015-08-14阅读668
    •ggplot2——饼图篇2015-08-13阅读1583
    •R——颜色篇2015-08-11阅读588
    •ggplot2——图例篇2015-08-06阅读1846

更多文章
参考知识库

img
    Java EE知识库

    1179关注|581收录

img
    Java SE知识库

    9437关注|454收录

img
    Java Web知识库

    9738关注|1042收录

猜你在找
    基于PHP面向对象的自定义MVC框架高级项目开发
    c++面向对象前言及意见征集（来者不拒）视频课程
    疯狂IOS讲义之Objective-C面向对象设计
    javaScript-高级面向对象视频教程
    秒学面向对象视频课程（C++高级实践篇）视频课程（50课时）
    转换指南 将程序从托管扩展 C++ 迁移到 C++CLI
    转换指南 将程序从托管扩展 C++ 迁移到 C++CLI
    转换指南 将程序从托管C++扩展迁移到C++CLI
    转换指南 将程序从托管C++扩展迁移到C++CLI
    30分钟--Spark快速入门指南

查看评论

  暂无评论

您还没有登录,请[登录]或[注册]
* 以上用户言论只代表其个人观点，不代表CSDN网站的观点或立场
核心技术类目
全部主题 Hadoop AWS 移动游戏 Java Android iOS Swift 智能硬件 Docker OpenStack VPN Spark ERP IE10 Eclipse CRM JavaScript 数据库 Ubuntu NFC WAP jQuery BI HTML5 Spring Apache .NET API HTML SDK IIS Fedora XML LBS Unity Splashtop UML components Windows Mobile Rails QEMU KDE Cassandra CloudStack FTC coremail OPhone CouchBase 云计算 iOS6 Rackspace Web App SpringSide Maemo Compuware 大数据 aptech Perl Tornado Ruby Hibernate ThinkPHP HBase Pure Solr Angular Cloud Foundry Redis Scala Django Bootstrap

    个人资料

    [访问我的空间]
    九茶
    4 1
        访问：110786次
        积分：1947
        等级：
        排名：第14560名
        原创：67篇
        转载：2篇
        译文：1篇
        评论：118条

    文章搜索

    博客专栏

    	Python爬虫

    文章：14篇
    阅读：27213
    	小算法大本营

    文章：20篇
    阅读：40941
    	R语言

    文章：17篇
    阅读：21291

    文章分类

    R(17)
    SAS(2)
    数学(6)
    算法(22)
    爬虫(11)
    生活(6)
    python(22)
    数据库(2)
    数据挖掘(14)
    草稿记录(2)
    逼格修炼之道(6)

    文章存档



推酷

    文章
    站点
    主题
    活动
    公开课
    APP 荐
    周刊

    登录

R语言基于S4的面向对象编程
时间 2014-04-10 12:59:24 粉丝日志
原文
  http://blog.fens.me/r-class-s4/
主题 R语言 面向对象编程

R的极客理想系列文章，涵盖了R的思想，使用，工具，创新等的一系列要点，以我个人的学习和体验去诠释R的强大。

R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。

要成为有理想的极客，我们不能停留在语法上，要掌握牢固的数学，概率，统计知识，同时还要有创新精神，把R语言发挥到各个领域。让我们一起动起来吧，开始R的极客理想。
关于作者：

    张丹(Conan), 程序员Java,R,PHP,Javascript
    weibo：@Conan_Z
    blog: http://blog.fens.me
    email: bsspirit@gmail.com

转载请注明出处：
http://blog.fens.me/r-class-s4/

前言

本文接上一篇文章 R语言基于S3的面向对象编程 ，本文继续介绍R语言基于S4的面向对象编程。

S4对象系统具有明显的结构化特征，更适合面向对象的程序设计。Bioconductor社区，以S4对象系统做为基础架构，只接受符合S4定义的R包。
目录

    S4对象介绍
    创建S4对象
    访问对象的属性
    S4的泛型函数
    查看S4对象的函数
    S4对象的使用

1 S4对象介绍

S4对象系统是一种标准的R语言面向对象实现方式，S4对象有明确的类定义，参数定义，参数检查，继承关系，实例化等的面向对象系统的特征。
2 创建S4对象

本文的系统环境

    Linux: Ubuntu Server 12.04.2 LTS 64bit
    R: 3.0.1 x86_64-pc-linux-gnu

为了方便我们检查对象的类型，引入pryr包作为辅助工具。关于pryr包的介绍，请参考文章:[撬动R内核的高级工具包pryr](http://blog.fens.me/r-pryr/)


# 加载pryr包
> library(pryr)

2.1 如何创建S4对象？

由于S4对象是标准的面向对象实现方式， 有专门的类定义函数 setClass() 和类的实例化函数new() ，我们看一下setClass()和new()是如何动作的。

2.1.1 setClass()

查看setClass的函数定义


setClass(Class, representation, prototype, contains=character(),
          validity, access, where, version, sealed, package,
          S3methods = FALSE, slots)

参数列表：

    Class: 定义类名
    slots: 定义属性和属性类型
    prototype: 定义属性的默认值
    contains=character(): 定义父类，继承关系
    validity: 定义属性的类型检查
    where: 定义存储空间
    sealed: 如果设置TRUE，则同名类不能被再次定义
    package: 定义所属的包
    S3methods: R3.0.0以后不建议使用
    representation R3.0.0以后不建议使用
    access R3.0.0以后不建议使用
    version R3.0.0以后不建议使用

2.2 创建一个S4对象实例


# 定义一个S4对象
> setClass("Person",slots=list(name="character",age="numeric"))

# 实例化一个Person对象
> father<-new("Person",name="F",age=44)

# 查看father对象，有两个属性name和age
> father
An object of class "Person"
Slot "name":
[1] "F"

Slot "age":
[1] 44

# 查看father对象类型，为Person
> class(father)
[1] "Person"
attr(,"package")
[1] ".GlobalEnv"

# 查看father对象为S4的对象
> otype(father)
[1] "S4"

2.3 创建一个有继承关系的S4对象


# 创建一个S4对象Person
> setClass("Person",slots=list(name="character",age="numeric"))

# 创建Person的子类
> setClass("Son",slots=list(father="Person",mother="Person"),contains="Person")

# 实例化Person对象
> father<-new("Person",name="F",age=44)
> mother<-new("Person",name="M",age=39)

# 实例化一个Son对象
> son<-new("Son",name="S",age=16,father=father,mother=mother)

# 查看son对象的name属性
> son@name
[1] "S"

# 查看son对象的age属性
> son@age
[1] 16

# 查看son对象的father属性
> son@father
An object of class "Person"
Slot "name":
[1] "F"

Slot "age":
[1] 44

# 查看son对象的mother属性
> slot(son,"mother")
An object of class "Person"
Slot "name":
[1] "M"

Slot "age":
[1] 39

# 检查son类型
> otype(son)
[1] "S4"

# 检查son@name属性类型
> otype(son@name)
[1] "primitive"

# 检查son@mother属性类型
> otype(son@mother)
[1] "S4"

# 用isS4()，检查S4对象的类型
> isS4(son)
[1] TRUE
> isS4(son@name)
[1] FALSE
> isS4(son@mother)
[1] TRUE

2.4 S4对象的默认值


> setClass("Person",slots=list(name="character",age="numeric"))

# 属性age为空
> a<-new("Person",name="a")
> a
An object of class "Person"
Slot "name":
[1] "a"

Slot "age":
numeric(0)

# 设置属性age的默认值20
> setClass("Person",slots=list(name="character",age="numeric"),prototype = list(age = 20))

# 属性age为空
> b<-new("Person",name="b")

# 属性age的默认值是20
> b
An object of class "Person"
Slot "name":
[1] "b"

Slot "age":
[1] 20

2.5 S4对象的类型检查


> setClass("Person",slots=list(name="character",age="numeric"))

# 传入错误的age类型
> bad<-new("Person",name="bad",age="abc")
Error in validObject(.Object) :
  invalid class “Person” object: invalid object for slot "age" in class "Person": got class "character", should be or extend class "numeric"

# 设置age的非负检查
> setValidity("Person",function(object) {
+     if (object@age <= 0) stop("Age is negative.")
+ })
Class "Person" [in ".GlobalEnv"]

Slots:
Name:       name       age
Class: character   numeric

# 修传入小于0的年龄
> bad2<-new("Person",name="bad",age=-1)
Error in validityMethod(object) : Age is negative.

2.6 从一个已经实例化的对象中创建新对象

S4对象，还支持从一个已经实例化的对象中创建新对象，创建时可以覆盖旧对象的值


> setClass("Person",slots=list(name="character",age="numeric"))

# 创建一个对象实例n1
> n1<-new("Person",name="n1",age=19);n1
An object of class "Person"
Slot "name":
[1] "n1"

Slot "age":
[1] 19

# 从实例n1中，创建实例n2，并修改name的属性值
> n2<-initialize(n1,name="n2");n2
An object of class "Person"
Slot "name":
[1] "n2"

Slot "age":
[1] 19

3 访问对象的属性

在S3对象中，一般我使用$来访问一个对象的属性，但在S4对象中，我们只能使用@来访问一个对象的属性


> setClass("Person",slots=list(name="character",age="numeric"))
> a<-new("Person",name="a")

# 访问S4对象的属性
> a@name
[1] "a"
> slot(a, "name")
[1] "a"

# 错误的属性访问
> a$name
Error in a$name : $ operator not defined for this S4 class
> a[1]
Error in a[1] : object of type 'S4' is not subsettable
> a[[1]]
Error in a[[1]] : this S4 class is not subsettable

4 S4的泛型函数

S4的泛型函数实现有别于S3的实现，S4分离了方法的定义和实现，如在其他语言中我们常说的接口和实现分离。通过setGeneric()来定义接口，通过setMethod()来定义现实类。这样可以让S4对象系统，更符合面向对象的特征。

普通函数的定义和调用


> work<-function(x) cat(x, "is working")
> work('Conan')
Conan is working

让我来看看如何用R分离接口和现实


# 定义Person对象
> setClass("Person",slots=list(name="character",age="numeric"))

# 定义泛型函数work，即接口
> setGeneric("work",function(object) standardGeneric("work"))
[1] "work"

# 定义work的现实，并指定参数类型为Person对象
> setMethod("work", signature(object = "Person"), function(object) cat(object@name , "is working") )
[1] "work"

# 创建一个Person对象a
> a<-new("Person",name="Conan",age=16)

# 把对象a传入work函数
> work(a)
Conan is working

通过S4对象系统，把原来的函数定义和调用2步，为成了4步进行：

    定义数据对象类型
    定义接口函数
    定义实现函数
    把数据对象以参数传入到接口函数，执行实现函数

通过S4对象系统，是一个结构化的，完整的面向对象实现。
5 查看S4对象的函数

当我们使用S4对象进行面向对象封装后，我们还需要能查看到S4对象的定义和函数定义。

还以上节中Person和work的例子


# 检查work的类型
> ftype(work)
[1] "s4"      "generic"

# 直接查看work函数
> work
standardGeneric for "work" defined from package ".GlobalEnv"
function (object)
standardGeneric("work")
<environment: 0x2aa6b18>
Methods may be defined for arguments: object
Use  showMethods("work")  for currently available ones.

# 查看work函数的现实定义
> showMethods(work)
Function: work (package .GlobalEnv)
object="Person"

# 查看Person对象的work函数现实
> getMethod("work", "Person")
Method Definition:
function (object)
cat(object@name, "is working")
Signatures:
        object
target  "Person"
defined "Person"

> selectMethod("work", "Person")
Method Definition:
function (object)
cat(object@name, "is working")
Signatures:
        object
target  "Person"
defined "Person"

# 检查Person对象有没有work函数
>  existsMethod("work", "Person")
[1] TRUE
> hasMethod("work", "Person")
[1] TRUE

6 S4对象的使用

我们接下用S4对象做一个例子，定义一组图形函数的库。
6.1 任务一：定义图形库的数据结构和计算函数

假设最Shape为图形的基类，包括圆形(Circle)和椭圆形(Ellipse)，并计算出它们的面积(area)和周长(circum)。

    定义图形库的数据结构
    定义圆形的数据结构，并计算面积和周长
    定义椭圆形的数据结构，并计算面积和周长

如图所示结构：

定义基类Shape 和 圆形类Circle


# 定义基类Shape
> setClass("Shape",slots=list(name="character"))

# 定义圆形类Circle，继承Shape，属性radius默认值为1
> setClass("Circle",contains="Shape",slots=list(radius="numeric"),prototype=list(radius = 1))

# 验证radius属性值要大等于0
> setValidity("Circle",function(object) {
+     if (object@radius <= 0) stop("Radius is negative.")
+ })
Class "Circle" [in ".GlobalEnv"]
Slots:
Name:     radius      name
Class:   numeric character
Extends: "Shape"

# 创建两个圆形实例
> c1<-new("Circle",name="c1")
> c2<-new("Circle",name="c2",radius=5)

定义计算面积的接口和现实


# 计算面积泛型函数接口
> setGeneric("area",function(obj,...) standardGeneric("area"))
[1] "area"

# 计算面积的函数现实
> setMethod("area","Circle",function(obj,...){
+     print("Area Circle Method")
+     pi*obj@radius^2
+ })
[1] "area"

# 分别计算c1和c2的两个圆形的面积
> area(c1)
[1] "Area Circle Method"
[1] 3.141593
> area(c2)
[1] "Area Circle Method"
[1] 78.53982

定义计算周长的接口和现实


# 计算周长泛型函数接口
> setGeneric("circum",function(obj,...) standardGeneric("circum"))
[1] "circum"

# 计算周长的函数现实
> setMethod("circum","Circle",function(obj,...){
+     2*pi*obj@radius
+ })

# 分别计算c1和c2的两个圆形的面积
[1] "circum"
> circum(c1)
[1] 6.283185
> circum(c2)
[1] 31.41593

上面的代码，我们实现了圆形的定义，下来我们实现椭圆形。


# 定义椭圆形的类，继承Shape，radius参数默认值为c(1,1)，分别表示椭圆形的长半径和短半径
> setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1)))

# 验证radius参数
> setValidity("Ellipse",function(object) {
+     if (length(object@radius) != 2 ) stop("It's not Ellipse.")
+     if (length(which(object@radius<=0))>0) stop("Radius is negative.")
+ })
Class "Ellipse" [in ".GlobalEnv"]
Slots:
Name:     radius      name
Class:   numeric character
Extends: "Shape"

# 创建两个椭圆形实例e1,e2
> e1<-new("Ellipse",name="e1")
> e2<-new("Ellipse",name="e2",radius=c(5,1))

# 计算椭圆形面积的函数现实
> setMethod("area", "Ellipse",function(obj,...){
+     print("Area Ellipse Method")
+     pi * prod(obj@radius)
+ })
[1] "area"

# 计算e1,e2两个椭圆形的面积
> area(e1)
[1] "Area Ellipse Method"
[1] 3.141593
> area(e2)
[1] "Area Ellipse Method"
[1] 15.70796

# 计算椭圆形周长的函数现实
> setMethod("circum","Ellipse",function(obj,...){
+     cat("Ellipse Circum :\n")
+     2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
+ })
[1] "circum"

# 计算e1,e2两个椭圆形的周长
> circum(e1)
Ellipse Circum :
[1] 6.283185
> circum(e2)
Ellipse Circum :
[1] 22.65435

6.2 任务二：重构圆形和椭圆形的设计

上一步，我们已经完成了 圆形和椭圆形 的数据结构定义，以及计算面积和周长的方法现实。不知大家有没有发现，圆形是椭圆形的一个特例呢？

当椭圆形的长半径和短半径相等时，即radius的两个值相等，形成的图形为圆形。利用这个特点，我们就可以重新设计 圆形和椭圆形 的关系。椭圆形是圆形的父类，而圆形是椭圆形的子类。

如图所示结构：


# 基类Shape
> setClass("Shape",slots=list(name="character",shape="character"))

# Ellipse继承Shape
> setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1),shape="Ellipse"))

# Circle继承Ellipse
> setClass("Circle",contains="Ellipse",slots=list(radius="numeric"),prototype=list(radius = 1,shape="Circle"))

# 定义area接口
> setGeneric("area",function(obj,...) standardGeneric("area"))
[1] "area"

# 定义area的Ellipse实现
> setMethod("area","Ellipse",function(obj,...){
+     cat("Ellipse Area :\n")
+     pi * prod(obj@radius)
+ })
[1] "area"

# 定义area的Circle实现
> setMethod("area","Circle",function(obj,...){
+     cat("Circle Area :\n")
+     pi*obj@radius^2
+ })
[1] "area"

# 定义circum接口
> setGeneric("circum",function(obj,...) standardGeneric("circum"))
[1] "circum"

# 定义circum的Ellipse实现
> setMethod("circum","Ellipse",function(obj,...){
+     cat("Ellipse Circum :\n")
+     2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
+ })
[1] "circum"

# 定义circum的Circle实现
> setMethod("circum","Circle",function(obj,...){
+     cat("Circle Circum :\n")
+     2*pi*obj@radius
+ })
[1] "circum"

# 创建实例
> e1<-new("Ellipse",name="e1",radius=c(2,5))
> c1<-new("Circle",name="c1",radius=2)

# 计算椭圆形的面积和周长
> area(e1)
Ellipse Area :
[1] 31.41593
> circum(e1)
Ellipse Circum :
[1] 23.92566

# 计算圆形的面积和周长
> area(c1)
Circle Area :
[1] 12.56637
> circum(c1)
Circle Circum :
[1] 12.56637

我们重构后的结构，是不是会更合理呢！！
6.3 任务三：增加矩形的图形处理

我们的图形库，进一步扩充，需要加入矩形和正方形。

    定义矩形的数据结构，并计算面积和周长
    定义正方形的数据结构，并计算面积和周长
    正方形是矩形的特例，定义矩形是正方形的父类，而正方形是矩形的子类。

如图所示结构：


# 定义矩形Rectangle，继承Shape
> setClass("Rectangle",contains="Shape",slots=list(edges="numeric"),prototype=list(edges=c(1,1),shape="Rectangle"))

# 定义正方形Square，继承Rectangle
> setClass("Square",contains="Rectangle",slots=list(edges="numeric"),prototype=list(edges=1,shape="Square"))

# 定义area的Rectangle实现
> setMethod("area","Rectangle",function(obj,...){
+     cat("Rectangle Area :\n")
+     prod(obj@edges)
+ })
[1] "area"

# 定义area的Square实现
> setMethod("area","Square",function(obj,...){
+     cat("Square Area :\n")
+     obj@edges^2
+ })
[1] "area"

# 定义circum的Rectangle实现
> setMethod("circum","Rectangle",function(obj,...){
+     cat("Rectangle Circum :\n")
+     2*sum(obj@edges)
+ })
[1] "circum"

# 定义circum的Square实现
> setMethod("circum","Square",function(obj,...){
+     cat("Square Circum :\n")
+     4*obj@edges
+ })
[1] "circum"

# 创建实例
> r1<-new("Rectangle",name="r1",edges=c(2,5))
> s1<-new("Square",name="s1",edges=2)

# 计算矩形形的面积和周长
> area(r1)
Rectangle Area :
[1] 10
> area(s1)
Square Area :
[1] 4

# 计算正方形的面积和周长
> circum(r1)
Rectangle Circum :
[1] 14
> circum(s1)
Square Circum :
[1] 8

这样，我们的图形库，已经支持了4种图形了！用面向对象的结构来设计，是不是结构化思路很清晰呢！！
6.4 任务四：在基类Shape中，增加shape属性和getShape方法

接下来，要对图形库的所有图形，定义图形类型的变量shape，然后再提供一个getShape函数可以检查实例中的是shape变量。

这个需求，如果没有面向对象的结构，那么你需要在所有图形定义的代码中，都增加一个参数和一个判断，如果有100图形，改起来还是挺复杂的。而面向对象的程序设计，就非常容易解决这个需求。我们只需要在基类上改动代码就可以实现了。

如图所示结构：


# 重新定义基类Shape，增加shape属性
> setClass("Shape",slots=list(name="character",shape="character"))

# 定义getShape接口
> setGeneric("getShape",function(obj,...) standardGeneric("getShape"))
[1] "getShape"

# 定义getShape实现
> setMethod("getShape","Shape",function(obj,...){
+     cat(obj@shape,"\n")
+ })
[1] "getShape"

其实，这样改动一个就可以了，我们只需要重实例化每个图形的对象就行了。


# 实例化一个Square对象，并给shape属性赋值
> s1<-new("Square",name="s1",edges=2, shape="Square")

# 调用基类的getShape()函数
> getShape(r1)
Rectangle

是不是很容易的呢！在代码只在基类里修改了，所有的图形就有了对应的属性和方法。

如果我们再多做一步，可以修改每个对象的定义，增加shape属性的默认值。


setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1),shape="Ellipse"))
setClass("Circle",contains="Ellipse",slots=list(radius="numeric"),prototype=list(radius = 1,shape="Circle"))
setClass("Rectangle",contains="Shape",slots=list(edges="numeric"),prototype=list(edges=c(1,1),shape="Rectangle"))
setClass("Square",contains="Rectangle",slots=list(edges="numeric"),prototype=list(edges=1,shape="Square"))

再实例化对象时，属性shape会被自动赋值


# 实例化一个Square对象
> s1<-new("Square",name="s1",edges=2)

# 调用基类的getShape()函数
> getShape(r1)
Rectangle

下面是完整的R语言的代码实现：


setClass("Shape",slots=list(name="character",shape="character"))
setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1),shape="Ellipse"))
setClass("Circle",contains="Ellipse",slots=list(radius="numeric"),prototype=list(radius = 1,shape="Circle"))
setClass("Rectangle",contains="Shape",slots=list(edges="numeric"),prototype=list(edges=c(1,1),shape="Rectangle"))
setClass("Square",contains="Rectangle",slots=list(edges="numeric"),prototype=list(edges=1,shape="Square"))

setGeneric("getShape",function(obj,...) standardGeneric("getShape"))
setMethod("getShape","Shape",function(obj,...){
  cat(obj@shape,"\n")
})


setGeneric("area",function(obj,...) standardGeneric("area"))
setMethod("area","Ellipse",function(obj,...){
  cat("Ellipse Area :\n")
  pi * prod(obj@radius)
})
setMethod("area","Circle",function(obj,...){
  cat("Circle Area :\n")
  pi*obj@radius^2
})
setMethod("area","Rectangle",function(obj,...){
  cat("Rectangle Area :\n")
  prod(obj@edges)
})
setMethod("area","Square",function(obj,...){
  cat("Square Area :\n")
  obj@edges^2
})


setGeneric("circum",function(obj,...) standardGeneric("circum"))
setMethod("circum","Ellipse",function(obj,...){
  cat("Ellipse Circum :\n")
  2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
})
setMethod("circum","Circle",function(obj,...){
  cat("Circle Circum :\n")
  2*pi*obj@radius
})
setMethod("circum","Rectangle",function(obj,...){
  cat("Rectangle Circum :\n")
  2*sum(obj@edges)
})
setMethod("circum","Square",function(obj,...){
  cat("Square Circum :\n")
  4*obj@edges
})

e1<-new("Ellipse",name="e1",radius=c(2,5))
c1<-new("Circle",name="c1",radius=2)

r1<-new("Rectangle",name="r1",edges=c(2,5))
s1<-new("Square",name="s1",edges=2)

area(e1)
area(c1)
circum(e1)
circum(c1)

area(r1)
area(s1)
circum(r1)
circum(s1)

通过这个例子，我们全面地了解了R语言中面向对象的使用，和S4对象系统的面向对象程序设计！

在程序员的世界里，世间万物都可以抽象成对象。
分享
推荐文章

    1. Formidable Playbook: A practical guide to building modern appli..
    2. Why Is JavaScript the Programming Language of the Future?
    3. JavaScript Arrow Functions Introduction
    4. The Now CLI goes open-source!
    5. Improving the syntax of EJS templates
    6. List of professional JavaScript Data Grid (table) products

相关推刊

    by stasi009
    《默认推刊》
    19

我来评几句
登录后评论

已发表评论数(0)
相关站点
粉丝日志
＋订阅
热门文章

    1. Formidable Playbook: A practical guide to building modern applications
    2. Why Is JavaScript the Programming Language of the Future?
    3. JavaScript Arrow Functions Introduction
    4. Streams and Async Await in Nodejs
    5. Improving the syntax of EJS templates

网站相关
    关于我们 
    移动应用 
    建议反馈 

关注我们
    推酷网 
    tuicool2012 

友情链接
    人人都是产品经理 PM256 移动信息化 行晓网 智城外包网 虎嗅 IT耳朵 创媒工场 经理人分享 市场部网 砍柴网 CocoaChina 北风网 云智慧 我赢职场 大数据时代 奇笛网 咕噜网 红联linux Win10之家 鸟哥笔记 爱游戏 投资潮 31会议网 极光推送 Teambition 硅谷网 leangoo ZEALER中国 OpenSNS 小牛学堂 handone Scrum中文网 比戈大牛 又拍云 更多链接>>   





    2016年09月(1)
    2016年03月(6)
    2016年02月(5)
    2015年12月(4)
    2015年11月(1)
    展开

    阅读排行 

    马踏棋盘之贪心算法优化(8464)
    新浪微博爬虫分享（一天可抓取 1300 万条数据）(7738)
    QQ空间爬虫分享（一天可抓取 400 万条数据）(5832)
    ggplot2——坐标系篇(3919)
    八皇后之回溯法解决(3675)
    凸包问题的五种解法(3419)
    python实现二叉树和它的七种遍历(3206)
    生活灵感汇总(3164)
    资源分享(3128)
    python字典--知识点总结(3097)

    联系方式


    Tel : 13570233493

    新浪微博：路过

    LEFTER：
    http://zhubei.lofter.com/

    GitHub：
    https://github.com/liuxingming

    我的微信：

    爬虫交流群：

    爬虫交流群：
                   爬虫交流群

    全职爬虫工程师：
                   爬虫工程师-群 

    我的爬虫历史

    QQ空间、新浪微博、WooYun、Github、CSDN、博客园、域名与IP数据、SearchCode、大众点评、图吧网、证券投资数据、中国土地数据、某些政府网站等等。

    公司简介
    |
    招贤纳士
    |
    广告服务
    |
    银行汇款帐号
    |
    联系方式
    |
    版权声明
    |
    法律顾问
    |
    问题报告
    |
    合作伙伴
    |
    论坛反馈
    网站客服
    杂志客服
    微博客服
    webmaster@csdn.net
    400-600-2320|北京创新乐知信息技术有限公司 版权所有|江苏乐知网络技术有限公司 提供商务支持
    京 ICP 证 09002463 号|Copyright © 1999-2016, CSDN.NET, All Rights Reserved 
    GongshangLogo



    登录 | 注册

九茶
强者自强，厚积薄发

    目录视图
    摘要视图
    订阅

一键管理你的代码     攒课--我的学习我做主     【hot】直播技术精选    
R语言面向对象指南
标签： R语言面向对象S3S4RC
2015-09-21 21:53 1288人阅读 评论(0) 收藏 举报
分类：
R（16）

目录(?)[+]

原文链接：OO field guide 。


面向对象指南：

这一章主要介绍怎样识别和使用 R 语言的面向对象系统（以下简称 OO）。R 语言主要有三种 OO 系统（加上基本类型）。本指南的目的不是让你精通 R 语言的 OO，而是让你熟悉各种系统，并且能够准确地区分和使用它们。
OO 最核心的就是类和方法的思想，类在定义对象的行为时主要是通过对象的属性以及它和其它类之间的关系。根据类的输入不同，类对方法、函数的选择也会不同。类的建造是有层次结构的：如果一个方法在子类中不存在，则使用父类中的方法；如果存在则继承父类中方法。

三种 OO 系统在定义类和方法的时候有以下不同：

    S3 实现的是泛型函数式 OO ，这与大部分的编程语言不同，像 Java、C++ 和 C# 它们实现的是消息传递式的 OO 。如果是消息传递，消息（方法）是传给一个对象，再由对象去决定调用哪个方法的。通常调用方法的形式是“对象名.方法名”，例如：canvas.drawRect(“blue”) 。而 S3 不同，S3 调用哪个方法是由泛型函数决定的，例如：drawRect(canvas, “blue”)。S3 是一种非正式的 OO 模式，它甚至都没有正式定义类这个概念。
    S4 与 S3 很相似，但是比 S3 正规。S4 与 S3 的不同主要有两点：S4 对类有更加正式的定义（描述了每个类的表现形式和继承情况，并且对泛型和方法的定义添加了特殊的辅助函数）；S4 支持多调度（这意味着泛型函数在调用方法的时候可以选择多个参数）。
    Reference classes （引用类），简称 RC ，和 S3、S4有很大区别。RC 实现的是消息传递式 OO ，所以方法是属于类的，而不是函数。对象和方法之间用”$”隔开，所以调用方法的形式如：canvas$drawRect(“blue”) 。RC 对象也总是可变的，它用的不是 R 平常的 copy-on-modify 语义，而是做了部分修改。从而可以解决 S3、S4 难以解决的问题。

还有另外一种系统，虽然不是完全的面向对象，但还是有必要提一下：

    base types（基本类型），主要使用C语言代码来操作。它之所以重要是因为它能为其它 OO 系统提供构建块。

以下内容从基本类型开始，逐个介绍每种 OO 系统。你将学习到怎样识别一个对象是属于哪种 OO 系统、方法的调用和使用，以及在该 OO 系统下如何创建新的对象、类、泛型和方法。本章节的结尾也有讲述哪种情况应该使用哪种系统。
前提：

你首先需要安装 pryr 包来获取某些函数：install.packages(“pryr”) 。
问题：

你是否已经了解本文要讲述的内容？如果你能准确地回答出以下问题，则可以跳过本章节了。答案请见本文末尾的问题答案 。

    你怎样区分一个对象属于哪种 OO 系统？
    如何确定基本类型（如整型或者列表）的对象？
    什么是类的函数？
    S3 和 S4 之间的主要差异是什么？ S4 和 RC 之间最主要的差异又是什么？

文章梗概：

    基本类型
    S3
    S4
    RC
    模式的选择


基本类型：

基本上每个 R 对象都类似于描述内存存储的 C 语言结构体，这个结构体包含了对象的所有内容（包括内存管理需要的信息，还有对象的基本类型）。基本类型并不是真的对象系统，因为只有 R 语言的核心团队才能创建新的类型。但结果新的基本类型竟然也很少见地被添加了：最近是在2011年，添加了两个你从来没在 R 里面见过的奇异类型（NEWSXP 和 FREESXP），它们能够有效地诊断出内存上的问题。在此之前，2005年为 S4 对象添加了一个特殊的基本类型（S4SXP）。

Data structures 章节讲述了大部分普通的基本类型（原子向量和列表），但基本类型还包括 functions、environments，以及其它更加奇异的对象，如 names、calls、promises，之后你将会在本书中学到。你可以使用 typeof() 来了解对象的基本类型。但基本类型的名字在 R 中并不总是有效的，并且类型和 “is” 函数可能会使用不同的名字：

# The type of a function is "closure"
f <- function() {}
typeof(f)
#> [1] "closure"
is.function(f)
#> [1] TRUE

# The type of a primitive function is "builtin"
typeof(sum)
#> [1] "builtin"
is.primitive(sum)
#> [1] TRUE

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

你可能听过 mode() 和 storage.mode()，我建议不要使用这两个函数，因为它们只是 typeof() 返回值的别名，而且只使用与 S 语言。如果你想了解它们具体如何实现，可以去看一下它们的源代码。

不同基本类型的函数一般都是用 C 语言编写的，在调度时使用switch语句(例如：switch(TYPEOF(x)))。尽管你可能没有写过 C 语言，但理解基本类型仍然很有必要，因为其他系统都是在此基础上的：S3 对象可以建立在所有基本类型上，S4 使用一个特殊的基本类型，而 RC 对象是 S4 和 environments（一个特殊的基本类型）的结合体。查看对象是否是一个单纯基本类型（即它不同时含 S3、S4、RC 的行为），使用 is.object(x) ，返回TRUE/FALSSE。


S3:

S3 是 R 语言的第一种也是最简单的一种 OO 系统。它还是唯一一种在基础包和统计包使用的 OO 系统，CRAN包中最平常使用的 OO 系统。
识别对象、泛型函数、方法：

你遇到的大部分对象都是 S3 对象。但不幸的是在 R 中并没有可以简单检测一个方法是否是 S3 的方法。最接近的方法就是 is.object(x) & !isS4(x)，即它是一个对象，但不是 S4 对象。一个更简单的方法就是使用 pryr::otype() ：

library(pryr)

df <- data.frame(x = 1:10, y = letters[1:10])
otype(df)    # A data frame is an S3 class
#> [1] "S3"
otype(df$x)  # A numeric vector isn't
#> [1] "base"
otype(df$y)  # A factor is
#> [1] "S3"

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

在 S3，方法是属于函数的，这些函数叫做泛型函数，或简称泛型。S3 的方法不属于对象或者类。这和大部分的编程语言都不同，但它确实是一种合法的 OO 方式。

你可以调用 UseMethod() 方法来查看某个函数的源代码，从而确定它是否是 S3 泛型。和 otype() 类似，prpy 也提供了 ftype() 来联系着一个函数（如果有的话）描述对象系统。

mean
#> function (x, ...) 
#> UseMethod("mean")
#> <bytecode: 0x24bfa50>
#> <environment: namespace:base>
ftype(mean)
#> [1] "s3"      "generic"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

有些 S3 泛型，例如 [ 、sum()、cbind()，不能调用 UseMethod()，因为它们是用 C 语言来执行的。不过它们可以调用 C 语言的函数 DispatchGroup() 和 DispatchOrEval()。利用 C 代码进行方法调用的函数叫作内部泛型。可以使用 ?”internal generic” 查看。

给定一个类，S3 泛型的工作是调用正确的 S3 方法。你可以通过 S3 方法的名字来识别（形如 generic.class()）。例如，泛型 mean() 的 Date 方法为 mean.Date()，泛型print() 的向量方法为 print.factor() 。
这也就是为什么现代风格不鼓励在函数名字里使用 “.” 的原因了。类的名字也不使用 “.” 。pryr::ftype() 可以发现这些异常，所以你可以用它来识别一个函数是 S3 方法还是泛型：

ftype(t.data.frame) # data frame method for t()
#> [1] "s3"     "method"
ftype(t.test)       # generic function for t tests
#> [1] "s3"      "generic"

    1
    2
    3
    4

    1
    2
    3
    4

你可以调用 methods() 来查看属于某个泛型的所有方法：

methods("mean")
#> [1] mean.Date     mean.default  mean.difftime mean.POSIXct  mean.POSIXlt 
#> see '?methods' for accessing help and source code
methods("t.test")
#> [1] t.test.default* t.test.formula*
#> see '?methods' for accessing help and source code

    1
    2
    3
    4
    5
    6

    1
    2
    3
    4
    5
    6

（除了在基础包里面定义的一些方法，大多数 S3 的方法都是不可见的使用 getS3method() 来阅读它们的源码。）

你也可以列出一个给出类中包含某个方法的所有泛型：

methods(class = "ts")
#>  [1] aggregate     as.data.frame cbind         coerce        cycle        
#>  [6] diffinv       diff          initialize    kernapply     lines        
#> [11] Math2         Math          monthplot     na.omit       Ops          
#> [16] plot          print         show          slotsFromS3   time         
#> [21] [<-           [             t             window<-      window       
#> see '?methods' for accessing help and source code

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

你也可以从接下来的部分知道，要列出所有的 S3 类是不可能的。
定义类和创建对象：

S3 是一个简单而特殊的系统，它对类没有正式的定义。要实例化一个类，你只能拿一个已有的基础对象，再设置类的属性。你可以在创建类的时候使用 structure()，或者事后用 class<-()：

# Create and assign class in one step
foo <- structure(list(), class = "foo")

# Create, then set class
foo <- list()
class(foo) <- "foo"

    1
    2
    3
    4
    5
    6

    1
    2
    3
    4
    5
    6

S3 对象的属性通常建立在列表或者原子向量之上（你可以用这个属性去刷新你的内存属性），你也能把函数转成 S3 对象，其他基本类型要么在 R 中很少见，要么就是该语义不能很好地在属性下运行。
你可以通过 class() 把类看作任意的对象，也可以通过 inherits(x, “classname”) 来查看某个对象是否继承自某个具体的类。

class(foo)
#> [1] "foo"
inherits(foo, "foo")
#> [1] TRUE

    1
    2
    3
    4

    1
    2
    3
    4

S3 对象所属于的类可以被看成是一个向量，一个通过最重要的特性来描述对象行为的向量。例如对象 glm() 的类是 c(“glm”, “lm”)，它表明着广义线性模型的行为继承自线性模型。类名通常是小写的，并且应该避免使用 “.” 。否则该类名将会混淆为下划线形式的 my_class，或者 CamelCase 写法的 MyClass。

大多数的 S3 类都提供了构造函数：

foo <- function(x) {
  if (!is.numeric(x)) stop("X must be numeric")
  structure(list(x), class = "foo")
}

    1
    2
    3
    4

    1
    2
    3
    4

如果它是可用的，则你应该使用它（例如 factor() 和 data.frame()）。这能确保你在创造类的时候使用正确的组件。构造函数的名字一般是和类名是相同的。

开发者提供了构造函数之后，S3 并没有对它的正确性做检查。这意味着你可以改变现有对象所属于的类：

# Create a linear model
mod <- lm(log(mpg) ~ log(disp), data = mtcars)
class(mod)
#> [1] "lm"
print(mod)
#> 
#> Call:
#> lm(formula = log(mpg) ~ log(disp), data = mtcars)
#> 
#> Coefficients:
#> (Intercept)    log(disp)  
#>      5.3810      -0.4586

# Turn it into a data frame (?!)
class(mod) <- "data.frame"
# But unsurprisingly this doesn't work very well
print(mod)
#>  [1] coefficients  residuals     effects       rank          fitted.values
#>  [6] assign        qr            df.residual   xlevels       call         
#> [11] terms         model        
#> <0 rows> (or 0-length row.names)
# However, the data is still there
mod$coefficients
#> (Intercept)   log(disp) 
#>   5.3809725  -0.4585683

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

如果你在之前使用过其他的 OO 语言，S3 可能会让你觉得很恶心。但令人惊讶的是，这种灵活性带来的问题很少：虽然你能改变对象的类型，但你并不会这么做。R 并不用提防自己：你可以很容易射自己的脚，只要你不把抢瞄在你的脚上并扣动扳机，你就不会有问题。
创建新的方法和泛型：

如果要添加一个新的泛型，你只要创建一个叫做 UseMethod() 的函数。UseMethod() 有两个参数：泛型函数的名字和用来调度方法的参数。如果第二个参数省略了，则根据第一个参数来调度方法。但是没有必要去省略 UseMethod() 的参数，你也不应该这么做。

f <- function(x) UseMethod("f")

    1

    1

没有方法的泛型是没有用的。如果要添加方法，你只需要用 generic.class 创建一个合法的函数：

f.a <- function(x) "Class a"

a <- structure(list(), class = "a")
class(a)
#> [1] "a"
f(a)
#> [1] "Class a"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

用同样的方法可以对已有的泛型添加方法：

mean.a <- function(x) "a"
mean(a)
#> [1] "a"

    1
    2
    3

    1
    2
    3

如你所看到的，它并没有确保类和泛型兼容的检查机制，它主要是靠编程者自己来确定自己的方法不会违反现有代码的期望。
方法调度：

S3 的方法调度比较简单。UseMethod() 创建一个向量或者一个函数名字（例如：paste0(“generic”, “.”, c(class(x), “default”))），并逐个查找。default 类作为回落的方法，以防其他未知类的情况。

f <- function(x) UseMethod("f")
f.a <- function(x) "Class a"
f.default <- function(x) "Unknown class"

f(structure(list(), class = "a"))
#> [1] "Class a"
# No method for b class, so uses method for a class
f(structure(list(), class = c("b", "a")))
#> [1] "Class a"
# No method for c class, so falls back to default
f(structure(list(), class = "c"))
#> [1] "Unknown class"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12

组泛型方法增加了一些复杂性，组泛型为一个函数实现复合泛型的多个方法提供了可能性。它们包含的四组泛型和函数如下：

    Math: abs, sign, sqrt, floor, cos, sin, log, exp, …
    Ops: +, -, *, /, ^, %%, %/%, &, |, !, ==, !=, <, <=, >=, >
    Summary: all, any, sum, prod, min, max, range
    Complex: Arg, Conj, Im, Mod, Re

组泛型是相对比较先进的技术，超出了本章的范围。但是你可以通过 ?groupGeneric 查看更多相关信息。区分组泛型最关键的是要意识到 Math、Ops、Summary 和 Complex 并不是真正的函数，而是代表着函数。注意在组泛型中有特殊的变量 .Generic 提供实际的泛型函数调用。

如果你有复数类模板的层次结构，那么调用“父”方法是有用的。要准确定义它的意义的话有点难度，但如果当前方法不存在的话它基本上都会被调用。同样的，你可以使用 ?NextMethod 查看相关信息。

因为方法是正规的 R 函数，所以你可以直接调用它：

c <- structure(list(), class = "c")
# Call the correct method:
f.default(c)
#> [1] "Unknown class"
# Force R to call the wrong method:
f.a(c)
#> [1] "Class a"

    1
    2
    3
    4
    5
    6
    7

    1
    2
    3
    4
    5
    6
    7

不过这种调用的方法和改变对象的类属性一样危险，所以一般都不这样做。不要把上膛了的枪瞄在自己的脚上。使用上述方法的唯一原因是它可以通过跳过方法调用达到很大的性能改进，你可以查看性能章节查看详情。

非 S3 对象也可以调用 S3 泛型，非内部的泛型会调用基本类型的隐式类。（因为性能上的原因，内部的泛型并不会这样做。）确定基本类型的隐式类有点难，如下面的函数所示：

iclass <- function(x) {
  if (is.object(x)) {
    stop("x is not a primitive type", call. = FALSE)
  }

  c(
    if (is.matrix(x)) "matrix",
    if (is.array(x) && !is.matrix(x)) "array",
    if (is.double(x)) "double",
    if (is.integer(x)) "integer",
    mode(x)
  )
}
iclass(matrix(1:5))
#> [1] "matrix"  "integer" "numeric"
iclass(array(1.5))
#> [1] "array"   "double"  "numeric"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17

练习：

    查阅 t() 和 t.test() 的源代码，并证明 t.test() 是一个 S3 泛型而不是 S3 方法。如果你用 test 类创建一个对象并用它调用 t() 会发生什么？
    在 R 语言的基本类型中什么类有 Math 组泛型？查阅源代码，该方法是如何工作的？
    R 语言在日期时间上有两种类，POSIXct 和 POSIXlt（两者都继承自 POSIXt）。哪些泛型对于这两个类是有不同行为的？哪个泛型共享相同的行为？
    哪个基本泛型定义的方法最多？
    UseMethod() 通过特殊的方式调用方法。请预测下列代码将会返回什么，然后运行一下，并且查看 UseMethod() 的帮助文档，推测一下发生了什么。用最简单的方式记下这些规则。

y <-1
g <-function(x) {
  y <-2UseMethod("g")
}
g.numeric <-function(x) y
g(10)

h <-function(x) {
  x <-10UseMethod("h")
}
h.character <-function(x) paste("char", x)
h.numeric <-function(x) paste("num", x)

h("a")

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14

    内部泛型不分配在基类类型的隐式类。仔细查阅 ?”internal generic”，为什么下面例子中的 f 和 g 的长度不一样？哪个函数可以区分 f 和 g 的行为？

f <- function() 1
g <- function() 2
class(g) <- "function"

class(f)
class(g)

length.function <- function(x) "function"
length(f)
length(g)

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10


S4：

S4 工作的方式和 S3 比较相似，但它更加正式和严谨。方法还是属于函数，而不是类。但是：

    类在描述字段和继承结构（父类）上有更加正式的定义。
    方法调用可以传递多个参数，而不仅仅是一个。
    出现了一个特殊的运算符——@，从 S4 对象中提取 slots（又名字段）。

所以 S4 的相关代码都存储在 methods 包里面。当你交互运行 R 程序的时候这个包都是可用的，但在批处理的模式下则可能不可用。所以，我们在使用 S4 的时候一般直接使用 library(methods) 。
S4 是一种丰富、复杂的系统，并不是一两页纸能解释完的。所以在此我把重点放在 S4 背后的面向对象思想，这样大家就可以比较好地使用 S4 对象了。如果想要了解更多，可以参考以下文献：

    S4 系统在 Bioconductor 中的发展历程
    John Chambers 写的《Software for Data Analysis》
    Martin Morgan 在 stackoverflow 上关于 S4 问题的回答

识别对象、泛型函数和方法：

要识别 S4 对象 、泛型、方法还是很简单的。对于 S4 对象：str() 将它描述成一个正式的类，isS4() 会返回 TRUE，prpy::otype() 会返回 “S4” 。对于 S4 泛型函数：它们是带有很好类定义的 S4 对象。
常用的基础包里面是没有 S4 对象的（stats, graphics, utils, datasets, 和 base），所以我们要从内建的 stats4 包新建一个 S4 对象开始，它提供了一些 S4 类和方法与最大似然估计：

library(stats4)

# From example(mle)
y <- c(26, 17, 13, 12, 20, 5, 9, 8, 5, 4, 8)
nLL <- function(lambda) - sum(dpois(y, lambda, log = TRUE))
fit <- mle(nLL, start = list(lambda = 5), nobs = length(y))

# An S4 object
isS4(fit)
#> [1] TRUE
otype(fit)
#> [1] "S4"

# An S4 generic
isS4(nobs)
#> [1] TRUE
ftype(nobs)
#> [1] "s4"      "generic"

# Retrieve an S4 method, described later
mle_nobs <- method_from_call(nobs(fit))
isS4(mle_nobs)
#> [1] TRUE
ftype(mle_nobs)
#> [1] "s4"     "method"

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14
    15
    16
    17
    18
    19
    20
    21
    22
    23
    24
    25

用带有一个参数的 is() 来列出对象继承的所有父类。用带有两个参数的 is() 来验证一个对象是否继承自该类：

is(fit)
#> [1] "mle"
is(fit, "mle")
#> [1] TRUE

    1
    2
    3
    4

    1
    2
    3
    4

你可以使用 getGenerics() 来获取 S4 的所有泛型函数，或者使用 getClasses() 来获取 S4 的所有类。这些类包括 S3 对 shim classes 和基本类型。另外你可以使用 showMethods() 来获取 S4 的所有方法。
定义类和新建对象

在 S3，你可以通过更改类的属性就可以改变任意一个对象，但是在 S4 要求比较严格：你必须使用 setClass() 定义类的声明，并且用 new() 新建一个对象。你可以用特殊的语法 class?className（例如：class?mle）找到该类的相关文档。
S4 类有三个主要的特性：

    名字：一个字母-数字的类标识符。按照惯例，S4 类名称使用 UpperCamelCase 。
    已命名的 slots（字段），它用来定义字段名称和允许类。例如，一个 person 类可能由字符型的名称和数字型的年龄所表征：list(name = "character", age = "numeric")。
    父类。你可以给出多重继承的多个类，但这项先进的技能增加了它的复杂性。

在slots和contains，你可以使用setOldClass()来注册新的 S3 或 S4 类，或者基本类型的隐式类。在slots，你可以使用特殊的ANY类，它不限制输入。
S4 类有像 validity 方法的可选属性，validity 方法可以检验一个对象是否是有效的，是否是定义了默认字段值的 prototype 对象。使用?setClass查看更多细节。
下面的例子新建了一个具有 name 字段和 age 字段的 Person 类，还有继承自 Person 类的 Employee 类。Employee 类从 Person 类继承字段和方法，并且增加了字段 boss 。我们调用 new() 方法和类的名字，还有name-values这样成对的参数值来新建一个对象。

setClass("Person",
  slots = list(name = "character", age = "numeric"))
setClass("Employee",
  slots = list(boss = "Person"),
  contains = "Person")

alice <- new("Person", name = "Alice", age = 40)
john <- new("Employee", name = "John", age = 20, boss = alice)

    1
    2
    3
    4
    5
    6
    7
    8

    1
    2
    3
    4
    5
    6
    7
    8

大部分 S4 类都有一个和类名相同名字的构造函数：如果有，可以直接用它来取代 new() 。
要访问 S4 对象的字段，可以用 @ 或者 slot() ：

alice@age
#> [1] 40
slot(john, "boss")
#> An object of class "Person"
#> Slot "name":
#> [1] "Alice"
#> 
#> Slot "age":
#> [1] 40

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

（@ 和 $ 等价，slot() 和 [] 等价）
如果一个 S4 对象继承自 S3 类或者基本类型，它会有特殊的属性 .Data：

setClass("RangedNumeric",
  contains = "numeric",
  slots = list(min = "numeric", max = "numeric"))
rn <- new("RangedNumeric", 1:10, min = 1, max = 10)
rn@min
#> [1] 1
rn@.Data
#>  [1]  1  2  3  4  5  6  7  8  9 10

    1
    2
    3
    4
    5
    6
    7
    8

    1
    2
    3
    4
    5
    6
    7
    8

因为 R 是响应式编程的语言，所以它可以随时创建新的类或者重新定义现有类。这将会造成一个问题：当你在响应式地调试 S4 的时候，如果你更改了一个类，你要知道你已经把该类的所有对象都更改了。
新建方法和泛型函数

S4 提供了特殊的函数来新建方法和泛型。setGeneric() 将产生一个新的泛型，或者把已有函数转成泛型。

setGeneric("union")
#> [1] "union"
setMethod("union",
  c(x = "data.frame", y = "data.frame"),
  function(x, y) {
    unique(rbind(x, y))
  }
)
#> [1] "union"

    1
    2
    3
    4
    5
    6
    7
    8
    9

    1
    2
    3
    4
    5
    6
    7
    8
    9

如果你要重新创建了一个泛型，你需要调用 standardGeneric() :

setGeneric("myGeneric", function(x) {
  standardGeneric("myGeneric")
})
#> [1] "myGeneric"

    1
    2
    3
    4

    1
    2
    3
    4

S4 中的 standardGeneric() 相当于 UseMethod() 。


测试的答案

    要确定一个对象属于哪种面向对象系统，你可以用排除法，如果 !is.object(x) 返回 TRUE，那么它是一个基本对象。如果 !isS4(x) 返回 TRUE，那么它是一个 S3 。如果 !is(x, "refClass") 返回 TRUE， 那么它是一个 S4 ，否则它是 RC 。
    用 typeof() 来确定基本类型的对象。
    泛型函数调用特殊方法的时候主要是通过它的参数输入来确定的，在 S3 和 S4 系统，方法属于泛型函数，不像其他编程语言那样属于类。
    S4 比 S3 更加正式，并且支持多重继承和多重调度，RC 对象的语义和方法是属于类的，而不属于函数。

顶
    0

踩
    0

 
 

    上一篇
    R::shiny 点击事件-Demo
    下一篇
    傅里叶分析之掐死教程（完整版）

我的同类文章
R（16）

    •R语言零碎知识集合2015-09-22阅读663
    •R语言——哈希表2015-08-21阅读1261
    •ggplot2——玫瑰图2015-08-13阅读723
    •ggplot2——坐标系篇2015-08-13阅读3915
    •R语言的各种报错及其解决方法2015-08-06阅读1143

    •R::shiny 点击事件-Demo2015-09-09阅读692
    •免安装Oracle连接数据库（odbc驱动）2015-08-14阅读668
    •ggplot2——饼图篇2015-08-13阅读1583
    •R——颜色篇2015-08-11阅读588
    •ggplot2——图例篇2015-08-06阅读1846

更多文章
参考知识库

img
    Java EE知识库

    1179关注|581收录

img
    Java SE知识库

    9437关注|454收录

img
    Java Web知识库

    9738关注|1042收录

猜你在找
    基于PHP面向对象的自定义MVC框架高级项目开发
    c++面向对象前言及意见征集（来者不拒）视频课程
    疯狂IOS讲义之Objective-C面向对象设计
    javaScript-高级面向对象视频教程
    秒学面向对象视频课程（C++高级实践篇）视频课程（50课时）
    转换指南 将程序从托管扩展 C++ 迁移到 C++CLI
    转换指南 将程序从托管扩展 C++ 迁移到 C++CLI
    转换指南 将程序从托管C++扩展迁移到C++CLI
    转换指南 将程序从托管C++扩展迁移到C++CLI
    30分钟--Spark快速入门指南

查看评论

  暂无评论

您还没有登录,请[登录]或[注册]
* 以上用户言论只代表其个人观点，不代表CSDN网站的观点或立场
核心技术类目
全部主题 Hadoop AWS 移动游戏 Java Android iOS Swift 智能硬件 Docker OpenStack VPN Spark ERP IE10 Eclipse CRM JavaScript 数据库 Ubuntu NFC WAP jQuery BI HTML5 Spring Apache .NET API HTML SDK IIS Fedora XML LBS Unity Splashtop UML components Windows Mobile Rails QEMU KDE Cassandra CloudStack FTC coremail OPhone CouchBase 云计算 iOS6 Rackspace Web App SpringSide Maemo Compuware 大数据 aptech Perl Tornado Ruby Hibernate ThinkPHP HBase Pure Solr Angular Cloud Foundry Redis Scala Django Bootstrap

    个人资料

    [访问我的空间]
    九茶
    4 1
        访问：110786次
        积分：1947
        等级：
        排名：第14560名
        原创：67篇
        转载：2篇
        译文：1篇
        评论：118条

    文章搜索

    博客专栏

    	Python爬虫

    文章：14篇
    阅读：27213
    	小算法大本营

    文章：20篇
    阅读：40941
    	R语言

    文章：17篇
    阅读：21291

    文章分类

    R(17)
    SAS(2)
    数学(6)
    算法(22)
    爬虫(11)
    生活(6)
    python(22)
    数据库(2)
    数据挖掘(14)
    草稿记录(2)
    逼格修炼之道(6)

    文章存档

    2016年09月(1)
    2016年03月(6)
    2016年02月(5)
    2015年12月(4)
    2015年11月(1)
    展开

    阅读排行 

    马踏棋盘之贪心算法优化(8464)
    新浪微博爬虫分享（一天可抓取 1300 万条数据）(7738)
    QQ空间爬虫分享（一天可抓取 400 万条数据）(5832)
    ggplot2——坐标系篇(3919)
    八皇后之回溯法解决(3675)
    凸包问题的五种解法(3419)
    python实现二叉树和它的七种遍历(3206)
    生活灵感汇总(3164)
    资源分享(3128)
    python字典--知识点总结(3097)

    联系方式


    Tel : 13570233493

    新浪微博：路过

    LEFTER：
    http://zhubei.lofter.com/

    GitHub：
    https://github.com/liuxingming

    我的微信：

    爬虫交流群：

    爬虫交流群：
                   爬虫交流群

    全职爬虫工程师：
                   爬虫工程师-群 

    我的爬虫历史

    QQ空间、新浪微博、WooYun、Github、CSDN、博客园、域名与IP数据、SearchCode、大众点评、图吧网、证券投资数据、中国土地数据、某些政府网站等等。

    公司简介
    |
    招贤纳士
    |
    广告服务
    |
    银行汇款帐号
    |
    联系方式
    |
    版权声明
    |
    法律顾问
    |
    问题报告
    |
    合作伙伴
    |
    论坛反馈
    网站客服
    杂志客服
    微博客服
    webmaster@csdn.net
    400-600-2320|北京创新乐知信息技术有限公司 版权所有|江苏乐知网络技术有限公司 提供商务支持
    京 ICP 证 09002463 号|Copyright © 1999-2016, CSDN.NET, All Rights Reserved 
    GongshangLogo




推酷

    文章
    站点
    主题
    活动
    公开课
    APP 荐
    周刊

    登录

R语言基于RC的面向对象编程
时间 2014-04-23 12:17:40 粉丝日志
原文
  http://blog.fens.me/r-class-rc/
主题 R语言 面向对象编程

R的极客理想系列文章，涵盖了R的思想，使用，工具，创新等的一系列要点，以我个人的学习和体验去诠释R的强大。

R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。

要成为有理想的极客，我们不能停留在语法上，要掌握牢固的数学，概率，统计知识，同时还要有创新精神，把R语言发挥到各个领域。让我们一起动起来吧，开始R的极客理想。
关于作者：

    张丹(Conan), 程序员Java,R,PHP,Javascript
    weibo：@Conan_Z
    blog: http://blog.fens.me
    email: bsspirit@gmail.com

转载请注明出处：
http://blog.fens.me/r-class-rc/

前言

本文接上一篇文章 R语言基于S4的面向对象编程 ，本文继续介绍R语言基于RC的面向对象编程。

RC对象系统从底层上改变了原有S3和S4对象系统的设计，去掉了泛型函数，真正地以类为基础实现面向对象的特征。
目录

    RC对象系统介绍
    创建RC类和对象
    对象赋值
    定义对象的方法
    RC对象内置方法
    RC类的辅助构造函数
    RC对象系统的使用

1 RC对象系统介绍

RC是Reference classes的简称，又被称为R5，在R语言的2.12版本被引入的，是最新一代的面向对象系统。

RC不同于原来的S3和S4对象系统，RC对象系统的方法是在类中自定的，而不是泛型函数。RC对象的行为更相似于其他的编程语言，实例化对象的语法也有所改变。

从面向对象的角度来说，我们下面要重定义几个名词。

    类：面向对象系统的基本类型，类是静态结构定义。
    对象：类实例化后，在内存中生成结构体。
    方法：是类中的函数定义，不通过泛型函数实现。

2 创建RC类和对象

本文的系统环境

    Linux: Ubuntu Server 12.04.2 LTS 64bit
    R: 3.0.1 x86_64-pc-linux-gnu

为了方便我们检查对象的类型，引入pryr包作为辅助工具。关于pryr包的介绍，请参考文章:[撬动R内核的高级工具包pryr](http://blog.fens.me/r-pryr/)


# 加载pryr包
> library(pryr)

2.1 如何创建RC类？

RC对象系统是以类为基本类型， 有专门的类的定义函数 setRefClass() 和 实例化则通过类的方法生成，我们一下如何用RC对象系统创建一个类。

2.1.1 setRefClass()

查看setRefClass的函数定义。


setRefClass(Class, fields = , contains = , methods =, where =, ...)

参数列表：

    Class: 定义类名
    fields: 定义属性和属性类型
    contains: 定义父类，继承关系
    methods: 定义类中的方法
    where: 定义存储空间

从setRefClass()函数的定义来看，参数比S4的setClass()函数变少了。
2.2 创建RC类和实例


# 定义一个RC类
> User<-setRefClass("User",fields=list(name="character"))

# 查看User的定义
> User
Generator for class "User":

Class fields:
Name:       name
Class: character

Class Methods:
"callSuper", "copy", "export", "field", "getClass",
"getRefClass", "import", "initFields", "show", "trace",
"untrace", "usingMethods"

Reference Superclasses:
"envRefClass"


# 实例化一个User对象u1
> u1<-User$new(name="u1")

# 查看u1对象
> u1
Reference class object of class "User"
Field "name":
[1] "u1"

# 检查User类的类型
> class(User)
[1] "refObjectGenerator"
attr(,"package")
[1] "methods"
> is.object(User)
[1] TRUE
> otype(User)
[1] "RC"

# 检查u1的类型
> class(u1)
[1] "User"
attr(,"package")
[1] ".GlobalEnv"
> is.object(u1)
[1] TRUE
> otype(u1)
[1] "RC"

2.3 创建一个有继承关系的RC类


# 创建RC类User
> User<-setRefClass("User",fields=list(name="character"))

# 创建User的子类Member
> Member<-setRefClass("Member",contains="User",fields=list(manager="User"))

# 实例化User
> manager<-User$new(name="manager")

# 实例化一个Son对象
> member<-Member$new(name="member",manager=manager)

# 查看member对象
> member
Reference class object of class "Member"
Field "name":
[1] "member"
Field "manager":
Reference class object of class "User"
Field "name":
[1] "manager"

# 查看member对象的name属性
> member$name
[1] "member

# 查看member对象的manager属性
> member$manager
Reference class object of class "User"
Field "name":
[1] "manager"

# 检查对象的属性类型
> otype(member$name)
[1] "primitive"
> otype(member$manager)
[1] "RC"

2.4 RC对象的默认值

RC的类有一个指定构造器方法 $initialize()，这个构造器方法在实例化对象时，会自动被运行一次，通过这个构造方法可以设置属性的默认值。


# 定义一个RC类
> User<-setRefClass("User",
+
+     # 定义2个属性
+     fields=list(name="character",level='numeric'),
+     methods=list(
+
+          # 构造方法
+          initialize = function(name,level){
+              print("User::initialize")
+
+              # 给属性增加默认值
+              name <<- 'conan'
+              level <<- 1
+           }
+      )
+ )

# 实例化对象u1
> u1<-User$new()
[1] "User::initialize"

# 查看对象u1，属性被增加了默认值
> u1
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

3 对象赋值


# 定义User类
> User<-setRefClass("User",fields=list(name="character",age="numeric",gender="factor"))

# 定义一个factor类型
> genderFactor<-factor(c('F','M'))

# 实例化u1
> u1<-User$new(name="u1",age=44,gender=genderFactor[1])

# 查看age属性值
> u1$age
[1] 44

给u1的age属性赋值。


# 重新赋值
> u1$age<-10

# age属性改变
> u1$age
[1] 10

把u1对象赋值给u2对象。


# 把u1赋值给u2对象
> u2<-u1

# 查看u2的age属性
> u2$age
[1] 10

# 重新赋值
> u1$age<-20

# 查看u1,u2的age属性，都发生改变
> u1$age
[1] 20
> u2$age
[1] 20

这是由于把u1赋值给u2的时候，传递的是u1的实例化对象的引入，而不是值本身。这一点与其他语言中对象赋值是一样的。

如果想进行赋值而不是引入传递，可以用下面的方法实现。


# 调用u1的内置方法copy()，赋值给u3
> u3<-u1$copy()

# 查看u3的age属性
> u3$age
[1] 20

# 重新赋值
> u1$age<-30

# 查看u1的age属性，发生改变
> u1$age
[1] 30

# 查看u3的age属性，没有改变
> u3$age
[1] 20

对引入关系把握，可以减少值传递过程中的内存复制过程，可以让我们的程序运行效率更高。
4 定义对象的方法

在S3,S4的对象系统中，我们实现对象的行为时，都是借助于泛型函数来实现的。这种现实方法的最大问题是，在定义时函数和对象的代码是分离的，需要在运行时，通过判断对象的类型完成方法调用。而在RC对象系统中，方法可以定义在类的内部，通过实例化的对象完成方法调用。


# 定义一个RC类，包括方法
> User<-setRefClass("User",
+       fields=list(name="character",favorite="vector"),
+
+       # 方法属性
+       methods = list(
+
+           # 增加一个兴趣
+           addFavorite = function(x) {
+                 favorite <<- c(favorite,x)
+           },
+
+           # 删除一个兴趣
+           delFavorite = function(x) {
+                 favorite <<- favorite[-which(favorite == x)]
+           },
+
+           # 重新定义兴趣列表
+           setFavorite = function(x) {
+                 favorite <<- x
+           }
+       )
+ )

# 实例化对象u1
> u1<-User$new(name="u1",favorite=c('movie','football'))

# 查看u1对象
> u1
Reference class object of class "User"
Field "name":
[1] "u1"
Field "favorite":
[1] "movie"    "football"

接下来，进行方法操作。


# 删除一个兴趣
> u1$delFavorite('football')

# 查看兴趣属性
> u1$favorite
[1] "movie"

# 增加一个兴趣
> u1$addFavorite('shopping')
> u1$favorite
[1] "movie"    "shopping"

# 重置兴趣列表
> u1$setFavorite('reading')
> u1$favorite
[1] "reading"

直接到方法定义到类的内部，通过实例化的对象进行访问。这样就做到了，在定义时就能保证了方法的作用域，减少运行时检查的系统开销。
5 RC对象内置方法和内置属性

对于RC的实例化对象，除了我们自己定义的方法函数，还有几个内置的方法。之前属性复制赋值时使用的copy()方法，就是其中之一。
5.1 内置方法：

    initialize 类的初始化函数，用于设置属性的默认值，只能在类定义的方法中使用。
    callSuper 调用父类的同名方法，只能在类定义的方法中使用。
    copy 复制实例化对象的所有属性。
    initFields 给对象的属性赋值。
    field 查看属性或给属性赋值。
    getClass 查看对象的类定义。
    getRefClass 同getClass。
    show 查看当前对象。
    export 查看属性值以类为作用域。
    import 把一个对象的属性值赋值给另一个对象。
    trace 跟踪对象中方法调用，用于程序debug。
    untrace 取消跟踪。
    usingMethods 用于实现方法调用，只能在类定义的方法中使用。这个方法不利于程序的健壮性，所以不建议使用。

接下来，我们使用这些内置的方法。

首先定义一个父类User，包括 name和level两个属性， addLevel和addHighLevel两个功能方法，initialize构造方法。


# 类User
> User<-setRefClass("User",
+    fields=list(name="character",level='numeric'),
+    methods=list(
+      initialize = function(name,level){
+        print("User::initialize")
+        name <<- 'conan'
+        level <<- 1
+      },
+      addLevel = function(x) {
+        print('User::addLevel')
+        level <<- level+x
+      },
+      addHighLevel = function(){
+        print('User::addHighLevel')
+        addLevel(2)
+      }
+    )
+)

定义子类Member，继承父类User，并包括同名方法addLevel覆盖父类的方法，在addLevel方法中，会调用父类的同名方法。


# 子类Member
> Member<-setRefClass("Member",contains="User",
+
+    # 子类中的属性
+    fields=list(age='numeric'),
+    methods=list(
+
+      # 覆盖父类的同名方法
+      addLevel = function(x) {
+          print('Member::addLevel')
+
+          # 调用父类的同名方法
+          callSuper(x)
+          level <<- level+1
+      }
+    )
+)

分别实例化对象u1,m1。


# 实例化u1
> u1<-User$new(name='u1',level=10)
[1] "User::initialize"

# 查看u1对象，$new()不能实现赋值的操作
> u1
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

# 通过$initFields()向属性赋值
> u1$initFields(name='u1',level=10)
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 10

# 实例化m1
> m1<-Member$new()
[1] "User::initialize"

> m1$initFields(name='m1',level=100,age=12)
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

执行$copy()方法，复制对象属性并传值。


# 属性复制到u2
> u2<-u1$copy()
[1] "User::initialize"

# 执行方法addLevel()，让level加1，u1已改变
> u1$addLevel(1);u1
[1] "User::addLevel"
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 11

# u2的level与u1没有引入关系，u2没有变化
> u2
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 10

使用方法field()，查看并给level属性赋值。


# 查看level属性值
> u1$field('level')
[1] 11

# 给level赋值为1
> u1$field('level',1)

# 查看level属性值
> u1$level
[1] 1

使用getRefClass()和getClass()方法查看u1对象的类定义。


# 类引入的定义
> m1$getRefClass()
Generator for class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 类定义
> m1$getClass()
Reference Class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 通过otype查看类型的不同
> otype(m1$getRefClass())
[1] "RC"
> otype(m1$getClass())
[1] "S4"

使用$show()方法查看对象属性值，$show()，同show()函数，对象直接输出时就是调用了$show()方法。


> m1$show()
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

> show(m1)
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

> m1
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

使用 $trace()跟踪方法调用 ，再用 $untrace()方法取消跟踪绑定。


# 对addLevel()方法跟踪
> m1$trace("addLevel")
Tracing reference method "addLevel" for object from class "Member"
[1] "addLevel"

# 调用addLevel()方法，Tracing m1$addLevel(1)被打印，跟踪生效
> m1$addLevel(1)
Tracing m1$addLevel(1) on entry
[1] "Member::addLevel"
[1] "User::addLevel"

# 调用父类的addHighLevel()方法，Tracing addLevel(2)被打印，跟踪生效
> m1$addHighLevel()
[1] "User::addHighLevel"
Tracing addLevel(2) on entry
[1] "Member::addLevel"
[1] "User::addLevel"

# 取消对addLevel()方法跟踪
> m1$untrace("addLevel")
Untracing reference method "addLevel" for object from class "Member"
[1] "addLevel"

使用$export()方法，以类为作用域查看属性值。


# 查看在Member类中的属性
> m1$export('Member')
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

# 查看在User类中的属性，当前作用域不包括age属性。
> m1$export('User')
[1] "User::initialize"
Reference class object of class "User"
Field "name":
[1] "m1"
Field "level":
[1] 105

使用$import()方法，把一个对象的属性值赋值给另一个对象。


# 实例化m2
> m2<-Member$new()
[1] "User::initialize"
> m2
Reference class object of class "Member"
Field "name":
[1] "conan"
Field "level":
[1] 1
Field "age":
numeric(0)

# 把m1对象的值赋值给m2对象
> m2$import(m1)
> m2
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

5.2 内置属性：

RC对象实例化后，有两个内置属性：

    .self 实例化对象自身
    .refClassDef 类的定义类型


# $.self属性
> m1$.self
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

#  m1$.self和m1 完全相同
> identical(m1$.self,m1)
[1] TRUE

# 查看类型
> otype(m1$.self)
[1] "RC"


# $.refClassDef属性
> m1$.refClassDef
Reference Class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 与$getClass()相同
> identical(m1$.refClassDef,m1$getClass())
[1] TRUE

# 查看类型
> otype(m1$.refClassDef)
[1] "S4"

6 RC类的辅助函数

当定义好了RC的类结构，有一些辅助函数可以帮助我们查看类型的属性和方法，上面用于创建实例化的对象的$new()函数，也属性这类辅助函数。

    new 用于实例化对象。
    help 用于查询类中方法的调用。
    methods 列出类中定义的所有方法。
    fields 列出类中定义的所有属性。
    lock 给属性加锁，实例化对象的属性只允许赋值一次，即赋值变量，不可修改。
    trace 跟踪方法。
    accessors 给属性生成get/set方法。

接下来，我们使用辅助函数，继续使用我们之前定义的User的类的结构。


# 定义User类
> User<-setRefClass("User",
+    fields=list(name="character",level='numeric'),
+    methods=list(
+      initialize = function(name,level){
+        print("User::initialize")
+        name <<- 'conan'
+        level <<- 1
+      },
+      addLevel = function(x) {
+        print('User::addLevel')
+        level <<- level+x
+      },
+      addHighLevel = function(){
+        print('User::addHighLevel')
+        addLevel(2)
+      }
+    )
+)

# 实例化对象u1
> u1<-User$new()

# 列出User类中的属性
> User$fields()
       name       level
"character"   "numeric"

# 列出User类中的方法
> User$methods()
 [1] "addHighLevel" "addLevel"     "callSuper"
 [4] "copy"         "export"       "field"
 [7] "getClass"     "getRefClass"  "import"
[10] "initFields"   "initialize"   "show"
[13] "trace"        "untrace"      "usingMethods"

# 查看User类的方法调用
> User$help("addLevel")
Call:
$addLevel(x)

> User$help("show")
Call:
$show()

给User类中的属性，增加get/set方法


# 给level属性增加get/set方法
> User$accessors("level")

# 给name属性增加get/set方法
> User$accessors("name")

# 列出所有方法
> User$methods()
 [1] "addHighLevel" "addLevel"     "callSuper"
 [4] "copy"         "export"       "field"
 [7] "getClass"     "getLevel"     "getName"
[10] "getRefClass"  "import"       "initFields"
[13] "initialize"   "setLevel"     "setName"
[16] "show"         "trace"        "untrace"
[19] "usingMethods"

使用$trace()函数，跟踪addLevel方法


# 跟踪User类的addLevel方法
> User$trace('addLevel')
Tracing reference method "addLevel" for class
"User"
[1] "addLevel"

# 实例化对象u3
> u3<-User$new(name='u3',level=1)
[1] "User::initialize"

# addLevel方法调用，出发跟踪日志 Tracing u3$addLevel(2)
> u3$addLevel(2)
Tracing u3$addLevel(2) on entry
[1] "User::addLevel"

使用$lock()函数，把level属性设置为常量。


# 锁定level属性
> User$lock("level")

# 查看User类中被锁定的属性
> User$lock()
[1] "level"

# 实例化对象u3，这时level属性已经被赋值一次
> u3<-User$new()
[1] "User::initialize"
> u3
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

# 给level属性，再次赋值出错
> u3$level=1
Error: invalid replacement: reference class field ‘level’ is read-only
> u3$addLevel(2)
[1] "User::addLevel"
Error: invalid replacement: reference class field ‘level’ is read-only

7 RC对象系统的使用

我们接下用RC对象系统做一个例子，定义一套动物叫声研究模型。
7.1 任务一：定义动物的数据结构和发声方法。

假设最Animal为动物的基类，包括 研究的动物包括 猫(cat)、狗(dog)、鸭(duck)。

    定义动物的数据结构
    分别定义3种动物的发声bark()方法

如图所示结构：

定义动物的数据结构，包括基类的结构 和 3种动物的结构。


# 创建Animal类，包括name属性，构造方法initialize()，叫声方法bark()。
> Animal<-setRefClass("Animal",
+  fields=list(name="character"),
+  methods=list(
+    initialize = function(name) name <<- 'Animal',
+    bark = function() print("Animal::bark")
+  )
+)

# 创建Cat类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Cat<-setRefClass("Cat",contains="Animal",
+  methods=list(
+    initialize = function(name) name <<- 'cat',
+    bark = function() print(paste(name,"is miao miao"))
+  )
+)

# 创建Dog类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Dog<-setRefClass("Dog",contains="Animal",
+  methods=list(
+    initialize = function(name) name <<- 'dog',
+    bark = function() print(paste(name,"is wang wang"))
+  )
+)

# 创建Duck类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Duck<-setRefClass("Duck",contains="Animal",
+   methods=list(
+     initialize = function(name) name <<- 'duck',
+     bark = function() print(paste(name,"is ga ga"))
+   )
+)

接下来，我们实例化对象，然后研究它们的叫声。


# 创建cat实例
> cat<-Cat$new()
> cat$name
[1] "cat"

# cat叫声
> cat$bark()
[1] "cat is miao miao"

# 创建dog实例，并给dog起名叫Huang
> dog<-Dog$new()
> dog$initFields(name='Huang')
Reference class object of class "Dog"
Field "name":
[1] "Huang"
> dog$name
[1] "Huang"

# dog叫声
> dog$bark()
[1] "Huang is wang wang"

# 创建duck实例
> duck<-Duck$new()

# duck叫声
> duck$bark()
[1] "duck is ga ga"

7.2 任务二：定义动物的体貌特征

动物的体貌特征，包括 头、身体、肢、翅等，我在这里只定义肢和翅的特征。

3种动物都有肢，cat和dog是四肢，duck是二肢和二翅。

如图所示结构：

我们需要对原结构进行修改。


# 定义Animal类，增加limbs属性，默认值为4
Animal<-setRefClass("Animal",
    fields=list(name="character",limbs='numeric'),
    methods=list(
      initialize = function(name) {
          name <<- 'Animal'
          limbs<<-4
      },
      bark = function() print("Animal::bark")
    )
)

# 在Cat类的 initialize()方法中，执行callSuper()方法，调用父类的同名方法
Cat<-setRefClass("Cat",contains="Animal",
     methods=list(
       initialize = function(name) {
         callSuper()
         name <<- 'cat'
       },
       bark = function() print(paste(name,"is miao miao"))
     )
)

# 在Dog类的 initialize()方法中，执行callSuper()方法，调用父类的同名方法
Dog<-setRefClass("Dog",contains="Animal",
     methods=list(
       initialize = function(name) {
         callSuper()
         name <<- 'dog'
       },
       bark = function() print(paste(name,"is wang wang"))
     )
)

# 在Dog类的定义wing属性， 并在initialize()方法，定义limbs和wing属性的默认值
Duck<-setRefClass("Duck",contains="Animal",
    fields=list(wing='numeric'),
    methods=list(
      initialize = function(name) {
          name <<- 'duck'
          limbs<<- 2
          wing<<- 2
      },
      bark = function() print(paste(name,"is ga ga"))
    )
)

实例化对象并查看3种动物的属性值。


# 实例化cat对象，属性limbs为4
> cat<-Cat$new();cat
Reference class object of class "Cat"
Field "name":
[1] "cat"
Field "limbs":
[1] 4

# 实例化dog对象，属性limbs为4
> dog<-Dog$new()
> dog$initFields(name='Huang')
Reference class object of class "Dog"
Field "name":
[1] "Huang"
Field "limbs":
[1] 4
> dog
Reference class object of class "Dog"
Field "name":
[1] "Huang"
Field "limbs":
[1] 4

# 实例化duck对象，属性limbs为2，wing为2
> duck<-Duck$new();duck
Reference class object of class "Duck"
Field "name":
[1] "duck"
Field "limbs":
[1] 2
Field "wing":
[1] 2

7.3 任务三：定义动物的行动方式。

对于 猫(cat)，狗(dog)，鸭(duck) 来说，它们都可以在陆地上行动，而且还有各自不同的行动方式。

特有行动方式：

    猫(cat) 爬树
    狗(dog) 游泳
    鸭(duck) 游泳，短距离飞行

如图所示结构：

接下来，我们按动物的不同行动方式进行建模。


# 定义类Animal，增加action()方法，用于通用的行为陆地上行动。
> Animal<-setRefClass("Animal",
+    fields=list(name="character",limbs='numeric'),
+    methods=list(
+      initialize = function(name) {
+        name <<- 'Animal'
+        limbs<<-4
+      },
+      bark = function() print("Animal::bark"),
+      action = function() print("I can walk on the foot")
+    )
+)

# 定义Cat类，重写action()方法，并增加爬树的行动
> Cat<-setRefClass("Cat",contains="Animal",
+     methods=list(
+       initialize = function(name) {
+         callSuper()
+         name <<- 'cat'
+       },
+       bark = function() print(paste(name,"is miao miao")),
+       action = function() {
+         callSuper()
+         print("I can Climb a tree")
+       }
+     )
+  )

# 定义Dog类，重写action()方法，并增加游泳行动
> Dog<-setRefClass("Dog",contains="Animal",
+   methods=list(
+     initialize = function(name) {
+       callSuper()
+       name <<- 'dog'
+     },
+     bark = function() print(paste(name,"is wang wang")),
+     action = function() {
+         callSuper()
+         print("I can Swim.")
+     }
+   )
+)

# 定义Duck类，重写action()方法，并增加游泳和短距离飞行
> Duck<-setRefClass("Duck",contains="Animal",
+    fields=list(wing='numeric'),
+    methods=list(
+      initialize = function(name) {
+        name <<- 'duck'
+        limbs<<- 2
+        wing<<- 2
+      },
+      bark = function() print(paste(name,"is ga ga")),
+      action = function() {
+        callSuper()
+        print("I can swim.")
+        print("I also can fly a short way.")
+     }
+    )
+)

实例化对象，并运行action()方法。

cat的行动。


# 实例化cat
> cat<-Cat$new()

# cat的行动
> cat$action()
[1] "I can walk on the foot"
[1] "I can Climb a tree"

dog的行动。


> dog<-Dog$new()
> dog$action()
[1] "I can walk on the foot"
[1] "I can Swim."

duck的行动。


> duck<-Duck$new()
> duck$action()
[1] "I can walk on the foot"
[1] "I can swim."
[1] "I also can fly a short way."

通过这个例子，我们应该就能全面地了解了R语言中基于RC对象系统的面向对象程序设计了！RC对象系统提供了完全的面向对象的实现。
分享
推荐文章

    1. Formidable Playbook: A practical guide to building modern appli..
    2. Why Is JavaScript the Programming Language of the Future?
    3. Top 5 new features of Entity Framework Core 1.0
    4. A Beginner’s Very Bumpy Journey Through The World of Open Sou..
    5. JavaScript Arrow Functions Introduction
    6. Cap’n Proto

相关推刊

    by stasi009
    《默认推刊》
    19

我来评几句
登录后评论

已发表评论数(0)
相关站点
粉丝日志
＋订阅
热门文章

    1. Raspberry Pi Plays All That Jazz
    2. Formidable Playbook: A practical guide to building modern applications
    3. Why Is JavaScript the Programming Language of the Future?
    4. Top 5 new features of Entity Framework Core 1.0
    5. A Beginner’s Very Bumpy Journey Through The World of Open Source

网站相关
    关于我们 
    移动应用 
    建议反馈 

关注我们
    推酷网 
    tuicool2012 

友情链接
    人人都是产品经理 PM256 移动信息化 行晓网 智城外包网 虎嗅 IT耳朵 创媒工场 经理人分享 市场部网 砍柴网 CocoaChina 北风网 云智慧 我赢职场 大数据时代 奇笛网 咕噜网 红联linux Win10之家 鸟哥笔记 爱游戏 投资潮 31会议网 极光推送 Teambition 硅谷网 leangoo ZEALER中国 OpenSNS 小牛学堂 handone Scrum中文网 比戈大牛 又拍云 更多链接>>   

################

推酷

    文章
    站点
    主题
    活动
    公开课
    APP 荐
    周刊

    登录

R语言基于RC的面向对象编程
时间 2014-04-23 12:17:40 粉丝日志
原文
  http://blog.fens.me/r-class-rc/
主题 R语言 面向对象编程

R的极客理想系列文章，涵盖了R的思想，使用，工具，创新等的一系列要点，以我个人的学习和体验去诠释R的强大。

R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。

要成为有理想的极客，我们不能停留在语法上，要掌握牢固的数学，概率，统计知识，同时还要有创新精神，把R语言发挥到各个领域。让我们一起动起来吧，开始R的极客理想。
关于作者：

    张丹(Conan), 程序员Java,R,PHP,Javascript
    weibo：@Conan_Z
    blog: http://blog.fens.me
    email: bsspirit@gmail.com

转载请注明出处：
http://blog.fens.me/r-class-rc/

前言

本文接上一篇文章 R语言基于S4的面向对象编程 ，本文继续介绍R语言基于RC的面向对象编程。

RC对象系统从底层上改变了原有S3和S4对象系统的设计，去掉了泛型函数，真正地以类为基础实现面向对象的特征。
目录

    RC对象系统介绍
    创建RC类和对象
    对象赋值
    定义对象的方法
    RC对象内置方法
    RC类的辅助构造函数
    RC对象系统的使用

1 RC对象系统介绍

RC是Reference classes的简称，又被称为R5，在R语言的2.12版本被引入的，是最新一代的面向对象系统。

RC不同于原来的S3和S4对象系统，RC对象系统的方法是在类中自定的，而不是泛型函数。RC对象的行为更相似于其他的编程语言，实例化对象的语法也有所改变。

从面向对象的角度来说，我们下面要重定义几个名词。

    类：面向对象系统的基本类型，类是静态结构定义。
    对象：类实例化后，在内存中生成结构体。
    方法：是类中的函数定义，不通过泛型函数实现。

2 创建RC类和对象

本文的系统环境

    Linux: Ubuntu Server 12.04.2 LTS 64bit
    R: 3.0.1 x86_64-pc-linux-gnu

为了方便我们检查对象的类型，引入pryr包作为辅助工具。关于pryr包的介绍，请参考文章:[撬动R内核的高级工具包pryr](http://blog.fens.me/r-pryr/)


# 加载pryr包
> library(pryr)

2.1 如何创建RC类？

RC对象系统是以类为基本类型， 有专门的类的定义函数 setRefClass() 和 实例化则通过类的方法生成，我们一下如何用RC对象系统创建一个类。

2.1.1 setRefClass()

查看setRefClass的函数定义。


setRefClass(Class, fields = , contains = , methods =, where =, ...)

参数列表：

    Class: 定义类名
    fields: 定义属性和属性类型
    contains: 定义父类，继承关系
    methods: 定义类中的方法
    where: 定义存储空间

从setRefClass()函数的定义来看，参数比S4的setClass()函数变少了。
2.2 创建RC类和实例


# 定义一个RC类
> User<-setRefClass("User",fields=list(name="character"))

# 查看User的定义
> User
Generator for class "User":

Class fields:
Name:       name
Class: character

Class Methods:
"callSuper", "copy", "export", "field", "getClass",
"getRefClass", "import", "initFields", "show", "trace",
"untrace", "usingMethods"

Reference Superclasses:
"envRefClass"


# 实例化一个User对象u1
> u1<-User$new(name="u1")

# 查看u1对象
> u1
Reference class object of class "User"
Field "name":
[1] "u1"

# 检查User类的类型
> class(User)
[1] "refObjectGenerator"
attr(,"package")
[1] "methods"
> is.object(User)
[1] TRUE
> otype(User)
[1] "RC"

# 检查u1的类型
> class(u1)
[1] "User"
attr(,"package")
[1] ".GlobalEnv"
> is.object(u1)
[1] TRUE
> otype(u1)
[1] "RC"

2.3 创建一个有继承关系的RC类


# 创建RC类User
> User<-setRefClass("User",fields=list(name="character"))

# 创建User的子类Member
> Member<-setRefClass("Member",contains="User",fields=list(manager="User"))

# 实例化User
> manager<-User$new(name="manager")

# 实例化一个Son对象
> member<-Member$new(name="member",manager=manager)

# 查看member对象
> member
Reference class object of class "Member"
Field "name":
[1] "member"
Field "manager":
Reference class object of class "User"
Field "name":
[1] "manager"

# 查看member对象的name属性
> member$name
[1] "member

# 查看member对象的manager属性
> member$manager
Reference class object of class "User"
Field "name":
[1] "manager"

# 检查对象的属性类型
> otype(member$name)
[1] "primitive"
> otype(member$manager)
[1] "RC"

2.4 RC对象的默认值

RC的类有一个指定构造器方法 $initialize()，这个构造器方法在实例化对象时，会自动被运行一次，通过这个构造方法可以设置属性的默认值。


# 定义一个RC类
> User<-setRefClass("User",
+
+     # 定义2个属性
+     fields=list(name="character",level='numeric'),
+     methods=list(
+
+          # 构造方法
+          initialize = function(name,level){
+              print("User::initialize")
+
+              # 给属性增加默认值
+              name <<- 'conan'
+              level <<- 1
+           }
+      )
+ )

# 实例化对象u1
> u1<-User$new()
[1] "User::initialize"

# 查看对象u1，属性被增加了默认值
> u1
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

3 对象赋值


# 定义User类
> User<-setRefClass("User",fields=list(name="character",age="numeric",gender="factor"))

# 定义一个factor类型
> genderFactor<-factor(c('F','M'))

# 实例化u1
> u1<-User$new(name="u1",age=44,gender=genderFactor[1])

# 查看age属性值
> u1$age
[1] 44

给u1的age属性赋值。


# 重新赋值
> u1$age<-10

# age属性改变
> u1$age
[1] 10

把u1对象赋值给u2对象。


# 把u1赋值给u2对象
> u2<-u1

# 查看u2的age属性
> u2$age
[1] 10

# 重新赋值
> u1$age<-20

# 查看u1,u2的age属性，都发生改变
> u1$age
[1] 20
> u2$age
[1] 20

这是由于把u1赋值给u2的时候，传递的是u1的实例化对象的引入，而不是值本身。这一点与其他语言中对象赋值是一样的。

如果想进行赋值而不是引入传递，可以用下面的方法实现。


# 调用u1的内置方法copy()，赋值给u3
> u3<-u1$copy()

# 查看u3的age属性
> u3$age
[1] 20

# 重新赋值
> u1$age<-30

# 查看u1的age属性，发生改变
> u1$age
[1] 30

# 查看u3的age属性，没有改变
> u3$age
[1] 20

对引入关系把握，可以减少值传递过程中的内存复制过程，可以让我们的程序运行效率更高。
4 定义对象的方法

在S3,S4的对象系统中，我们实现对象的行为时，都是借助于泛型函数来实现的。这种现实方法的最大问题是，在定义时函数和对象的代码是分离的，需要在运行时，通过判断对象的类型完成方法调用。而在RC对象系统中，方法可以定义在类的内部，通过实例化的对象完成方法调用。


# 定义一个RC类，包括方法
> User<-setRefClass("User",
+       fields=list(name="character",favorite="vector"),
+
+       # 方法属性
+       methods = list(
+
+           # 增加一个兴趣
+           addFavorite = function(x) {
+                 favorite <<- c(favorite,x)
+           },
+
+           # 删除一个兴趣
+           delFavorite = function(x) {
+                 favorite <<- favorite[-which(favorite == x)]
+           },
+
+           # 重新定义兴趣列表
+           setFavorite = function(x) {
+                 favorite <<- x
+           }
+       )
+ )

# 实例化对象u1
> u1<-User$new(name="u1",favorite=c('movie','football'))

# 查看u1对象
> u1
Reference class object of class "User"
Field "name":
[1] "u1"
Field "favorite":
[1] "movie"    "football"

接下来，进行方法操作。


# 删除一个兴趣
> u1$delFavorite('football')

# 查看兴趣属性
> u1$favorite
[1] "movie"

# 增加一个兴趣
> u1$addFavorite('shopping')
> u1$favorite
[1] "movie"    "shopping"

# 重置兴趣列表
> u1$setFavorite('reading')
> u1$favorite
[1] "reading"

直接到方法定义到类的内部，通过实例化的对象进行访问。这样就做到了，在定义时就能保证了方法的作用域，减少运行时检查的系统开销。
5 RC对象内置方法和内置属性

对于RC的实例化对象，除了我们自己定义的方法函数，还有几个内置的方法。之前属性复制赋值时使用的copy()方法，就是其中之一。
5.1 内置方法：

    initialize 类的初始化函数，用于设置属性的默认值，只能在类定义的方法中使用。
    callSuper 调用父类的同名方法，只能在类定义的方法中使用。
    copy 复制实例化对象的所有属性。
    initFields 给对象的属性赋值。
    field 查看属性或给属性赋值。
    getClass 查看对象的类定义。
    getRefClass 同getClass。
    show 查看当前对象。
    export 查看属性值以类为作用域。
    import 把一个对象的属性值赋值给另一个对象。
    trace 跟踪对象中方法调用，用于程序debug。
    untrace 取消跟踪。
    usingMethods 用于实现方法调用，只能在类定义的方法中使用。这个方法不利于程序的健壮性，所以不建议使用。

接下来，我们使用这些内置的方法。

首先定义一个父类User，包括 name和level两个属性， addLevel和addHighLevel两个功能方法，initialize构造方法。


# 类User
> User<-setRefClass("User",
+    fields=list(name="character",level='numeric'),
+    methods=list(
+      initialize = function(name,level){
+        print("User::initialize")
+        name <<- 'conan'
+        level <<- 1
+      },
+      addLevel = function(x) {
+        print('User::addLevel')
+        level <<- level+x
+      },
+      addHighLevel = function(){
+        print('User::addHighLevel')
+        addLevel(2)
+      }
+    )
+)

定义子类Member，继承父类User，并包括同名方法addLevel覆盖父类的方法，在addLevel方法中，会调用父类的同名方法。


# 子类Member
> Member<-setRefClass("Member",contains="User",
+
+    # 子类中的属性
+    fields=list(age='numeric'),
+    methods=list(
+
+      # 覆盖父类的同名方法
+      addLevel = function(x) {
+          print('Member::addLevel')
+
+          # 调用父类的同名方法
+          callSuper(x)
+          level <<- level+1
+      }
+    )
+)

分别实例化对象u1,m1。


# 实例化u1
> u1<-User$new(name='u1',level=10)
[1] "User::initialize"

# 查看u1对象，$new()不能实现赋值的操作
> u1
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

# 通过$initFields()向属性赋值
> u1$initFields(name='u1',level=10)
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 10

# 实例化m1
> m1<-Member$new()
[1] "User::initialize"

> m1$initFields(name='m1',level=100,age=12)
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

执行$copy()方法，复制对象属性并传值。


# 属性复制到u2
> u2<-u1$copy()
[1] "User::initialize"

# 执行方法addLevel()，让level加1，u1已改变
> u1$addLevel(1);u1
[1] "User::addLevel"
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 11

# u2的level与u1没有引入关系，u2没有变化
> u2
Reference class object of class "User"
Field "name":
[1] "u1"
Field "level":
[1] 10

使用方法field()，查看并给level属性赋值。


# 查看level属性值
> u1$field('level')
[1] 11

# 给level赋值为1
> u1$field('level',1)

# 查看level属性值
> u1$level
[1] 1

使用getRefClass()和getClass()方法查看u1对象的类定义。


# 类引入的定义
> m1$getRefClass()
Generator for class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 类定义
> m1$getClass()
Reference Class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 通过otype查看类型的不同
> otype(m1$getRefClass())
[1] "RC"
> otype(m1$getClass())
[1] "S4"

使用$show()方法查看对象属性值，$show()，同show()函数，对象直接输出时就是调用了$show()方法。


> m1$show()
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

> show(m1)
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

> m1
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 100
Field "age":
[1] 12

使用 $trace()跟踪方法调用 ，再用 $untrace()方法取消跟踪绑定。


# 对addLevel()方法跟踪
> m1$trace("addLevel")
Tracing reference method "addLevel" for object from class "Member"
[1] "addLevel"

# 调用addLevel()方法，Tracing m1$addLevel(1)被打印，跟踪生效
> m1$addLevel(1)
Tracing m1$addLevel(1) on entry
[1] "Member::addLevel"
[1] "User::addLevel"

# 调用父类的addHighLevel()方法，Tracing addLevel(2)被打印，跟踪生效
> m1$addHighLevel()
[1] "User::addHighLevel"
Tracing addLevel(2) on entry
[1] "Member::addLevel"
[1] "User::addLevel"

# 取消对addLevel()方法跟踪
> m1$untrace("addLevel")
Untracing reference method "addLevel" for object from class "Member"
[1] "addLevel"

使用$export()方法，以类为作用域查看属性值。


# 查看在Member类中的属性
> m1$export('Member')
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

# 查看在User类中的属性，当前作用域不包括age属性。
> m1$export('User')
[1] "User::initialize"
Reference class object of class "User"
Field "name":
[1] "m1"
Field "level":
[1] 105

使用$import()方法，把一个对象的属性值赋值给另一个对象。


# 实例化m2
> m2<-Member$new()
[1] "User::initialize"
> m2
Reference class object of class "Member"
Field "name":
[1] "conan"
Field "level":
[1] 1
Field "age":
numeric(0)

# 把m1对象的值赋值给m2对象
> m2$import(m1)
> m2
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

5.2 内置属性：

RC对象实例化后，有两个内置属性：

    .self 实例化对象自身
    .refClassDef 类的定义类型


# $.self属性
> m1$.self
Reference class object of class "Member"
Field "name":
[1] "m1"
Field "level":
[1] 105
Field "age":
[1] 12

#  m1$.self和m1 完全相同
> identical(m1$.self,m1)
[1] TRUE

# 查看类型
> otype(m1$.self)
[1] "RC"


# $.refClassDef属性
> m1$.refClassDef
Reference Class "Member":

Class fields:
Name:       name     level       age
Class: character   numeric   numeric

Class Methods:
"addHighLevel", "addLevel", "addLevel#User", "callSuper", "copy", "export", "field", "getClass", "getRefClass", "import", "initFields",
"initialize", "show", "trace", "untrace", "usingMethods"

Reference Superclasses:
"User", "envRefClass"

# 与$getClass()相同
> identical(m1$.refClassDef,m1$getClass())
[1] TRUE

# 查看类型
> otype(m1$.refClassDef)
[1] "S4"

6 RC类的辅助函数

当定义好了RC的类结构，有一些辅助函数可以帮助我们查看类型的属性和方法，上面用于创建实例化的对象的$new()函数，也属性这类辅助函数。

    new 用于实例化对象。
    help 用于查询类中方法的调用。
    methods 列出类中定义的所有方法。
    fields 列出类中定义的所有属性。
    lock 给属性加锁，实例化对象的属性只允许赋值一次，即赋值变量，不可修改。
    trace 跟踪方法。
    accessors 给属性生成get/set方法。

接下来，我们使用辅助函数，继续使用我们之前定义的User的类的结构。


# 定义User类
> User<-setRefClass("User",
+    fields=list(name="character",level='numeric'),
+    methods=list(
+      initialize = function(name,level){
+        print("User::initialize")
+        name <<- 'conan'
+        level <<- 1
+      },
+      addLevel = function(x) {
+        print('User::addLevel')
+        level <<- level+x
+      },
+      addHighLevel = function(){
+        print('User::addHighLevel')
+        addLevel(2)
+      }
+    )
+)

# 实例化对象u1
> u1<-User$new()

# 列出User类中的属性
> User$fields()
       name       level
"character"   "numeric"

# 列出User类中的方法
> User$methods()
 [1] "addHighLevel" "addLevel"     "callSuper"
 [4] "copy"         "export"       "field"
 [7] "getClass"     "getRefClass"  "import"
[10] "initFields"   "initialize"   "show"
[13] "trace"        "untrace"      "usingMethods"

# 查看User类的方法调用
> User$help("addLevel")
Call:
$addLevel(x)

> User$help("show")
Call:
$show()

给User类中的属性，增加get/set方法


# 给level属性增加get/set方法
> User$accessors("level")

# 给name属性增加get/set方法
> User$accessors("name")

# 列出所有方法
> User$methods()
 [1] "addHighLevel" "addLevel"     "callSuper"
 [4] "copy"         "export"       "field"
 [7] "getClass"     "getLevel"     "getName"
[10] "getRefClass"  "import"       "initFields"
[13] "initialize"   "setLevel"     "setName"
[16] "show"         "trace"        "untrace"
[19] "usingMethods"

使用$trace()函数，跟踪addLevel方法


# 跟踪User类的addLevel方法
> User$trace('addLevel')
Tracing reference method "addLevel" for class
"User"
[1] "addLevel"

# 实例化对象u3
> u3<-User$new(name='u3',level=1)
[1] "User::initialize"

# addLevel方法调用，出发跟踪日志 Tracing u3$addLevel(2)
> u3$addLevel(2)
Tracing u3$addLevel(2) on entry
[1] "User::addLevel"

使用$lock()函数，把level属性设置为常量。


# 锁定level属性
> User$lock("level")

# 查看User类中被锁定的属性
> User$lock()
[1] "level"

# 实例化对象u3，这时level属性已经被赋值一次
> u3<-User$new()
[1] "User::initialize"
> u3
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1

# 给level属性，再次赋值出错
> u3$level=1
Error: invalid replacement: reference class field ‘level’ is read-only
> u3$addLevel(2)
[1] "User::addLevel"
Error: invalid replacement: reference class field ‘level’ is read-only

7 RC对象系统的使用

我们接下用RC对象系统做一个例子，定义一套动物叫声研究模型。
7.1 任务一：定义动物的数据结构和发声方法。

假设最Animal为动物的基类，包括 研究的动物包括 猫(cat)、狗(dog)、鸭(duck)。

    定义动物的数据结构
    分别定义3种动物的发声bark()方法

如图所示结构：

定义动物的数据结构，包括基类的结构 和 3种动物的结构。


# 创建Animal类，包括name属性，构造方法initialize()，叫声方法bark()。
> Animal<-setRefClass("Animal",
+  fields=list(name="character"),
+  methods=list(
+    initialize = function(name) name <<- 'Animal',
+    bark = function() print("Animal::bark")
+  )
+)

# 创建Cat类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Cat<-setRefClass("Cat",contains="Animal",
+  methods=list(
+    initialize = function(name) name <<- 'cat',
+    bark = function() print(paste(name,"is miao miao"))
+  )
+)

# 创建Dog类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Dog<-setRefClass("Dog",contains="Animal",
+  methods=list(
+    initialize = function(name) name <<- 'dog',
+    bark = function() print(paste(name,"is wang wang"))
+  )
+)

# 创建Duck类，继承Animal类，并重写(Overwrite)了 initialize() 和 bark()。
> Duck<-setRefClass("Duck",contains="Animal",
+   methods=list(
+     initialize = function(name) name <<- 'duck',
+     bark = function() print(paste(name,"is ga ga"))
+   )
+)

接下来，我们实例化对象，然后研究它们的叫声。


# 创建cat实例
> cat<-Cat$new()
> cat$name
[1] "cat"

# cat叫声
> cat$bark()
[1] "cat is miao miao"

# 创建dog实例，并给dog起名叫Huang
> dog<-Dog$new()
> dog$initFields(name='Huang')
Reference class object of class "Dog"
Field "name":
[1] "Huang"
> dog$name
[1] "Huang"

# dog叫声
> dog$bark()
[1] "Huang is wang wang"

# 创建duck实例
> duck<-Duck$new()

# duck叫声
> duck$bark()
[1] "duck is ga ga"

7.2 任务二：定义动物的体貌特征

动物的体貌特征，包括 头、身体、肢、翅等，我在这里只定义肢和翅的特征。

3种动物都有肢，cat和dog是四肢，duck是二肢和二翅。

如图所示结构：

我们需要对原结构进行修改。


# 定义Animal类，增加limbs属性，默认值为4
Animal<-setRefClass("Animal",
    fields=list(name="character",limbs='numeric'),
    methods=list(
      initialize = function(name) {
          name <<- 'Animal'
          limbs<<-4
      },
      bark = function() print("Animal::bark")
    )
)

# 在Cat类的 initialize()方法中，执行callSuper()方法，调用父类的同名方法
Cat<-setRefClass("Cat",contains="Animal",
     methods=list(
       initialize = function(name) {
         callSuper()
         name <<- 'cat'
       },
       bark = function() print(paste(name,"is miao miao"))
     )
)

# 在Dog类的 initialize()方法中，执行callSuper()方法，调用父类的同名方法
Dog<-setRefClass("Dog",contains="Animal",
     methods=list(
       initialize = function(name) {
         callSuper()
         name <<- 'dog'
       },
       bark = function() print(paste(name,"is wang wang"))
     )
)

# 在Dog类的定义wing属性， 并在initialize()方法，定义limbs和wing属性的默认值
Duck<-setRefClass("Duck",contains="Animal",
    fields=list(wing='numeric'),
    methods=list(
      initialize = function(name) {
          name <<- 'duck'
          limbs<<- 2
          wing<<- 2
      },
      bark = function() print(paste(name,"is ga ga"))
    )
)

实例化对象并查看3种动物的属性值。


# 实例化cat对象，属性limbs为4
> cat<-Cat$new();cat
Reference class object of class "Cat"
Field "name":
[1] "cat"
Field "limbs":
[1] 4

# 实例化dog对象，属性limbs为4
> dog<-Dog$new()
> dog$initFields(name='Huang')
Reference class object of class "Dog"
Field "name":
[1] "Huang"
Field "limbs":
[1] 4
> dog
Reference class object of class "Dog"
Field "name":
[1] "Huang"
Field "limbs":
[1] 4

# 实例化duck对象，属性limbs为2，wing为2
> duck<-Duck$new();duck
Reference class object of class "Duck"
Field "name":
[1] "duck"
Field "limbs":
[1] 2
Field "wing":
[1] 2

7.3 任务三：定义动物的行动方式。

对于 猫(cat)，狗(dog)，鸭(duck) 来说，它们都可以在陆地上行动，而且还有各自不同的行动方式。

特有行动方式：

    猫(cat) 爬树
    狗(dog) 游泳
    鸭(duck) 游泳，短距离飞行

如图所示结构：

接下来，我们按动物的不同行动方式进行建模。


# 定义类Animal，增加action()方法，用于通用的行为陆地上行动。
> Animal<-setRefClass("Animal",
+    fields=list(name="character",limbs='numeric'),
+    methods=list(
+      initialize = function(name) {
+        name <<- 'Animal'
+        limbs<<-4
+      },
+      bark = function() print("Animal::bark"),
+      action = function() print("I can walk on the foot")
+    )
+)

# 定义Cat类，重写action()方法，并增加爬树的行动
> Cat<-setRefClass("Cat",contains="Animal",
+     methods=list(
+       initialize = function(name) {
+         callSuper()
+         name <<- 'cat'
+       },
+       bark = function() print(paste(name,"is miao miao")),
+       action = function() {
+         callSuper()
+         print("I can Climb a tree")
+       }
+     )
+  )

# 定义Dog类，重写action()方法，并增加游泳行动
> Dog<-setRefClass("Dog",contains="Animal",
+   methods=list(
+     initialize = function(name) {
+       callSuper()
+       name <<- 'dog'
+     },
+     bark = function() print(paste(name,"is wang wang")),
+     action = function() {
+         callSuper()
+         print("I can Swim.")
+     }
+   )
+)

# 定义Duck类，重写action()方法，并增加游泳和短距离飞行
> Duck<-setRefClass("Duck",contains="Animal",
+    fields=list(wing='numeric'),
+    methods=list(
+      initialize = function(name) {
+        name <<- 'duck'
+        limbs<<- 2
+        wing<<- 2
+      },
+      bark = function() print(paste(name,"is ga ga")),
+      action = function() {
+        callSuper()
+        print("I can swim.")
+        print("I also can fly a short way.")
+     }
+    )
+)

实例化对象，并运行action()方法。

cat的行动。


# 实例化cat
> cat<-Cat$new()

# cat的行动
> cat$action()
[1] "I can walk on the foot"
[1] "I can Climb a tree"

dog的行动。


> dog<-Dog$new()
> dog$action()
[1] "I can walk on the foot"
[1] "I can Swim."

duck的行动。


> duck<-Duck$new()
> duck$action()
[1] "I can walk on the foot"
[1] "I can swim."
[1] "I also can fly a short way."

通过这个例子，我们应该就能全面地了解了R语言中基于RC对象系统的面向对象程序设计了！RC对象系统提供了完全的面向对象的实现。
分享
推荐文章

    1. Formidable Playbook: A practical guide to building modern appli..
    2. Why Is JavaScript the Programming Language of the Future?
    3. Top 5 new features of Entity Framework Core 1.0
    4. A Beginner’s Very Bumpy Journey Through The World of Open Sou..
    5. JavaScript Arrow Functions Introduction
    6. Cap’n Proto

相关推刊

    by stasi009
    《默认推刊》
    19

我来评几句
登录后评论

已发表评论数(0)
相关站点
粉丝日志
＋订阅
热门文章

    1. Raspberry Pi Plays All That Jazz
    2. Formidable Playbook: A practical guide to building modern applications
    3. Why Is JavaScript the Programming Language of the Future?
    4. Top 5 new features of Entity Framework Core 1.0
    5. A Beginner’s Very Bumpy Journey Through The World of Open Source

网站相关
    关于我们 
    移动应用 
    建议反馈 

关注我们
    推酷网 
    tuicool2012 

友情链接
    人人都是产品经理 PM256 移动信息化 行晓网 智城外包网 虎嗅 IT耳朵 创媒工场 经理人分享 市场部网 砍柴网 CocoaChina 北风网 云智慧 我赢职场 大数据时代 奇笛网 咕噜网 红联linux Win10之家 鸟哥笔记 爱游戏 投资潮 31会议网 极光推送 Teambition 硅谷网 leangoo ZEALER中国 OpenSNS 小牛学堂 handone Scrum中文网 比戈大牛 又拍云 更多链接>>   


###########################################################################333333333333333


    Categories
        Dataguru作业
        Hadoop实践
        IT相关知识
        Javascript语言实践
        JAVA语言实践
        R语言实践
        SEO优化
        其他语言
        创业
        可视化技术
        操作系统
        数据库
        数据挖掘
        晒粉丝
        架构设计
        活动聚会
        游戏
        程序算法
        网络技术
        虚拟化实践
        金融
        面试
        黑客攻防
    Twitter Updates

    Follow us on Twitter

+

    粉丝日志

跨界的IT博客|Hadoop家族, R, RHadoop, Nodejs, AngularJS, NoSQL, IT金融

    R语言实践 »
    R语言基于R6的面向对象编程

    @晒粉丝
    @每日中国天气

Posted:
Oct 14, 2014
Tags:
class
OO
R
R6
R6Class
RC
类
面向对象
Comments:
11 Comments
R语言基于R6的面向对象编程

R的极客理想系列文章，涵盖了R的思想，使用，工具，创新等的一系列要点，以我个人的学习和体验去诠释R的强大。

R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。

要成为有理想的极客，我们不能停留在语法上，要掌握牢固的数学，概率，统计知识，同时还要有创新精神，把R语言发挥到各个领域。让我们一起动起来吧，开始R的极客理想。

关于作者：

    张丹(Conan), 程序员Java,R,PHP,Javascript
    weibo：@Conan_Z
    blog: http://blog.fens.me
    email: bsspirit@gmail.com

转载请注明出处：
http://blog.fens.me/r-class-r6/

r-class-r6

前言

R6是什么？听说过S3、S4和RC(R5)的面向对象类型 ，R6难道是一种新的类型吗？

其实，我也是在无意中发现R6的。R6是R语言的一个面向对象的R包，R6类型非常接近于RC类型(Reference classes)，但比RC类型更轻，由于R6不依赖于S4的对象系统，所以用R6的构建面向对象系统会更加有效率。

目录

    初识R6
    创建R6类和实例化对象
    R6类的主动绑定
    R6类的继承关系
    R6类的对象的静态属性
    R6类的可移植类型
    R6类的动态绑定
    R6类的打印函数
    实例化对象的存储
    R6面向对象系统的案例

1. 初识R6

R6是一个单独的R包，与我们熟悉的原生的面向对象系统类型S3,S4和RC类型不一样。在R语言的面向对象系统中，R6类型与RC类型是比较相似的，但R6并不基于S4的对象系统，因此我们在用R6类型开发R包的时候，不用依赖于methods包，而用RC类型开发R包的时候则必须设置methods包的依赖，在发布gridgame游戏包 文章中，就会出现RC依赖于methods包的使用情况。

R6类型比RC类型更符合其他编程对于面向对象的设置，支持类的公有成员和私有成员，支持函数的主动绑定，并支持跨包的继承关系。由于RC类型的面向对象系统设计并不彻底，所以才会有R6这样的包出现。下面就让我们体会一下，基于R6面向对象系统编程吧。
2. 创建R6类和实例化对象

本文的系统环境

    Win7 64bit
    R: 3.1.1 x86_64-w64-mingw32/x64 (64-bit)

我们先安装R6包，同时为了方便我们检查对象的类型，引入pryr包作为辅助工具。关于pryr包的介绍，请参看撬动R内核的高级工具包pryr一文。


~ R                         # 启动R程序
> install.packages("R6")    # 安装R6包
> library(R6)               # 加载R6包
> library(pryr)             # 加载pryr包

注：R6同时支持Win7环境和Linux环境

2.1 如何创建R6类？

R6对象系统是以类为基本类型， 有专门的类的定义函数 R6Class() 和 实例化对象的生成方法，下面我们用R6对象系统创建一个类。

先查看R6的类创建函数R6Class()函数的定义。


> R6Class
function (classname = NULL, public = list(), private = NULL,
    active = NULL, inherit = NULL, lock = TRUE, class = TRUE,
    portable = TRUE, parent_env = parent.frame())

参数列表：

    classname 定义类名。
    public 定义公有成员，包括公有方法和属性。
    private 定义私有成员，包括私有方法和属性。
    active 主动绑定的函数列表。
    inherit 定义父类，继承关系。
    lock 是否上锁，如果上锁则用于类变量存储的环境空间被锁定，不能修改。
    class 是否把属性封装成对象，默认是封装，如果选择不封装，类中属性存存在一个环境空间中。
    portable 是否为可移植类型，默认是可移植型类，类中成员访问需要用调用self和private对象。
    parent_env 定义对象的父环境空间。

从R6Class()函数的定义来看，参数比RC类定义函数的setRefClass()函数有更多的面对对象特征。

2.2 创建R6的类和实例化对象

我们先创建一个最简单的R6的类，只包括一个公有方法。


> Person <- R6Class("Person",    # 定义一个R6类
+  public=list(
+    hello = function(){         # 定义公有方法hello
+      print(paste("Hello"))
+    }
+  )
+)

> Person                   # 查看Person的定义
<Person> object generator
  Public:
    hello: function
  Parent env: 
  Lock: TRUE
  Portable: TRUE

> class(Person)             # 检查Person的类型
[1] "R6ClassGenerator"

接下来，实例化Person对象，使用$new()函数完成。


> u1<-Person$new()   # 实例化一个Person对象u1
> u1                 #查看u1对象
<Person>
  Public:
    hello: function
> class(u1)           # 检查u1的类型
[1] "Person" "R6"

通过pryr包的otype检查Person类的类型和u1对象的实例化类型。


> otype(Person)   # 查看Person类型
[1] "S3"
> otype(u1)       # 查看u1类型
[1] "S3"

完全没有想到的结果，Person和u1都是S3类型的。如果R6是基于S3系统构建的，那么其实就可以解释R6类型与RC类型的不同，并且R6在传值和继承上会更有效率。

2.3 公有成员和私有成员

类的成员，包括属性和方法2部分。R6类定义中，可以分开设置公有成员和私有成员。我们设置类的公有成员，修改Person类的定义，在public参数中增加公有属性name，并通过hello()方法打印name的属性值，让这个R6的类更像是Java语言的JavaBean。在类中访问公有成员时，需要使用self对象进行调用。


> Person <- R6Class("Person",
+  public=list(
+    name=NA,                           # 公有属性
+    initialize = function(name){       # 构建函数方法
+      self$name <- name
+    },
+    hello = function(){                # 公有方法
+      print(paste("Hello",self$name))
+    }
+  )
+)

> conan <- Person$new('Conan')          # 实例化对象
> conan$hello()                         # 调用用hello()方法
[1] "Hello Conan"

接下来再设置类的私有成员，给Person类中增加private参数，并在公有函数有调用私有成员变量，调用私有成员变量时，要通过private对象进行访问。


> Person <- R6Class("Person",
+   public=list(                       # 公有成员
+     name=NA,
+     initialize = function(name,gender){
+       self$name <- name
+       private$gender<- gender        # 给私有属性赋值
+     },
+     hello = function(){
+       print(paste("Hello",self$name))
+       private$myGender()             # 调用私有方法
+     }
+   ),
+   private=list(                      # 私有成员
+     gender=NA,
+     myGender=function(){
+       print(paste(self$name,"is",private$gender))
+     }
+   )
+ )
> conan <- Person$new('Conan','Male')         # 实例化对象
> conan$hello()                               # 调用用hello()方法
[1] "Hello Conan"
[1] "Conan is Male"

在给Person类中增加私有成员时，通过private参数定义gender的私有属性和myGender()的私有方法。之得注意的是在类的内部，要访问私有成员时，需要用private对象进行调用。

那我直接访问公有属性和私有属性时，公有属性返回正确，而私有属性就是NULL值，并且访问私有方法不可见。


> conan$name            # 公有属性
[1] "Conan"
> conan$gender          # 私有属性
NULL
> conan$myGender()      # 私有方法
Error: attempt to apply non-function

进一步地，我们看看self对象和private对象，具体是什么。在Person类中，增加公有方法member()，在member()方法中分别打印self对象和private对象。


> Person <- R6Class("Person",
+   public=list(
+     name=NA,
+     initialize = function(name,gender){
+       self$name <- name
+       private$gender<- gender
+     },
+     hello = function(){
+       print(paste("Hello",self$name))
+       private$myGender()
+     },
+     member = function(){              # 用于测试的方法
+       print(self)
+       print(private)
+       print(ls(envir=private))
+     }
+   ),
+   private=list(
+     gender=NA,
+     myGender=function(){
+       print(paste(self$name,"is",private$gender))
+     }
+   )
+ )
>
> conan <- Person$new('Conan','Male')
> conan$member()                            # 执行member()方法
<Person>                                    # print(self)的输出
  Public:
    hello: function
    initialize: function
    member: function
    name: Conan

<environment: 0x0000000008cfc918>          # print(private)的输出
[1] "gender"   "myGender"                  # print(ls(envir=private))的输出

从测试结果，我们可以看出self对象，就是实例化的对象本身。private对象则是一个的环境空间，是self对象所在环境空间的中的一个子环境空间，所以私有成员只能在当前的类中被调用，外部访问私有成员时，就会找不到。在环境空间中保存私有成员的属性和方法，通过环境空间的访问控制让外部调用无法使用私有属性和方法，这种方式是经常被用在R包开发上的技巧。
3. R6类的主动绑定

主动绑定(Active bindings)是R6中一种特殊的函数调用方式，把对函数的访问表现为对属性的访问，主动绑定是属于公有成员。在类定义中，通过设置active参数实现主动绑定的功能，给Person类增加两个主动绑定的函数active和rand。


> Person <- R6Class("Person",
+   public = list(
+     num = 100
+   ),
+   active = list(                      # 主动绑定
+     active  = function(value) {
+       if (missing(value)) return(self$num +10 )
+       else self$num <- value/2
+     },
+     rand = function() rnorm(1)
+   )
+)

> conan <- Person$new()
> conan$num                   # 查看公有属性
[1] 100
> conan$active                # 调用主动绑定的active()函数，结果为 num +10= 100+10=100
[1] 110

给主动绑定的active函数传参数，这里传参数要用赋值符号”<-"，而不能是方法调用"()"。


> conan$active<-100    # 传参数
> conan$num            # 查看公有属性num
[1] 50
> conan$active         # 调用主动绑定的active()函数，结果为 num+10=50+10=60
[1] 60
> conan$active(100)    # 如果进行方法调用，其实会提示没有这个函数的
Error: attempt to apply non-function

我们再来调用rand函数，看看执行情况。


> conan$rand           # 调用rand函数
[1] -0.4767338
> conan$rand
[1] 0.1063623
> conan$rand<-99       # 传参出错
Error in (function ()  : unused argument (quote(99))

我们直接使用rand()函数完全没有问题，但给rand()函数传参数的时候就出现了错误，由于rand()函数没有定义参数，所以这个操作是不允许的。

通过主动绑定，可以把函数的行为转换成属性的行为，让类中的函数操作更加灵活。
4. R6类的继承关系

继承是面向对象的基本特征，R6的面向对象系统也是支持继承的。当你创建一个类时，可以继承另一个类做为父类存在。

先创建一个父类Person，包括公有成员和私有成员。


> Person <- R6Class("Person",
+   public=list(                            # 公有成员
+     name=NA,
+     initialize = function(name,gender){
+       self$name <- name
+       private$gender <- gender
+     },
+     hello = function(){
+       print(paste("Hello",self$name))
+       private$myGender()
+     }
+   ),
+   private=list(                           # 私有成员
+     gender=NA,
+     myGender=function(){
+       print(paste(self$name,"is",private$gender))
+     }
+   )
+ )

创建子类Worker继承父类Person，并在子类增加bye()公有方法。


> Worker <- R6Class("Worker",
+   inherit = Person,                # 继承，指向父类
+   public=list(
+     bye = function(){
+       print(paste("bye",self$name))
+     }
+   )
+ )

实例化父类和子类，看看继承关系是不是生效了。


> u1<-Person$new("Conan","Male")        # 实例化父类
> u1$hello()
[1] "Hello Conan"
[1] "Conan is Male"

> u2<-Worker$new("Conan","Male")        # 实例化子类
> u2$hello()
[1] "Hello Conan"
[1] "Conan is Male"
> u2$bye()
[1] "bye Conan"

我们看到继承确实生效了，在子类中我们并没有定义hello()方法，子类实例u2可以直接使用hello()方法。同时，子类u2的bye()方法，到了在父类中定义的name属性，输出结果完全正确的。

接下来，我们在子类中定义父类的同名方法，然后再查看方法的调用，看看是否会出现继承中函数重写的特征。修改Worker类，在子类定义private的属性和方法。


> Worker <- R6Class("Worker",
+   inherit = Person,
+   public=list(
+     bye = function(){
+       print(paste("bye",self$name))
+     }
+   ),
+   private=list(
+     gender=NA,
+     myGender=function(){
+       print(paste("worker",self$name,"is",private$gender))
+     }
+   )
+ )

实例化子类，调用hello()方法。


> u2<-Worker$new("Conan","Male")
> u2$hello()                    # 调用hello()方法
[1] "Hello Conan"
[1] "worker Conan is Male"

由于子类中的myGender()私有方法，覆盖了父类的myGender()私有方法，所以在调用hello()方法时，hello()方法中会调用子类中的myGender()方法实现，而忽略了父类中的myGender()方法。

如果在子类中想调用父类的方法，有一个办法是使用super对象，通过super$xx()的语法进行调用。


> Worker <- R6Class("Worker",
+   inherit = Person,
+   public=list(
+     bye = function(){
+       print(paste("bye",self$name))
+     }
+   ),
+   private=list(
+     gender=NA,
+     myGender=function(){
+       super$myGender()                                      # 调用父类的方法
+       print(paste("worker",self$name,"is",private$gender))
+     }
+   )
+ )

> u2<-Worker$new("Conan","Male")
> u2$hello()
[1] "Hello Conan"
[1] "Conan is Male"
[1] "worker Conan is Male"

在子类myGender()方法中，用super对象调用父类的myGender()方法，从输出可以看出，父类的同名方法也同时被调用了。
5. R6类的对象的静态属性

用面向对象的方法进行编程，那么所有变量其实都是对象，我们可以把一个实例化的对象定义成另一个类的属性，这样就形成了对象的引用关系链。

需要注意的一点是，当属性赋值为另一个R6的对象时，属性的值保存了对象的引用，而非对象实例本身。利用这个规则就可以实现对象的静态属性，也就是可以在多种不同的实例中是共享对象属性，类似于Java中的static属性一样。

下面用代码描述一下，就能很容易的理解。定义两个类A和B，A类中有一个公有属性x，B类中有一个公有属性a，a为A类的实例化对象。


> A <- R6Class("A",
+  public=list(
+    x = NULL
+  )
+ )
>
> B <- R6Class("B",
+  public = list(
+    a = A$new()
+  )
+ )

运行程序，实现B实例化对象对A实例化对象的调用，并给x变量赋值。


> b <- B$new()         # 实例化B对象
> b$a$x <- 1           # 给x变量赋值
> b$a$x                # 查看x变量的值
[1] 1

> b2 <- B$new()        # 实例化b2对象
> b2$a$x <- 2          # 给x变量赋值
> b2$a$x               # 查看x变量的值
[1] 2

> b$a$x                # b实例的a对象的x值也发生改变
[1] 2

从输出结果可以看到，a对象实现了在多个b实例的共享，当b2实例修改a对象x值的时候，b实例的a对象的x值也发生了变化。

这里有一种写法，我们是应该要避免的，就是通过initialize()方法赋值。


> C <- R6Class("C",
+  public = list(
+    a = NULL,
+    initialize = function() {
+      a <<- A$new()
+    }
+  )
+ )

> cc <- C$new()
> cc$a$x <- 1
> cc$a$x
[1] 1

> cc2 <- C$new()
> cc2$a$x <- 2
> cc2$a$x
[1] 2

> cc$a$x        # x值未发生改变
[1] 1

通过initialize()构建是的a对象，是对单独的环境空间中的引用，所以不能实现引用对象的共享。
6. R6类的可移植类型

在R6类的定义中，portable参数可以设置R6类的类型为可移植类型和不可移植类型。可移植类型和不可移植类型主要有2个明显的特征。

    可移植类型支持跨R包的继承；不可移植类型，在跨R包继承的时候，兼容性不太好。
    可移植类型必须要用self对象和private对象来访问类中的成员，如self$x,private$y；不可移植类型，可以直接使用变量x,y，并通过<<-实现赋值。

本文中使用的是R6的最新版本2.0，所以默认创建的是可移植类型。所以，当我们要考虑是否有跨包继承的需求时，可以在可移植类型和不可移植类型之间进行选择。

我们比较一下RC类型，R6的可移植类型和R6的不可移植类型三者的区别，定义一个简单的类，包括一个属性x和两个方法getx(),setx()。


> RC <- setRefClass("RC",                  # RC类型的定义
+   fields = list(x = 'Hello'),
+   methods = list(
+     getx = function() x,
+     setx = function(value) x <<- value
+   )
+ )
> rc <- RC$new()
> rc$setx(10)
> rc$getx()
[1] 10

创建一个行为完全一样的不可移植类型的R6类。


> NR6 <- R6Class("NR6",                # R6不可移植类型
+   portable = FALSE,
+   public = list(
+     x = NA,
+     getx = function() x,
+     setx = function(value) x <<- value
+   )
+ )
> np6 <- NR6$new()
> np6$setx(10)
> np6$getx()
[1] 10

再创建一个行为完全一样的可移植类型的R6类。


> PR6 <- R6Class("PR6",
+   portable = TRUE,            # R6可移植类型
+   public = list(
+    x = NA,
+    getx = function() self$x,
+    setx = function(value) self$x <- value
+   )
+ )
> pr6 <- PR6$new()
> pr6$setx(10)
> pr6$getx()
[1] 10

从这个例子中，可移植类型的R6类和不可移植类型的区别在，就在于self对象的使用。
7. R6类的动态绑定

对于静态类型的编程语言来说，一旦类定义后，就不能再修改类中的属性和方法，像反射这样的高开销的特殊操作除外。 而对于动态类型的编程语言来说，通常不存在这样的限制，可以任意修改其类的结构或者已实例化的对象的结构。 R作为动态语言来说，同样是支持动态变量修改的，基于S3类型和S4类型可以通过泛型函数动态地增加函数定义，但RC类型是不支持的，再次感觉到了R语言中面向对象系统设计的奇葩了。

R6包已考虑这个情况，提供了一种动态设置成员变量的方法用$set()函数。


> A <- R6Class("A",
+   public = list(
+     x = 1,
+     getx = function() x
+   )
+ )
> A$set("public", "getx2", function() self$x*2)     # 动态增加getx2()方法
> s <- A$new()
> s                     # 查看实例化对象的结构
<A>
  Public:
    getx: function
    getx2: function
    x: 1
> s$getx2()             # 调用getx2()方法
[1] 20

同样地，属性也可以动态修改，动态改变x属性的值。


> A$set("public", "x", 10, overwrite = TRUE)     # 动态改变x属性
> s <- A$new()
> s$x                                            # 查看x属性
[1] 10
> s$getx()                                       # 调用getx()方法，可移植类型x变量丢失
Error in s$getx() : object 'x' not found

由于A类默认是可移植类型的，所以在使用x变量时应该通过self对象来访问，否则动态成员修改的时候，就会出现错误，我们把getx中的x改为self$x。


> A <- R6Class("A",
+  public = list(
+    x = 1,
+    getx = function() self$x     # 修改为self$x
+  )
+ )
> A$set("public", "x", 10, overwrite = TRUE)
> s <- A$new()
> s$x
[1] 10
> s$getx()                        # 调用getx()方法
[1] 10

对于可移植类型和不可移植类型，建议大家养成习惯都使用self和private对象进行访问。
8. R6类的打印函数

R6提供了用于打印的默认方法print()，每当要打印实例化对象时，都会调用这个默认的print()方法，有点类似于Java类中默认的toString()方法。

我们可以覆盖print()方法，使用自定义的打印提示。


> A <- R6Class("A",
+  public = list(
+    x = 1,
+    getx = function() self$x
+  )
+ )
> a <- A$new()
> print(a)             # 使用默认的打印方法
<A>
  Public:
    getx: function
    x: 1

自定义打印方法，覆盖print()方法。


> A <- R6Class("A",
+    public = list(
+      x = 1,
+      getx = function() self$x,
+      print = function(...) {
+        cat("Class <A> of public ", ls(self), " :", sep="")
+        cat(ls(self), sep=",")
+        invisible(self)
+      }
+    )
+ )
> a <- A$new()
> print(a)
Class <A> of public getxprintx :getx,print,x

通过自定义的方法，就可以覆盖系统默认的方法，从而输出我们想显示的文字。
9. 实例化对象的存储

R6是基于S3面向对象系统的构建，而S3类型又是一种比较松散的类型，会造成用户环境空间的变量泛滥的问题。R6提供了一种方式，设置R6Class()的class参数，把类中定义的属性和方法统一存储到一个S3对象中，这种方式是默认的。另一种方式为，把把类中定义的属性和方法统一存储到一个单独的环境空间中。

我们看查看一下默认的情况，class=TRUE，实例化后的a对象，就是一个S3的类。


> A <- R6Class("A",
+  class=TRUE,
+  public = list(
+    x = 1,
+    getx = function() self$x
+  )
+ )
> a <- A$new()
> class(a)
[1] "A"  "R6"
> a
<A>
  Public:
    getx: function
    x: 1

当class=FALSE时，实例化后的a对象，是一个环境空间，在环境空间中存储了类的变量数据。


> B <- R6Class("B",
+   class=FALSE,
+   public = list(
+     x = 1,
+     getx = function() self$x
+   )
+ )
> b <- B$new()
> class(b)
[1] "environment"
> b
<environment: 0x000000000d83c970>
> ls(envir=b)
[1] "getx" "x"

实例化对象的存储还有另外一方面的考虑，由于类中的变量都是存在于一个环境空间中的，我们也可以通过手动的方式找到这个环境空间，从而进行变量的增加或修改。 如果随意地对环境空间中的变量进行修改，那么会给我们的程序带来一些安全上的风险，所以为了预防安全上的问题，可以通过R6Class()的lock参数所定环境空间，不允许动态修改，默认值为锁定状态不能修改。


> A <- R6Class("A",
+   lock=TRUE,       # 锁定环境空间
+   public = list(
+     x = 1
+   )
+ )
> s<-A$new()
> ls(s)         # 查看s环境空间的变量
[1] "x"
> s$aa<-11      # 增加新变量，错误
Error in s$aa <- 11 : cannot add bindings to a locked environment
> rm("x",envir=s)       # 删除原有变量，错误
Error in rm("x", envir = s) :
  cannot remove bindings from a locked environment

如果不锁定环境空间，让lock=FALSE，则环境空间处于完全开放的状态，可以任意进行变量的修改。


> A <- R6Class("A",
+  lock=FALSE,         # 不锁定环境空间
+  public = list(
+    x = 1
+  )
+ )
> s<-A$new()
> ls(s)         # 查看s环境空间的变量
[1] "x"
> s$aa<-11      # 增加变量
> ls(s)
[1] "aa" "x"
> rm("x",envir=s)    # 删除变量
> ls(s)
[1] "aa"

通过上面对R6的介绍，我就基本掌握R6面向对象系统的知识。接下来，我们做一个简单的例子，应用一下R6的面向对象编程。
10. R6面向对象系统的案例

我们用R6的面向对象系统，来构建一个图书分类的使用案例。

任务一：定义图书的静态结构

以图书(book)为父类，包括R，Java，PHP 的3个分类，在book类中定义私有属性及公有方法。

r6-class

定义图书系统的数据结构，包括父类的结构 和 3种型类的图书。


> Book <- R6Class("Book",            # 父类
+    private = list(
+      title=NA,
+      price=NA,
+      category=NA
+    ),
+   public = list(
+     initialize = function(title,price,category){
+       private$title <- title
+       private$price <- price
+       private$category <- category
+     },
+     getPrice=function(){
+       private$price
+     }
+   )
+ )

> R <- R6Class("R",     # 子类R图书
+    inherit = Book
+ )
> Java <- R6Class("JAVA",  # 子类JAVA图书
+   inherit = Book
+ )
> Php <- R6Class("PHP",    # 子类PHP图书
+   inherit = Book
+ )

创建3个实例化对象，R语言图书《R的极客理想-工具篇》，JAVA语言图书《Java编程思想》，PHP语言图书《Head First PHP & MySQL》，并获得图书的定价。


> r1<-R$new("R的极客理想-工具篇",59,"R")
> r1$getPrice()
[1] 59

> j1<-Java$new("Java编程思想",108,"JAVA")
> j1$getPrice()
[1] 108

> p1<-Java$new("Head First PHP & MySQL",98,"PHP")
> p1$getPrice()
[1] 98

任务二：正逢双11对各类图书打折促销

我们设计一种打折规则，用来促进图书的销售，这个规则纯属虚构。

    所有图书9折
    JAVA图书7折，不支持重复打折
    为了推动R图书的销售，R语言图书7折，并支持重复打折
    PHP图书无特别优惠

根据打折规则，图书都可以被打折，那么打折就可以作为图书对象的一个行为，然后R, Java, PHP的3类图书，分别还有自己的打折规则，所以是一种多态的表现。

我们修改父类的定义，增加打折的方法discount()，默认设置为9折，满足第一条规则。


> Book <- R6Class("Book",
+   private = list(
+     title=NA,
+     price=NA,
+     category=NA
+   ),
+   public = list(
+     initialize = function(title,price,category){
+       private$title <- title
+       private$price <- price
+       private$category <- category
+     },
+     getPrice=function(){
+       p<-private$price*self$discount()
+       print(paste("Price:",private$price,", Sell out:",p,sep=""))
+     },
+     discount=function(){
+       0.9
+     }
+   )
+ )

3个子类，分别对应自己的打折规则，分别进行修改。

    给JAVA子类增加 discount()方法，用于覆盖父类的discount()方法，让JAVA图书7折，不支持重复打折，从而满足第二条规则。
    给R子类增加 discount()方法，在子类的discount()方法中调用父类的discount()方法，让支持 R图书7折和9折的折上折，从而满足第三条规则。
    PHP子类，没有修改，完全遵循第一条规则的。


        > Java <- R6Class("JAVA",
        +   inherit = Book,
        +   public = list(
        +     discount=function(){
        +       0.7
        +     }
        +   )    
        + )
        > 
        > R <- R6Class("R",
        +   inherit = Book,
        +   public = list(
        +     discount=function(){
        +       super$discount()*0.7
        +     }
        +   )             
        + )
        > 
        > Php <- R6Class("PHP",
        +   inherit = Book       
        + )

        分别查看3本图书的折后价格。


        > r1<-R$new("R的极客理想-工具篇",59,"R")
        > r1$getPrice()
        [1] "Price:59, Sell out:37.17"   # 59 * 0.9 *0.7= 37.17
        >
        > j1<-Java$new("Java编程思想",108,"JAVA")
        > j1$getPrice()
        [1] "Price:108, Sell out:75.6"    # 108 *0.7= 75.6
        >
        > p1<-Php$new("Head First PHP & MySQL",98,"PHP")
        > p1$getPrice()
        [1] "Price:98, Sell out:88.2"      # 98 *0.9= 88.2

        R图书打折最多，享受7折和9折的折上折优惠， 59 * 0.9 * 0.7= 37.17；Java图书享受7折优惠，108 *0.7= 75.6；PHP图书享受9折优惠 98 *0.9= 88.2。

        通过这个实例，我们用R6的方法实现了面向对象编程中的封装、继承和多态的3个特征，证明R6是一种完全的面向对象的实现。R6类对象系统，提供了一种可兼容的面向对象实现方式，更接近于其他的编程语言上的面向对象的定义，由于R6底层基于S3来实现的，所以比RC的类更加有效果。

        我们一共介绍了4种R语言的面向对象体系结构，选择自己理解的，总有一种会适合你。

        转载请注明出处：
        http://blog.fens.me/r-class-r6/

        打赏作者

        This entry was posted in R语言实践

赞助商广告(购买)
[珠峰培训]

    dj123jary

    一直有个疑问，R的长处在于统计和算法设计，让R去实现面向对象，进行面向对象编程，是不是有点舍长取短啊，问下楼主，R语言实现面向对象，主要是不是想用面向对象的思想去设计算法啊
        Conan Zhang

        面向对象主要由于解决复杂问题的设计，当你的R程序超过1万行时，用面向函数的编程方法就不可维护了。
    淡忘~浅思

    嘿嘿 觉得贵站不错 已经将贵站加入 http://www.ido321.com/daohang/daohang.php 综合资讯类 如有错误请指正
        Conan Zhang

        谢谢！
    ppl

    animal = R6Class(“animal”, list(mother = NA, foreign = NA, say = NA))

    cat = animal$new()

    cat$mother = “喵喵”

    cat$foreign = “汪汪”

    athome = TRUE

    if (athome) {

    cat$say = function() print(self$mother)

    } else {

    cat$say = function() print(self$foreign)

    }

    cat$say() # error
        ppl

        实例里面的函数好像不能用self,或者得用其他办法搞…不太方便实现单例模式的样子…或者还是把cat定义成class会好点么…
            Conan Zhang

            你的代码有问题，self只能用在R6Class的定义里面。

            你单独做了函数空间，这里根本没有self变量。
            function() print(self$mother)

            先按规范写程序，开始不要想当然。
                ppl

                r里面函数用到上层的变量很自然啊
                f = function(){
                x=10
                ff = function(){
                print(x)
                }
                ff()
                }

                f()
                    ppl

                    run的时候是global的env么…好像前面这种需求是比较麻烦…
                    Conan Zhang

                    用到上层变量没问题，你之前的程序self不是上层变量。
    chilly

    笔误：7. R6类的动态绑定
    > s$getx2() # 调用getx2()方法
    [1] 20
    应该为
    [1] 2

    站内导航
        R的极客理想系列文章
        从零开始nodejs系列文章
        用IT技术玩金融系列文章
        跨界知识聚会系列文章
        Hadoop家族系列文章
        AngularJS体验式编程系列文章
        RHadoop实践系列文章
        无所不能的Java系列文章
        ubuntu实用工具系列文章
        R利剑NoSQL系列文章
        MongoDB部署实验系列文章
        让Hadoop跑在云端系列文章
        自己搭建VPS系列文章
        架构师的信仰系列文章
        算法为王系列文章
        我的博客我的SEO系列文章
        创造可视化系列文章
        创业者的囧境系列文章
        写作计划列表
        关于站长
        投放广告
    最新评论
        2016CDAS中国数据分析师行业峰会:如何用R语言进行量化分析 | 粉丝日志 on 跨界知识聚会系列文章
        snowdream on 在Ubuntu中安装Docker
        mao on Mongoose使用案例–让JSON数据直接入库MongoDB
        当R语言遇上Docker | 粉丝日志 on R的极客理想系列文章
        在Ubuntu中安装Docker | 粉丝日志 on R语言解读自回归模型
        在Ubuntu中安装Docker | 粉丝日志 on 2016天善智能交流会第22场: R语言为量化而生
        在Ubuntu中安装Docker | 粉丝日志 on ubuntu实用工具系列文章
        R语言解读自回归模型 | 粉丝日志 on R的极客理想系列文章
        Conan Zhang on R语言构建配对交易量化模型
        taipeialpha on R语言构建配对交易量化模型
        Conan Zhang on R语言构建配对交易量化模型
        Conan Zhang on R语言构建配对交易量化模型
        Francis Tsai on R语言构建配对交易量化模型
        黃冠儒 on Nodejs异步流程控制Async
        taipeialpha on R语言构建配对交易量化模型
    最新文章
        2016CDAS中国数据分析师行业峰会:如何用R语言进行量化分析
        当R语言遇上Docker
        在Ubuntu中安装Docker
        R语言解读自回归模型
        R语言量化投资常用包总结
        R语言跨界调用C++
        R语言解读多元线性回归模型
        R语言解读一元线性回归模型
        R语言中文分词包jiebaR
        2016天善智能交流会第22场: R语言为量化而生
        R语言为量化而生
        超高性能数据处理包data.table
        掌握R语言中的apply函数族
        R语言高效的管道操作magrittr
        R语言字符串处理包stringr
        R语言构建配对交易量化模型
        尚书视频群活动:投资分析师笔试题
        构建自己的Aleax查询服务
        OpenBlas让R的矩阵计算加速
        2015lopdev生态联盟开发者大会:股市中的R语言量化算法模型

Copyright © 2016 All rights reserved.
Designed by NattyWP


#########################


    Categories
        Dataguru作业
        Hadoop实践
        IT相关知识
        Javascript语言实践
        JAVA语言实践
        R语言实践
        SEO优化
        其他语言
        创业
        可视化技术
        操作系统
        数据库
        数据挖掘
        晒粉丝
        架构设计
        活动聚会
        游戏
        程序算法
        网络技术
        虚拟化实践
        金融
        面试
        黑客攻防
    Twitter Updates

    Follow us on Twitter

+

    粉丝日志

跨界的IT博客|Hadoop家族, R, RHadoop, Nodejs, AngularJS, NoSQL, IT金融

    R语言实践 »
    撬动R内核的高级工具包pryr

    @晒粉丝
    @每日中国天气

Posted:
Apr 5, 2014
Tags:
pryr
R
RC
R包
S3
S4
Comments:
Comments Off on 撬动R内核的高级工具包pryr
撬动R内核的高级工具包pryr

R的极客理想系列文章，涵盖了R的思想，使用，工具，创新等的一系列要点，以我个人的学习和体验去诠释R的强大。

R语言作为统计学一门语言，一直在小众领域闪耀着光芒。直到大数据的爆发，R语言变成了一门炙手可热的数据分析的利器。随着越来越多的工程背景的人的加入，R语言的社区在迅速扩大成长。现在已不仅仅是统计领域，教育，银行，电商，互联网….都在使用R语言。

要成为有理想的极客，我们不能停留在语法上，要掌握牢固的数学，概率，统计知识，同时还要有创新精神，把R语言发挥到各个领域。让我们一起动起来吧，开始R的极客理想。

关于作者：

    张丹(Conan), 程序员Java,R,PHP,Javascript
    weibo：@Conan_Z
    blog: http://blog.fens.me
    email: bsspirit@gmail.com

转载请注明出处：
http://blog.fens.me/r-pryr/

r-pryr

前言

随着对R语言的使用越来越深入，我们需要更多的对R语言底层的进行了解，比如数据结构S3,S4对象，函数的调用机制等。pryr包就是可以帮助我们了解R语言运行机制的工具。利用pryr包，我们可以更容易地接触R的核心。

本文为R语言的高级内容。

目录

    pryr介绍
    pryr安装
    pryr使用

1 pryr介绍

pryr包是一个深层的了解R语言运行机制的工具，可以帮助我们更加贴近R语言的核心。为了能开发出更高级R语言应用，需要我们更深入地懂R。

pryr的API介绍

内部实现工具：

    promise对象：uneval(), is_promise()
    查询环境变量： where(), rls(), parenv()
    查看闭包函数变量： unenclose()
    函数调用关系：call_tree()
    查看对象底层对应的C语言类型 address(), refs(), typename()
    跟踪对象是否被修改track_copy()

面向对象检查：

    判断属于哪种类型对象： otype()
    判断属于哪种类型函数： ftype()

辅助编程函数：

    通过参数创建函数：make_function(), f()
    变量表达式替换：substitute_q(), subs()
    批量修改对象： modify_lang()
    快速创建list对象：dots(), named_dots()
    建匿名函数调用：partial()
    找符合条件函数：find_funs()

代码简化工具：

    创建延迟或直接绑定：%<d-%, %<a-%
    创建常量绑定：%<c-%
    重新绑定：rebind, <<-

2 pryr安装

系统环境

    Linux Ubuntu 12.04.2 LTS 64bit
    R 3.0.1 x86_64-pc-linux-gnu (64-bit)

由于项目pryr，还没有发布到CRAN，仅支持从github安装。我们要使用devtools包来通过github来安装。关于devtools包的使用，请参考文章：在巨人的肩膀前行 催化R包开发

pryr安装


~ R

# 安装devtools
# install.packages("devtools")

> library(devtools)
> install_github("pryr")

注：我尝试在Win7下安装，但出现了编译错误。
3 pryr使用

    3.1 创建匿名函数f()
    3.2 通过参数创建函数make_function()
    3.3 创建匿名函数调用partial()
    3.4 变量表达式替换substitute_q(), subs()
    3.5 面向对象类型判断otype(),ftype()
    3.6 查看对象底层的C语言类型 address(), refs(), typename()
    3.7 查看对象是否被修改track_copy()
    3.8 查看闭包函数变量 unenclose()
    3.9 批量修改对象 modify_lang()
    3.10 快速创建list对象 dots(), named_dots()
    3.11 查找符合条件函数 fun_calls()
    3.12 查询环境变量 where(), rls(), parenv()
    3.13 打印函数调用关系 call_tree(), ast()
    3.14 promise对象 uneval(), is_promise()
    3.15 数据绑定%<a-%, %<c-%，%<d-%, rebind,<<-

3.1 创建匿名函数f()

通过使用f()函数，可以实现创建匿名函数，在单行完成函数定义、调用、运算的操作。


# 创建一个匿名函数
> f(x + y)
function (x, y)
x + y

# 创建一个匿名函数，并赋值计算
> f(x + y)(1, 10)
[1] 11

# 创建一个匿名函数，指定参数和默认值
> f(x, y = 2, x + y)
function (x, y = 2)
x + y

# 创建一个匿名函数，并赋值计算
> f(x, y = 2, x + y)(1)
[1] 3

# 创建一个匿名函数，多行运行，并赋值计算
>  f({y <- runif(1); x + y})(3)
[1] 3.7483

3.2 通过参数创建函数make_function()

通过使用make_function()函数，可以通过make_function()函数的3个参数，来创建一个普通的函数，从而现实动态性。

make_function()函数的3个参数分别是：

    生成函数的参数部分, list类型
    生成函数的表达式部分, 语法表达式, call类型
    生成函数的系统环境部分, environment类型


# 创建标准的函数
> f <- function(x) x + 3
> f
function(x) x + 3

# 运行函数
> f(12)
[1] 15

# 通过参数创建函数
> g <- make_function(alist(x = ), quote(x + 3))
> g
function (x)
x + 3

# 运行函数
> g(12)
[1] 15

3.3 创建匿名函数调用partial()

使用partial()函数，可以减少参数定义的过程，方便匿名函数的调用


# 定义一个普通的函数
> compact1 <- function(x) Filter(Negate(is.null), x)
> compact1
function(x) Filter(Negate(is.null), x)

# 通过partial定义的匿名函数
> compact2 <- partial(Filter, Negate(is.null))
> compact2
function (...)
Filter(Negate(is.null), ...)

我们看到，上面的两个函数定义很像，一个是有明确的参数定义，另一个用partial()则是隐式的参数定义。

再看另一例：输出runif()均匀分布的结果


# 标准函数实现
> f1 <- function(){runif(rpois(1, 5))}
> f1()
[1] 0.09654228 0.93089395 0.85530142 0.33021067 0.16728877 0.79099825
> f1()
[1] 0.6166580 0.2100876 0.3125176

# 通过partial的匿名函数调用
> f2 <- partial(runif, n = rpois(1, 5))
> f2()
[1] 0.25955143 0.12858459 0.04994997 0.11505708 0.10509429
> f2()
[1] 0.9710866 0.1469317

3.4 变量表达式替换 substitute_q(), subs()

使用substitute_q()函数，可以对表达式调用，直接进行参数替换


# 定义一个表达式调用
>  x <- quote(a + b)
> class(x)
[1] "call"

# 对x调用参数替换，无效
>  substitute(x, list(a = 1, b = 2))
x

# 对直接变量参数替换
> substitute(a+b, list(a = 1, b = 2))
1 + 2

# 对x调用参数替换
>  substitute_q(x, list(a = 1, b = 2))
1 + 2

执行参数调用
> eval(substitute_q(x, list(a = 1, b = 2)))
[1] 3

使用subs()函数，可以直接对变量表达式替换


> a <- 1
> b <- 2

# 对变量表达式替换，无效
> substitute(a + b)
a + b

# 对变量表达式替换
> subs(a + b)
1 + 2

3.5 面向对象类型判断otype(),ftype()

判断对象类型：通过otype()函数可以很容易的分辨出基本类型，S3类型，S4类型，RC类型的对象，比起内置的类型检查要高效的多。


# 基本类型
> otype(1:10)
[1] "primitive"
> otype(c('a','d'))
[1] "primitive"
> otype(list(c('a'),data.frame()))
[1] "primitive"

# S3类型
> otype(data.frame())
[1] "S3"

# 自定的S3类型
> x <- 1
> attr(x,'class')<-'foo'
> is.object(x)
[1] TRUE
> otype(x)
[1] "S3"

# S4类型
> setClass("Person",slots=list(name="character",age="numeric"))
> alice<-new("Person",name="Alice",age=40) 
> isS4(alice)
[1] TRUE
> otype(alice)
[1] "S4"

# RC类型
> Account<-setRefClass("Account")
> a<-Account$new()
> class(a)
[1] "Account"
attr(,"package")
[1] ".GlobalEnv"

> is.object(a)
[1] TRUE
> isS4(a)
[1] TRUE
> otype(a)
[1] "RC"

判断函数类型：通过ftype()函数可以很容易的分辨出function,primitive,S3,S4,internal类型的函数，比起内置的类型检查要高效的多。


# 标准函数
> ftype(`%in%`)
[1] "function"

# primitive函数
> ftype(sum)
[1] "primitive" "generic"

# internal函数
> ftype(writeLines)
[1] "internal"
> ftype(unlist)
[1] "internal" "generic"

# S3函数
>  ftype(t.data.frame)
[1] "s3"     "method"
> ftype(t.test)
[1] "s3"      "generic"

# S4 函数
> setGeneric("union")
[1] "union"
> setMethod("union",c(x="data.frame",y="data.frame"),function(x, y){unique(rbind (x, y))})
[1] "union"
> ftype(union)
[1] "s4"      "generic"

# RC函数
> Account<-setRefClass("Account",fields=list(balance="numeric"),methods=list(
+   withdraw=function(x){balance<<-balance-x},
+   deposit=function(x){balance<<-balance+x}))
> a<-Account$new(balance=100)
> a$deposit(100)
> ftype(a$deposit)
[1] "rc"     "method"

3.6 查看对象底层的C语言类型 address(), refs(), typename()

我们可以通过address(), refs(), typename()来查看，R对象对应的底层C语言实现的类型。

    typename: 返回C语言类型名
    address: 返回内存地址
    refs: 返回指针数字

查看变量


# 定义一个变量x
>  x <- 1:10

# 打印C语言类型名
> typename(x)
[1] "INTSXP"

# 返回指针
> refs(x)
[1] 1

# 打印内存地址
> address(x)
[1] "0x365f560"

# 定义一个list对象
>  z <- list(1:10)

# 打印C语言类型名
>  typename(z)
[1] "VECSXP"

# 延迟赋值
> delayedAssign("a", 1 + 2)

# 打印C语言类型名
> typename(a)
[1] "PROMSXP"

# 打印a变量
> a
[1] 3
> typename(a)
[1] "PROMSXP"

# 定义变量b，与a变量对比
> b<-3
> typename(b)
[1] "REALSXP"

3.7 查看对象是否被修改track_copy()

使用track_copy()函数，我们可以跟踪对象，并检查是被修改过，通过内存地址进行判断。


# 定义一个变量
> a<-1:3
> a
[1] 1 2 3

# 查看变量的内存地址
> address(a)
[1] "0x2ad77f0"

# 跟踪变量
> track_a <- track_copy(a)

# 检查变更是否被修改，没有修改
> track_a()

# 给变量赋值
> a[3] <- 3L

# 查看变量的内存地址，发现没有变化
> address(a)
[1] "0x2ad77f0"

# 检查变量是否被修改，没有修改
>  track_a()

# 再次给变量赋值
> a[3]<-3

# 查看变量的内存地址，内存地址改变
> address(a)
[1] "0x37f8580"

# 检查变量是否被修改，已被修改，变成一份copy
>  track_a()
a copied

3.8 查看闭包函数变量 unenclose()

使用unenclose()给闭包环境的变量的赋值


# 定义一个嵌套函数power
>  power <- function(exp) {
+      function(x) x ^ exp
+  }

# 调用闭包函数
>  square <- power(2)
>  cube <- power(3)

# 查看square函数，exp变量并显示没有赋值后的结果
> square
function(x) x ^ exp
<environment: 0x4055f28>

# 查看square函数，exp变量显示赋值后的结果
> unenclose(square)
function (x)
x^2

# 执行square函数
> square(3)
[1] 9

3.9 批量修改对象 modify_lang()

这是一个神奇的函数，可以方便地替换 list对象、表达式、函数 中的变量定义。

接下来，我们尝试替换list对象中定义的变量a为变量b


# 定义list对象及内部数据
> examples <- list(
+        quote(a <- 5),
+        alist(a = 1, c = a),
+        function(a = 1) a * 10,
+        expression(a <- 1, a, f(a), f(a = a))
+      )

# 查看对象数据
> examples
[[1]]
a <- 5

[[2]]
[[2]]$a
[1] 1

[[2]]$c
a

[[3]]
function (a = 1)
a * 10

[[4]]
expression(a <- 1, a, f(a), f(a = a))

# 定义转换函数a_to_b，
>  a_to_b <- function(x) {
+        if (is.name(x) && identical(x, quote(a))) return(quote(b))
+        x
+  }

# 批量修改对象，替换examples对象中，所有的变量a变成变量b
> modify_lang(examples, a_to_b)
[[1]]
b <- 5

[[2]]
[[2]]$a
[1] 1

[[2]]$c
b

[[3]]
function (a = 1)
b * 10

[[4]]
expression(b <- 1, b, f(b), f(a = b))

3.10 快速创建list对象 dots(), named_dots()

使用dots()函数，我们可以快速创建list对象，通过参数设置来list的数据的名字和值。


# 初始化一个变量
> y <- 2

# 创建list对象
> dots(x = 1, y, z = )
$x
[1] 1

[[2]]
y

$z

# 查看对象类型
> class(dots(x = 1, y, z = ))
[1] "list"

# 查看对象的内部结果
> str(dots(x = 1, y, z = ))
List of 3
 $ x: num 1
 $  : symbol y
 $ z: symbol

使用named_dots()函数，同样我们可以快速创建list对象，通过参数设置list的数据的名字和值。与dots()函数的不同点在于，参数变量就是list的数据的名字，如 变量y在没有赋值情况下，也被用作list数据的名字，并可以通过$y来得到值。


# 创建list对象
> named_dots(x = 1, y, z =)
$x
[1] 1

$y
y

$z

# 查看对象类型
> class(named_dots(x = 1, y, z =))
[1] "list"

# 查看对象的内部结果
> str(named_dots(x = 1, y, z =))
List of 3
 $ x: num 1
 $ y: symbol y
 $ z: symbol

3.11 查找符合条件函数 fun_calls()

使用fun_calls()函数，可以通过过滤条件快速找到函数。

查找base包中所有的函数，找到匹配match.fun字符串的函数名


> find_funs("package:base", fun_calls, "match.fun", fixed = TRUE)
Using environment package:base
 [1] "apply"  "eapply" "Find"   "lapply" "Map"    "mapply" "Negate" "outer"
 [9] "Reduce" "sapply" "sweep"  "tapply" "vapply"

# 查看Map函数，检查是否包括match.fun字符串
> Map
function (f, ...)
{
    f <- match.fun(f)
    mapply(FUN = f, ..., SIMPLIFY = FALSE)
}
<bytecode: 0x21688e0>
<environment: namespace:base>

查找stats包中所有的函数的参数，找到精确匹配FUN字符串的函数名


> find_funs("package:stats", fun_args, "^FUN$")
Using environment package:stats
[1] "addmargins"           "aggregate.data.frame" "aggregate.ts"
[4] "ave"                  "dendrapply"

# 查看ave函数源代码，检查参数名是否有FUN字符串
> ave
function (x, ..., FUN = mean)
{
    if (missing(...))
        x[] <- FUN(x)
    else {
        g <- interaction(...)
        split(x, g) <- lapply(split(x, g), FUN)
    }
    x
}
<bytecode: 0x2acba70>
<environment: namespace:stats>

3.12 查询环境变量 where(), rls(), parenv()

使用where()函数，可以定位对象的在R环境中的位置，有点像Linux的命令whereis。


# 定义一个变量x
> x <- 1
> where("x")
<environment: R_GlobalEnv>

# 查询t.test函数的位置
> where("t.test")
<environment: package:stats>
attr(,"name")
[1] "package:stats"
attr(,"path")
[1] "/usr/lib/R/library/stats"

> t.test
function (x, ...)
UseMethod("t.test")
<bytecode: 0x1ae9bc8>
<environment: namespace:stats>

# 查询mean函数的位置
> where("mean")
<environment: base>

# 查询where函数的位置
> where("where")
<environment: package:pryr>
attr(,"name")
[1] "package:pryr"
attr(,"path")
[1] "/home/conan/R/x86_64-pc-linux-gnu-library/3.0/pryr"

使用rls()函数，可以显示出当前环境的所有变量，包括当前变量，全局变量，空环境变量，命令空间环境变量。


# 打印当前环境的变量
> ls()
 [1] "a"                "Account"          "alice"            "a_to_b"
 [5] "b"                "compact1"         "compact2"         "examples"
 [9] "f"                "f1"               "f2"               "g"
[13] "myGeneric"        "my_long_variable" "plot2"            "union"
[17] "x"                "y"

# 打印所有环境的变量
> rls()
[[1]]
 [1] "a"                          "Account"
 [3] "alice"                      "a_to_b"
 [5] "b"                          ".__C__Account"
 [7] "compact1"                   "compact2"
 [9] ".__C__Person"               "examples"
[11] "f"                          "f1"
[13] "f2"                         "g"
[15] ".__global__"                "myGeneric"
[17] "my_long_variable"           "plot2"
[19] ".Random.seed"               ".requireCachedGenerics"
[21] ".__T__myGeneric:.GlobalEnv" ".__T__union:base"
[23] "union"                      "x"
[25] "y"

使用parenv()函数，可以找到函数调用的上一级环境，从而可以追溯到函数的根。


# 定义一个3层嵌套函数
> adder <- function(x) function(y) function(z) x + y + z

# 调用第一层函数
> add2 <- adder(2)

# 查看函数
> add2
function(y) function(z) x + y + z
<environment: 0x323c000>

# 调用第二层函数
> add3<-add2(3)
> add3
function(z) x + y + z
<environment: 0x3203558>

# 查内层函数的上一级环境
>  parenv(add3)
<environment: 0x323c000>
>  parenv(add2)
<environment: R_GlobalEnv>

3.13 找印调用关系 call_tree(), ast()

使用call_tree()函数，可以打印出表达式的调用关系


# 嵌套函数语句调用
>  call_tree(quote(f(x, 1, g(), h(i()))))
\- ()
  \- `f
  \- `x
  \-  1
  \- ()
    \- `g
  \- ()
    \- `h
    \- ()
      \- `i

# 条件语句调用
> call_tree(quote(if (TRUE) 3 else 4))
\- ()
  \- `if
  \-  TRUE
  \-  3
  \-  4

# 表达式语句调用
> call_tree(expression(1, 2, 3))
\-  1
\-  2
\-  3

使用ast()函数，可以直接打印语句的调用关系


# 嵌套表达式语句
> ast(f(x, 1, g(), h(i())))
\- ()
  \- `f
  \- `x
  \-  1
  \- ()
    \- `g
  \- ()
    \- `h
    \- ()
      \- `i

# 条件语句
> ast(if (TRUE) 3 else 4)
\- ()
  \- `if
  \-  TRUE
  \-  3
  \-  4

# 函数定义
> ast(function(a = 1, b = 2) {a + b})
\- ()
  \- `function
  \- []
    \ a = 1
    \ b = 2
  \- ()
    \- `{
    \- ()
      \- `+
      \- `a
      \- `b
  \- 

# 函数调用
> ast(f()()())
\- ()
  \- ()
    \- ()
      \- `f

3.14 promise对象 uneval(), is_promise()

promise对象：是R语言中延迟加载机制的一部分，包含三个部分：值，表达式和环境。当函数被调用时参数进行匹配，然后每个形式参数会绑定到一个promise上。表达式有形式参数和存储在promise里的函数的指针。

简单来说，延迟加载调用过程就是，先把函数指针存储在promise对象里，并不马上调用；当其实调用发生时，从promise对象里找到函数指针，进行函数的调用。


# 定义变量并赋值
> x <- 10

# 检查是否 promise模式
> is_promise(x)
[1] FALSE

# 匿名函数调用，检查是否 promise模式
> (function(x) is_promise(x))(x = 10)
[1] TRUE

使用uneval()函数，可以在延迟赋值的过程中，打印函数调用方法，而不执行赋值函数调用。


# 定义一个函数
> f <- function(x) {
+     uneval(x)
+ }

# 打印函数调用
> f(a + b)
a + b

> class(f(a+b))
[1] "call"

# 打印函数调用
> f(1 + 4)
1 + 4

# 延迟赋值
> delayedAssign("x", 1 + 4)

# 不执行函数调用，只打印函数调用
> uneval(x)
1 + 4

# 执行函数调用，并赋值
> x
[1] 5

# 延迟赋值又一例
> delayedAssign("x", {
+     for(i in 1:3)
+         cat("yippee!\n")
+     10
+ })

# 执行函数调用，并赋值
> x
yippee!
yippee!
yippee!
[1] 10

3.15 数据绑定%<a-%, %<c-%，%<d-%, rebind,<<-

使用特殊的函数，可以实现数据绑定的功能。

直接绑定


> x %<a-% runif(1)
> x
[1] 0.06793592
> x
[1] 0.8217227

常量绑定


> y %<c-% 4 + 2
[1] 6
> y
[1] 4

延迟绑定


> z %<d-% (a + b)
> a <- 10
> b <- 100
> z
[1] 110

重新绑定


# 对已知变量a重新赋值
> a <- 1
> rebind("a", 2)

# 对未知变量cc重新赋值，出错
> rebind("ccc", 2)
Error: Can't find ccc

# 用 <<- 对已知变量a重新赋值
> a<<-2
> a
[1] 2

# 用 <<- 对未知变量cc重新赋值
> rm(ccc)
> ccc
Error: object 'ccc' not found
> ccc<<-2
> ccc
[1] 2

通过对pryr全面介绍，我们了解这个包的强大，对于R的数据结构的理解非常有帮助。

转载请注明出处：
http://blog.fens.me/r-pryr/

打赏作者

This entry was posted in R语言实践
赞助商广告(购买)
[珠峰培训]

    站内导航
        R的极客理想系列文章
        从零开始nodejs系列文章
        用IT技术玩金融系列文章
        跨界知识聚会系列文章
        Hadoop家族系列文章
        AngularJS体验式编程系列文章
        RHadoop实践系列文章
        无所不能的Java系列文章
        ubuntu实用工具系列文章
        R利剑NoSQL系列文章
        MongoDB部署实验系列文章
        让Hadoop跑在云端系列文章
        自己搭建VPS系列文章
        架构师的信仰系列文章
        算法为王系列文章
        我的博客我的SEO系列文章
        创造可视化系列文章
        创业者的囧境系列文章
        写作计划列表
        关于站长
        投放广告
    最新评论
        2016CDAS中国数据分析师行业峰会:如何用R语言进行量化分析 | 粉丝日志 on 跨界知识聚会系列文章
        snowdream on 在Ubuntu中安装Docker
        mao on Mongoose使用案例–让JSON数据直接入库MongoDB
        当R语言遇上Docker | 粉丝日志 on R的极客理想系列文章
        在Ubuntu中安装Docker | 粉丝日志 on R语言解读自回归模型
        在Ubuntu中安装Docker | 粉丝日志 on 2016天善智能交流会第22场: R语言为量化而生
        在Ubuntu中安装Docker | 粉丝日志 on ubuntu实用工具系列文章
        R语言解读自回归模型 | 粉丝日志 on R的极客理想系列文章
        Conan Zhang on R语言构建配对交易量化模型
        taipeialpha on R语言构建配对交易量化模型
        Conan Zhang on R语言构建配对交易量化模型
        Conan Zhang on R语言构建配对交易量化模型
        Francis Tsai on R语言构建配对交易量化模型
        黃冠儒 on Nodejs异步流程控制Async
        taipeialpha on R语言构建配对交易量化模型
    最新文章
        2016CDAS中国数据分析师行业峰会:如何用R语言进行量化分析
        当R语言遇上Docker
        在Ubuntu中安装Docker
        R语言解读自回归模型
        R语言量化投资常用包总结
        R语言跨界调用C++
        R语言解读多元线性回归模型
        R语言解读一元线性回归模型
        R语言中文分词包jiebaR
        2016天善智能交流会第22场: R语言为量化而生
        R语言为量化而生
        超高性能数据处理包data.table
        掌握R语言中的apply函数族
        R语言高效的管道操作magrittr
        R语言字符串处理包stringr
        R语言构建配对交易量化模型
        尚书视频群活动:投资分析师笔试题
        构建自己的Aleax查询服务
        OpenBlas让R的矩阵计算加速
        2015lopdev生态联盟开发者大会:股市中的R语言量化算法模型

Copyright © 2016 All rights reserved.
Designed by NattyWP






