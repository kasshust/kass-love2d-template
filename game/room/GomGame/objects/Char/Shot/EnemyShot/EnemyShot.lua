
O_EnemyShot = {
    new = function(x,y,player)
      local obj = instance(O_EnemyShot,O_String,x,y)
      obj.name = "O_String"
      table.insert(obj.tag,"EnemyAttack")

      obj.wight = 8.7
      
      --標準でエネミーショット化
      obj.enemyShot = true;
      
      obj.pos = Vector.new(x,y)
      obj.solid = HC.rectangle(x,y,6,4)
      obj.solid.other = obj

      obj.frame = 0
      table.insert(obj.tag,"string")
      return obj
    end;
    
    -- 継承先でこんな感じで書いてね
    collision = function(self)
        self.solid:moveTo(self.pos.x,self.pos.y)

        self:collideWithWall()
        
        self:collideWithPlayer(function(other,delta)
            self.pos = self.pos + delta
            testEffect.new(self.pos.x,self.pos.y)
            Smoke.new(self.pos.x,self.pos.y)
            O_Effect.new(self.pos.x,self.pos.y)
            self.kill = true
        end)

        self:collideWithEnemy(function(other,delta)
          self.pos = self.pos + delta
          testEffect.new(self.pos.x,self.pos.y)
          --camStand:shake(10,4,4)
          Smoke.new(self.pos.x,self.pos.y)
          O_Effect.new(self.pos.x,self.pos.y)
          self.kill = true
        end)
    end;



    draw = function(self)        
      local xscale,yscale = math.abs(self.vpos.x/2) + 3 , math.abs(self.vpos.y/2) + 3
      g.setColor(ASE.RED)
      g.ellipse("fill",self.pos.x - self.vpos.x*2.5,self.pos.y - self.vpos.y*2.5,xscale,yscale)
      g.setColor(ASE.ORANGE)
      g.ellipse("fill",self.pos.x - self.vpos.x,self.pos.y - self.vpos.y,xscale,yscale)
      g.setColor(ASE.YELLOW)
      g.ellipse("fill",self.pos.x,self.pos.y,xscale,yscale)
      g.setColor(ASE.WHITE)
    end;
  
  }
  
