# Sensor Position Estimation and Optimal Estimate

## Overview
This MATLAB script simulates the observation of position data from two sensors, each with different random error characteristics. The goal of the script is to demonstrate how to estimate the position based on sensor readings, calculate the standard deviation of errors, and combine the estimates from both sensors to create an optimal position estimate. The script also calculates the minimum error and variance for the optimal estimate.

## Key Features
1. **Generate Data**: Simulates sensor readings with different random errors and zero deterministic errors.
2. **Best Estimate Calculation**: Computes the best estimate of the position from the observed data.
3. **Recursive Estimation**: Uses a recursive formula to compute the estimated position over time for each sensor.
4. **Optimal Estimate**: Combines the two sensor estimates using weighted averaging based on their standard deviations.
5. **Error and Variance Calculation**: Calculates the standard deviation, minimum error, and variance for the optimal estimate.

## Inputs
The script uses the following parameters, which are predefined in the script:
- `num_samples`: Number of samples for simulation (1000).
- `mean_actual`: The actual mean position value (set to 10).
- `std_actual`: Standard deviation of actual values (set to 0 for stationary data).
- `std_random1`: Standard deviation of random error for sensor 1 (set to 1).
- `std_random2`: Standard deviation of random error for sensor 2 (set to 5).

## Outputs
The code generates the following output for demonstration:

- **First 10 Samples** of observed values for both sensors.
- **Best Estimate of Position** for both sensors.
- **Estimated Positions** for both sensors over all samples.
- **Optimal Position Estimate** combining both sensors.
- **Minimum Error** and **Variance** of the optimal estimate.

## Explanation of Calculations

- **Best Estimate**: The best estimate of the position is simply the mean of the observed values adjusted for deterministic errors (which are zero in this case).
  
- **Recursive Position Estimation**: The estimated position is updated recursively using a weighted formula:

  Estimated Position_n = ((n-1)/n) * Estimated Position_(n-1) + (Observed Value_n / n)

- **Weighting Factors**: The weighting factors are based on the standard deviations of the random errors for each sensor. These weights determine the influence of each sensor on the optimal estimate:

  Weight_1 = (sigma2^2) / (sigma1^2 + sigma2^2) Weight_2 = (sigma1^2) / (sigma1^2 + sigma2^2)

- **Optimal Estimate**: The optimal estimate is computed by combining the weighted estimates from both sensors:

  Optimal Estimate_n = Weight_1 * Estimated Position_1 + Weight_2 * Estimated Position_2
  
- **Error and Variance**: The minimum error is calculated as a weighted sum of the individual errors from both sensors, and the variance of the optimal estimate is calculated as:

  Minimum Error = Weight_1 * Std Deviation Error 1 + Weight_2 * Std Deviation Error 2
- **Variance**: The variance of the optimal estimate is calculated as:

  Variance = (sigma1^2 * sigma2^2) / (sigma1^2 + sigma2^2)

## Example Output
The script will print the following for the first 10 samples, the 1000th sample, and additional information:
- Actual and observed values for both sensors.
- The best estimate of position for both sensors.
- The estimated positions for both sensors.
- The optimal position estimate using both sensors.
- The minimum error and variance of the optimal estimate.
