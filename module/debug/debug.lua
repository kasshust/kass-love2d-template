function draw_status(x,y)
        local stats = g.getStats()
        local str = string.format("draw call  used: %.2f B", stats.drawcalls)
        local x ,y = x , y
        g.setColor(255,255,255)
        love.graphics.print('Memory actually used (in kB): ' .. collectgarbage('count'), x,y)
        love.graphics.print("Current FPS: "..tostring(math.floor(1/love.timer.getDelta())), x, y + 20)
        love.graphics.print(str, x , y + 40)
        love.graphics.print("window_size: " .. "W : " .. W  .. " H : " .. H , x , y + 60)
end
