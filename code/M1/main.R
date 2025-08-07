# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 7 Aug 2025
# main.R
# 
# This script is the master file to get MCMC array for Main.run. Run this
# script to get reulsts.
#
# used for which run: main.run
#
# this script is called by any other scripts: null
#
# this script calls other scripts:
# 1. source_BasicSetup.R
# 2. source_DirectorySetup.R
# 3. source_DataSetup.R - is only called once and is in this script.
# 4. source_adj_DataSetup.R
# 5. source_ADJ&TFR_relation.R
# 6. jags_setupMCMC.R
# 7. jags_getMCMC.R
#
# functions called: Null
# 
#
# output data in folder data/:
# 1. interim/database_for_modeling_2020-05-11.csv - the SR database for modelling
# 2. output/M1/temp.JAGSobjects/  - stepwise JAGS trajectory output
# Note: only the main output data are listed here since it is a master script.
#
###############################################################################

## Master code file ##
## This run is to get normal level of SRB only!!!

rm(list = objects())

projname <- "SRB_Nepal" # name for this project
runname  <- "M1" # name for this run/model; based on M6c_new_full_reg
glb.normal.runname <- "M57_normal"
glb.adj.runname <- "M58_adj_test"

First.run <- TRUE # construct mcmcarray and output?
CleanData <- FALSE # only do once to avoid problems with sorting differences
DoMCMC    <- TRUE  # get step-wise JAGS output?

OneCountry.run <- grepl("_one", runname) # whether this is a one-country run

workdir <- "Your own dictionary"
setwd(file.path(workdir, projname))

# setup directories
source("code/source_DirectorySetup.R")

# setup constants, functions, libraries
source("code/source_BasicSetup.R")

# read in cleaned SRB database
dataset <- read.csv(paste0(interim.dir, srb.filename),
                    header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)
Inclusion <- dataset$Inclusion
table(Inclusion)
dataset <- dataset[Inclusion, ]
dim(dataset) #92 28


## When modle is to get normal SRB, use ALL data from non-Aisian, and 
## data with reference date BEFORE 1970 for Asian countries.
adj.year <- 1970.5 # no adjustment before 1970

source(paste0("code/", runname, "/source_DataSetup.R"))
## data for adjustment factor ##
source(paste0("code/", runname, "/source_adj_DataSetup.R"))
## data related to TFR ##
source(paste0("code/", runname, "/source_ADJ&TFR_relation.R"))
# setup MCMC settings
source(paste0("code/", runname, "/jags_setupMCMC.R"))

## STOP HERE FOR JAGS ##
if (DoMCMC) {
  source(paste0("code/", runname, "/jags_getMCMC.R"))
}

## The End! ##
