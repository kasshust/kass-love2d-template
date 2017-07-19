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
    self:CW(test2,function(other)
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
  new = function(parent,x,y,w,h,depth)
    local obj = instance(Window,Object)
    obj.x,obj.y = x,y
    obj.w,obj.h = w,h
    obj.parent = parent
    obj.visible = true

    if obj.parent ~= nil then obj.depth = obj.parent.depth - 1 else obj.depth = depth or 0 end

    obj.tw = {frame = 0}
    obj.time = {}
    obj.time._in = 0.3
    obj.time._out = 0.3
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
      self:f(dt)
    end
    switch[self.status.SLEEP] = function()
    end
    switch[self.status.OUT] = function()

      local finish = self.tween2:update(dt)

      if finish then
        if self.f_close ~= nil then self:f_close() end
        self:destroy()
      end
    end
    switch[self.status_now]()
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
    if self.visible then switch[self.status_now]() end
  end;

  close = function(self)
    self.status_now = self.status.OUT
  end;
  f_close = function(self)
  end;
  activate = function(self)
    self.status_now = self.status.NOONE
  end;
  sleep = function(self)
    self.status_now = self.status.SLEEP
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

--親、座標、サイズ、テキスト(content)、depthを指定してテキストウィンドウを作成
TextWindow = {
  new = function(parent,text,x,y,w,h,padding,depth)
    local obj = instance(TextWindow,Window,parent,x,y,w,h,depth)
    --テキストが空だとerror
    if #text == 0 then error("text must have string!") end

    obj.byte = 3 ---日本語は3 アルファベットは1
    obj.s = Enum:new{"UPDATE","NOONE"};
    obj.s_n = obj.s.UPDATE

    obj.text = ""
    obj.text_byte = {}
    for i,v in ipairs(text) do
      local prev = obj.text_byte[i-1] ~= nil and obj.text_byte[i-1] or 0
      table.insert(obj.text_byte,#v + prev)
      obj.text = obj.text .. v
    end
    --表示用
    obj.str = ""
    obj.frame = 0
    obj.num = 1 ---textの回数
    obj.padding = padding or 0
    obj.c_x = obj.x + obj.padding
    obj.c_y = obj.y + obj.padding
    obj.c_w = obj.w - obj.padding * 2
    obj.c_h = obj.h - obj.padding * 2

    ----tween用
    --超過したlowを格納
    obj.lt = {low = 0}
    --現在の行数
    obj.low = 0
    obj.maxlow = math.floor(obj.c_h/font:getHeight())
    obj.excesslow = obj.low - obj.maxlow > 0 and obj.low - obj.maxlow or 0
    obj.tween = tween.new(0.1, obj.lt, {low = obj.excesslow }, tween.easing.outSin)

    return obj
  end;

  --アクティブ時の処理
  f = function(self,dt)
    --キーボード
    local switch = {}
    switch[self.s.UPDATE] = function()
      self:updateText()

      --skip
      if love.mouse.wasPressed(2) then
        self.frame = self.text_byte[self.num] / self.byte
        self.s_n = self.s.NOONE
      end

      --状態判定
      if self.frame * self.byte  >= self.text_byte[self.num] then
        self.frame = self.text_byte[self.num] / self.byte
        self.s_n = self.s.NOONE
      end
      self:scrollText()
    end
    --受付
    switch[self.s.NOONE] = function()
      if love.mouse.wasPressed(2) then
        if self.num < #self.text_byte then
          self.num = self.num + 1
          self.s_n = self.s.UPDATE
        else
          self:close()
        end
      end
    end
    switch[self.s_n]()
    self.tween:update(dt)
  end;
  --超過分の文字送り
  scrollText = function(self)
    self.str = self.text:sub(0,self.byte*math.ceil(self.frame))
    local width, wrappedtext = font:getWrap( self.str, self.c_w )
    local low = math.ceil(font:getWidth(self.str) / width)
    self.excesslow = low - self.maxlow > 0 and low - self.maxlow or 0
    --以前のlowと異なる場合、超過分を繰越
    if self.low ~= low then
      self.tween = tween.new(0.1, self.lt, {low = self.excesslow}, tween.easing.outBounce)
    else
    end
    self.low = low
  end;
  --文字を送る
  updateText = function(self)
    self.frame = self.frame + 1
    --if self.frame % 3 == 0 then soundmanager:play("sound/se/se_test.wav") end
  end;

  -------------------------以下任意--------------------------
  --終了時の処理
  f_close = function(self)
    if self.parent ~= nil then self.parent:activate() end
  end;
  --windowのデザイン
  drawWindow = function(self)
    g.setColor(128,128,128,128)
    love.graphics.rectangle("fill", g_x + self.x  - self.w*self.tw.frame/2, g_y + self.y - self.h*self.tw.frame/2, self.w*self.tw.frame, self.h * self.tw.frame)
    g.setColor(256,256,256,256)
  end;
  --windowの内容
  drawContent = function(self)
    g.cut(self.x - self.w/2 + self.padding,self.y-self.h/2 + self.padding,self.w - self.padding*2,self.h - self.padding*2,function()
      g.printf(self.str,g_x + self.c_x - self.w*self.tw.frame/2,g_y + self.c_y - self.h*self.tw.frame/2 - self.lt.low * font:getHeight(),self.c_w)
    end)
    g.print(self.status_now,g_x + self.x- self.w*self.tw.frame/2,g_y + self.y - self.h*self.tw.frame/2 - 15)
  end;
}
