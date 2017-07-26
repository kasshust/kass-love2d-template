--ゲーム内でシーン共通変数などを処理 全ゲームで用意される

Manager = {
    new = function(x,y)
        local obj = instance(Manager,StaticObject)
        obj.frame = 0
        ---セーブデータの各変数初期化
        Manager.save_init()

        return obj
    end;
    update = function(self,dt)
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
    end;

    --save load
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
