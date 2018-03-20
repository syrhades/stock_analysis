r. .that is a special variable
which proto adds to every proto object denoting the object itself. .super is also added to
every proto object and is the parent of .that. .that and .super are normally used within
methods of an object to refer to other components of the same or parent object, respectively,
as opposed to the receiver (.). For example, suppose we want add in addProto2 to add the
elements of x together and the elements of y together and then add these two sums. We could
redefine add like this:
addProto2$add <- function(.) .super$add(.) + sum(.$y)

making use of the add already defined in the parent. One exception should be noted here.
When one uses .super, as above, or .that to specify a method then the receiver object must
be explicitly specified in argument one (since in those cases the receiver is possibly different
than .super or .that so the system cannot automatically supply it to the call.)
Setting a value is similar to the corresponding operation for environments except that any
function, i.e method, which is inserted has its environment set to the environment of the
object into which it is being inserted. This is necessary so that such methods can reference
.that and .super using lexical scoping.
In closing this section a few points should be re-emphasized and expanded upon. A proto
object is an environment whose parent object is the parent environment of the proto object.
The methods in the proto objects are ordinary functions that have the containing object as
their environment.
The R with function can be used with environments and therefore can be used with proto
objects since proto objects are environments too. Thus with(addProto, x) refers to the

Logadd <- Add$proto(logadd = function(.) log(.$add()))
logadd1 <- Logadd$new(1:5)
logadd1$logadd()

addProto$ls()
addProto$str()
addProto$print()
addProto$as.list()
addProto2a$parent.env()


show additional information about the elements. eapply can be used to explore more properties
such as the the length of each component of an object:
addProto$eapply(length)

 addProto$identical(addProto2)
obj$fun(...) is transformed
into get("fun", obj)(obj, ...) by the proto $ operator.

library(Rgraphviz)
g <- graph.proto()
plot(g)

http://r-pkgs.had.co.nz/

