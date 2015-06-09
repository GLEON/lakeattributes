#'@title Turbidity data table
#'
#'
#'@name turbidity
#'
#'@return turbidity data.frame with all available observed turbidity data.
#'
#'\tabular{lll}{
#'Name \tab Type \tab Description\cr
#'site_id \tab character \tab Unique identifier of site\cr
#'year \tab numeric \tab Year of observation\cr
#'date \tab character \tab Date of observation (May 15th for turbidity averages)\cr
#'turbidity_ntu \tab numeric \tab Observed or estimated turbidity in NTU\cr
#'source \tab character \tab Source (Just in-situ right now)\cr
#'}
#'
#'@docType data
#'
#'@examples
#'head(turbidity)
#'
#'@export turbidity
NULL