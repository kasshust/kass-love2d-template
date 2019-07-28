
-- ひっぱれる弾
O_String = {
  new = function(x,y,player)
    local obj = instance(O_String,Object,x,y)
    --継承時に探索用のため必要
    obj.name = "O_String"
    obj.tag = {"string"}

    obj.player = player
    obj.pos = Vector.new(x,y)

    obj.vpos = Vector.new(0,0);    
    obj.solid = HC.rectangle(x,y,6,4)
    obj.solid.other = obj
    obj.gom = true

    obj.frame = 0

    return obj
  end;

  step = function(self,dt)

    if(self.gom and self.player ~= nil ) then
      -- 中心からの偏差
      local hx = self.player.pos.x - self.pos.x
      local hy = self.player.pos.y - self.pos.y
      local gain = 15

      self.vpos = self.vpos + Vector.new(hx/gain ,hy/gain)/math.log(self.frame + 2)
    end

    self.pos = self.pos + self.vpos

    self.frame = self.frame + 1
  end;

  collision = function(self)
    -- 複数オブジェクトとの接触時に問題あり
    self.solid:moveTo(self.pos.x,self.pos.y)

    self:collideWith("top_collision",self.solid,function(other,delta)
      self.pos = self.pos + delta
      testEffect.new(self.pos.x,self.pos.y)
      --camStand:shake(10,4,4)
      Smoke.new(self.pos.x,self.pos.y)
      O_Effect.new(self.pos.x,self.pos.y)
      self.kill = true
      soundmanager:play(ADDRESS.se .. "se_hit.wav")
    end)
  
  end;
  draw = function(self)
    --g.circle("line",self.pos.x,self.pos.y,8)
    --love.graphics.line(self.pos.x,self.pos.y,self.pos.x+self.vpos.x,self.pos.y+self.vpos.y)

    --particle
    --g.setColor(ASE.RED)
    --love.graphics.draw(psystem, self.pos.x, self.pos.y)
    
    --　補助ライン
    g.setColor(ASE.DARKGRAY)
    --if(self.vpos:len()>1) then g.line(self.pos.x,self.pos.y,self.pos.x + self.vpos.x*32,self.pos.y + self.vpos.y*32) end
    g.setColor(ASE.WHITE)
    
    local xscale,yscale = math.abs(self.vpos.x/2) + 3 , math.abs(self.vpos.y/2) + 3
    g.setColor(ASE.DARKGRAY)
    g.ellipse("fill",self.pos.x - self.vpos.x*2.5,self.pos.y - self.vpos.y*2.5,xscale,yscale)
    g.setColor(ASE.LIGHTCYAN)
    g.ellipse("fill",self.pos.x - self.vpos.x,self.pos.y - self.vpos.y,xscale,yscale)
    g.setColor(ASE.WHITE)
    g.ellipse("fill",self.pos.x,self.pos.y,xscale,yscale)
  end;

}

--　一瞬作るゴムの輪っか
O_Gum = {
  new = function(x,y,player)
    local obj = instance(O_Gum,Object,x,y,player)
    obj.name = "O_Gum"
    obj.tag = {"gum"}
    obj.player = player
    obj.pos = Vector.new(x,y)
    obj.vpos = Vector.new(0,0);    
    obj.solid = HC.circle(x,y,64)
    obj.solid.other = obj
    obj.gom = true
    obj.frame = 0
    return obj
  end;

  step = function(self,dt)
    self.pos = self.pos + self.vpos
    self.frame = self.frame + 1
  end;

  collision = function(self)
    self.solid:moveTo(self.pos.x,self.pos.y)
      self:collideWith("string",self.solid,function(other,delta)
        table.insert(self.player.ball,other) 
        other.player = self.player
        other.gom = true
        self:destroy()
      end)
    self:destroy()
  end;
  draw = function(self)
    
    g.circle("line",self.pos.x,self.pos.y,64)
  end;
}

-- これ敵
O_Shot = {
  new = function(x,y)
    local obj = instance(O_Shot,Object,x,y)
    --継承時に探索用のため必要
    obj.name = "O_Shot"
    obj.tag = {"shot"}

    obj.pos = Vector.new(x,y)
    obj.vpos = Vector.new(0,0);    
    obj.solid = HC.circle(x,y,36)
    obj.solid.other = obj
    obj.collidable = true

    obj.frame = 0

    obj.image = load_image("game/materials/images/test/spr_logo.png")

    return obj
  end;

  step = function(self,dt)
    self.frame = self.frame+1
    if self.frame%120 == 0 then
      local o = O_String.new(self.pos.x,self.pos.y)
      o.vpos = Vector.new(math.random(-5,5),math.random(-5,5))
      self.vpos = self.vpos + Vector.new(math.random(-12,12),math.random(-12,12))
    end

    self.vpos = self.vpos * 0.85
    self.pos = self.pos + self.vpos

    --psystem:update(dt)
  end;
  collision = function(self)
    -- 複数オブジェクトとの接触時に問題あり
    self.solid:moveTo(self.pos.x,self.pos.y)  
    self:collideWith("string",self.solid,function(other,delta)
      if other.vpos:len() > 8 then
        camStand:shake(10,4,4)
        Smoke.new(self.pos.x,self.pos.y)
        O_Effect.new(self.pos.x,self.pos.y)
        self:destroy()
        self.vpos = other.vpos
        other.kill = true
        soundmanager:play(ADDRESS.se .. "se_explosion.wav")
      end
    end)

    --　壁との衝突
    self:collideWith("top_collision",self.solid,function(other,delta)
      if(self.collidable) then
        --衝突物に垂直なベクトル
        local de =  Vector.new(delta.x,delta.y):normalized()
        local checkzero = Vector.new(delta.x,delta.y)
        
        local ho = de:perpendicular()
        local projection = self.vpos:inner(de)*de
        local vertic = self.vpos - (projection)
        if(checkzero:len() ~=0 and self.vpos:len() ~= 0)then 
            self.vpos = vertic
            self.pos = self.pos + delta
            self.saveDelta = de
            self.solid:moveTo(self.pos.x,self.pos.y)
            print(other.id)
            --deltaの表示をする
        else
          self.pos = self.pos + delta
        end
      end
    end)

  end;
  draw = function(self)

    
    -- 中心からの偏差
    local hx = g_x + W/2 - self.pos.x
    local hy = g_y + H/2  - self.pos.y
    local gain = -50
    
    for i = 1,8 do
      --g.circle("fill",self.pos.x + i*hx/gain,self.pos.y + i*hy/gain,36-(i*i)/3)
      g.draw(self.image,self.pos.x + i*hx/gain,self.pos.y + i*hy/gain,0,0.2,0.2,self.image:getWidth()/2,self.image:getHeight()/2)
    end
    
         
  end;

}

-- プレイヤー
O_Circle = {
  new = function(x,y)
    local obj = instance(O_Circle,Top_Char,x,y)
    obj.name = "circle"
    obj.pos = Vector.new(x,y)
    obj.c_pos = Vector.new(x,y)
    obj.prepos = Vector.new(x,y)
    obj.direction = Vector.new(0,0)
    
    obj.time = 0
    obj.posTable = {}
    obj.vpos = Vector.new(0,0)
    obj.solid = HC.rectangle(obj.pos.x-8,obj.pos.y-8,16,16)
    obj.solid.other = obj

    obj.image = load_image("game/materials/images/char/been.png")
    --obj.animator = Animator.new(obj.image,32,32,1,1,1,"default",16,16)
    obj.animator = Animator.new(obj.image,32,32,1,4)
    --obj.solid = HC.circle(obj.pos.x,obj.pos.y,16)
    
    obj.angle = 0

    obj.legs = {Vector.new(0,0),Vector.new(0,0),Vector.new(0,0),Vector.new(0,0)}
    obj.c_legs =  {Vector.new(0,0),Vector.new(0,0),Vector.new(0,0),Vector.new(0,0)}

    obj.c_legs_tw = {
      tween.new(1/10, obj.c_legs[1], {x = 0,y = 0}, tween.easing.outBounce),
      tween.new(1/10, obj.c_legs[2], {x = 0,y = 0}, tween.easing.outBounce),
      tween.new(1/10, obj.c_legs[3], {x = 0,y = 0}, tween.easing.outBounce),
      tween.new(1/10, obj.c_legs[4], {x = 0,y = 0}, tween.easing.outBounce),
    }

    obj.c_pos = Vector.new(0,0)

     
    obj.tww = {scale = 1}
    obj.tween = tween.new(1/5, obj.tww, {scale = 1}, tween.easing.outBounce)

    obj.cam_angle = 0
    obj.cam_vangle = 0
    obj.cam_aangle = 0
    obj.ball = {}

    obj.view = O_TopView.new(obj)

    obj.saveDelta = nil
    obj.collidable = true --collisionとのcollisionは1stepに一度のみ
    
    return obj
  end;

  step = function(self,dt)
    
    if(controller.isDown("y"))then
      self.tween = tween.new(1/5, self.tww, {scale = 0.5}, tween.easing.outBounce)
    else
      self.tween = tween.new(1/5, self.tww, {scale = 1.0}, tween.easing.outBounce)
    end
    maincam:setScale(self.tww.scale)
    self.tween:update(dt)

    local sum = 0.3

    if p1joystick ~= nil then
  
      self.vpos.x = self.vpos.x + p1joystick:getGamepadAxis("leftx")*0.06
      self.vpos.y = self.vpos.y + p1joystick:getGamepadAxis("lefty")*0.06

      self.angle = math.atan2(self.vpos.y,self.vpos.x)
    end

    -- ballによる影響
    if not table.empty(self.ball) then 
      for i,v in ipairs(self.ball) do
        if v.kill == true then 
          --self.ball[i] = nil
          table.remove(self.ball, i)
        else 
          self.vpos = self.vpos + (v.pos-self.pos)/2400
        end
      end
    end


    if controller.wasPressed("l1")then 
      --table.insert(self.ball,O_String.new(self.pos.x,self.pos.y,self) )
      --soundmanager:play(ADDRESS.se .. "se_shot.wav")
    end

    if controller.wasReleased("r1")then 
      if(not table.empty(self.ball)) then
        self.ball[1].vpos = self.ball[1].vpos * 2.5
        self.ball[1].gom = false
        table.remove(self.ball,1)
        soundmanager:play(ADDRESS.se .. "se_hit.wav")
      end
    end

    if controller.wasPressed("l1")then 
      self.vpos = self.vpos + self.vpos:normalized()
      print(self.vpos)
    end

    if controller.wasPressed("r1")then 
      local o = O_Gum.new(self.pos.x,self.pos.y,self)
      o.vpos = self.vpos:normalized()*8.0
      soundmanager:play(ADDRESS.se .. "se_shot.wav")
    end

    local distance = self.angle - self.cam_angle

    -- ここなに？
    ---暫定ゲイン
    local pgain = 1/20
    local dgain = 1/20
    local aangle = distance*pgain+distance*self.cam_vangle*dgain

    ---加速度加算
    local vangle = self.cam_vangle + aangle
    self.cam_angle = self.cam_angle + vangle
    --maincam:setAngle(self.cam_angle + math.pi/2)

    self.pos = self.pos + self.vpos*10
    self.vpos = self.vpos*0.90

    self.time = self.time + 1
    
    -- 脚アップデート
    local len = 24
    for i = 1,4 do
      self.legs[i] = Vector.new(self.pos.x + len*math.cos(self.angle+(45+90*i)/180*math.pi),self.pos.y + len*math.sin(self.angle+(45+90*i)/180*math.pi))
    end

    for i = 1,4 do
      if (self.legs[i]-self.c_legs[i]):len() > 64 then
        if self.c_legs_tw[i]:update(dt) then 
          self.c_legs_tw[i] = tween.new(1/4, self.c_legs[i], {x = self.legs[i].x, y = self.legs[i].y}, tween.easing.outBounce) 
          --Smoke.new(self.c_legs[i].x,self.c_legs[i].y)
          --soundmanager:play(ADDRESS.se .. "se_walk.wav")
          --soundmanager:play(ADDRESS.se .. "se_hit.wav")
        end
      end
    end
  
    self.animator:update(dt)
    
    local temp = Vector.new(0,0)
    temp = self.pos - self.prepos

    self.direction = temp:len() == 0 and self.direction or temp:normalized()
    self.prepos = self.pos

    local temp = Vector.new(0,0)
    for i = 1,4 do
      temp = temp + self.c_legs[i]
    end

    self.c_pos = temp/4
          
  end;

  collision = function(self)
        -- 複数オブジェクトとの接触時に問題あり
    self.solid:moveTo(self.pos.x,self.pos.y)
    self.collidable = true

    self:collideWith("top_collision",self.solid,function(other,delta)
      if(self.collidable) then
        --self.collidable = false  
        --衝突物に垂直なベクトル
        local de =  Vector.new(delta.x,delta.y):normalized()
        local checkzero = Vector.new(delta.x,delta.y)
        
        local ho = de:perpendicular()
        local projection = self.vpos:inner(de)*de
        local vertic = self.vpos - (projection)
        if(checkzero:len() ~=0 and self.vpos:len() ~= 0)then 

            --Smoke.new(self.pos.x,self.pos.y)
            --testEffect.new(self.pos.x,self.pos.y)
            print(delta.x,delta.y)
            --self.vpos = -1*projection + vertic
            self.vpos = vertic
            self.pos = self.pos + delta
            
            --self.pos = self.pos + self.vpos*0.1
            --soundmanager:play("game/materials/sound/se/se_walk.wav")
            self.saveDelta = de
            self.solid:moveTo(self.pos.x,self.pos.y)
            print(other.id)
            --deltaの表示をする
        else
          self.pos = self.pos + delta
        end
      end
    end)

    --self.vpos = self.vpos*0
  end;

  draw = function(self)
    O_Entity.draw(self)

    love.graphics.setColor(1, 1.0, 1.0, 1.0)
    love.graphics.circle("line",self.pos.x,self.pos.y,12,12)
    
    if not table.empty(self.ball) then 
      for i,v in ipairs(self.ball) do
        local len = self.pos - v.pos
        love.graphics.setLineWidth(240/len:len())
        love.graphics.line(self.pos.x,self.pos.y,v.pos.x,v.pos.y)
        love.graphics.setLineWidth(1)
      end
    end

    -- 頭
    love.graphics.circle(("line"), self.c_pos.x + self.direction.x*48, self.c_pos.y + self.direction.y*48, 8, 6)

    -- 中心からの偏差
    local hx = g_x + W/2 - self.c_pos.x
    local hy = g_y + H/2  - self.c_pos.y
    local gain = -40

    for i = 1,6 do
      love.graphics.circle(("fill"), self.c_pos.x + i * hx/gain, self.c_pos.y + i * hy/gain, 8- i*1, 6)
    end

    -- 脚目標
    for i = 1,4 do
      love.graphics.line(self.pos.x,self.pos.y,self.legs[i].x,self.legs[i].y)
    end

    -- 脚
    for i = 1,4 do
      love.graphics.line(self.c_pos.x,self.c_pos.y,self.c_legs[i].x,self.c_legs[i].y)
      love.graphics.circle("line",self.c_legs[i].x,self.c_legs[i].y,6)
    end

    love.graphics.setColor(1, 1, 1, 1)

   

  end;
  drawGUI = function(self)
    if self.object ~= nil then self.object:drawGUI() end
  end
}

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
    camStand:setfocus(obj)
    camStand:moveFocusSeq(0.5)
    camStand:setPos(obj.focus.pos.x,obj.focus.pos.y)

    return obj
  end;
  step = function(self,dt)
    if true then
      self.tween = tween.new(1/5,self.destination, {x = math.cos(self.focus.angle) * 70,y = math.sin(self.focus.angle) * 70}, tween.easing.inOutQubic)
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

-- 爆発エフェクト
O_Effect = {
  new = function(x,y)
    local obj = instance(O_Effect,Object,x,y)
    obj.name = "O_Effect"
    obj.pos = Vector.new(x,y)
    obj.lifetime = 20
    obj.frame = 0

    return obj
  end;
  step = function(self,dt)

    if self.frame > self.lifetime then
      self:destroy()
    end
    self.frame = self.frame + 1
  end;
  draw = function(self)
    g.setColor(HSV(1,0,(self.lifetime-self.frame)/self.lifetime,0.2))
    g.circle("fill",self.pos.x,self.pos.y,(self.lifetime - self.frame)*math.random(1,3),16)
    g.setColor(1,1,1)
  end;
}

-- 矩形の障害物
O_Collision = {
  new = function(x,y,w,h)
    local obj = instance(O_Collision,Object,x,y,w,h)
    --継承時に探索用のため必要
    obj.name = "O_Collision"
    obj.tag = {"collision"}

    obj.pos = Vector.new(x,y)
    obj.vpos = Vector.new(0,0);
    obj.w = w or 64
    obj.h = h or 64

    obj.mycol = Top_Block.new(x,y,obj.w,obj.h)
    
    return obj
  end;

  draw = function(self)

    if self.visible == true then      
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
    end
  end;
};

-- 丸の障害物？
O_Entity = {
  new = function(x,y)
    local obj = instance(O_Entity,Object,x,y)
    --継承時に探索用のため必要
    obj.name = "O_Entity"
    obj.tag = {"char"}

    obj.vpos = Vector.new(0,0);
    obj.w,obj.h = 16,16

    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    obj.solid.other = obj

    return obj
  end;

  collision = function(self)
    ---衝突検知
    --self:checkCollisionWithSolid()
    --solid,colをposに
    --self.solid:moveTo(self.pos.x,self.pos.y)
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
            else  debugger:print("下" .. tostring(dis1),"上" .. tostring(dis2))
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

