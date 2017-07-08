Object = {
    table = {};
    new = function(x,y)
        local obj = instance(Object)

        obj.name = "Object"
        obj.x = x or 0
        obj.y = y or 0
        obj.direction = 0
        table.insert(Object.table,obj)
        return obj
    end;
    update = function(self,dt)
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
    end;
    destroy = function(self)
        --[[ 親クラス:destroy() を書いてね ]]
        removeFromTable(self,ObjectTable)
        removeFromTable(self,Object.table)
    end;
}

--[[
 - 当たり判定検出の例-
    obj.mouse = HC.circle(400,300,20)
    self.mouse:moveTo(love.mouse.getPosition())
    self.mouse:draw("fill")
]]--
