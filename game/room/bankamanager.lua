---ゲーム作成 manager経由で取得してね

ADDRESS = {}
ADDRESS.se = "game/materials/sound/se/"

Manager_banka = {
  new = function()
    local obj = instance(Manager_banka,GameManager)

    --生成用
    obj.player = {num = "2",status = nil,dir = 1}
    obj.t = {{0,0},{0,0},{0,0}}
    return obj
  end;
  update = function(dt)
    if love.mouse.wasPressed(1) then
      Smoke.new(g_x+maid64.mouse.getX(),g_y+maid64.mouse.getY())
      Smoke.new(g_x+maid64.mouse.getX(),g_y+maid64.mouse.getY())
      Smoke.new(g_x+maid64.mouse.getX(),g_y+maid64.mouse.getY())
      camStand:shake(20,1,1)
      soundmanager:play(ADDRESS.se .. "se_explosion2.wav")
    end
  end;
  draw = function(self)
    local _x,_y = g_x+maid64.mouse.getX(),g_y+maid64.mouse.getY()
    table.insert(self.t,1,{_x,_y})
    g.setColor(ASE.DARKGRAY)
    g.ellipse("fill",self.t[3][1],self.t[3][2],12,3)
    g.setColor(ASE.LIGHTCYAN)
    g.ellipse("fill",self.t[2][1],self.t[2][2],12,3)
    g.setColor(ASE.WHITE)
    g.ellipse("fill",self.t[1][1],self.t[1][2],12,3)
  end;

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
      eventmanager:add(E_Pause.new(true))
      eventmanager:add(E_CamMoveTo.new(42*16,28*16,3))
      eventmanager:add(E_CamMoveTo.new(p.player.x,p.player.y,2))
      eventmanager:add(E_Pause.new(false))

      eventmanager:add(CustomEventInit.new(function(obj) TestEnemy.new(p.player.x,p.player.y) end))
      eventmanager:add(CustomEventInit.new(function(obj) camStand:shake(2,2,3) end))
      eventmanager:add(CustomEventInit.new(function(obj) player = TestPlayer.new(p.player.x,p.player.y) end))
      eventmanager:add(CustomEventInit.new(function(obj) player.vpos.y = -5 end))
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
    eventmanager:add(CustomEventInit.new(function(obj) player = TestPlayer.new(p.player.x,p.player.y) end))
    eventmanager:add(CustomEventInit.new(function(obj) camStand:shake(2,2,3) end))
  end;
}

--map情報を記述
BankaMap = {
  debug1 = {map = "game/materials/stages/test/test.lua",name = "デバッグ1",music = "game/materials/sound/music/gunctrl_-_07_-_Dactylic_Hexameter.mp3",event = BankaEvent["ev_debug1"]},
  debug2 = {map = "game/materials/stages/test/test2.lua",name = "デバッグ2",music = "game/materials/sound/music/Nctrnm_-_Pull.mp3",event = BankaEvent["ev_debug2"]},
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
