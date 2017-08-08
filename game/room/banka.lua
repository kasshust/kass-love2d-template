
--map情報を記述
BankaMap = {
  debug1 = {map = "game/materials/stages/test/test.lua",name = "デバッグ1",music = "game/materials/sound//music/gunctrl_-_07_-_Dactylic_Hexameter.mp3"},
  debug2 = {map = "game/materials/stages/test/test2.lua",name = "デバッグ2",music = "game/materials/sound//music/Nctrnm_-_Pull.mp3"},
  debug3 = {map = "game/materials/stages/test/test3.lua",name = "デバッグ3",music = nil},
}

--Title
Title = {}


--trans? manager.game.player = nil このゲーム用のtrans

--ゲーム内ルーム
BankaRoom = {
  new = function(property)
    local obj = instance(BankaRoom,Scene,property)
    obj.frame = 0

    if property == nil then error("This bankaroom is invalid") end
    obj.name = property["name"]

    --BGM
    if property["music"] ~= nil then
      obj.m = love.audio.newSource(property["music"], "stream")
      soundmanager:playMusic(obj.m)
    else
      love.audio.stop()
    end

    obj.pause = false ---objectのupdateを停止する 使ってない
    obj.bg = {} ----ばっぐぐらうんど　canvasを作成して  登録、drawで表示


    --------------マップ作成
    obj.map = sti(property.map, {})
    obj.size = {width = obj.map.width*16,height = obj.map.height*16}
    maincam:setWorld(0,0,obj.size.width,obj.size.height)


        obj:create(obj.map.layers.block,function(o)
          Block.new(o.x,o.y,o.width,o.height)
        end)
        obj:create(obj.map.layers.floor,function(o)
          Floor.new(o.x,o.y,o.width,4)
        end)
        obj:create(obj.map.layers.slope,function(o)
          Slope.new(o.polygon)
        end)
        obj:create(obj.map.layers.text,function(o)
          local text = split(o.properties["text"],":")
          TouchWindow.new(text,o.x,o.y)
        end)
        obj:create(obj.map.layers.event,function(o)
          TouchEvent.new(text,o.x,o.y)
        end)

        --propertyで判定する？
        obj:create(obj.map.layers.door,function(o)
          TouchDoor.new(o.x,o.y,o.properties["room"],o.properties["num"])
          if manager.game.player.num == o.name then
            --managerのプレイヤーを上書き
            manager.game.test = TestPlayer.new(o.x + 8,o.y + 8)
            return true
          end
        end)

          local player = manager.game.test
          eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) player.operation = false obj.kill = true end end))
          eventmanager:add(E_CamMoveTo.new(player.pos.x + 32,player.pos.y,1))
          eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) camStand:shake(10,3,3) player.vpos.x = 3 obj.kill = true end end))
          eventmanager:add(TestEvent.new())
          eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) camStand:shake(10,3,3) player.vpos.y = -3 obj.kill = true end end))
          eventmanager:add(E_CamMoveTo.new(player.pos.x + 64,player.pos.y,1))
          eventmanager:add(TestEvent.new())
          eventmanager:add(E_CamMoveTo.new(player.pos.x + 32,player.pos.y+32,1))
          eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) camStand:shake(10,3,3) player.dir.x = -1 obj.kill = true end end))
          eventmanager:add(E_CamMoveTo.new(player.pos.x,player.pos.y+32,1))
          eventmanager:add(E_CamMoveFocusSeq.new(0.2))
          eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) player.operation = true obj.kill = true end end))
    return obj
  end;
  update = function(self,dt)
    self:staticObjectUpdate(dt)
    if not self.pause then self:objectUpdate(dt) end
    self.frame = self.frame + 1
  end;
  draw = function(self)
    --背景
    if self.map.layers["bg"] ~= nil then
      self.map.layers["bg"].x ,self.map.layers["bg"].y  = maincam.x/4,maincam.y/4
      self.map.layers["bg"]:draw()
    end
    --オブジェクト
    self:objectDraw();
    --タイル
    if self.map ~= nil then self.map:draw() end
    --背景
  end;
  drawGUI = function(self)
    self:objectDrawGUI()
  end;

  --override
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
      if dis < 300 or v.persist == true then table.insert(t,v) end
    end

    table.sort(t,function(a,b)
    return (a.depth > b.depth)end )

    for i,v in pairs(t) do
      v:draw()
    end
  end;
  create = function(self,var,f)
    if var ~= nil then
      for k ,o in pairs(var.objects) do
        f(o)
      end
    end
  end;
}

-------------------------------------------------------------------------------------------------------------
----PreRoom----　初期化用ルーム
PreRoom = {
  new = function(property)
    local obj = instance(PreRoom,OtherRoom,property)
    --このゲームのマネージャーを登録
    manager:apply(Manager_banka.new())

    -------初期設定--------------------------------
    --標準フォント設定
    font = love.graphics.newFont( "game/materials/fonts/PixelMplus12-Regular.ttf" , 12 )
    font:setFilter( "nearest", "nearest", 1 )
    love.graphics.setFont(font);

    --スプライトシートの読み込み(ゲーム別)
    img_test = load_image("game/materials/images/test/sprite_test.png")
    weap_test = load_image("game/materials/images/test/weapon_test.png")
    if(DEBUG) then trans(T_normal,DebugRoom,{})end
    return obj
  end;
  u = function(self,dt)
    --なんかムービーとかロゴとか
  end;
  dg = function(self)
     g.print("なんかロゴとか",0,H/2)
  end;
}

----debug
DebugRoom = {
  new = function(property)
    local obj = instance(DebugRoom,OtherRoom,property)
    obj.frame = 0
    obj.name = "banka"
    obj.s = Select.new(1,5)
    obj.tw = {num = 1}
    obj.tween = tween.new(0.1,obj.tw, {num = obj.s.now}, tween.easing.outBounce)
    obj.picture = load_image("game/materials/images/test/sprite_test2.png")
    return obj
  end;
  u = function(self,dt)
    local bool2 = self.s:check()
    if bool2 then
      self.tween = tween.new(0.1,self.tw, {num = self.s.now}, tween.easing.outBounce)
      soundmanager:play("game/materials/sound/se/se_test.wav")
    end

    local bool =  controller.wasPressed("a")

    if bool then
      local switch = {}
      switch[1] = function()
        trans(T_normal,BankaRoom,BankaMap["debug1"])
      end
      switch[2] = function()
        trans(T_normal,BankaRoom,BankaMap["debug2"])
      end
      switch[3] = function()
        trans(T_normal,BankaRoom,BankaMap["debug3"])
      end
      switch[4] = function()
      end
      switch[5] = function()
      end
      switch[self.s.now]()
    end
    self.tween:update(dt)
  end;
  d = function(self)
  end;
  dg = function(self)
    ---背景
    g.setColor(32,32,48)
    g.rectangle("fill",0,0,W,H)
    g.setColor(255,255,255)

    g.draw(self.picture,32,0,0,2,2)

    local t = "Banka"
    g.printf(t,W - 130,H-20,200,"left")

    ---text
    local text = {"Metorovania1","Metorovania2","c","d","e"}
    local explain = {"Room1へ","Room2へ","なし","無し","梨"}

    local x,y,dif = 100,120,18
    local wi_x,wi_y = x-30,y-16
    g.setColor(0,0,0)
    g.rectangle("fill",wi_x,wi_y,200,48)
    g.setColor(255,255,255)
    g.rectangle("line",wi_x,wi_y,200,48)
    g.print(explain[self.s.now],wi_x,y-30)
    love.graphics.cut(wi_x,wi_y,200,48,function()
      for i,v in pairs(text) do
        g.print(v,x,y + (-self.tw.num+i) * dif,0,1 - 0.3*math.abs((i-self.tw.num)), 1 - 0.3*math.abs((i-self.tw.num)))
      end
      g.print("→",x-20,y)
    end)

  end;
}
