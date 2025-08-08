
###############################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 8 Aug 2025
#
# source_ADJ&TFR_relation.R
# 
# This script analyze the relation between starting year of SRB inflation period
# and TFR value. Furthermore, to find the mean of the informative prior for
# start year parameter.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main.R and main_output.R;
#
# this script calls other scripts: null
#
# functions called: null
# 
# input data: null
#
# output data: null
# 
###############################################################################


## This script is to analyze the relation between
## starting year of SRB inflation period and TFR value
## Furthermore, to find the mean of the informative prior for
## start year parameter.

## for all the adj.name.list countries, further choose a subset
## of countries with smaller sampling error in order to be used
## for assigning informative prior

load(file = paste0(interim.dir, "tfr_province.ct.rda")) #tfr.ct

TFR.target <- 2.6 # pnas paper for Nepal
print(paste("TFR median is", TFR.target))

year.TFRtarget.j <- index.TFRtarget.j <- rep(NA, C.adj)
names(year.TFRtarget.j) <- names(index.TFRtarget.j) <- name.c[c.adj]

for (j in 1:C.adj) {
  c <- c.adj[j]
  tfr <- as.numeric(tfr.ct[name.c[c], ])
  year.TFRtarget.j[j] <- years.t[which.min(abs(tfr - TFR.target))]
  index.TFRtarget.j[j] <- which(years.t == year.TFRtarget.j[j])
} # end of c loop

year.TFRtarget.j

## the end ##

