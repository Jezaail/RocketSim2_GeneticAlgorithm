%log.txt data retrieval function
function [rocketData] = log_data()
filePath = 'D:\Clemson\Courses\Fall 2024\Engineering Optimization\Full Course Files\Final Exam\RocketSim2\RocketSim2\log.txt'; 


fileContent = fileread(filePath);


rocketsections = regexp(fileContent, 'Rocket Configuration:', 'split');
rocketsections(1) = []; 


rocketData = struct();

for i = 1:length(rocketsections)
    section = rocketsections{i};
    
    config_pattern = 'Rocket Configuration:\s*(.+)\n';
    config_match = regexp(section, config_pattern, 'tokens', 'once');
    if ~isempty(config_match)
        rocketData(i).Configuration = str2num(config_match{1}); %#ok<ST2NM>
    else
        rocketData(i).Configuration = [];
    end
    
    maxQ_pattern = 'Maximum Dynamic Pressure of ([\d.e+-]+) \(Pa\) at time t = ([\d.e+-]+) sec';
    maxQ_Match = regexp(section, maxQ_pattern, 'tokens', 'once');
    if ~isempty(maxQ_Match)
        rocketData(i).maxQ = str2double(maxQ_Match{1});
        rocketData(i).time_maxQ = str2double(maxQ_Match{2});
    else
        rocketData(i).maxQ = NaN;
        rocketData(i).time_maxQ = NaN;
    end
    
    maxA_Pattern = 'Maximum Acceleration of ([\d.e+-]+) \(m/s\^2\) at time t = ([\d.e+-]+) sec';
    maxA_Match = regexp(section, maxA_Pattern, 'tokens', 'once');
    if ~isempty(maxA_Match)
        rocketData(i).max_A = str2double(maxA_Match{1});
        rocketData(i).time_maxA = str2double(maxA_Match{2});
    else
        rocketData(i).maxA = NaN;
        rocketData(i).time_maxA = NaN;
    end
    
    stageV_pattern = 'Stage (\d+) Final Velocity of ([\d.e+-]+) \(m/s\) at time t = ([\d.e+-]+) sec and an Altitude of ([\d.e+-]+) m';
    stageV_matches = regexp(section, stageV_pattern, 'tokens');
    
    if ~isempty(stageV_matches)
        for j = 1:length(stageV_matches)
            stagenum = str2double(stageV_matches{j}{1});
            rocketData(i).Stages(stagenum).final_velocity = str2double(stageV_matches{j}{2});
            rocketData(i).Stages(stagenum).time_finalvelocity = str2double(stageV_matches{j}{3});
            rocketData(i).Stages(stagenum).final_altitude = str2double(stageV_matches{j}{4});
        end
    else
        rocketData(i).Stages = [];
    end
    
    orbit_pattern = 'Orbit Achieved';
    orbit_match = regexp(section, orbit_pattern, 'once');
    if ~isempty(orbit_match)
        rocketData(i).orbit_achieved = true;
    else
        rocketData(i).orbit_achieved = false;
    end
end

end
