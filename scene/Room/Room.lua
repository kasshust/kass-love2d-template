Title = {
    new = function()
        local obj = instance(Title,Scene)
            obj.frame = 0
            obj.name = "title"

        return obj
    end;
}

Room1 = {
    new = function()
        local obj = instance(Room1,Scene)
            obj.frame = 0
            obj.name = "stage1"
            --maincam-worldをステージの大きさに合わせる(自動でバウンダリーが設定される)
            maincam:setWorld(0,0,640,480)
            add(test.new(100,100))
            add(test2.new(100,100))
            add(test3.new(0,0,32,H))
            add(test3.new(32,H-16*3,32,32))
            add(test3.new(0,0,W,32))
            add(test3.new(0,H-32,W,32))
            add(test3.new(W-32,0,32,H))
            obj.music = love.audio.newSource("materials/sound/music/music_test.mp3", "stream")
            soundmanager:playMusic(obj.music)
            obj.map = sti("materials/stages/stage1/dood.lua", {})
        return obj
    end;
}

Room2 = {
    new = function()
        local obj = instance(Room2,Scene)
            obj.frame = 0
            obj.name = "stage2"

            for i=0,1000 do
              add(test3.new(32,H-16*3,32,32))
            end
        return obj
    end;
}
