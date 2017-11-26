function [agentLattice, agentProperties] = ...
  MoveAgents(agentLattice, foodLattice, agentProperties, diffusion)

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

      % Agent will move to first available food position, if food exists in neighbourhood
      for d = 1:length(randomDirections)
        direction = randomDirections(d);
        [nextX, nextY] = GetPeriodicBoundaryCoordinates([x,y]', size(agentLattice), direction);
        if foodLattice(nextX, nextY) == 1
          agentLattice(nextX, nextY) = i;
          agentLattice(x,y) = 0;
          agentProperties(i,2) = nextX;
          agentProperties(i,3) = nextY;
          foodLattice(nextX, nextY) = 0;
          foodFound = true;
          break;
        end
      end

      % If food does not exist in the neighbourhood, move to an empty place
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