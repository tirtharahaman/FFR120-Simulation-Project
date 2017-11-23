%% PlotPopulationGrid.m
%
%
function [agentGrid, foodGrid] = ...
    InitializeGrid(agentLattice,agentProperties,foodProperties)

    latticeLength = size(agentLattice,1);
    populationFigure = figure(1);
    offset = (latticeLength-1)*0.6*1e-2;
    set(populationFigure,'DoubleBuffer','on');
    axis([1-offset latticeLength+offset 1-offset latticeLength+offset])
    box on
    set(gca,'XTick',[],'YTick',[])
    hold on
    
    xAgents = agentProperties(:,2);
    yAgents = agentProperties(:,3);
    agentGrid = scatter(xAgents,yAgents,10);
    agentGrid.MarkerEdgeColor = [0.05 0.05 0.9];
    agentGrid.MarkerFaceColor = [0.05 0.05 0.9];
    
    xFoodTiles = foodProperties(:,2);
    yFoodTiles = foodProperties(:,3);
    foodGrid = scatter(xFoodTiles,yFoodTiles,10);
    foodGrid.MarkerEdgeColor = [0.05 0.9 0.05];
    foodGrid.MarkerFaceColor = [0.05 0.9 0.05];
 
end
