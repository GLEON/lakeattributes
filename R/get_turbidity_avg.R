#'@title Get lake average turbidity
#'
#'@inheritParams get_kd_avg
#'
#'
#'@author Luke Winslow
#'
#'
#'
#'@export
get_turbidity_avg = function(ids, src='in-situ'){
		
	
	ids = toupper(ids)
	
	#first filter by site ids so we're using a smaller dataset
	tmp = filter(turbidity, site_id %in% ids, source==src)
	
	tmp = group_by(tmp, site_id) %>%
		summarise(turbidity_avg=mean(turbidity_ntu)) %>%
		right_join(data.frame(site_id=ids, stringsAsFactors=FALSE))  #this maintains order
	
	return(tmp)
}
