#' @title Get latitude and longitude for a given lake
#' @description
#' Get the center lat/lon of a lake with given ID
#' 
#' @param id The character ID for the requested data
#' 
#' @return
#'  Lat/lon on the WGS84 datum as two-element vector in order lat, long. If not ID match found, 
#'  return NA values.
#'  
#' @details
#' Based on the exported locations data.frame. Mostly based on NHD polygon centroid lat/lons. 
#' 
#' 
#' @examples
#' get_latlon('nhd_1097324')
#' 
#' 
#' @export
get_latlon = function(id){
	
	site_id = as.character(id)
	
	lake_area = subset(location, site_id == id)
	if(nrow(lake_area) < 1){
		return(c(lat=NA, lon=NA))
	}else{
		return(c(lat=lake_area$lat, lon=lake_area$lon))
	}
	
}