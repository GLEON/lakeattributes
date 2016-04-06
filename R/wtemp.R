#' @title Water Temperature data table
#' 
#' @description
#' Water temperature observations collected from a variety of
#' sourced. Primarily profile data, indexed by NHD PermID.
#' 
#' @return wtemp data.frame with all available observed water temp data.
#' 
#' \tabular{lll}{
#' Name \tab Type \tab Description\cr
#' site_id \tab character \tab Unique identifier of site\cr
#' year \tab numeric \tab Year of observation\cr
#' date \tab character \tab Date of observation\cr
#' wtr \tab numeric \tab Observed water temp in deg C\cr
#' source \tab character \tab Source (currently only in-situ)\cr
#' }
#' 
#' @docType data
#' 
#' @examples
#' data(wtemp)
#' head(wtemp)
#' 
"wtemp"