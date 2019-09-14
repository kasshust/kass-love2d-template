
O_PlayerShot = {
    new = function(x,y,player)
      local obj = instance(O_PlayerShot,O_String,x,y)
      obj.name = "O_PlayerShot"
      table.insert(obj.tag,"PlayerAttack")
      
      --標準でエネミーショット化
      obj.playerShot = true;
      
      obj.pos = Vector.new(x,y)
      obj.solid = HC.rectangle(x,y,6,4)
      obj.solid.other = obj

      return obj
    end;
    
    -- 継承先でこんな感じで書いてね
    collision = function(self)
     -- 複数オブジェクトとの接触時に問題あり
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
        g.setColor(ASE.DARKGRAY)
        g.ellipse("fill",self.pos.x - self.vpos.x*2.5,self.pos.y - self.vpos.y*2.5,xscale,yscale)
        g.setColor(ASE.LIGHTCYAN)
        g.ellipse("fill",self.pos.x - self.vpos.x,self.pos.y - self.vpos.y,xscale,yscale)
        g.setColor(ASE.WHITE)
        g.ellipse("fill",self.pos.x,self.pos.y,xscale,yscale)
    end;
  
  }