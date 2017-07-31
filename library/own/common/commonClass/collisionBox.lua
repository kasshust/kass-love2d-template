----クラス
--CollisionBox  各オブジェクト内で生成　set() colliderect()で判定
CollisionBox = {}
CollisionBox.new = function(x,y,width,height,d_x,d_y)
    local obj ={}
    obj.x = x
    obj.y = y
    obj.width = width
    obj.height = height
    obj.count = 0

    --ズレ
    obj.d_x = d_x or 0
    obj.d_y = d_y or 0
    --box
    obj.box_left = obj.x + obj.d_x
    obj.box_right = obj.x + obj.d_x + obj.width
    obj.box_top = obj.y + obj.d_y
    obj.box_bottom = obj.y + obj.d_y + obj.height

    obj.set = function(self,x,y)
        self.x = x
        self.y = y

        -----boxの設定
        self.box_left = self.x + self.d_x
        self.box_right = self.x  + self.d_x + self.width
        self.box_top = self.y + self.d_y
        self.box_bottom = self.y + self.d_y + self.height

        self.count = 0
    end
    obj.colliderect = function(self,diffBox)
        if self.box_left < diffBox.box_right and
                self.box_top < diffBox.box_bottom and
                self.box_right > diffBox.box_left and
                self.box_bottom > diffBox.box_top then

            self.count = self.count + 1
            return self.count
        else
            return self.count
        end
    end
    obj.col_draw = function(self)
        love.graphics.setColor(255,0,0,128)
        love.graphics.rectangle("fill",self.box_left,self.box_top,self.width,self.height)
        love.graphics.setColor(255,255,255,255)
    end

    return setmetatable(obj,{__index = CollisionBox})

end