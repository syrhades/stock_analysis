 u = "http://tidesonline.nos.noaa.gov/data_read.shtml?station_info=9414290+San+Francisco,+CA"
 h = htmlParse(u)
 p = getNodeSet(h, "//pre")
 con = textConnection(xmlValue(p[[2]]))
 tides = read.table(con)