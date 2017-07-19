TouchWindow = {
  table = {};
  new = function(x,y)
    local obj = instance(TouchWindow,Object,x,y)
    obj.pos = Vector.new(x,y)
    obj.col = HC.rectangle(obj.pos.x,obj.pos.y,16,16)
    return obj
  end;

  update = function(self,dt)
    self:CW(Player,function(other)
      if love.mouse.wasPressed(1) then
        local text = {"ここはデバッグルームだ。","これはテキストウィンドウのテストだ。","ＥＮＴＥＲボタンで文字を送ることができるぞ。","おりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃりゃ！"}
        add(TextWindow.new(nil,text,W/2,200,300,70,2))
      end
    end)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end;
};
table.insert(SearchTable,test)

Player = {
  table = {};
  new = function(x,y)
    local obj = instance(Player,Object,100,100)
    obj.name = "Player"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.col = HC.rectangle(obj.pos.x,obj.pos.y,16,16)
    ---スプライト
    obj.animator = Animator.new()
    obj.quad = split_image(6,6,img_test:getDimensions(),img_test:getDimensions(),16)

    table.insert(Player.table,obj)
    return obj
  end;

  update = function (self,dt)
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

  draw = function(self)
    love.graphics.draw(img_test,self.quad[self.animator:_animation(1,4,1)],self.pos.x-8, self.pos.y-8)
    g.setColor(255,0,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Player)
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
    g.setColor(255,0,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
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
