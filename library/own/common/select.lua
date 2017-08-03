Select = {
  new = function(min,max)
    local obj = instance(Select)
    obj.min = min or 1
    obj.max = max or 1
    obj.now = 1
    return obj
  end;
  check = function(self)
    local up,down = controller.wasPressed("up"),controller.wasPressed("down")
    if up then self.now = self.now - 1  end
    if down then self.now = self.now + 1  end

    if self.now > self.max then self.now = self.min end
    if self.now < self.min then self.now = self.max end

    return up or down ,self.now
  end;
}
