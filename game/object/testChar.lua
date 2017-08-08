
TestPlayer = {
  c_player = nil,
   new = function(x,y)
     local obj = instance(TestPlayer,Char,x,y)
     table.insert(obj.tag,"player")

     --collision上書き
     --identity用col
     obj.depth = -10
     obj.w,obj.h = 12,12
     obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
     obj.solid.other = obj
     obj.gravity = 0.08
     obj.operation = true
     obj.view = View.new(obj)

     obj.animator = Animator.new(img_test,16,16,1,2,1)
     obj.animator:add("run",3,6)
     obj.animator:add("up",7,7)
     obj.animator:add("down",8,8)
     obj.animator:add("jump",9,9)
     obj.animator:setProperty(3,{oy = 1})
     obj.animator:setProperty(5,{oy = 1})
     return obj
   end;
   step = function(self,dt)
     --anim update
     self.animator:update(dt)
     --操作
     if self.operation == true then self:operate(dt) end;
     --効果音
     if self.animator:isrenew(3,"run") == true or self.animator:isrenew(5,"run") then soundmanager:play("game/materials/sound/se/se_walk.wav") end


     if controller.isDown("a") and self.vpos.y < 0 then self.gravity = 0.12 * 0.7 else self.gravity = 0.12 end

     local inertia = 1.00

     if self.islanding == true then inertia = 0.93 end

     self.vpos = self.vpos * Vector.new(inertia,1.00) + Vector.new(0.0,self.gravity)
     self.pos = self.pos + self.vpos

     self.solid:moveTo(self.pos.x,self.pos.y)
     self:collideWith("block",self.solid,function(other,delta)
       if delta.y > 0 and self.vpos.y < 0 then debugger:print(delta.y) soundmanager:play("game/materials/sound/se/se_head.wav")  end
     end)
   end;
   operate = function(self,dt)

     --ジャンプ
     if controller.wasPressed("a") then
       if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
       --self.vpos = Vector.new(self.vpos.x,-3.2)
     end
     --移動

     local d = controller.isDown


     self.animator:change("default")
     if d("left") then
       local add = -0.07
       if self.islanding == true then
         add = -0.14
       end
       self.vpos = self.vpos + Vector.new(add,0.0)
       self.animator:change("run")
       self.animator:setSpeed(12)
       self.dir.x = -1
    elseif d("right") then
      local add = 0.07
      if self.islanding == true then
        add = 0.14
      end
      self.vpos = self.vpos + Vector.new(add,0.0)
       self.animator:change("run")
       self.animator:setSpeed(12)
       self.dir.x = 1
    else
      self.animator:setSpeed(1)
     end

     if d("up") then
       self.dir.y = -1
       self.animator:change("up")
     elseif d("down") then
       self.dir.y = 1
       self.animator:change("down")
     else
       self.dir.y = 0
     end

     if self.islanding == false then self.animator:change("jump") end

     self.dis = 0
     if controller.wasPressed("x") then testEffect2.new(self.pos.x + 15*self.dir.x,self.pos.y) end

   end;
   draw = function(self)
     --g.draw(weap_test,self.pos.x,self.pos.y,self.dir.y*self.dir.x*90*2*math.pi/360 + self.dis,self.dir.x,1,3,6)
     self.animator:draw(self.pos.x,self.pos.y,0,1*self.dir.x,1,8,10)

     g.setColor(255,0,0,128)
     self.solid:draw("fill")
     g.setColor(255,255,255,255)
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
      obj.tween = tween.new(1,obj.destination, {x = obj.focus.dir.x * 75,y = 0}, tween.easing.inOutQubic)
      obj.pre = {dir = {x = obj.focus.dir.x ,y = obj.focus.dir.x }}
      camStand:setfocus(obj)
      camStand:moveFocusSeq(0.5)
      camStand:setPos(obj.focus.pos.x,obj.focus.pos.y)

      return obj
    end;
    step = function(self,dt)
      if self.focus.dir.x ~= self.pre.dir.x or self.focus.dir.y ~= self.pre.dir.y then
        self.tween = tween.new(1,self.destination, {x = self.focus.dir.x * 70,y = self.focus.dir.y * 70}, tween.easing.inOutQubic)
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
       if bool1 and bool2 and bool3 then self.dir.x = self.dir.x * - 1 else if self.islanding then
         self.vpos = Vector.new(self.vpos.x,-3.2)
         soundmanager:play("game/materials/sound/se/se_test_jump.wav")
       end
     end
     end)

     self.vpos = self.vpos * Vector.new(0.87,1.00) + Vector.new(0.0,0.1)
     self.pos = self.pos + self.vpos
   end;
   draw = function(self)
     self.solid:draw("fill")
     self.col:draw("fill")
   end;
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
