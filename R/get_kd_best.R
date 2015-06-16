#'@title Return best available secchi/Kd
#'
#'@inheritParams get_kd_year
#'
#'
#'@details
#'This implements a hierarchical selection routine. The hierarchy is:
#'\enumerate{
#'	\item Mean in-situ secchi data for each year available
#'	\item Mean satellite secchi data for each year availble
#'	\item Overall mean in-situ secchi value for the lake
#'	\item Overall mean satellite secchi value for the lake
#'	\item Population mean of in-situ data (currently 2.46566 meters)
#'}
#'
#' This guarantees you will always get a secchi value for a lake. This 
#' does not mean that lake has observed secchi data, as 'population mean' 
#' is the catch-all. 
#'@return
#'A data frame with columns 'year', 'secchi_avg', and 'source'. 
#'
#'@import dplyr
#'
#'@examples
#'
#'#get the best available secchi depths for Sparkling lake
#'get_kd_best('WBIC_1881900', 1979:2012)
#'
#'
#'@export
get_kd_best = function(id, years){
	
	if(missing(years)){
		stop('Must specify requested years')
	}
	
	insitu = get_kd_year(id, years=years, src = 'in-situ') %>%
		group_by(year) %>%
		summarise(secchi_avg=mean(secchi_m, na.rm=TRUE))
	insitu$source = 'in-situ'
	
	for(i in 1:nrow(insitu)){
		
		#lets start building the data we need
		if(!is.na(insitu$secchi_avg[i])){
			next
		}
		
		## so we know we have a missing secchi value
		sat = get_kd_year(id, insitu$year[i], src='satellite')
		if(nrow(sat) > 0 && !is.na(sat$secchi_m)){
			insitu$secchi_avg[i] = mean(sat$secchi_m, na.rm=TRUE)
			insitu$source[i] = 'satellite'
		}
	}
	
	## any missing values now, we replace with overall in-situ mean
	insitu$source[is.na(insitu$secchi_avg)] = 'in-situ mean'
	insitu$secchi_avg[is.na(insitu$secchi_avg)] = mean(get_kd_year(id, src='in-situ')$secchi_m, na.rm=TRUE)
	
	## any missing values now, we replace with overall satellite mean
	insitu$source[is.na(insitu$secchi_avg)] = 'satellite mean'
	insitu$secchi_avg[is.na(insitu$secchi_avg)] = mean(get_kd_year(id, src='satellite')$secchi_m, na.rm=TRUE)
	
	## any missing values now, we replace with overall in-situ population mean
	# Code:
	# library(lakeattributes)
	# all_kd = get_kd_avg(to_run, default.if.null = FALSE, src='in-situ')$kd_avg
	# mean(1.7/all_kd[!is.infinite(all_kd) & !is.na(all_kd)])
	insitu$source[is.na(insitu$secchi_avg)] = 'global mean'
	insitu$secchi_avg[is.na(insitu$secchi_avg)] = 2.46566
	
	return(as.data.frame(insitu))
}