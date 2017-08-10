---ゲーム作成 manager経由で取得してね
Manager_banka = {
  new = function()
    local obj = instance(Manager_banka,GameManager)

    --生成用
    obj.player = {num = "2",status = nil,dir = 1}
    obj.test = nil

    return obj
  end;
  update = function(self,dt)

    if love.keyboard.wasPressed("r") then
      trans(T_normal,SceneManager.c_scene,SceneManager.c_scene.property)
    end
  end;
  draw = function()end;
  drawGUI = function()end;

  --save load
  save = function(self)
    love.filesystem.write("banka.lua",Tserial.pack(savedata))
  end;
  save_init = function(self)
    savedata = {}
    --savedataの構造
    savedata[1] = {clear = 1}
    savedata[2] = {clear = 2}
    savedata[3] = {clear = 3}

    love.filesystem.write("banka.lua",Tserial.pack(savedata))
    return savedata
  end;
  load = function(self)
    savedata = {}
    if not love.filesystem.exists("banka.lua") then
      savedata = Manager.save_init()
    else
      savedata = Tserial.unpack(love.filesystem.read("banka.lua"))
    end
  end;
};


---Tiledから読み込み
-------------------------------------------------Event-------------------------s
--room別イベント生成
BankaEvent = {
  ev_debug1 = function(p)
    flag = not BankaFlag["debug"]["test1"]
    if flag then
      local player = nil
      eventmanager:add(E_CamMoveTo.new(p.player.x,p.player.y,0.1))
      eventmanager:add(E_CamMoveTo.new(42*16,28*16,3))
      eventmanager:add(E_CamMoveTo.new(p.player.x,p.player.y,2))
      eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) TestEnemy.new(p.player.x,p.player.y) obj.kill = true end end))
      eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) camStand:shake(2,2,3) obj.kill = true end end))
      eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) player =  TestPlayer.new(p.player.x,p.player.y) obj.kill = true end end))
      eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) player.vpos = 5 obj.kill = true end end))
      eventmanager:add(E_CamMoveFocusSeq.new(0.2))
      BankaFlag["debug"]["test1"] = true
    else
      local player = TestPlayer.new(p.player.x,p.player.y)
    end
  end;
  ev_debug2 = function(p)
    TestPlayer.new(p.player.x,p.player.y)
  end;
  ev_debug3 = function(p)
    eventmanager:add(TestEvent.new())
    eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) camStand:shake(2,2,3) obj.kill = true end end))
    eventmanager:add(CustomEvent.new(function(obj) obj.init = function(obj) player =  TestPlayer.new(p.player.x,p.player.y) obj.kill = true end end))
  end;
}

--map情報を記述
BankaMap = {
  debug1 = {map = "game/materials/stages/test/test.lua",name = "デバッグ1",music = "game/materials/sound//music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_debug1"]},
  debug2 = {map = "game/materials/stages/test/test2.lua",name = "デバッグ2",music = "game/materials/sound//music/Nctrnm_-_Pull.mp3",event = BankaEvent["ev_debug2"]},
  debug3 = {map = "game/materials/stages/test/test3.lua",name = "デバッグ3",music = nil,event = BankaEvent["ev_debug3"]}
}

BankaEnemy = {
  debug = {
    test1 = TestEnemy
  }
}

--ゲーム内のflag
BankaFlag = {
  debug = {
    test1 = false
  }
}



--[[
  E_Select.new(e1,e2)
  e1 = {

  }
  e2 = {

  }
]]

--[[
      EventChar(event) <- eventをもたせる
      EventTouch(event) <- eventをもたせる
]]
