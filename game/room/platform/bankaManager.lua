---ゲーム作成 manager経由で取得してね
Manager_banka = {
  new = function()
    local obj = instance(Manager_banka,GameManager)
    --生成用
    obj.player = {num = "1",status = nil,dir = 1}

    return obj
  end;
  update = function(dt)
    if love.mouse.wasPressed(1) then
       TestShot.new(math.floor(m_x/16)*16,math.floor(m_y/16)*16,16,0)
       g_soundmanager:play(ADDRESS.se .. "se_shot.wav")
    end
    if love.mouse.wasPressed(2) then
       TestEnemy2.new(math.floor(m_x/16)*16,math.floor(m_y/16)*16)
    end
    if love.keyboard.wasPressed("t") then
       trans(T_normal,DebugRoom,nil)
    end
  end;
  drawGUI = function(self)
    g.setColor(255,128,128,128)
    g.rectangle("fill",math.floor(m_x/16)*16,math.floor(m_y/16)*16,16,16)
    g.setColor(255,255,255,255)
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
