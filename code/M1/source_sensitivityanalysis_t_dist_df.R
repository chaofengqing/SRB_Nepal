#################################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 8 Aug 2025
# 
# source_sensitivityanalysis_t_dist_df.R
# 
# This script performs a sensitivity analysis comparing two model assumptions
# for the error distribution in the time series process
#
# used for which run: Main.run
#
# this script is called by any other scripts: main_output.R
# 
# this script calls other scripts: null
#
# functions called: function(2) means the function is called twice in this
# script. Functions called in the scripts listed above are not listed.
# 1. SamplesToUI(8): compute uncertainty intervals from posterior samples
# 2. PlotCIbandwithDataseries(1): plot SRB trajectories with uncertainty bands
# 
# 
# input data:
# 1. data/output/M1/M1_postinfo_exclude-alpha_jt.csv
# 2. data/output/M1_t_dist_df/M1_t_dist_df_postinfo_exclude-alpha_jt.csv
# 3. data/output/M1/traj_M1_R2.jtl.rda
# 4. data/output/M1_t_dist_df/traj_M1_t_dist_df_R2.jtl.rda
# 5. data/output/M1/cis_M1_senario_proj.rda
# 6. data/output/M1_t_dist_df/cis_M1_t_dist_df_senario_proj.rda
#
# output data: null
#
# output plots in folder fig/ - sensitivity_t_dist_SRB_Nepalprovince.pdf
#############################################################################
runname.list <- c("M1", "M1_t_dist_df")
par.list <- c("T0.j")


for (par in par.list) {
  msg.out <- NULL
  for (c in 1:C) {
    parname <- paste0(par, "[", c, "]")
    msg1 <- paste0("$p=", c, "$")
    msg2 <- NULL
    for (run in runname.list) {
      post.info <- read.csv(paste0("data/output/", run, "/", run, "_postinfo_exclude-alpha_jt.csv"),
                            header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, row.names = 1)
      
      yr <- years.t[round(post.info[parname, "X50.percentile"])]-0.5
      msg1 <- paste(msg1, paste( "& ", yr))

    } # end of run loop
    
    for (run in runname.list) {
      post.info <- read.csv(paste0("data/output/", run, "/", run, "_postinfo_exclude-alpha_jt.csv"),
                            header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, row.names = 1)
      
      t1 <- round(post.info[parname, "X2.5.percentile"])
      t2 <- round(post.info[parname, "X97.5.percentile"])
      t1 <- ifelse(t1<=1, 1, t1)
      t2 <- ifelse(t2<=1, 1, t2)
      yr1 <- years.t[t1]-0.5
      yr2 <- years.t[t2]-0.5
      msg2 <- paste(msg2, " & ", paste0("(", yr1, ", ", yr2, ")"))
      
    } # end of run loop
    msg0 <- paste0(msg1, "\\", "\\ \n", msg2, "\\", "\\\ \\hline \n")
    msg.out <- paste(msg.out, msg0)
  } # end of c loop
  cat("\n\n\n", par, "\n")
  cat(msg.out)
}#end of par loop

for (run in runname.list) {
  load(file = paste0("data/output/", run, "/traj_", run, "_R2.jtl.rda")) #res.trajS2
  name.out <- paste0("res_traj", which(run == runname.list)); print(name.out)
  eval(parse(text = paste0("res_traj", which(run == runname.list), " <- res.trajS2")))
} # end of run loop

##############################
## SRB difference 1980-2050 ##
msg.out <- NULL
rud.num <- 4
yr.start <- 1980
yr.end <- 2050
for (j in 1:C) {
  parname <- "R2.jpt"
  msg1 <- paste0("$p=", j, "$ & --")
  msg2 <- " & -- "
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  }#end of run loop
  
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg2 <- paste(msg2, " & ", paste0("(", round(diff.q[1], rud.num), ", ",
                                      round(diff.q[3], rud.num), ")"))
  } # end of run loop
  msg0 <- paste0(msg1, "\\", "\\ \n", msg2, "\\", "\\\ \\hline \n")
  msg.out <- paste(msg.out, msg0)
} # end of j loop
cat(par, "\n")
cat(msg.out)

## SRB difference 1980-2016 ##
msg.out <- NULL
rud.num <- 4
yr.start <- 1980
yr.end <- 2016
for (j in 1:C) {
  parname <- "R2.jpt"
  msg1 <- paste0("$p=", j, "$ & --")
  msg2 <- " & -- "
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  } # end of run loop
  
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg2 <- paste(msg2, " & ", paste0("(", round(diff.q[1], rud.num), ", ",
                                      round(diff.q[3], rud.num), ")"))
  }#end of run loop
  msg0 <- paste0(msg1, "\\", "\\ \n", msg2, "\\", "\\\ \\hline \n")
  msg.out <- paste(msg.out, msg0)
} # end of j loop
cat(parname, "\n")
cat(msg.out)

## SRB difference 2016-2050 ##
msg.out <- NULL
rud.num <- 4
yr.start <- 2016
yr.end <- 2050
for (j in 1:C) {
  parname <- "R2.jpt"
  msg1 <- paste0("$p=", j, "$ & --")
  msg2 <- " & -- "
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  } # end of run loop
  
  for (run in 2) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg2 <- paste(msg2, " & ", paste0("(", round(diff.q[1], rud.num), ", ",
                                      round(diff.q[3], rud.num), ")"))
  } # end of run loop
  msg0 <- paste0(msg1, "\\", "\\ \n", msg2, "\\", "\\\ \\hline \n")
  msg.out <- paste(msg.out, msg0)
} # end of j loop
cat(parname, "\n")
cat(msg.out)


## plot ##
pdf(paste0(fig.dir, "sensitivity_t_dist_SRB_Nepalprovince.pdf"), 
    width = 10*1.6, height = 13*1.7)
par(cex.lab = 2.7, cex.axis = 2.5, mgp = c(6.2, 1.4, 0), mar = c(4, 8.2, 4, 1),
    cex.main = 3.2, las = 1, tcl = -1, mfrow = c(4, 2))
yr.start <- 1980
yr.end <- 2050
plot.lim <- c(1.03, 1.16)
for (c in 1:C) {

  for (run in runname.list) {
    load(file = paste0("data/output/", run, "/cis_", run, "_senario_proj.rda")) #res.proj
    eval(parse(text = paste0("res", which(run == runname.list), " <- res.proj")))
  }#end of run loop
  R1.qt <- res1[["R2.jqt"]][c, , paste(yr.start:yr.end)]
  R2.qt <- res2[["R2.jqt"]][c, , paste(yr.start:yr.end)]

  PlotCIbandwithDataseries(
    SElim = plot.lim, datalim = plot.lim,
    main = paste0("SRB in Province ", c),
    alpha.dataseries = 0.7,
    alpha.point      = 1,
    alpha.polygon    = 0.5,
    year.t = yr.start:yr.end,
    CI1s = R1.qt, CI2s = R2.qt,
    nameCI1 = expression(paste(nu, "=", 3)),
    nameCI2 = expression(paste(nu, "~ U(1,50)")),
    colCI = c("red", "blue"),
    lwd.CI1 = 12, lwd.CI2 = 7, lwd.CI3 = 5,
    x = year.i, select.x = TRUE,
    x.lim = c(yr.start, yr.end),
    ylab = "Sex Ratio at Birth", xlab = "", cutoff = exp(logNmu),
    lwd.dataseries = 3, legendCI.posi = "topleft", cex.legend = 2.5)
  abline(v = 2016)
} # end of c loop
dev.off()

