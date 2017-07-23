camera = {}

----------エフェクトテーブル作成
camera.effectTable = {} ----描画前エフェクト
camera.effectTableEnd = {}  ----描画後エフェクト

camera.effect = {}
camera.effect.draw = function(self)
    for i, v in ipairs(camera.effectTable) do
        v:update()

        --------ｖ指定のtable削除がうまくいかない
        if v.kill == true then table.remove(camera.effectTable,i) end
    end
end
camera.effect.drawEnd = function(self)
    for _, v in ipairs(camera.effectTableEnd) do
        v:update()
        --------ｖ指定のtable削除がうまくいかない
        if v.kill == true then table.remove(camera.effectTableEnd) end
    end
end

----------

camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.timer = 0

camera._bounds = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }

camera.WIDTH = 320 * camera.scaleX
camera.HEIGHT = 240 * camera.scaleY

function camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
    love.graphics.translate(-self.x, -self.y)
end
function camera:unset()
    love.graphics.pop()
end
function camera:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
end
function camera:rotate(dr)
    self.rotation = self.rotation + dr
end
function camera:scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
end
function camera:setPosition(x, y)
    self.x = x or self.x
    self.y = y or self.y
    camera:clamp()  ----clamp
end
function camera:setScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end
function camera:newLayer(scale, func)
    table.insert(self.layers, { draw = func, scale = scale })
    table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end
function camera:ResetLayer()
    camera.layers = nil
    camera.layers = {}
end
function camera:draw()
    local bx, by = self.x, self.y

    for _, v in ipairs(self.layers) do
        self.x = bx * v.scale
        self.y = by * v.scale
        camera:set()
        camera.effect:draw()
            v.draw()
        camera.effect:drawEnd()
        camera:unset()
    end
end

----エフェクト

---揺らす
 function camera:Shake(width,height,time,period)
    local obj = {}
    obj.kill = false
    obj.width = width or 2
    obj.height = height  or 2
    obj.time = time or 2
    obj.period = period or 2
    obj.x = self.x
    obj.y = self.y

    obj.update = function(self)
        if self.time <= 0 then self.kill = true end
        if self.time > 0 then self.time = self.time - 1 end
        love.graphics.translate(self.width*math.sin(self.time * self.period),self.height*math.cos(self.time * self.period))
        self.time = self.time - 1
    end

    table.insert(camera.effectTable,obj)
end
---拡大 未
function camera:Expansion(time,size)
    local obj = {}
    obj.kill = false

    obj.time = self.time or 1
    obj.size = self.size or 1.13
    obj.x = self.x
    obj.y = self.y

    obj.update = function(self)

        if self.time <= 0 then self.kill = true end
        if self.time > 0 then self.time = self.time - 1 end
        love.graphics.scale((self.size),(self.size))
        self.time = self.time - 1
    end

    table.insert(camera.effectTable,obj)
end
---フラッシュライト
function camera:FlashLight(time)
    local obj = {}
    obj.kill = false
    obj.time = self.time or 1

    obj.update = function(self)

        ----フラッシュライトのカラーを設定
        love.graphics.setColor(255,255,255,255)
        love.graphics.rectangle("fill",-100,-100,2000,2000)
        if self.time <= 0 then self.kill = true end
        if self.time > 0 then self.time = self.time - 1 end

        self.time = self.time - 1
    end

    table.insert(camera.effectTableEnd,obj)

end

-----稼働域
function camera:getBounds()
    return unpack(self._bounds)
end
function camera:setBounds(x1, y1, x2, y2)
    self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end
function camera:clamp()
    local x1 = self._bounds["x1"]
    local x2 = self._bounds["x2"]
    local y1 = self._bounds["y1"]
    local y2 = self._bounds["y2"]
     self.x = math.clamp(self.x,x1,x2)
     self.y = math.clamp(self.y,y1,y2)
end