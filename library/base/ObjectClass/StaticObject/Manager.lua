--ゲーム内でシーン共通変数などを処理 全ゲームで用意される
Manager = {
  new = function(x,y)
    local obj = instance(Manager,StaticObject)
    obj.frame = 0
    obj.game = nil
    return obj
  end;
  update = function(self,dt)
    if self.game ~= nil then self.game:update(dt) end
  end;
  draw = function(self)
    if self.game ~= nil then self.game:draw() end
  end;
  drawGUI = function(self)
    if self.game ~= nil then self.game:drawGUI() end
  end;
  apply = function(self,obj)
    self.game = obj
  end
}

--各々のゲームマネージャーはこれを継承
--これをmanagerにapply
GameManager = {
  new = function(x,y)
    local obj = instance(GameManager)
    return obj
  end;
  update = function(self,dt)
  end;
  draw = function(self)
  end;
  drawGUI = function(self)
  end;
  
  --save load 例
  save = function(self)
    love.filesystem.write("save.lua",Tserial.pack(savedata))
  end;
  save_init = function(self)
    savedata = {}
    --savedataの構造
    savedata[1] = {clear = 1}
    savedata[2] = {clear = 2}
    savedata[3] = {clear = 3}

    love.filesystem.write("save.lua",Tserial.pack(savedata))
    return savedata
  end;
  load = function(self)
    savedata = {}
    if not love.filesystem.exists("save.lua") then
      savedata = Manager.save_init()
    else
      savedata = Tserial.unpack(love.filesystem.read("save.lua"))
    end
  end;
}
