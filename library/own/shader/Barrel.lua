--[[
--
--
--     barrelShader:send("mouse",{love.mouse.getX(),love.mouse.getY()})
       barrelShader:send("resolution",{width,height})
       barrelShader:send("Time",frame/60)
--
--
-- ]]

barrelShader = love.graphics.newShader [[
        extern float Time;
        extern vec2 mouse;
        extern vec2 resolution;

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
            {
                //正規化
                vec2 p = pixel_coords/resolution;
                //時間
                float t = Time;
                //マウス位置正規化
                vec2 m_pos = (mouse/vec2(resolution.x,resolution.y));

                ///バレルのように変形
                p *= vec2(pow(length(p-m_pos), -0.1));

                //テクスチャの色
                vec4 pix = Texel(texture, p);


                return color * pix * vec4(vec3(abs(1.0)),1.0);
            }

    ]]