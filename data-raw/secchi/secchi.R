
library(dplyr)
library(lubridate)
library(digest)
library(fasttime)

#parse and save the secchi data, creating two classifications, "in-situ" and "satellite"

source('R/encryption_helpers.R')

LAGOS_KEY = Sys.getenv('LAGOS_KEY')

necsc = read_aes('data-raw/secchi/all_secchi.edt', LAGOS_KEY)
necsc$year = year(fastPOSIXct(necsc$date, tz='GMT'))
necsc$site_id = necsc$id
necsc$datasource = necsc$source 
necsc$source = necsc$type
necsc$secchi_m = necsc$secchi

necsc = necsc[,c('site_id', 'year', 'date', 'secchi_m', 'source', 'datasource')]

lagos = subset(necsc, datasource=='lagos')
secchi = subset(necsc, datasource!='lagos')

write_aes(lagos, 'inst/extdata/lagos_secchi.edt', key=LAGOS_KEY)


#Add secchi data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
}else{
	sysdata = new.env()
}

sysdata$secchi = secchi
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

