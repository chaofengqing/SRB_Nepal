

## Master code file ##
## This run is to get normal level of SRB only!!!

rm(list = objects())

projname <- "SRB_Nepal" # name for this project
runname  <- "M1" # name for this run/model; based on M6c_new_full_reg
glb.normal.runname <- "M57_normal"
glb.adj.runname <- "M58_adj_test"

First.run <- FALSE # construct mcmcarray and output?
CleanData <- FALSE # only do once to avoid problems with sorting differences
DoMCMC    <- FALSE  # get step-wise JAGS output?

OneCountry.run <- grepl("_one", runname) # whether this is a one-country run

workdir <- "/Users/chaof/Dropbox/work/"
workdir <- "/Users/fengqingchao/Dropbox/work/"
setwd(file.path(workdir, projname))

# setup directories
source("code/source_DirectorySetup.R")

# setup constants, functions, libraries
source("code/source_BasicSetup.R")

# read in cleaned SRB database
dataset <- read.csv(paste0(interim.dir, srb.filename),
                    header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE)
Inclusion <- dataset$Inclusion
dataset <- dataset[Inclusion, ]

## When modle is to get normal SRB, use ALL data from non-Aisian, and 
## data with reference date BEFORE 1970 for Asian countries.
adj.year <- 1970.5 # no adjustment before 1970

source(paste0("code/", runname, "/source_DataSetup.R"))
## data for adjustment factor ##
source(paste0("code/", runname, "/source_adj_DataSetup.R"))
## data related to TFR ##
source(paste0("code/", runname, "/source_ADJ&TFR-relation.R"))
# setup MCMC settings
source(paste0("code/", runname, "/jags_setupMCMC.R"))


## PART 1 - construct MCMC array (primary results) ##
## step 1: read in MCMC step-chains and get MCMC array as a whole
mcmc.array <- ReadJagsOutput(
  n.steps = N.STEPS,
  start.step = 1,
  maxiter = 20000,
  ChainNums = ChainIDs,
  runname = runname, output.dir = output.dir
)
save(mcmc.array, file = paste0(output.dir, "mcmc.array_", runname, ".rda"))

load(paste0(output.dir, "mcmc.array_", runname, ".rda")) #mcmc.array
L <- dim(mcmc.array)[1] * dim(mcmc.array)[2]; L

## convergence check ##
# convergeplot.dir <- paste0(fig.dir, "convergence/pre/")
# dir.create(convergeplot.dir, showWarnings = FALSE)
source(paste0("code/", runname, "/jags_ConvergenceCheck.R"))

## reconstruct all logP.ct's ##
source(paste0("code/", runname, "/construct_logPselect.R"))
## reconstruct all alpha.ct's ##
## directly from model
source(paste0("code/", runname, "/construct_ADJselect.R"))
# get country names with past/ongoing SRB inflation
source(paste0("code/", runname, "/construct_CountryList_PastInflation.R"))
# load(file = paste0(output.dir, "country.list.past.inflation.rda")) #country.list.past.inflation
country.list.remove.adj <- setdiff(name.c, country.list.past.inflation)
## get country-specific R, P first!
source(paste0("code/", runname, "/construct_countryCIs.R"))

save(selectP, file = paste0(output.dir, "selectP_", runname, ".rda"))
save(selectADJ, file = paste0(output.dir, "selectADJ_", runname, ".rda"))
save(res.proj, file = paste0(output.dir, "cis_", runname, "_senario_proj.rda"))
save(res.trajS2, file = paste0(output.dir, "traj_", runname, "_R2.jtl.rda"))

load(file = paste0(output.dir, "selectP_", runname, ".rda")) #selectP
load(file = paste0(output.dir, "selectADJ_", runname, ".rda")) #selectADJ
load(file = paste0(output.dir, "cis_", runname, "_senario_proj.rda")) #res.proj

source(paste0("code/", runname, "/plot_countrySRB&TFR.R"))
source(paste0("code/", runname, "/plot_countryCIandData(NOimpute).R"))
source(paste0("code/", runname, "/plot_lineseg_SRB_allstates.R"))
source(paste0("code/", runname, "/plot_SRB_map_province.R"))

## get simulated SRB inflation for each of the 33 countries ##
source(paste0("code/", runname, "/construct_onecountry_ADJ_simulation.R"))
source(paste0("code/", runname, "/construct_ErrorRelativeErrorCoverage_TestingSet.R"))

## sensitivity analysis
source(paste0("code/", runname, "/source_sensitivityanalysis_cv.R"))
source(paste0("code/", runname, "/source_sensitivityanalysis_t_dist_df.R"))
source(paste0("code/", runname, "/source_sensitivityanalysis_Phi.R"))

## save SRB results in csv files
source(paste0("code/", runname, "/construct_ResultsExcel.R"))

## The End! ##
