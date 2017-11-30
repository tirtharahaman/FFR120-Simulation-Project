function [foodLattice, foodProperties] = ...
    GrowFood(foodLattice, agentLattice, foodProperties, growProbability)
% clc; clear
% [agentLattice, foodLattice, agentProperties, foodProperties] = ...
% InitializeLattices(3,2,2)
% growProbability = 1;
    
    latticeSize = size(foodLattice);
    % food cannot spawn on tiles where agents are
    emptyTiles = (foodLattice==0) & agentLattice==0;
    nEmptySites = length(foodLattice(emptyTiles));
    indices = find(emptyTiles);
    p = rand(nEmptySites,1);
    result = p < growProbability;
    
    growLinearIndices = result.*indices;
    growLinearIndices(growLinearIndices == 0) = [];
	% coordinates for the new grown food
    [x, y] = ind2sub(latticeSize,growLinearIndices);
    
    nNewFoodTiles = length(growLinearIndices);
    nChecked = 0;
    foodNumber = 0;
    while nChecked < nNewFoodTiles
        foodNumber = foodNumber + 1;
        tileIsOccupied = foodProperties(foodNumber,1);
        if ~tileIsOccupied
            % find the first empty spots
            foodProperties(foodNumber,1) = 1;
            foodProperties(foodNumber,2:3) = [x(nChecked+1) y(nChecked+1)];
            foodLattice(x(nChecked+1), y(nChecked+1)) = foodNumber;
            nChecked = nChecked + 1;
        end
    end
end