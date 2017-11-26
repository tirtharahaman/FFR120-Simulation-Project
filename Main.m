clc; clf; clear;

% --- Configurable parameters ---
sideLength = 100; %size of lattice
initialPopulationSize = 50;
initialFoodSupply = 500;
diffusion = 0.5; %Probability of an agent moving in a given timestep.
nTimesteps = 1e3;
timestepsBetweenAnimations = 1; % update graphics after a certain number of updates
animateGrid = true;
animateGraph = true;

% --- Initialize global variables ---
[agentLattice, foodLattice, agentProperties, foodProperties] = ...
    InitializeLattices(sideLength,initialPopulationSize,initialFoodSupply);
nAgents = zeros(1,nTimesteps+1); % number of agents alive after each update
nFoodTiles = zeros(1,nTimesteps+1); % number of food tiles left after each update
nAgents(1) = sum(agentProperties(:,1)); % initial agents
nFoodTiles(1) = sum(foodProperties(:,1)); % initial food tile
% initialize grid and graph
subplot(1,2,1);
[agentGrid, foodGrid] = InitializeGrid(agentLattice, agentProperties, foodProperties);
subplot(1,2,2);
[agentPlot, foodPlot] = InitializeGraph(agentLattice, nAgents, nFoodTiles);

% agentProperties has one row for each property, at the moment these are
% dead/alive, x, y, age, hunger in this order. This can of course be
% changed.
% foodProperties has one row for each property, at the moment these are
% dead/alive, x, y in this order. This can of course be
% changed.

for iTimestep = 1:nTimesteps
    
    % --- Move agents ---
    [agentLattice, agentProperties] = ...
        MoveAgents(agentLattice, foodLattice, agentProperties, diffusion);
    
    % --- Update graphics ---
    nAgents(iTimestep+1) = sum(agentProperties(:,1));
    nFoodTiles(iTimestep+1) = sum(foodProperties(:,1));
    if rem(iTimestep, timestepsBetweenAnimations) == 0
        if animateGrid
            UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties);
        end
        if animateGraph
            UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents, nFoodTiles);
            axis([0 iTimestep 0 1]); % the x-axis changes with time
        end
        drawnow;
    end
end

% --- Plot final graphics ---
UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties);
UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents, nFoodTiles);
axis([0 iTimestep 0 1.3]);
drawnow;