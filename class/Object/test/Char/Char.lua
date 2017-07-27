--[[
  メトロヴァニア的なキャラクター
]]

Char = {
  table = {};
  new = function(class,x,y)
    local obj = instance(Char,Object,class,x,y)
    --継承時に探索用のため必要
    Char.table[obj.id] = obj
    obj.name = "Char"
    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = 16,16
    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.col = collider:rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.islanding = false
    obj.dir = 1
    return obj
  end;

  step = function(self,dt)
  end;

  --メトロヴァニア的な当たり判定
  collision = function(self)
    ---着地判定
    self:checkLanding()
    ---衝突検知
    self:checkCollisionWithSolid()
    --solid,colをposに
    self.col:moveTo(self.pos.x,self.pos.y)
    self.solid:moveTo(self.pos.x,self.pos.y)
  end;

  checkCollisionWithSolid = function(self)
    --Solidオブジェクすべてに対して
    self.solid:moveTo(self.pos.x,self.pos.y)
    --衝突検知
      for shape, delta in pairs(HC.collisions(self.solid)) do
        self.pos = self.pos + delta
        debugger:print(delta.x,delta.y)
        if delta.y < 0 then self.islanding = true  end
        if delta.x ~= 0 and (math.abs(delta.x) > 0.001) then self.vpos = self.vpos * Vector.new(0,1) end
        if delta.y ~= 0 and (math.abs(delta.y) > 0.001) then self.vpos = self.vpos * Vector.new(1,0) end
      end
  end;
  checkLanding = function(self)
    self.islanding = false
    self.solid:moveTo(self.pos.x,self.pos.y + 2)
    for shape, delta in pairs(HC.collisions(self.solid)) do
      if delta.y ~= 0 then self.islanding = true end
    end
  end;

  draw = function(self)
    if self.visible == true then
      g.setColor(255,0,0,128)
      self.solid:draw("fill")
      g.setColor(255,255,255,255)
    end
  end;

  destroy = function(self)
    Object.destroy(self)
    Char.table[self.id] = nil
  end;
};
table.insert(SearchTable,Char)

TestPlayer = {
   table = {};
   new = function(class,x,y)
     local obj = instance(TestPlayer,Char,class,x,y)
     TestPlayer.table[obj.id] = obj
     obj.name = "TestPlayer"

     obj.w,obj.h = 14,14
     obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
     obj.col = collider:rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)

     obj.animator = Animator.new(img_test,16,16,1,1,1)
     obj.animator:add("run",2,3)
     return obj
   end;
   step = function(self,dt)
     self.animator:update(dt)

     --ジャンプ
     if love.keyboard.wasPressed("return") then
       if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
       self.vpos = Vector.new(self.vpos.x,-3.2)
     end
     --移動
     if love.keyboard.isDown("a") then
       self.vpos = self.vpos + Vector.new(-0.2,0.0)
       self.animator:change("run")
       self.animator:setSpeed(10)
       self.dir = -1
    elseif love.keyboard.isDown("d") then
       self.vpos = self.vpos + Vector.new(0.2,0.0)
       self.animator:change("run")
       self.animator:setSpeed(10)
       self.dir = 1
    else
      self.animator:change("default")
      self.animator:setSpeed(1)
     end

     if love.keyboard.wasPressed("q") then
       self.kill = true
     end

     self.vpos = self.vpos * Vector.new(0.90,1.00) + Vector.new(0.0,0.1)

     self.pos = self.pos + self.vpos
   end;
   draw = function(self)
     self.animator:draw(self.pos.x,self.pos.y,0,1*self.dir,1,8,9)
   end;
   destroy = function(self)
     Char.destroy(self)
     TestPlayer.table[self.id] = nil
   end;
 }
 table.insert(SearchTable,TestPlayer)
