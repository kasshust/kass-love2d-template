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
    obj.dir = {x = 1,y= 0}
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
        --blocktagとの衝突
        if shape.tag == "block" then
          self.pos = self.pos + delta
          if delta.y < 0 then self.islanding = true  end
          if delta.x ~= 0 and (math.abs(delta.x) > 0.01) then self.vpos = self.vpos * Vector.new(0,1) end
          if delta.y ~= 0 and (math.abs(delta.y) > 0.01) then self.vpos = self.vpos * Vector.new(1,0) end
        end
      end
  end;
  checkLanding = function(self)
    self.islanding = false
    self.solid:moveTo(self.pos.x,self.pos.y + 2)
    for shape, delta in pairs(HC.collisions(self.solid)) do
      if shape.tag == "block" then
        if delta.y ~= 0 then self.islanding = true end
      end;
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

     --collision上書き
     obj.w,obj.h = 12,12
     obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
     obj.col = collider:rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)

     obj.operation = true
     obj.view = View:new(obj)

     obj.animator = Animator.new(img_test,16,16,1,1,1)
     obj.animator:add("run",2,3)
     return obj
   end;
   step = function(self,dt)
     --anim update
     self.animator:update(dt)
     --操作
     if self.operation == true then self:operate(dt) end;
     --効果音
     if self.animator:isrenew(2,"run") == true then soundmanager:play("materials/sound/se/se_test.wav") end

     self.vpos = self.vpos * Vector.new(0.84,1.00) + Vector.new(0.0,0.1)
     self.pos = self.pos + self.vpos
   end;
   operate = function(self,dt)
     --ジャンプ
     if love.keyboard.wasPressed("return") then
       if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
       self.vpos = Vector.new(self.vpos.x,-3.2)
     end
     --移動
     if love.keyboard.isDown("a") then
       self.vpos = self.vpos + Vector.new(-0.4,0.0)
       self.animator:change("run")
       self.animator:setSpeed(5)
       self.dir.x = -1
    elseif love.keyboard.isDown("d") then
       self.vpos = self.vpos + Vector.new(0.4,0.0)
       self.animator:change("run")
       self.animator:setSpeed(5)
       self.dir.x = 1
    else
      self.animator:change("default")
      self.animator:setSpeed(1)
     end

     if love.keyboard.wasPressed("q") then
       self.kill = true
     end
   end;
   draw = function(self)
     self.animator:draw(self.pos.x,self.pos.y,0,1*self.dir.x,1,8,9)
   end;
   destroy = function(self)
     Char.destroy(self)
     TestPlayer.table[self.id] = nil
     self.view.kill = true
     self.view:destroy()
   end;
 }
table.insert(SearchTable,TestPlayer)

View = {
    new = function(class,focus)
      local obj = instance(View,Object,class)
      obj.name = "View"
      obj.focus = focus
      obj.pos = obj.focus.pos

      --プレイヤーからの差のみ
      obj.destination = {x = 0,y = 0}
      obj.tween = tween.new(1,obj.destination, {x = obj.focus.dir.x * 40,y = 0}, tween.easing.inOutQubic)
      obj.pre = {dir = obj.focus.dir.x}
      camStand:setfocus(obj)
      camStand:moveFocusSeq(0.5)
      camStand:setPos(obj.focus.pos.x,obj.focus.pos.y)

      return obj
    end;
    step = function(self,dt)
      if self.focus.dir.x ~= self.pre.dir then
        self.tween = tween.new(1,self.destination, {x = self.focus.dir.x * 40,y = 0}, tween.easing.inOutQubic)
      end
      self.pre.dir = self.focus.dir.x
      self.pos = self.focus.pos + Vector.new(self.destination.x,self.destination.y)
      self.tween:update(dt)
    end;
    draw = function(self)
      g.setColor(255,0,0)
      --g.points(self.pos.x,self.pos.y)
      g.setColor(255,255,255)
    end;
}

TestEnemy = {
   table = {};
   new = function(class,x,y)
     local obj = instance(TestEnemy,Char,class,x,y)
     TestEnemy.table[obj.id] = obj
     obj.name = "TestEnemy"
     return obj
   end;
   step = function(self,dt)

     --if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
     self.vpos = self.vpos + Vector.new(0.2*self.dir.x,0.0)

     self.vpos = self.vpos * Vector.new(0.84,1.00) + Vector.new(0.0,0.1)
     self.pos = self.pos + self.vpos
   end;
   collision = function(self)
     self.solid:moveTo(self.pos.x,self.pos.y)
     for shape, delta in pairs(HC.collisions(self.solid)) do
       if math.abs(delta.x) > 0 then debugger:print(delta.x) self.dir.x = math.sign(delta.x) end
     end
     Char.collision(self)
   end;
   draw = function(self)
     self.solid:draw("fill")
   end;
   destroy = function(self)
     Char.destroy(self)
     TestEnemy.table[obj.id] = nil
   end;
 }
 table.insert(SearchTable,TestEnemy)
