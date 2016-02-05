.onAttach = function(libname, pkgname){
	
	#warning(ls(envir = parent.env(environment())))
	
	#look for LAGOS_KEY environ variable
	if(Sys.getenv('LAGOS_KEY', unset = '') != ''){
		#if there, use to open lagos datasets and append to secchi, depth

		## load LAGOS secchi data and append
		lagos_secchi = read_aes('data/lagos_secchi.edt', Sys.getenv('LAGOS_KEY', unset = ''))
		names(lagos_secchi) = c('site_id', 'secchi_m', 'year', 'month')
		
		lagos_secchi$date = ISOdate(lagos_secchi$year, lagos_secchi$month, 15)
		lagos_secchi$source = 'in-situ'
		
		secchi = rbind(secchi, lagos_secchi[,c('site_id', 'year', 'date', 'secchi_m', 'source')])
		
		#omg what a hack, this was not as clean as I thought it would be
		unlockBinding('secchi', parent.env(environment()))
		secchi <<- secchi
	  .GlobalEnv$secchi = secchi
	  lockBinding('secchi', parent.env(environment()))
	  
	  
	  #load lagos depth data
	  lagos_zmax = read_aes('data/lagos_zmax.edt', Sys.getenv('LAGOS_KEY', unset = ''))
	  names(lagos_zmax) = c('site_id', 'zmax_m')
	  zmax = rbind(zmax, lagos_zmax)
	  unlockBinding('zmax', parent.env(environment()))
	  zmax <<- zmax
	  .GlobalEnv$zmax = zmax
	  lockBinding('zmax', parent.env(environment()))
	  
	}
	#otherwise, do nothing
}