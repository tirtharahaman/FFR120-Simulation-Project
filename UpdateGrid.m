%% UpdateGrid.m
%
%
function UpdateGrid(agentGrid, foodGrid, agentProperties, foodProperties)

    xAgents = agentProperties(:,2);
    yAgents = agentProperties(:,3);
    agentGrid.XData = xAgents;
    agentGrid.YData = yAgents;
    
    xFoodTiles = foodProperties(:,2);
    yFoodTiles = foodProperties(:,3);
    foodGrid.XData = xFoodTiles;
    foodGrid.YData = yFoodTiles;

end