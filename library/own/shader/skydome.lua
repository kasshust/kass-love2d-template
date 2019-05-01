sh_skydome = love.graphics.newShader[[
    extern number scr_dist;
    extern number r;
    extern number scale;
    extern number start_x;
    extern number start_y;
 
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
      float sx = (screen_coords.x - (love_ScreenSize.x / 2)) / love_ScreenSize.x;
      float sy = (screen_coords.y - (love_ScreenSize.y / 2)) / love_ScreenSize.x;
      // float sx = texture_coords.x - 0.5;
      // float sy = texture_coords.y - 0.5;
      float ang_v = atan(sy, scr_dist);
      float ang_u = atan(sx, scr_dist);
      float pz = r * cos(ang_v);
      float qz = pz * cos(ang_u);
      float u = sx * qz / scr_dist;
      float v = sy * qz / scr_dist;
      texture_coords.x = mod((u + start_x) * scale + 0.5, 1.0);
      texture_coords.y = mod((v + start_y) * scale + 0.5, 1.0);
      vec4 texcolor = Texel(texture, texture_coords);
      return texcolor * color;
    }
  ]]