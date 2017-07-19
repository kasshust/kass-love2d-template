---Scene(Room)の制御
SceneManager = {
    c_scene = nil;
    new = function(self,scene)
        local obj = instance(SceneManager)
        self.c_scene = scene
        return obj
    end;
    update = function(self,dt)
        ---update処理
        self.c_scene:update(dt)
    end;
    draw = function(self)
      maincam:draw(function(t,l,w,h)
        self.c_scene:draw()
        local x,y = maincam:getPosition()
        g_x,g_y = x-W/2,y-H/2
        self.c_scene:drawGUI()
      end)
    end;
}

---roomの親クラス
Scene ={
    new = function()
        local obj = instance(Scene)
        obj.frame = 0
        obj.name = "dummy";
        ---status
        obj.status = Enum:new{"NOONE","TRANSITION"};
        obj.status_now = obj.status.NOONE
        return obj
    end;

    update = function(self,dt)
      local switch={}
      switch[self.status.NOONE]=function()
        self:objectUpdate(dt)
      end
      switch[self.status.TRANSITION]=function()
      end
      switch[self.status_now]()
      self.frame = self.frame + 1
    end;
    draw = function(self)
      self:objectDraw();
    end;
    drawGUI = function(self)
      self:objectDrawGUI()
    end;
    objectUpdate = function(self,dt)
      for i,v in ipairs(StaticObjectTable) do
          v:update(dt)
      end
      for i,v in ipairs(ObjectTable) do
          v:update(dt)
      end
    end;
    objectDraw = function(self)
      for i,v in ipairs(StaticObjectTable) do
          v:draw()
      end
      for i,v in ipairs(ObjectTable) do
          v:draw()
      end
    end;
    objectDrawGUI = function(self)
      for i,v in ipairs(StaticObjectTable) do
          v:drawGUI()
      end
      for i,v in ipairs(ObjectTable) do
          v:drawGUI()
      end
    end;
}

---以下はSceneManagerに命令を送る
SceneManager.changeScene = function(scene)
    ObjectTable = nil
    ObjectTable = {}
    for i,v in ipairs(SearchTable)do
        v.table = nil
        v.table = {}
    end
    HC.resetHash()
    collectgarbage("collect")

    --シーン変更
    SceneManager.c_scene = nil
    SceneManager.c_scene = scene.new()
    local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
    debugger:print(str ..":" .. #ObjectTable)
end;

add = function(obj)
  table.insert(ObjectTable,obj)
  table.sort(ObjectTable,
    function (a,b) return a.depth > b.depth end
  )
end;

addS = function(obj)
  table.insert(StaticObjectTable,obj)
end;
