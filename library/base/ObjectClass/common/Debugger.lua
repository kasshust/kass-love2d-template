Debugger ={
  new = function()
      local obj = instance(Debugger)
      --window
      obj.x = 0
      obj.y = 0
      obj.maxWidth = 900
      obj.maxHeight = 600
      obj.minWidth = 100
      obj.minHeight = 100
      obj.width = 300
      obj.height = 100
      obj.d_x = 0
      obj.d_y = 0
      obj.resize_x = 0
      obj.resize_y = 0

      obj.box = {_y = -15}
      obj.move = tween.new(0.1, obj.box, {_y = 0}, tween.easing.inOutQuad)

      --console
      obj.text = {}

      obj.status = Enum:new{"NOONE","MOVE","RESIZE"};
      obj.status_now = obj.status.NOONE
      return obj
  end;
  update = function(self,dt)
    local m_x = love.mouse.getX()
    local m_y = love.mouse.getY()

    local switch={}
    switch[self.status.NOONE]=function()

      --  MOVE
      if m_x > self.x and m_x < self.x + self.width and m_y > self.y and m_y < self.y + self.height then
        if love.mouse.wasPressed(1)then
          self.d_x = m_x - self.x
          self.d_y = m_y - self.y
          self.status_now = self.status.MOVE
        end
      end

      --  RESIZE
      if m_x > self.x + self.width and m_x < self.x + self.width + 10 and m_y > self.y + self.height and m_y < self.y + self.height + 10 then
        if love.mouse.wasPressed(1) then
          self.resize_x = m_x
          self.resize_y = m_x
          self.status_now = self.status.RESIZE
        end
      end
    end
    switch[self.status.MOVE]=function()
      --windowを移動
        if love.mouse.isDown(1) then
          self.x = m_x - self.d_x
          self.y = m_y - self.d_y
        else self.status_now = self.status.NOONE
        end

    end
    switch[self.status.RESIZE]=function()
      if love.mouse.isDown(1) then
          self.width = self.width +  (m_x - self.resize_x)
          self.height = self.height + (m_y - self.resize_y)

          self.width = math.clamp(self.width,self.minWidth,self.maxWidth)
          self.height = math.clamp(self.height,self.minHeight,self.maxHeight)

          self.resize_x = m_x
          self.resize_y = m_y

        else self.status_now = self.status.NOONE
      end
    end
    switch[self.status_now]()
    self.move:update(dt)
  end;

  draw = function(self)
    --window作成
    love.graphics.setScissor(self.x, self.y, self.width, self.height )

    love.graphics.setColor(0.4,0.4,0.4,0.4)
    love.graphics.rectangle("fill", self.x, self.y, self.maxWidth, self.maxHeight)

    love.graphics.setColor(0.4,0.4,0.4,0.4)
    love.graphics.rectangle("fill", self.x, self.y, self.maxWidth, self.maxHeight)
    love.graphics.setColor(1,1,1,1)
    
    --print messages
    for i = 1,#self.text do
      love.graphics.setColor(1,1,1)
      love.graphics.print(self.text[#self.text - (i-1)],self.x +10,self.y + i * 15 + self.box._y)
    end
        
    --ドローコールやfpsを表示させる
    draw_status(self.x + self.width-70,self.y+15)

    --ObjectTableの要素数
    local O = 0
    local count = 0
    for i,v in pairs(ObjectTable) do
      love.graphics.setColor(1,1,1)
      g.print(v.name,self.x + self.width-100,self.y + 120 + count*10)
      
      count = count + 1
      O = O + 1
    end

    g.print("Object : " .. O,self.x + self.width-100,self.y + 70)

    love.graphics.setColor(0.4,0.4,0.4,0.4)
    love.graphics.setScissor()

    --windowリサイズボックス
    if self.resize == true then love.graphics.setColor(0.4,0.4,0.4,0.4)
    else love.graphics.setColor(0.4,0.4,0.4,0.4) end
    love.graphics.rectangle("fill", self.x+self.width, self.y+self.height, 10,10)
    love.graphics.setColor(1,1,1,1)
  end;

  print = function(self,...)
    self.move:reset()
    local n = {...}
    local str = ""
    for i,v in pairs(n) do
      if type(str) ~= "nil" then
        str = str .. "  " .. table.tostring(v)
      else
        str = str .. "  " .. "error:nil"
      end
    end
    self.text[#self.text+1] = str

    while #self.text > 20 do
      table.remove(self.text, 1)
    end
  end;
}

function draw_status(x,y)
  local stats = g.getStats()
  local str = string.format("draw: %.2f B", stats.drawcalls)
  local str2 = string.format("tm: %.2f MB", stats.texturememory/(1024*1024))
  local x ,y = x , y
  g.setColor(255,255,255)
  love.graphics.print('M: ' .. math.floor(collectgarbage('count')/1024*1000)/1000, x,y)
  love.graphics.print("FPS: "..tostring(math.floor(1/love.timer.getDelta())), x, y + 20)
  love.graphics.print(str, x , y + 40)
  love.graphics.print(str2,x , y + 70)
end
