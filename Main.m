clc; clf; clear;
% -------------------------------------
% ------ Configurable parameters ------
% -------------------------------------

% --- Grid and starting parameters ---
sideLength = 100; % size of lattice
initialPopulationSize = 50;
initialFoodSupply = 5000;

% --- Fitness parameters ---
foodConstant = 0.5; % positive factor when agent eats food
hungerConstant = 0.1; % negative factor when agent stays hungry
ageConstant = 0.007; % negative factor of aging = 1/maxAge

% --- Birth & death parameters ---
birthRate = 1;
deathRate = 0.1;

% --- Movement parameters ---
diffusion = 0.5; % Probability of an agent moving in a given timestep.
moveToFood = true; % move the agent to the first available food tile in its neighbourhood

% --- Runtime and animation parameters ---
nTimesteps = 1e3;
timestepsBetweenAnimations = 1; % update graphics after a certain number of updates
animateGrid = 1;
animateGraph = 1;
pauseBetweenAnimations = 0; % time in seconds

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
      MoveAgents(agentLattice, foodLattice, agentProperties, diffusion, moveToFood);

    % --- Update agent and food properties ---
    [agentProperties, foodLattice, foodProperties] = ...
      UpdateAgentAndFoodProperties(agentProperties, foodLattice, foodProperties, ...
                                    foodConstant, hungerConstant, ageConstant);

    % --- Check if agents should die ---
    [agentLattice, agentProperties] = CheckForDeaths(deathRate, agentLattice, agentProperties);

    % --- Check if agents should give birth ---
    [agentLattice, agentProperties] = CheckForBirths(birthRate, agentLattice, agentProperties);
    
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
        pause(pauseBetweenAnimations)
    end
    if nAgents(iTimestep+1) == 0
        break
    end
end

% --- Plot final graphics ---
UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties);
UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents, nFoodTiles);
axis([0 iTimestep 0 1.3]);
drawnow;