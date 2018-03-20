require(tidyverse)
require(plyr)
require(stringr)
"C:/Users/carlos/AppData/Local/Temp/Rtmp"
file_list <- list.files("C:/Users/carlos/AppData/Local/Temp/",full.names=T,recursive=F)
match_list <- stringr::str_detect(file_list,"Rtmp")
match_list %>% table
extract_list <- file_list[match_list]

extract_list %>% llply(function(x){
						java_cmd <-sprintf('D:/shell.w32-ix86/rm -r %s',x)
						java_cmd %>% print
						try(system(java_cmd, intern = TRUE))
}
)

  

				