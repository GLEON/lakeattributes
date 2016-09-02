.onAttach = function(libname, pkgname){
	
	#warning(ls(envir = parent.env(environment())))
	
	#look for LAGOS_KEY environ variable
	if(Sys.getenv('LAGOS_KEY', unset = '') != ''){
		#if there, use to open lagos datasets and append to secchi, depth
		
		## load LAGOS secchi data and append
		lagos_secchi = read_aes(system.file('extdata/lagos_secchi.edt', package=pkgname), Sys.getenv('LAGOS_KEY', unset = ''))
		#names(lagos_secchi) = c('site_id', 'secchi_m', 'year', 'month')
		
		#lagos_secchi$date = ISOdate(lagos_secchi$year, lagos_secchi$month, 15)
		#lagos_secchi$source = 'in-situ'
		
		secchi = rbind(secchi, lagos_secchi)
		
		#omg what a hack, this was not as clean as I thought it would be
		unlockBinding('secchi', parent.env(environment()))
		secchi <<- secchi
	  .GlobalEnv$secchi = secchi
	  lockBinding('secchi', parent.env(environment()))
	  
	  
	}
	#otherwise, do nothing
}