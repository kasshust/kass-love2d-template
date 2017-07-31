--[[
  プラットフォーマー、トップダウンなど、アクションゲーム用
  Object class
  ゲーム内に存在するstaticでないすべてのインスタンスはこれを継承する。
  CWはObject同士のコリジョンを検知し、任意の関数を設定し、呼ぶことができる。
  newのみでシーンに自動で追加される
]]--

--Objectに固有のidを与える
function makeid(t)
  local id = math.random(1,999999)
  if t[id] == nil then
    return id
  else return makeid(t)
  end
end

Object = {
    new = function(x,y)
        local obj = instance(Object)

        --id登録
        obj.id = makeid(ObjectTable)
        ObjectTable[obj.id] = obj

        obj.solid = nil

        obj.name = "Object"
        local _x,_y = x or 0 , y or 0
        obj.pos = Vector.new(_x,_y)
        obj.depth = 0
        obj.persist = false --条件を受け付けない
        obj.visible = true
        obj.active = true
        obj.kill = false

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
    step = function(self,dt)
    end;
    collision = function(self,dt)
    end;

    --メモリから破棄する
    destroy = function(self)
      --継承先でちゃんとオーバーライドできないと100％バグ
      debugger:print("削除id:" .. self.id)
      ObjectTable[self.id] = nil
      if self.solid ~= nil then HC.remove(self.solid) end
      self = nil
    end;
    --shapeとタグの衝突検知
    collideWith = function(self,tag,col,f)
      for shape, delta in pairs(HC.collisions(col)) do
        --相手がnilの場合は無視
        if shape.other ~= nil then
          local type = type(shape.other.tag)
          if type ~= "table" then do break end; end
          if array.search(shape.other.tag,tag) then
            f(shape.other,delta)
          end
        end
      end
    end
}
