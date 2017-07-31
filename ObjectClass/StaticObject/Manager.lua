--ゲーム内でシーン共通変数などを処理 全ゲームで用意される
Manager = {
    new = function(x,y)
        local obj = instance(Manager,StaticObject)
        obj.frame = 0
        ---セーブデータの各変数初期化
        Manager.save_init()
        --ゲーム情報作成
        obj.game = testGame.new()
        return obj
    end;
    update = function(self,dt)

      if love.keyboard.wasPressed("c") then
          --eventmanager:add(E_CamMoveTo.new(100,100,1))
          --eventmanager:add(TestEvent.new())
          --eventmanager:add(E_CamMoveTo.new(200,200,0.2))
          --eventmanager:add(TestEvent.new())
          --eventmanager:add(E_CamMoveTo.new(300,200,1))
          --eventmanager:add(E_CamMoveFocusSeq.new(0.2))
          --eventmanager:add(TestEvent.new())
      end;
      if love.mouse.wasPressed(1) then
        Laser.new(g_x + maid64.mouse.getX(),g_y + maid64.mouse.getY())
      end


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

---ゲーム作成
testGame = {
  new = function()
    local obj = instance(testGame)
    --生成用
    obj.player = {num = 1,status = nil,dir = 1}
    return obj
  end;
};
