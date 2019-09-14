Sh_Noise = love.graphics.newShader [[
    extern vec2  CameraPos;
    extern float Time;

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
                              
                vec2 uv = texture_coords;

                vec2 a = CameraPos;
                float b = Time;
                
                vec4 pix = Texel(texture, uv);
                float colorIntensity = floor(length(pix.rgb)*2)/2;
                vec2 vector = (pixel_coords - CameraPos) * -0.000030;
                float height = (colorIntensity);

                vec4 col = Texel(texture,uv + height*vector);

                vec4 finalcol = Texel(texture,uv);

                return col * color;
            }

    ]]