function [foodLattice, foodProperties] = GrowFood(foodLattice, foodProperties, growProbability)

    latticeSize = size(foodLattice);
    emptyTiles = foodLattice==0;
    nEmptySites = length(foodLattice(emptyTiles));
    indices = find(emptyTiles);
    p = rand(nEmptySites,1);
    result = p < growProbability;
    foodLattice(emptyTiles) = result;
    
    growLinearIndices = result.*indices;
    growLinearIndices(growLinearIndices == 0) = [];
    [x, y] = ind2sub(latticeSize,growLinearIndices);
    
    foodProperties(growLinearIndices,1) = 1;
    foodProperties(growLinearIndices,2:3) = [x y];

end