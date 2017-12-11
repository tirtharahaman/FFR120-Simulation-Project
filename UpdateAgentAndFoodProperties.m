function [agentProperties, foodLattice, foodProperties] = ...
  UpdateAgentAndFoodProperties(agentProperties, foodLattice, foodProperties,...
                                foodConstant, hungerConstant, ageConstant)
  
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
      x = agentProperties(agentNumber,2);
      y = agentProperties(agentNumber,3);
      age = agentProperties(agentNumber,4);
      ateFood = 0;
      
      % updating food lattice and food properties
      if foodLattice(x, y) ~= 0
        ateFood = 1;
        % removing food
        foodProperties(foodLattice(x, y), :) = 0;
        foodLattice(x, y) = 0;
      end
      
      % updating agent age
      agentProperties(agentNumber, 4) = agentProperties(agentNumber, 4) + 1;
      
      % updating agent fitness
      % fitness = fitness + foodConstant - (ageConstant * age); if eats food
      % fitness = fitness - hungerConstant - (ageConstant * age); if does NOT eat food
      % ageConstant = 1/maxAge;

      fitness = agentProperties(agentNumber, 5);
      fitness = ...
        fitness + (foodConstant * ateFood) - (ageConstant * age)...
                              - (1-ateFood) * hungerConstant;
      
      % Capping fitness between 0 and 1
      fitness = min(fitness, 1);
      fitness = max(fitness, 0);
      agentProperties(agentNumber, 5) = fitness;
      
      checkedAgents = checkedAgents + 1;
    else
      continue;
    end
  end

end
