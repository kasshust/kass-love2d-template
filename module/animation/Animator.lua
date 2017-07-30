---　画像を読み込む
function load_image(_filename)
    Image = love.graphics.newImage(_filename)
    min, mag = Image:getFilter()
    Image:setFilter('nearest','nearest')
    return Image
end

--- 分割したquadを返す
function split_image(_split_x,_split_y,_image_x,_image_y,_gs,_ygs)
    local _gs = _gs
    local _ygs = _ygs or _gs
    quadList = {}
    for y= 0 ,_split_y-1 do
        for x = 0,_split_x-1 do
            table.insert(quadList,love.graphics.newQuad(x*_gs,y*_ygs,_gs,_ygs,_image_x,_image_y))
        end
    end

    return quadList
end

--[[
  Animator スプライトシートのアドレス,終了開始地点と名前を与えて制御
  change後はisrenewとisfinishが呼ばれなくなる問題もある

]]
Animator = {
  new = function(image,_xGS,_yGS,start,finish,speed,dafault)
    local obj = instance(Animator)
      xGS = _xGS
      yGS = _yGS or _xGS

      obj.image = image

      --imageのquadを作成
      obj.quad = split_image(math.floor(image:getWidth()/xGS),math.floor(image:getHeight()/yGS),image:getDimensions(),image:getDimensions(),xGS,yGS)
      --frame
      obj.frame = 0
      --quadNumを初期化
      obj.quadNum = 1
      --アニメーションスピード
      obj.speed = speed or 60
      --アニメーション状態のtable
      obj.state = {}


      --初期状態の設定
      obj.nowstate = default or "default"
      obj.state[obj.nowstate] = {}
      obj.state[obj.nowstate]["start"] = start
      obj.state[obj.nowstate]["finish"] = finish

      --前回のstart,finish値
      obj.pre = {}
      obj.pre.start = start
      obj.pre.finish = finish
      obj.pre.num = obj.quadNum
      ---終了判定・更新判定
      obj.finish = {bool = false,state = nil}
      obj.renew = {bool = false,state = nil,num = nil}
    return obj
  end;
  add = function(self,newstate,start,finish)
    self.state[newstate] = {}
    self.state[newstate]["start"] = start
    self.state[newstate]["finish"] = finish
  end;
  --speed
  setSpeed = function(self,sp)
    self.speed = sp
  end;
  --現在のstateのstartにリセット
  reset = function(self)
    self.frame = 0
    self.quadNum = self.state[self.nowstate]["start"]
  end;
  --終了判定 1frameならfalse
  isfinish = function(self,state)
    if state == nil then return self.finish.bool,self.finish.state end

    if self.finish.state == state and self.finish.bool == true then
      return true
    else return false
    end
  end;
  --更新判定 指定ナンバーである場合trueを返す 1frameならfalse
  isrenew = function(self,num,state)
    if state == nil then return self.renew.bool,self.renew.state end

    if self.renew.state == state and self.renew.bool == true and self.renew.num == num then
      return true
    else return false
    end
  end;
  --stateを変更し、初期化する
  change = function(self,nextstate)
    if self.nowstate ~= nextstate then self:reset() end
    self.nowstate = nextstate
    --frameを初期化
    return true
  end;
  update = function(self,dt)
    --終了判定
      local start = self.state[self.nowstate]["start"]
      local finish = self.state[self.nowstate]["finish"]

      --quadの更新
      self.frame = self.frame + 1;
      self.quadNum = self:animation(self.frame,start,finish,60/self.speed)

      --判定初期化
      self.finish = {bool = false,state = nil}
      self.renew = {bool = false,state = nil,num = nil}
      --stateが変化していない
      if start == self.pre.start and finish == self.pre.finish then

        --現在のnumが前回のnumと異なる　->
        if self.quadNum ~= self.pre.num then
          self.renew.bool = true
          self.renew.state = self.nowstate
          self.renew.num = self.quadNum
        end
        --現在のnumが前回のnumよりも小さい -> animationの終了判定
        if self.quadNum < self.pre.num then
          self.finish.bool = true
          self.finish.state = self.nowstate
        end
      end

    self.pre.start = start
    self.pre.finish = finish
    self.pre.num = self.quadNum
  end;
  draw = function(self,x,y,_angle,_xscale,_yscale,_ox,_oy,_kx,_ky)
    local angle = _angle or 0
    local xscale = _xscale or 1
    local yscale = _yscale or 1
    local ox = _ox or 0
    local oy = _oy or 0
    local kx = _kx or 0
    local ky = _ky or 0
    love.graphics.draw(self.image,self.quad[self.quadNum],x,y,angle,xscale,yscale,ox,oy,kx,ky)
  end;
  animation = function(self,frame,start,finish,speed)
      ---前回とアニメーションの開始位置が違う場合、アニメーションフレームを初期化
      local num = math.floor(frame / speed % (finish - start + 1)) + start
      return num
  end;
}
