clc;
clear;

% Define the data for Weight (x-axis) and Aspect Ratio (y-axis)
weight = linspace(6, 20, 100); % Weight ranging from 6 to 20 lbs
aspect_ratio = linspace(1, 10, 100); % Aspect Ratio from 1 to 10

% Create a meshgrid for the data
[W, A] = meshgrid(weight, aspect_ratio);

% Define a function for the Weighted Score (example: some arbitrary equation)
weighted_score = log(A * W); % You can use your own function here

% Create a filled contour plot
contourf(W, A, weighted_score, 20); % The number '20' defines the number of contour levels

% Add labels and color bar
xlabel('Weight (lb)');
ylabel('Aspect Ratio');
colorbar;
title('Weighted Score Contour Plot');

print('contour_plot', '-dpng', '-r300')  % Save as PNG with 300 DPI resolution