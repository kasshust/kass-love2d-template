Manager = {
    new = function(x,y)
        local obj = instance(Manager,StaticObject)
        obj.frame = 0
        obj.t = {}

        ---各変数初期化
        Manager.save_init()

        return obj
    end;
    update = function(self,dt)
      if love.keyboard.wasPressed("1") then
        Transition.transition(Room1)
      end
      if love.keyboard.wasPressed("2") then
        Transition.transition(Room2)
      end
      if love.keyboard.wasPressed("3") then
        Transition.transition(Title)
      end
      if love.mouse.wasPressed(1) then
        local x,y = maincam:toWorld(love.mouse.getX(),love.mouse.getY())
        if love.mouse.wasPressed(1) then
          testEffect:new(x,y)
        end
      end
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
    end;
}

--save,load
Manager.save = function()
  love.filesystem.write("save.lua",Tserial.pack(savedata))
end;

Manager.save_init = function()
  savedata = {}
  --savedataの構造
  savedata[1] = {clear = 1}
  savedata[2] = {clear = 2}
  savedata[3] = {clear = 3}

  love.filesystem.write("save.lua",Tserial.pack(savedata))
  return savedata
end;

Manager.load = function()
  savedata = {}
  if not love.filesystem.exists("save.lua") then
      savedata = Manager.save_init()
  else
      savedata = Tserial.unpack(love.filesystem.read("save.lua"))
  end
end;
