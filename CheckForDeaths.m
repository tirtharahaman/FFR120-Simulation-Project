%
% Checks if the agent should die due to age or hunger, if true then delete the agent
% Death by hunger is determined by checking if its hunger value exceeds a certain threshold
%
function [agentLattice, agentProperties] = ...
  CheckForDeaths(deathRate, agentLattice, agentProperties)

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
      deathProbability = deathRate * (1-fitness);

      p = rand;
      if p < deathProbability
        x = agentProperties(agentNumber,2);
        y = agentProperties(agentNumber,3);
        agentLattice(x,y) = 0;
        agentProperties(agentNumber,:) = 0;
      end

      checkedAgents = checkedAgents + 1;
    else
      continue;
    end
  end
end