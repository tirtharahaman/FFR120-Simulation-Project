%% UpdateGraph.m
%
%
function UpdateGraph(agentPlot, foodPlot, agentLattice, nAgents, nFoodTiles)

    latticeLength = size(agentLattice,1);
    maxPopulation = latticeLength^2;
    nMaxTimesteps = length(nAgents)-1;
    
    agentPlot.YData = nAgents/maxPopulation;
    agentPlot.XData = 0:nMaxTimesteps;
    
    foodPlot.YData = nFoodTiles/maxPopulation;
    foodPlot.XData = 0:nMaxTimesteps;
        
end