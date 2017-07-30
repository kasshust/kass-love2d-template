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

                -------プレイヤ−生成可否

                TestEnemy:new(100,100)

                for k ,o in pairs(obj.map.layers.door.objects) do
                    if manager.game.player.num == tonumber(o.name) then
                      TestPlayer:new(o.x + 8,o.y + 8)
                      do break end;
                    end
                end

            obj.m = love.audio.newSource("materials/sound/music/music_test.mp3", "stream")
            obj.m:setVolume(0.1)
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

            TestPlayer:new(100,100)


        return obj
    end;
}
