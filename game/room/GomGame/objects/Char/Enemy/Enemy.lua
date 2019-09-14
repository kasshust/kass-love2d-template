
-- エネミー親クラス
O_Enemy = {
    new = function(x,y)
      local obj = instance(O_Enemy,Object,x,y)
      table.insert(EnemyTable,obj)
      
      --継承時に探索用のため必要
      obj.name = "O_Enemy"
      obj.tag = {"enemy"}
  
      obj.pos = Vector.new(x,y)
      obj.vpos = Vector.new(0,0);    
      obj.solid = HC.circle(x,y,48)
      obj.solid.other = obj

      -- 壁判定を行うか
      obj.collidable = true
  
      -- オブジェ判定を行うか
      obj.objhit = true

      obj.frame = 0

      return obj
    end;
  
    step = function(self,dt)
      self.frame = self.frame + 1  
    end;
  
    collision = function(self)  
      self.solid:moveTo(self.pos.x,self.pos.y)
      self:collideWithWall()
      -- プレイヤーの攻撃との当たり
    end;

    --[[各衝突処理]]
    -- 壁との衝突処理
    collideWithWall = function(self)
      --　壁との衝突
      self:collideWith("top_collision",self.solid,function(other,delta)
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

    collideWithPlayerAttack = function(self,f)
      --　プレイヤーの攻撃との衝突
      self:collideWith("playerAttack",self.solid,function(other,delta)
        if self.objhit == true then
          f()
        end
      end)
    end;

    -- プレイヤーの弾と接触時呼ばれる
    damage = function(self)
      soundmanager:play(ADDRESS.se .. "se_explosion2.wav")
      testEffect.new(self.pos.x,self.pos.y)
      --g_camStand:shake(10,4,4)
      Smoke.new(self.pos.x,self.pos.y)
      O_Effect.new(self.pos.x,self.pos.y)
      self.kill = true
    end;
  }

