Manager = {
    new = function(x,y)
        local obj = instance(Manager,StaticObject)
        obj.frame = 0
        return obj
    end;
    update = function(self,dt)
      if love.keyboard.wasPressed("w") then
        Transition.transition(Room2)
      end
      if love.keyboard.wasPressed("q") then
        Transition.transition(Room1)
      end
      if love.keyboard.wasPressed("t") then
        Transition.transition(Title)
      end
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
      local x,y = maincam:getPosition()
      draw_status(x - W/2,y - H/2)
      g.print("バルサミコ酢　こんにちは　こんばんは",x - W/2,y - H/2 + 100)
    end;
}

--save,load
Manager.save = function()
  if not love.filesystem.exists("save.lua") then
      savedata = {}
      for i = 1 , 20 do
          table.insert(savedata,false)
      end
      love.filesystem.write("save.lua",Tserial.pack(savedata))
  else
      savedata = Tserial.unpack(love.filesystem.read("save.lua"))
  end
end;


Manager.load = function()
end;
