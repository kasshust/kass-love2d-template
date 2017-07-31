TouchWindow = {
  new = function(text,x,y)
    local obj = instance(TouchWindow,Object,x,y)

    obj.text = text or "うんこ"

    obj.pos = Vector.new(x,y)
    return obj
  end;

  step = function(self,dt)
    if love.keyboard.wasPressed("s") then
    end
  end;

  draw = function(self)
  end;
};

testEffect = {
    new = function(x,y)
      local obj = instance(testEffect,Object,x,y)
      obj.tw = {w = 32,h = 0,color = 230}
      obj.t = tween.new(1/5, obj.tw, {w = 0,h = 64,color = 230}, tween.easing.outBounce)
      obj.x = x or 0
      obj.y = y or 0
      return obj
    end;
    update = function(self,dt)
      local finish = self.t:update(dt)
      if finish then self.t = tween.new(1/10, self.tw, {w = 0,h = 16,color = 126}, tween.easing.outBounce) end
    end;
    draw = function(self)
      --g.setColor(self.tw.color,math.random(230,255),self.tw.color)
      g.setColor(self.tw.color,self.tw.color,255)
      --g.setColor(math.random(230,255),self.tw.color,math.random(230,255))
      love.graphics.ellipse("fill", self.x, self.y, self.tw.w, self.tw.h)
    end;
}
