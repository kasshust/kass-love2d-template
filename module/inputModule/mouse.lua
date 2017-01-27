love.mouse.Pressed = { }
love.mouse.Released = { }

function love.mouse.wasPressed(button)
    if (love.mouse.Pressed[button] ) then
        return true
    else
        return false
    end
end

function love.mouse.wasReleased(button)
    if (love.mouse.Released[button] ) then
        return true
    else
        return false
    end
end

function love.mousepressed( x, y, button, istouch )
    love.mouse.Pressed[button] = true
end

function love.mousereleased( x, y, button, istouch )
    love.mouse.Released[button] = true
end

function love.mouse.updateKeys()
    love.mouse.Pressed = { }
    love.mouse.Released = { }
end