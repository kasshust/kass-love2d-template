test = {
  new = function()
    local obj = instance(test,Object,100,100)
    obj.col = HC.circle(obj.x,obj.y,10)
    return obj
  end;
  update = function (self,dt)
     self.x = love.mouse.getX()
     self.y = love.mouse.getY()

     self.col:moveTo(love.mouse.getPosition())
  end;
  draw = function (self)

    g.circle("fill",self.x,self.y,16,16)
    g.setColor(255,0,0)
    self.col:draw("fill")
  end
};
