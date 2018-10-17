--[[
  Me_Room用のキャラクター
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

    --hsp
    self.solid:moveTo(self.pos.x-self.vpos.x,self.pos.y)
    self:collideWith("block",self.solid,function(other,delta)
      if delta.y ~= 0 then if math.sign(delta.y) == -math.sign(self.vpos.y) then self.vpos = self.vpos * Vector.new(1,0) end end
    end)
    
    --vsp
    self.solid:moveTo(self.pos.x,self.pos.y-self.vpos.y)
    self:collideWith("block",self.solid,function(other,delta)
      if  delta.x ~= 0 then
        if math.sign(delta.x) == -math.sign(self.vpos.x) then
          local x1,y1,x2,y2 = self.solid:bbox()
          local dis1,dis2 = y2 - other.pos.y , other.pos.y + other.h - y1
            if dis1 > 2 and dis2 > 2 then
              self.vpos = self.vpos * Vector.new(0,1)
            else  debugger:print("下" .. tostring(dis1),"上" .. tostring(dis2))
            end
        end
      end
    end)

    --col
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:collideWith("block",self.solid,function(other,delta)
      self.pos = self.pos + delta
      if delta.y < 0 then self.islanding = true  end
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
