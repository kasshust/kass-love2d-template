Transition = {
    new = function(room)
        local obj = instance(Transition,StaticObject)
        obj.frame = 0
        obj.time_in,obj.time_out = 10,10
        obj.toRoom = room
        obj.status = Enum:new{"IN","OUT"};
        obj.status_now = obj.status.IN
        return obj
    end;
    update = function(self,dt)
        local switch={}
        switch[self.status.IN]=function()
          if self.frame > self.time_in then
            SceneManager.changeScene(self.toRoom)
            self.status_now = self.status.OUT
          end
        end
        switch[self.status.OUT]=function()
          if self.frame > self.time_in + self.time_out then
            self:destroy()
          end
        end
        switch[self.status_now]()

        self.frame = self.frame + 1
    end;
    drawGUI = function(self)
      local switch={}
      switch[self.status.IN]=function()
        local x,y = maincam:getPosition()
        for i=0,self.frame do
          love.graphics.points(x-W/2+i, y)
        end
      end
      switch[self.status.OUT]=function()
        local x,y = maincam:getPosition()
        for i=0,self.frame-self.time_in do
          love.graphics.points(x-W/2+i, y)
        end
      end
      switch[self.status_now]()
    end;
}

Transition.transition = function(room)
  addS(Transition.new(room))
end
