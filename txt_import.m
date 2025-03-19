% RocketData.txt data import function
function [booster_type, engine_type1, engine_type2, dia_booster, dia_eng1, dia_eng2, prob_booster, prob_eng1, prob_eng2] = txt_import()
    % Read data from the text file
    rocketdata = readmatrix('D:\Clemson\Courses\Fall 2024\Engineering Optimization\Full Course Files\Final Exam\RocketSim2\RocketSim2\RocketData.txt');
    
    % Existing outputs
    booster_type = rocketdata(1:32, 1);
    engine_type1 = rocketdata(33:78, 1);
    engine_type2 = rocketdata(79:end, 1);
    dia_booster = rocketdata(1:32, 8);
    dia_eng1 = rocketdata(33:78, 8);
    dia_eng2 = rocketdata(79:end, 8);

    % Read 'All Engine Types' sheet
    engineData = readtable('D:\Clemson\Courses\Fall 2024\Engineering Optimization\Full Course Files\Final Exam\RocketSim2\RocketSim2\ME8710-RocketsFinal.xlsx', 'Sheet', 'All Engine Types');
    
    % Find the exact column name for "Probability of Failure"
    columnNames = engineData.Properties.VariableNames;
    probFailureColName = columnNames{contains(columnNames, 'Probability')};

    % Extract the probability of failure data using the correct column name
    prob_failure = engineData{:, probFailureColName};

    % Categorize the probabilities to match engine categories
    prob_booster = prob_failure(1:32)
    prob_eng1 = prob_failure(33:78)
    prob_eng2 = prob_failure(79:end)
end