
library(dplyr)
library(lubridate)
#parse and save the wtemp data

## WQP wtemp data
wqp = read.table('data-raw/wtemp/wqp_temperature.tsv', sep='\t', header=TRUE, as.is=TRUE)

wqp = transmute(wqp, site_id=id, year=year(as.POSIXct(Date)), date=as.POSIXct(Date), depth=depth, wtemp=wtemp)
wqp$source = 'in-situ'


wtemp = rbind(wqp)


#Add wtemp data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
}else{
	sysdata = new.env()
}

sysdata$wtemp = wtemp
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

