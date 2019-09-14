-- 爆発エフェクト
O_Effect = {
    new = function(x,y)
      local obj = instance(O_Effect,Object,x,y)
      obj.name = "O_Effect"
      obj.pos = Vector.new(x,y)
      obj.lifetime = 20
      obj.frame = 0
  
      return obj
    end;
    step = function(self,dt)
  
      if self.frame > self.lifetime then
        self:destroy()
      end
      self.frame = self.frame + 1
    end;
    draw = function(self)
      g.setColor(HSV(1,0,(self.lifetime-self.frame)/self.lifetime,0.2))
      g.circle("fill",self.pos.x,self.pos.y,(self.lifetime - self.frame)*math.random(1,3),16)
      g.setColor(1,1,1)
    end;
  }
  