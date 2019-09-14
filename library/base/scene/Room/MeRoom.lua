------------------------メトロヴァニア用-------------------
--これを参考に継承して作ればええよ
MeRoom = {
  new = function(property)
    local obj = instance(MeRoom,Scene,property)
    obj.frame = 0
    obj.name = "メトロヴァニア"
    obj.pause = false ---objectのupdateを停止する
    obj.bg = {} ----ばっぐぐらうんど　canvasを作成して  登録、drawで表示
    return obj
  end;
  update = function(self,dt)
    self:staticObjectUpdate(dt)
    if not self.pause then self:objectUpdate(dt) end
    self.frame = self.frame + 1
  end;
  draw = function(self)
    --例

    --背景
    if self.map.layers["bg"] ~= nil then
      self.map.layers["bg"].x ,self.map.layers["bg"].y  = g_maincam.x/4,g_maincam.y/4
      self.map.layers["bg"]:draw()
    end

    --オブジェクト
    self:objectDraw();
    --タイル
    if self.map ~= nil then self.map:draw() end
    --背景
  end;
  drawGUI = function(self)
    self:objectDrawGUI()
  end;
  objectUpdate = function(self,dt)
    --オブジェクトのupdate
    for i,v in pairs(ObjectTable) do
      local dis = (math.pow(g_maincam.x - v.pos.x,2) + math.pow(g_maincam.y - v.pos.y,2) )^0.5
      --if dis < 400 or v.persist == true then
        v:update(dt)
      --end
      if v.kill == true then v:destroy() end
    end
  end;
  objectDraw = function(self)
    for i,v in ipairs(StaticObjectTable) do
      v:draw()
    end

    local t = {}
    for i,v in pairs(ObjectTable) do
       local dis = (math.pow(g_maincam.x - v.pos.x,2) + math.pow(g_maincam.y - v.pos.y,2) )^0.5
      if dis < 300 or v.persist == true then table.insert(t,v) end
    end

    table.sort(t,function(a,b)
    return (a.depth > b.depth)end )

    for i,v in pairs(t) do
      v:draw()
    end
  end;
}
