function [foodLattice, agentProperties, foodProperties] = ...
    ConsumeFoodTiles(agentLattice, foodLattice, agentProperties, foodProperties)

% find where agents sit on food tiles
agentsOnFoodTile = (agentLattice > 0) & (foodLattice > 0);
foodNumbers = foodLattice(agentsOnFoodTile);
agentNumbers = agentLattice(agentsOnFoodTile);

% update lattice and properties
foodLattice(agentsOnFoodTile) = 0;
foodProperties(foodNumbers,:) = 0;

% reset hunger
agentProperties(agentNumbers,5) = 0;

end
