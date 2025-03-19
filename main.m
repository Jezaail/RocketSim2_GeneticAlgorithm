% Main Function
close all;
clear variables
clc

[boost_type, engine_type1, engine_type2, dia_booster, dia_eng1, dia_eng2, prob_booster, prob_eng1, prob_eng2] = txt_import();
tar_alt = input('Target Altitude:');
pay_mass = input('Payload Mass:');
pop_size = 1;
while mod(pop_size/2,2) ~= 0
    pop_size = input('Population Size:');
end
mut_rate = 1;
while mut_rate >= 1
    mut_rate = input('Mutation Rate');
end
population = pop_generator(pop_size, boost_type, engine_type1, engine_type2, dia_eng1, dia_eng2, tar_alt);
gen_lim = input('Generation Limit:');

gen_max_fit = [];
gen_mean_fit = [];

%% Genetic Algorithm
for i = 1:gen_lim
    input_array = [pop_size];
    for j = 1:pop_size
        input_array = [input_array, population(j, 1:15)];
        input_array(j * 16 + j - 1) = tar_alt;
        input_array = [input_array, population(j, 16), pay_mass];
    end
    column_input = input_array(:);

    fid = fopen('D:\Clemson\Courses\Fall 2024\Engineering Optimization\Full Course Files\Final Exam\RocketSim2\RocketSim2\Batch.txt', 'w');
    if fid == -1
        error('Could not open the file for writing');
    end

    for j = 1:length(input_array)
        fprintf(fid, '%f\n', input_array(j));
    end

    fclose(fid);
    exeFilePath = 'D:\Clemson\Courses\Fall 2024\Engineering Optimization\Full Course Files\Final Exam\RocketSim2\RocketSim2\RocketSim2.exe';

    winopen(exeFilePath);

    disp('Executable triggered successfully.');
    pause(15);
    rocketData = log_data();

    num_rockets = length(rocketData);

    maxStages = 0;
    for i = 1:num_rockets
        if isfield(rocketData(i), 'Stages') && ~isempty(rocketData(i).Stages)
            maxStages = max(maxStages, length(rocketData(i).Stages));
        end
    end

    maxAccelerationVec = arrayfun(@(x) x.max_A, rocketData);
    maxDynamicPressureVec = arrayfun(@(x) x.maxQ, rocketData);

    orbitAchievedVec = arrayfun(@(x) double(x.orbit_achieved), rocketData);

    finalVelMat = NaN(num_rockets, maxStages);
    finalAltMat = NaN(num_rockets, maxStages);

    for i = 1:num_rockets
        if isfield(rocketData(i), 'Stages') && ~isempty(rocketData(i).Stages)
            for s = 1:length(rocketData(i).Stages)
                finalVelMat(i, s) = rocketData(i).Stages(s).final_velocity;
                finalAltMat(i, s) = rocketData(i).Stages(s).final_altitude;
            end
        end
    end

    pop_fitness = fitness_evaluator(finalVelMat, maxAccelerationVec, maxDynamicPressureVec, orbitAchievedVec, finalAltMat, tar_alt);

    max_fitness = max(pop_fitness);
    mean_fitness = mean(pop_fitness);
    disp('Max Fitness: ');
    disp(max_fitness);
    disp('Mean Fitness:');
    disp(mean_fitness);
    gen_max_fit = [gen_max_fit, max_fitness];
    gen_mean_fit = [gen_mean_fit, mean_fitness];

    % Reproduction
    [rank_array, NewPopulation, mut_population] = reproduction_function(pop_fitness, population, pop_size, mut_rate, tar_alt, boost_type, engine_type1, engine_type2, dia_eng1, dia_eng2);
    population = NewPopulation;
end

%% Plotting the Maximum and Mean Fitness
figure;
hold on;
plot(1:gen_lim, gen_max_fit, 'r-', 'LineWidth', 2);  
plot(1:gen_lim, gen_mean_fit, 'b-', 'LineWidth', 2); 
xlabel('Generation');
ylabel('Fitness');
title('Change in Max and Mean Fitness Over Generations');
legend('Max Fitness', 'Mean Fitness');
grid on;
hold off;
