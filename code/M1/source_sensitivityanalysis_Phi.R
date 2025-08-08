#################################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 8 Aug 2025
# 
# source_sensitivityanalysis_Phi.R
# 
# This script performs sensitivity analysis of the Phi process.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main_output.R
# 
# this script calls other scripts: null
#
# functions called: function(2) means the function is called twice in this
# script. Functions called in the scripts listed above are not listed.
# PlotCIbandwithDataseries(1) - data series plots for checking purpose.
# 
# 
# input data:
# 1. data/Aux_data/district_DHScode.csv
# 2. data/output/M1_postinfo_exclude-alpha_jt.csv"
# - "data/output/M1/selectP_M1.rda"
# - "data/output/M1_test_normal/selectP_M1_test_normal.rda"
# - "data/output/M1_test_normal_ar2/selectP_M1_test_normal_ar2.rda"
#
# output data: null
#
# output plots in folder fig/ - sensitivity_Phi_Nepalprovince.pdf
#############################################################################

runname.list <- c("M1", "M1_test_normal", "M1_test_normal_ar2")

for (run in runname.list) {
  load(file = paste0("data/output/", run, "/selectP_", run, ".rda")) #selectP
  name.out <- paste0("selectP", which(run == runname.list)); print(name.out)
  eval(parse(text = paste0("selectP", which(run == runname.list), " <- selectP")))
}#end of run loop

## plot ##
pdf(paste0(fig.dir, "sensitivity_Phi_Nepalprovince.pdf"), 
    width = 10*1.6, height = 13*1.7)
par(cex.lab = 2.7, cex.axis = 2.5, mgp = c(6.2, 1.4, 0), mar = c(4, 8.2, 4, 1),
    cex.main = 3.2, las = 1, tcl = -1, mfrow = c(4, 2))
yr.start <- 1980
yr.end <- 2016
t.select <- is.element(years.t-0.5, c(yr.start:yr.end))
plot.lim <- c(-0.1, 0.1)
for (c in 1:C) {
  
  P1.qt <- SamplesToUI(t(selectP1[["logP.jtl"]][c, , ]))[, t.select]
  P2.qt <- SamplesToUI(t(selectP2[["logP.ctl"]][c, , ]))[, t.select]
  P3.qt <- SamplesToUI(t(selectP3[["logP.ctl"]][c, , ]))[, t.select]
  
  PlotCIbandwithDataseries(
    SElim = plot.lim, datalim = plot.lim,
    main = paste0("SRB in Province ", c),
    alpha.dataseries = 0.7,
    alpha.point      = 1,
    alpha.polygon    = 0.5,
    year.t = yr.start:yr.end,
    CI1s = P1.qt, CI2s = P2.qt, CI3s = P3.qt,
    colCI = c("red", "blue", "limegreen"),
    lwd.CI1 = 12, lwd.CI2 = 7, lwd.CI3 = 5,
    x = year.i, select.x = TRUE,
    x.lim = c(yr.start, yr.end),
    ylab = "Sex Ratio at Birth", xlab = "", cutoff = 0,
    lwd.dataseries = 3, legendCI.posi = "topleft", cex.legend = 2.5)
} # end of c loop
plot(0, type = "n", xlab = "", ylab = "", main = "", xaxt = "n", yaxt = "n", bty = "n")
legend("left", c(expression(paste("AR(1); fix ", rho, ",", sigma[epsilon])),
                 expression(paste("AR(1); model ", rho, ",", sigma[epsilon])),
                 expression(paste("AR(2); model ", rho[1], ",", rho[2], ",", sigma[epsilon]))),
       lwd = 5, col = c("red", "blue", "limegreen"), cex = 2.7)
dev.off()

## the end ##

