clc; clf; clear;
% -------------------------------------
% ------ Configurable parameters ------
% -------------------------------------

% --- Grid and starting parameters ---
sideLength = 100; % size of lattice
nTiles = sideLength^2;
initialPopulationSize = 5;
initialFoodSupply = 0.5*nTiles;

% --- Food parameters ---
growProbability = 0.01; % probability that each non-food tile grows food each timestep

% --- Fitness parameters ---
foodConstant = 0.8; % positive factor when agent eats food
hungerConstant = 0.1; % negative factor when agent stays hungry
ageConstant = 0.007; % negative factor of aging = 1/maxAge

% --- Birth & death parameters ---
birthRate = 0.2;
deathRate = 0.2;

% --- Movement parameters ---
diffusion = 0.5; % Probability of an agent moving in a given timestep.
moveToFood = true; % move the agent to the first available food tile in its neighbourhood

% --- Runtime and animation parameters ---
nTimesteps = 1e3;
nExperiments = 3;
timestepsBetweenAnimations = 1; % update graphics after a certain number of updates
animateGrid = 0;
animateGraph = 0;
pauseBetweenAnimations = 0; % time in seconds
showProgress = 1;

% ------------------------------------------
% ------ Initialization and main loop ------
% ------------------------------------------

% --- Initialize global variables across experiments ---
nAgents = zeros(nExperiments,nTimesteps+1); % number of agents alive after each update
nFoodTiles = zeros(nExperiments,nTimesteps+1); % number of food tiles left after each update

for iExperiment = 1:nExperiments

    % --- Initialize local variables ---
    [agentLattice, foodLattice, agentProperties, foodProperties] = ...
    InitializeLattices(sideLength,initialPopulationSize,initialFoodSupply);
    nAgents(iExperiment,1) = sum(agentProperties(:,1)); % initial agents
    nFoodTiles(iExperiment,1) = sum(foodProperties(:,1)); % initial food tile

    clf
    % initialize grid and graph
    gridHandle = subplot(1,2,1);
    [agentGrid, foodGrid] = InitializeGrid(agentLattice, agentProperties, foodProperties);
    graphHandle = subplot(1,2,2);
    [agentPlot, foodPlot] = ...
        InitializeGraph(agentLattice, nAgents(iExperiment,:), nFoodTiles(iExperiment,:));

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

        % --- Grow food ---
        [foodLattice, foodProperties] = ...
            GrowFood(foodLattice, agentLattice, foodProperties, growProbability);

        % --- Check if agents should die ---
        [agentLattice, agentProperties] = CheckForDeaths(deathRate, agentLattice, agentProperties);

        % --- Check if agents should give birth ---
        [agentLattice, agentProperties] = CheckForBirths(birthRate, agentLattice, agentProperties);

        % --- Update graphics ---
        nAgents(iExperiment,iTimestep+1) = sum(agentProperties(:,1));
        nFoodTiles(iExperiment,iTimestep+1) = sum(foodProperties(:,1));
        if rem(iTimestep, timestepsBetweenAnimations) == 0
            if animateGrid
                UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties);
            end
            if animateGraph
                UpdateGraph(agentPlot, foodPlot, agentLattice,...
                    nAgents(iExperiment,:), nFoodTiles(iExperiment,:));
                axis([0 iTimestep 0 1]); % the x-axis changes with time
            end
            drawnow;
            pause(pauseBetweenAnimations)
        end
    %     nAgents(iExperiment,iTimestep+1)
        if nAgents(iExperiment,iTimestep+1) == 0
            clc;
            disp('The number of alive agents reached zero. Simulation terminated.');
            break
        end
        % --- progress ---
        if rem(100*iTimestep,nTimesteps) == 0 && showProgress == 1
            clc;
            experimentProgress = strcat('(',num2str(iExperiment),'/',num2str(nExperiments),')');
            disp(['Progress: ',num2str((100*iTimestep./nTimesteps)),' % ',experimentProgress])
        end
    end

end

% ---------------------------------
% ------ Plot final graphics ------
% ---------------------------------

% --- Plot graphics of the last experiment ---
UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties);
UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents(iExperiment,:), nFoodTiles(iExperiment,:));
axis([0 iTimestep 0 1.3]);
drawnow;

% --- Calculate and plot moving average of all experiments ---
movingAverageAgents = cumsum(nAgents,2) / nTiles;
timeAxis = 1:nTimesteps;
movingAverageAgents(:,2:end) = movingAverageAgents(:,2:end) ./ timeAxis;

delete(gridHandle)
subplot(1,2,1)
hold on;
for iExperiment = 1:nExperiments
    plot(0:nTimesteps,movingAverageAgents(iExperiment,:));
end
xlabel('Timesteps');
ylabel('Moving average of agent density');
title('Moving average');