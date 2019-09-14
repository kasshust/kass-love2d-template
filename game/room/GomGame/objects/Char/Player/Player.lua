-- プレイヤー
O_Player = {
    new = function(x,y)
      local obj = instance(O_Player,Top_Char,x,y)
      obj.name = "player"
      table.insert(obj.tag,"player")


      obj.life = 5;

      obj.pos = Vector.new(x,y)
      obj.c_pos = Vector.new(x,y)
      obj.prepos = Vector.new(x,y)
      obj.direction = Vector.new(0,0)
      
      obj.time = 0
      obj.posTable = {}
      obj.vpos = Vector.new(0,0)
      obj.solid = HC.rectangle(obj.pos.x-8,obj.pos.y-8,16,16)
      obj.solid.other = obj
  
      obj.image = load_image("game/materials/images/char/pr_00.png")
      obj.image2 = load_image("game/materials/images/char/pr_01.png")
      obj.image3 = load_image("game/materials/images/char/pr_02.png")
      --obj.animator = Animator.new(obj.image,32,32,1,1,1,"default",16,16)
      --obj.animator = Animator.new(obj.image,32,32,1,4)
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
        self.tween = tween.new(1/5, self.tww, {scale = 0.3}, tween.easing.outBounce)
      else
        self.tween = tween.new(1/5, self.tww, {scale = 0.5}, tween.easing.outBounce)
      end
      g_maincam:setScale(self.tww.scale)
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
            self.vpos = self.vpos + (v.pos-self.pos)/(1800)
          end
        end
      end
  
  
      if controller.wasPressed("l1")then 
        --table.insert(self.ball,O_String.new(self.pos.x,self.pos.y,self) )
        --soundmanager:play(ADDRESS.se .. "se_shot.wav")
      end
  
      if controller.wasReleased("r1")then 
        if(not table.empty(self.ball)) then
          self.ball[1].vpos = self.ball[1].vpos * 1.5
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
        if(table.empty(self.ball)) then
          local o = O_Gum.new(self.pos.x,self.pos.y,self)
          o.vpos = self.vpos:normalized()*8.0
          soundmanager:play(ADDRESS.se .. "se_shot.wav")
        end
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
      --g_maincam:setAngle(self.cam_angle + math.pi/2)
  
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
    
      --self.animator:update(dt)
      
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
              --self.vpos = -1*projection + vertic
              self.vpos = vertic
              self.pos = self.pos + delta
              
              --self.pos = self.pos + self.vpos*0.1
              --soundmanager:play("game/materials/sound/se/se_walk.wav")
              self.saveDelta = de
              self.solid:moveTo(self.pos.x,self.pos.y)
              --deltaの表示をする
          else
            self.pos = self.pos + delta
          end
        end
      end)
  
      --self.vpos = self.vpos*0
    end;

    -- ダメージ食らったときのアニメーション遷移とか書く
    damage = function(self)
      soundmanager:play(ADDRESS.se.."se_walk.wav")
      soundmanager:play(ADDRESS.se.."se_explosion.wav")
      g_camStand:shake(10,4,4)
      g_camStand:flashLight(3)
      g_debugger:print("プレイヤー攻撃食らった")
      self.life = self.life - 1
    end;
  
    draw = function(self)
  
      love.graphics.setColor(1, 1.0, 1.0, 1.0)
      --love.graphics.circle("line",self.pos.x,self.pos.y,12,12)

      Sh_Blend:send("image",self.image)
      Sh_Blend:send("angle",self.angle)

      --love.graphics.draw(self.image3,self.pos.x,self.pos.y,self.angle ,1,1,64,64)

      love.graphics.setShader(Sh_Blend)
      love.graphics.draw(self.image2,self.pos.x,self.pos.y,self.angle ,1,1,64,64)
      love.graphics.setShader()
      --love.graphics.draw(self.image,self.pos.x,self.pos.y,0,1,1,32,32)
      
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
        --love.graphics.line(self.pos.x,self.pos.y,self.legs[i].x,self.legs[i].y)
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

