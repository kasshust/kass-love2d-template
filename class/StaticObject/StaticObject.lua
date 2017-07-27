StaticObject = {
  new = function(x,y)
      local obj = instance(StaticObject)
      table.insert(StaticObjectTable,obj)
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
  end;
}
