###############################################################################
# Estimation and probabilistic projection of levels and trends 
# in the sex ratio at birth in seven provinces of Nepal
# from 1980 to 2050: a Bayesian modeling approach
#
# Code constructed by: Fengqing CHAO
# Code last revised by: Qiqi Qiang on 8 Aug 2025
# 
# InternalStandardizeNepalDevRegName.R
# 
# This script contains all functions related to standardizing Nepal's region name.
# Functions are: function1(.., function2(3), ..); means function2 is called
# three times inside function1.
# InternalStandardizeNepalDevRegName(..)
###############################################################################
#------------------------------------------------------------------------------

InternalStandardizeNepalDevRegName <- function(name.in) {
  
  ## Shorten India state names (and make consistent) ##
  name.in <- ifelse(name.in == "East", "Eastern", paste(name.in))
  name.in <- ifelse(name.in == "West", "Western", paste(name.in))
  name.in <- ifelse(name.in == "Far-western" | name.in == "Far-Western", "Farwestern", paste(name.in))
  name.in <- ifelse(name.in == "Mid-western" | name.in == "Mid-Western", "Midwestern", paste(name.in))
  
  name.out <- name.in
  return(name.out)
} # end of InternalStandardizeNepalDevRegName function
