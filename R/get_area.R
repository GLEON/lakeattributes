#' @title Get lake surface area 
#' @description
#' Returns the surface area for a lake with given ID
#' 
#' @param id The character ID for the requested data 
#' 
#' @return
#'  Lake surface areas in meters^2. NA if no value available
#'  
#' @details
#' Looks for given id and returns values if availalbe. id
#' is coerced to character regardless of input type.
#' 
#' 
#' 
#' @examples
#' #Multiple values
#' get_area('nhd_1097324')
#' 
#' #this should return NA
#' get_area('asdf')
#' 
#' @export
get_area = function(id){
	
	site_id = as.character(id)
	
	lake_area = subset(area, site_id == id)
	if(nrow(lake_area) < 1){
		return(NA)
	}else{
		return(lake_area$area_m2)
	}
}
# 	
# 	##Load data
# 	acre2m2	<-	4046.85642
# 	fname = system.file('supporting_files/managed_lake_info.txt', package=packageName())
# 	d	<-	read.table(fname, header=TRUE, sep='\t', quote="\"", colClasses=c(WBIC='character'))
# 	
# 	#Lookup
# 	vals = merge(data.frame(site_id, order=1:length(site_id)), 
# 							 d, by.x='site_id', by.y='WBIC', all.x=TRUE)
# 	
# 	vals = vals[order(vals$order),]
# 	
# 	return(vals$acres * acre2m2)
