--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}
StaticObjectTable = {}

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
        self.c_scene:draw()
        self.c_scene:drawGUI()
    end;
}

Scene ={
    new = function()
        local obj = instance(Scene)
        obj.frame = 0
        obj.name = "dummy";
        ---camera
        obj.camTable = {}
        obj.maincam = gamera.new(0,0,W,H)
        table.insert(obj.camTable,obj.maincam)

        --使ってない
        obj.table = {}
        return obj
    end;

    update = function(self,dt)

        for i,v in ipairs(StaticObjectTable) do
            v:update()
        end
        for i,v in ipairs(ObjectTable) do
            v:update()
        end
        self.frame = self.frame + 1
    end;

    draw = function(self)
      for j,c in ipairs(self.camTable) do
        c:draw(function(l,t,w,h)
          for i,v in ipairs(StaticObjectTable) do
              v:draw()
          end
          for i,v in ipairs(ObjectTable) do
              v:draw()
          end
        end)
      end
    end;

    drawGUI = function(self)
        for i,v in ipairs(StaticObjectTable) do
            if v.drawGUI ~= nil then
              v:drawGUI()
            end
        end
        for i,v in ipairs(ObjectTable) do
            if v.drawGUI ~= nil then
              v:drawGUI()
            end
        end
    end;
}

---以下はSceneManagerに命令を送る
Scene.changeScene = function(scene)
    for i,v in ripairs(ObjectTable) do
        v:destroy()
    end
    SceneManager.c_scene = scene.new()
    local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
end;

Scene.add = function(obj)
  table.insert(ObjectTable,obj)
end;
