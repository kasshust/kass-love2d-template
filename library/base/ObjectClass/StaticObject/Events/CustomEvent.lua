--[[
  CustomEvent　たぶんなんでもできる！
]]
CustomEvent = {
  new = function(f)
    local obj = instance(CustomEvent,Event)
    obj.name = "custom event"
    f(obj)
    return obj
  end;
}

CustomEventInit = {
  new = function(f)
    local obj = instance(CustomEventInit,Event)
    obj.name = "init event"
    obj.f = f
    return obj
  end;
  init = function(self)
    g_debugger:print("---E:CustomEventInit:発火")
    self:f()
    self.kill = true
  end;
}
