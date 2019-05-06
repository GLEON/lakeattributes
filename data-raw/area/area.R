
#parse and save the area data, creating two classifications

#grab the areas from the NHD 1:100k processed data
nhd = read.table('data-raw/area/nhd_area.csv', sep=',', header=TRUE, quote='\"', as.is=TRUE)
names(nhd) = c('site_id', 'area_m2')

lter = read.csv('data-raw/area/lter_lake_areas.csv', as.is=TRUE)
lter$site_id = lter$id
lter$area_m2 = lter$area_ha * 1e4

#merge to area
area = rbind(nhd, lter[,c('site_id', 'area_m2')])

# grab new data for footprint expansion
new_area <- readRDS('data-raw/area/lakeattributes_area.rds')

area <- bind_rows(area, new_area) %>%
	distinct()

#Add area data to sysdata if it doesn't already contain it
if(file.exists('R/sysdata.rda')){
	sysdata = new.env()
	load('R/sysdata.rda', envir=sysdata, verbose=TRUE)
	rm(sysdata, envir=sysdata)#weird hack, I don't understand save
}else{
	sysdata = new.env()
}

sysdata$area = area
save(list=names(sysdata), file = "R/sysdata.rda", envr=sysdata, compress=TRUE)

