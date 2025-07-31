

InternalStandardizeNepalDevRegName <- function(name.in) {
  
  ## Shorten India state names (and make consistent) ##
  name.in <- ifelse(name.in == "East", "Eastern", paste(name.in))
  name.in <- ifelse(name.in == "West", "Western", paste(name.in))
  name.in <- ifelse(name.in == "Far-western" | name.in == "Far-Western", "Farwestern", paste(name.in))
  name.in <- ifelse(name.in == "Mid-western" | name.in == "Mid-Western", "Midwestern", paste(name.in))
  
  name.out <- name.in
  return(name.out)
}#end of InternalStandardizeNepalDevRegName function
