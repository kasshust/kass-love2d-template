Room1 = {
    new = function()
        local obj = instance(Room1,Scene)
            obj.frame = 0
            obj.name = "stage1"

            Scene.add(test.new(100,100))
            Scene.add(test3.new(0,0,10,H))
            Scene.add(test3.new(0,0,W,10))
            Scene.add(test3.new(0,H-10,W,10))
            Scene.add(test3.new(W-10,0,10,H))
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
