

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

