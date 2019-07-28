M_FreedomGame = {
    new = function()
      local obj = instance(M_FreedomGame,GameManager)
      
      return obj
    end;
    update = function(dt)
      
      if love.mouse.wasPressed(1) then
      end
      if love.mouse.wasPressed(2) then
      end
      if love.keyboard.wasPressed("t") then
      end
    end;
    drawGUI = function(self)
      --　マウスの位置を表示
      g.setColor(1,0.5,0.5,0.5)
      g.rectangle("fill",math.floor(m_x/16)*16,math.floor(m_y/16)*16,16,16)
      g.setColor(1,1,1,1)
    end;
  
    --save load
    save = function(self)
      --love.filesystem.write("banka.lua",Tserial.pack(savedata))
    end;

    save_init = function(self)
        --[[
            --savedata = {}
            --savedataの構造
            --savedata[1] = {clear = 1}
            --savedata[2] = {clear = 2}
            --savedata[3] = {clear = 3}
        
            --love.filesystem.write("banka.lua",Tserial.pack(savedata))
            --return savedata
        ]]--
    end;
    
    load = function(self)
      --[[
        savedata = {}
      if not love.filesystem.exists("banka.lua") then
        savedata = Manager.save_init()
      else
        savedata = Tserial.unpack(love.filesystem.read("banka.lua"))
      end
      ]]
    end;
    
};

