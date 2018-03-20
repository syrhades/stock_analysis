setClass("Person",
  slots = list(name = "character", age = "numeric"))
setClass("Employee",
  slots = list(boss = "Person"),
  contains = "Person")

alice <- new("Person", name = "Alice", age = 40)
john <- new("Employee", name = "John", age = 20, boss = alice)


# 定义老师对象和行为
teacher <- function(x, ...) UseMethod("teacher")
teacher.lecture <- function(x) print("讲课")
teacher.assignment <- function(x) print("布置作业")
teacher.correcting <- function(x) print("批改作业")
teacher.default<-function(x) print("你不是teacher")

# 定义同学对象和行为
student <- function(x, ...) UseMethod("student")
student.attend <- function(x) print("听课")
student.homework <- function(x) print("写作业")
student.exam <- function(x) print("考试")
student.default<-function(x) print("你不是student")

# 定义两个变量，a老师和b同学
a<-'teacher'
b<-'student'

# 给老师变量设置行为
attr(a,'class') <- 'lecture'
# 执行老师的行为
teacher(a)
[1] "讲课"

# 给同学变量设置行为
attr(b,'class') <- 'attend'
# 执行同学的行为
student(b)
[1] "听课"

attr(a,'class') <- 'assignment'
teacher(a)
[1] "布置作业"

attr(b,'class') <- 'homework'
student(b)
[1] "写作业"
 
attr(a,'class') <- 'correcting'
teacher(a)
[1] "批改作业"
 
attr(b,'class') <- 'exam'
student(b)
[1] "考试"

# 定义一个变量，既是老师又是同学 
ab<-'student_teacher'
# 分别设置不同对象的行为
attr(ab,'class') <- c('lecture','homework')
# 执行老师的行为
teacher(ab)
[1] "讲课"
# 执行同学的行为
student(ab)
[1] "写作业"


 3.2 R语言实现继承


# 给同学对象增加新的行为
student.correcting <- function(x) print("帮助老师批改作业")

# 辅助变量用于设置初始值
char0 = character(0)

# 实现继承关系
create <- function(classes=char0, parents=char0) {
  mro <- c(classes)
  for (name in parents) {
      mro <- c(mro, name)
      ancestors <- attr(get(name),'type')
      mro <- c(mro, ancestors[ancestors != name])
  }
  return(mro)
 }

# 定义构造函数，创建对象
NewInstance <- function(value=0, classes=char0, parents=char0) {
  obj <- value
  attr(obj,'type') <- create(classes, parents)
  attr(obj,'class') <- c('homework','correcting','exam')
  return(obj)
 }

# 创建父对象实例
StudentObj <- NewInstance()

# 创建子对象实例
s1 <- NewInstance('普通同学',classes='normal', parents='StudentObj')
s2 <- NewInstance('课代表',classes='leader', parents='StudentObj')

# 给课代表，增加批改作业的行为
attr(s2,'class') <- c(attr(s2,'class'),'correcting')

# 查看普通同学的对象实例
s1
[1] "普通同学"
attr(,"type")
[1] "normal"     "StudentObj"
attr(,"class")
[1] "homework"   "correcting" "exam"      

# 查看课代表的对象实例
s2
[1] "课代表"
attr(,"type")
[1] "leader"     "StudentObj"
attr(,"class")
[1] "homework"   "correcting" "exam"       "correcting"

3.3 R语言实现多态


# 创建优等生和次等生，两个实例
e1 <- NewInstance('优等生',classes='excellent', parents='StudentObj')
e2 <- NewInstance('次等生',classes='poor', parents='StudentObj')

# 修改同学考试的行为，大于85分结果为优秀，小于70分结果为及格
student.exam <- function(x,score) {
  p<-"考试"
  if(score>85) print(paste(p,"优秀",sep=""))
  if(score<70) print(paste(p,"及格",sep=""))
 }

# 执行优等生的考试行为，并输入分数为90
attr(e1,'class') <- 'exam'
student(e1,90)
[1] "考试优秀"

# 执行次等生的考试行为，并输入分数为66
attr(e2,'class') <- 'exam'
student(e2,66)
[1] "考试及格"

这样通过R语言的泛型函数，我们就实现了面向对象的编程。
4 R的面向过程编程

接下来，我们再次对比用R语言用面向过程实现上面的逻辑。

4.1 定义老师和同学两个对象和行为


# 辅助变量用于设置初始值
char0 = character(1)

# 定义老师对象和行为
teacher_fun<-function(x=char0){
  if(x=='lecture'){
      print("讲课")
  }else if(x=='assignment'){
      print("布置作业")
  }else if(x=='correcting'){
      print("批改作业")
  }else{
      print("你不是teacher")
  }
 }

# 定义同学对象和行为 
student_fun<-function(x=char0){
  if(x=='attend'){
      print("听课")
  }else if(x=='homework'){
      print("写作业")
  }else if(x=='exam'){
      print("考试")
  }else{
      print("你不是student")
  }
 }

# 执行老师的一个行为
teacher_fun('lecture')
[1] "讲课"

# 执行同学的一个行为
student_fun('attend')
[1] "听课"

4.2 区别普通同学和课代表的行为


# 重定义同学的函数，增加角色判断
student_fun<-function(x=char0,role=0){
  if(x=='attend'){
      print("听课")
  }else if(x=='homework'){
      print("写作业")
  }else if(x=='exam'){
      print("考试")
  }else if(x=='correcting'){
      if(role==1){#课代表
          print("帮助老师批改作业")  
      }else{
          print("你不是课代表")  
      }
  }else{
      print("你不是student")
  }
 }

# 以普通同学的角色，执行课代表的行为
student_fun('correcting')
[1] "你不是课代表"

# 以课代表的角色，执行课代表的行为
student_fun('correcting',1)
[1] "帮助老师批改作业"

我在修改student_fun()函数的同时，已经增加了原函数的复杂度。

4.3 参加考试，以成绩区别出优等生和次等生


# 修改同学的函数定义，增加考试成绩参数
student_fun<-function(x=char0,role=0,score){
  if(x=='attend'){
      print("听课")
  }else if(x=='homework'){
      print("写作业")
  }else if(x=='exam'){
      p<-"考试"
      if(score>85) print(paste(p,"优秀",sep=""))
      if(score<70) print(paste(p,"及格",sep=""))
  }else if(x=='correcting'){
      if(role==1){#课代表
          print("帮助老师批改作业")  
      }else{
          print("你不是课代表")  
      }
  }else{
      print("你不是student")
  }
 }

# 执行考试函数，考试成绩为大于85分，为优等生
student_fun('exam',score=90)
[1] "考试优秀"

# 执行考试函数，考试成绩为小于70分，为次等生
student_fun('exam',score=66)
[1] "考试及格"

我再一次用面向过程的代码，实现了整个的编辑逻辑。再用到面向过程来写程序的时候，每一次的需求变化，都需要对原始代码进行修改，从而不仅增加了复杂度，而且不利于长久的维护。更多思考留给了大家！

本文抛砖引玉地讲了R语言的面向对象的编程，其中部分代码有些不够严谨，本文只希望给大家思路上的认识，更具体的面向对象编程实例，会在以后的文章中进行讨论。



setClass("Person",slots=list(name="character",age="numeric"))
father<-new("Person",name="F",age=44)
class(father)
otype(father)
setClass("Person",slots=list(name="character",age="numeric"))
setClass("Son",slots=list(father="Person",mother="Person"),contains="Person")

# 实例化Person对象
father<-new("Person",name="F",age=44)
mother<-new("Person",name="M",age=39)

# 实例化一个Son对象
son<-new("Son",name="S",age=16,father=father,mother=mother)

# 查看son对象的name属性
son@name
slot(son,"mother")

setClass("Person",slots=list(name="character",age="numeric"))

# 属性age为空
a<-new("Person",name="a")
a
# 设置属性age的默认值20
setClass("Person",slots=list(name="character",age="numeric"),prototype = list(age = 20))

# 属性age为空
b<-new("Person",name="b")

# 属性age的默认值是20
b

setClass("Person",slots=list(name="character",age="numeric"))

# 传入错误的age类型
bad<-new("Person",name="bad",age="abc")

setValidity("Person",function(object) {
  if (object@age <= 0) stop("Age is negative.")
 })

# 修传入小于0的年龄
bad2<-new("Person",name="bad",age=-1)

setClass("Person",slots=list(name="character",age="numeric"))

# 创建一个对象实例n1
n1<-new("Person",name="n1",age=19);n1


# 从实例n1中，创建实例n2，并修改name的属性值
n2<-initialize(n1,name="n2");n2

setClass("Person",slots=list(name="character",age="numeric"))
a<-new("Person",name="a")

# 访问S4对象的属性
a@name
########################################33

# 定义Person对象
setClass("Person",slots=list(name="character",age="numeric"))

# 定义泛型函数work，即接口
setGeneric("work",function(object) standardGeneric("work"))


# 定义work的现实，并指定参数类型为Person对象
setMethod("work", signature(object = "Person"), function(object) cat(object@name , "is working") )

# 创建一个Person对象a
a<-new("Person",name="Conan",age=16)
# 把对象a传入work函数
work(a)
Conan is working
##################################

User<-setRefClass("User",fields=list(name="character"))

User
# 实例化一个User对象u1
u1<-User$new(name="u1")
# 检查User类的类型
class(User)
is.object(User)
otype(User)

class(u1)

# 检查u1的类型
class(u1)
[1] "User"
attr(,"package")
[1] ".GlobalEnv"
is.object(u1)
[1] TRUE
otype(u1)
[1] "RC"
2.3 创建一个有继承关系的RC类


# 创建RC类User
User<-setRefClass("User",fields=list(name="character"))

# 创建User的子类Member
Member<-setRefClass("Member",contains="User",fields=list(manager="User"))

# 实例化User
manager<-User$new(name="manager")

# 实例化一个Son对象
member<-Member$new(name="member",manager=manager)

# 查看member对象
member
Reference class object of class "Member"
Field "name":
[1] "member"
Field "manager":
Reference class object of class "User"
Field "name":
[1] "manager"

# 查看member对象的name属性
member$name
[1] "member

# 查看member对象的manager属性
member$manager
Reference class object of class "User"
Field "name":
[1] "manager"

# 检查对象的属性类型
otype(member$name)
[1] "primitive"
otype(member$manager)
[1] "RC"

# 定义一个RC类
User<-setRefClass("User",

  # 定义2个属性
  fields=list(name="character",level='numeric'),
  methods=list(

       # 构造方法
       initialize = function(name,level){
           print("User::initialize")

           # 给属性增加默认值
           name <<- 'conan'
           level <<- 1
        }
   )
 )

# 实例化对象u1
u1<-User$new()
[1] "User::initialize"

# 查看对象u1，属性被增加了默认值
u1
Reference class object of class "User"
Field "name":
[1] "conan"
Field "level":
[1] 1




User<-setRefClass("User",
 fields=list(name="character",level='numeric'),
 methods=list(
   initialize = function(name,level){
     print("User::initialize")
     name <<- 'conan'
     level <<- 1
   },
   addLevel = function(x) {
     print('User::addLevel')
     level <<- levelx
   },
   addHighLevel = function(){
     print('User::addHighLevel')
     addLevel(2)
   }
 )
)




Member<-setRefClass("Member",contains="User",

    # 子类中的属性
    fields=list(age='numeric'),
    methods=list(

      # 覆盖父类的同名方法
      addLevel = function(x) {
          print('Member::addLevel')

          # 调用父类的同名方法
          callSuper(x)
          level <<- level1
      }
    )
)


######################################33
## R6
########################################333

install.packages("R6") 
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包


Person <- R6Class("Person",    # 定义一个R6类
  public=list(
 hello = function(){         # 定义公有方法hello
   print(paste("Hello"))
 }
  )
)
Person
u1<-Person$new()   # 实例化一个Person对象u1




Person <- R6Class("Person",
  lock_objects = FALSE,
  public=list(
	name=NA,                           # 公有属性
	initialize = function(name){       # 构建函数方法
	self$name <- name
	self$id <- "rererere"
    },
    hello = function(){                # 公有方法
      print(paste("Hello",self$name,self$id))
    }
  )
)
u1<-Person$new("carlos")   # 实例化一个Person对象u1
u1$hello()

