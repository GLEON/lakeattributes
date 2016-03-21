
depths = function(){

	##read in lter zmaxes
	lter = read.csv('data-raw/depth/lter_zmax.csv', as.is=TRUE)
	names(lter) = c('name', 'site_id', 'zmax_m')
	lter$source = 'ntl-lter'
	
	
	#now do lagos stuff
	if(Sys.getenv('LAGOS_KEY', unset = '') != ''){
		all_necsc = read_aes('data-raw/depth/all_depths.edt', Sys.getenv('LAGOS_KEY', unset = ''))
		names(all_necsc) = c('site_id', 'source', 'type', 'zmax_m')
		
		#Ugh, hack for LAGOS, write LAGOS out, return all non-lagos data
		just_lagos = subset(all_necsc, `source`=='lagos')
		write_aes(just_lagos[, c('site_id', 'source', 'zmax_m')], 'inst/extdata/lagos_zmax.edt', key=Sys.getenv('LAGOS_KEY', unset = ''))
		
		all_necsc = subset(all_necsc, `source`!='lagos')
		
	}
	
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