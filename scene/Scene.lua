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
      if scene == nil then error("scene is nil! Please specify scene") end
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
      camStand:init()

      --シーン変更
      SceneManager.c_scene = nil
      SceneManager.c_scene = scene.new()
      local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
      debugger:print(str ..":")
      collectgarbage("collect")
    end;
}

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
    --ここに各ルームの処理
  end;
  draw = function(self)
    --ここに各ルームの処理
  end;
  drawGUI = function(self)
    --ここに各ルームの処理
  end;
  staticObjectUpdate = function(self,dt)
    for i,v in ipairs(StaticObjectTable) do
      v:update(dt)
    end
    for i,v in pairs(StaticObjectTable) do
      if v.kill == true then v:destroy() end
    end
  end;

  objectUpdate = function(self,dt)
    --オブジェクトのupdate
    for i,v in pairs(ObjectTable) do
      v:update(dt)
    end
    --オブジェクトの削除判定
    for i,v in pairs(ObjectTable) do
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
      if dis < 200 then table.insert(t,v) end
    end

    table.sort(t,function(a,b)
		return (a.depth > b.depth)end )

    for i,v in pairs(t) do
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
    obj.pause = false ---objectのupdateを停止する
    obj.bg = {} ----ばっぐぐらうんど　canvasを作成して  登録、drawで表示
    return obj
  end;
  update = function(self,dt)
    self:staticObjectUpdate(dt)
    if not self.pause then self:objectUpdate(dt) end
    self.frame = self.frame + 1
  end;
  draw = function(self)
    --背景

    --タイル
    if self.map ~= nil then self.map:draw() end
    --オブジェクト
    self:objectDraw();
    --タイル
    --if self.map ~= nil then self.map:draw() end
    --背景
  end;
  drawGUI = function(self)
    self:objectDrawGUI()
  end;
}
------------------------ルームに処理を打ち込める-----------------------
OtherRoom = {
  new = function()
    local obj = instance(OtherRoom,Scene)
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
