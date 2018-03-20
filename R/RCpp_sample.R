library(Rcpp)
cppFunction('
int add(int x, int y, int z) {
int sum = x + y + z;
return sum;
}'
)
add # like a regular R function, printing displays info about the function
#> function (x, y, z)
#> .Primitive(".Call")(<pointer: 0x7fa688ff3590>, x, y, z)
#> <environment: 0x37db310>
add(1, 2, 3)
#> [1] 6