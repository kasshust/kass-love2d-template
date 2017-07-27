--[[
  gameraを制御する

  update object -> staticobject

  (self.pos)
    ↓
  focus
  effect
    ↓

]]--
CamStand = {
  new = function(cam)
    local obj = instance(CamStand,StaticObject)
    obj.camera = cam
    obj.focus = nil
    obj.pos = Vector.new(0,0)
    obj.effect = {}
    return obj
  end;
  update = function(self,dt)

    --フォーカス特定
    if self.focus ~= nil then
      if self.focus.pos == nil then error("obj must have pos") end
      self.pos = Vector.new(self.focus.pos.x,self.focus.pos.y)
    end
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
  end;
  shake = function(self)
  end;
  setfocus = function(self,obj)
    self.focus = obj
  end;
  resetfocus = function(self)
    ---シーンの変更後は必ず呼ばれる
    self.focus = nil
    self.camera:setPosition(0,0)
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
