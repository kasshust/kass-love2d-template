Room1 = {
    new = function()
        local obj = instance(Room1,Scene)
            obj.frame = 0
            obj.name = "stage1"
            table.insert(ObjectTable,test.new(100,100))
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
