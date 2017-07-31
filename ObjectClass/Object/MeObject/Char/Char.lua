--[[
  メトロヴァニア的なキャラクター
]]

Char = {
  new = function(x,y)
    local obj = instance(Char,Object,x,y)
    --継承時に探索用のため必要
    obj.name = "Char"
    obj.tag = {"char"}

    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = 16,16

    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.solid.other = obj

    obj.islanding = false
    obj.dir = {x = 1,y= 0}
    return obj
  end;

  step = function(self,dt)
  end;

  --メトロヴァニア的な当たり判定
  collision = function(self)
    ---着地判定
    self:checkLanding()
    ---衝突検知
    self:checkCollisionWithSolid()
    --solid,colをposに
    self.solid:moveTo(self.pos.x,self.pos.y)
  end;

  checkCollisionWithSolid = function(self)
    --blockと衝突
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:collideWith("block",self.solid,function(other,delta)
      self.pos = self.pos + delta
      if delta.y < 0 then self.islanding = true  end
      if delta.x ~= 0 and (math.abs(delta.x) > 0.01) then self.vpos = self.vpos * Vector.new(0,1) end
      if delta.y ~= 0 and (math.abs(delta.y) > 0.01) then self.vpos = self.vpos * Vector.new(1,0) end
    end)

  end;
  checkLanding = function(self)
    self.islanding = false
    self.solid:moveTo(self.pos.x,self.pos.y + 2)
    self:collideWith("block",self.solid,function(other,delta)
      if delta.y ~= 0 then self.islanding = true end
    end)
  end;

  draw = function(self)
    if self.visible == true then
      g.setColor(255,0,0,128)
      self.solid:draw("fill")
      g.setColor(255,255,255,255)
    end
  end;
};
