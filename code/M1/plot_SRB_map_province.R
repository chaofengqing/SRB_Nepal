

text.cex <- 0.9
boundary.lwd <- 0.5
NoDataColor <- "gray" # color for polygons with no data
boundary.color <- "slategray4"#"black" # color for country boundaries
background.color <- "white" # color for oceans, seas and lakes


library("sp")
library("RColorBrewer")
library("ggplot2")
library("rgdal")
library("scales")
require("rgeos",character.only=TRUE)

pdf(file = paste0(fig.dir, "Nepal_province_SRB.pdf"), height = 5)
par(mar = c(0, 0, 2, 0))
for (yr in seq(1980, 2050, 5)) {
  print(yr)
  print(round(quantile(res.proj$R2.jqt[, 2, paste(yr)], seq(0, 1, length.out = 9), na.rm = TRUE), 4))
  start <- round(floor(min(res.proj$R2.jqt[, 2, paste(yr)], na.rm = TRUE)*1000)/1000, 3)
  end <- round(ceiling(max(res.proj$R2.jqt[, 2, paste(yr)], na.rm = TRUE)*1000)/1000, 3)
  cutoff <- seq(start, end, length.out = 5)
  myPalette <- brewer.pal(4, "Reds")
  
  if (end > start) {
    # Read in the state-level polygon shapefile (no antarctica)
    npl1 <- readOGR("data/npl_admbnda_nd_20190430_shp/", "npl_admbnda_adm1_nd_20190430")
    # convert to Robinson projection (the projection preferred by UN Cartography)
    proj4string(npl1) <- CRS("+proj=longlat +ellps=WGS84") # (requires sp package)
    npl1.robin <- spTransform(npl1, CRS("+proj=robin")) # (requires rgdal package)
    
    npl1.robin$NAME_1 <- paste("Province", paste(npl1.robin$ADM1_EN))
    
    srb.s <- rep(NA, length(npl1.robin$NAME_1))
    names(srb.s) <- npl1.robin$NAME_1
    srb.s[name.c] <- res.proj$R2.jqt[name.c, 2, paste(yr)]
    npl1.robin$SRB <- srb.s[npl1.robin$NAME_1]
    
    # Find the center of each region and label lat and lon of centers
    centroids <- gCentroid(npl1.robin, byid=TRUE)
    # select.names <- is.element(npl1.robin$NAME_1, name.show.result)
    centroidLons <- coordinates(centroids)[, 1]
    centroidLats <- coordinates(centroids)[, 2]
    names(centroidLons) <- names(centroidLats) <- npl1.robin$NAME_1
    
    code.plot <- NULL
    for (j in 1:C.adj) {
      add.code <- npl1.robin$NAME_1[j]
      code.plot <- c(code.plot, add.code)
    }#end of j loop
    
    cutoff.labs <- as.character(cut(cutoff, cutoff, include.lowest = TRUE))[-1]
    cutoff.labs <-
      ifelse(substr(cutoff.labs, 6, 6) == ",",
             paste0(substr(cutoff.labs, 1, 5), "0", substr(cutoff.labs, 6, nchar(cutoff.labs))), cutoff.labs)
    cutoff.labs <-
      ifelse(substr(cutoff.labs, 12, 12) == "]",
             paste0(substr(cutoff.labs, 1, 11), "0", substr(cutoff.labs, 12, nchar(cutoff.labs))), cutoff.labs)
    cutoff.labs <- gsub(",", "; ", cutoff.labs, fixed = TRUE)
    
    
    # colouring the districts with range of colours
    col_no <- as.numeric(cut(npl1.robin$SRB, cutoff, include.lowest = TRUE))
    names(col_no) <- npl1.robin$NAME_1
    col_no[is.na(col_no)] <- length(cutoff)
    npl1.robin$col_no <- col_no
    
    ## plot the map ##
    plot(npl1.robin,border=1,bg=background.color, col = myPalette[npl1.robin$col_no],
         lwd = boundary.lwd, main = paste0("Sex Ratio at Birth Projection (", yr, ")"))#, ylim = c(10^6*2.967999, 10^6*2.968)
    # title(paste0("Sex Ratio at Birth Projection (", yr, ")"), cex.main = 1, outer = TRUE)
    text(centroidLons, centroidLats, labels = code.plot, cex = 1)
    legend(legend = cutoff.labs, bg = "white", box.col = "white",
           fill = myPalette, "bottomleft", cex = 1)
  }#end of if(end > start)
}#end of yr loop
dev.off()


## only projections
plot.yr <- c(2016, 2020, 2035)
print(round(quantile(res.proj$R2.jqt[, 2, paste(plot.yr)], seq(0, 1, length.out = 9), na.rm = TRUE), 4))
start <- 1.05#round(floor(min(res.proj$R2.jqt[, 2, paste(yr)], na.rm = TRUE)*1000)/1000, 3)
end <- 1.11#round(ceiling(max(res.proj$R2.jqt[, 2, paste(yr)], na.rm = TRUE)*1000)/1000, 3)
out.number <- 7
cutoff <- seq(start, end, length.out = out.number)
myPalette <- brewer.pal(out.number-1, "Reds")

cutoff.labs <- as.character(cut(cutoff, cutoff, include.lowest = TRUE))[-1]
cutoff.labs <-
  ifelse(substr(cutoff.labs, 5, 5) == ",",
         paste0(substr(cutoff.labs, 1, 4), "0", substr(cutoff.labs, 5, nchar(cutoff.labs))), cutoff.labs)
cutoff.labs <-
  ifelse(substr(cutoff.labs, 10, 10) == "]",
         paste0(substr(cutoff.labs, 1, 9), "0", substr(cutoff.labs, 10, nchar(cutoff.labs))), cutoff.labs)
cutoff.labs <- gsub(",", "; ", cutoff.labs, fixed = TRUE); cutoff.labs

pdf(file = paste0(fig.dir, "Nepal_province_SRB_proj.pdf"), height = 10)
par(mar = c(0, 0, 2, 0), mfrow = c(3, 1), oma = c(0, 0, 0, 0))
for (yr in plot.yr) {
  print(yr)
  
  # Read in the state-level polygon shapefile (no antarctica)
  npl1 <- readOGR("data/npl_admbnda_nd_20190430_shp/", "npl_admbnda_adm1_nd_20190430")
  # convert to Robinson projection (the projection preferred by UN Cartography)
  proj4string(npl1) <- CRS("+proj=longlat +ellps=WGS84") # (requires sp package)
  npl1.robin <- spTransform(npl1, CRS("+proj=robin")) # (requires rgdal package)
  
  npl1.robin$NAME_1 <- paste("Province", paste(npl1.robin$ADM1_EN))
  
  srb.s <- rep(NA, length(npl1.robin$NAME_1))
  names(srb.s) <- npl1.robin$NAME_1
  srb.s[name.c] <- res.proj$R2.jqt[name.c, 2, paste(yr)]
  npl1.robin$SRB <- srb.s[npl1.robin$NAME_1]
  
  # Find the center of each region and label lat and lon of centers
  centroids <- gCentroid(npl1.robin, byid=TRUE)
  # select.names <- is.element(npl1.robin$NAME_1, name.show.result)
  centroidLons <- coordinates(centroids)[, 1]
  centroidLats <- coordinates(centroids)[, 2]
  names(centroidLons) <- names(centroidLats) <- npl1.robin$NAME_1
  
  code.plot <- NULL
  for (j in 1:C.adj) {
    add.code <- npl1.robin$NAME_1[j]
    code.plot <- c(code.plot, add.code)
  }#end of j loop
  
  
  # colouring the districts with range of colours
  col_no <- as.numeric(cut(npl1.robin$SRB, cutoff, include.lowest = TRUE))
  names(col_no) <- npl1.robin$NAME_1
  col_no[is.na(col_no)] <- length(cutoff)
  npl1.robin$col_no <- col_no
  
  ## plot the map ##
  plot(npl1.robin,border=1,bg=background.color, col = myPalette[npl1.robin$col_no],
       lwd = boundary.lwd, main = paste0("Sex Ratio at Birth Projection (", yr, ")"))#, ylim = c(10^6*2.967999, 10^6*2.968)
  # title(paste0("Sex Ratio at Birth Projection (", yr, ")"), cex.main = 1, outer = TRUE)
  text(centroidLons, centroidLats, labels = code.plot, cex = 1)
  legend(legend = cutoff.labs, bg = "white", box.col = "white",
         fill = myPalette, "bottomleft", cex = 1)
}#end of yr loop
dev.off()

## the end ##


