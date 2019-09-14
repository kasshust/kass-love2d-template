-- これカメラ
O_TopView = {
    new = function(focus)
      local obj = instance(O_TopView,Object)
      obj.name = "O_TopView"
      obj.focus = focus
      obj.pos = obj.focus.pos
  
      --プレイヤーからの差のみ
      obj.destination = {x = 0,y = 0}
      obj.tween = tween.new(1/5,obj.destination, {x = 0,y = 0}, tween.easing.inOutQubic)
      obj.pre = {dir = {angle = obj.focus.angle }}
      g_camStand:setfocus(obj)
      g_camStand:moveFocusSeq(0.3)
      g_camStand:setPos(obj.focus.pos.x,obj.focus.pos.y)
  
      return obj
    end;
    step = function(self,dt)
      if true then
        self.tween = tween.new(1/9,self.destination, {x = math.cos(self.focus.angle) * 256,y = math.sin(self.focus.angle) * 256}, tween.easing.inOutQubic)
      end
  
      self.pos = self.focus.pos + Vector.new(self.destination.x,self.destination.y)
      self.tween:update(dt)
    end;
    draw = function(self)
      g.setColor(255,0,0)
      --g.points(self.pos.x,self.pos.y)
      g.setColor(255,255,255)
    end;
  }