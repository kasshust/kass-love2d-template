TouchWindow = {
  new = function(text,x,y)
    local obj = instance(TouchWindow,Object,x,y)
    obj.text = text or "うんこ"
    obj.pos = Vector.new(x,y)
    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,16,16)
    obj.object = nil
    return obj
  end;

  step = function(self,dt)
    if controller.wasPressed("down") then
      self:collideWith("player",self.solid,function(other,delta)
          self.object = TextWindow.new(nil,self.text,W/2,H/2,W-20,70,10)
      end)
    end
    if self.object ~= nil then
      self.object:update(dt)
      if self.object.kill == true then self.object = nil end
    end
  end;

  draw = function(self)
    self.solid:draw("fill")
  end;
  drawGUI = function(self)
    if self.object ~= nil then debugger:print("aaa") self.object:drawGUI() end
  end
};

testEffect = {
    new = function(x,y)
      local obj = instance(testEffect,Object,x,y)
      obj.tw = {w = 0,h = 32,color = 230}
      obj.queue = Queue.new()
      obj.queue:enqueue(tween.new(1/5, obj.tw, {w = 64,h = 0,color = 230}, tween.easing.outBounce))
      obj.queue:enqueue(tween.new(1/20, obj.tw, {w = 2,h = 4,color = 126}, tween.easing.outBounce))
      obj.x = x or 0
      obj.y = y or 0
      return obj
    end;
    update = function(self,dt)
      local finish = self.queue:top():update(dt)
      if finish then
        self.queue:dequeue()
      end
      if self.queue:isEmpty() then
        self.kill = true
      end
    end;
    draw = function(self)
      --g.setColor(self.tw.color,math.random(230,255),self.tw.color)
      g.setColor(255,255,self.tw.color)
      --g.setColor(math.random(230,255),self.tw.color,math.random(230,255))
      love.graphics.ellipse("fill", self.x, self.y, self.tw.w, self.tw.h)
      g.setColor(255,255,255)
    end;
}