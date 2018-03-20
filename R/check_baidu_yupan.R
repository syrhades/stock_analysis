require(tidyverse)
require(plyr)
require(stringr)

file_list <- list.files("D:/BaiduYunDownload",recursive=T)
match_list <- stringr::str_detect(file_list,"baiduyun\\.downloading")
match_list %>% table
extract_list <- file_list[match_list]
extract_list %>%llply(.,function(x) stringr::str_split(x,"/")%>%`[`(1))


extract_list %>%write.table(.,file="e:/undownload.log")
extract_list %>% stringr::str_split(.,"/")


