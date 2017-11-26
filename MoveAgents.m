function [agentLattice, agentProperties] = ...
  MoveAgents(agentLattice, foodLattice, agentProperties, diffusion, moveToFood)

  nAgents = sum(agentProperties(:,1));

  if nAgents == 0
    return;
  end

  for i = 1:nAgents

    r = rand;

    if r < diffusion

      x = agentProperties(i,2);
      y = agentProperties(i,3);

      randomDirections = randperm(8);
      foodFound = false;

      % Agent will move to the first available food position if moveToFood is set to true,
      % and if food exists in neighbourhood
      if moveToFood
          for d = 1:length(randomDirections)
            direction = randomDirections(d);
            [nextX, nextY] = GetPeriodicBoundaryCoordinates([x,y]', size(agentLattice), direction);
            if foodLattice(nextX, nextY) == 1 && agentLattice(nextX, nextY) == 0
              agentLattice(nextX, nextY) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = nextX;
              agentProperties(i,3) = nextY;
              foodFound = true;
              break;
            end
          end
      end

      % If food does not exist in the neighbourhood or moveToFood is set to false,
      % move to an empty place
      if ~foodFound
        for d = 1:length(randomDirections)
          direction = randomDirections(d);
          [nextX, nextY] = GetPeriodicBoundaryCoordinates([x,y]', size(agentLattice), direction);
          if agentLattice(nextX, nextY) == 0
            agentLattice(nextX, nextY) = i;
            agentLattice(x,y) = 0;
            agentProperties(i,2) = nextX;
            agentProperties(i,3) = nextY;
            break;
          end
        end
      end
      % At this point either agent has moved to a food spot, or to an empty
      % spot. If there is no empty spot, the agent will not move.
    end
  end

end