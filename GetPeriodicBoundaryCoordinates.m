function [nextX, nextY] = GetPeriodicBoundaryCoordinates(position, latticeSize, direction)

  x = position(1); y = position(2);
  xMax = latticeSize(1); yMax = latticeSize(2);

  % 1 -- 2 -- 3
  % |    |    |
  % 8 --[o]-- 4   Directions surrounding a position[o]
  % |    |    |
  % 7 -- 6 -- 5

  switch(direction)
    case 1
      if x == 1
        nextX = xMax;
      else
        nextX = x-1;
      end

      if y == 1
        nextY = yMax;
      else
        nextY = y-1;
      end
  
    case 2
      nextX = x;

      if y == 1
        nextY = yMax;
      else
        nextY = y-1;
      end

    case 3
      if x == xMax
        nextX = 1;
      else
        nextX = x+1;
      end

      if y == 1
        nextY = yMax;
      else
        nextY = y-1;
      end

    case 4
      if x == xMax
        nextX = 1;
      else
        nextX = x+1;
      end
      
      nextY = y;

    case 5
      if x == xMax
        nextX = 1;
      else
        nextX = x+1;
      end

      if y == yMax
        nextY = 1;
      else
        nextY = y+1;
      end
      
    case 6
      nextX = x;

      if y == yMax
        nextY = 1;
      else
        nextY = y+1;
      end
      
    case 7
      if x == 1
        nextX = xMax;
      else
        nextX = x-1;
      end

      if y == yMax
        nextY = 1;
      else
        nextY = y+1;
      end
      
    case 8
      if x == 1
        nextX = xMax;
      else
        nextX = x-1;
      end
      
      nextY = y;
  end

end