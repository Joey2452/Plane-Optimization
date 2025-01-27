function [alpha_data, CL_data, CD_data, CDp_data] = loadAirfoilData(filename);
    % Load the data from the CSV
    rawData = readmatrix(filename);
    alpha_data = rawData(:, 1);      % First column is alpha
    CL_data = rawData(:, 2);          % Second column is CL
    CD_data = rawData(:, 3);          % Third column is CD
    CDp_data = rawData(:, 4);         % Fourth column is CDp (optional)
end