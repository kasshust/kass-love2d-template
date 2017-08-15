--[[
  Me_Room用の地形オブジェクト
]]

Block = {
  new = function(x,y,w,h)
    local obj = instance(Block,Object)
    obj.name = "test3"
    obj.tag = {"block"}
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.other = obj
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    --g.setColor(255,0,0,128)
    --self.solid:draw("fill")
    --g.setColor(255,255,255,255)
  end
};

-- <-Block
MoveBlock = {
  new = function(x,y,w,h,vx,vy)
    local obj = instance(MoveBlock,Block,x,y,w,h)
    obj.name = "test3"
    obj.frame = 0
    obj.pos = Vector.new(x,y)
    obj.dpos = Vector.new(x,y)
    obj.v = Vector.new(vx or 0,vy or 0)
    obj.bpos = obj.pos

    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.other = obj
    obj.col = HC.rectangle(x,y,w,2)
    return obj
  end;

  step = function(self,dt)
    self.frame = self.frame + 1
    local pre = Vector.new(self.pos.x,self.pos.y)
    self.pos = self.bpos + Vector.new(self.v.x * math.sin(self.frame * 2*math.pi/360),self.v.y * math.sin(self.frame * 2*math.pi/360))
    self.dpos = self.pos - pre
  end;

  collision = function(self,dt)
    --乗ったものを動かす
    self.col:moveTo(self.pos.x,self.pos.y-self.h/2-1)
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:collideWith("char",self.col,function(other,delta)
      --other.islanding = true
      if other.islanding == true then
        other.pos = other.pos + self.dpos
      end
    end)

    self:collideWith("char",self.solid,function(other,delta)
      other.pos = other.pos - delta
      other.solid:moveTo(other.pos.x,other.pos.y)
    end)
    --プレイヤーを吐き出す


  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("fill")
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};

Floor = {
  new = function(x,y,w,h)
    local obj = instance(Floor,Object)
    obj.name = "Floors"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.other = obj
    return obj
  end;

  step = function(self,dt)
  end;

  collision = function(self,dt)
    --tag作ったほうがいいと思う
    --[[
    self:CW(Char,function(other,dx,dy)
      --other.pos = other.pos - Vector.new(dx,dy)

      --条件作る
      --self.pos.y - (other.pos.y + other.h/2) > -4
      if dy > 0 then
        other.islanding = true
        other.pos.y = self.pos.y - other.h/2
        other.vpos = other.vpos * Vector.new(1,0)
      end

      other.solid:moveTo(other.pos.x,other.pos.y)
      other.col:moveTo(other.pos.x,other.pos.y)
    end)
    ]]
  end;

  draw = function(self)
    self.solid:draw("fill")
  end
};

Slope = {
  new = function(...)
    local obj = instance(Slope,Object)
    obj.name = "test3"
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    local p = {}
    for k ,v in pairs(...) do
      table.insert(p,v.x)
      table.insert(p,v.y)
    end
    obj.solid = HC.polygon(p[1],p[2],p[3],p[4],p[5],p[6])
    obj.pos = Vector.new(p[1],p[2]);
    return obj
  end;
  collision = function(self,dt)
    self.solid:move(0,-3)
    self:collideWith("char",self.solid,function(other,delta)
      if delta.y >= 0 and other.vpos.y >= 0 then
        other.islanding = true
        other.pos = other.pos - Vector.new(0,delta.y-2)
        other.vpos = other.vpos * Vector.new(1,0)
        other.solid:moveTo(other.pos.x,other.pos.y)
      end
    end)
    self.solid:move(0,3)
  end;
};
