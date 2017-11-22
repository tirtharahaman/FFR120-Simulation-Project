function [agentLattice,agentProperties] = MoveAgents(agentLattice,foodLattice,agentProperties,diffusion)

numberOfAgents = sum(agentProperties(:,1));

if numberOfAgents == 0
  return
end

length = size(agentLattice,1);

for i = 1:numberOfAgents
    
  r = rand;
      
  if r < diffusion
          
    agentMoved = false;
    x = agentProperties(i,2);
    y = agentProperties(i,3);
    tries = 0;
      
    while agentMoved == false
          
      direction = 1 + fix(8*rand);
      tries = tries + 1;
          
      if direction == 1
              
          if x == length
                
            if agentLattice(1,y) == 0 && foodLattice(1,y) == 0
                
              agentLattice(1,y) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = 1;
              agentProperties(i,3) = y;
              agentMoved = true;
                
            end
              
          else
              
            if agentLattice(x+1,y) == 0 && foodLattice(x+1,y) == 0
                
              agentLattice(x+1,y) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x+1;
              agentProperties(i,3) = y;
              agentMoved = true;
                
            end
                
          end
          
        elseif direction == 2
              
          if x == length && y == 1
                
            if agentLattice(1,length) == 0 && foodLattice(1,length) == 0
                
              agentLattice(1,length) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = 1;
              agentProperties(i,3) = length;
              agentMoved = true;
                
            end
              
          elseif x == length
              
            if agentLattice(1,y-1) == 0 && foodLattice(1,y-1) == 0
                
              agentLattice(1,y-1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = 1;
              agentProperties(i,3) = y-1;
              agentMoved = true;
                
            end
                
          elseif y == 1
              
            if agentLattice(x+1,length) == 0 && foodLattice(x+1,length) == 0
                
              agentLattice(x+1,length) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x+1;
              agentProperties(i,3) = length;
              agentMoved = true;
                
            end
            
          else
              
            if agentLattice(x+1,y-1) == 0 && foodLattice(x+1,y-1) == 0
                
              agentLattice(x+1,y-1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x+1;
              agentProperties(i,3) = y-1;
              agentMoved = true;
                
            end
          end
            
        elseif direction == 3
          if y == 1
                
            if agentLattice(x,length) == 0 && foodLattice(x,length) == 0
                
              agentLattice(x,length) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x;
              agentProperties(i,3) = length;
              agentMoved = true;
                
            end
              
          else
              
            if agentLattice(x,y-1) == 0 && foodLattice(x,y-1) == 0
                
              agentLattice(x,y-1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x;
              agentProperties(i,3) = y-1;
              agentMoved = true;
                
            end
                
          end
          
          elseif direction == 4
              
          if x == 1 && y == 1
                
            if agentLattice(length,length) == 0 && foodLattice(length,length) == 0
                
              agentLattice(length,length) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = length;
              agentProperties(i,3) = length;
              agentMoved = true;
                
            end
              
          elseif x == 1
              
            if agentLattice(length,y-1) == 0 && foodLattice(length,y-1) == 0
                
              agentLattice(length,y-1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = length;
              agentProperties(i,3) = y-1;
              agentMoved = true;
                
            end
                
          elseif y == 1
              
            if agentLattice(x-1,length) == 0 && foodLattice(x-1,length) == 0
                
              agentLattice(x-1,length) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x-1;
              agentProperties(i,3) = length;
              agentMoved = true;
                
            end
            
          else
              
            if agentLattice(x-1,y-1) == 0 && foodLattice(x-1,y-1) == 0
                
              agentLattice(x-1,y-1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x-1;
              agentProperties(i,3) = y-1;
              agentMoved = true;
                
            end
          end
        elseif direction == 5
              
          if x == 1
                
            if agentLattice(length,y) == 0 && foodLattice(length,y) == 0
                
              agentLattice(length,y) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = length;
              agentProperties(i,3) = y;
              agentMoved = true;
                
            end
              
          else
              
            if agentLattice(x-1,y) == 0 && foodLattice(x-1,y) == 0
                
              agentLattice(x-1,y) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x-1;
              agentProperties(i,3) = y;
              agentMoved = true;
                
            end
                
          end
          
          elseif direction == 6
              
          if x == 1 && y == length
                
            if agentLattice(length,1) == 0 && foodLattice(length,1) == 0
                
              agentLattice(length,1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = length;
              agentProperties(i,3) = 1;
              agentMoved = true;
                
            end
              
          elseif x == 1
              
            if agentLattice(length,y+1) == 0 && foodLattice(length,y+1) == 0
                
              agentLattice(length,y+1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = length;
              agentProperties(i,3) = y+1;
              agentMoved = true;
                
            end
                
          elseif y == length
              
            if agentLattice(x-1,1) == 0 && foodLattice(x-1,1) == 0
                
              agentLattice(x-1,1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x-1;
              agentProperties(i,3) = 1;
              agentMoved = true;
                
            end
            
          else
              
            if agentLattice(x-1,y+1) == 0 && foodLattice(x-1,y+1) == 0
                
              agentLattice(x-1,y+1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x-1;
              agentProperties(i,3) = y+1;
              agentMoved = true;
                
            end
          end
            
        elseif direction == 7
              
        if y == length
                
            if agentLattice(x,1) == 0 && foodLattice(x,1) == 0
                
              agentLattice(x,1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x;
              agentProperties(i,3) = 1;
              agentMoved = true;
                
            end
              
          else
              
          if agentLattice(x,y+1) == 0 && foodLattice(x,y+1) == 0
                
            agentLattice(x,y+1) = i;
            agentLattice(x,y) = 0;
            agentProperties(i,2) = x;
            agentProperties(i,3) = y+1;
            agentMoved = true;
                
          end   
        end
        
        elseif direction == 8
              
          if x == length && y == length
                
            if agentLattice(1,1) == 0 && foodLattice(1,1) == 0
                
              agentLattice(1,1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = 1;
              agentProperties(i,3) = 1;
              agentMoved = true;
                
            end
              
          elseif x == length
              
            if agentLattice(1,y+1) == 0 && foodLattice(1,y+1) == 0
                
              agentLattice(1,y+1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = 1;
              agentProperties(i,3) = y+1;
              agentMoved = true;
                
            end
                
          elseif y == length
              
            if agentLattice(x+1,1) == 0 && foodLattice(x+1,1) == 0
                
              agentLattice(x+1,1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x+1;
              agentProperties(i,3) = 1;
              agentMoved = true;
                
            end
            
          else
              
            if agentLattice(x+1,y+1) == 0 && foodLattice(x+1,y+1) == 0
                
              agentLattice(x+1,y+1) = i;
              agentLattice(x,y) = 0;
              agentProperties(i,2) = x+1;
              agentProperties(i,3) = y+1;
              agentMoved = true;
                
            end
          end
      end
      
      if tries > 100
        agentMoved = true; %agent is stuck
      end
      
    end
  end
end
end