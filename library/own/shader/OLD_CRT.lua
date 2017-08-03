OLD_CRT = love.graphics.newShader [[
    extern number Time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            //textureの色
            vec4 texturecolor = Texel(texture, texture_coords);

            vec3 c = Texel(texture, texture_coords).rgb;
            vec3 cc = vec3(0.0, 0.0, 0.0);

            c -= abs(sin(pixel_coords.y * 50.0 + Time * 5.0)) * 0.03;
            c -= abs(sin(pixel_coords.y * 50.0 - Time * 10.0)) * 0.07;

            cc += c * color.rgb;

            return vec4(cc,texturecolor.a) * vec4(1,1,1,color.a);
        }
]]
