#update_all.R
unlink('R/sysdata.rda')
source('data-raw/area/area.R')
source('data-raw/depth/depths.R')
source('data-raw/location/location.R')
source('data-raw/secchi/secchi.R')
source('data-raw/turbidity/turbidity.R')