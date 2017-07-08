test = {
  new = function()
    local obj = instance(test,Object,100,100)
    obj.col = HC.circle(obj.x,obj.y,8)
    return obj
  end;

  update = function (self,dt)
     self.x = love.mouse.getX()
     self.y = love.mouse.getY()
     self.col:moveTo(love.mouse.getPosition())
  end;

  draw = function (self)
    g.setColor(255,255,255)
    g.circle("fill",self.x,self.y,16,16)
    g.setColor(255,0,0)
    self.col:draw("fill")
  end
};

test2 = {
  new = function(x,y)
    local obj = instance(test2,Object,100,100)
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.col = HC.circle(obj.pos.x,obj.pos.y,3)
    return obj
  end;

  update = function (self,dt)
     self.col:moveTo(self.pos.x,self.pos.y)

     for shape, delta in pairs(HC.collisions(self.col)) do
      self.vpos = delta * Vector.new(2,2)
     end

     self.pos = self.pos + self.vpos

  end;

  draw = function (self)
    g.setColor(255,255,255)
    g.setColor(255,0,0)
    --self.col:draw("fill")
  end
};

test3 = {
  new = function(x,y,w,h)
    local obj = instance(test3,Object,100,100)
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.col = HC.rectangle(x,y,w,h)
    return obj
  end;

  update = function (self,dt)
  end;

  draw = function (self)
    g.setColor(255,255,255)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)
    g.setColor(255,0,0)
    --self.col:draw("fill")
  end
}
