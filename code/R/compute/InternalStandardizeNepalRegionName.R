

InternalStandardizeNepalRegionName <- function(name.in) {
  
  ## Shorten India state names (and make consistent) ##
  name.in <- ifelse(name.in == "Central hill" | name.in == "Hill Central", "Central Hill", paste(name.in))
  name.in <- ifelse(name.in == "Central mountain" | name.in == "Mountain Central", "Central Mountain", paste(name.in))
  name.in <- ifelse(name.in == "Central terai" | name.in == "Terai Central", "Central Terai", paste(name.in))
  
  name.in <- ifelse(name.in == "Eastern hill" | name.in == "Hill Eastern", "Eastern Hill", paste(name.in))
  name.in <- ifelse(name.in == "Eastern mountain" | name.in == "Mountain Eastern", "Eastern Mountain", paste(name.in))
  name.in <- ifelse(name.in == "Eastern terai" | name.in == "Terai Eastern", "Eastern Terai", paste(name.in))
  
  name.in <- ifelse(name.in == "Western hill" | name.in == "Hill Western", "Western Hill", paste(name.in))
  name.in <- ifelse(name.in == "Western mountain" | name.in == "Mountain Western" |
                      name.in == "Mountn Western", "Western Mountain", paste(name.in))
  name.in <- ifelse(name.in == "Western terai" | name.in == "Terai Western", "Western Terai", paste(name.in))
  
  name.in <- ifelse(name.in == "Far-western hill" | name.in == "Far-western Hill" |
                      name.in == "Hill Farwestern", "Farwestern Hill", paste(name.in))
  name.in <- ifelse(name.in == "Far-western terai" | name.in == "Far-western Terai" |
                      name.in == "Terai Farwestern", "Farwestern Terai", paste(name.in))
  
  name.in <- ifelse(name.in == "Mid-western hill" | name.in == "Mid-western Hill" |
                      name.in == "Hill Midwestern", "Midwestern Hill", paste(name.in))
  name.in <- ifelse(name.in == "Mid-western terai" | name.in == "Mid-western Terai" |
                      name.in == "Terai Midwestern", "Midwestern Terai", paste(name.in))
  
  name.out <- name.in
  return(name.out)
}#end of InternalStandardizeNepalRegionName function
