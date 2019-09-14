-- Playerのマネージャー
M_Player = {
    new = function()
      local obj = instance(M_Player,GameManager)
        
        obj.player = nil

      return obj
    end;
    update = function(self,dt)
        if self.player ~= nil then
            if self.player.life < 0 then
              trans(T_normal, Room_GomGameTitle)
            end
          end
    end;

    getPlayer = function(self)
        if self.player ~= nil then return self.player
        else return nil end
    end;

    setPlayer = function(self,player)
        if self.player == nil then 
            self.player = player
        else 
            print("M_Player:すでにplayerが入ってます -> ",self.player)
        end
    end;

    resetPlayer = function(self)
        self.player = nil
    end;

    drawGUI = function(self)
        if self.player ~= nil then
            for i = 0 , self.player.life do 
                g.setColor(ASE.PURPLE)
                love.graphics.circle("fill", g_x + i*16 + 30, g_y + 30, 8, 4)
                g.setColor(ASE.WHITE)
            end
        end

        local  width , height = 128 , 128
        local dx,dy = W - width, H - height
        --self:drawMap(dx,dy,width,height)

    end;

    drawMap = function(self,x,y,width,height)
        --地図
        local l,t,w,h = maincam:getWorld() 

        g.setColor(ASE.SALMON)
        love.graphics.rectangle("fill",g_x + x,g_y + y,width,height)

        g.setColor(ASE.RED)
        if self.player ~= nil then
            local pos = self.player.pos / Vector.new(w,h) * Vector.new(width,height)
            love.graphics.circle("line",g_x + x + pos.x,g_y + y + pos.y,3,3)
        end
        
        g.setColor(ASE.WHITE)
        for i,v in pairs(ObjectTable) do
            local pos = v.pos / Vector.new(w,h) * Vector.new(width,height)
            love.graphics.points(g_x + x + pos.x,g_y + y + pos.y)

        end
    end

};
