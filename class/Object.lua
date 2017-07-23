--[[
  プラットフォーマー、トップダウンなど、アクションゲーム用
  Object class
  ゲーム内に存在するstaticでないすべてのインスタンスはこれを継承する。
  CWはObject同士のコリジョンを検知し、任意の関数を設定し、呼ぶことができる。
]]--

function makeid(t)
  local id = math.random(1,999999)
  if t[id] == nil then
    return id
  else return makeid(t)
  end
end

Object = {
    table = {};
    new = function(class,x,y)
        local obj = instance(Object)

        --id登録
        obj.id = makeid(ObjectTable)
        ObjectTable[obj.id] = obj
        Object.table[obj.id] = obj

        obj.col = nil
        obj.solid = nil

        obj.class = class
        obj.name = "Object"
        obj.x = x or 0
        obj.y = y or 0
        obj.pos = Vector.new(obj.x,obj.y)
        obj.depth = 0

        return obj
    end;
    update = function(self,dt)
      self:step(dt)
      self:collision(dt)
    end;
    draw = function(self)
    end;
    drawGUI = function(self)
    end;
    destroy = function(self)
        debugger:print("削除id:" .. self.id)
        --[[ 親クラス:destroy() を書いてね ]]
        Object.table[self.id] = nil
        ObjectTable[self.id] = nil
        if self.solid ~= nil then
          HC.remove(self.solid)
        end
        if self.col ~= nil then
           collider:remove(self.col)
         end
        self = nil
    end;

    --collisionを検知し、関数を設定できる。
    step = function(self,dt)
    end;
    collision = function(self,dt)
    end;
    CW = function(self,other,f)
      for i,v in pairs(other.table) do
        local bool,dx,dy = self.col:collidesWith(v.col)
        if v ~= self and bool then
          f(v,dx,dy)
        end
      end
    end;
    SW = function(self,other,f)
      for i,v in pairs(other.table) do
        local bool,dx,dy = self.solid:collidesWith(v.solid)
        if v ~= self and bool then
          f(v,dx,dy)
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
