--[[
--
--
--     //Sh_ClampColor:send("mouse",{love.mouse.getX(),love.mouse.getY()})
       Sh_ClampColor:send("resolution",{width,height})
       Sh_ClampColor:send("Time",frame/60)
--
--
-- ]]



Sh_ClampColor = love.graphics.newShader [[
        extern float Time;
        extern vec2 resolution;

        float random (in vec2 st) {
            return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
        }

        float noise (in vec2 st) {
            vec2 i = floor(st);
            vec2 f = fract(st);

            // Four corners in 2D of a tile
            float a = random(i);
            float b = random(i + vec2(1.0, 0.0));
            float c = random(i + vec2(0.0, 1.0));
            float d = random(i + vec2(1.0, 1.0));

            // Smooth Interpolation

            // Cubic Hermine Curve.  Same as SmoothStep()
            // ウェーブレット関数
            vec2 u = f*f*(3.0-2.0*f);
            // u = smoothstep(0.,1.,f);

            // Mix 4 coorners percentages
            return mix(a, b, u.x) + // 左上から右上の頂点への補間
                    (c - a)* u.y * (1.0 - u.x) + // 左上から左下への補間
                    (d - b) * u.x * u.y; // 右上から右下への補間
        }

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
            {

                
                //中心座標
                /*
                vec2 p = pixel_coords/resolution - 0.5;

                //texture の　uvを手に入れる
                vec2 uv = texture_coords;
                
                //時間
                float t = Time;
                //マウス位置正規化
                //vec2 m_pos = (mouse/resolution - 0.5);

                //テクスチャの色colorセットのまぜもの
                vec4 pix = Texel(texture, uv) * color;
                vec3 texture_color = pix.rgb  ;

                float gamma = 2.2;
                texture_color.r = pow(texture_color.r, gamma);
                texture_color.g = pow(texture_color.g, gamma);
                texture_color.b = pow(texture_color.b, gamma);


                ///液体、マウス部分
                //texture_color -= 0.5 * 2 * sin(-sin(p.y + 0.01*sin(p.x * 10.0 + Time * 10.0 ) + 0.01 * sin(p.y * 1.0 - Time * 10.0)));
                //texture_color += -length( p )*0.4;
                */
                
                /*

                 vec3 col1 = vec3(0.078, 0.047, 0.109); // BLACK
                 vec3 col2 = vec3(0.266, 0.141, 0.203); // PURPLE
                 vec3 col3 = vec3(0.188, 0.203, 0.427); // NAVY
                 vec3 col4 = vec3(0.305, 0.290, 0.305); // DARKGRAY
                 vec3 col5 = vec3(0.521, 0.298, 0.188); // DARKORANGE
                 vec3 col6 = vec3(0.203, 0.396, 0.298); // GREEN
                 vec3 col7 = vec3(0.815, 0.274, 0.282); // RED
                 vec3 col8 = vec3(0.459, 0.443, 0.380); // GRAY
                 vec3 col9 = vec3(0.349, 0.490, 0.807); // BLUE
                 vec3 col10 = vec3(0.824, 0.490, 0.173); // ORANGE
                 vec3 col11 = vec3(0.521, 0.584, 0.631); // SKYBLUE
                 vec3 col12 = vec3(0.427, 0.667, 0.173); // TEAL
                 vec3 col13 = vec3(0.824, 0.667, 0.600); // PINK
                 vec3 col14 = vec3(0.427, 0.760, 0.792); // CYAN
                 vec3 col15 = vec3(0.855, 0.831, 0.369); // YELLOW
                 vec3 col16 = vec3(0.870, 0.9300, 0.839); // WHITE

                 float dist1 = length(texture_color - col1);
                 float dist2 = length(texture_color - col2);
                 float dist3 = length(texture_color - col3);
                 float dist4 = length(texture_color - col4);
                 float dist5 = length(texture_color - col5);
                 float dist6 = length(texture_color - col6);
                 float dist7 = length(texture_color - col7);
                 float dist8 = length(texture_color - col8);
                 float dist9 = length(texture_color - col9);
                 float dist10 = length(texture_color - col10);
                 float dist11 = length(texture_color - col11);
                 float dist12 = length(texture_color - col12);
                 float dist13 = length(texture_color - col13);
                 float dist14 = length(texture_color - col14);
                 float dist15 = length(texture_color - col15);
                 float dist16 = length(texture_color - col16);


                ///色の濃さと一番近い色を選ぶ
                float d = min(dist1, dist2);
                d = min(d, dist3);
                d = min(d, dist4);
                d = min(d, dist5);
                d = min(d, dist6);
                d = min(d, dist7);
                d = min(d, dist8);
                d = min(d, dist9);
                d = min(d, dist10);
                d = min(d, dist11);
                d = min(d, dist12);
                d = min(d, dist13);
                d = min(d, dist14);
                d = min(d, dist15);
                d = min(d, dist16);

                if (d == dist1) {
                    texture_color = col1;
                }
                else if (d == dist2) {
                    texture_color = col2;
                }
                else if (d == dist3) {
                    texture_color = col3;
                }
                else if (d == dist4) {
                    texture_color = col4;
                }
                else if (d == dist5) {
                    texture_color = col5;
                }
                else if (d == dist6) {
                    texture_color = col6;
                }
                else if (d == dist7) {
                    texture_color = col7;
                }
                else if (d == dist8) {
                    texture_color = col8;
                }
                else if (d == dist9) {
                    texture_color = col9;
                }
                else if (d == dist10) {
                    texture_color = col10;
                }
                else if (d == dist11) {
                    texture_color = col11;
                }
                else if (d == dist12) {
                    texture_color = col12;
                }
                else if (d == dist13) {
                    texture_color = col13;
                }
                else if (d == dist14) {
                    texture_color = col14;
                }
                else if (d == dist15)  {
                    texture_color = col15;
                }
                else if (d == dist16) {
                    texture_color = col16;
                }
                */

                /*
                vec3 col1 = vec3(63/255, 63/255, 116/255); // BLUE
                vec3 col2 = vec3(238/255, 195/255, 154/255); // 肌
                vec3 col3 = vec3(0.824, 0.490, 0.173); // ORANGE
                vec3 col4 = vec3(0.203, 0.396, 0.298); // GREEN
                vec3 col5 = vec3(238/255, 195/255, 154/255); // LightGREEN

                float dist1 = length(texture_color - col1);
                float dist2 = length(texture_color - col2);
                float dist3 = length(texture_color - col3);
                float dist4 = length(texture_color - col4);
                float dist5 = length(texture_color - col5);

                float d = min(dist1, dist2);
                d = min(d, dist3);
                d = min(d, dist4);
                d = min(d, dist5);

                if (d == dist1) {
                    texture_color = col1;
                }
                else if (d == dist2) {
                    texture_color = col2;
                }
                else if (d == dist3) {
                    texture_color = col3;
                }
                else if (d == dist4) {
                    texture_color = col4;
                }
                else if (d == dist5) {
                    texture_color = col5;
                }


                return vec4(texture_color.rgb, pix.a).rgba;
                */

                
                //正規化
                vec2 p = pixel_coords/resolution - 0.5;
                float ma = max(resolution.x,resolution.y);
                float mi = min(resolution.x,resolution.y); 

                
                //時間
                float t = Time;
                //マウス位置正規化
                // vec2 m_pos = (mouse/vec2(resolution.x,resolution.y));

                vec2 uv = texture_coords;
                //uv.x = uv.x * mi/ma;

                float n = noise(uv*100.0);

                //テクスチャの色
                vec2 vect   = uv-vec2(0.5,0.5);
                vec2 len    = abs(vect);

                // 歪曲
                vec2 distortion = vect*length(vect)*0.3;

                //vec4 pix = Texel(texture, uv + distortion + 0.1*len*len*random(uv));
                vec4 pix = Texel(texture, uv + distortion);
                float l = 0.1 / length(p);

                return vec4(pix.r,pix.g,pix.b,1.0 )* color;
            
            }

    ]]