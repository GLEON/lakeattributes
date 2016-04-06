#canopy


nlcd_based = read.table('data-raw/canopy/hc_sheltering.tsv', as.is=TRUE, sep='\t', header=TRUE)
names(nlcd_based) = c('site_id', 'canopy_m')
nlcd_based$source = 'nlcd'

canopy = rbind(nlcd_based)
#lets just try making it part of 'data'
save(canopy, file='data/canopy.rdata')
