#' @title Get Hypsometry for a given lake
#' @description
#' Returns the hypsometry profile for a lake with the given ID
#' 
#' @param site_id The character ID for the requested data
#' 
#' @return
#' Data frame with columns \code{depth} and \code{area}
#' 
#' 
#' @examples 
#' get_bathy('nhd_1097324')
#' 
#' 
#' @export
get_bathy = function(site_id){
	numZ	<-	15
	fileN	<-	system.file(paste(c('Bathy/', site_id, '.bth'), collapse=''), 
											 package=packageName())
	
	if (file.exists(fileN)){
		data	<-	read.table(fileN,header=TRUE,sep='\t')
		bathymetry	<-	data.frame(depths=data$depth,areas=data$area)
	} else {
		lkeArea	<-	get_area(site_id)
		zMax	<-	get_zmax(site_id)
		depth	<-	seq(0,zMax,length.out=numZ)
		area	<-	approx(c(0,zMax),c(lkeArea,0),depth)$y
		bathymetry	<-	data.frame(depths=depth,areas=area)
	}
	
	return(bathymetry)
}