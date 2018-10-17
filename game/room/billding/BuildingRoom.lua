--Debug Room--
BuildingRoom = {
  new = function(property)
    local obj = instance(BuildingRoom,OtherRoom,property)
    obj.frame = 0
    obj.name = "building"
    obj.s = Select.new(1,5)
    obj.tw = {num = 1}
    obj.tween = tween.new(0.1,obj.tw, {num = obj.s.now}, tween.easing.outBounce)
    return obj
  end;
  u = function(self,dt)
    local bool2 = self.s:check()
    if bool2 then
      self.tween = tween.new(0.1,self.tw, {num = self.s.now}, tween.easing.outBounce)
      soundmanager:play("game/materials/sound/se/se_test.wav")
    end

    local bool = controller.wasPressed("a")

    if bool then
      local switch = {}
      switch[1] = function()
        trans(T_normal,ModelRoom)
      end
      switch[2] = function()
      end
      switch[3] = function()
      end
      switch[4] = function()
      end
      switch[5] = function()
      end
        switch[self.s.now]()
      end
      self.tween:update(dt)
    end;
    
  d = function(self)
  end;
  dg = function(self)
      ---背景
      g.setColor(32,32,48)
      g.rectangle("fill",0,0,W,H)
      g.setColor(255,255,255)

      ---text
      local text = {"Building","nil","nil","nil","nil"}
    local explain = {"","","","",""}

      local x,y,dif = 100,120,18
      local wi_x,wi_y = x-30,y-16
      g.setColor(0,0,0)
      g.rectangle("fill",wi_x,wi_y,200,48)
      g.setColor(255,255,255)
      g.rectangle("line",wi_x,wi_y,200,48)
      g.print(explain[self.s.now],wi_x,y-30)
      love.graphics.cut(wi_x,wi_y,200,48,function()
          for i,v in pairs(text) do
            g.print(v,x,y + (-self.tw.num+i) * dif,0,1 - 0.3*math.abs((i-self.tw.num)), 1 - 0.3*math.abs((i-self.tw.num)))
          end
          g.print("→",x-20,y)
        end)
  end;
}

-- Title
ModelRoom = {
    new = function(property)
      local obj = instance(ModelRoom,OtherRoom,property)
      obj.frame = 0
      obj.name = "model"
      obj.picture = load_image("game/materials/images/test/spr_qdwdqwd.png")
      obj.title = load_image("game/materials/images/test/spr_jld.png")
      obj.m = love.audio.newSource("game/materials/sound/music/Ars_Sonor_-_04_-_Nitynitya_Vastu_Viveka.mp3", "stream")
      soundmanager:playMusic(obj.m)
      obj.time = 0
      obj.line1 = {}
      obj.line2 = {}
      return obj
    end;
    u = function(self,dt)
      if controller.wasPressed("a") then trans(T_normal,StageRoom) end
    end;
    d = function(self)
      self.time = self.time + 1

      love.graphics.setColor(ASE.FRENCHGRAY)
      love.graphics.rectangle("fill",0,0,320,240)
      love.graphics.setColor(ASE.GREEN)
      love.graphics.setLineStyle( "rough")
      love.graphics.setLineWidth(1)
      love.graphics.setColor(ASE.WHITE)
      
      for y = 1,1 do
        for x = 1, 20 do
          if math.random(1,10)>9 then
            love.graphics.setLineWidth(4)
            love.graphics.setColor(ASE.ORANGE)
          end
            self.line1[x*2-1] = (x-1)*16
            self.line1[x*2] = 16*math.sin(x+self.time/10) +16*11
            self.line2[x*2-1] = 320-(x-1)*16
            self.line2[x*2] = 16*math.sin(x-self.time/10) +16*4
            love.graphics.line(self.line1[x*2-1],self.line1[x*2],self.line1[x*2-1],self.line1[x*2]+320)
            love.graphics.line(self.line2[x*2-1],self.line2[x*2],self.line2[x*2-1],self.line2[x*2]-320)

            love.graphics.setColor(ASE.GREEN)
            love.graphics.setLineWidth(1)
          
        end
        love.graphics.line(self.line1)
        love.graphics.line(self.line2)
      end
      love.graphics.setColor(ASE.WHITE)

      --love.graphics.draw(self.picture,0,0,0)
      love.graphics.draw(self.title,160,120+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)


      love.graphics.circle("line",m_x,m_y,12 + (m_y-240)/10)

    end;

    dg = function(self)
    end;
}

-- Stage
StageRoom = {
    new = function(property)
      local obj = instance(StageRoom,BasicRoom,property)
      obj.frame = 0
      obj.name = "stage"
      --obj.m = love.audio.newSource("game/materials/sound/music/Ars_Sonor_-_04_-_Nitynitya_Vastu_Viveka.mp3", "stream")
      --soundmanager:playMusic(obj.m)
      love.audio.pause()
      obj.time = 0
      obj.char = O_Circle.new(200,200)

      Top_Block.new(0,0,320*4,16)
      Top_Block.new(0,0,16,240*4)
      Top_Block.new(0,240*4-16,320*4-16,16)
      Top_Block.new(320*4-16,0,16,240*4-16)

      for i=0,32 do
        Top_Block.new(math.random(320*4),math.random(320*4),64,64)
      end

      obj.sub = Top_Circle.new(300,100,4*16)
      Top_Polygon.new(400,400, 400,500, 500,550,500,350)

      maincam:setWorld(-320*8,-240*8,320*16,240*16)
      
      obj.canvas = love.graphics.newCanvas(320*4,240*4)
      obj.canvas:setFilter("nearest")
      return obj
    end;

    draw = function(self)

  
      
      local cav = love.graphics.getCanvas()
      love.graphics.push()
      love.graphics.origin()
      love.graphics.setScissor()
      love.graphics.setCanvas(self.canvas)
      love.graphics.setColor(ASE.WHITE)
      love.graphics.setLineStyle("rough")
      love.graphics.circle("line",320,240,24)  --??????
      --love.graphics.circle("line",self.char.pos.x,self.char.pos.y,4)
      --print(self.char.pos.x,self.char.pos.y)--0~480 0~320
      --print(self.canvas:getFormat())
      love.graphics.pop()
      love.graphics.setCanvas(cav)
      
      love.graphics.setColor(ASE.GRAY)
      love.graphics.rectangle("fill",maincam.x/2,maincam.y/2,320*4,240*4)
      love.graphics.setColor(ASE.WHITE)
      love.graphics.draw(self.canvas,0,0,0,1,1,0,0)
      love.graphics.setColor(ASE.FRENCHGRAY)
      love.graphics.rectangle_c("fill",W/2,H/2,160,120)
      love.graphics.rectangle_c("fill",W/2*3,H/2*3,160,120)
      love.graphics.setColor(ASE.GREEN)
      love.graphics.rectangle_c("fill",W/2,H/2*3,160,120)
      love.graphics.rectangle_c("fill",W/2*3,H/2,160,120)

      BasicRoom:draw()
      
    end;
}

--object
O_Circle = {
  new = function(x,y)
    local obj = instance(O_Circle,Top_Char,x,y)
    obj.name = "circle"
    obj.pos = Vector.new(x,y)
    obj.time = 0
    obj.posTable = {}
    obj.vpos = Vector.new(0,0)
    obj.solid = HC.rectangle(obj.pos.x,obj.pos.y,obj.w,obj.h)
    --obj.solid = HC.circle(obj.pos.x,obj.pos.y,16)
    obj.solid.other = obj
    obj.angle = 0

    obj.tww = {scale = 1}
    obj.tween = tween.new(1/5, obj.tww, {scale = 1}, tween.easing.outBounce)

    obj.cam_angle = 0
    obj.cam_vangle = 0
    obj.cam_aangle = 0

    obj.view = O_TopView.new(obj)

    obj.saveDelta = nil
    obj.collidable = true --collisionとのcollisionは1stepに一度のみ
    
    --obj.object = TextWindow.new(nil,{"あいうえおかきくけこさしすせそたちつてと","あいうえおかきくけこさしすせそたちつてと","あいうえおかきくけこさしすせそたちつてと"},W/2,H/2,W-20,70,10)
    
    return obj
  end;

  step = function(self,dt)
    


    if(love.keyboard.isDown("e"))then
      self.tween = tween.new(1/5, self.tww, {scale = 0.6}, tween.easing.outBounce)
    else
      self.tween = tween.new(1/5, self.tww, {scale = 1}, tween.easing.outBounce)
    end
    maincam:setScale(self.tww.scale)
    self.tween:update(dt)

    if(love.keyboard.isDown("k"))then
      trans(T_normal,StageRoom)
    end

    --[[
    
    if controller.isDown("right")then self.vpos = self.vpos + Vector.new(0.1,0)end;
    if controller.isDown("left")then self.vpos = self.vpos + Vector.new(-0.1,0)end;
    if controller.isDown("up")then self.vpos = self.vpos + Vector.new(0,-0.1)end;
    if controller.isDown("down")then self.vpos = self.vpos + Vector.new(0,0.1)end;
    --if true then self.vpos = self.vpos + Vector.new(1,0)end;
    ]]

    local sum = 0.3

    if controller.isDown("right")then self.angle = self.angle + 0.1 end;
    if controller.isDown("left")then self.angle = self.angle - 0.1 end;

    if controller.isDown("up")then self.vpos = self.vpos + Vector.new(sum*math.cos(-self.angle),-sum*math.sin(-self.angle))end;
    if controller.isDown("down")then self.vpos = self.vpos - Vector.new(sum*math.cos(-self.angle),-sum*math.sin(-self.angle))end;
    
    if controller.isDown("l1")then 
      TestShot.new(self.pos.x,self.pos.y,18*math.cos(-self.angle),-18*math.sin(-self.angle)) 
      soundmanager:play(ADDRESS.se .. "se_shot.wav")
    end

    if self.object ~= nil then
      self.object:update(dt)
      if self.object.kill == true then self.object = nil end
    end

    local distance = self.angle - self.cam_angle

    ---暫定ゲイン
    local pgain = 1/20
    local dgain = 1/20
    
    local aangle = distance*pgain+distance*self.cam_vangle*dgain

    ---加速度加算
    local vangle = self.cam_vangle + aangle
    self.cam_angle = self.cam_angle + vangle
    --maincam:setAngle(self.cam_angle + math.pi/2)

    self.pos = self.pos + self.vpos
    self.vpos = self.vpos*0.95
    

    if #self.posTable >102 then table.remove(self.posTable, 102) end

    table.insert(self.posTable,1,self.pos)

    self.time = self.time + 1
    
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

            Smoke.new(self.pos.x,self.pos.y)
            testEffect.new(self.pos.x,self.pos.y)
            print(delta.x,delta.y)
            self.vpos = -1*projection + vertic
            --self.vpos = vertic
            self.pos = self.pos + delta
            
            --self.pos = self.pos + self.vpos*0.1
            soundmanager:play("game/materials/sound/se/se_walk.wav")
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
    love.graphics.setColor(ASE.WHITE)

    if self.saveDelta ~= nil then 
      self.saveDelta = self.saveDelta:normalized()*32
      local perpendicular = self.saveDelta:perpendicular()
      love.graphics.line(self.pos.x,self.pos.y,self.pos.x+self.saveDelta.x,self.pos.y+self.saveDelta.y)
      --love.graphics.line(self.pos.x,self.pos.y,self.pos.x+perpendicular.x,self.pos.y+perpendicular.y)
    end 
    
    
    local normal = self.vpos:perpendicular():normalize()*5
    --love.graphics.circle("line",self.pos.x+normal.x,self.pos.y+normal.y,2)
    --love.graphics.circle("line",self.pos.x-normal.x,self.pos.y-normal.y,2)
    love.graphics.circle("line",self.pos.x + 16*math.cos(-self.angle),self.pos.y - 16*math.sin(-self.angle),2)

    if #self.posTable > 98  then
      for i = 1, 98 do
        --love.graphics.circle("line",self.posTable[i].x,self.posTable[i].y,4+self.vpos:len())

        love.graphics.setLineStyle("rough")
        
        if(self.posTable[i+2] ~= nil) then
          local p = Vector:new()
          local p2 = Vector:new()
          p = (self.posTable[i+1]-self.posTable[i]):normalize():perpendicular()*12 - self.vpos:len()*Vector.new(math.cos((self.time+i)/math.pi),math.sin((self.time+i)/math.pi))
          p2 = (self.posTable[i+2]-self.posTable[i+1]):normalize():perpendicular()*12 - self.vpos:len()*Vector.new(math.cos((self.time+i)/math.pi),math.sin((self.time+i)/math.pi))
          
          love.graphics.line(self.posTable[i].x,self.posTable[i].y,self.posTable[i].x+p.x,self.posTable[i].y+p.y)
          love.graphics.line(self.posTable[i].x,self.posTable[i].y,self.posTable[i].x-p.x,self.posTable[i].y-p.y)
          
        love.graphics.line(self.posTable[i+1].x+p2.x,self.posTable[i+1].y+p2.y,self.posTable[i].x+p.x,self.posTable[i].y+p.y)
        love.graphics.line(self.posTable[i+1].x-p2.x,self.posTable[i+1].y-p2.y,self.posTable[i].x-p.x,self.posTable[i].y-p.y)
        --p2 = (self.posTable[1]-self.posTable[i]):perpendicular():normalize()
        --love.graphics.setColor(math.random(255),math.random(255),math.random(255))
        --love.graphics.line(self.posTable[1].x,self.posTable[1].y,self.posTable[i].x,self.posTable[i].y)
        --love.graphics.line(self.posTable[i].x,self.posTable[i].y,self.posTable[i].x-p2.x,self.posTable[i].y-p2.y)
        if(i==98) then 
          --local a = 
            --love.graphics.line(self.posTable[i+2].x+p2.x,self.posTable[i+2].y+p2.y,self.posTable[i+2].x-p2.x,self.posTable[i+2].y-p2.y)
        end
        if(i==1) then 
          --local a = 
            --love.graphics.line(self.posTable[i].x+p2.x,self.posTable[i].y+p2.y,self.posTable[i].x-p2.x,self.posTable[i].y-p2.y)
        end
      end
    end
            
  end
    
  end;
  drawGUI = function(self)
    if self.object ~= nil then self.object:drawGUI() end
  end
}

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
  --メトロヴァニア的な当たり判定
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
      g.setColor(255,0,0,128)
      self.solid:draw("fill")
      g.setColor(255,255,255,255)
    end
  end;
};