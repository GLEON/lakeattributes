#'@title Get light attenuation coefficient for a lake through time
#'@description
#'Returns the annual average light attenuation coefficient for a lake with the given ID
#'
#'@param id The character ID for the requested data
#'@param years Integer vector of years for which you want Kd values
#'@param src The data source, currently one of \code{c('in-situ', 'satellite')}. In-situ observations are default
#'
#'@return
#' data.frmae of Kd values with the same number of rows as \code{length(years)}. NA filled when missing.
#'@details
#' TODO
#'
#'
#'@author 
#'Luke Winslow, Jordan Read
#'
#'@import dplyr
#'
#'@examples
#'#Get and plot Kds for a lake over time
#'years = 1970:2012
#'kds   = get_kd_year('WBIC_1881900', years)
#'plot(secchi_m~year, kds, type='o')
#'
#'
#'@export
get_kd_year = function(id, years, src='in-situ'){
	
	secchiConv	<-	1.7
	
	#only one lake allowed
	tmp = filter(secchi, site_id == id)
	
	if(missing(years)){
		
		tmp = right_join(tmp, data.frame(source=src, stringsAsFactors = FALSE)) %>%
					mutate(kd=secchiConv/secchi_m)
		
		return(tmp)
		
	}else{
		
		tmp = right_join(tmp, data.frame(year=years, source=src, stringsAsFactors = FALSE)) %>% 
					mutate(kd=secchiConv/secchi_m)
		
		return(tmp)
	
	}
	
}