###############################################################################
# Sex ratio at birth in Vietnam among six subnational regions during 1980–2050, 
# estimation and probabilistic projection using a Bayesian hierarchical time ser##ies model 
# with 2.9 million birth records.
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 4 Aug 2025
# 
# source_BasicSetup.R
# 
# This script sets up the basic stuff for all the rest script in code/ folder.
# 1. assign constants;
# 2. install packages and call libraries;
# 3. prepare for JAGS model.
#
# used for which run: Main.run
#
# this script is called by any other scripts: main.R
#
#
# functions called: null
# 
# input data: aux.data.dir which contains the information for the surveys and countries.
#             database_for_modeling_2021-02-10.csv is the cleaned data.
#
# output data: null
#
###############################################################################
## basic setup ##
aux.data.dir <- "data/input/Auxdata/"

# install.packages("R2jags") # for JAGS
# install.packages("foreign") # read in SPSS data (for DHS)
# install.packages("xlsx") # read in xlsx file
# install.packages("Read.isi") # read in ISI format data (for WFS)
# install.packages("RColorBrewer")
# install.packages("Hmisc")
# install.packages("readstata13")

## call function scritps ##
funcode.dirs <- list.dirs("code/R", full.names = TRUE, recursive = FALSE)
for (code.dir in funcode.dirs) {
  
  funcode.file <- list.files(code.dir)
  
  for (file in funcode.file) {
    script.name <- paste0(code.dir, "/", file)
    print(paste("call code:", script.name))
    source(script.name)
  } # end of file loop
  
} # end of code.dir loop


if.read.xlsx <- FALSE #FALSE # FALSE: if cannot load library(xlsx)
if.read.csv  <- !if.read.xlsx

if (CleanData) {
  ## import survey information ##
  ## read in DHS country code description file to identify country folder ##

  if (if.read.csv) {
    data.DHSCountryInfo <- read.csv(paste0(aux.data.dir, "SurveyInfo_CountryInfo.csv"),
                                    header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)

    data.DHSinfo <- read.csv(paste0(aux.data.dir, "SurveyInfo_DHS.csv"),
                             header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)
  }#end of if(if.read.csv)
}#end of if(CleanData)


## info to save for SRB related data ##
Nsim <- 1000 # number of simulations #FQ!!! do not use N which is para for natural SRB!!!
percentiles <- c(0.025, 0.500, 0.975)
Per <- length(percentiles)
SRB0 <- 1.05

# filter out extreme values # FQ: NEED TO CHANGE THIS VALUE!! (AFTER DATA QUALITY ANALYSIS FINISHED)
extremeSRB <- 5


# Jackknife settings
k.CVcutoff <- k.CVlogcutoff <- 0.05 #FQ20140820 change 0.1
k.MaxTimePeriod <- 10 #after discuss with Patrick; 10 yr is convension for DHS in IGME #10 #5

# retrospective period keep for each full birth history data series
k.RetroPeriod <- 25

# cutoff for under-reported VR data: ratio of number of live birth (VR over WPP)
k.Underreport <- 0.8#0.85 #CFQ: increase from 0.8 to 0.85 in order to exclude Saint Lucia 1956 VR
k.Underreport.relax <- 0.75#0.8 #VR inclusion criteria: relax the cutoff once VR data get included.
# e.g. lower the threshold from 85% to 80%

# import Nepal region info
ecological.zone <- c("Mountain", "Hill", "Terai")
region <- c("Eastern", "Central", "Western", "Midwestern", "Farwestern")
province.c <- paste("Province", 1:7)

domain.c <-
  c(paste(region[1], ecological.zone),
    paste(region[2], ecological.zone),
    paste(region[3], ecological.zone),
    paste(region[4], ecological.zone[-1]),
    paste(region[5], ecological.zone[-1]))

# Mountain Eastern
# 1   Mountain Central
# 2   Mountn Western
# 3   Hill Eastern
# 4   Hill Central
# 5   Hill Western
# 6   Hill Midwestern
# 7   Hill Farwestern
# 8   Terai Eastern
# 9   Terai Central
# 10  Terai Western
# 11  Terai Midwestern
# 12  Terai Farwestern

name.c <- province.c
C <- length(unique(name.c)); C


# time period that will be estimated for all countries/areas
years.fix.t <- c(1950.5 : 2030.5) # for M51_normal onwards


# percentiles to get UI: get 90% CI throughout this project since
# child mortality estimates and related outcomes are quite uncertain.
percentiles <- c(0.025, 0.5, 0.975) 
Per         <- length(percentiles)

# age group for mothers
agefull.a <- c("19 and below",
               "20-24", "25-29",
               "30-34", "35-39",
               "40-44", "45 and above")
Amax <- length(agefull.a)

# parity
parfull.p <- c(as.character(1:9), "10 and above")
Pmax <- length(parfull.p)


## plot setup ##
# plot size in the unit of cm
cm <- 1 / 2.54

# write JAGS model (jags_writeJAGSmodel.R)
NoTermPerLine <- 2 #shorten the length of long summition to seperate lines

plotWhichP <- 30 # trace plot for logP.ct: too many of them, only plot some

## assign input file names ##
srb.filename <- "database_for_modeling_2020-05-11.csv"

## the end ##

