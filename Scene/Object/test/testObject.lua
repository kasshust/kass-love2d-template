test = {
  new = function()
    local obj = instance(test,Object,100,100)
    obj.col = HC.rectangle(obj.x,obj.y,32,32)
    return obj
  end;

  update = function (self,dt)
     self.x,self.y = maincam:toWorld(love.mouse.getX(),love.mouse.getY())
     self.col:moveTo(self.x,self.y)
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
    obj.col = HC.rectangle(obj.pos.x,obj.pos.y,16,16)
    return obj
  end;

  update = function (self,dt)

      maincam:setPosition(self.pos.x,self.pos.y)

      if love.keyboard.wasPressed("up") then
        self.vpos = self.vpos + Vector.new(0.0,-4.2)
      end
      if love.keyboard.isDown("down") then
        self.vpos = Vector.new(0.0,8.0)
      end
      if love.keyboard.isDown("left") then
        self.vpos = self.vpos + Vector.new(-0.2,0.0)
      end
      if love.keyboard.isDown("right") then
        self.vpos = self.vpos + Vector.new(0.2,0.0)
      end

      self.vpos = self.vpos * Vector.new(0.95,1) + Vector.new(0.0,0.1)
      self.pos = self.pos + self.vpos

     self.col:moveTo(self.pos.x,self.pos.y)
     for shape, delta in pairs(HC.collisions(self.col)) do
      self.pos = self.pos + delta
      if delta.x ~= 0 then self.vpos = self.vpos * Vector.new(0,1) end
      if delta.y ~= 0 then self.vpos = self.vpos * Vector.new(1,0) end
     end



  end;

  draw = function (self)
    g.setColor(255,255,255)
    g.setColor(255,0,0)
    self.col:draw("fill")
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
