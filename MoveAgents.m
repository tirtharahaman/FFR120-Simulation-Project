function [agentLattice, agentProperties] = ...
  MoveAgents(agentLattice, foodLattice, agentProperties, diffusion, moveToFood)

  nAgents = sum(agentProperties(:,1));

  if nAgents == 0
    return;
  end

  agentNumber = 0;
  checkedAgents = 0; % we need to check first if the agent is alive or dead
  while checkedAgents < nAgents
    agentNumber = agentNumber + 1;
    isAlive = agentProperties(agentNumber,1);
    if isAlive
        
    r = rand;

    if r < diffusion

      x = agentProperties(agentNumber,2);
      y = agentProperties(agentNumber,3);

      randomDirections = randperm(8);
      foodFound = false;

      % Agent will move to the first available food position if moveToFood is set to true,
      % and if food exists in neighbourhood
      if moveToFood
          for d = 1:length(randomDirections)
            direction = randomDirections(d);
            [nextX, nextY] = GetPeriodicBoundaryCoordinates([x,y]', size(agentLattice), direction);
            if foodLattice(nextX, nextY) == 1 && agentLattice(nextX, nextY) == 0
              agentLattice(nextX, nextY) = agentNumber;
              agentLattice(x,y) = 0;
              agentProperties(agentNumber,2) = nextX;
              agentProperties(agentNumber,3) = nextY;
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
            agentLattice(nextX, nextY) = agentNumber;
            agentLattice(x,y) = 0;
            agentProperties(agentNumber,2) = nextX;
            agentProperties(agentNumber,3) = nextY;
            break;
          end
        end
      end
      % At this point either agent has moved to a food spot, or to an empty
      % spot. If there is no empty spot, the agent will not move.
    end
    	checkedAgents = checkedAgents + 1;
    else
        continue 
    end
  end

end