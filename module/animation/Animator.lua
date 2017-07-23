---　画像を読み込む
function load_image(_filename)
    Image = love.graphics.newImage(_filename)
    min, mag = Image:getFilter()
    Image:setFilter('nearest','nearest')
    return Image
end

--- 分割したquadを返す
---
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

Animator = {
  new = function()
    local obj = instance(Animator)
      obj.pre_frame = 0
      obj.a_frame = 0
      obj.pre_start = 0
      obj.pre_finish = 0
      obj._finish = false
    return obj
  end;

  animation = function(frame,start,finish,speed)
      local animeframe
      animeframe = math.floor(frame / speed % (finish - start + 1)) + start
      return animeframe
  end;

  _animation = function(self,start,finish,speed)
      ---前回とアニメーションの開始位置が違う場合、アニメーションフレームを初期化
      if start == finish then end

      if not (self.pre_start == start and self.pre_finish == finish) then self.a_frame = 0  end
      local c_frame = self.animation(self.a_frame,start,finish,speed)
      self.pre_start = start
      self.pre_finish = finish

      -----フレーム更新
      self.a_frame = self.a_frame + 1;

      ------アニメーションの終わりを判定
      if start <= c_frame and finish >= c_frame and c_frame < self.pre_frame then
          self._finish = true
      else
          self._finish = false
      end

      self.pre_frame = c_frame

      return c_frame
  end;
  finish = function(self)
      return self._finish
  end;
}
