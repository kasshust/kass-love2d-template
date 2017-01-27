---　画像を読み込む
function load_image(_filename)
    Image = love.graphics.newImage(_filename)
    min, mag = Image:getFilter()
    Image:setFilter('nearest','nearest')
    return Image
end
--- 分割したquadを返す
function split_image(_split_x,_split_y,_image_x,_image_y,_gs,_ygs)
    local _gs = _gs
    local _ygs = _ygs or _gs
    quadList = {}
    for y= 0 ,_split_y-1 do
        for x = 0,_split_x-1 do
            table.insert(quadList,love.graphics.newQuad(x*_gs,y*_ygs,_gs,_ygs,_image_x,_image_y))
        end
    end

    return quadList
end