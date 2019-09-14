-- 1次パーリンノイズ

-- numに0.1,0.2,0.3...遷移する数字を与える

function perlinNoise(num)
    local i = math.floor(num)
    local f =  ( num - i )*2 -1 

    -- 切片
    math.randomseed(i)
    local a = math.random(0,100)/100
    
    -- ウェーブレット関数
    local f_2 = f*f
    local wave = 1-3.0*f_2+2.0*f_2*math.abs(f)

    return a*f*wave
end 

-- 引数はVector 未完成
function perlinNoise2(vec2)
    local function mix(x,y,a)
        return x(1-a)+y*a
    end

    i = Vector.new(math.floor(vec2.x),math.floor(vec2.y));
    f = (vec2 - i)*2 - 1;

    -- 切片
    math.randomseed(i)
    local a = math.random(0,100)/100
    math.randomseed(i)
    local b = math.random(0,100)/100

    u = f*f*(3.0-2.0*f);

    return mix(a, b, u.x) + 
            (c - a)* u.y * (1.0 - u.x) + 
            (d - b) * u.x * u.y; 
end 