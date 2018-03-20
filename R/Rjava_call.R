system("javac f:/NoParameter.java")#生成.class文件  
system("java NoParameter")#执行NoParameter文件  


tz = TimeZone.getTimeZone("America/Los_Angeles");
String tx = new String()
java.util.TimeZone
s <- .jnew("java/lang/String", "Hello World!") 
tz <- .jnew("java/util/TimeZone") 

http://docs.oracle.com/javase/7/docs/api/java/util/TimeZone.html
http://docs.oracle.com/javase/7/docs/api/java/util/Timer.html


tz <- J("java/util/TimeZone")
tz$getTimeZone("GMT+8")

tz$getTimeZone("Sofia")

io <- J("java/io/BufferedReader")
tz$getTimeZone("GMT+8")

fo <- .jnew("java/io/FileInputStream","e:/NoParameter.java")
bufr  <- J("java/io/BufferedReader")

mt <- J("java/lang/Math")
mt$abs(-11)


 
       刚开始用rJava的时候，以为只需要JAVA中调用R不需要R中调用JAVA。现在终于遇到了需要在R中调用JAVA的问题。一般来说，如果是统计或者数学模型，在R社区可以找到很多有用的包，但是一些其他领域的应用，就要到JAVA社区中找了。比如这段时间要用到一个中文分词的工具，好的开源工具基本都是基于lucene的，因此需要在R中调用Jar包。
　　要在R中使用JAVA对象或者方法，在http://www.rforge.net/rJava/页面有清晰的例子。首先通过library(rJava)加载rJava包，然后利用.jinit()打开JVM虚拟机，在该命令下可以指定classpath等启动参数，有些类似在IDE中的设置。.jnew(类名,参数)可以建立一个JAVA对象，.jcall(R中建立的JAVA对象,输入类型,方法,参数)可以调用建立好的对象的方法。其实能够建立对象调用方法就基本够了，面向对象的编程还是直接用JAVA写比较好。
　　官方的例子都比较简单，其实实际开发中一般都是利用某个JAVA工程（通常是Jar包）而不是JAVA的内置对象或方法。一般来说，需要导入外部的Jar包，还需要import相关的类。在rJava中，会直接找到系统环境变量中的jar包，不需要单独导入。因此可以将需要的Jar文件路径写入系统环境变量的classpath中，直接.jinit()后就可以使用。如果不想频繁修改环境变量，可以用.jinit("D:/lucene-core-2.4.1.jar")的方式添加。至于JAVA开发中需要的import某些类，在R中不需要事先声明，只要classpath中有的对象直接拿来用就行。
　　实际操作中也遇到了一点问题，关于.jcall函数，调用内置的对象没有任何问题，但是调用加载的Jar包中比较复杂的对象或方法时（返回自定义的对象）就出错，提示找不到该方法，在网上也找不到复杂对象的例子。仔细一想，其实也没必要在R中使用自定义的复杂对象，毕竟我们需要返回的是R中的数据结构，通常都是数值或字符串，那么直接让JAVA返回标准数值或字符串就行了。于是我在JAVA中专门写了一个类，把所有对象之间调来调去的东西都写进一个方法f中，最后返回我要的字符串。在R中只需要调用这个返回标准字符串的方法即可，例如.jcall(x,"S","f","")，就可以正常输出了。
　　如果不想以后麻烦，可以将自定义的函数和引用的Jar包打在一起，形成一个单独的Jar包，那么每次操作时在.jinit()中引入就行，非常方便。