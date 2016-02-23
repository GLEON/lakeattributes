#'@title Get surface elevation for a given lake
#'@description
#'Get the elevation of a lake with given ID
#'
#'@param site_id The character ID for the requested data
#'
#'@return
#' Elevation in meters
#'@details
#'TODO
#'
#'
#'@author 
#'Luke Winslow, Jordan Read
#'
#'
#'
#'@export
get_elevation = function(id){
	warning('just setting elevation to 320 right now (mean elevation of WI,MN,MI')
	return(320)
}