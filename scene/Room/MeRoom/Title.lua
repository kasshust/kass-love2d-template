Title = {
    new = function()
        local obj = instance(Title,OtherRoom)
            obj.frame = 0
            obj.name = "title"
            obj.s = Select.new(1,5)
            obj.tw = {num = 1}
            obj.tween = tween.new(0.1,obj.tw, {num = obj.s.now}, tween.easing.outBounce)
        return obj
    end;
    u = function(self,dt)
      local bool2 = self.s:check()
      if bool2 then
         self.tween = tween.new(0.1,self.tw, {num = self.s.now}, tween.easing.outBounce)
         soundmanager:play("materials/sound/se/se_test.wav")
      end

      local bool =  love.keyboard.wasPressed("return")

      if bool then
        local switch = {}
        switch[1] = function()
          Transition.transition(Room1)
        end
        switch[2] = function()
          Transition.transition(Room2)
        end
        switch[3] = function()
        end
        switch[4] = function()
        end
        switch[5] = function()
        end
        switch[self.s.now]()
      end
      self.tween:update(dt)
    end;
    d = function(self)
    end;
    dg = function(self)
      ---背景
      g.setColor(128,128,255)
      g.rectangle("fill",0,0,W,H)
      g.setColor(255,255,255)

      local t = "Love2D Template 1.0"
      g.printf(t,W - 130,H-20,200,"left")

      ---text
      local text = {"Metorovania1","Metorovania2","c","d","e"}
      g.setColor(255,255,255)

      local x,y,dif = 100,60,18
      for i,v in pairs(text) do
        g.print(v,x,y + i * dif)
      end
        g.print("→",x-20,y + self.tw.num * dif)

    end;
}
