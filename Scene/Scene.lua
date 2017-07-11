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
      maincam:draw(function(t,l,w,h)
        self.c_scene:draw()
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
        --使ってない
        --obj.table = {}
        return obj
    end;

    update = function(self,dt)
      local switch={}
      switch[self.status.NOONE]=function()
        for i,v in ipairs(StaticObjectTable) do
            v:update()
        end
        for i,v in ipairs(ObjectTable) do
            v:update()
        end
      end
      switch[self.status.TRANSITION]=function()

      end
        switch[self.status_now]()
        self.frame = self.frame + 1
    end;

    draw = function(self)
        for i,v in ipairs(StaticObjectTable) do
            v:draw()
        end
        for i,v in ipairs(ObjectTable) do
            v:draw()
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
SceneManager.changeScene = function(scene)
    for i,v in ripairs(ObjectTable) do
        v:destroy()
    end
    SceneManager.c_scene = scene.new()
    local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
    debugger:print(str ..":" .. #ObjectTable)
end;

add = function(obj)
  table.insert(ObjectTable,obj)
end;

addS = function(obj)
  table.insert(StaticObjectTable,obj)
end;
