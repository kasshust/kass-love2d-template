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
    if love.keyboard.wasPressed("return") then
    self:CW(Player,function(other)
        TextWindow:new(nil,self.text,W/2,200,300,70,15)
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

Player = {
  table = {};
  new = function(class,x,y)
    local obj = instance(Player,Object,class,100,100)
    --継承時に探索用のため必要
    Player.table[obj.id] = obj
    obj.name = "Player"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = 14,14
    obj.islanding = false
    obj.dir = 1
    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.col = collider:rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)

    obj.animator = Animator.new(img_test,16,16,1,1,1)
    obj.animator:add("run",2,3)

    return obj
  end;

  step = function(self,dt)
      self.animator:update(dt)

      --ジャンプ
      if love.keyboard.wasPressed("return") then
        if self.islanding then self.vpos = Vector.new(self.vpos.x,-3.2) end
      end
      --移動
      if love.keyboard.isDown("a") then
        self.vpos = self.vpos + Vector.new(-0.2,0.0)
        self.animator:change("run")
        self.animator:setSpeed(1)
        self.dir = -1
      end
      if love.keyboard.isDown("d") then
        self.vpos = self.vpos + Vector.new(0.2,0.0)
        self.animator:change("run")
        self.animator:setSpeed(1)
        self.dir = 1
      end
      self.vpos = self.vpos * Vector.new(0.90,1.00) + Vector.new(0.0,0.1)

      self.pos = self.pos + self.vpos

  end;

  collision = function(self)

    --全探索
    --[[
    self:SW(Block,function(other,dx,dy)
      self.pos = self.pos + Vector.new(dx,dy)
      if dx ~= 0 then self.vpos = self.vpos * Vector.new(0,1) end
      if dy ~= 0 then self.vpos = self.vpos * Vector.new(1,0) end
    end)
    ]]--
    --

    self.solid:moveTo(self.pos.x,self.pos.y)
    --衝突検知
      for shape, delta in pairs(HC.collisions(self.solid)) do
        self.pos = self.pos + delta
        if delta.y < 0 then self.islanding = true end
        if delta.x ~= 0 then self.vpos = self.vpos * Vector.new(0,1) end
        if delta.y ~= 0 then self.vpos = self.vpos * Vector.new(1,0) end
      end

      ---着地判定
      self.islanding = false
      self.solid:moveTo(self.pos.x,self.pos.y + 2)
      for shape, delta in pairs(HC.collisions(self.solid)) do
        if delta.y ~= 0 then self.islanding = true end
      end

      self.col:moveTo(self.pos.x,self.pos.y)
      self.solid:moveTo(self.pos.x,self.pos.y)


  end;

  draw = function(self)
    self.animator:draw(self.pos.x,self.pos.y,0,1*self.dir,1,8,9)
    g.setColor(255,0,0,128)
    --self.solid:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Player)

Block = {
  table = {};
  new = function(class,x,y,w,h)
    local obj = instance(Block,Object,class,100,100)
    Block.table[obj.id] = obj
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    --g.setColor(255,0,0,128)
    --self.solid:draw("fill")
    --g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Block)

MoveBlock = {
  table = {};
  new = function(class,x,y,w,h,vx,vy)
    local obj = instance(MoveBlock,Block,class,x,y,w,h)
    MoveBlock.table[obj.id] = obj
    obj.name = "test3"
    obj.frame = 0
    obj.pos = Vector.new(x,y)
    obj.dpos = Vector.new(x,y)
    obj.v = Vector.new(vx or 0,vy or 0)
    obj.bpos = obj.pos

    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.col = collider:rectangle(obj.pos.x,obj.pos.y-obj.h-1,w,1)
    return obj
  end;

  step = function(self,dt)
    self.frame = self.frame + 1
    local pre = Vector.new(self.pos.x,self.pos.y)
    self.pos = self.bpos + Vector.new(self.v.x * math.sin(self.frame * 2*math.pi/360),self.v.y * math.sin(self.frame * 2*math.pi/360))
    self.dpos = self.pos - pre
  end;

  collision = function(self,dt)
    --乗ったものを動かす
    self.col:moveTo(self.pos.x,self.pos.y-self.h/2-1)
    self:CW(Player,function(other)
      --other.islanding = true
      if other.islanding == true then
        other.pos = other.pos + self.dpos
      end
    end)

    --プレイヤーを吐き出す
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:SW(Player,function(other,dx,dy)
      other.pos = other.pos - Vector.new(dx,dy)
      other.solid:moveTo(other.pos.x,other.pos.y)
      other.col:moveTo(other.pos.x,other.pos.y)
    end)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("fill")
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,MoveBlock)

Block = {
  table = {};
  new = function(class,x,y,w,h)
    local obj = instance(Block,Object,class,100,100)
    Block.table[obj.id] = obj
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    --g.setColor(255,0,0,128)
    --self.solid:draw("fill")
    --g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Block)

Floor = {
  table = {};
  new = function(class,x,y,w,h)
    local obj = instance(Floor,Object,class,100,100)
    Floor.table[obj.id] = obj
    obj.name = "Floors"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    obj.col = collider:rectangle(x,y,w,h)
    return obj
  end;

  step = function(self,dt)
  end;

  collision = function(self,dt)
    self:CW(Player,function(other,dx,dy)
      print(dx,dy)
      --other.pos = other.pos - Vector.new(dx,dy)

      --条件作る
      --self.pos.y - (other.pos.y + other.h/2) > -4
      if dy > 0 then
        other.islanding = true
        other.pos.y = self.pos.y - other.h/2
        other.vpos = other.vpos * Vector.new(1,0)
      end

      other.solid:moveTo(other.pos.x,other.pos.y)
      other.col:moveTo(other.pos.x,other.pos.y)
    end)
  end;

  draw = function(self)
    g.setColor(255,0,255,128)
    self.col:draw("fill")
    g.setColor(255,255,255)
  end
};
table.insert(SearchTable,Floor)

Slope = {
  table = {};
  new = function(class,...)
    local obj = instance(Slope,Object,class)
    Slope.table[obj.id] = obj
    obj.name = "test3"
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.h,obj.w = h,w;
    local p = {}
    for k ,v in pairs(...) do
      table.insert(p,v.x)
      table.insert(p,v.y)
    end
    obj.col = collider:polygon(p[1],p[2],p[3],p[4],p[5],p[6])
    return obj
  end;

  step = function(self,dt)
  end;

  collision = function(self,dt)
    self.col:move(0,-3)
    self:CW(Player,function(other,dx,dy)
      if dy >= 0 and other.vpos.y >= 0 then
        debugger:print("aaaa")
        other.islanding = true
        other.pos = other.pos - Vector.new(0,dy-2)
        other.vpos = other.vpos * Vector.new(1,0)
        other.solid:moveTo(other.pos.x,other.pos.y)
        other.col:moveTo(other.pos.x,other.pos.y)
      end
    end)
    self.col:move(0,3)
  end;

  draw = function(self)
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};
table.insert(SearchTable,Slope)

test5 = {
  table = {};
  new = function(class)
    local obj = instance(test5,Object,class,100,100)
    test5.table[obj.id] = obj
    obj.name = "test5"
    return obj
  end;
}
table.insert(SearchTable,test5)

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
     for k,v in pairs(Player.table) do
      local bool,t  = v.col:intersectsRay(self.pos.x,self.pos.y,0,1)
      if bool then
        self.vec = Vector.new(self.pos.x, self.pos.y) +  Vector.new(t,t) * Vector.new(0,1):normalize()
        --debugger:print(v)
      end
     end
   end;
   collision = function(self)

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
