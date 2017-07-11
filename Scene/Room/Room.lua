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
            add(test3.new(0,0,16,H))
            add(test3.new(16,H-16*3,16,16))
            add(test3.new(0,0,W,16))
            add(test3.new(0,H-16,W,16))
            add(test3.new(W-16,0,16,H))
        return obj
    end;
}

Room2 = {
    new = function()
        local obj = instance(Room2,Scene)
            obj.frame = 0
            obj.name = "stage2"
        return obj
    end;
}
