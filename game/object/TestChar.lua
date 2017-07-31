
TestPlayer = {
   new = function(x,y)
     local obj = instance(TestPlayer,Char,x,y)
     table.insert(obj.tag,"player")

     --collision上書き
     --identity用col
     obj.w,obj.h = 12,12
     obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
     obj.solid.other = obj

     obj.operation = true
     obj.view = View.new(obj)

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
     if self.animator:isrenew(2,"run") == true then soundmanager:play("game/materials/sound/se/se_test.wav") end

     self.vpos = self.vpos * Vector.new(0.84,1.00) + Vector.new(0.0,0.1)
     self.pos = self.pos + self.vpos
   end;
   operate = function(self,dt)
     --ジャンプ
     if love.keyboard.wasPressed("return") then
       if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
       --self.vpos = Vector.new(self.vpos.x,-3.2)
     end
     --移動

     local d = love.keyboard.isDown
     if d("a") then
       self.vpos = self.vpos + Vector.new(-0.4,0.0)
       self.animator:change("run")
       self.animator:setSpeed(5)
       self.dir.x = -1
    elseif d("d") then
       self.vpos = self.vpos + Vector.new(0.4,0.0)
       self.animator:change("run")
       self.animator:setSpeed(5)
       self.dir.x = 1
    else
      self.animator:change("default")
      self.animator:setSpeed(1)
     end

     if d("w") then self.dir.y = -1
     elseif d("s") then self.dir.y = 1
     else self.dir.y = 0  end

     if d("q") then
       self.kill = true
     end
   end;
   draw = function(self)
     self.animator:draw(self.pos.x,self.pos.y,0,1*self.dir.x,1,8,10)
     self.solid:draw("fill")
   end;
   destroy = function(self)
     Char.destroy(self)
     self.view.kill = true
     self.view:destroy()
   end;
 }
View = {
    new = function(focus)
      local obj = instance(View,Object)
      obj.name = "View"
      obj.focus = focus
      obj.pos = obj.focus.pos

      --プレイヤーからの差のみ
      obj.destination = {x = 0,y = 0}
      obj.tween = tween.new(1,obj.destination, {x = obj.focus.dir.x * 40,y = 0}, tween.easing.inOutQubic)
      obj.pre = {dir = {x = obj.focus.dir.x ,y = obj.focus.dir.x }}
      camStand:setfocus(obj)
      camStand:moveFocusSeq(0.5)
      camStand:setPos(obj.focus.pos.x,obj.focus.pos.y)

      return obj
    end;
    step = function(self,dt)
      if self.focus.dir.x ~= self.pre.dir.x or self.focus.dir.y ~= self.pre.dir.y then
        self.tween = tween.new(1,self.destination, {x = self.focus.dir.x * 40,y = self.focus.dir.y * 40}, tween.easing.inOutQubic)
      end
      self.pre.dir.x = self.focus.dir.x
      self.pre.dir.y = self.focus.dir.y
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
   new = function(x,y)
     local obj = instance(TestEnemy,Char,x,y)
     obj.name = "TestEnemy"
     table.insert(obj.tag,"enemy")
     obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,12,12)
     obj.solid.other = obj
     obj.col = HC.point(obj.pos.x,obj.pos.y)
     return obj
   end;
   step = function(self,dt)
     --if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
     self.vpos = self.vpos + Vector.new(0.2*self.dir.x,0.0)


     self:collideWith("player",self.solid,function(other,delta)
     end)

     self.col:moveTo(self.pos.x + self.dir.x * 10,self.pos.y)
     self:collideWith("block",self.col,function(other,delta)
       local bool1 = self:checkPoint("block",self.pos.x + self.dir.x * 15,self.pos.y - 16)
       local bool2 = self:checkPoint("block",self.pos.x + self.dir.x * 15,self.pos.y - 32)
       local bool3 = self:checkPoint("block",self.pos.x + self.dir.x * 15,self.pos.y - 48)
       if bool1 and bool2 and bool3 then self.dir.x = self.dir.x * - 1 else if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end end
     end)

     self.vpos = self.vpos * Vector.new(0.87,1.00) + Vector.new(0.0,0.1)
     self.pos = self.pos + self.vpos
   end;
   draw = function(self)
     self.solid:draw("fill")
     self.col:draw("fill")
   end;

   --test
   checkPoint = function(self,tag,x,y)
      local temp = HC.point(x,y)
      for shape, delta in pairs(HC.collisions(temp)) do
        if shape.other ~= nil then
          if array.search(shape.other.tag,tag)then
            HC.remove(temp)
            return true
          end
        end
      end
      HC.remove(temp)
      return false
   end
 }

Laser = {
   new = function(x,y)
     local obj = instance(Laser,MoveBlock,x,y,32,8,16,0)
     obj.name = "Laser"
     return obj
   end;
   step = function(self,dt)
     MoveBlock.step(self)
   end;
   draw = function(self)
     self.solid:draw()
     g.points(self.pos.x,self.pos.y)
   end;
 }
