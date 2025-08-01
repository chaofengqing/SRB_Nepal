

############################################
## plot the results for all the countries ##

adj.info <- read.csv(paste0(output.dir, runname,
                            "_postinfo_exclude-alpha_jt.csv"), row.names = 1)

plot.year <- years.t#c(1950.5:2100.5)
select.t <- is.element(years.t, plot.year)
col.tfr <- "navyblue"
plot.country <- name.c

surveyplot.i[grepl("VR", surveyplot.i)] <- "VR"

pdf(paste0(fig.dir, "CIs_adj-Country_senario_proj_", runname, ".pdf"),
    height = 15, width = 19)
text.cex <- 4.0
par(cex.lab = text.cex, cex.axis = text.cex, mgp = c(11.5, 2.5, 0), mar = c(6, 14, 8, 11),
    cex.main = 4, las = 1, tcl = -1)
for (country in plot.country) { #c in c.asia: now plot a subset of Asian countries
  j <- which(name.c == country)
  c <- which(name.c == country)
  c.select <- which(name.i == name.c[c] & year.i > 1950)
  # sort by survey date to get nicer legend
  select <- c.select[order(surveyplot.i[c.select])]
  
  R1.qt <- res.proj[["R1.jqt"]][j, , select.t]
  R2.qt <- res.proj[["R2.jqt"]][j, , select.t]
  R3.qt <- res.proj[["R3.jqt"]][j, , select.t]

  s2.l.prob <- res.proj[["S2.l.select.prob.j"]][j]*100
  s3.l.prob <- res.proj[["S3.l.select.prob.j"]][j]*100
  plot.range <- range(R1.qt, R2.qt, R3.qt, exp(logr.i[select]), na.rm = TRUE)
  par(las = 1)
  PlotCIbandwithDataseries(
    if.LogScale = TRUE,
    dataseries = logr.i, dataseriesSE = logSEnoimpute.i, year.t = plot.year,
    CI1s = R1.qt, nameCI1 = paste0("S1 (select ", round(s2.l.prob, 2),
                                   "% traj delta*alpha=0 data period)"),
    CI2s = R2.qt, nameCI2 = "S2 (post sample)",
    CI3s = R3.qt, nameCI3 = paste0("S3 (select ", round(s3.l.prob, 2), "% traj delta=1)"),
    Source = surveyplot.i,
    baseSeries = "VR", x.lim = range(round(plot.year)),
    x = year.i, select.x = select,
    SElim = plot.range, datalim = plot.range,
    main = paste0(name.c[c],
                  " (Prob inflation=", round(res.proj$inflation.prob.j[j]*100, 1), "%)"),
    ylab = "Sex Ratio at Birth", xlab = "Year", cutoff = SRB0,  cex.dataseries = 2.7,
    lwd.CI1 = 16, lwd.CI2 = 11, lwd.CI3 = 11, lwd.dataseries = 3,
    colCI = c("blue", "red",  "orange"), alpha.dataseries = 0.8,
    cex.legend = 2.5, legendCI.posi = "bottomleft")
  abline(h = res.proj$a.jqt[j, 2, 1], lwd = 3, col = "limegreen")
  legend("topleft", "national baseline", lwd = 5, col = "limegreen", cex = 2.5)
  ##############
  ## plot TFR ##
  ## Allow a second plot on the same graph
  par(new = TRUE)
  ## Plot the second plot and put axis scale on right
  tfr <- as.numeric(tfr.ct[name.c[c], paste(plot.year-0.5)])
  
  plot(x = plot.year, y = tfr, pch = 15,  xlab = "", ylab = "", ylim = range(tfr, 2.1, na.rm = TRUE),
       axes = FALSE, type = "b", col = col.tfr, cex = 1.7)
  ## a little farther out (line=4) to make room for labels
  mtext("Total Fertility Rate", side = 4, col = "navyblue", line = 9, cex = text.cex, las = 3) 
  axis(4, col = col.tfr, col.axis = col.tfr, las = 1)
  
  # identify the starting and ending year of adjustment period
  start.yr <- years.t[floor(adj.info[paste0("T0.j[", j, "]"), "X50.percentile"])]
  end.yr   <- years.t[floor(adj.info[paste0("T3.j[", j, "]"), "X50.percentile"])]
  abline(v = c(start.yr, end.yr), col = col.tfr)
  start.tfr <- tfr[plot.year == start.yr]
  end.tfr <- tfr[plot.year == end.yr]
  text(x = start.yr, y = max(tfr, na.rm = TRUE) - 0.4, pos = 4, col = col.tfr, cex = text.cex,
       labels = paste0(floor(start.yr), "\n(TFR=", round(start.tfr, 1), ")"))
  text(x = end.yr, y = max(tfr, na.rm = TRUE) - 0.2, pos = 4, col = col.tfr, cex = text.cex,
       labels = paste0(floor(end.yr)))
}#end of c loop
dev.off()



### compare S1 with previous fitting
plot.year <- c(1980.5:2050.5)
select.t <- is.element(years.t, plot.year)
col.tfr <- "navyblue"
plot.country <- adj.name.list
plot.country[!is.element(plot.country, name.c)]
surveyplot.i[grepl("VR", surveyplot.i)] <- "VR"

for (scna in 1:3) {
  pdf(paste0(fig.dir, "CIs_adj-Country_S", scna, "_", runname, ".pdf"),
      height = 12, width = 25)
  text.cex <- 4.0
  for (country in name.c) { #c in c.asia: now plot a subset of Asian countries
    par(cex.lab = text.cex, cex.axis = text.cex, mgp = c(11.3, 2.3, 0), mar = c(6, 14, 6, 11),
        cex.main = 4, las = 1, tcl = -1)
    j <- which(name.c == country)
    c <- which(name.c == country)
    c.select <- which(name.i == name.c[c] & year.i > 1950)
    # sort by survey date to get nicer legend
    select <- c.select[order(surveyplot.i[c.select])]
    
    R.qt <- res.proj[[paste0("R", scna, ".jqt")]][j, , select.t]
    a.qt <- matrix(res.proj[["a.jqt"]][j, 2, 1], nr = Per, nc = Tend)
    plot.range <- range(R.qt, exp(logr.i[select]), na.rm = TRUE)
    par(las = 1)
    PlotCIbandwithDataseries(
      if.LogScale = TRUE, if.SurveyLegend = TRUE,
      dataseries = logr.i, dataseriesSE = logSEnoimpute.i, year.t = plot.year,
      CI1s = R.qt, nameCI1 = "Provincial SRB",
      CI2s = a.qt, nameCI2 = "National baseline",
      Source = surveyplot.i, baseSeries = "VR", x.lim = range(round(plot.year)),
      x = year.i, select.x = select,
      SElim = plot.range, datalim = plot.range,
      main = paste0(name.c[c],
                    " (Prob. inflation=", round(res.proj$inflation.prob.j[j]*100, 1), "%)"),
      ylab = "Sex Ratio at Birth", xlab = "Year", cutoff = SRB0,  cex.dataseries = 1.7,
      lwd.CI1 = 15, lwd.CI2 = 8, lwd.CI3 = 4, lwd.dataseries = 1,
      colCI = c("red", "limegreen"), alpha.dataseries = 0.8,
      cex.legend = text.cex-1, legendCI.posi = "bottomright", legendSurvey.posi = "bottomleft")
    
    ##############
    ## plot TFR ##
    par(new = TRUE)
    ## Plot the second plot and put axis scale on right
    tfr <- as.numeric(tfr.ct[name.c[c], paste(plot.year-0.5)])
    
    plot(x = plot.year, y = tfr, pch = 15,  xlab = "", ylab = "", ylim = range(tfr, 2.1, na.rm = TRUE),
         axes = FALSE, type = "b", col = col.tfr, cex = 1.7)
    ## a little farther out (line=4) to make room for labels
    mtext("Total Fertility Rate", side = 4, col = "navyblue", line = 9, cex = text.cex, las = 3) 
    axis(4, col = col.tfr, col.axis = col.tfr, las = 1)
    
    # identify the starting and ending year of adjustment period
    start.yr <- years.t[floor(adj.info[paste0("T0.j[", j, "]"), "X50.percentile"])]
    end.yr   <- years.t[floor(adj.info[paste0("T3.j[", j, "]"), "X50.percentile"])]
    abline(v = c(start.yr, end.yr), col = col.tfr)
    start.tfr <- tfr[plot.year == start.yr]
    end.tfr <- tfr[plot.year == end.yr]
    text(x = start.yr, y = max(tfr, na.rm = TRUE) - 0.4, pos = 4, col = col.tfr, cex = text.cex,
         labels = paste0(floor(start.yr), "\n(TFR=", round(start.tfr, 1), ")"))
    text(x = end.yr, y = max(tfr, na.rm = TRUE) - 0.2, pos = 2, col = col.tfr, cex = text.cex,
         labels = paste0(floor(end.yr)))
    
  }#end of c loop
  dev.off()
  
}#end of scna loop


## the end ##

