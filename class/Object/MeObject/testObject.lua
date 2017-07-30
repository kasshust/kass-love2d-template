TouchWindow = {
  table = {};
  new = function(class,text,x,y)
    local obj = instance(TouchWindow,Object,class,x,y)
    TouchWindow.table[obj.id] = obj

    obj.text = text or "うんこ"

    obj.pos = Vector.new(x,y)
    obj.col = collider:rectangle(obj.pos.x,obj.pos.y,16,16)
    return obj
  end;

  step = function(self,dt)
    if love.keyboard.wasPressed("s") then
    self:CW(Char,function(other)
        if other.operation == true then ObjectTextWindow:new(nil,self.text,W/2,200,300,70,15) end
      end)
    end
  end;

  destroy = function(self)
    Object.destroy(self)
    TouchWindow.table[self.id] = nil
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end;
};
table.insert(SearchTable,TouchWindow)

testEffect = {
    table = {};
    new = function(class,x,y)
      local obj = instance(testEffect,Object,class,x,y)
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

Laser = {
   table = {};
   new = function(class,x,y)
     local obj = instance(Laser,Object,class)
     Laser.table[obj.id] = obj
     obj.name = "Laser"
     obj.pos = Vector.new(x,y)
     obj.vec = Vector.new(x,y)
     return obj
   end;
   update = function(self,dt)
     for k,v in pairs(Char.table) do
      local bool,t  = v.col:intersectsRay(self.pos.x,self.pos.y,0,1)
      if bool then
        self.vec = Vector.new(self.pos.x, self.pos.y) +  Vector.new(t,t) * Vector.new(0,1):normalize()
      end
     end
   end;
   draw = function(self)
     g.points(self.pos.x,self.pos.y)
     g.line(self.pos.x,self.pos.y,self.vec.x,self.vec.y)
   end;
   destroy = function(self)
     Objec.destroy(self)
     Laser.table[obj.id] = nil
   end;
 }

--引数にfunction
