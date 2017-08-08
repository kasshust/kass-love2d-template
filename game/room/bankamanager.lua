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
