data_combine = function(...){

	
	#Add area data to sysdata if it doesn't already contain it
	if(file.exists('R/sysdata.rda')){
		sysdata = new.env()
		load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
		rm(sysdata, envir=sysdata)#weird hack, I don't understand save
	}else{
		sysdata = new.env()
	}
	
	data_in = list(...)
	data_names = names(data_in)
	for(i in 1:length(data_names)){
		sysdata[[data_names[i]]] = data_in[[i]]
	}
	
	#sysdata$zmax = zmax
	save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)	
}