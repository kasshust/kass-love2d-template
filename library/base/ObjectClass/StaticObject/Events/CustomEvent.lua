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
