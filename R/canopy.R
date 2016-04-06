#' @title Lake surrounding canopy height
#' 
#' @description
#' Canopy height in meters derived from a variety of sourced
#' linked to the NHD PermIDs.
#' 
#' @return canopy data.frame with all available observed heights
#' 
#' \tabular{lll}{
#' site_id \tab character \tab Unique identifier of site\cr
#' canopy_m \tab numeric \tab Estimated canopy height in meters\cr
#' source \tab character \tab Source of data (NLCD, satellite, etc)\cr
#' }
#' 
#' @docType data
#' 
#' @examples
#' data(canopy)
#' head(canopy)
#' 
"canopy"