--[[
--
--
--     Sh_GameBoyShader:send("mouse",{love.mouse.getX(),love.mouse.getY()})
       Sh_GameBoyShader:send("resolution",{width,height})
       Sh_GameBoyShader:send("Time",frame/60)
--
--
-- ]]

Sh_GameBoyShader = love.graphics.newShader [[
        extern float Time;
        extern vec2 mouse;

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
            {

                //中心座標
                vec2 p = pixel_coords/vec2(800,600) - 0.5;

                //texture の　uvを手に入れる
                vec2 uv = texture_coords;
                //時間
                float t = Time;
                //マウス位置正規化
                vec2 m_pos = (mouse/vec2(800,600) - 0.5);

                //テクスチャの色
                vec4 pix = Texel(texture, uv);
                vec3 texture_color = pix.rgb;

                float gamma = 0.5;
                texture_color.r = pow(texture_color.r, gamma);
                texture_color.g = pow(texture_color.g, gamma);
                texture_color.b = pow(texture_color.b, gamma);


                ///液体、マウス部分
                texture_color -= 0.5 * 2 * sin(-sin(p.y + 0.01*sin(p.x * 10.0 + Time * 10.0 ) + 0.01 * sin(p.y * 1.0 - Time * 10.0)));
                texture_color += 0.01 / length( p-  m_pos);

                 vec3 col1 = vec3(0.612, 0.725, 0.086);
                 vec3 col2 = vec3(0.549, 0.667, 0.078);
                 vec3 col3 = vec3(0.188, 0.392, 0.188);
                 vec3 col4 = vec3(0.063, 0.247, 0.063);

                 float dist1 = length(texture_color - col1);
                 float dist2 = length(texture_color - col2);
                 float dist3 = length(texture_color - col3);
                 float dist4 = length(texture_color - col4);


                  ///色の濃さと一番近い色を選ぶ
                  float d = min(dist1, dist2);
                  d = min(d, dist3);
                  d = min(d, dist4);

                  if (d == dist1) {
                    texture_color = col1;
                  }
                  else if (d == dist2) {
                    texture_color = col2;
                  }
                  else if (d == dist3) {
                    texture_color = col3;
                  }
                  else {
                    texture_color = col4;
                  }


                return vec4(texture_color.rgb,1.0).rgba;
            }

    ]]