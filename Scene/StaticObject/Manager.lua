Manager = {
    new = function(x,y)
        local obj = instance(Manager)
        obj.frame = 0

        return obj
    end;
    update = function(self,dt)
      SceneManager.c_scene.maincam:setScale(2 + wheel_y)
      SceneManager.c_scene.maincam:setPosition(love.mouse.getX(), love.mouse.getY())
      debugger:print(wheel_y)
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
    end;
}


--save,load
Manager.save = function()
end;


Manager.load = function()
end;
