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
      print(k,v)
      v:update(dt)
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
  shake = function(self,dx,dy,time)
    Shake.new(self,dx,dy,time)
  end;
}

Shake = {
  new = function(p,dx,dy,time)
    local obj = instance(Shake)
    obj.p = p
    obj.id = makeid(obj.p.effect)
    p.effect[obj.id] = obj
    obj.time = time
    obj.frame = 0
    obj.dx = dx
    obj.dy = dy
    obj.frame = 0
    obj.kill = false
    return obj
  end;
  update = function(self,dt)
    self.p.pos = Vector.new(self.p.camera.x,self.p.camera.y) + Vector.new(math.random(-self.dx,self.dy),math.random(-self.dx,self.dy))
    self.p.camera.x,self.p.camera.y = self.p.pos.x,self.p.pos.y

    self.frame = self.frame + 1
    if self.frame > self.time then self.kill = true end
    if self.kill == true then self.p.effect[self.id] = nil end
  end;
};
