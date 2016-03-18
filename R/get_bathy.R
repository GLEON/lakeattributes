#' @title Get Hypsometry for a given lake
#' @description
#' Returns the hypsometry profile for a lake with the given ID
#' 
#' @param site_id The character ID for the requested data
#' @param cone_est Estimate bathymetry as a cone using available zmax data
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
get_bathy = function(site_id, cone_est=TRUE){
	numZ	<-	15
	fileN	<-	system.file(paste(c('Bathy/', site_id, '.bth'), collapse=''), 
											 package=packageName())
	
	if (file.exists(fileN)){
		data	<-	read.table(fileN,header=TRUE,sep='\t')
		bathymetry	<-	data.frame(depths=data$depth,areas=data$area)
	} else if(cone_est){
		lkeArea	<-	get_area(site_id)
		zMax	<-	get_zmax(site_id)
		depth	<-	seq(0,zMax,length.out=numZ)
		area	<-	approx(c(0,zMax),c(lkeArea,0),depth)$y
		bathymetry	<-	data.frame(depths=depth,areas=area)
	}else{
		return(NULL)
	}
	
	return(bathymetry)
}