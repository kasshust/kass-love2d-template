--PreRoom--　初期化用ルーム
PreRoom = {
  new = function(property)
    local obj = instance(PreRoom,OtherRoom,property)
    --このゲームのマネージャーを登録

    -------初期設定--------------------------------
    --標準フォント設定
    font = love.graphics.newFont( "game/materials/fonts/PixelMplus12-Regular.ttf" , 12 )
    font:setFilter( "nearest", "nearest", 1 )
    love.graphics.setFont(font);

    --スプライトシートの読み込み(ゲーム別)
    sprite = {}
    sprite.test1 = load_image("game/materials/images/test/sprite_test.png")
    sprite.test2 = load_image("game/materials/images/test/spr_test.png")
    sprite.test3 = load_image("game/materials/images/test/spr_test2.png")

    --manager作成
    manager:apply(Manager_banka.new())
    if(DEBUG) then trans(T_normal,DebugRoom,{})end
    return obj
  end;
  u = function(self,dt)
    --なんかムービーとかロゴとか
  end;
  dg = function(self)
    g.print("なんかロゴとか",0,H/2)
  end;
}

--Title--
Title = {}

--Game Room--
BankaRoom = {
  new = function(property)
    local obj = instance(BankaRoom,Scene,property)
    obj.frame = 0
    if property == nil then error("This bankaroom is invalid") end
    obj.name = property["name"] --ルーム名

    --BGM
    if property["music"] ~= nil then
      obj.m = love.audio.newSource(property["music"], "stream")
      soundmanager:playMusic(obj.m)
    else
      love.audio.stop()
    end

    obj.pause = false --objectのupdateを停止する 使ってない
    obj.bg = {} --ばっぐぐらうんど　canvasを作成して 登録、drawで表示

    --マップ作成
    obj.map = sti(property.map, {})
    obj.size = {width = obj.map.width*16,height = obj.map.height*16}
    maincam:setWorld(0,0,obj.size.width,obj.size.height)

    ------------------------------------------------------------------

    local name = "col"
    local col = {}
    for y = 1,obj.map.height do
      col[y] = {}
      if obj.map.layers[name].data[y] ~= nil then
        for x = 1,obj.map.width do
          if obj.map.layers[name].data[y][x] ~= nil then
            col[y][x] = 1
          else
            col[y][x] = 0
          end
        end
      else
        for x = 1,obj.map.width do
          col[y][x] = 0
        end
      end
    end

    --[[
    local d = {}
    for i,v in pairs(col) do
      d[i] = ""
      for j,p in pairs(v) do
        d[i] = d[i] .. p .. ","
      end
    end

    for i,v in pairs(d) do
      print(v)
    end
    ]]

    --探索済みか?
    local search = {}
    for y = 1,obj.map.height do
      search[y] = {}
      for x = 1,obj.map.width do
        search[y][x] = 0
      end
    end

    local function check(x,y)
      --限界を越えてたらfalse
      if x > obj.map.width or y > obj.map.height then return false end
      --策定
      return col[y][x] == 1
    end

    local function makeRect(xstart,ystart)
      --例外で最初が0ならw,h=0,0で抜ける
      if not check(xstart,ystart) then return 0,0 end

      local cx,cy = xstart,ystart
      local xend,yend = xstart,ystart

      cx = cx + 1

      while(1) do

        --０に衝突 y探索へ
        if not check(cx,cy) then
          search[cy][cx] = 1

          xend = cx - 1

          cy = cy + 1

          while(1) do

            local bool = false
            for i = xstart,xend do
              --0に衝突 ループを抜け xend yend確定
              if not check(i,cy) then bool = true do break end end
            end

            --0があった
            if bool then
              yend = cy - 1
              do break end;
            else
              --0がなかった
              for i = xstart,xend do
                search[cy][i] = 1
              end
              cy = cy + 1
            end
          end

          do break end;

          --clock
        else search[cy][cx] = 1 cx = cx + 1 end

      end

      return xend - xstart + 1,yend - ystart + 1

    end

    obj.rectanges = {}

    for y = 1,obj.map.height do
      for x = 1,obj.map.width do
        --探索済みじゃない
        if search[y][x] == 0 then
          w,h = makeRect(x,y)
          if w ~= 0 and h ~= 0 then
            table.insert(obj.rectanges,{x,y,w,h})
            Block.new(x*16-16,y*16-16,w*16,h*16)
          end
        end
      end
    end

    -----------------------------------------------------------------------

    --eventに送るプロパティ
    local ev_property = {}

    --地形読み込み
    obj:create(obj.map.layers.block,function(o)
        Block.new(o.x,o.y,o.width,o.height)
      end)
    obj:create(obj.map.layers.floor,function(o)
        Floor.new(o.x,o.y,o.width,4)
      end)
    obj:create(obj.map.layers.slope,function(o)
        Slope.new(o.polygon)
      end)
    --char読み込み
    obj:create(obj.map.layers.enemy,function(o)
        BankaEnemy[o.name][o.properties["type"]].new(o.x,o.y)
      end)

    -- property経由プレイヤー
    obj:create(obj.map.layers.door,function(o)
        TouchDoor.new(o.x,o.y,o.properties["room"],o.properties["num"])
        if manager.game.player.num == o.name then
          --managerのプレイヤーを上書き
          ev_property["player"] = {x = o.x + 8, y = o.y + 8}
          return true
        end
      end)

    ---room開始----
    --イベント読み込み
    property["event"](ev_property)

    return obj
  end;
  update = function(self,dt)
    self:staticObjectUpdate(dt)
    if not self.pause then self:objectUpdate(dt) end
  end;
  draw = function(self)
    --背景
    if self.map.layers["bg"] ~= nil then
      self.map.layers["bg"].x ,self.map.layers["bg"].y = maincam.x/4,maincam.y/4
      self.map.layers["bg"]:draw()
    end

    --b layer
    if self.map.layers["b1"] ~= nil then
      self.map.layers["b1"]:draw()
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

  --override
  objectUpdate = function(self,dt)
    --オブジェクトのupdate
    for i,v in pairs(ObjectTable) do
      local dis = (math.pow(maincam.x - v.pos.x,2) + math.pow(maincam.y - v.pos.y,2) )^0.5
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
      local dis = (math.pow(maincam.x - v.pos.x,2) + math.pow(maincam.y - v.pos.y,2) )^0.5
      if dis < 300 or v.persist == true then table.insert(t,v) end
    end

    table.sort(t,function(a,b)
        return (a.depth > b.depth)end )

      for i,v in pairs(t) do
        v:draw()
      end
    end;
    create = function(self,var,f)
      if var ~= nil then
        for k ,o in pairs(var.objects) do
          f(o)
        end
      end
    end;
  }

  --Debug Room--
  DebugRoom = {
    new = function(property)
      local obj = instance(DebugRoom,OtherRoom,property)
      obj.frame = 0
      obj.name = "banka"
      obj.s = Select.new(1,5)
      obj.tw = {num = 1}
      obj.tween = tween.new(0.1,obj.tw, {num = obj.s.now}, tween.easing.outBounce)
      obj.picture = load_image("game/materials/images/test/sprite_test2.png")
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
          trans(T_normal,BankaRoom,BankaMap["debug1"])
        end
        switch[2] = function()
          trans(T_normal,BankaRoom,BankaMap["debug2"])
        end
        switch[3] = function()
          trans(T_normal,BankaRoom,BankaMap["debug3"])
        end
        switch[4] = function()
          trans(T_normal,BankaRoom,BankaMap["debug4"])
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

      g.draw(self.picture,32,0,0,2,2)

      local t = "Banka"
      g.printf(t,W - 130,H-20,200,"left")

      ---text
      local text = {"Metorovania1","Metorovania2","c","d","e"}
      local explain = {"debug1へ","debug2へ","debug3へ","debug4へ","梨"}

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
