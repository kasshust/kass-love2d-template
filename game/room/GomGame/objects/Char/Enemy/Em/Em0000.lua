--[[
    Enemyのテンプレ
]]

O_Em0000 = {
    new = function(x,y)
      local obj = instance(O_Em0000,O_Enemy,x,y)
      --継承時に探索用のため必要
      obj.name = "O_Em0000" 
      return obj
    end;
  
    step = function(self,dt)
      O_Enemy.step(self,dt)
    end;
  
    collision = function(self)
      O_Enemy.collision(self)
    end;
    draw = function(self)
        love.graphics.circle("line", self.pos.x, self.pos.y , 16, 8)        
    end;
  }