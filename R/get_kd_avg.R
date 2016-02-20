#'@title Get light attenuation coefficient for a given lake
#'@description
#'Returns the light attenuation coefficient for a lake with the given ID
#'
#'@param ids The character ID for the requested kd data. Can be a character vector.
#'@param default.if.null boolean indicating if default Kd should be used if lake has no observations
#'@param src The data source, currently one of \code{c('in-situ', 'satellite')}. In-situ observations are default
#'
#'@return
#' Light attenuation coefficient in m^-1
#'@details
#'TODO
#'
#'
#'@author 
#'Luke Winslow, Jordan Read
#'
#'@import dplyr
#'
#'@examples
#'#NA returned when no site with that ID found
#'get_kd_avg(c('WBIC_6100', 'WBIC_10000', 'asdf'))
#'
#'#Some lakes have satellite data available
#'get_kd_avg(c('WBIC_6100', 'WBIC_805400', 'asdf'), src='satellite')
#'
#'#Default can be requested as well
#'get_kd_avg(c('WBIC_6100','asdf', 'WBIC_10000', 'asdf'), default.if.null=TRUE)
#'
#'
#'@export
get_kd_avg = function(ids, default.if.null=FALSE, src='in-situ'){
	
	default.kd = 0.6983965
	
	secchiConv = 1.7
	
	#ids = toupper(ids)
	
	#first filter by site ids so we're using a smaller dataset
	tmp = filter(secchi, site_id %in% ids, source==src)
	
	tmp = group_by(tmp, site_id) %>%
					summarise(kd_avg=secchiConv/mean(secchi_m)) %>%
					right_join(data.frame(site_id=ids, stringsAsFactors=FALSE))  #this maintains order

	if(default.if.null){
		tmp$kd_avg[is.na(tmp$kd_avg)] = default.kd
	}
	
	return(tmp)
}