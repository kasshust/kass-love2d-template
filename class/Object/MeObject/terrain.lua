--[[
  Me_Room用の地形オブジェクト
]]

Block = {
  table = {};
  new = function(class,x,y,w,h)
    local obj = instance(Block,Object,class,100,100)
    Block.table[obj.id] = obj
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.tag = "block"
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
table.insert(SearchTable,Block)

-- <-Block
MoveBlock = {
  table = {};
  new = function(class,x,y,w,h,vx,vy)
    local obj = instance(MoveBlock,Block,class,x,y,w,h)
    MoveBlock.table[obj.id] = obj
    obj.name = "test3"
    obj.frame = 0
    obj.pos = Vector.new(x,y)
    obj.dpos = Vector.new(x,y)
    obj.v = Vector.new(vx or 0,vy or 0)
    obj.bpos = obj.pos

    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.tag = "block"
    obj.col = collider:rectangle(obj.pos.x,obj.pos.y-obj.h-1,w,1)
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
    self:CW(Char,function(other,dx,dy)
      --other.islanding = true
      if other.islanding == true then
        other.pos = other.pos + self.dpos
      end
    end)

    --プレイヤーを吐き出す
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:SW(Char,function(other,dx,dy)
      other.pos = other.pos - Vector.new(dx,dy)
      other.solid:moveTo(other.pos.x,other.pos.y)
      other.col:moveTo(other.pos.x,other.pos.y)
    end)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("fill")
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,MoveBlock)

Floor = {
  table = {};
  new = function(class,x,y,w,h)
    local obj = instance(Floor,Object,class,100,100)
    Floor.table[obj.id] = obj
    obj.name = "Floors"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.col = collider:rectangle(x,y,w,h)
    return obj
  end;

  step = function(self,dt)
  end;

  collision = function(self,dt)
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
  end;

  draw = function(self)
    g.setColor(255,0,255,128)
    self.col:draw("fill")
    g.setColor(255,255,255)
  end
};
table.insert(SearchTable,Floor)

Slope = {
  table = {};
  new = function(class,...)
    local obj = instance(Slope,Object,class)
    Slope.table[obj.id] = obj
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    local p = {}
    for k ,v in pairs(...) do
      table.insert(p,v.x)
      table.insert(p,v.y)
    end
    obj.col = collider:polygon(p[1],p[2],p[3],p[4],p[5],p[6])
    return obj
  end;

  step = function(self,dt)
  end;

  collision = function(self,dt)
    self.col:move(0,-3)
    self:CW(Char,function(other,dx,dy)
      if dy >= 0 and other.vpos.y >= 0 then
        other.islanding = true
        other.pos = other.pos - Vector.new(0,dy-2)
        other.vpos = other.vpos * Vector.new(1,0)
        other.solid:moveTo(other.pos.x,other.pos.y)
        other.col:moveTo(other.pos.x,other.pos.y)
      end
    end)
    self.col:move(0,3)
  end;

  draw = function(self)
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Slope)
