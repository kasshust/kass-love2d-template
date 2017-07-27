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

Room1 = {
    new = function()
        local obj = instance(Room1,MeRoom)
            obj.frame = 0
            obj.name = "stage1"
            obj.size = {width = 480,height = 320}
            --maincam-worldをステージの大きさに合わせる(自動でバウンダリーが設定される)
            maincam:setWorld(0,0,obj.size.width,obj.size.height)

            obj.map = sti("materials/stages/test/test.lua", {})
            --[[

                          オブジェクト配置
                          げーむべつ

            ]]
                for k ,o in pairs(obj.map.layers.block.objects) do
                    Block:new(o.x,o.y,o.width,o.height)
                end

                for k ,o in pairs(obj.map.layers.floor.objects) do
                    Floor:new(o.x,o.y,o.width,4)
                end

                for k ,o in pairs(obj.map.layers.slope.objects) do
                    Slope:new(o.polygon)
                end

                for k ,o in pairs(obj.map.layers.text.objects) do
                    local text = split(o.properties["text"],":")
                    TouchWindow:new(text,o.x,o.y,o.width,o.height)
                end

                  MoveBlock:new(16*5,16*7,32,32,32,32)
                  MoveBlock:new(16*9,16*18,32,32,32,0)

            local player = TestPlayer:new(100,100)
            camStand:setfocus(player)

            obj.m = love.audio.newSource("materials/sound/music/music_test.mp3", "stream")
            obj.m:setVolume(0.03)
            --soundmanager:playMusic(obj.m)
        return obj
    end;
}

Room2 = {
    new = function()
        local obj = instance(Room2,MeRoom)
            obj.frame = 0
            obj.name = "stage2"
            obj.size = {width = 16*30,height = 16*60}
            --maincam-worldをステージの大きさに合わせる(自動でバウンダリーが設定される)
            maincam:setWorld(0,0,obj.size.width,obj.size.height)
            obj.map = sti("materials/stages/stage2/untitled.lua", {})

            for k ,o in pairs(obj.map.layers.block.objects) do
                Block:new(o.x,o.y,o.width,o.height)
            end

            local player = TestPlayer:new(100,100)
            camStand:setfocus(player)

        return obj
    end;
}
