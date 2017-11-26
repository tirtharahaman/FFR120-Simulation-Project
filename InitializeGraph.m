%% InitializeGraph.m
%
%
function [agentPlot, foodPlot] = InitializeGraph(agentLattice, nAgents, nFoodTiles)

    latticeLength = size(agentLattice, 1);
    maxPopulation = latticeLength^2;
    horizontalAxis = 0:1;

    agentPlot = plot(horizontalAxis, ones(2,1)*nAgents(1)/maxPopulation, 'Color', [0.05 0.05 0.9]);
    hold on;
    foodPlot = plot(horizontalAxis, ones(2,1)*nFoodTiles(1)/maxPopulation, 'Color', [0.05 0.9 0.05]);
 
    xlabel('Iterations (time)');
    ylabel('Population density');
    legend('Agents', 'Food tiles');
    title('Population graph');
    axis([0 1 0 1]);
end