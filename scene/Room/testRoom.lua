Title = {
    new = function()
        local obj = instance(Title,OtherRoom)
            obj.frame = 0
            obj.name = "title"
            for k,v in pairs(StaticObjectTable) do
              print(k,v)
            end
        return obj
    end;
    u = function(self,dt)
    end;
    d = function()
    end;
    dg = function()
      g.setColor(128,128,255)
      g.rectangle("fill",0,0,W,H)
      g.setColor(255,255,255)
      g.print("Title",g_x + W/2,g_y + H/2)
      g.setColor(255,255,255)
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
            obj.block = {}

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

            local player = Player:new(100,100)
            camStand:setfocus(player)

            --soundmanager:playMusic(love.audio.newSource("materials/sound/music/music_test.mp3", "stream"))
        return obj
    end;
}

Room2 = {
    new = function()
        local obj = instance(Room2,OtherRoom)
            obj.frame = 0
        return obj
    end;
    u = function(self,dt)
    end;
    d = function()
    end;
    dg = function()
    end;
}
