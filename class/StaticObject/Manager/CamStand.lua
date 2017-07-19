--[[
  gameraを制御する
]]--
CamStand = {
  new = function(cam)
    local obj = instance(CamStand,StaticObject)
    obj.camera = cam
    obj.focus = nil
    return obj
  end;
  update = function(self,dt)
    if self.focus ~= nil then
      if self.focus.pos == nil then error("obj must have pos") end
      self.camera:setPosition(self.focus.pos.x,self.focus.pos.y)
    else
      self.focus = nil
      self.camera:setPosition(0,0)
    end
  end;
  setfocus = function(self,obj)
    self.focus = obj
    --[[
    ここで登録したobjがdestroy後も消えてない
    ]]
  end;
  resetfocus = function(self)
    self.focus = nil
  end;
}
