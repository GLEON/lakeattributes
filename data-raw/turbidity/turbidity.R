
library(dplyr)
library(lubridate)
#parse and save the turbidity data, creating two classifications, "in-situ" (at the moment)


## data from swims
swims = read.table(gzfile('data-raw/turbidity/turbidity_data_SWIMS.csv.gz'), sep=',', 
								 header=TRUE, as.is=TRUE, quote="\"", comment.char="")

swims$START_DATETIME = as.Date(strptime(swims$START_DATETIME, format='%d-%b-%y'))

swims_clean = transmute(swims, site_id=paste0('WBIC_', WBIC), year=year(START_DATETIME),
												date=START_DATETIME, turbidity_ntu=Result.Value, source='in-situ')


turbidity = rbind(swims_clean)

#Make all site IDS caps
turbidity$site_id = toupper(turbidity$site_id)

#Add turbidity data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata)
}else{
	sysdata = new.env()
}

sysdata$turbidity = turbidity
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

