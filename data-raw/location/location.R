
nhd_locs = read.table('data-raw/location/nhd_centroids.csv', sep=',', header=TRUE, quote='\"', as.is=TRUE)
nhd_locs$area = NULL
nhd_locs$state = NULL
names(nhd_locs) = c('site_id', 'lon', 'lat')

location = nhd_locs

#Add area data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
}else{
	sysdata = new.env()
}

sysdata$location = location
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

