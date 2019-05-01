   --[[
   --
   --
   --     WEshader:send("mouse",{love.mouse.getX(),love.mouse.getY()})
          WEshader:send("resolution",{width,height})
          WEshader:send("Time",frame/60)
   --
   --
   -- ]]

    WEshader = love.graphics.newShader [[
        extern float Time;
        extern vec2 mouse;
        extern vec2 resolution;

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
            {
                vec2 p = pixel_coords/resolution - 0.5;
                vec2 m_pos = (mouse/vec2(800,600) - 0.5);

                //テクスチャの色
                vec4 pix = Texel(texture, texture_coords);

                float l = 0.0;

                //mouse
                l += 0.01/length(p - m_pos);

                //wave
                l -= sin(-sin(p.y + 0.01*sin(p.x * 10.0 + Time * 10.0 ) + 0.01 * sin(p.y * 1.0 - Time * 10.0)));

                return pix + vec4(vec3(abs(0.001/l)),1.0);
            }

    ]]