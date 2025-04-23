install.packages("prism")
library(prism)

# Set directory for PRISM data
prism_set_dl_dir("D:/Winter 2025/MIS 5470 PCDA/Final_Project/Pre-Downloaded_Data/US/PRISM_Data")

# Define years and months
years <- 1985:2024
months <- 1:12

# Variables to download
variables <- c("ppt", "tmin", "tmean", "tmax", "tdmean", "vpdmin", "vpdmax")

# Loop through each variable and download monthly data
for (var in variables) {
  get_prism_monthlys(type = var, years = years, mon = months, keepZip = FALSE)
}