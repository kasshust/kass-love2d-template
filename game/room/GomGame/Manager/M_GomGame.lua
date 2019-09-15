M_GomGame = {
    new = function()
      local obj = instance(M_GomGame,GameManager)

      obj.playerManager = M_Player.new()
      
      return obj
    end;
    update = function(self,dt)

      -- バックスペースでエネミーを全部殺す
      if love.keyboard.wasPressed("backspace") then
        for key, value in pairs(g_entityManager.EnemyTable) do
          value:damage()
        end
      end

      self.playerManager:update() 
      if controller.wasPressed("start") then
        trans(T_normal,DebugRoom_GomGame)
      end

    end;
    drawGUI = function(self)
      self.playerManager:drawGUI() 
    end;
  
    --save load
    save = function(self)
      --love.filesystem.write("banka.lua",Tserial.pack(savedata))
    end;

    save_init = function(self)
        --[[
            --savedata = {}
            --savedataの構造  struct
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

