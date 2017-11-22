clear all

sideLength = 50; %size of lattice
initialPopulationSize = 50;
initialFoodSupply = 50; 
diffusion = 0.5; %Probability of an agent moving in a given timestep.

[agentLattice,foodLattice,agentProperties] = ...
InitializeLattices(sideLength,initialPopulationSize,initialFoodSupply);

% agentProperties has one row for each property, at the moment these are
% dead/alive, x, y, age, hunger in this order. This can of course be
% changed.