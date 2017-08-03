------------------------ルームに処理を打ち込める-----------------------
OtherRoom = {
  new = function()
    local obj = instance(OtherRoom,Scene,property)
    obj.frame = 0
    obj.name = "other"
    return obj
  end;
  update = function(self,dt)
    self:u(dt)
    self:staticObjectUpdate(dt)
    self:objectUpdate(dt)
  end;
  draw = function(self)
    self:d()
    self:objectDraw();
  end;
  drawGUI = function(self)
    self:dg()
    self:objectDrawGUI()
  end;

  --ルーム記述用
  u = function(self,dt)
  end;
  d = function(self)
  end;
  dg = function(self)
  end;
}
