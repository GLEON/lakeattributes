data_combine = function(zmax, ...){

	
	#Add area data to sysdata if it doesn't already contain it
	if(file.exists('R/sysdata.rda')){
		sysdata = new.env()
		load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
		rm(sysdata, envir=sysdata)#weird hack, I don't understand save
	}else{
		sysdata = new.env()
	}
	
	sysdata$zmax = zmax
	#sysdata$wtemp = wtemp
	
	save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)
}