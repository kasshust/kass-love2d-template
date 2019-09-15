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
      g_maincam:draw(function(t,l,w,h)
        self.c_scene:draw()
      end)
      g_maincam:drawGUI(function(t,l,w,h)
        self.c_scene:drawGUI()
      end)
    end;
    init = function(self)
      --各table初期化
      ObjectTable = nil
      ObjectTable = {}

      g_entityManager:init()

      --HC空間の初期化
      HC.resetHash()
      --camStandの初期化
      g_camStand:init()
    end;
    changeScene = function(scene,property)
      --例外
      if scene == nil then error("scene is nil! Please specify this scene") end
      --シーン初期化
      SceneManager.init()
      --シーン変更
      SceneManager.c_scene:destroy()
      SceneManager.c_scene = nil
      SceneManager.c_scene = scene.new(property)
      local str = "ChangeScene! : " .. " -> " .. SceneManager.c_scene.name
      g_debugger:print(str ..":")
    end;
}

-----------------------roomの親クラス-------------------
Scene ={
  new = function(property)
    local obj = instance(Scene)
    obj.property = property

    obj.frame = 0
    obj.name = "Scene";
    obj.pause = false
    obj.size = {width = W,height = H}
    --g_maincam-worldをステージの大きさに合わせる(自動でバウンダリーが設定される)
    g_maincam:setWorld(0,0,obj.size.width,obj.size.height)
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
  --必要ならオーバーライドで書き換えて
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
      if v.kill == true then v:destroy() end
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
    for i,v in pairs(StaticObjectTable) do
      v:drawGUI()
    end
  end;

  -- ルーム破棄時の処理
  destroy = function(self)
  end;
}
