# Michigan Climate Trends Forecasting Project

This project explores and forecasts long-term climate trends in Michigan using water usage data from USGS and climate data from PRISM (1985–2024).

## Project Structure

- `Water_Use_Data_Extraction.Rmd` – Extract and clean USGS Water Use Data
- `Extract_Prism_Data.R` – Download PRISM .bil files via API
- `Prism_Data_Combine.R` – Extract state-level values and compile into a dataset
- `FinalData_Extraction.Rmd` – Merge water use and climate data
- `Water_Use_EDA.Rmd` – Exploratory analysis of water usage
- `PRISM_Climate_Exploration_1985_2024.Rmd` – Climate EDA by state, region, and season
- `Michigan Climate Forecast.ipynb` – Forecasting using Prophet and LSTM

> Note: Due to size limits, PRISM `.bil` files (~12GB) are not included in the repo. The extraction code is provided.

## Forecasting Models

- **Prophet**: Baseline model for seasonal trends
- **LSTM (Keras)**: Deep learning model with 36-month forecasts and backtest RMSE
- Includes comparison to **seasonal naive baseline**

## Key Insights

- Clear seasonality and warming trends in fall/summer
- LSTM outperformed Prophet and seasonal naive baselines across all variables

## Deliverables

- Clean `.csv` files
- Forecast plots
- Knitted HTMLs from R
- Final screencast (shared separately)

## Author

**Uttara Bammireddy**  
MS in Business Analytics, Oakland University  
Winter 2025 – MIS 5470
