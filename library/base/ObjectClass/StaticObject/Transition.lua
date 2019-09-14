
--[[
  シーン遷移,種類,room,propertyを与えることができうＲ
]]
function trans(class,room,property)
  addS(class.new(room,property))
end

--[[
  トランジションの仮想クラス 直接呼ばないでね
  アニメーションにはself.tw.frame (0~1)を用いる
]]

Transition = {
    c_transition = nil;
    new = function(room,property,time1,time2,type1,type2)
        local obj = instance(Transition,StaticObject)
        obj.name = "基本遷移オブジェクト"
        obj.toRoom = room
        obj.status = Enum:new{"IN","OUT"};
        obj.status_now = obj.status.IN
        --各シーンにpropertyを送る
        obj.property = property
        --tween用
        obj.time1 = time1 or 1
        obj.time2 = time2 or 1
        obj.type1 = type1 or tween.easing.outBounce
        obj.type2 = type2 or tween.easing.outBounce
        obj.tw = {frame = 0}
        obj.tween = tween.new(obj.time1,obj.tw, {frame = 1}, obj.type1)
        return obj
    end;
    update = function(self,dt)
        --現在稼働中
        --すでに他が遷移中ならkill　そうでないなら登録
        if Transition.c_transition == nil or Transition.c_transition == self then
          --継続
          Transition.c_transition = self
        else
          self.kill = true
          debugger:print("すでにシーンの遷移中です。次フレームでこのトランジションを削除します")
        end

        local switch={}
        switch[self.status.IN]=function()
          local finish = self.tween:update(dt)
          if finish then
            SceneManager.changeScene(self.toRoom,self.property)
            self.status_now = self.status.OUT
            self.tween = tween.new(self.time2,self.tw, {frame = 0}, self.type2)
          end
        end
        switch[self.status.OUT]=function()
          local finish = self.tween:update(dt)
          if finish then
            self.kill = true
            Transition.c_transition = nil
          end
        end
        switch[self.status_now]()
    end;
    drawGUI = function(self)
      local switch={}
      switch[self.status.IN]=function()
        self:drawIN()
      end
      switch[self.status.OUT]=function()
        self:drawOUT();
      end
      switch[self.status_now]()
      g.setColor(255,255,255)
    end;
    transition = function(room,class)
        if class == nil then addS(Transition.new(room))
        else addS(class.new(room)) end
    end;

    -------上書き----------
    drawIN = function(self)
      local t = self.tw.frame
      g.setColor(16,16,32,t*255)
      love.graphics.rectangle("fill", g_x+W/2*(1-t), g_y+H/2*(1-t),W*t,H*t)
      g.setColor(0,0,0,255)
    end;

    drawOUT = function(self)
      local t = self.tw.frame
      g.setColor(16,16,32,t*255)
      love.graphics.rectangle("fill", g_x+W/2*(1-t), g_y+H/2*(1-t),W*t,H*t)
      g.setColor(0,0,0,255)
    end;
}

--トランジション例 時間、演出を作る
T_normal = {
  new = function(room,property)
    local obj = instance(T_normal,Transition,room,property,1,1,tween.easing.inSine,tween.easing.inSine)
    obj.size = W/16 
    return obj
  end;
  drawIN = function(self)
    local t = self.tw.frame
    g.setColor(0,0,0)
    for j = 0,H/self.size do
      for i = 0,W/self.size do
        g.setColor(0,0,0)
        if t < 0.5 then
          if (i+j) % 2 == 0 then
            local scale = math.clamp( ((W + H) * self.size)/( i + j ) * t,0,self.size)
             g.rectangle("fill",g_x + i*self.size,g_y + j*self.size,scale,self.size)
          end
        else
          local scale = math.clamp( ((W + H) * self.size)/( i + j ) * t,0,self.size)
          if (i+j) % 2 == 0 then g.rectangle("fill",g_x + i*self.size,g_y + j*self.size,self.size,self.size) end
          if (i+j) % 2 == 1 then g.rectangle("fill",g_x + i*self.size,g_y + j*self.size,scale,self.size) end
        end
      end
    end
  end;
  drawOUT = function(self)
    local t = self.tw.frame
    g.setColor(0,0,0)
    for j = 0,H/self.size do
      for i = 0,W/self.size do
        if t < 0.5 then
          if (i+j) % 2 == 1 then g.rectangle("fill",g_x + i*self.size,g_y + j*self.size,self.size*t*2,self.size) end
        else
          if (i+j) % 2 == 1 then g.rectangle("fill",g_x + i*self.size,g_y + j*self.size,self.size,self.size) end
          if (i+j) % 2 == 0 then g.rectangle("fill",g_x + (i+1)*self.size,g_y + j*self.size,-self.size*2*(t-0.5),self.size) end
        end
      end
    end
    g.setColor(1,1,1,1)
  end;
};
