---オブジェクト指向用
function instance(class, super, ...)
    local self = (super and super.new(...) or {})
    setmetatable(self, {__index = class})
    setmetatable(class, {__index = super})
    return self
end

--仕組み

--　クラス設計例
--[[

    Parent = {
        new = function()
            local obj = {}
            setmetatable(obj,{_index = Parent})
            return obj
        end

        parentFunc = function(self)
            // 処理
        end 
    }
    
    Class = {
        new = function()
            local obj = parent.new()

            setmetatable(obj, {__index=Class})
            return obj
        end

        func = function(self)
            // 処理
        end
    }

    obj.funcを呼び出した時，objの中にfuncは無いんだけど，setmetatableで__indexにparentを指定しているので
    そこからfuncを探してくる．

    classの__indexにmetatableにsuper(親)を設定しているのは，親クラスの関数を呼べるようにするため
    このおかげでoverrideが可能になる

]]
