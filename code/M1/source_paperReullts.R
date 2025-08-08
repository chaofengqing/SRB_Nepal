 ###############################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 8 Aug 2025
# 
# source_adj_dataSetup.R
# 
# This script is the results of the paper.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main.R and main_output.R
# 
# this script calls other scripts: null
#
# functions called: null
# 
# input data: data/Aux_data/district_DHScode.csv
#             data/output/M1_postinfo_exclude-alpha_jt.csv
# output data: null
#############################################################################

## paper results ##
yr <- 2016
sort(res.proj$R2.jqt[, 2, paste(yr)])
round(res.proj$R2.jqt["Province 5", , paste(yr)], 3)
round(res.proj$R2.jqt["Province 2", , paste(yr)], 3)

yr <- 1980
sort(res.proj$R2.jqt[, 2, paste(yr)])
round(res.proj$R2.jqt["Province 7", , paste(yr)], 3)
round(res.proj$R2.jqt["Province 4", , paste(yr)], 3)

## read in prince and district info
pro.info <- read.csv(paste0(aux.data.dir, "district_DHScode.csv"),
                     header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)
for (p in 1:7) {
  print(paste("Province", p))
  msg <- paste(pro.info[pro.info$Province.Name == p, "District.Name"], collapse = "; ")
  print(paste(sum(pro.info$Province.Name == p), "Districts"))
  print(msg)
} # end of p loop
range(pro.info$District.Code)


adj.info <- read.csv(paste0(output.dir, runname,
                            "_postinfo_exclude-alpha_jt.csv"), row.names = 1)

for (j in 1:C.adj) {
  t.index <- as.numeric(floor(adj.info[paste0("T0.j[", j, "]"), c("X50.percentile",
                                                         "X2.5.percentile",
                                                         "X97.5.percentile")]))
  t.index[t.index < 1] <- 1
  start.yr <- years.t[t.index]
  cat("Province", c.adj[j], floor(start.yr), "\n")
}
