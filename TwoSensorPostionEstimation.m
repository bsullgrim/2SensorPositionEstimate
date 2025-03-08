clc
clear all
% Set parameters
num_samples = 1000;  % Number of samples
mean_actual = 10;    % Mean of actual values (stationary)
std_actual = 0;      % Standard deviation of actual values (stationary)
std_random1 = 1;      % Standard deviation of random errors for sensor 1
std_random2 =5;         % Standard deviation of random errors for sensor 2


% Set random seed for reproducibility
rng(41);

% Generate constant actual value (stationary)
actual_value = mean_actual;

% Generate random errors
random_errors1 = std_random1 * rand(num_samples, 1);
random_errors2 = std_random2 * rand(num_samples, 1);

% Deterministic error is set to zero
deterministic_errors1 = zeros(num_samples, 1);
deterministic_errors2 = zeros(num_samples, 1);

% Simulate observed values
observed_values1 = actual_value + deterministic_errors1 + random_errors1;
observed_values2 = actual_value + deterministic_errors2 + random_errors2;

% Calculate best estimate of position
best_estimate1 = mean(observed_values1-deterministic_errors1);
best_estimate2 = mean(observed_values2-deterministic_errors2);

 % Calculate the standard deviation of the error
std_deviation_err1 = best_estimate1 - actual_value;
std_deviation_err2 = best_estimate2 - actual_value;

%Calculate the standard deviation
sigma1 = std_deviation_err1/sqrt(num_samples);
sigma2 = std_deviation_err2/sqrt(num_samples);

% Display the first 10 samples for demonstration
for i = 1:10
    fprintf('Sensor 1 Actual: %.4f, Observed: %.4f\n', actual_value, observed_values1(i));
end
 fprintf('\n')

% Display the first 10 samples for demonstration
for i = 1:10
    fprintf('Sensor 2 Actual: %.4f, Observed: %.4f\n', actual_value, observed_values2(i));
end
 fprintf('\n')
 % Display the best estimate
fprintf('Best Estimate of Position: %.4f\n', best_estimate1);
fprintf('Best Estimate of Position: %.4f\n', best_estimate2);
 fprintf('\n')

% Initialize variables
estimated_positions1 = zeros(num_samples, 1);
estimated_positions2 = zeros(num_samples, 1);
estimated_positions1(1) = observed_values1(1);  % Initial estimate is the first observation
estimated_positions2(1) = observed_values2(1);  % Initial estimate is the first observation

% Calculate estimated positions recursively
for n = 2:num_samples
    estimated_positions1(n) = ((n-1)/n)*estimated_positions1(n-1) + (observed_values1(n) / n);
    estimated_positions2(n) = ((n-1)/n)*estimated_positions2(n-1) + (observed_values2(n) / n);
end

% Display the first 10 estimated positions for demonstration
for i = 1:10
    fprintf('Sensor 1 Estimated Position at Sample %d: %.4f\n', i, estimated_positions1(i));
end
    fprintf('Sensor 1 Estimated Position at Sample 1000: %.4f\n', estimated_positions1(1000));
fprintf('\n')

for i = 1:10
    fprintf('Sensor 2 Estimated Position at Sample %d: %.4f\n', i, estimated_positions2(i));
end
    fprintf('Sensor 2 Estimated Position at Sample 1000: %.4f\n', estimated_positions2(1000));
 fprintf('\n')

% Display the standard deviation of the error
fprintf('Standard Deviation of the Random Error Sensor 1: %.4f\nStandard Deviation of the Random Error Sensor 2: %.4f\n', std_deviation_err1, std_deviation_err2);

% Display the best estimate
fprintf('Standard Deviation Sensor 1: %.4f\nStandard Deviation Sensor 2: %.4f\n', sigma1, sigma2);
fprintf('\n')

% Calculate the Weighting Factors
Dn = sigma1^2+sigma2^2;
weight1 = (sigma2^2)/Dn;
weight2 = (sigma1^2)/Dn;

% Calculate the Optimal Estimate from both sensors
optimal_estimate = zeros(num_samples, 1);
for n = 1:num_samples
    optimal_estimate(n) = weight1*estimated_positions1(n) + weight2*estimated_positions2(n);

end

% Display the first 10 estimated positions for demonstration
for i = 1:10
    fprintf('Optimal Position Estimate at Sample %d: %.4f\n', i, optimal_estimate(i));
end
    fprintf('Optimal Position Estimate at Sample 1000: %.4f\n', optimal_estimate(1000));
fprintf('\n')
%Calculate the Minimum Error
minimum_error = weight1*std_deviation_err1 + weight2*std_deviation_err2;
fprintf('Mimimum Error: %.4f\n', minimum_error);
fprintf('\n')
% Calculate the Variance
Variance = (sigma1^2) * (sigma2^2) / Dn; 
fprintf('Variance: %.4f\n', Variance);

