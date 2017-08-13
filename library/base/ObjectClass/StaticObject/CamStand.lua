CamStand = {
  new = function(cam)
    local obj = instance(CamStand,StaticObject)
    obj.camera = cam
    obj.focus = nil
    obj.pos = Vector.new(0,0)
    obj.effect = {}
    obj.status = Enum:new{"NOONE","FOCUS","MOVETO","FOCUS_SEQ"}
    obj.status_now = obj.status.FOCUS

    --moveTo
    obj.tw = {x = 0,y = 0}
    obj.tween = tween.new(1.0,obj.tw, {x = 0,y = 0}, tween.easing.outSin)
    obj.moveTo_finish = false

    --focus_seq
    obj.vpos = Vector.new(0,0)
    obj.speed = 1
    obj.maxspeed = 1
    return obj
  end;
  update = function(self,dt)

    local switch = {}
    switch[self.status.NOONE] = function()
      --何もしない
    end
    --focusの座標にゆっくり近づく
    switch[self.status.FOCUS_SEQ] = function()
      if self.focus ~= nil then
        if self.focus.pos == nil then error("obj must have pos") end
        local destination = Vector.new(self.focus.pos.x,self.focus.pos.y)
        local distance = destination - self.pos

        ---暫定ゲイン
        local gain = 1/5
        local apos = distance*gain*self.speed

        ---加速度加算
        local vpos = self.vpos + apos

        --規定スピードを超える場合distance基準に
        if vpos:len() > self.maxspeed*gain then
          self.vpos = distance/10*self.speed
        else
          self.vpos = vpos
        end

        if self.vpos:len() < 0.01 then
          self.vpos = self.vpos * 0
          self.pos = destination
        end
        ---
        self.pos = self.pos + self.vpos
        if self.focus.kill ==true then self.focus = nil end
      end
    end
    --focusの座標にカメラを合わせる
    switch[self.status.FOCUS] = function()
      if self.focus ~= nil then
        if self.focus.pos == nil then error("obj must have pos") end
        self.pos = Vector.new(self.focus.pos.x,self.focus.pos.y)
        if self.focus.kill ==true then self.focus = nil end
      end
    end
    --指定座標にtweenする。
    switch[self.status.MOVETO] = function()
      local finish = self.tween:update(dt)
      self.pos = Vector.new(self.tw.x,self.tw.y)
      if finish then self.moveTo_finish = true end
    end
    switch[self.status_now]()

    self.camera:setPosition(self.pos.x,self.pos.y)

    --effect
    for k,v in pairs(self.effect) do
      v:update(dt)
    end

  end;
  drawGUI = function(self)
    for k,v in pairs(self.effect) do
      v:drawGUI()
    end
    --debug時に状態表示
    if DEBUG then
      local name = self.focus and self.focus.name or "nil"
      g.print("camera " .. "x:" .. math.ceil(self.camera.x*10)/10 .. " " .. " y:" .. math.ceil(self.camera.y*10)/10,g_x + 10,g_y + H -30)
      g.print("focus : " .. name .. " status:" .. self.status_now,g_x + 10,g_y + H - 20)
    end
  end;

  --カメラをx,yに
  setPos = function(self,x,y)
    self.pos = Vector.new(x,y)
  end;
  --focusをセットする
  setfocus = function(self,obj)
    self.focus = obj
  end;
  --focusをnilに
  resetfocus = function(self)
    ---シーンの変更後は必ず呼ばれる
    self.focus = nil
  end;
  --focusを初期化、座標を初期値に、NOONEに
  init = function(self)
    self:resetfocus()
    self.pos = Vector.new(0,0)
    self.status_now = self.status.NOONE
  end;
  getStatus = function(self)
    return self.status_now
  end;


  --------------------statusを変更する--------------------
  --MOVETOに設定して移動
  moveTo = function(self,_x,_y,time,_type)
    debugger:print("MOVETOカメラ移動".. _x .. "," .. _y)
    self.status_now = self.status.MOVETO
    self.moveTo_finish = false
    self.tw.x = self.pos.x
    self.tw.y = self.pos.y

    local type = tween.easing.outSin or _type
    self.tween = tween.new(time,self.tw, {x = _x,y = _y},type)
  end;

  --FOCUSに設定
  moveFocus = function(self)
    debugger:print("FOCUSカメラ移動")
    self.status_now = self.status.FOCUS
  end;

  --FOCUS_SEQに設定
  moveFocusSeq = function(self,speed,maxspeed)
    self.speed = speed or 1
    self.maxspeed = maxspeed or 1
    debugger:print("FOCUS_SEQカメラ移動")
    self.vpos = Vector.new(0,0)
    self.status_now = self.status.FOCUS_SEQ
  end;

  ------------------------------effect----------------------------------
  shake = function(self,time,dx,dy)
    C_Shake.new(self,time,dx,dy)
  end;
  flashLight = function(self,time)
    C_FlashLight.new(self,time)
  end;
}

--[[
  カメラエフェクト
  C_からはじめる
]]

CameraEffect = {
  new = function(p,time)
    local obj = instance(CameraEffect)
    obj.p = p
    obj.id = makeid(obj.p.effect)
    p.effect[obj.id] = obj
    obj.time = time
    obj.frame = 0
    obj.time = time
    obj.kill = false
    return obj
  end;
  update = function(self,dt)
  end;
  drawGUI = function(self)
  end;
  count = function(self)
    self.frame = self.frame + 1
    if self.frame > self.time then self.kill = true end
    if self.kill == true then self.p.effect[self.id] = nil end
  end
};

C_Shake = {
  new = function(p,time,dx,dy)
    local obj = instance(C_Shake,CameraEffect,p,time)
    obj.dx = dx
    obj.dy = dy
    return obj
  end;
  update = function(self,dt)
    self.p.pos = Vector.new(self.p.camera.x,self.p.camera.y) + Vector.new(math.random(-self.dx,self.dy),math.random(-self.dx,self.dy))
    self.p.camera.x,self.p.camera.y = self.p.pos.x,self.p.pos.y
    self:count()
  end;
};

C_FlashLight = {
  new = function(p,time)
    local obj = instance(C_FlashLight,CameraEffect,p,time)
    return obj
  end;
  update  = function(self)
    self:count()
  end;
  drawGUI = function(self)
    g.rectangle("fill",g_x,g_y,W,H)
  end;
};
