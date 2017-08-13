--aseprite色定数
ASE = {}
ASE.BLACK     = {0,0,0,255} -- 黒
ASE.LAMPBLACK = {34,32,52,255} -- 濃い黒
ASE.TAUPE     = {69,40,60,255} -- 黒
ASE.BROWN     = {102,57,49,255} -- 茶色
ASE.MAROON    = {143,86,59,255} -- 赤茶色
ASE.ORANGE    = {223,113,38,255} -- オレンジ
ASE.SALMON    = {217,160,102,255} -- オレンジピンク
ASE.PINK      = {238,195,154,255} -- 肌色
ASE.YELLOW    = {251,242,54,255} -- 黄色
ASE.LIME      = {153,229,80,255} -- 黄緑
ASE.LIMEGREEN = {106,190,48,255} -- 濃い黄緑
ASE.GREEN     = {55,148,110,255} -- 緑
ASE.DARKGREEN = {75,105,47,255} -- 暗い緑
ASE.DARKBROWN = {82,75,36,255} -- 暗い茶色
ASE.DARKNAVY  = {50,60,57,255} -- 暗い紺色
ASE.NAVY      = {63,63,116,255} -- 濃い紺色
ASE.TEAL      = {48,96,130,255} -- 青緑
ASE.BLUE      = {91,110,225,255} -- 青
ASE.SKYBLUE   = {99,155,255,255} -- 薄い青色
ASE.CYAN      = {95,205,228,255} -- 水色
ASE.LIGHTCYAN = {203,219,252,255} -- 薄い水色
ASE.WHITE     = {255,255,255,255} -- 白
ASE.FRENCHGRAY= {155,173,183,255} -- 青みがかった灰色
ASE.DARKGRAY  = {132,126,135,255} -- 明るい灰色
ASE.GRAY      = {105,106,106,255} -- 灰色
ASE.CHARCOAL  = {89,86,82,255} -- 石炭色
ASE.PURPLE    = {118,66,138,255} -- 紫
ASE.CRIMSON   = {172,50,50,255} -- 濃い赤
ASE.RED       = {217,87,99,255} -- 赤
ASE.MAGENTA   = {215,123,186,255} -- 明るい赤紫色
ASE.DRAKKHAKI = {143,151,74,255} -- 暗い黄土色
ASE.OLIVE     = {138,111,48,255} -- 暗い黄色


function love.graphics.rectangle_c(mode,x,y,width,height)
    love.graphics.rectangle(mode,x-width/2,y-height/2,width,height)
end
function love.graphics.rectangle_d(mode,x,y,width,height,deg)
    love.graphics.polygon(mode, x + width*math.cos(deg + math.pi/4), y - height*math.sin(deg+ math.pi/4), x + width*math.cos(deg+ math.pi*3/4), y - height*math.sin(deg+ math.pi*3/4), x + width*math.cos(deg+ math.pi*5/4), y - height*math.sin(deg+ math.pi*5/4), x + width*math.cos(deg+ math.pi*7/4), y - height*math.sin(deg+ math.pi*7/4))
end

--始点が左上
function love.graphics.quarter(_mode,_x,_y,_width,_height,_depth,_z)
    local x,y,z,width,height,depth
    x = _x
    y = _y
    z = _z or 0

    local angle = math.pi/6

    depth = _depth
    height = _height
    width = _width

    local c_r, c_g, c_b, c_a = love.graphics.getColor()

    local a = {x,y - z}
    local b = {x + width * math.cos(angle), y - width * math.sin(angle) - z}
    local c = {x + width * math.cos(angle) + height * math.cos(angle),y- width * math.sin(angle) + height * math.sin(angle) - z}
    local d = {x + height * math.cos(angle),y + height * math.sin(angle) - z}

    g.setColor(c_r*4/4,c_g*4/4,c_b*4/4,c_a)
    love.graphics.polygon(_mode,a[1],a[2],b[1],b[2],c[1],c[2],d[1],d[2])
    g.setColor(c_r*1.5/4,c_g*2/4,c_b*1.0/4,c_a)
    love.graphics.polygon(_mode,a[1],a[2],d[1],d[2],d[1],d[2] + depth,a[1],a[2] + depth)
    g.setColor(c_r*1.0/4,c_g*1.5/4,c_b*1.75/4,c_a)
    love.graphics.polygon(_mode,c[1],c[2],d[1],d[2],d[1],d[2] + depth,c[1],c[2] + depth)

    g.setColor(c_r,c_g,c_b,c_a)

end
--始点位置がクォータービュー的
function love.graphics.w_quarter(_mode,_x,_y,_width,_height,_depth,_z)
    local angle = math.pi/6
    love.graphics.quarter(_mode,_x - _width * math.cos(angle),_y + _width *  math.sin(angle),_width,_height,_depth,_z)
end
--クォーターワールド限定
function love.graphics.wq_quarter(_mode,_x,_y,i,j,width_per,height_per,_width,_height,_depth,_z)
    local angle = math.pi/6
    love.graphics.w_quarter(_mode,_x - i*width_per*math.cos(angle) + j*height_per*math.cos(angle),_y + (i-1)*width_per*math.sin(angle) + (j-1)*height_per*math.sin(angle),_width,_height,_depth,_z)
end

function love.graphics.print_c(text,x,y,r,sx,sy,ox,oy,kx,ky)
    local font = love.graphics.getFont()
    local width =font:getWidth(text)
    local height =font:getHeight(text)
    local sx = sx or 1
    local sy = sy or 1
    love.graphics.print(text,x-width/2*sx,y-height/2*sy,r,sx,sy,ox,oy,kx,ky)
end

---指定範囲をカットしてdraw
function love.graphics.cut(_x,_y,_w,_h,f)
  local x,y,w,h = love.graphics.getScissor()
    --maid64により不要
    love.graphics.intersectScissor(_x,_y,_w, _h)
    f()
  love.graphics.setScissor(x,y,w,h)
end
