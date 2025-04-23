# Install/Load required packages
#install.packages(c("terra", "dplyr", "stringr"))
library(terra)
library(dplyr)
library(stringr)

install.packages("USAboundariesData", repos = "https://ropensci.r-universe.dev", type = "source")
library(USAboundaries)

prism_dir <- "D:/Winter 2025/MIS 5470 PCDA/Final_Project/Pre-Downloaded_Data/US/PRISM_Data"
setwd(prism_dir)

# Recursively list all .bil raster files
bil_files <- list.files(pattern = "\\.bil$", full.names = TRUE, recursive = TRUE)

# Load U.S. state boundaries and convert to terra format
states_sf <- us_states(resolution = "high")
states_vect <- vect(states_sf)  # convert sf SpatVector

# Initialize final results container
final_output <- data.frame()

# Loop through each .bil raster file
for (file in bil_files) {
  try({
    # Load raster
    r <- rast(file)
    
    # Reproject state polygons to match raster CRS
    states_proj <- project(states_vect, crs(r))
    
    # Parse file name: PRISM_<var>_stable_4kmM3_<yyyymm>_bil.bil
    fname <- basename(file)
    parts <- str_split(fname, "_", simplify = TRUE)
    
    variable <- parts[2]
    year <- substr(parts[5], 1, 4)
    month <- substr(parts[5], 5, 6)
    
    # Extract mean value for each state
    extracted <- extract(r, states_proj, fun = mean, na.rm = TRUE, ID = TRUE)
    
    # Add metadata columns
    extracted$state <- states_sf$name
    extracted$year <- year
    extracted$month <- month
    extracted$variable <- variable
    colnames(extracted)[2] <- "mean_value"
    
    # Keep relevant columns only
    output <- extracted[, c("state", "year", "month", "variable", "mean_value")]
    final_output <- bind_rows(final_output, output)
    
    cat("Processed:", fname, "\n")
  }, silent = TRUE)
}

# Save to CSV
write.csv(final_output, "PRISM_Climate_By_State1.csv", row.names = FALSE)
cat(" Done! Output saved to PRISM_Climate_By_State1.csv\n")
