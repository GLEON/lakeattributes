#update_all.R
unlink('R/sysdata.rda')
sysdata = new.env()

source('data-raw/secchi/secchi.R')
source('data-raw/area/area.R')
source('data-raw/location/location.R')
source('data-raw/turbidity/turbidity.R')
source('data-raw/canopy/canopy.R')
