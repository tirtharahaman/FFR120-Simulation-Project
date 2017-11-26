function [agentLattice, foodLattice, agentProperties, foodProperties] = ...
  InitializeLattices(sideLength, initialPopulationSize, initialFoodSupply)

  agentLattice = zeros(sideLength);
  foodLattice = zeros(sideLength);
  agentProperties = zeros(sideLength^2,5); %Currently built for 5 properties,
  %Dead/Alive, x, y, age and hunger. Can be changed of course.
  foodProperties = zeros(sideLength^2,3); %to keep track of x- and y-coordinates when food grows

  for i = 1:initialFoodSupply

    foodPlanted = false;

    while foodPlanted == false

      x = 1 + fix(sideLength*rand); 
      y = 1 + fix(sideLength*rand);

      if foodLattice(x,y) == 0

        foodLattice(x,y) = i;
        foodPlanted = true;
        foodProperties(i,1) = true; %true means alive
        foodProperties(i,2) = x;
        foodProperties(i,3) = y;

      end
    end
  end

  for i = 1:initialPopulationSize

    agentPlaced = false;

    while agentPlaced == false

      x = 1 + fix(sideLength*rand); 
      y = 1 + fix(sideLength*rand);

      if agentLattice(x,y) == 0

        agentLattice(x,y) = i;
        agentPlaced = true;
        agentProperties(i,1) = true; %true means alive
        agentProperties(i,2) = x;
        agentProperties(i,3) = y;

      end
    end
  end

end