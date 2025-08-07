###########################################################################
# Sex ratio at birth in Vietnam among six subnational regions during 1980–2050, 
# estimation and probabilistic projection using a Bayesian hierarchical time series model 
# with 2.9 million birth records.
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 4 Aug 2025
#
# source_DirectorySetup.R
#
# This script saves provincial SRB projections in excel sheet.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main.R
#
# this script calls other scripts: null
# functions called:                null
# input data:                      null
# output data:                     null
#
# Folders that you need to create by yourself before you start this project:
# project folder: SRB_Vietnam/
# input data folder: SRB_Vietnam/data/input/
# input population data folder: SRB_Vietnam/data/input/Auxdata
#
#
# Folders that will be created after running this script for a certain run:
# 1. SRB_Vietnam/data/interim/
# 2. SRB_Vietnam/data/output/; and its subfolders
# 3. SRB_Vietnam/fig/; and its subfolders
###############################################################################


##################################################
## save provincial SRB estimates in excel sheet ##

col.names <- c("Nepal.Province.Name",
               "Indicator", "Reference.Year",
               "Quantile", "Model.Estimate")
years.print.t <- 1980:2016

data.out <- NULL
for (c in 1:C) {
  add.data <- matrix(NA, nr = Per * length(years.print.t), nc = length(col.names))
  colnames(add.data) <- col.names
  
  add.data[, "Nepal.Province.Name"] <- name.c[c]
  add.data[, "Indicator"] <- "Sex Ratio at Birth"
  add.data[, "Reference.Year"] <- rep(years.print.t, each = Per)
  add.data[, "Quantile"] <- rep(c("2.5 percentile", "Median", "97.5 percentile"), length(years.print.t))
  add.data[, "Model.Estimate"] <- c(res.proj$R2.jqt[name.c[c], , paste(years.print.t)])
  
  data.out <- rbind(data.out, add.data)
}#end of c loop

write.csv(data.out, row.names = FALSE, na = "",
          file = paste0(output.dir, "SRB_by_NepalProvince_estimates_",
                        years.print.t[1], "_to_", rev(years.print.t)[1], ".csv"))


####################################################
## save provincial SRB projections in excel sheet ##

col.names <- c("Nepal.Province.Name",
               "Indicator", "Reference.Year",
               "Quantile", "Model.Projection")
years.print.t <- 2017:2050

data.out <- NULL
for (c in 1:C) {
  add.data <- matrix(NA, nr = Per * length(years.print.t), nc = length(col.names))
  colnames(add.data) <- col.names
  
  add.data[, "Nepal.Province.Name"] <- name.c[c]
  add.data[, "Indicator"] <- "Sex Ratio at Birth"
  add.data[, "Reference.Year"] <- rep(years.print.t, each = Per)
  add.data[, "Quantile"] <- rep(c("2.5 percentile", "Median", "97.5 percentile"), length(years.print.t))
  add.data[, "Model.Projection"] <- c(res.proj$R2.jqt[name.c[c], , paste(years.print.t)])
  
  data.out <- rbind(data.out, add.data)
}#end of c loop

write.csv(data.out, row.names = FALSE, na = "",
          file = paste0(output.dir, "SRB_by_NepalProvince_projections_",
                        years.print.t[1], "_to_", rev(years.print.t)[1], ".csv"))

## THE END ##

