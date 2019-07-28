--[[
  Me_Room用の地形オブジェクト
]]

Top_Collision = {
  new = function()
    local obj = instance(Top_Collision,Object)
    obj.name = "top_collision"
    obj.tag = {"top_collision"}
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("line")
    g.setColor(255,255,255,255)
  end
}

-- 四角形
Top_Block = {
  new = function(x,y,w,h)
    local obj = instance(Top_Block,Top_Collision)
    obj.name = "test3"
    table.insert(obj.tag ,"top_block")
    obj.pos = Vector.new((x+w)/2,(y+h)/2);
    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = w,h;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.other = obj

    -- どこでも見れるよ
    obj.allvisible = true
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

-- 円
Top_Circle = {
  new = function(x,y,r)
    local obj = instance(Top_Circle,Top_Collision)
    obj.name = "Top_Circle"
    table.insert(obj.tag ,"top_circle")
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.r = r;
    obj.solid = HC.circle(x,y,r)
    obj.solid.other = obj
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("fill")
    g.setColor(255,255,255,255)
  end
};

-- ポリゴン 三角形を複数作成 本体に判定なし
Top_Polygon = {
  new = function(...)
    local obj = instance(Top_Polygon,Top_Collision)
    obj.name = "Top_Polygon"
    --table.insert(obj.tag ,"top_polygon")
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.solid = polygon(...)
    x1,y1,x2,y2 = obj.solid:bbox()
    obj.pos = Vector.new((x1+x2)/2,(y1+y2)/2);

    for i,triangle in ipairs(obj.solid:triangulate()) do
      Top_Triangle.new(triangle:unpack())
    end

    obj.solid.other = obj
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
   
    love.graphics.polygon("fill",self.solid:unpack())
    x1,y1,x2,y2 = self.solid:bbox()
    -- draw bounding box
    g.setColor(255,255,0,255)
    --love.graphics.rectangle('line', x1,y1, x2-x1, y2-y1)
    love.graphics.points(self.pos.x,self.pos.y)
    g.setColor(255,255,255,255)
  end
};

Top_Triangle = {
  new = function(...)
    local obj = instance(Top_Triangle,Top_Collision)
    obj.name = "Top_Triangle"
    table.insert(obj.tag ,"top_triangle")
    obj.pos = Vector.new(x,y);
    obj.vpos = Vector.new(0,0);
    obj.solid = HC.polygon(...)
    x1,y1,x2,y2 = obj.solid:bbox()
    obj.pos = Vector.new((x1+x2)/2,(y1+y2)/2);
    obj.solid.other = obj
    return obj
  end;

  step = function(self,dt)
  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("line")
    x1,y1,x2,y2 = self.solid:bbox()
    -- draw bounding box
    g.setColor(255,255,0,255)
    --love.graphics.rectangle('line', x1,y1, x2-x1, y2-y1)
    love.graphics.points(self.pos.x,self.pos.y)
    g.setColor(255,255,255,255)
  end
};

-- <-Block
Top_MoveBlock = {
  new = function(x,y,w,h,vx,vy)
    local obj = instance(MoveBlock,Top_Block,x,y,w,h)
    obj.name = "test3"
    obj.frame = 0
    obj.pos = Vector.new(x,y)
    obj.dpos = Vector.new(x,y)
    obj.v = Vector.new(vx or 0,vy or 0)
    obj.bpos = obj.pos
    table.insert(obj.tag ,"top_moveblock")

    obj.h,obj.w = h,w;
    obj.solid = HC.rectangle(x,y,w,h)
    obj.solid.other = obj
    obj.col = HC.rectangle(x,y,w,2)
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
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:collideWith("char",self.col,function(other,delta)
      --other.islanding = true
      if other.islanding == true then
        other.pos = other.pos + self.dpos
      end
    end)

    self:collideWith("char",self.solid,function(other,delta)
      other.pos = other.pos - delta
      other.solid:moveTo(other.pos.x,other.pos.y)
    end)
    --プレイヤーを吐き出す


  end;

  draw = function(self)
    g.setColor(255,0,0,128)
    self.solid:draw("fill")
    g.setColor(0,255,0,128)
    self.col:draw("fill")
    g.setColor(255,255,255,255)
  end
};