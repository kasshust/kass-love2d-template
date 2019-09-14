--[[
--
--
--     //Sh_ClampColor:send("mouse",{love.mouse.getX(),love.mouse.getY()})
       Sh_ClampColor:send("resolution",{width,height})
       Sh_ClampColor:send("Time",frame/60)
--
--
-- ]]



Sh_Blend = love.graphics.newShader [[
        extern Image image;
        extern float angle;

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
            {
                // Pivot
                vec2 pivot = vec2(0.5, 0.5);
                // Rotation Matrix
                float cosAngle = cos(-angle);
                float sinAngle = sin(-angle);
                mat2 rot = mat2(cosAngle, -sinAngle, sinAngle, cosAngle);

                // Rotation consedering pivot
                vec2 uv = texture_coords - pivot;
                vec2 nuv = rot * uv;
                nuv += pivot;

                vec4 pix = Texel(texture, texture_coords) * color;
                vec4 pix2 = Texel(image, nuv) * color;

                if(pix2.a != 0 && pix.a != 0){
                    pix = pix2;

                }
                

                return pix;
            
            }

    ]]