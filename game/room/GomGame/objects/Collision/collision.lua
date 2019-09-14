-- 矩形の障害物
O_RectCollision = {
  new = function(x,y,w,h)
    local obj = instance(O_RectCollision,Object,x,y,w,h)
    --継承時に探索用のため必要
    obj.name = "RectCollision"
    obj.tag = {"collision"}

    obj.pos = Vector.new(x,y)
    obj.vpos = Vector.new(0,0);
    obj.w = w or 64
    obj.h = h or 64
    obj.length = 1/math.random(1000)
  
    obj.mycol = Top_Block.new(x,y,obj.w,obj.h)
      
    return obj
  end;
  
  draw = function(self)
    if self.visible == true then 
            -- 3D描画1
      --[[
      local hx = g_x + W/2 - self.pos.x
      local hy = g_y + H/2  - self.pos.y
      local gain = -50
      
      for i = 1,8 do
        
        if i > 6 then 
          g.setColor(0.7,0.7,0.7,0.8)
          love.graphics.circle(("fill"), self.pos.x + self.w/2 + i * hx/gain, self.pos.y + self.h/2 + i* hy/gain, 12)
        else
          g.setColor(0.3,0.3,0.3,1)
          love.graphics.rectangle(("fill"), self.pos.x + i * hx/gain, self.pos.y + i* hy/gain, self.w-i, self.h-i)
        end
      end
      g.setColor(255,255,255,255)
      ]]

        -- 3D描画2
        local hx = g_x + W/2 - self.pos.x
        local hy = g_y + H/2  - self.pos.y
        local gain = -self.length
        
        self.depth = Vector.new(hx,hy):len()

        g.setColor(0.3,0.3,0.3,1)
  
        local p1 = Vector.new(self.pos.x + 0 * hx/gain, self.pos.y + 0* hy/gain)
        local p2 = Vector.new(self.pos.x + 8 * hx/gain, self.pos.y + 8* hy/gain)
  
        --ワイヤーフレーム
        -- 上下の四角形の描画
        --love.graphics.rectangle(("line"), p1.x, p1.y, self.w, self.h)
        --love.graphics.rectangle(("line"), p2.x, p2.y, self.w, self.h)
        -- 側面のワイヤーフレームの描画
        --love.graphics.line(p1.x,p1.y,p2.x,p2.y)
        --love.graphics.line(p1.x+self.w,p1.y,p2.x+self.w,p2.y)
        --love.graphics.line(p1.x,p1.y+self.h,p2.x,p2.y+self.h)
        --love.graphics.line(p1.x+self.w,p1.y+self.h,p2.x+self.w,p2.y+self.h)
  

        if hx < 0 and hy > 0 then
        --ポリゴンの描画 正面から時計回り
          g.setColor(1,0,0,1) --3
          love.graphics.rectangle_a("fill",p1.x,p1.y,p2.x,p2.y,p2.x+self.w,p2.y,p1.x+self.w,p1.y)
          g.setColor(0,1,0,1) --4
          love.graphics.rectangle_a("fill",p1.x+self.w,p1.y,p2.x+self.w,p2.y,p2.x+self.w,p2.y+self.h,p1.x+self.w,p1.y+self.h)
  
          g.setColor(0,0,1,1)--1
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h, p1.x+self.w, p1.y+self.h , p2.x+self.w,p2.y+self.h , p2.x , p2.y+self.h)
          g.setColor(1,1,1,1)--2
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h,p2.x,p2.y+self.h, p2.x,p2.y,p1.x , p1.y)
        elseif hx > 0  and hy > 0 then
          g.setColor(1,0,0,1) --3
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h,p2.x,p2.y+self.h, p2.x,p2.y,p1.x,p1.y)
          g.setColor(0,1,0,1) --4
          love.graphics.rectangle_a("fill",p1.x,p1.y,p2.x,p2.y,p2.x+self.w,p2.y,p1.x+self.w,p1.y)
          g.setColor(0,0,1,1)
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h, p1.x+self.w, p1.y+self.h , p2.x+self.w,p2.y+self.h , p2.x , p2.y+self.h)
          g.setColor(1,1,1,1)
          love.graphics.rectangle_a("fill",p1.x+self.w,p1.y,p2.x+self.w,p2.y,p2.x+self.w,p2.y+self.h,p1.x+self.w,p1.y+self.h)
        elseif hx > 0  and hy < 0 then
          g.setColor(0,0,1,1)--1
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h, p1.x+self.w, p1.y+self.h , p2.x+self.w,p2.y+self.h , p2.x , p2.y+self.h)
          g.setColor(1,1,1,1)--2
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h,p2.x,p2.y+self.h, p2.x,p2.y,p1.x , p1.y)
          g.setColor(1,0,0,1) --3
          love.graphics.rectangle_a("fill",p1.x,p1.y,p2.x,p2.y,p2.x+self.w,p2.y,p1.x+self.w,p1.y)
          g.setColor(0,1,0,1) --4
          love.graphics.rectangle_a("fill",p1.x+self.w,p1.y,p2.x+self.w,p2.y,p2.x+self.w,p2.y+self.h,p1.x+self.w,p1.y+self.h)
        elseif hx < 0  and hy < 0 then
          g.setColor(0,0,1,1)--1
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h, p1.x+self.w, p1.y+self.h , p2.x+self.w,p2.y+self.h , p2.x , p2.y+self.h)
          g.setColor(0,1,0,1) --4
          love.graphics.rectangle_a("fill",p1.x+self.w,p1.y,p2.x+self.w,p2.y,p2.x+self.w,p2.y+self.h,p1.x+self.w,p1.y+self.h)
          g.setColor(1,1,1,1)--2
          love.graphics.rectangle_a("fill",p1.x,p1.y+self.h,p2.x,p2.y+self.h, p2.x,p2.y,p1.x , p1.y)
          g.setColor(1,0,0,1) --3
          love.graphics.rectangle_a("fill",p1.x,p1.y,p2.x,p2.y,p2.x+self.w,p2.y,p1.x+self.w,p1.y)
        end;
        
        --ふた
        g.setColor(1,1,0,1)
        love.graphics.rectangle(("fill"), p2.x, p2.y, self.w, self.h)

        g.setColor(255,255,255,255)
    end  
  end
};

  -- 丸の障害物
O_CircleCollision = {
  new = function(x,y)
    local obj = instance(O_CircleCollision,Object,x,y)
    --継承時に探索用のため必要
    obj.name = "CircleCollision"
    obj.tag = {"collision"}

    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = 16,16

    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.solid.other = obj

    return obj
  end;

  collision = function(self)
  end;

  checkCollisionWithSolid = function(self)
    --hsp
    self.solid:moveTo(self.pos.x-self.vpos.x,self.pos.y)
    self:collideWith("block",self.solid,function(other,delta)
      if delta.y ~= 0 then if math.sign(delta.y) == -math.sign(self.vpos.y) then self.vpos = self.vpos * Vector.new(1,0) end end
    end)
    
    --vsp
    self.solid:moveTo(self.pos.x,self.pos.y-self.vpos.y)
    self:collideWith("block",self.solid,function(other,delta)
      if  delta.x ~= 0 then
        if math.sign(delta.x) == -math.sign(self.vpos.x) then
          local x1,y1,x2,y2 = self.solid:bbox()
          local dis1,dis2 = y2 - other.pos.y , other.pos.y + other.h - y1
            if dis1 > 2 and dis2 > 2 then
              self.vpos = self.vpos * Vector.new(0,1)
            else  g_debugger:print("下" .. tostring(dis1),"上" .. tostring(dis2))
            end
        end
      end
    end)

    --col
    self.solid:moveTo(self.pos.x,self.pos.y)
    self:collideWith("block",self.solid,function(other,delta)
      self.pos = self.pos + delta
      if delta.y < 0 then self.islanding = true  end
    end)
  end;

  draw = function(self)
    if self.visible == true then
      g.setColor(1,0,1,0.4)
      self.solid:draw("fill")
      g.setColor(255,255,255,255)
    end
  end;
 };