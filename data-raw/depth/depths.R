#read in zmax data

bathybase = read.csv('data-raw/depth/bathynhd_final.csv', sep=',', header=TRUE, as.is=TRUE)

bathybase = bathybase[, c('bathybaseid', 'depth_max', 'id')]

names(bathybase) = c('bathybaseid', 'zmax_m', 'site_id')

zmax = bathybase[, c('site_id', 'zmax_m')]

#Add area data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
}else{
	sysdata = new.env()
}

sysdata$zmax = zmax
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

