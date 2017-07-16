test = {
  table = {};
  new = function()
    local obj = instance(test,Object,100,100)
    obj.name = "test"
    return obj
  end;

  update = function(self,dt)
     self.x,self.y = maincam:toWorld(love.mouse.getX(),love.mouse.getY())
     if love.mouse.wasPressed(1) then
       add(test4.new(self.x,self.y,math.random(1, 16*2)))
     end
  end;
};
table.insert(SearchTable,test)


test2 = {
  table = {};
  new = function(x,y)
    local obj = instance(test2,Object,100,100)
    obj.name = "test2"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.col = HC.rectangle(obj.pos.x,obj.pos.y,16,16)
    table.insert(test2.table,obj)
    return obj
  end;

  update = function (self,dt)
      maincam:setPosition(self.pos.x,self.pos.y)
      if love.keyboard.wasPressed("w") then
        self.vpos = self.vpos + Vector.new(0.0,-4.2)
      end
      if love.keyboard.isDown("s") then
        self.vpos = Vector.new(0.0,8.0)
      end
      if love.keyboard.isDown("a") then
        self.vpos = self.vpos + Vector.new(-0.2,0.0)
      end
      if love.keyboard.isDown("d") then
        self.vpos = self.vpos + Vector.new(0.2,0.0)
      end

      self.vpos = self.vpos * Vector.new(0.90,1.00) + Vector.new(0.0,0.1)
      self.pos = self.pos + self.vpos


     self.col:moveTo(self.pos.x,self.pos.y)
     for shape, delta in pairs(HC.collisions(self.col)) do
      self.pos = self.pos + delta
      if delta.x ~= 0 then self.vpos = self.vpos * Vector.new(0,1) end
      if delta.y ~= 0 then self.vpos = self.vpos * Vector.new(1,0) end
     end
     self.col:moveTo(self.pos.x,self.pos.y)
  end;

  draw = function (self)
    g.setColor(255,255,255)
    g.setColor(255,0,0)
    self.col:draw("fill")
  end
};
table.insert(SearchTable,test2)
test3 = {
  table = {};
  new = function(x,y,w,h)
    local obj = instance(test3,Object,100,100)
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.col = HC.rectangle(x,y,w,h)
    table.insert(test3.table,obj)
    return obj
  end;

  update = function(self,dt)
  end;

  draw = function(self)
    g.setColor(255,255,255)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)
    g.setColor(255,0,0)
    --self.col:draw("fill")
  end
};
table.insert(SearchTable,test3)
test4 = {
  table = {};
  new = function(x,y,c)
    local obj = instance(test4,Object,100,100)
    obj.name = "test4"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.col = HC.circle(x,y,c)
    table.insert(test4.table,obj)
    return obj
  end;

  update = function(self,dt)
    self.vpos = self.vpos * Vector.new(0.95,0.95) + Vector.new(0.0,0.1)
    self.pos = self.pos + self.vpos
    self.vpos = self.vpos


    self.col:moveTo(self.pos.x,self.pos.y)
    for shape, delta in pairs(HC.collisions(self.col)) do
      self.vpos = self.vpos + delta
    end
    self.col:moveTo(self.pos.x,self.pos.y)

    --[[
    self:CW(,function(other)
      self.vpos = self.vpos + Vector.new(0,-2.0)
    end)
    self.col:moveTo(self.pos.x,self.pos.y)
    ]]--

  end;

  draw = function(self)
    g.setColor(255,255,255)
    g.setColor(255,0,0)
    self.col:draw("fill")
  end
};
table.insert(SearchTable,test4)
test5 = {
  table = {};
  new = function()
    local obj = instance(test5,Object,100,100)
    obj.name = "test5"
    table.insert(test5.table,obj)
    return obj
  end;
}
table.insert(SearchTable,test5)

Window = {
  new = function(parent,x,y,w,h)
    local obj = instance(Window,Object)
    obj.x,obj.y = x,y
    obj.w,obj.h = w,h
    obj.child = parent
    obj.tw = {frame = 0}
    obj.time = {}
    obj.time._in = 0.3
    obj.time._out = 0.4
    obj.tween1 = tween.new(obj.time._in, obj.tw, {frame = 1}, tween.easing.outBounce)
    obj.tween2 = tween.new(obj.time._out, obj.tw, {frame = 0}, tween.easing.outBounce)
    obj.name = "window"
    obj.status = Enum:new{"IN","OUT","NOONE","SLEEP"};
    obj.status_now = obj.status.IN
    return obj
  end;
  update = function(self,dt)
    local switch = {}
    switch[self.status.IN] = function()

      local finish = self.tween1:update(dt)

      if finish then
        self.status_now = self.status.NOONE
      end
    end
    switch[self.status.NOONE] = function()
      self:f()
    end
    switch[self.status.SLEEP] = function()
    end
    switch[self.status.OUT] = function()

      local finish = self.tween2:update(dt)

      if finish then
        self:destroy()
      end
    end
    switch[self.status_now]()
  end;
  close = function(self)
      self.status_now = self.status.OUT
  end;
  drawGUI = function(self)
    local switch = {}
    switch[self.status.IN] = function()
      self:drawWindow()
    end
    switch[self.status.NOONE] = function()
      self:drawWindow()
      self:drawContent()
    end
    switch[self.status.SLEEP] = function()
      self:drawWindow()
      self:drawContent()
    end
    switch[self.status.OUT] = function()
      self:drawWindow()
    end
    switch[self.status_now]()
  end;
  ------↓をオーバーライド

  --処理
  f = function(self)
  end;
  --windowのデザイン
  drawWindow = function(self)
    --self.tw.frame が 0-1
  end;
  --contentのデザイン
  drawContent = function(self)
  end;
}

testWindow = {
  new = function(parent,x,y,w,h)
    local obj = instance(testWindow,Window,parent,x,y,w,h)
    return obj
  end;

  f = function(self)
    if love.mouse.wasPressed(2) then
      self:close()
    end
  end;
  drawWindow = function(self)
    g.setColor(128,128,128,128)
    love.graphics.rectangle("fill", g_x + self.x  - self.w*self.tw.frame/2, g_y + self.y - self.h*self.tw.frame/2, self.w*self.tw.frame, self.h * self.tw.frame)
    g.setColor(256,256,256,256)
  end;
  drawContent = function(self)
    g.print("うんこうんこ",g_x + self.x- self.w*self.tw.frame/2,g_y + self.y - self.h*self.tw.frame/2)
  end;
}
