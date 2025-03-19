% fitness evaluation function
function [pop_fitness] = fitness_evaluator(finalVelMat, maxAccelerationVec, maxDynamicPressureVec, orbitAchievedVec, finalAltMat, tar_alt)
tar_maxQ = 33440;
tar_A = 49.1;
tar_V = 10400;

pop_fitness = zeros(size(finalVelMat, 1), 1);

for i = 1:size(finalVelMat, 1)
    if orbitAchievedVec == 1
        orbit_val = 10;
    else
        orbit_val = 1;
    end
    pop_fitness(i) = orbit_val * max(finalVelMat(i,:), [], 'omitnan');
    % pop_fitness(i) = 10*(abs(tar_V-max(finalVelMat(i,:)))/tar_V) + ((tar_maxQ - maxDynamicPressureVec(i))/tar_maxQ) + ((tar_A - maxAccelerationVec(i))/tar_A) + (abs(tar_alt-max(finalAltMat(i,:)))/tar_alt) + orbit_val;
end
end