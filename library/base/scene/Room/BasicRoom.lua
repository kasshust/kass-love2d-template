BasicRoom = {
    new = function(property)
      local obj = instance(BasicRoom,Scene,property)
      obj.frame = 0
      obj.name = "ベーシック"
      obj.pause = false ---objectのupdateを停止する
      obj.m_drawDistance = 600
      return obj
    end;
    update = function(self,dt)
      self:staticObjectUpdate(dt)
      if not self.pause then self:objectUpdate(dt) end
      self.frame = self.frame + 1
    end;
    draw = function(self)
      --オブジェクト
      self:objectDraw();
    end;
    drawGUI = function(self)
      self:objectDrawGUI()
    end;
    objectUpdate = function(self,dt)
      --オブジェクトのupdate
      for i,v in pairs(ObjectTable) do
        local dis = (math.pow(maincam.x - v.pos.x,2) + math.pow(maincam.y - v.pos.y,2) )^0.5
        --if dis < 400 or v.persist == true then
          v:update(dt)
        --end
        if v.kill == true then v:destroy() end
      end
    end;
    objectDraw = function(self)
      for i,v in ipairs(StaticObjectTable) do
        v:draw()
      end
  

      local t = {}
      for i,v in pairs(ObjectTable) do
         local dis = (math.pow(maincam.x - v.pos.x,2) + math.pow(maincam.y - v.pos.y,2) )^0.5
        if dis < self.m_drawDistance or v.persist == true or v.allvisible == true then table.insert(t,v) end
      end
  
      table.sort(t,function(a,b)
      return (a.depth > b.depth)end )
  
      for i,v in pairs(t) do
        v:draw()
      end
    end;
  }
  