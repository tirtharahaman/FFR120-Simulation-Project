%% UpdateGraph.m
%
%
function UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents, nFoodTiles)

    latticeLength = size(agentLattice,1);
    maxPopulation = latticeLength^2;
    nMaxIterations = length(nAgents)-1;
    
    agentPlot.YData = nAgents/maxPopulation;
    agentPlot.XData = 0:nMaxIterations;
    
    foodPlot.YData = nFoodTiles/maxPopulation;
    foodPlot.XData = 0:nMaxIterations;
        
end