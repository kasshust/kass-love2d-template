--ADDRESS
ADDRESS = {}
ADDRESS.se = "game/materials/sound/se/"

--ゲーム内のflag
BankaFlag = {
  debug = {
    test1 = false
  }
}
--room別イベント生成
BankaEvent = {
  ev_standard = function(p)
    TestPlayer.new(p.player.x,p.player.y)
  end;
  ev_debug1 = function(p)
    flag = not BankaFlag["debug"]["test1"]
    if flag then
      local player = nil
      g_eventmanager:add(E_CamMoveTo.new(p.player.x,p.player.y,0.1))
      g_eventmanager:add(E_Pause.new(true))
      g_eventmanager:add(E_CamMoveTo.new(42*16,28*16,3))
      g_eventmanager:add(E_CamMoveTo.new(p.player.x,p.player.y,2))
      g_eventmanager:add(E_Pause.new(false))

      g_eventmanager:add(CustomEventInit.new(function(obj) TestEnemy.new(p.player.x,p.player.y) end))
      g_eventmanager:add(CustomEventInit.new(function(obj) g_camStand:shake(2,2,3) end))
      g_eventmanager:add(CustomEventInit.new(function(obj) player = TestPlayer.new(p.player.x,p.player.y) end))
      g_eventmanager:add(CustomEventInit.new(function(obj) player.vpos.y = -5 end))
      g_eventmanager:add(E_CamMoveFocusSeq.new(0.2))
      BankaFlag["debug"]["test1"] = true
    else
      local player = TestPlayer.new(p.player.x,p.player.y)
    end
  end;

  ev_debug2 = function(p)
    TestPlayer.new(p.player.x,p.player.y)
  end;

  ev_debug3 = function(p)
    g_eventmanager:add(TestEvent.new())
    g_eventmanager:add(CustomEventInit.new(function(obj) player = TestPlayer.new(p.player.x,p.player.y) end))
    g_eventmanager:add(CustomEventInit.new(function(obj) g_camStand:shake(2,2,3) end))
  end;
}
--map情報を記述
BankaMap = {
  debug1 = {map = "game/materials/stages/test/test.lua",name = "デバッグ1",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_debug1"]},
  debug2 = {map = "game/materials/stages/test/test2.lua",name = "デバッグ2",music = "game/materials/sound/music/Nctrnm_-_Pull.mp3",event = BankaEvent["ev_debug2"]},
  debug3 = {map = "game/materials/stages/test/test3.lua",name = "デバッグ3",music = nil,event = BankaEvent["ev_debug3"]},
  debug4 = {map = "game/materials/stages/test2/test4.lua",name = "デバッグ4",music = nil,event = BankaEvent["ev_standard"]},
  S1 = {map = "game/materials/stages/S/S1.lua",name = "S1",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_standard"]},
  S2 = {map = "game/materials/stages/S/S2.lua",name = "S2",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_standard"]},
  S3 = {map = "game/materials/stages/S/S3.lua",name = "S3",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_standard"]},
  Sboss = {map = "game/materials/stages/S/Sboss.lua",name = "Sboss",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_standard"]},
}
--enemy情報
BankaEnemy = {
  debug = {
    test1 = TestEnemy
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
