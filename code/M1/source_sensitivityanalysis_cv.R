
runname.list <- c("M1", "M1_cv1over5", "M1_cv1over2")#, "M1_cv1")
cv.list <- c(0.1, 0.2, 0.5)
par.list <- c("a.j", "D1.j", "D2.j", "D3.j")

for (par in par.list) {
  rud.num <- ifelse(par == "a.j", 3, 2)
  msg.out <- NULL
  for (c in 1:C) {
    parname <- paste0(par, "[", c, "]")
    msg1 <- paste0("$p=", c, "$")
    msg2 <- NULL
    for (run in runname.list) {
      post.info <- read.csv(paste0("data/output/", run, "/", run, "_postinfo_exclude-alpha_jt.csv"),
                            header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, row.names = 1)
      
      
      msg1 <- paste(msg1, paste( "& ", round(post.info[parname, "X50.percentile"], rud.num)))

    }#end of run loop
    
    for (run in runname.list) {
      post.info <- read.csv(paste0("data/output/", run, "/", run, "_postinfo_exclude-alpha_jt.csv"),
                            header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, row.names = 1)
      
      
       msg2 <- paste(msg2, " & ", paste0("(", round(post.info[parname, "X2.5.percentile"], rud.num), ", ",
                           round(post.info[parname, "X97.5.percentile"], rud.num), ")"))
      
    }#end of run loop
    msg0 <- paste0(msg1, "\\", "\\ \n", msg2, "\\", "\\\ \\hline \n")
    msg.out <- paste(msg.out, msg0)
  }#end of c loop
  cat("\n\n\n", par, "\n")
  cat(msg.out)
}#end of par loop

for (run in runname.list) {
  load(file = paste0("data/output/", run, "/traj_", run, "_R2.jtl.rda")) #res.trajS2
  name.out <- paste0("res_traj", which(run == runname.list)); print(name.out)
  eval(parse(text = paste0("res_traj", which(run == runname.list), " <- res.trajS2")))
}#end of run loop

## SRB difference 1980-2050 ##
msg.out <- NULL
rud.num <- 4
yr.start <- 1980
yr.end <- 2050
for (j in 1:C) {
  parname <- "R2.jpt"
  msg1 <- paste0("$p=", j, "$ & --")
  msg2 <- " & -- "
  for (run in 2:3) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  }#end of run loop
  
  for (run in 2:3) {
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
}#end of j loop
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
  for (run in 2:3) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  }#end of run loop
  
  for (run in 2:3) {
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
}#end of j loop
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
  for (run in 2:3) {
    res.traj <- eval(parse(text = paste0("res_traj", run)))
    diff.tl <- res.traj$R2.jtl[j, paste(yr.start:yr.end), ] -
      res_traj1$R2.jtl[j, paste(yr.start:yr.end), ]
    diff.qt <- SamplesToUI(t(diff.tl))
    diff.q <- SamplesToUI(apply(diff.tl, 2, mean, na.rm = TRUE))
    
    msg1 <- paste(msg1, paste( "& ", round(diff.q[2], rud.num)))
  }#end of run loop
  
  for (run in 2:3) {
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
}#end of j loop
cat(parname, "\n")
cat(msg.out)


## plot ##
pdf(paste0(fig.dir, "sensitivity_CV_SRB_Nepalprovince.pdf"), 
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
  R3.qt <- res3[["R2.jqt"]][c, , paste(yr.start:yr.end)]
  
  PlotCIbandwithDataseries(
    SElim = plot.lim, datalim = plot.lim,
    main = paste0("SRB in Province ", c),
    alpha.dataseries = 0.7,
    alpha.point      = 1,
    alpha.polygon    = 0.5,
    year.t = yr.start:yr.end,
    CI1s = R1.qt, CI2s = R2.qt, CI3s = R3.qt,
    nameCI1 = paste0("CV=", cv.list[1]),
    nameCI2 = paste0("CV=", cv.list[2]),
    nameCI3 = paste0("CV=", cv.list[3]), 
    colCI = c("red", "blue", "limegreen"),
    lwd.CI1 = 12, lwd.CI2 = 7, lwd.CI3 = 5,
    x = year.i, select.x = TRUE,
    x.lim = c(yr.start, yr.end),
    ylab = "Sex Ratio at Birth", xlab = "", cutoff = exp(logNmu),
    lwd.dataseries = 3, legendCI.posi = "topleft", cex.legend = 2.5)
  abline(v = 2016)
}#end of c loop
dev.off()

