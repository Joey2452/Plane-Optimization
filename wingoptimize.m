
function wingoptimize()
    clear;
    clc;
    % Initial guess for design parameters
    initialGuess = [6, .5,6,.3]; % [ wingspan, chord length, max gtow, Cl]

    lb = [1, .05, 10,.02];
    ub = [6, 1, 15,0.7];

    % Optimization options: may change function tolerance (narrower
    % tolerance forces it to your parameters closer), Pop size (higher
    % population size allows more "guesses" per generation, outputs more
    % solutions closer to obj), and max gen (you want to reach max gen
    % before you hit your tolerances)
    options = optimoptions('gamultiobj', 'Display', 'iter','FunctionTolerance', 1e-4, 'PopulationSize', 100, 'MaxGenerations', 100);
    % Call gamultiobj
    [x_opt, fval] = gamultiobj(@multiObjectiveFunction, 4, [], [], [], [], lb, ub, @constraints, options);
  
    % Display results
    fprintf('\n');
    disp('Optimized Parameters:');
    [nRows, ~] = size(x_opt); % Get number of rows

    % Create an array of solution labels
    SolutionLabels = categorical(strcat('Solution #', string((1:nRows)')));
    
    % Create a table with your data
    T = table(SolutionLabels, x_opt(:,1), x_opt(:,2), x_opt(:,3), x_opt(:,4), ...
        'VariableNames', {'Solution', 'Wingspan', 'Chord Length', 'GTOW', 'Cl'});
    
    disp(T)
    % disp(x_opt); % Optimal wingspan, chord length, gtow, Cl
    save('wingopt_results.mat', 'x_opt', 'fval');
end
