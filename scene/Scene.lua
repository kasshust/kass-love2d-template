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
        self.c_scene:drawGUI()
      end)
    end;
    changeScene = function(scene)
      --各table初期化
      ObjectTable = nil
      ObjectTable = {}
      for i,v in ipairs(SearchTable)do
          v.table = nil
          v.table = {}
      end
      HC.resetHash()
      collider:resetHash()

      --camstandのfocusをリセット focus対象のオブジェクトは破棄されないから残ってしまう
      camStand:resetfocus()

      --シーン変更
      SceneManager.c_scene = nil
      SceneManager.c_scene = scene.new()
      local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
      debugger:print(str ..":")
      collectgarbage("collect")
    end;
}

addS = function(obj)
  table.insert(StaticObjectTable,obj)
end;

-----------------------roomの親クラス-------------------
Scene ={
  new = function()
    local obj = instance(Scene)
    obj.frame = 0
    obj.name = "Scene";
    obj.size = {width = W,height = H}
    --maincam-worldをステージの大きさに合わせる(自動でバウンダリーが設定される)
    maincam:setWorld(0,0,obj.size.width,obj.size.height)
    return obj
  end;
  update = function(self,dt)
  end;
  draw = function(self)
  end;
  drawGUI = function(self)
  end;

  objectUpdate = function(self,dt)
    for i,v in ipairs(StaticObjectTable) do
      v:update(dt)
    end
    for i,v in pairs(ObjectTable) do
      v:update(dt)
    end
  end;
  objectDraw = function(self)
    for i,v in ipairs(StaticObjectTable) do
      v:draw()
    end
    for i,v in pairs(ObjectTable) do
      v:draw()
    end
  end;
  objectDrawGUI = function(self)
    for i,v in pairs(ObjectTable) do
      v:drawGUI()
    end
    for i,v in ipairs(StaticObjectTable) do
      v:drawGUI()
    end
  end;
}
------------------------メトロヴァニア用-------------------
MeRoom = {
  new = function()
    local obj = instance(MeRoom,Scene)
    obj.frame = 0
    obj.name = "メトロヴァニア"
    return obj
  end;
  update = function(self,dt)
    self:objectUpdate(dt)
    self.frame = self.frame + 1
  end;
  draw = function(self)
    --背景
    --タイル
    if self.map ~= nil then self.map:draw() end
    --オブジェクト
    self:objectDraw();
  end;
  drawGUI = function(self)
    self:objectDrawGUI()
  end;
}
------------------------テスト用-----------------------
OtherRoom = {
  new = function()
    local obj = instance(OtherRoom,Scene)
    obj.frame = 0
    obj.name = "other"
    return obj
  end;
  update = function(self,dt)
    self:u(dt)
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

  u = function(self,dt)
  end;
  d = function(self)
  end;
  dg = function(self)
  end;
}
