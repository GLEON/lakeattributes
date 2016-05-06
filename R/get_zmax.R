#' @title Get max depth for a given lake
#' @description
#' Get the max depth for a given lake id
#' 
#' @param id The character ID for the requested data
#' 
#' @return
#'  Max observed depth in meters
#' @details
#' TODO
#' 
#' 
#' 
#' 
#' @examples 
#' get_zmax('nhd_1097324')
#' 
#' 
#' @export
get_zmax = function(id){
	site_id = as.character(id)
	
	bathy = get_bathy(id, cone_est=FALSE)
	#quick short circuit. If we have a bathy file, 
	#return max depth from that. 
	
	if(!is.null(bathy)){
		return(max(bathy$depths, na.rm=TRUE))
	}
	
	lake_zmax = subset(zmax, site_id == id)
	if(nrow(lake_zmax) < 1){
		
			return(max(get_bathy(site_id, cone_est=FALSE)$depths))
		
	}else{
		if(nrow(lake_zmax) > 1){
			#TODO: Figure out why there are multiple depth estimates for some lakes
			warning(site_id, ':More than one zmax found, picking the smaller of the two')
			return(min(lake_zmax$zmax_m))
			
		}else{
			return(lake_zmax$zmax_m)
		}
	}
}
