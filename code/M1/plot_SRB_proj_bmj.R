###############################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 7 Aug 2025
#
# plot_CI_SRB_NepalProvince.R
#
# This script plots projected SRB with uncertainty and baseline for 
# each province of Nepal.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main_output.R;
#
# this script calls other scripts: null
#
# functions called: function(2) means the function is called twice in this
# script. Those functions called in the scripts listed above are not listed.
# PlotCIbandwithDataseries(1)
#
# input data: null
#
# output data in folder fig/: 
# 1. CIs_SRB_Nepal_province_M1_bmj.pdf 
###############################################################################
pdf(paste0(fig.dir, "CIs_SRB_Nepal_province_", runname, "_bmj.pdf"),
    height = 50, width = 25)
text.cex <- 4.5
par(cex.lab = text.cex, cex.axis = text.cex, mgp = c(11, 3, 0), mar = c(5, 14, 6, 2),
    cex.main = 6, las = 1, tcl = -1, mfrow = c(7, 1))
plot.range <- range(res.proj$a.jqt, res.proj[["R2.jqt"]], na.rm = TRUE)
for (country in name.c) {
  c <- which(country == name.c)
  # # sort by survey date to get nicer legend
  
  R.qt <- res.proj[["R2.jqt"]][country, , ]
  
  a.qt <- res.proj$a.jqt[country, , ]
  par(las = 1)
  PlotCIbandwithDataseries(
    if.LogScale = TRUE, if.SurveyLegend = TRUE,
    year.t = floor(years.t),
    CI1s = R.qt, 
    CI2s = a.qt,
    x = floor(years.t), select.x = TRUE, x.lim = c(2010, 2050),
    SElim = plot.range, datalim = plot.range,
    main = country, #alpha.dataseries = 0.8, cex.dataseries = 1.5,
    ylab = "Sex Ratio at Birth", xlab = "Year", cutoff = exp(logNmu),
    lwd.CI1 = 15, lwd.CI2 = 10, lwd.dataseries = 3, colCI = c("red", "darkgreen"),
    cex.legend = text.cex, legendCI.posi = "topleft", legendSurvey.posi = "bottomright")
  if (c == 1) {
    legend("topright", c("Provincial SRB", "National SRB baseline"),
           col = c("red", "darkgreen"), lwd = 10, cex = text.cex)
  } # end of if(c == 1)
  axis(1, at = 2016, labels = 2016)
  abline(v = 2016)
  
  max.yr <- years.t[which.max(R.qt[2, ])]-0.5
  abline(v = max.yr, lty = 3, col = "red3")
  text(pos = 4, x = max.yr, y = 1.125, labels = max.yr, col = "red3", cex = text.cex)
} # end of c loop
dev.off()

for (country in name.c) {
  R.qt <- res.proj[["R2.jqt"]][country, , ]
  max.yr <- years.t[which.max(R.qt[2, ])]-0.5
  cat(country, max.yr, "\t")
  print(round(R.qt[, paste(max.yr)], 3))
}
