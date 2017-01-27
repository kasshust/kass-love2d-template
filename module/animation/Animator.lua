function animation(frame,start,finish,speed)
    local animeframe
    animeframe = math.floor(frame / speed % (finish - start + 1)) + start
    return animeframe
end

Animator = {}
Animator.new = function()
    local obj = {}
    obj.pre_frame = 0
    obj.a_frame = 0
    obj.pre_start = 0
    obj.pre_finish = 0
    obj.finish = false

    obj.animation =  function(self,start,finish,speed)
        ---前回とアニメーションの開始位置が違う場合、アニメーションフレームを初期化
        if start == finish then end

        if not (self.pre_start == start and self.pre_finish == finish) then self.a_frame = 0  end
        local c_frame = animation(self.a_frame,start,finish,speed)
        self.pre_start = start
        self.pre_finish = finish

        -----フレーム更新
        self.a_frame = self.a_frame + 1;

        ------アニメーションの終わりを判定

        if start <= c_frame and finish >= c_frame and c_frame < self.pre_frame then
            self.finish = true
        else
            self.finish = false
        end

        self.pre_frame = c_frame

        return c_frame

    end
    obj.animation_finish = function(self)
        return self.finish
    end

    return setmetatable(obj, { __index = Animator })
end
