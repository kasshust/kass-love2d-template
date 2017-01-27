--シーン内で毎フレーム処理させるインスタンスはここにぶっこむ
ObjectTable = {}

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
        obj.table = {}
        return obj
    end;

    update = function(self,dt)
        for i,v in ipairs(ObjectTable) do
            v:update()
        end
        self.frame = self.frame + 1
    end;

    draw = function(self)
        for i,v in ipairs(ObjectTable) do
            v:draw()
        end
    end;

    drawGUI = function(self)
        for i,v in ipairs(ObjectTable) do
            if v.drawGUI ~= nil then
                v:drawGUI()
            end
        end
    end;
}

---以下はSceneManagerに命令を送る
changeScene = function(scene)
    for i,v in ipairs(ObjectTable) do
        v:destroy()
    end
    SceneManager.c_scene = scene.new()
    print("ChangeScene! : " .. " -> " .. SceneManager.c_scene.name)
end;