
depths = function(){

	##read in lter zmaxes
	lter = read.csv('data-raw/depth/lter_zmax.csv', as.is=TRUE)
	names(lter) = c('name', 'site_id', 'zmax_m')
	lter$source = 'ntl-lter'
	
	all_necsc = readRDS('data-raw/depth/all_depths.rds')
	names(all_necsc) = c('site_id', 'source', 'type', 'zmax_m')
	
	zmax = rbind(all_necsc[, c('site_id', 'source', 'zmax_m')], lter[,c('site_id', 'source', 'zmax_m')])
	
	return(zmax)
	
	# 
	# #Add area data to sysdata if it doesn't already contain it
	# if(file.exists('R/sysdata.rda')){
	# 	sysdata = new.env()
	# 	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	# 	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
	# }else{
	# 	sysdata = new.env()
	# }
	# 
	# sysdata$zmax = zmax
	# save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

}