--即席テキスト

ObjectTextWindow = {
  new = function(class,parent,text,x,y,w,h,padding,depth)
    local obj = instance(ObjectTextWindow,Object,class)
    obj.window = TextWindow.new(parent,text,x,y,w,h,padding,depth)
    return obj
  end;
  update = function(self,dt)
    self.window:update(dt)
    if self.window.kill == true then
      self.kill = true
    end
  end;
  drawGUI = function(self)
    self.window:drawGUI()
  end
};
