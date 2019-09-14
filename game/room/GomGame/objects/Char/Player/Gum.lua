  --　ガム

  O_Gum = {
    new = function(x,y,player)
      local obj = instance(O_Gum,Object,x,y,player)
      obj.name = "O_Gum"
      obj.tag = {"gum"}
      obj.player = player
      obj.pos = Vector.new(x,y)
      obj.vpos = Vector.new(0,0);    
      obj.radius  = 128
      obj.solid = HC.circle(x,y,obj.radius)
      obj.solid.other = obj
      obj.gom = true
      obj.frame = 0
      obj.done = false
      return obj
    end;
  
    step = function(self,dt)
      self.pos = self.pos + self.vpos
      self.frame = self.frame + 1
    end;
  
    collision = function(self)
      self.solid:moveTo(self.pos.x,self.pos.y)
  
      self:collideWith("string",self.solid,function(other,delta)
  
        if self.done == false then
          self.done = true 
          -- stringをplayerShot化するぞ
          other.playerShot = true
          other.enemyShot = false
          -- ゴム化
          table.insert(self.player.ball,other) 
          other.player = self.player
          other.gom = true
          self:destroy()
        end
      end)
  
      self:destroy()
    end;
    draw = function(self)
      g.circle("line",self.pos.x,self.pos.y,self.radius)
    end;
  }