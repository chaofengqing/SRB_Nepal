

## This script is to analyze the relation between
## starting year of SRB inflation period and TFR value
## Furthermore, to find the mean of the informative prior for
## start year parameter.

## for all the adj.name.list countries, further choose a subset
## of countries with smaller sampling error in order to be used
## for assigning informative prior

# mean.j <- median.j <- prop.j <- rep(NA, C.adj)
# 
# for (j in 1:C.adj) {
#   j.se <- logSE.i[name.i == name.c[c.adj[j]] &
#                     year.i >= adj.year]
#   mean.j[j] <- mean(j.se, na.rm = TRUE)
#   median.j[j] <- median(j.se, na.rm = TRUE)
#   prop.j[j] <- mean(j.se <= SE.lower)
#   cat(j, name.c[c.adj[j]], "\n")
#   cat("\tmean is", round(mean.j[j], 3), "\n")
#   cat("\tmedian is", round(median.j[j], 3), "\n")
#   cat("\tproportion below 0.01 is", round(prop.j[j]*100, 1), "\n")
# }#end of j loop
# 
# ## select countries with median of logSE at most 0.01
# adj.name.startinflate.b <- name.c[c.adj[mean.j <= SE.lower *2]]
# adj.name.startinflate.b
# 
# ## for selected countries above, compute the starting year
# ## of inflation using VR data only, since the estimates will be
# ## main driven by VR data
# 
# ## read in posterior predictive distribution from normal run
# load(file = paste0("data/output/", normal.runname, "/",
#                    "post_pred_traj_",normal.runname,".rda")) #ppd.el
# 
# period.length <- 5
# pencentile.cutoff <- 0.5#0.75
# obs.year.startinflate.b <- rep(NA, length(adj.name.startinflate.b))
# 
# for (b in 1:length(adj.name.startinflate.b)) {
#   cat(b, "/", length(adj.name.startinflate.b), adj.name.startinflate.b[b], "\n")
#   select.b <- which(ppd.el[["name.e"]] == adj.name.startinflate.b[b] &
#                       ppd.el[["year.e"]] >= adj.year &
#                       ppd.el[["source.e"]] == S)
#   
#   ## need to order the year in sequence
#   order.by.year.b <- order(ppd.el[["year.e"]][select.b])
#   select.b <- select.b[order.by.year.b]
#   
#   vr.points.u <- ppd.el[["r.e"]][select.b]
#   ppd.median.u <- apply(ppd.el[["post_pred.el"]][select.b, ], 1,
#                         quantile, pencentile.cutoff)
#   
#   ## if 5 consecutive years the vr data point value > median of PPD
#   ## consider it as a starting year of SRB inflation
#   count <- 0
#   for (u in 1:length(select.b)) {
#     
#     if (vr.points.u[u] <= ppd.median.u[u]) {
#       count <- 0
#     } else {
#       count <- count + 1
#     }#end of ifelse
#     
#     if (count == period.length) {
#       u.index <- ifelse(u == period.length, 1, u - period.length)
#       obs.year.startinflate.b[b] <- ppd.el[["year.e"]][select.b[u.index]]
#       break
#     }#end of if
#   }#end of u loop
#   
# }#end of b loop
# 
# cbind(adj.name.startinflate.b, obs.year.startinflate.b)
# 
# 
# ## get the TFR value when SRB starts to inflate for countries that
# ## SRB happened/is happening.
# 
# 
# ## read in TFR data ##
# wpp.data <- read.csv("data/input/WPPdata/WPP2019_INT_F01_ANNUAL_DEMOGRAPHIC_INDICATORS.csv",
#                      header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)
# 
# plot.year <- c(adj.year:2099.5)
# 
# obs.TFR.startinflate.b <- rep(NA, length(adj.name.startinflate.b))
# names(obs.year.startinflate.b) <-
#   names(obs.TFR.startinflate.b) <- adj.name.startinflate.b
# 
# 
# for (b in 1:length(adj.name.startinflate.b)) {
#   country <- adj.name.startinflate.b[b]
#   c <- which(name.c == country)
#   
#   select.wpp <- which(wpp.data$LocID == iso.c[c] &
#                         wpp.data$MidPeriod == obs.year.startinflate.b[b])
#   obs.TFR.startinflate.b[b] <- as.numeric(wpp.data[select.wpp, "TFR"])
# }#end of b loop
# 
# mean(obs.TFR.startinflate.b) #2.764 - 20170417 #2.562
# median(obs.TFR.startinflate.b) #2.538 - 20170417 #2.5295
# sd(obs.TFR.startinflate.b) #1.213138 - 20170417 #0.3028946
# 
# print(cbind(adj.name.startinflate.b, obs.year.startinflate.b, obs.TFR.startinflate.b))


load(file = paste0(interim.dir, "tfr_province.ct.rda")) #tfr.ct

# TFR.target <- round(median(obs.TFR.startinflate.b), 1)
TFR.target <- 2.6 #pnas paper for Nepal
print(paste("TFR median is", TFR.target))

year.TFRtarget.j <- index.TFRtarget.j <- rep(NA, C.adj)
names(year.TFRtarget.j) <- names(index.TFRtarget.j) <- name.c[c.adj]

for (j in 1:C.adj) {
  c <- c.adj[j]
  tfr <- as.numeric(tfr.ct[name.c[c], ])
  year.TFRtarget.j[j] <- years.t[which.min(abs(tfr - TFR.target))]
  index.TFRtarget.j[j] <- which(years.t == year.TFRtarget.j[j])
}#end of c loop

year.TFRtarget.j

## the end ##

