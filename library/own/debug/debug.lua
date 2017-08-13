function draw_status(x,y)
        local stats = g.getStats()
        local str = string.format("draw: %.2f B", stats.drawcalls)
        local str2 = string.format("tm: %.2f MB", stats.texturememory/(1024*1024))
        local x ,y = x , y
        g.setColor(255,255,255)
        love.graphics.print('M: ' .. math.floor(collectgarbage('count')/1024*1000)/1000, x,y)
        love.graphics.print("FPS: "..tostring(math.floor(1/love.timer.getDelta())), x, y + 20)
        love.graphics.print(str, x , y + 40)
        love.graphics.print(str2,x , y + 70)
end
