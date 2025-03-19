Overview
This project implements a Genetic Algorithm (GA) for optimizing rocket designs, specifically focusing on selecting the best combination of booster types, engine configurations, and other design parameters to achieve a target altitude. The algorithm aims to evolve a population of rocket designs across multiple generations, improving the design based on fitness evaluations that consider various physical parameters (such as velocity, acceleration, pressure, and altitude).

Key Features:
Genetic Algorithm: Uses selection, crossover, and mutation to evolve a population of rocket designs.
Fitness Evaluation: The fitness of each rocket design is calculated based on its performance in terms of max velocity, acceleration, dynamic pressure, altitude, and orbit achievement.
Simulation Integration: The genetic algorithm integrates with external rocket simulation software to evaluate rocket performance.
Performance Tracking: Tracks the maximum and average fitness values of the population across generations to monitor the optimization progress.
Project Structure
The project is composed of multiple MATLAB scripts and functions that together form the optimization process. The key components are:

Main Function (main.m): The entry point for the algorithm. It initializes the population, runs the simulation, and updates the population over generations.
Population Generation (pop_generator.m): Creates the initial population of rocket designs with random configurations of boosters, engines, and other design parameters.
Fitness Evaluation (fitness_evaluator.m): Calculates the fitness of each rocket design based on its performance in the simulation.
Reproduction (reproduction_function.m): Handles the crossover and mutation of the population to generate new offspring for the next generation.
Simulation Integration: The RocketSim2.exe simulation is triggered to evaluate the performance of the rocket designs in the environment defined by the user.
How It Works
Initialization:

The population of rockets is generated with random design configurations, including the number and type of boosters, engines, and engine diameters.
A target altitude and payload mass are specified by the user.
Simulation:

For each generation, the algorithm generates input data for the rocket simulation (RocketSim2.exe), which simulates the rocket's flight and performance.
The resulting data from the simulation (such as final velocity, max acceleration, dynamic pressure, and achieved orbit) is logged.
Fitness Evaluation:

The fitness of each rocket design is evaluated based on the simulation results. The fitness function takes into account the following metrics:
Final velocity compared to the target velocity.
Max acceleration compared to a target value.
Max dynamic pressure compared to a target value.
Achieved orbit (whether the rocket reaches the target orbit).
Final altitude compared to the target altitude.
Evolution:

After evaluating the fitness, the algorithm performs selection (choosing the top half of the population based on fitness) and applies crossover (to mix designs of the best individuals) and mutation (to introduce random variations).
The process repeats for a specified number of generations, with the population evolving towards more optimal designs.
Tracking:

The maximum and mean fitness values are tracked across generations to monitor the optimization progress. This data is plotted to visualize the improvement in the population's fitness.
How to Run
Requirements:

MATLAB (R2018b or later recommended).
The external rocket simulation software (RocketSim2.exe) and its dependencies must be correctly installed and accessible from MATLAB.
Setup:

Download or clone this repository to your local machine.
Ensure that the RocketSim2.exe file and other necessary data files (e.g., RocketData.txt) are available and correctly referenced in the code.
Running the Algorithm:

Open the main.m file in MATLAB.
Run the script by typing main in the command window.
Follow the prompts to input the target altitude, payload mass, population size, mutation rate, and generation limit.
The algorithm will run for the specified number of generations, generating rockets, simulating them, and evolving the population.
Visualization:

After the algorithm completes, a plot of the maximum and mean fitness over generations will be displayed.
Example Output
The output includes a plot showing the change in max fitness and mean fitness over each generation. This helps visualize how the population of rocket designs evolves and improves with each generation.

Files in the Repository
main.m: The main script to run the genetic algorithm.
fitness_evaluator.m: Evaluates the fitness of rocket designs.
pop_generator.m: Generates the initial population of rocket designs.
reproduction_function.m: Handles the reproduction process (selection, crossover, mutation).
RocketSim2.exe: The external rocket simulation software that evaluates each rocket's performance.
RocketData.txt: A file containing the data for available boosters, engines, and other parameters used to generate the population.
