
library(dplyr)
library(lubridate)
#parse and save the secchi data, creating two classifications, "in-situ" and "satellite"


## data from swims
swims = read.table(gzfile('data-raw/secchi/secchi_data_swims_in_situ_fixed.csv.gz'), sep=',', 
								 header=TRUE, as.is=TRUE, quote="\"", comment.char="")

swims_clean = transmute(swims, site_id=paste0('WBIC_', WBIC), year=year(as.Date(START_DATETIME)),
												date=START_DATETIME, secchi_m=secchi.m, source='in-situ')

## Personal communication from Max Wolter (WDNR), dug up from archives
sawyer = read.table('data-raw/secchi/historical_sawyer_secchi.tsv', sep='\t', header=TRUE)

sawyer_clean = transmute(sawyer, site_id=lake_id, year=year(as.POSIXct(datetime)),
																date=datetime, secchi_m=secchi_meter, source='in-situ')

## satellite secchi data (from Steve Greb)
satellite = read.table('data-raw/secchi/annual_mean_secchi.txt', sep='\t', header=TRUE)

warning('Giving all satellite secchi annual means a date of June 15th as we don\'t know the year. ',
				'Do not use satellite data for timeseries analysis')

satellite_clean = transmute(satellite, site_id=paste0('wbic_', WBIC), year=year,
														date=paste0(year,'-06-15'), secchi_m=secchi.m.mean, source='satellite')


## NTL LTER secchi data
lter = read.table('data-raw/secchi/lter_data.tsv', sep='\t', header=TRUE)
lter$source = 'in-situ'


## WQP Secchi data
wqp = read.table(gzfile('data-raw/secchi/wqp_secchi.tsv.gz'), sep='\t', header=TRUE, as.is=TRUE)
wqp = transmute(wqp, site_id=id, year=year(as.POSIXct(Date)), date=Date, secchi_m=secchi)
wqp$source = 'in-situ'

secchi = rbind(swims_clean, sawyer_clean, satellite_clean, lter, wqp)

#Make all site IDS caps

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

