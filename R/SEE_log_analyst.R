
source("e:/syrhadestock/R/cl_part_function.R")
bis_bsh<-read.csv("D:/help_line/bsh/log20161024_26/bis-BSHCN_EDI.lgw.13",header = F,sep = "\t",stringsAsFactors = F)

source("~/sdcard1/syrhadestock/R/cl_part_function.R")
# step1 read log file
log_filename <-"/media/syrhades/新加卷/log20161024_26/bis-BSHCN_EDI.lgw.13"
frm_read_log<-function(log_filename){
  bis_bsh<-read.csv(log_filename,header = F,sep = "\t",stringsAsFactors = F)
  # set col names
  names(bis_bsh)<-c("V1","time","compoent","jb","adapter","env","log_level","V8","V9","user","property.list","property.message.id")
  # bis_bsh %>% str
  # delete some cols
  bis_bsh<-bis_bsh[,c(-4,-6,-8,-9)]
  # move content to message id
  bis_bsh[bis_bsh$V1!="@LGW800",]$property.message.id<-bis_bsh[bis_bsh$V1!="@LGW800",]$V1
  bis_bsh[bis_bsh$V1!="@LGW800",]$log_level<-"ERROR"
  # trim space in col property.list
  bis_bsh<-transform(bis_bsh,property.list=str_trim(property.list)) 
  # create two cos for message id (id_no,id_no2)
  see_id <- "[[:alnum:]]{8}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{12}"
  bis_bsh$id_no<-llply(bis_bsh$property.message.id,function(x) frm_gexpr_tool1(see_id,x)%>%unlist%>%unique)
  bis_bsh$id_no2<-llply(bis_bsh$property.message.id,function(x) frm_gexpr_tool1(see_id,x)%>%unlist%>%unique%>%as.character)
  bis_bsh<-transform(bis_bsh,id_no2=id_no2%>%as.character)
  bis_bsh<-transform(bis_bsh,log_level=log_level%>%str_trim)
  return(bis_bsh)
}
bis_bsh<-frm_read_log(log_filename)

# filter error message
df_error<-subset(bis_bsh,log_level=="ERROR") 
# extract property.list unique
df_error_unique_list<-df_error$property.list %>% unique
# method1 property.list = special value
df_step1<-subset(bis_bsh,property.list==df_error_unique_list[2])  
# method2 id_no2  match xxx value
# df_filter2 <- subset(bis_bsh,)
frm_index_filter <-  function(col_content,reg_match){
  df_match <- laply(col_content,function(x) stri_count_regex(x,reg_match))
  fliter_line <- df_match > 0
  return(fliter_line)
}



hwriter:::showExample()


# extract unique messag id
frm_extract_unique_message_id <- function(df_obj_filtered,df_obj_all){
  unique.messageid <-df_obj_filtered$id_no2 %>%unique
  unique.messageid <- unique.messageid[unique.messageid != ""]
  target_line1<-llply(df_obj_all$id_no,  function(x) x%>%unlist %in% unique.messageid%>%any) %>%unlist
  df_trace_step <-  df_obj_all[target_line1,]
  return(df_trace_step)
}

df_trace_step<-frm_extract_unique_message_id(df_step1,bis_bsh)


 # show html report 
# df_trace_step %>% frm_show_html_v2("c") # center align
df_trace_step %>% frm_show_html_v2("l") # center align

# subset(bis_bsh,log_level="ERROR") %>%head
bis_bsh[bis_bsh$log_level ==" ERROR",] %>%head

# bis_bsh $property.list %>% unique %>% length
# apply(bis_bsh,2, function(x) unique(x) %>% length )

# sample 2 extract specail content
df_filter2<-bis_bsh[frm_index_filter(bis_bsh$property.message.id,"MAILClient"),]
df_filter2<-bis_bsh[frm_index_filter(bis_bsh$property.list,"10b00a5820bf"),]
df_trace_step2<-frm_extract_unique_message_id(df_filter2,bis_bsh)
df_trace_step2 %>% frm_show_html_v2("l") # center align
#generate a html file df_trace_step2[1:8]  '/tmp/test2.html'
frm_show_html_v3 (df_trace_step2[1:8] ,'/tmp/test3.html')

# subset(bis_bsh,V1!="@LGW800") %>% head 


# # > apply(bis_bsh,2, function(x) unique(x) %>% length )
# #                  V1                time            compoent                  jb             adapter                 env           log_level 
# #                 284               17775                  65                   2                 825                   2                   4 
# #                  V8                  V9                user       property.list property.message.id 
# #                   2                   3                  62                 345                4085 
# # bis_bsh $property.list %>% unique
# # cfbf60d0-9a17-11e6-95f0-10b00a5820bf
# # cfadfbb0-9a17-11e6-95f0-10b00a5820bf.p1477333774084
# # cfa19fa1-9a17-11e6-95f0-10b00a5820bf	cfadfbb0-9a17-11e6-95f0-10b00a5820bf	cfadfbb0-9a17-11e6-95f0-10b00a5820bf.p1477333774084	24748fa0-848e-11e6-95f0-10b00a5820bf.p1474965672161	1f71d9f1-9a13-11e6-95f0-10b00a5820bf	f52ab181-9a17-11e6-95f0-10b00a5820bf	f536bf70-9a17-11e6-95f0-10b00a5820bf	f536bf70-9a17-11e6-95f0-10b00a5820bf.p1477333837057	f42c86f1-9a0d-11e6-95f0-10b00a5820bf	1a9a20e0-9a18-11e6-95f0-10b00a5820bf	1aa4a830-9a18-11e6-95f0-10b00a5820bf	1aa4a830-9a18-11e6-95f0-10b00a5820bf.p1477333899852	36160ae1-9a0f-11e6-95f0-10b00a5820bf	400e4b30-9a18-11e6-95f0-10b00a5820bf	401a0b00-9a18-11e6-95f0-10b00a5820bf	401a0b00-9a18-11e6-95f0-10b00a5820bf.p1477333962696	37d893b1-9a15-11e6-95f0-10b00a5820bf	658cd5c1-9a18-11e6-95f0-10b00a5820bf	659a9160-9a18-11e6-95f0-10b00a5820bf	659a9160-9a18-11e6-95f0-10b00a5820bf.p1477334025615	8b0c23a1-9a18-11e6-95f0-10b00a5820bf	8b17e370-9a18-11e6-95f0-10b00a5820bf	8b17e370-9a18-11e6-95f0-10b00a5820bf.p1477334088510	b0a03201-9a18-11e6-95f0-10b00a5820bf	b0ae89e0-9a18-11e6-95f0-10b00a5820bf	b0ae89e0-9a18-11e6-95f0-10b00a5820bf.p1477334151573	8e8959f1-9a0c-11e6-95f0-10b00a5820bf	d6206a40-9a18-11e6-95f0-10b00a5820bf	d62b3fb0-9a18-11e6-95f0-10b00a5820bf	d62b3fb0-9a18-11e6-95f0-10b00a5820bf.p1477334214466	fb9b4b51-9a18-11e6-95f0-10b00a5820bf	fba5f9b0-9a18-11e6-95f0-10b00a5820bf	fba5f9b0-9a18-11e6-95f0-10b00a5820bf.p1477334277347	cca88b41-9a14-11e6-95f0-10b00a5820bf	2104a030-9a19-11e6-95f0-10b00a5820bf	211011e0-9a19-11e6-95f0-10b00a5820bf	211011e0-9a19-11e6-95f0-10b00a5820bf.p1477334340117	46859bc0-9a19-11e6-95f0-10b00a5820bf	469245f0-9a19-11e6-95f0-10b00a5820bf	469245f0-9a19-11e6-95f0-10b00a5820bf.p1477334403048	b41a7361-9a12-11e6-95f0-10b00a5820bf	6c0c1591-9a19-11e6-95f0-10b00a5820bf	6c17fc70-9a19-11e6-95f0-10b00a5820bf	6c17fc70-9a19-11e6-95f0-10b00a5820bf.p1477334465999	9176a2f0-9a19-11e6-95f0-10b00a5820bf	91837430-9a19-11e6-95f0-10b00a5820bf	91837430-9a19-11e6-95f0-10b00a5820bf.p1477334528781	b70a1511-9a19-11e6-95f0-10b00a5820bf	b7214690-9a19-11e6-95f0-10b00a5820bf	b7214690-9a19-11e6-95f0-10b00a5820bf.p1477334591889	a151fa31-9a0f-11e6-95f0-10b00a5820bf	dcbf8e20-9a19-11e6-95f0-10b00a5820bf	dccbc320-9a19-11e6-95f0-10b00a5820bf	dccbc320-9a19-11e6-95f0-10b00a5820bf.p1477334655083	f7db8ec1-9a19-11e6-95f0-10b00a5820bf	023761f1-9a1a-11e6-95f0-10b00a5820bf	0243be00-9a1a-11e6-95f0-10b00a5820bf	0243be00-9a1a-11e6-95f0-10b00a5820bf.p1477334717946	27dbc401-9a1a-11e6-95f0-10b00a5820bf	27e783d0-9a1a-11e6-95f0-10b00a5820bf	27e783d0-9a1a-11e6-95f0-10b00a5820bf.p1477334781094	d9ee5cd1-9a05-11e6-95f0-10b00a5820bf	4d62da10-9a1a-11e6-95f0-10b00a5820bf	4d6dd690-9a1a-11e6-95f0-10b00a5820bf	4d6dd690-9a1a-11e6-95f0-10b00a5820bf.p1477334844053	72da5fc1-9a1a-11e6-95f0-10b00a5820bf	72e4e710-9a1a-11e6-95f0-10b00a5820bf	72e4e710-9a1a-11e6-95f0-10b00a5820bf.p1477334906905	86d015b1-9a1a-11e6-95f0-10b00a5820bf	98df5861-9a1a-11e6-95f0-10b00a5820bf	98e9b8a0-9a1a-11e6-95f0-10b00a5820bf	98e9b8a0-9a1a-11e6-95f0-10b00a5820bf.p1477334970690	be570521-9a1a-11e6-95f0-10b00a5820bf	be63d660-9a1a-11e6-95f0-10b00a5820bf	be63d660-9a1a-11e6-95f0-10b00a5820bf.p1477335033567	e3ddcd11-9a1a-11e6-95f0-10b00a5820bf	e3e8a280-9a1a-11e6-95f0-10b00a5820bf	e3e8a280-9a1a-11e6-95f0-10b00a5820bf.p1477335096512	f23a40f1-9a1a-11e6-95f0-10b00a5820bf	09638391-9a1b-11e6-95f0-10b00a5820bf	096ece30-9a1b-11e6-95f0-10b00a5820bf	096ece30-9a1b-11e6-95f0-10b00a5820bf.p1477335159468	2ee0ae91-9a1b-11e6-95f0-10b00a5820bf	2eeb8400-9a1b-11e6-95f0-10b00a5820bf	2eeb8400-9a1b-11e6-95f0-10b00a5820bf.p1477335222362	01a96e12-99ff-11e6-95f0-10b00a5820bf	545f8741-9a1b-11e6-95f0-10b00a5820bf	546c5880-9a1b-11e6-95f0-10b00a5820bf	546c5880-9a1b-11e6-95f0-10b00a5820bf.p1477335285280	79e516b1-9a1b-11e6-95f0-10b00a5820bf	79f0d680-9a1b-11e6-95f0-10b00a5820bf	79f0d680-9a1b-11e6-95f0-10b00a5820bf.p1477335348226	9f724741-9a1b-11e6-95f0-10b00a5820bf	9f7ea350-9a1b-11e6-95f0-10b00a5820bf	9f7ea350-9a1b-11e6-95f0-10b00a5820bf.p1477335411231	c4fda311-9a1b-11e6-95f0-10b00a5820bf	c5080350-9a1b-11e6-95f0-10b00a5820bf	c5080350-9a1b-11e6-95f0-10b00a5820bf.p1477335474204	c8cecf51-9a1b-11e6-95f0-10b00a5820bf	ea70bbf0-9a1b-11e6-95f0-10b00a5820bf	ea7d1800-9a1b-11e6-95f0-10b00a5820bf	ea7d1800-9a1b-11e6-95f0-10b00a5820bf.p1477335537050	0fe7f381-9a1c-11e6-95f0-10b00a5820bf	0ff36530-9a1c-11e6-95f0-10b00a5820bf	0ff36530-9a1c-11e6-95f0-10b00a5820bf.p1477335599902	dd91f2f1-9a11-11e6-95f0-10b00a5820bf	35b0cd80-9a1c-11e6-95f0-10b00a5820bf	35bc1820-9a1c-11e6-95f0-10b00a5820bf	35bc1820-9a1c-11e6-95f0-10b00a5820bf.p1477335663290	5b448dc1-9a1c-11e6-95f0-10b00a5820bf	5b509bb0-9a1c-11e6-95f0-10b00a5820bf	5b509bb0-9a1c-11e6-95f0-10b00a5820bf.p1477335726340	7b7d9b91-9a1c-11e6-95f0-10b00a5820bf	80d39310-9a1c-11e6-95f0-10b00a5820bf	80df04c0-9a1c-11e6-95f0-10b00a5820bf	80df04c0-9a1c-11e6-95f0-10b00a5820bf.p1477335789351	a652e0f1-9a1c-11e6-95f0-10b00a5820bf	a65d6840-9a1c-11e6-95f0-10b00a5820bf	a65d6840-9a1c-11e6-95f0-10b00a5820bf.p1477335852251	cbe8c410-9a1c-11e6-95f0-10b00a5820bf	cbf56e40-9a1c-11e6-95f0-10b00a5820bf	cbf56e40-9a1c-11e6-95f0-10b00a5820bf.p1477335915325	f175f4a1-9a1c-11e6-95f0-10b00a5820bf	f18229a0-9a1c-11e6-95f0-10b00a5820bf	f18229a0-9a1c-11e6-95f0-10b00a5820bf.p1477335978324	f86b4440-9a1c-11e6-95f0-10b00a5820bf	f86b4440-9a1c-11e6-95f0-10b00a5820bf.p1477335992499	141fb911-848c-11e6-b362-5aaa0a5820bf.p1474964789776	170d8570-9a1d-11e6-95f0-10b00a5820bf	1718d010-9a1d-11e6-95f0-10b00a5820bf	1718d010-9a1d-11e6-95f0-10b00a5820bf.p1477336041386	3c8ea811-9a1d-11e6-95f0-10b00a5820bf	3c9a8ef0-9a1d-11e6-95f0-10b00a5820bf	3c9a8ef0-9a1d-11e6-95f0-10b00a5820bf.p1477336104310	62006161-9a1d-11e6-95f0-10b00a5820bf	620c6f50-9a1d-11e6-95f0-10b00a5820bf	620c6f50-9a1d-11e6-95f0-10b00a5820bf.p1477336167134	88029ae1-9a1d-11e6-95f0-10b00a5820bf	880dbe70-9a1d-11e6-95f0-10b00a5820bf	880dbe70-9a1d-11e6-95f0-10b00a5820bf.p1477336230898	5ba883e1-9a15-11e6-95f0-10b00a5820bf	adc95200-9a1d-11e6-95f0-10b00a5820bf	add40060-9a1d-11e6-95f0-10b00a5820bf	add40060-9a1d-11e6-95f0-10b00a5820bf.p1477336294269	bd6a53d1-9a1d-11e6-95f0-10b00a5820bf	d35c7601-9a1d-11e6-95f0-10b00a5820bf	d3679990-9a1d-11e6-95f0-10b00a5820bf	d3679990-9a1d-11e6-95f0-10b00a5820bf.p1477336357314	e1224f31-9a1d-11e6-95f0-10b00a5820bf	f8f78941-9a1d-11e6-95f0-10b00a5820bf	f9032200-9a1d-11e6-95f0-10b00a5820bf	f9032200-9a1d-11e6-95f0-10b00a5820bf.p1477336420409	04f573b1-9a1e-11e6-95f0-10b00a5820bf	1e82e510-9a1e-11e6-95f0-10b00a5820bf	1e8e56c0-9a1e-11e6-95f0-10b00a5820bf	1e8e56c0-9a1e-11e6-95f0-10b00a5820bf.p1477336483399	44497520-9a1e-11e6-95f0-10b00a5820bf	4454e6d0-9a1e-11e6-95f0-10b00a5820bf	4454e6d0-9a1e-11e6-95f0-10b00a5820bf.p1477336546774	69c31db1-9a1e-11e6-95f0-10b00a5820bf	69d25ff0-9a1e-11e6-95f0-10b00a5820bf	69d25ff0-9a1e-11e6-95f0-10b00a5820bf.p1477336609671	8f515fb0-9a1e-11e6-95f0-10b00a5820bf	8f5c0e10-9a1e-11e6-95f0-10b00a5820bf	8f5c0e10-9a1e-11e6-95f0-10b00a5820bf.p1477336672649	b4d91200-9a1e-11e6-95f0-10b00a5820bf	b4e40e80-9a1e-11e6-95f0-10b00a5820bf	b4e40e80-9a1e-11e6-95f0-10b00a5820bf.p1477336735616	b7b46c91-9a1e-11e6-95f0-10b00a5820bf	da613981-9a1e-11e6-95f0-10b00a5820bf	da6cab30-9a1e-11e6-95f0-10b00a5820bf	da6cab30-9a1e-11e6-95f0-10b00a5820bf.p1477336798587	ffe59071-9a1e-11e6-95f0-10b00a5820bf	fff0b400-9a1e-11e6-95f0-10b00a5820bf	fff0b400-9a1e-11e6-95f0-10b00a5820bf.p1477336861529	257f1d10-9a1f-11e6-95f0-10b00a5820bf	258b5210-9a1f-11e6-95f0-10b00a5820bf	258b5210-9a1f-11e6-95f0-10b00a5820bf.p1477336924620	46c0c141-9a1f-11e6-95f0-10b00a5820bf	4af3e3a0-9a1f-11e6-95f0-10b00a5820bf	4b026290-9a1f-11e6-95f0-10b00a5820bf	4b026290-9a1f-11e6-95f0-10b00a5820bf.p1477336987474	707a3661-9a1f-11e6-95f0-10b00a5820bf	70861d40-9a1f-11e6-95f0-10b00a5820bf	70861d40-9a1f-11e6-95f0-10b00a5820bf.p1477337050412	960480c1-9a1f-11e6-95f0-10b00a5820bf	96115200-9a1f-11e6-95f0-10b00a5820bf	96115200-9a1f-11e6-95f0-10b00a5820bf.p1477337113400	bb79e391-9a1f-11e6-95f0-10b00a5820bf	bb861890-9a1f-11e6-95f0-10b00a5820bf	bb861890-9a1f-11e6-95f0-10b00a5820bf.p1477337176241	e0f783c0-9a1f-11e6-95f0-10b00a5820bf	e1036aa0-9a1f-11e6-95f0-10b00a5820bf	e1036aa0-9a1f-11e6-95f0-10b00a5820bf.p1477337239138	067cec21-9a20-11e6-95f0-10b00a5820bf	0688d300-9a20-11e6-95f0-10b00a5820bf	0688d300-9a20-11e6-95f0-10b00a5820bf.p1477337302089	2bf44ac1-9a20-11e6-95f0-10b00a5820bf	2c000a90-9a20-11e6-95f0-10b00a5820bf	2c000a90-9a20-11e6-95f0-10b00a5820bf.p1477337364945	516e4170-9a20-11e6-95f0-10b00a5820bf	5179da30-9a20-11e6-95f0-10b00a5820bf	5179da30-9a20-11e6-95f0-10b00a5820bf.p1477337427819	64dbb491-9a20-11e6-95f0-10b00a5820bf	77d61a91-9a20-11e6-95f0-10b00a5820bf	77e2ebd0-9a20-11e6-95f0-10b00a5820bf	77e2ebd0-9a20-11e6-95f0-10b00a5820bf.p1477337492260	88ad2b61-9a20-11e6-95f0-10b00a5820bf	9d66cd91-9a20-11e6-95f0-10b00a5820bf	9d7154e0-9a20-11e6-95f0-10b00a5820bf	9d7154e0-9a20-11e6-95f0-10b00a5820bf.p1477337555271	c2e928b1-9a20-11e6-95f0-10b00a5820bf	c2f3b000-9a20-11e6-95f0-10b00a5820bf	c2f3b000-9a20-11e6-95f0-10b00a5820bf.p1477337618202	e8885aa0-9a20-11e6-95f0-10b00a5820bf	e8944180-9a20-11e6-95f0-10b00a5820bf	e8944180-9a20-11e6-95f0-10b00a5820bf.p1477337681328	0dff6b21-9a21-11e6-95f0-10b00a5820bf	0e0bc730-9a21-11e6-95f0-10b00a5820bf	0e0bc730-9a21-11e6-95f0-10b00a5820bf.p1477337744190	17bdece1-9a21-11e6-95f0-10b00a5820bf	33732040-9a21-11e6-95f0-10b00a5820bf	337fa360-9a21-11e6-95f0-10b00a5820bf	337fa360-9a21-11e6-95f0-10b00a5820bf.p1477337807024	59423bd1-9a21-11e6-95f0-10b00a5820bf	594cc320-9a21-11e6-95f0-10b00a5820bf	594cc320-9a21-11e6-95f0-10b00a5820bf.p1477337870442	7ebaabe1-9a21-11e6-95f0-10b00a5820bf	7ec77d20-9a21-11e6-95f0-10b00a5820bf	7ec77d20-9a21-11e6-95f0-10b00a5820bf.p1477337933322	a4312021-9a21-11e6-95f0-10b00a5820bf	a43d5520-9a21-11e6-95f0-10b00a5820bf	a43d5520-9a21-11e6-95f0-10b00a5820bf.p1477337996170	c9a9b741-9a21-11e6-95f0-10b00a5820bf	c9b4b3c0-9a21-11e6-95f0-10b00a5820bf	c9b4b3c0-9a21-11e6-95f0-10b00a5820bf.p1477338059029	ef292c30-9a21-11e6-95f0-10b00a5820bf	ef3428b0-9a21-11e6-95f0-10b00a5820bf	ef3428b0-9a21-11e6-95f0-10b00a5820bf.p1477338121948	14bc7740-9a22-11e6-95f0-10b00a5820bf	14c83710-9a22-11e6-95f0-10b00a5820bf	14c83710-9a22-11e6-95f0-10b00a5820bf.p1477338184985	3a3d72d0-9a22-11e6-95f0-10b00a5820bf	3a47d310-9a22-11e6-95f0-10b00a5820bf	3a47d310-9a22-11e6-95f0-10b00a5820bf.p1477338247897	599fa8a1-9a22-11e6-95f0-10b00a5820bf	5fa56821-9a22-11e6-95f0-10b00a5820bf	5fb23960-9a22-11e6-95f0-10b00a5820bf	5fb23960-9a22-11e6-95f0-10b00a5820bf.p1477338310672	d83e2381-99ff-11e6-95f0-10b00a5820bf	851b4021-9a22-11e6-95f0-10b00a5820bf	85281160-9a22-11e6-95f0-10b00a5820bf	85281160-9a22-11e6-95f0-10b00a5820bf.p1477338373521	aad83340-9a22-11e6-95f0-10b00a5820bf	aae2e1a0-9a22-11e6-95f0-10b00a5820bf	aae2e1a0-9a22-11e6-95f0-10b00a5820bf.p1477338436818	d0495051-9a22-11e6-95f0-10b00a5820bf	d0549af0-9a22-11e6-95f0-10b00a5820bf	d0549af0-9a22-11e6-95f0-10b00a5820bf.p1477338499641	f5b404c1-9a22-11e6-95f0-10b00a5820bf	f5beb320-9a22-11e6-95f0-10b00a5820bf	f5beb320-9a22-11e6-95f0-10b00a5820bf.p1477338562410	1bc66ae0-9a23-11e6-95f0-10b00a5820bf	1bd0f230-9a23-11e6-95f0-10b00a5820bf	1bd0f230-9a23-11e6-95f0-10b00a5820bf.p1477338626283	301b57d1-9a23-11e6-95f0-10b00a5820bf	415214d1-9a23-11e6-95f0-10b00a5820bf	415e70e0-9a23-11e6-95f0-10b00a5820bf	415e70e0-9a23-11e6-95f0-10b00a5820bf.p1477338689287	53fde5a1-9a23-11e6-95f0-10b00a5820bf	6767af40-9a23-11e6-95f0-10b00a5820bf	6772d2d0-9a23-11e6-95f0-10b00a5820bf	6772d2d0-9a23-11e6-95f0-10b00a5820bf.p1477338753177	8ce612c1-9a23-11e6-95f0-10b00a5820bf	8cf220b0-9a23-11e6-95f0-10b00a5820bf	8cf220b0-9a23-11e6-95f0-10b00a5820bf.p1477338816083	b26a69b1-9a23-11e6-95f0-10b00a5820bf	b2756630-9a23-11e6-95f0-10b00a5820bf	b2756630-9a23-11e6-95f0-10b00a5820bf.p1477338879019	d7ef35d1-9a23-11e6-95f0-10b00a5820bf	d7fc0710-9a23-11e6-95f0-10b00a5820bf	d7fc0710-9a23-11e6-95f0-10b00a5820bf.p1477338941977	fd775d51-9a23-11e6-95f0-10b00a5820bf	fd839250-9a23-11e6-95f0-10b00a5820bf	fd839250-9a23-11e6-95f0-10b00a5820bf.p1477339004941	22f17b10-9a24-11e6-95f0-10b00a5820bf	22fd13d0-9a24-11e6-95f0-10b00a5820bf	22fd13d0-9a24-11e6-95f0-10b00a5820bf.p1477339067813	0cbb1401-9a10-11e6-95f0-10b00a5820bf	48677a21-9a24-11e6-95f0-10b00a5820bf	48736100-9a24-11e6-95f0-10b00a5820bf	48736100-9a24-11e6-95f0-10b00a5820bf.p1477339130665	6dfe95c1-9a24-11e6-95f0-10b00a5820bf	6e091d10-9a24-11e6-95f0-10b00a5820bf	6e091d10-9a24-11e6-95f0-10b00a5820bf.p1477339193720	93889200-9a24-11e6-95f0-10b00a5820bf	9394ee10-9a24-11e6-95f0-10b00a5820bf	9394ee10-9a24-11e6-95f0-10b00a5820bf.p1477339256716	b90ee4c0-9a24-11e6-95f0-10b00a5820bf	b9199320-9a24-11e6-95f0-10b00a5820bf	b9199320-9a24-11e6-95f0-10b00a5820bf.p1477339319658	c2caf580-9a24-11e6-95f0-10b00a5820bf	c2caf580-9a24-11e6-95f0-10b00a5820bf.p1477339338364	d618d2b1-9a24-11e6-95f0-10b00a5820bf	d618d2b1-9a24-11e6-95f0-10b00a5820bf.p1477339370822	dedca0c0-9a24-11e6-95f0-10b00a5820bf	dee77630-9a24-11e6-95f0-10b00a5820bf	dee77630-9a24-11e6-95f0-10b00a5820bf.p1477339383082	f15ec980-9a24-11e6-95f0-10b00a5820bf	f15ec980-9a24-11e6-95f0-10b00a5820bf.p1477339416511	047039f0-9a25-11e6-95f0-10b00a5820bf	047da770-9a25-11e6-95f0-10b00a5820bf	047da770-9a25-11e6-95f0-10b00a5820bf.p1477339446143	10473b70-9a25-11e6-95f0-10b00a5820bf	10473b70-9a25-11e6-95f0-10b00a5820bf.p1477339468307	24cc6021-9a25-11e6-95f0-10b00a5820bf	29ef39b1-9a25-11e6-95f0-10b00a5820bf	29fb47a0-9a25-11e6-95f0-10b00a5820bf	29fb47a0-9a25-11e6-95f0-10b00a5820bf.p1477339509044	4f5c3810-9a25-11e6-95f0-10b00a5820bf	4f673490-9a25-11e6-95f0-10b00a5820bf	4f673490-9a25-11e6-95f0-10b00a5820bf.p1477339571828	55c85a80-9a25-11e6-95f0-10b00a5820bf	55c85a80-9a25-11e6-95f0-10b00a5820bf.p1477339582894	561c9500-9a25-11e6-95f0-10b00a5820bf	561c9500-9a25-11e6-95f0-10b00a5820bf.p1477339583324	6ca94981-9a25-11e6-95f0-10b00a5820bf.p1477339620946	6cc005d1-9a25-11e6-95f0-10b00a5820bf.p1477339621067	6ca94981-9a25-11e6-95f0-10b00a5820bf	6cc005d1-9a25-11e6-95f0-10b00a5820bf	74db37d1-9a25-11e6-95f0-10b00a5820bf	74e6d090-9a25-11e6-95f0-10b00a5820bf	74e6d090-9a25-11e6-95f0-10b00a5820bf.p1477339634740	9a4f8930-9a25-11e6-95f0-10b00a5820bf	9a5afae0-9a25-11e6-95f0-10b00a5820bf	9a5afae0-9a25-11e6-95f0-10b00a5820bf.p1477339697576	bfd518a1-9a25-11e6-95f0-10b00a5820bf	bfdfc700-9a25-11e6-95f0-10b00a5820bf	bfdfc700-9a25-11e6-95f0-10b00a5820bf.p1477339760521	e55e2a81-9a25-11e6-95f0-10b00a5820bf	e569ea50-9a25-11e6-95f0-10b00a5820bf	e569ea50-9a25-11e6-95f0-10b00a5820bf.p1477339823502	fb5de141-9a25-11e6-95f0-10b00a5820bf
# # bis_bsh$jb %>% unique %>% length
# # bis_bsh$V1 == " "
# # subset(bis_bsh,V1!="@LGW800") %>% head 
# # subset(bis_bsh,V1!="@LGW800") %>% head 

# # property.message.id



# # f_df<-subset(bis_bsh,log_level==" ERROR" | log_level==" WARN") 
# # f_df %>% head


# # df_error<-df_error[,c(-4,-6,-8,-9)]


# df_error %>% head
# df_error$property.message.id %>% unique %>% length


# df_error$property.list %>% unique %>% length

# # cfbf60d0-9a17-11e6-95f0-10b00a5820bf
# # gsub(".*([[:alnum:]]{8}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{12}).*","\\1", text, perl = TRUE)

# gpair<-gregexpr("[[:alnum:]]{8}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{12}", text)
# # gpair[[1]]%>%attr("match.length")
# # sapply(gpair[[1]],)



# frm_gexpr_tool1(see_id,text)
# frm_gexpr_tool2(see_id,text)
# step2.messageid<-llply(step1.message,function(x) frm_gexpr_tool1(see_id,x)) %>%unlist %>%unique
# step2.messageid<-step2.messageid[step2.messageid!=""]
# # in bis_bsh find char of  step2.messageid
# target_line<-bis_bsh$id_no2 %in% step2.messageid
# target_line1<-llply(bis_bsh$id_no,  function(x) x%>%unlist %in% step2.messageid%>%any) %>%unlist
# bis_bsh[target_line,] %>%frm_show_html_v2("c") # center align
# bis_bsh[target_line,] %>%frm_show_html_v2("l")  #left align
# bis_bsh[target_line,] %>%nrow
# df_target3<-bis_bsh[target_line,] 

# df_target4<-bis_bsh[target_line1,] 
# df_target4%>%nrow
# df_target4%>%frm_show_html_v2("l")  #left align
# # show diff line between target 4 and target 3 
# setdiff(df_target4%>%rownames,df_target3%>%rownames)
# setdiff(df_target3%>%rownames,df_target4%>%rownames)


# c(\"df806dc0-9a17-11e6-95f0-10b00a5820bf\", \"df8046b0-9a17-11e6-95f0-10b00a5820bf\")
# # confirm whether lack some ids

# step3.messageid<-llply(df_target3$property.message.id,function(x) frm_gexpr_tool1(see_id,x)) %>%unlist %>%unique

 
# bis_bsh$id_no2[27] %in% c("df806dc0-9a17-11e6-95f0-10b00a5820bf")

# tempcheck<-bis_bsh$id_no[27]%>%unlist %in% c("df8046b0-9a17-11e6-95f0-10b00a5820bf","xxx") %>%any

# df806dc0-9a17-11e6-95f0-10b00a5820bf


# # all.messageid<-llply(bis_bsh,function(x) frm_gexpr_tool1(see_id,x))
# # bis_bsh[bis_bsh$property.list %in%step2.messageid,]



# gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", txt, perl=TRUE)
# gsub("\\b(\\w)",    "\\U\\1",       txt, perl=TRUE)


# read.table(file, header = FALSE, sep = "\t", quote = "\"'",
#            dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
#            row.names, col.names, as.is = !stringsAsFactors,
#            na.strings = "NA", colClasses = NA, nrows = -1,
#            skip = 0, check.names = TRUE, fill = !blank.lines.skip,
#            strip.white = FALSE, blank.lines.skip = TRUE,
#            comment.char = "#",
#            allowEscapes = FALSE, flush = FALSE,
#            stringsAsFactors = default.stringsAsFactors(),
#            fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)





subset(bis_bsh,log_level=3)

log4j.appender.LOGFILE.layout.ConversionPattern=@LGW800\t%d{yyyy-MM-dd'T'HH:mm:ss.SSSZ}\t %c\t cli\t %t\t LOCALHOST\t %p\t %X{env}\t %X{property.user}\t %X{property.list}\t %X{property.message.id}\t %m%n




as2<-read.csv("D:/help_line/welm/log/log/adapters/as2controller.lgw.5",header = F,sep = "\t")
names(as2)<-c("V1","time","compoent","jb","adapter","env","log_level","V8","V9","user","property.list","property.message.id")



names(as2)

BIS 652 sp 14 
http listerner does not work without reason
physical memory 64G
usage memory  4G
Then reactive the configured http listerner in  configuration/HTTP SERVICES\listerner ,the http listerner recovery to work again.
The issuse always happens.

There is noting in the front-end Montioring /adapter monitor /error monitor

There are som kinds error in log as below 


@LGW800	2016-10-26T05:51:13.057+0800	 org.apache.tomcat.util.net.JIoEndpoint	 JB700	 http--0.0.0.0-15001-Acceptor-0	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 Error allocating socket processor: java.util.concurrent.RejectedExecutionException: Task org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor@36bb1bb5 rejected from com.seeburger.httplistener.connectors.ListenerThreadPoolExecutor@101d9f30[Running, pool size = 150, active threads = 150, queued tasks = 150, completed tasks = 17737]
	at java.util.concurrent.ThreadPoolExecutor$AbortPolicy.rejectedExecution(ThreadPoolExecutor.java:2047)
	at java.util.concurrent.ThreadPoolExecutor.reject(ThreadPoolExecutor.java:823)
	at java.util.concurrent.ThreadPoolExecutor.execute(ThreadPoolExecutor.java:1369)
	at org.apache.tomcat.util.net.JIoEndpoint.processSocket(JIoEndpoint.java:1236)
	at org.apache.tomcat.util.net.JIoEndpoint$Acceptor.run(JIoEndpoint.java:324)
	at java.lang.Thread.run(Thread.java:745)



@LGW800	2016-10-25T02:34:48.291+0800	 com.seeburger.ws.adapter.server.InitiatorServant	 JB700	 http-listener-worker-thread-1125305 (10000)@WS Server	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 000	 	 {sys.classname=com.seeburger.ws.adapter.server.InitiatorServant}	 659a9160-9a18-11e6-95f0-10b00a5820bf	 Process invocation error: Operation 'Aisino_request' of service 'Aisino_requestPort: Initiation of synchronous task 659a9161-9a18-11e6-95f0-10b00a5820bf failed.: com.seeburger.initiator.exc.RuleEngineException: com.seeburger.initiator.exc.RuleEngineException: LocalActionHander:invokeProcess(): Invocation of process failed.com.seeburger.invoker.InvokerException: Process failed with BPEL Fault: {http://uri.seeburger.com/dt/mail/wsdl}DtFault: com.seeburger.af.exception.AdapterInitiationException: Initiation of synchronous task 659a9161-9a18-11e6-95f0-10b00a5820bf failed.
	at com.seeburger.af.AdapterFrameworkBase.initiateSynchronous(AdapterFrameworkBase.java:1133)
	at com.seeburger.af.AdapterFrameworkBase.initiateSynchronousWS(AdapterFrameworkBase.java:1042)
	at com.seeburger.af.AbstractWSProcessor.initiateSync(AbstractWSProcessor.java:204)
	at com.seeburger.ws.adapter.server.InitiatorServant.invokeInOut(InitiatorServant.java:153)
	at com.seeburger.ws.engine.server.InOutReceiver.invokeBusinessLogic(InOutReceiver.java:137)
	at org.apache.axis2.receivers.AbstractInOutMessageReceiver.invokeBusinessLogic(AbstractInOutMessageReceiver.java:40)
	at org.apache.axis2.receivers.AbstractMessageReceiver.receive(AbstractMessageReceiver.java:114)
	at org.apache.axis2.engine.AxisEngine.receive(AxisEngine.java:181)
	at com.seeburger.ws.engine.server.ServerPipeline.invokeInOut(ServerPipeline.java:91)
	at com.seeburger.ws.engine.WSEngine.in(WSEngine.java:225)
	at com.seeburger.ws.adapter.server.WSServer.receiveHttpRequest_aroundBody0(WSServer.java:176)
	at com.seeburger.ws.adapter.server.WSServer$AjcClosure1.run(WSServer.java:1)
	at org.aspectj.runtime.reflect.JoinPointImpl.proceed(JoinPointImpl.java:149)
	at com.seeburger.common.aspects.compiletime.aspects.BundleLoaderAsTCCLAspect.useCorrectClassLoader(BundleLoaderAsTCCLAspect.java:67)
	at com.seeburger.ws.adapter.server.WSServer.receiveHttpRequest(WSServer.java:118)
	at com.seeburger.af.AbstractHttpProcessor.service(AbstractHttpProcessor.java:242)
	at com.seeburger.httplistener.service.HTTPListenerService.invokeByName(HTTPListenerService.java:107)
	at com.seeburger.httplistener.connectors.ListenerValve.invoke(ListenerValve.java:580)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:368)
	at org.apache.coyote.http11.Http11Processor.process(Http11Processor.java:877)
	at org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler.process(Http11Protocol.java:671)
	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:518)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)
Caused by: com.seeburger.initiator.exc.RuleEngineException: com.seeburger.initiator.exc.RuleEngineException: LocalActionHander:invokeProcess(): Invocation of process failed.com.seeburger.invoker.InvokerException: Process failed with BPEL Fault: {http://uri.seeburger.com/dt/mail/wsdl}DtFault
	at com.seeburger.rule.impl.RuleEngine.decide(RuleEngine.java:265)
	at com.seeburger.initiator.impl.Initiator.initiateSync(Initiator.java:457)
	at com.seeburger.frame.connection.SeeInitiatorConnector.doInitiateTask(SeeInitiatorConnector.java:358)
	at com.seeburger.frame.connection.SeeInitiatorConnector.initiateSync(SeeInitiatorConnector.java:180)
	at com.seeburger.frame.FrameWork.initiateSync(FrameWork.java:145)
	at com.seeburger.af.AdapterFrameworkBase.initiateSynchronous(AdapterFrameworkBase.java:1104)
	... 24 more
Caused by: com.seeburger.initiator.exc.RuleEngineException: LocalActionHander:invokeProcess(): Invocation of process failed.com.seeburger.invoker.InvokerException: Process failed with BPEL Fault: {http://uri.seeburger.com/dt/mail/wsdl}DtFault
	at com.seeburger.action.handler.impl.LocalActionHandler.invokeProcess(LocalActionHandler.java:323)
	at com.seeburger.action.handler.impl.LocalActionHandler.handle(LocalActionHandler.java:206)
	at com.seeburger.rule.impl.RuleEngine.decide(RuleEngine.java:261)
	... 29 more
Caused by: com.seeburger.invoker.InvokerException: Process failed with BPEL Fault: {http://uri.seeburger.com/dt/mail/wsdl}DtFault
	at com.seeburger.invoker.impl.InboxInvoker.initiateAndWait(InboxInvoker.java:123)
	at com.seeburger.action.handler.impl.LocalActionHandler.invokeProcess(LocalActionHandler.java:299)
	... 31 more


@LGW800	2016-10-25T04:12:28.295+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 [Fatal Error] :-1:-1: Premature end of file.

@LGW800	2016-10-25T04:12:28.296+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 org.xml.sax.SAXParseException; Premature end of file.

@LGW800	2016-10-25T04:12:28.297+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.apache.xerces.parsers.DOMParser.parse(DOMParser.java:244)

@LGW800	2016-10-25T04:12:28.298+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.apache.xerces.jaxp.DocumentBuilderImpl.parse(DocumentBuilderImpl.java:285)

@LGW800	2016-10-25T04:12:28.299+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor13363.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.300+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.300+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.301+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.Reflect.invokeMethod(Reflect.java:134)

@LGW800	2016-10-25T04:12:28.302+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.Reflect.invokeObjectMethod(Reflect.java:80)

@LGW800	2016-10-25T04:12:28.302+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.Name.invokeMethod(Name.java:862)

@LGW800	2016-10-25T04:12:28.303+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHMethodInvocation.eval(BSHMethodInvocation.java:75)

@LGW800	2016-10-25T04:12:28.304+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:102)

@LGW800	2016-10-25T04:12:28.305+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:47)

@LGW800	2016-10-25T04:12:28.305+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHVariableDeclarator.eval(BSHVariableDeclarator.java:86)

@LGW800	2016-10-25T04:12:28.306+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHTypedVariableDeclaration.eval(BSHTypedVariableDeclaration.java:84)

@LGW800	2016-10-25T04:12:28.307+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.evalBlock(BSHBlock.java:130)

@LGW800	2016-10-25T04:12:28.307+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.eval(BSHBlock.java:80)

@LGW800	2016-10-25T04:12:28.308+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.eval(BSHBlock.java:46)

@LGW800	2016-10-25T04:12:28.309+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHTryStatement.eval(BSHTryStatement.java:86)

@LGW800	2016-10-25T04:12:28.310+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.evalBlock(BSHBlock.java:130)

@LGW800	2016-10-25T04:12:28.310+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.eval(BSHBlock.java:80)

@LGW800	2016-10-25T04:12:28.311+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invokeImpl(BshMethod.java:362)

@LGW800	2016-10-25T04:12:28.312+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invoke(BshMethod.java:258)

@LGW800	2016-10-25T04:12:28.312+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invoke(BshMethod.java:186)

@LGW800	2016-10-25T04:12:28.313+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.Name.invokeLocalMethod(Name.java:921)

@LGW800	2016-10-25T04:12:28.314+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.Name.invokeMethod(Name.java:808)

@LGW800	2016-10-25T04:12:28.314+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHMethodInvocation.eval(BSHMethodInvocation.java:75)

@LGW800	2016-10-25T04:12:28.315+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:102)

@LGW800	2016-10-25T04:12:28.316+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:47)

@LGW800	2016-10-25T04:12:28.317+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHVariableDeclarator.eval(BSHVariableDeclarator.java:86)

@LGW800	2016-10-25T04:12:28.317+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHTypedVariableDeclaration.eval(BSHTypedVariableDeclaration.java:84)

@LGW800	2016-10-25T04:12:28.318+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.evalBlock(BSHBlock.java:130)

@LGW800	2016-10-25T04:12:28.319+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BSHBlock.eval(BSHBlock.java:80)

@LGW800	2016-10-25T04:12:28.320+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invokeImpl(BshMethod.java:362)

@LGW800	2016-10-25T04:12:28.320+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invoke(BshMethod.java:258)

@LGW800	2016-10-25T04:12:28.321+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.BshMethod.invoke(BshMethod.java:186)

@LGW800	2016-10-25T04:12:28.322+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.This.invokeMethod(This.java:255)

@LGW800	2016-10-25T04:12:28.322+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.This.invokeMethod(This.java:174)

@LGW800	2016-10-25T04:12:28.323+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.XThis$Handler.invokeImpl(XThis.java:194)

@LGW800	2016-10-25T04:12:28.324+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at bsh.XThis$Handler.invoke(XThis.java:131)

@LGW800	2016-10-25T04:12:28.325+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.sun.proxy.$Proxy145.execute(Unknown Source)

@LGW800	2016-10-25T04:12:28.325+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.script.executor.ScriptExecutor.execute(ScriptExecutor.java:320)

@LGW800	2016-10-25T04:12:28.326+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor9548.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.327+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.327+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.328+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.invservice.WebServiceRegistry.executeMethodWithReturn(WebServiceRegistry.java:126)

@LGW800	2016-10-25T04:12:28.329+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.invservice.java.SeeWSIFJavaOperation.executeRequestResponseOperation(SeeWSIFJavaOperation.java:76)

@LGW800	2016-10-25T04:12:28.330+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.model.impl.base.ServiceInvoker.invoke(ServiceInvoker.java:450)

@LGW800	2016-10-25T04:12:28.330+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.model.impl.activity.InvokeImpl.execute(InvokeImpl.java:260)

@LGW800	2016-10-25T04:12:28.331+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.model.impl.base.ExecutionQueue2.execute(ExecutionQueue2.java:200)

@LGW800	2016-10-25T04:12:28.332+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.model.impl.base.BPELObjectExecutor.startObjectExecution(BPELObjectExecutor.java:192)

@LGW800	2016-10-25T04:12:28.332+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.model.impl.base.BusinessProcessImpl.messageReceived(BusinessProcessImpl.java:678)

@LGW800	2016-10-25T04:12:28.333+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.managers.impl.ProcessManager.messageReceived(ProcessManager.java:1233)

@LGW800	2016-10-25T04:12:28.334+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.BusinessProcessEngineBase.messageReceived(BusinessProcessEngineBase.java:397)

@LGW800	2016-10-25T04:12:28.335+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor1061.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.335+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.336+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.337+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceMethodInterceptorFactory$ManagedReferenceMethodInterceptor.processInvocation(ManagedReferenceMethodInterceptorFactory.java:72)

@LGW800	2016-10-25T04:12:28.337+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.338+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)

@LGW800	2016-10-25T04:12:28.339+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.seeauth.session.interceptors.SessionTokenInterceptorBase.processSessionTokenBase(SessionTokenInterceptorBase.java:32)

@LGW800	2016-10-25T04:12:28.340+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.client.interceptors.SessionTokenInterceptor.processSessionToken(SessionTokenInterceptor.java:23)

@LGW800	2016-10-25T04:12:28.340+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor456.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.341+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.342+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.342+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)

@LGW800	2016-10-25T04:12:28.343+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.344+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)

@LGW800	2016-10-25T04:12:28.345+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.seeauth.session.interceptors.SessionTokenInterceptorBase.processSessionTokenBase(SessionTokenInterceptorBase.java:32)

@LGW800	2016-10-25T04:12:28.345+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.client.interceptors.SessionTokenInterceptor.processSessionToken(SessionTokenInterceptor.java:23)

@LGW800	2016-10-25T04:12:28.346+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor456.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.347+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.348+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.348+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)

@LGW800	2016-10-25T04:12:28.349+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.350+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)

@LGW800	2016-10-25T04:12:28.350+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.base.util.hibernate.CacheInterceptor.evictCacheEntries(CacheInterceptor.java:30)

@LGW800	2016-10-25T04:12:28.351+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.EngineCacheInterceptor.evictCacheEntries(EngineCacheInterceptor.java:44)

@LGW800	2016-10-25T04:12:28.352+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor455.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.353+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.354+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.354+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)

@LGW800	2016-10-25T04:12:28.355+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.356+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.WeavedInterceptor.processInvocation(WeavedInterceptor.java:53)

@LGW800	2016-10-25T04:12:28.357+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.interceptors.UserInterceptorFactory$1.processInvocation(UserInterceptorFactory.java:36)

@LGW800	2016-10-25T04:12:28.357+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.358+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.jpa.interceptor.SBInvocationInterceptor.processInvocation(SBInvocationInterceptor.java:47)

@LGW800	2016-10-25T04:12:28.359+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.360+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InitialInterceptor.processInvocation(InitialInterceptor.java:21)

@LGW800	2016-10-25T04:12:28.360+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.361+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.362+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.interceptors.ComponentDispatcherInterceptor.processInvocation(ComponentDispatcherInterceptor.java:53)

@LGW800	2016-10-25T04:12:28.363+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.363+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.pool.PooledInstanceInterceptor.processInvocation(PooledInstanceInterceptor.java:51)

@LGW800	2016-10-25T04:12:28.364+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.365+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInCallerTx(CMTTxInterceptor.java:202)

@LGW800	2016-10-25T04:12:28.365+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.required(CMTTxInterceptor.java:306)

@LGW800	2016-10-25T04:12:28.366+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.processInvocation(CMTTxInterceptor.java:190)

@LGW800	2016-10-25T04:12:28.367+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.368+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.CurrentInvocationContextInterceptor.processInvocation(CurrentInvocationContextInterceptor.java:41)

@LGW800	2016-10-25T04:12:28.369+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.370+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.LoggingInterceptor.processInvocation(LoggingInterceptor.java:59)

@LGW800	2016-10-25T04:12:28.371+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.371+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.NamespaceContextInterceptor.processInvocation(NamespaceContextInterceptor.java:50)

@LGW800	2016-10-25T04:12:28.372+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.373+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.AdditionalSetupInterceptor.processInvocation(AdditionalSetupInterceptor.java:32)

@LGW800	2016-10-25T04:12:28.373+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.374+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.TCCLInterceptor.processInvocation(TCCLInterceptor.java:45)

@LGW800	2016-10-25T04:12:28.375+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.375+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.376+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ViewService$View.invoke(ViewService.java:165)

@LGW800	2016-10-25T04:12:28.377+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ViewDescription$1.processInvocation(ViewDescription.java:173)

@LGW800	2016-10-25T04:12:28.377+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.378+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.379+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ProxyInvocationHandler.invoke(ProxyInvocationHandler.java:72)

@LGW800	2016-10-25T04:12:28.380+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.BusinessProcessEngine$$$view316.messageReceived(Unknown Source)

@LGW800	2016-10-25T04:12:28.380+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.jms.WLHReceiverEJB.doConsume(WLHReceiverEJB.java:297)

@LGW800	2016-10-25T04:12:28.381+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.jms.BaseMessageDrivenBean.onMessage(BaseMessageDrivenBean.java:127)

@LGW800	2016-10-25T04:12:28.382+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor1060.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.383+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.384+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.384+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceMethodInterceptorFactory$ManagedReferenceMethodInterceptor.processInvocation(ManagedReferenceMethodInterceptorFactory.java:72)

@LGW800	2016-10-25T04:12:28.385+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.386+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)

@LGW800	2016-10-25T04:12:28.386+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.base.util.hibernate.CacheInterceptor.evictCacheEntries(CacheInterceptor.java:30)

@LGW800	2016-10-25T04:12:28.387+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.seeburger.engine.EngineCacheInterceptor.evictCacheEntries(EngineCacheInterceptor.java:44)

@LGW800	2016-10-25T04:12:28.388+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor455.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.389+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.389+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.390+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)

@LGW800	2016-10-25T04:12:28.391+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.392+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.WeavedInterceptor.processInvocation(WeavedInterceptor.java:53)

@LGW800	2016-10-25T04:12:28.392+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.interceptors.UserInterceptorFactory$1.processInvocation(UserInterceptorFactory.java:36)

@LGW800	2016-10-25T04:12:28.393+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.394+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InitialInterceptor.processInvocation(InitialInterceptor.java:21)

@LGW800	2016-10-25T04:12:28.394+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.395+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.396+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.interceptors.ComponentDispatcherInterceptor.processInvocation(ComponentDispatcherInterceptor.java:53)

@LGW800	2016-10-25T04:12:28.397+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.397+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.pool.PooledInstanceInterceptor.processInvocation(PooledInstanceInterceptor.java:51)

@LGW800	2016-10-25T04:12:28.398+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.399+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInCallerTx(CMTTxInterceptor.java:202)

@LGW800	2016-10-25T04:12:28.400+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.required(CMTTxInterceptor.java:306)

@LGW800	2016-10-25T04:12:28.401+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.tx.CMTTxInterceptor.processInvocation(CMTTxInterceptor.java:190)

@LGW800	2016-10-25T04:12:28.401+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.402+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.CurrentInvocationContextInterceptor.processInvocation(CurrentInvocationContextInterceptor.java:41)

@LGW800	2016-10-25T04:12:28.403+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.404+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.LoggingInterceptor.processInvocation(LoggingInterceptor.java:59)

@LGW800	2016-10-25T04:12:28.404+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.405+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.NamespaceContextInterceptor.processInvocation(NamespaceContextInterceptor.java:50)

@LGW800	2016-10-25T04:12:28.406+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.407+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.interceptors.AdditionalSetupInterceptor.processInvocation(AdditionalSetupInterceptor.java:43)

@LGW800	2016-10-25T04:12:28.407+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.408+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.component.messagedriven.MessageDrivenComponentDescription$5$1.processInvocation(MessageDrivenComponentDescription.java:184)

@LGW800	2016-10-25T04:12:28.409+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.409+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.TCCLInterceptor.processInvocation(TCCLInterceptor.java:45)

@LGW800	2016-10-25T04:12:28.410+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.411+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.411+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ViewService$View.invoke(ViewService.java:165)

@LGW800	2016-10-25T04:12:28.412+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ViewDescription$1.processInvocation(ViewDescription.java:173)

@LGW800	2016-10-25T04:12:28.413+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)

@LGW800	2016-10-25T04:12:28.414+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)

@LGW800	2016-10-25T04:12:28.415+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ee.component.ProxyInvocationHandler.invoke(ProxyInvocationHandler.java:72)

@LGW800	2016-10-25T04:12:28.416+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at javax.jms.MessageListener$$$view286.onMessage(Unknown Source)

@LGW800	2016-10-25T04:12:28.416+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.GeneratedMethodAccessor829.invoke(Unknown Source)

@LGW800	2016-10-25T04:12:28.417+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)

@LGW800	2016-10-25T04:12:28.418+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.reflect.Method.invoke(Method.java:497)

@LGW800	2016-10-25T04:12:28.419+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.inflow.MessageEndpointInvocationHandler.doInvoke(MessageEndpointInvocationHandler.java:140)

@LGW800	2016-10-25T04:12:28.419+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.jboss.as.ejb3.inflow.AbstractInvocationHandler.invoke(AbstractInvocationHandler.java:73)

@LGW800	2016-10-25T04:12:28.420+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at com.sun.proxy.$Proxy96.onMessage(Unknown Source)

@LGW800	2016-10-25T04:12:28.421+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.hornetq.ra.inflow.HornetQMessageHandler.onMessage(HornetQMessageHandler.java:278)

@LGW800	2016-10-25T04:12:28.421+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.hornetq.core.client.impl.ClientConsumerImpl.callOnMessage(ClientConsumerImpl.java:1008)

@LGW800	2016-10-25T04:12:28.422+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.hornetq.core.client.impl.ClientConsumerImpl$Runner.run(ClientConsumerImpl.java:1138)

@LGW800	2016-10-25T04:12:28.423+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at org.hornetq.utils.OrderedExecutorFactory$OrderedExecutor$1.run(OrderedExecutorFactory.java:107)

@LGW800	2016-10-25T04:12:28.423+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)

@LGW800	2016-10-25T04:12:28.424+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)

@LGW800	2016-10-25T04:12:28.425+0800	 stderr	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 	 	 	 	 	at java.lang.Thread.run(Thread.java:745)

@LGW800	2016-10-25T04:12:28.426+0800	 com.seeburger.script.executor.ScriptExecutor	 JB700	 Thread-151318 (HornetQ-client-global-threads-1074586133)@engineCorrelationReceiver	 BSHCN_EDI@NAASWIEDI03P	 ERROR	 000	 	 {sys.classname=com.seeburger.script.executor.ScriptExecutor}	 0ad53b00-9a26-11e6-95f0-10b00a5820bf.p1477339886282	 [ScriptExecutor:execute()] Exception occured. : java.lang.NullPointerException: Source and/or Return Type can not be null
	at org.apache.xpath.jaxp.XPathExpressionImpl.evaluate(XPathExpressionImpl.java:278)
	at sun.reflect.GeneratedMethodAccessor13398.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at bsh.Reflect.invokeMethod(Reflect.java:134)
	at bsh.Reflect.invokeObjectMethod(Reflect.java:80)
	at bsh.Name.invokeMethod(Name.java:862)
	at bsh.BSHMethodInvocation.eval(BSHMethodInvocation.java:75)
	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:102)
	at bsh.BSHPrimaryExpression.eval(BSHPrimaryExpression.java:47)
	at bsh.BSHVariableDeclarator.eval(BSHVariableDeclarator.java:86)
	at bsh.BSHTypedVariableDeclaration.eval(BSHTypedVariableDeclaration.java:84)
	at bsh.BSHBlock.evalBlock(BSHBlock.java:130)
	at bsh.BSHBlock.eval(BSHBlock.java:80)
	at bsh.BshMethod.invokeImpl(BshMethod.java:362)
	at bsh.BshMethod.invoke(BshMethod.java:258)
	at bsh.BshMethod.invoke(BshMethod.java:186)
	at bsh.This.invokeMethod(This.java:255)
	at bsh.This.invokeMethod(This.java:174)
	at bsh.XThis$Handler.invokeImpl(XThis.java:194)
	at bsh.XThis$Handler.invoke(XThis.java:131)
	at com.sun.proxy.$Proxy145.execute(Unknown Source)
	at com.seeburger.script.executor.ScriptExecutor.execute(ScriptExecutor.java:320)
	at sun.reflect.GeneratedMethodAccessor9548.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at com.seeburger.engine.invservice.WebServiceRegistry.executeMethodWithReturn(WebServiceRegistry.java:126)
	at com.seeburger.engine.invservice.java.SeeWSIFJavaOperation.executeRequestResponseOperation(SeeWSIFJavaOperation.java:76)
	at com.seeburger.engine.model.impl.base.ServiceInvoker.invoke(ServiceInvoker.java:450)
	at com.seeburger.engine.model.impl.activity.InvokeImpl.execute(InvokeImpl.java:260)
	at com.seeburger.engine.model.impl.base.ExecutionQueue2.execute(ExecutionQueue2.java:200)
	at com.seeburger.engine.model.impl.base.BPELObjectExecutor.startObjectExecution(BPELObjectExecutor.java:192)
	at com.seeburger.engine.model.impl.base.BusinessProcessImpl.messageReceived(BusinessProcessImpl.java:678)
	at com.seeburger.engine.managers.impl.ProcessManager.messageReceived(ProcessManager.java:1233)
	at com.seeburger.engine.BusinessProcessEngineBase.messageReceived(BusinessProcessEngineBase.java:397)
	at sun.reflect.GeneratedMethodAccessor1061.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceMethodInterceptorFactory$ManagedReferenceMethodInterceptor.processInvocation(ManagedReferenceMethodInterceptorFactory.java:72)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)
	at com.seeburger.seeauth.session.interceptors.SessionTokenInterceptorBase.processSessionTokenBase(SessionTokenInterceptorBase.java:32)
	at com.seeburger.engine.client.interceptors.SessionTokenInterceptor.processSessionToken(SessionTokenInterceptor.java:23)
	at sun.reflect.GeneratedMethodAccessor456.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)
	at com.seeburger.seeauth.session.interceptors.SessionTokenInterceptorBase.processSessionTokenBase(SessionTokenInterceptorBase.java:32)
	at com.seeburger.engine.client.interceptors.SessionTokenInterceptor.processSessionToken(SessionTokenInterceptor.java:23)
	at sun.reflect.GeneratedMethodAccessor456.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)
	at com.seeburger.base.util.hibernate.CacheInterceptor.evictCacheEntries(CacheInterceptor.java:30)
	at com.seeburger.engine.EngineCacheInterceptor.evictCacheEntries(EngineCacheInterceptor.java:44)
	at sun.reflect.GeneratedMethodAccessor455.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.WeavedInterceptor.processInvocation(WeavedInterceptor.java:53)
	at org.jboss.as.ee.component.interceptors.UserInterceptorFactory$1.processInvocation(UserInterceptorFactory.java:36)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.jpa.interceptor.SBInvocationInterceptor.processInvocation(SBInvocationInterceptor.java:47)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InitialInterceptor.processInvocation(InitialInterceptor.java:21)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.interceptors.ComponentDispatcherInterceptor.processInvocation(ComponentDispatcherInterceptor.java:53)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.pool.PooledInstanceInterceptor.processInvocation(PooledInstanceInterceptor.java:51)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInCallerTx(CMTTxInterceptor.java:202)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.required(CMTTxInterceptor.java:306)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.processInvocation(CMTTxInterceptor.java:190)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.CurrentInvocationContextInterceptor.processInvocation(CurrentInvocationContextInterceptor.java:41)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.LoggingInterceptor.processInvocation(LoggingInterceptor.java:59)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ee.component.NamespaceContextInterceptor.processInvocation(NamespaceContextInterceptor.java:50)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.AdditionalSetupInterceptor.processInvocation(AdditionalSetupInterceptor.java:32)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ee.component.TCCLInterceptor.processInvocation(TCCLInterceptor.java:45)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.ViewService$View.invoke(ViewService.java:165)
	at org.jboss.as.ee.component.ViewDescription$1.processInvocation(ViewDescription.java:173)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.ProxyInvocationHandler.invoke(ProxyInvocationHandler.java:72)
	at com.seeburger.engine.BusinessProcessEngine$$$view316.messageReceived(Unknown Source)
	at com.seeburger.engine.jms.WLHReceiverEJB.doConsume(WLHReceiverEJB.java:297)
	at com.seeburger.engine.jms.BaseMessageDrivenBean.onMessage(BaseMessageDrivenBean.java:127)
	at sun.reflect.GeneratedMethodAccessor1060.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceMethodInterceptorFactory$ManagedReferenceMethodInterceptor.processInvocation(ManagedReferenceMethodInterceptorFactory.java:72)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:374)
	at com.seeburger.base.util.hibernate.CacheInterceptor.evictCacheEntries(CacheInterceptor.java:30)
	at com.seeburger.engine.EngineCacheInterceptor.evictCacheEntries(EngineCacheInterceptor.java:44)
	at sun.reflect.GeneratedMethodAccessor455.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ee.component.ManagedReferenceLifecycleMethodInterceptorFactory$ManagedReferenceLifecycleMethodInterceptor.processInvocation(ManagedReferenceLifecycleMethodInterceptorFactory.java:123)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.WeavedInterceptor.processInvocation(WeavedInterceptor.java:53)
	at org.jboss.as.ee.component.interceptors.UserInterceptorFactory$1.processInvocation(UserInterceptorFactory.java:36)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.InitialInterceptor.processInvocation(InitialInterceptor.java:21)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.interceptors.ComponentDispatcherInterceptor.processInvocation(ComponentDispatcherInterceptor.java:53)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.pool.PooledInstanceInterceptor.processInvocation(PooledInstanceInterceptor.java:51)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInCallerTx(CMTTxInterceptor.java:202)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.required(CMTTxInterceptor.java:306)
	at org.jboss.as.ejb3.tx.CMTTxInterceptor.processInvocation(CMTTxInterceptor.java:190)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.CurrentInvocationContextInterceptor.processInvocation(CurrentInvocationContextInterceptor.java:41)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.LoggingInterceptor.processInvocation(LoggingInterceptor.java:59)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ee.component.NamespaceContextInterceptor.processInvocation(NamespaceContextInterceptor.java:50)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.interceptors.AdditionalSetupInterceptor.processInvocation(AdditionalSetupInterceptor.java:43)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ejb3.component.messagedriven.MessageDrivenComponentDescription$5$1.processInvocation(MessageDrivenComponentDescription.java:184)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.as.ee.component.TCCLInterceptor.processInvocation(TCCLInterceptor.java:45)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.ViewService$View.invoke(ViewService.java:165)
	at org.jboss.as.ee.component.ViewDescription$1.processInvocation(ViewDescription.java:173)
	at org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:288)
	at org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:61)
	at org.jboss.as.ee.component.ProxyInvocationHandler.invoke(ProxyInvocationHandler.java:72)
	at javax.jms.MessageListener$$$view286.onMessage(Unknown Source)
	at sun.reflect.GeneratedMethodAccessor829.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.jboss.as.ejb3.inflow.MessageEndpointInvocationHandler.doInvoke(MessageEndpointInvocationHandler.java:140)
	at org.jboss.as.ejb3.inflow.AbstractInvocationHandler.invoke(AbstractInvocationHandler.java:73)
	at com.sun.proxy.$Proxy96.onMessage(Unknown Source)
	at org.hornetq.ra.inflow.HornetQMessageHandler.onMessage(HornetQMessageHandler.java:278)
	at org.hornetq.core.client.impl.ClientConsumerImpl.callOnMessage(ClientConsumerImpl.java:1008)
	at org.hornetq.core.client.impl.ClientConsumerImpl$Runner.run(ClientConsumerImpl.java:1138)
	at org.hornetq.utils.OrderedExecutorFactory$OrderedExecutor$1.run(OrderedExecutorFactory.java:107)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)



Could you help us to do some analysis about the error message,please?
How to avoid the http listerner reactive?
How to do some confirguration in frontend to detect the issus if the http listerner does not work without reason?