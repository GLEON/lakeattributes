
library(dplyr)
library(lubridate)
library(digest)
#parse and save the secchi data, creating two classifications, "in-situ" and "satellite"

source('R/encryption_helpers.R')

LAGOS_KEY = Sys.getenv('LAGOS_KEY')

necsc = read_aes('data-raw/secchi/all_secchi.edt', LAGOS_KEY)

lagos = subset(necsc, source=='lagos')
secchi = subset(necsc, source!='lagos')

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

