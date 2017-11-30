function [agentLattice, agentProperties] = CheckForBirths(birthRate, agentLattice, agentProperties)

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

      fitness = agentProperties(agentNumber,5);
      birthProbability = birthRate * fitness;

      p = rand;
      if p < birthProbability

        randomDirections = randperm(8);
        for d = 1:length(randomDirections)

          direction = randomDirections(d);
          x = agentProperties(agentNumber,2);
          y = agentProperties(agentNumber,3);
          [nextX, nextY] = GetPeriodicBoundaryCoordinates([x,y]', size(agentLattice), direction);
          
          if agentLattice(nextX, nextY) == 0
            agentRow = find(agentProperties(:,1) == 0);
            
            if ~isempty(agentRow)
              % New agent initialized
              agentProperties(agentRow(1), :) = [1 nextX nextY 0 1];
              agentLattice(nextX, nextY) = agentRow(1);
              break;
            end
            
          end

        end
        % At this point either a new agent was placed on the grid or no new
        % agent was created since there was no empty spot in the neighbourhood
      end
      checkedAgents = checkedAgents + 1;
    else
      continue;
    end
  end

end