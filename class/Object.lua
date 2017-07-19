--[[
  Object class
  ゲーム内に存在するstaticでないすべてのインスタンスはこれを継承する。
  CWはObject同士のコリジョンを検知し、任意の関数を設定し、呼ぶことができる。
]]--

Object = {
    table = {};
    new = function(x,y)
        local obj = instance(Object)
        setmetatable(obj, {__mode = "k"})
        obj.name = "Object"
        obj.x = x or 0
        obj.y = y or 0
        obj.pos = Vector.new(obj.x,obj.y)
        obj.depth = 0
        obj.col = nil
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
        if self.col ~= nil then HC.remove(self.col) end
        if self.hb ~= nil then collide.remove(self.hb) end
        self = nil
    end;

    --collisionを検知し、関数を設定できる。
    CW = function(self,other,f)
      for i,v in ipairs(other.table) do
        if v ~= self and self.col:collidesWith(v.col) then
          f(v)
        end
      end
    end;
}
table.insert(SearchTable,Object)


--[[
コールバックを使用したコリジョン関数
self:CW(Player,function(other)
  self.vpos = self.vpos + Vector.new(0,-2.0)
end)
self.col:moveTo(self.pos.x,self.pos.y)
]]--
