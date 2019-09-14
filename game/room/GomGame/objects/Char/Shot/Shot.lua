-- 弾の親オブジェクト
O_String = {
    new = function(x,y,player)
      local obj = instance(O_String,Object,x,y)
      obj.name = "O_String"
      obj.tag = {"string"}
      obj.player = player

      obj.wight = 10
      
      -- 何に対して判定があるか随時追加
      obj.playerShot = false
      obj.enemyShot = false
    
      obj.pos = Vector.new(x,y)
      obj.vpos = Vector.new(0,0);    
      obj.solid = HC.rectangle(x,y,6,4)
      obj.solid.other = obj
      obj.gom = true
  
      obj.frame = 0
  
      return obj
    end;
  
    step = function(self,dt)

      --　ゴム化時の処理
      if(self.gom and self.player ~= nil ) then
        -- プレイヤーからの偏差
        local hx = self.player.pos.x - self.pos.x
        local hy = self.player.pos.y - self.pos.y
        local gain = self.wight
  
        self.vpos = self.vpos + Vector.new(hx/gain ,hy/gain)/math.log(self.frame + 2)
      end
  
      self.pos = self.pos + self.vpos
  
      self.frame = self.frame + 1
    end;
  
    -- エネミーとの接触時
    collideWithEnemy = function(self,f)
      self:collideWith("enemy",self.solid,function(other,delta)
        if self.playerShot == true then
          other:damage()
          f(other,delta)
        end
      end)
    end;

    -- プレイヤーと接触時
    collideWithPlayer = function(self,f)
      self:collideWith("player",self.solid,function(other,delta)
        if self.enemyShot == true then
          other:damage()
          f(other,delta)
        end
      end)
    end;

    -- 壁にあたったら消える　
    collideWithWall = function(self)
      self:collideWith("top_collision",self.solid,function(other,delta)
        self.pos = self.pos + delta
        testEffect.new(self.pos.x,self.pos.y)
        --g_camStand:shake(10,4,4)
        Smoke.new(self.pos.x,self.pos.y)
        O_Effect.new(self.pos.x,self.pos.y)
        soundmanager:play(ADDRESS.se .. "se_hit.wav")
        self.kill = true
        --　反射
        --[[
          local normal = Vector.new(delta.x,delta.y):normalized()
          if normal.x == normal.x then self.vpos = self.vpos + 2 * (-self.vpos:inner(normal))*normal
          else self.kill =  true end 
        ]]
      end)
    end;
  
  }
  


