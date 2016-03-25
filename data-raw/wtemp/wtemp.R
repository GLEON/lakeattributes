
#library(dplyr)
#library(lubridate)
#parse and save the wtemp data

watertemp = function(){
	## wtemp data
	wtemp = read.table('data-raw/wtemp/all_temp.tsv', sep='\t', header=TRUE, as.is=TRUE)
	
	wtemp = transmute(wtemp, site_id=id, year=year(fasttime::fastPOSIXct(date)), date=fasttime::fastPOSIXct(date), depth=depth, wtemp=wtemp)
	wtemp$source = 'in-situ'
	
	
	wtemp = rbind(wtemp)
	
	return(wtemp)
}
# 
# #Add wtemp data to sysdata if it doesn't already contain it
#' if(file.exists('R/sysdata.rda')){
#' 	sysdata = new.env()
#' 	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
#' 	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
#' }else{
#' 	sysdata = new.env()
#' }
#' 
#' sysdata$wtemp = wtemp
#' save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)
# 
