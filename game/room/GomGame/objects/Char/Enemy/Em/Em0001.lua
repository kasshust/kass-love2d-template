--[[
    タコ
]]

O_Em0001 = {
    new = function(x,y)
      local obj = instance(O_Em0001,O_Enemy,x,y)
      --継承時に探索用のため必要
      obj.name = "O_Em0001"
      obj.solid = HC.circle(x,y,128)
      obj.solid.other = obj

      table.insert(obj.tag,"Em0001")
      return obj
    end;

    step = function(self,dt)
      O_Enemy.step(self,dt)

      --move
      local p = g_manager.game.playerManager:getPlayer()

      if p ~= nil then
        local dist = p.pos - self.pos
        self.vpos = dist:normalized()
        self.pos = self.pos + self.vpos
      end

      if self.frame % 10 == 0 then
        -- self:shot()
      end

    end;

    shot = function(self)
      local shot = O_EnemyShot.new(self.pos.x,self.pos.y)
      shot.vpos = self.vpos*10
    end;

    collision = function(self)
      O_Enemy.collision(self)
      self:collideWith("enemy",self.solid,function(other,delta)
        if(self.collidable) then

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
            else
              self.pos = self.pos + delta
            end
        end
      end)
    end;

    draw = function(self)
        love.graphics.setColor(ASE.RED)
        love.graphics.circle("line", self.pos.x, self.pos.y , 128 , 8)
        love.graphics.setColor(ASE.WHITE)
    end;

    damage = function(self)
      soundmanager:play(ADDRESS.se .. "se_explosion2.wav")
      testEffect.new(self.pos.x,self.pos.y)
      --g_camStand:shake(10,4,4)
      Smoke.new(self.pos.x,self.pos.y)
      O_Effect.new(self.pos.x,self.pos.y)
      self.kill = true
    end;
  }