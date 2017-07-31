StaticObject = {
  new = function()
      local obj = instance(StaticObject)
      obj.name = "StaticObject"
      obj.kill = false
      return obj
  end;
  update = function(self,dt)
  end;
  draw = function(self)
  end;
  drawGUI = function(self)
  end;
  destroy = function(self)
    removeFromTable(self,StaticObjectTable)
    debugger:print("Static削除:" .. self.name)
  end;
}

addS = function(obj)
  table.insert(StaticObjectTable,obj)
end
